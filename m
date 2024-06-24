Return-Path: <linux-kernel+bounces-227833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8E91570B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978F5284D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AD19FA92;
	Mon, 24 Jun 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="Dz9tb5fr"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1619CCEF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719256708; cv=none; b=B/sBZe/xwUoycpuiHKaTY/R36tt0vbzf9MM28RsCWrvWcmyQQS2AFWJfOhel9bZ9kcncZ6ZLhRwMhvo0w4+gR8EAwBxPyULWeEBsMSpXa0FzgwaBqR+rJlyKzNsIaOXs8N+3Rs+btOnSjkLB9DPaJq2lvM7piLxprNWoftTe/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719256708; c=relaxed/simple;
	bh=1+8P9e4bjZNNeYr8EhkJJ8GlBLAx7rydpxmTmFAOTFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+1GzaQyXtpTBp0olJrN+CSmN95/lbTcP6zoYdGxqJtRIDZ65689Tfmgje1bAnAIghjcHL471k3OpAXXZy1x4Mwkk7jATOTPvn17MQXFxl64uiFxvht0CdEyZ3e3gun9gxxAmpQiv0yn+CxqwKrL57fP/RRStcHcll6KngtYMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=Dz9tb5fr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso5956320a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1719256704; x=1719861504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/utmK01Q/aAz/jmaJoKVno7ODPMTb9bqaLsPY3576Y=;
        b=Dz9tb5frwaL9QXBBkZt75It488ohDV/0Y1daKnhL5RsQrwmSwXtc3sECP8Yod8Q11F
         Lwl8/C2iLhQJx+Bjbsxp+xVsAbk1jjpkpaDLlqe7V0thV8O9bn6Dgm08Pcz76hKTiPkH
         pLtrS9Q+ylubMwkzx4CKJpPrEEtxoUCv9ztumZ0k2xlKBQ64W071WoN6YW56QbJ+uO6M
         +ag7eHjCT4l6zrj3PzNxpdES5oiPtlk06GC4gR2Q34cUkiP73wAoJ0QigPM7bO5cgSam
         pG4fNNwQrdQeyXndnSrhRq5DAQzZ2c+Bgj46FaM2ub4GILYH+kQS/8w5ZCszEJ0H0usn
         VBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719256704; x=1719861504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/utmK01Q/aAz/jmaJoKVno7ODPMTb9bqaLsPY3576Y=;
        b=RHG0c1J23SSKcCwstb7A9St3ogA2X+b0TppCOOlPWA+2vvEo7/KzZbA82P9dC31bwX
         bTbcZl3DIem/WffGnFk/JznPZt+EB7N4mfzt0eGXBg1PD1P2uRXdT5T+0OxXqgrRf1nk
         YcE0KuprlRDuByd0Oz7y9tj8li0FoQvIKvMn0T/8Vk+NdhN+KAZadFpp0eGRE/+rWgSh
         0mdZhrwV2PX92xYpflgp/Y/MQOk2EiUGfyiE3mYuf3LBATq5BsCZWMh14qgox4YOTc2F
         Pz8bRPmxNHO2nqHocSCuj9v/Y27zOsUPWbJhMXNaZlUWZpGC5q9oOULJ6P0Z0aY1Qkkw
         UNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtwy1xfD9V7hSOF+Gx0ZTkJn9n7ERzDVF31A8zgD0palynUBz16hgYgwtZMnWcW3ye0eVjp2g+NNsi+iz0J48PvJXNDIFnjAiNc5hQ
X-Gm-Message-State: AOJu0Yx9X0Zb6ZjKdOSDHjJluVJcIQAmZO0zygdAfK6o0vHQ7nAXBlHM
	p1NarQtrK6rGlrZ+9i7+Uv/Iep/ex37h0aXI8tDHRlaY75BDPi/jg6C1SZwb6b8Su/acEuUOxZN
	YgGnQDLNkvI0YqN4F9tYCthvqO4G9Ra46kIF+ZA==
X-Google-Smtp-Source: AGHT+IHotRG6K2HXCdC5lYRNF4KD1Z2OXWs9Jet+gNkN4MBEBoLu0f2q74erRpdjiiCthuRWlb1Tc3ezwYipTA/uF1s=
X-Received: by 2002:aa7:cb50:0:b0:57d:4b56:da11 with SMTP id
 4fb4d7f45d1cf-57d4b56da8emr5008376a12.11.1719256703918; Mon, 24 Jun 2024
 12:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12464461.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12464461.O9o76ZdvQC@rjwysocki.net>
From: Steev Klimaszewski <steev@kali.org>
Date: Mon, 24 Jun 2024 14:18:12 -0500
Message-ID: <CAKXuJqjAQERxkfTESUKSvPo3N5qOf+un6LbKys9YrBT_ocJG8A@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: gov_step_wise: Go straight to instance->lower
 when mitigation is over
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>, Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Sat, Jun 22, 2024 at 7:28=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit b6846826982b ("thermal: gov_step_wise: Restore passive polling
> management") attempted to fix a Step-Wise thermal governor issue
> introduced by commit 042a3d80f118 ("thermal: core: Move passive polling
> management to the core"), which caused the governor to leave cooling
> devices in high states, by partially revering that commit.
>
> However, this turns out to be insufficient on some systems due to
> interactions between the governor code restored by commit b6846826982b
> and the passive polling management in the thermal core.
>
> For this reason, revert commit b6846826982b and make the governor set
> the target cooling device state to the "lower" one as soon as the zone
> temperature falls below the threshold of the trip point corresponding
> to the given thermal instance, which means that thermal mitigation is
> not necessary any more.
>
> Before this change the "lower" cooling device state would be reached in
> steps through the passive polling mechanism which was questionable for
> three reasons: (1) cooling device were kept in high states when that was
> not necessary (and it could adversely impact performance), (2) it only
> worked for thermal zones with nonzero passive_delay_jiffies value, and
> (3) passive polling belongs to the core and should not be hijacked by
> governors for their internal purposes.
>
> Fixes: b6846826982b ("thermal: gov_step_wise: Restore passive polling man=
agement")
> Closes: https://lore.kernel.org/linux-pm/6759ce9f-281d-4fcd-bb4c-b784a1cc=
5f6e@oldschoolsolutions.biz
> Reported-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/gov_step_wise.c |   23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
>
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -55,7 +55,11 @@ static unsigned long get_target_state(st
>                 if (cur_state <=3D instance->lower)
>                         return THERMAL_NO_TARGET;
>
> -               return clamp(cur_state - 1, instance->lower, instance->up=
per);
> +               /*
> +                * If 'throttle' is false, no mitigation is necessary, so
> +                * request the lower state for this instance.
> +                */
> +               return instance->lower;
>         }
>
>         return instance->target;
> @@ -93,23 +97,6 @@ static void thermal_zone_trip_update(str
>                 if (instance->initialized && old_target =3D=3D instance->=
target)
>                         continue;
>
> -               if (trip->type =3D=3D THERMAL_TRIP_PASSIVE) {
> -                       /*
> -                        * If the target state for this thermal instance
> -                        * changes from THERMAL_NO_TARGET to something el=
se,
> -                        * ensure that the zone temperature will be updat=
ed
> -                        * (assuming enabled passive cooling) until it be=
comes
> -                        * THERMAL_NO_TARGET again, or the cooling device=
 may
> -                        * not be reset to its initial state.
> -                        */
> -                       if (old_target =3D=3D THERMAL_NO_TARGET &&
> -                           instance->target !=3D THERMAL_NO_TARGET)
> -                               tz->passive++;
> -                       else if (old_target !=3D THERMAL_NO_TARGET &&
> -                                instance->target =3D=3D THERMAL_NO_TARGE=
T)
> -                               tz->passive--;
> -               }
> -
>                 instance->initialized =3D true;
>
>                 mutex_lock(&instance->cdev->lock);
>
>
>
I've tested this here against 6.10.0-rc5 and it looks like it does
what it says on the tin now.  Locks to low speeds at thermal and
(rather quickly) unlocks once it's no longer in the "danger zone"

Tested-by: Steev Klimaszewski <steev@kali.org>

