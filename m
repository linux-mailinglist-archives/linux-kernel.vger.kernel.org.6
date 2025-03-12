Return-Path: <linux-kernel+bounces-558050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021AFA5E0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B1417C06D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30D252907;
	Wed, 12 Mar 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NTavR2yE"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C4288BA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794505; cv=none; b=g/CzSC5hF6XsGnDZrf5cqXiw+jTr2C2EwKeSrFQY2itJkrkZUE5qH94z2v7jH1Y1ymSAggcM67cGH7FnBraJZWMLO46szTa0786LHlh/UZj43+nFYO2T2Hi3i8uhFDAbbSV5d9JYwNgdPX6JqpY8kN96fhPs2DGn6zfKVdzrwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794505; c=relaxed/simple;
	bh=uCPOdA185BvWq5ZjhYWej2duz8xzBQXEQZTw4vCw+HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=He9Cn0YwcQv3/G5VEjbyby8yl7T64xfJOEowdSm57rWGYZu61cMGNaPDRsMZgcgRip44GtrxXXpcaQGCILELqNGvh1qrnUYwbVc4IwgJILhu4le2zlISazkSf/FyYHHqLzGUq6wUw3Fjl3ItUDfzhk0gaTbBcxurH3zuq0lunMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NTavR2yE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499659e669so6042416e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741794497; x=1742399297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdZ/KsjENSBssp+v/dxb+PBQzOCtXKmGBKQGm6xeShA=;
        b=NTavR2yE7yAGZhxlLIsJJD4Un3rw3JgyR/Z8YmQS//oP2pS/7lHNKaQxugJ6cE9snX
         W5OlPeNVKEzyI4ir6wXKYkOoi6kaRKdvVt3oX0+lgiemAHI4aqxJgtb3Ol8VugJdWfYX
         WYiYN2Zd0NM7R8YBLXQYbHyWhkdwOabo+ymZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794497; x=1742399297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdZ/KsjENSBssp+v/dxb+PBQzOCtXKmGBKQGm6xeShA=;
        b=SW1wEmx/iV69+Y+VTKIflwSTnJROX5qJM8p1K4SYaczMygzwSJQhUX8sansvSaDRm0
         oy9mdtr30WGctlwAU7KWRhckmq3Y5rd34jbo61kpz8nvhFDhxzHZ9ZVYwlqBzPs7A/qN
         RO/ySsoL6pFmiD46T8TWpPGpyFOdA4RLJdgNlZKjDI9vrLcx+bUUMmW+nTlsCGwGjMrU
         0voAGuqx1+8MrYxTDoTvo68ezzzDRkvv4DJrqMFwVdeaGnXLnExshIfaeyMmez8lown9
         Obd6r3GDyYhBqeGdPTE1EvXDHCyN2d+zqRyQBaSx+4Ehe7Is1Ry3dsXJAfydb8F+Mfow
         k09Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/Gl3qF8OMkfYlVbiK5s/HUuq92UpeeZCkcuHZNKzZCdznqSpif11b5wNcyxLut7X7Yvt6s7ZfFnHpUEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFNjtD9X7FGT7m8eP8sfhxz+fz5uM8LIyY364DmPIf4ARg/eI
	GyRJhWR0JmZHcVr9fow146yoHRt3U8PDOmEle/B0jnUwAKzP6+mUR4k8MVNZspOl8d5CrQ/NbEy
	A1OEV
X-Gm-Gg: ASbGncvXS8dqJCfnYUOfl67TUH4lYfBPRa8v6QLQw8Sy33CoqwzuhY3U0g2rPCinGpQ
	HQ9TM907n9N871iyGf9sUgarsL96IFY9dKpcYAtgrd6sMomk44I9tX9D5hsjd3haMWyceObO6Fd
	6Bj6klZMzgiU18bh/HK6aBWFNU6QEWR8ioF9SgKNDnMYjddKZEHmqI/HXCTGm6LNXKTcoGGxj8T
	jpcU5L+/hyhGExnSZ6n5AMe+E5moU0KOD7Zut7iWZaJpFjbG7Bkj/SxEynxd/FiCBmO8iHBQYDi
	qwIrtfmzEQrSu391ueGoEYRrTOddnJknTnrXDi19FRYLaEfCQqOlRCZbLFVlI7wIO9WNz6VfS7g
	RUt4TTQoR
X-Google-Smtp-Source: AGHT+IEFC3jlzIZd82yyazj4cpZ7CQCHTGIowCJABhhYcW6bQMNDSE/Jm6LPkVdFu+ydjch0zu3yug==
X-Received: by 2002:a05:6512:b24:b0:549:9143:4ce1 with SMTP id 2adb3069b0e04-549abaa8c5bmr3472623e87.3.1741794496591;
        Wed, 12 Mar 2025 08:48:16 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4626csm2145368e87.48.2025.03.12.08.48.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 08:48:15 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499659e669so6042195e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:48:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvW0gHPPMpj04G36EXyt/07KWJjlsxCrE2EA5sC62SdzJuo32+7+T/EMiJROe/4Ws+X/v/iBsdMqcTevI=@vger.kernel.org
X-Received: by 2002:a05:6512:3b25:b0:549:7394:2ce5 with SMTP id
 2adb3069b0e04-549abae9732mr3014845e87.41.1741794492068; Wed, 12 Mar 2025
 08:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-mipi-synaptic-1-v2-1-20ee4397c670@redhat.com>
 <20250311-warm-icy-rottweiler-cefcdd@houat> <CAN9Xe3Qwu=E=VVZZ_8EHPF7Xsk6Zcbp=R_b=cRgF=9SWCkmsqA@mail.gmail.com>
In-Reply-To: <CAN9Xe3Qwu=E=VVZZ_8EHPF7Xsk6Zcbp=R_b=cRgF=9SWCkmsqA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Mar 2025 08:47:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XdngrNhUn8jQ3FGitkBCkiQO1dXnPhCKj+S5Jo8_WUrQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqKOeCFnqz9t-GQAqcT1m-g7AXhkRBMViQRSMxzjFeOfKb4IuUc4Kxm3n4
Message-ID: <CAD=FV=XdngrNhUn8jQ3FGitkBCkiQO1dXnPhCKj+S5Jo8_WUrQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel/synaptics-r63353: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 12, 2025 at 8:06=E2=80=AFAM Anusha Srivatsa <asrivats@redhat.co=
m> wrote:
>
>> > @@ -106,53 +107,46 @@ static int r63353_panel_power_off(struct r63353_=
panel *rpanel)
>> >  static int r63353_panel_activate(struct r63353_panel *rpanel)
>> >  {
>> >       struct mipi_dsi_device *dsi =3D rpanel->dsi;
>> > -     struct device *dev =3D &dsi->dev;
>> > -     int i, ret;
>> > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>> > +     int i;
>> >
>> > -     ret =3D mipi_dsi_dcs_soft_reset(dsi);
>> > -     if (ret < 0) {
>> > -             dev_err(dev, "Failed to do Software Reset (%d)\n", ret);
>> > +     mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
>> > +     if (dsi_ctx.accum_err)
>> >               goto fail;
>> > -     }
>>
>> This changes was definitely not what the script is doing.
>
>
> It isnt. Using coccinelle for the major part of pattern matching and repl=
acing the newer _multi variant API. Some handling (including a newline that=
 it introduces) and  the returns depend on a case by case basis, which had =
to be done manually.

...and now you're getting to see why I didn't think a coccinelle
script could fully handle this task. ;-) IMO instead of trying to get
a coccinelle script to do the full conversion, the right approach
would be to use a coccinelle script (or equivalent) to get the basics
done (just so you don't make any typos) and then cleanup the result
manually. Spending more time on the coccinelle script than it would
take to do the conversion manually is probably not the right approach.

If your patch wasn't fully generated by a coccinelle script you should
document that in the commit message. Something like "Initial patch was
generated by a coccinelle script and the result was cleaned up
manually." If the script is too long to fit in the commit message,
it's fine to put it somewhere online and provide a link. "Somewhere
online" could easily be a mailing list post.

-Doug

