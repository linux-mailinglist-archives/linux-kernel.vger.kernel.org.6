Return-Path: <linux-kernel+bounces-176274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65738C2C9E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E728C1C21719
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076C13D25A;
	Fri, 10 May 2024 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WEYG0ggp"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9613D249
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380104; cv=none; b=lxguYLje3nd/L1V4zEUqzwspVSGwAPBYEzZ0v7px0GfZ5XV7SRGW7d5ub2DTQ34J3fZP2DSaGI+xvRv6x8z7ImALfVSA5uPQEnhiK5k+zHaNvR6GANtvcbYKM5Tg96Z2LlFzh0ZbXgUCwqFtv7/1ed+wgyYvubs4nTAek/nUWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380104; c=relaxed/simple;
	bh=QUvkzr2l/uiy5GlxGfNfCrbyjBH0No4JLdD4lgoUp/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU0zK0tWVfqNr8oL1YsGrkD8Q4TNtGrMWWxM4hZ+uTp3NVBOvmaB8E7zlofjTRsmBV2d/iSnz243Rm+d8Uya/1sL5LzWauhivx3OsrPCzPgMLLkSyOhh1hmN06ewA5gVrzvCOB+VkWDFkzmES8sksdU17gqVcfpEgzqGM2iaTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WEYG0ggp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-792bae4137bso223965285a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715380100; x=1715984900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVisxd1xtcmhvxdpqTGyNvzYQwpGM+4jeLB5LKdcrvQ=;
        b=WEYG0ggpgGb6MHdfspMq5cKeBS6Eon4lvoXeCY023umEJuxB3nwg5onwmt30OpbDtO
         lAM4xa4cKlneXNlB9XD/sbRyjh770raec8aNMIbhz8ctiLKj6H7Vg5vjCAm7cYrXpK4a
         oRofxmOxVnL9tt8f4rqCExcyYBDtTcRH+auc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715380100; x=1715984900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVisxd1xtcmhvxdpqTGyNvzYQwpGM+4jeLB5LKdcrvQ=;
        b=TuKziV+3mNtLAfZ76p+4lxekmK3LTevMk13Hh55wtBCwxFREfAGcjWlM9nf3UXsPUO
         SDq4F4LMow5jsGs8hfVSoACL/ByGRY32YbWVRjaV12LHSbrbuaC/ARDslyblC+cjrAuF
         dPD5TYgEhWYFUnYmekyke9ZzHDtN+uVXIMiYvKMVQKme63YFFd4rzDNlasiHPArrDm2q
         mEvZSyWcOAGErAvS8CgdIpNrEQCZgGtXuAR/llVOMd4Hqskvwt5fY79zEF1yW2Qtv5UZ
         y0HP1kTLyXiTNa2Rc9svaMnnoXPjxkCjf6BnuyWyyAMkizD8cfwFpihtHYrOCQ7Vm0rQ
         JYCw==
X-Forwarded-Encrypted: i=1; AJvYcCXrqJKp6kmtGNOVzPbr53YtAKTApeKvuldu90gOtE8uqN5mUEgwNgKjIjcqOwnmlpERCKOVyzWs9Ot+PdSlnydsPQvAZb9my33v43s6
X-Gm-Message-State: AOJu0Yx9k53N+zWRm4YCOmpOGg3aVrF9yGzoVsGPi76cbmcSNDnYJKF5
	DVkfOy2UFlX3JJgsVpfNou2ZZsFxx7Y7X9OrYcD/YADXIlyLC7a3OyAx08DtFibIHXF3XfysKf0
	=
X-Google-Smtp-Source: AGHT+IGU7j9lSGWZmyyn0qDAVrEWHa9nw4aNupTkilc8h9HkOreVJ9bZLJXlb7xzldtrz8ReryPrvw==
X-Received: by 2002:a05:620a:390e:b0:792:bcb1:7308 with SMTP id af79cd13be357-792c7598bdbmr503306385a.20.1715380100456;
        Fri, 10 May 2024 15:28:20 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf32e705sm220108685a.124.2024.05.10.15.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 15:28:19 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43dfa9a98d2so23241cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:28:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJ8jMC44aTa9GSAuFcnjpE+bMj2383UMl8s/FenohvB6At6iFu1nPtlOWsOVsJviISQjCxpMje5VTzFO3UTS9s4ft/Dhmv0XZLklc5
X-Received: by 2002:a05:622a:1c15:b0:43a:f42f:f0b4 with SMTP id
 d75a77b69052e-43e0a22b948mr305931cf.13.1715380098995; Fri, 10 May 2024
 15:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
 <20240510-dsi-panels-upd-api-v1-6-317c78a0dcc8@linaro.org>
 <CAD=FV=Uu2=6c_3Q44BK384cgSLX=++_bBbg6=CCqBaXnqcEK=g@mail.gmail.com> <hf7u3rxard7yg2z3fkmntemhnnmwnsgmhmfhpt74modswg7nj4@7kwyba55x6o7>
In-Reply-To: <hf7u3rxard7yg2z3fkmntemhnnmwnsgmhmfhpt74modswg7nj4@7kwyba55x6o7>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 15:28:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ukk2JGV5jP_WUVFKfOsK2z=FUbUDDG5pnOumw0S-9CjQ@mail.gmail.com>
Message-ID: <CAD=FV=Ukk2JGV5jP_WUVFKfOsK2z=FUbUDDG5pnOumw0S-9CjQ@mail.gmail.com>
Subject: Re: [PATCH RFC 6/7] drm/panel: lg-sw43408: add missing error handling
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, 
	cong yang <yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 10, 2024 at 3:25=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, May 10, 2024 at 02:47:05PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, May 9, 2024 at 3:37=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > Add missing error handling for the mipi_dsi_ functions that actually
> > > return error code instead of silently ignoring it.
> > >
> > > Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/gpu/drm/panel/panel-lg-sw43408.c | 33 ++++++++++++++++++++++=
++++------
> > >  1 file changed, 27 insertions(+), 6 deletions(-)
> >
> > Looks right to me. Only slight nit would be that I'd put this as the
> > first patch in the series to make it obvious to anyone backporting it
> > to older kernels that it doesn't have any dependencies on the earlier
> > patches in the series. It's fairly obvious so this isn't a huge deal,
> > but still could be nice.
>
> Yes. I wanted to emphasise the _multi stuff rather than this fix. I'll
> reorder patches for v2. Maybe I should also rebase the series on top of
> patches by Cong Yang. WDYT?

Sounds good. I think Cong is planning on a V6 to fix the last nit I
had on his patch series [1] but otherwise this plan sounds fine to me.

[1] https://lore.kernel.org/r/CAHwB_NKtw0AyMgFb4rMFNgr4WF10o9_0pYvbKpnDM45a=
Yma9zg@mail.gmail.com

-Doug

