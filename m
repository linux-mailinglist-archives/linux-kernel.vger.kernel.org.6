Return-Path: <linux-kernel+bounces-558036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24820A5E0C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E739F1882F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCD9252907;
	Wed, 12 Mar 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdqnrBRD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A1156C6F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794179; cv=none; b=PUAe4Hd+4amM8nGQlsPfSxpXGvaa1tdREiCjEe8kqrzzDtG3JqMxWSiZ1phQAj8S4/d2E6lEd4//JHYDWoi52UIflHEyJ85SjV2HMjEQVGlv5Y6X/HQwmCw4JWCNRWvnex+W2ZBPeG4JMUZ34Ssl9np2X53gJDCy1DykCbIw7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794179; c=relaxed/simple;
	bh=+ioIR9/OtnIM/ROKNhxo/w9cSOuoRECrzjeIXxMshMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqGlj1WKZi7Cm1Cc8cQGpMkx3k0MC6izxLzm6+myN1e+/xNaD44moFsv9lnA9tyVlx3PhTOfpDIspshDKJf9sR7+aZekdHc8z9kfh+77w4OkgN+L0OgEPSkBtqhqecsnpdWeRgXyPsrXJ3F3HELZr1KsSVvf9lBwDgwiEcJ2Y7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GdqnrBRD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549a4a4400aso3981719e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741794172; x=1742398972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw0KUaZ0b+JsqMU9c0Y3CKPGy3vo4F+iJFxyks2AXEc=;
        b=GdqnrBRDixGASSVP60bltrh9DINRVazDiFkemvU2IqEmrRrXoe6zOS4ZnLd8KA1TJ4
         qKJEMCunLYCiuoviTETJYBiG22m+0cSOa0xhM5FvKmo3K6CR3CaRzDCL/67FsXjBemsy
         C3NKzKVrLcfz+E9LEEO5uxYdMQFouAU5LQbuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794172; x=1742398972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vw0KUaZ0b+JsqMU9c0Y3CKPGy3vo4F+iJFxyks2AXEc=;
        b=nrpJ92TMNHOLqjEpcaiDidFpcoxHDWoEDH0ziOZu/CTy7MUKoWkz1WJ6C6CvCHp+Yx
         l27TV+DlKGUhyC6iZbOIGMyTzaiX6WhBVr9j00aTLRQVQWuv5x2vB6cIxR6DSHul7D8c
         B1yBxSWxcVGwmXA8JsFJKqzrjSRcrpP/cD/RF072myJWz/09bORc3EX07vTQ4x75UK9k
         yH/ky7/Rdm1wDyvGmGlA0VuQG5uUG3ZQsmd64UOWFPLoWsYgwepWK4ookoiBRxCzgldr
         0DvUJqp8ao7QQSR6h0smpiFp+MsAxXdhWQ8qrx8esXy3cLleQA/2cawudc1Fh7Emykgr
         QvPw==
X-Forwarded-Encrypted: i=1; AJvYcCVXl4HSR0pMxrwS7igXakP+TBZtz/N0kcSsEUwMsGo28OV+3G93KED1/0QOZutKg6ZP8V7PYTAI+FNZtCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFq1siSw60W+9U9CGlfeVaa+e+pXkoI97nWcQN4o/wJfzSQfED
	3HvpwhcwkH4BkxiRS8sATRYehzlOlXsRuvct9MSXYG3CKFVh07HAs/7XolDp60i5JZ33vdNmJ9Z
	SI53f
X-Gm-Gg: ASbGncsXWSx+Poo5PqYqOR7ZcXUPIy3w9JOlM+SjUAjwF65Ng9zk94dDvTx8fzDJbTi
	s7kygFICHnAQo7Elb8vIB44WasqLL1jCWEBdWSGizV0GtBmmo6v1+BAW//WvSfMMQwzM4KsSMHj
	U+cAhcXuCX0yRIQya6sV9eGP8SL5LUBxoX9DkXDnkeZk0jDgSMTP78DmuPpq3+gqgJkep2dzIkH
	VTLWM0/07g/JHtHKG8zyVpDb0a2nfNP2tRwX5pbmdeXXYCMuHCLcXS+magTmveOomNyi5qCWxMb
	saUz7IVTiUxLRDeEZkferXq+LsLDXquTQhPdCsbzK5SwaHAhzE+6oZvDEU+c7hyzCnTQvwROCxd
	WeiSz8ol6SCTT
X-Google-Smtp-Source: AGHT+IFYMmkk1eY/JyoRrkGhnsNFBqwZ2p+G02gvkThgGgnTS8s/J7UwMyM1RmQrvr3AuI+G6V+tmA==
X-Received: by 2002:a05:6512:b1d:b0:545:60b:f382 with SMTP id 2adb3069b0e04-549abac01fdmr3276223e87.17.1741794172401;
        Wed, 12 Mar 2025 08:42:52 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2bf1sm2163784e87.224.2025.03.12.08.42.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 08:42:51 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30613802a04so74983491fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:42:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdA10TyJU+486gHGhnaGK0E7XfHs87RWXUOcdt/LTOfMr0i1QilQbcfivzgMo6t7PmAdUNQoNPtCS6uMM=@vger.kernel.org
X-Received: by 2002:a05:6512:3d19:b0:549:4d78:2418 with SMTP id
 2adb3069b0e04-549abacd211mr2905563e87.27.1741794168636; Wed, 12 Mar 2025
 08:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-mipi-synaptic-1-v2-1-20ee4397c670@redhat.com>
 <CAD=FV=WW1ak-_MEBVks==Yr1tUdfFZ3K16_gcdJQ9rwE4ZduNg@mail.gmail.com> <CAN9Xe3RYgnELGymau=EoZQy54sM-WfnR-6dr-wmNaBr4ZLnROg@mail.gmail.com>
In-Reply-To: <CAN9Xe3RYgnELGymau=EoZQy54sM-WfnR-6dr-wmNaBr4ZLnROg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Mar 2025 08:42:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XubjtTV70MMPBm2EwoLzoQPHKv6RzHXJgf44mu-h2o=w@mail.gmail.com>
X-Gm-Features: AQ5f1JqXMzAvNqm-GDk-AEL8mokEJ4SfWD3DkXGx_CXDjIlY6tZpWWWd-O4t1JM
Message-ID: <CAD=FV=XubjtTV70MMPBm2EwoLzoQPHKv6RzHXJgf44mu-h2o=w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel/synaptics-r63353: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 12, 2025 at 7:54=E2=80=AFAM Anusha Srivatsa <asrivats@redhat.co=
m> wrote:
>
>> > @@ -78,7 +79,7 @@ static int r63353_panel_power_on(struct r63353_panel=
 *rpanel)
>> >                 return ret;
>> >         }
>> >
>> > -       usleep_range(15000, 25000);
>> > +       mipi_dsi_usleep_range(&dsi_ctx, 15000, 25000);
>>
>> No. None of the conversions in this function are correct.
>> mipi_dsi_usleep_range() is only for use when you're in the middle of a
>> bunch of other "multi" calls and want the sleep to be conditional upon
>> there being no error. Here there is no chance of an error because no
>> _multi() are used. Go back to the normal usleep_range().
>>
>
> OK. Then the approach to prefer mipi_dsi_usleep_range() over the previous=
ly used usleep_range() everywhere is out the window. Sounds good. Is replac=
ing msleep() with mipi_dsi_msleep() preferable?

Same rules there. If you're in the middle of a sequence of "multi"
commands and only want the sleep if there is no error then use
mipi_dsi_msleep(). If you're not then use a regular msleep().


-Doug

