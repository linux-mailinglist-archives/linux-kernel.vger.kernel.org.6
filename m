Return-Path: <linux-kernel+bounces-560387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8334A60367
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A453AC451
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8421F4CA2;
	Thu, 13 Mar 2025 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPAyuHcT"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68592126C1E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741901170; cv=none; b=uen77ZCH/Pn9M172u3c3E+RkMZCwvOdfW9tgvdsdTWhF1uNGagStbqkmOwIfes3/ZO7c47Glgg/+1UtL7PmJTwnezArF+ywVwVCc3rr+rCA/LpT9v6Kep21S9DcnaBgoGMe/PtJpBFxmhdChy+/5zkWPuHbXmPWV9jW9eoqMXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741901170; c=relaxed/simple;
	bh=UfXACb8VfYItqeVlsi0BGbqMyOFIDyF57IXGiKf6dfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ7MTfmF4E4bEE9P+DoNfli7ij2ZQfmDsHpVQdFwzzO9KLbggfp7qAdQS0BKOk4BPIeRpa6yVFuuWMt3bzJcdKMT5aHcw7EFgeCPLtTngQf0aw9UWEalGRh6PyyQZEN8WpHYSbWVeiiwa3XYt1YEfYVSr8SlDpLcppT+rcCCnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPAyuHcT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54993c68ba0so1611249e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741901166; x=1742505966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEvSm/qV/gA4924ww+yiikc6EOcgXf2+Ryx6VfqPSVs=;
        b=DPAyuHcThzY62v6CJT6aaJ+huGprvPxXkR/ZArExmMykVNg+JuOMayLor2+vOPG/Kq
         MtGyyyqh77u2bkTLUF2VfWhEOAA41o+i/r6hRlO1hTrMMY4Mp1SuP2CDBmbcbvIktLDs
         dF5dBHI4SEKRHUGN/qTgMIdbwECQEbV9cquWd2xij9y7k9pY/IyaMlgS6VbcxNktMDHk
         AUZu5A6Rj53LxTnYeq6IgPpauvvl9vHvhfUHjNU6Xg9uzZBC/Exu0gcv91uu9hXPJfsW
         ovj199aneCD4e9MxNShTfWgxt3cRyRYX9G3oqD4YvEc/+oqO7JG3m3hJzDaKQaQwpU2F
         0Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741901166; x=1742505966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEvSm/qV/gA4924ww+yiikc6EOcgXf2+Ryx6VfqPSVs=;
        b=vaDLneG+LypbcewcICTcc5peGErzrsgKfhyT/fpliRfFDTfawQ1CR4RoUpxklryjrV
         L0fT9pprZiqyMAa6zUj5emOzEiwM38RLirTjNZH6DbBW8mOUhwG+m9qwKEDzyaUSnkK7
         gpxylJhbsKUzcQNgJscVfJlWqm29CYlPEReqd9CRFr1U3tMiwp3EpxDrxXfPypbluTEn
         hp86TtU4OeO6nXNbDWss8fH6qX1Wm3CCPXHZTl1N2BmWEv0ZaPF/oFbK5McRJs1r1Bao
         gXmxVE4CbW2raiqvniTE+bN2sMtVoETLZ5z/0JH7cc4V5WM8dc+gmAOK9z4RWfl76ehU
         aweQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsnfAzocg9N5jFXfzn3hCuUZqgSJNdpRSwqOWHbGz6gubkeSkl+g74Zp4Ofm/jvfMYR427FP/9wHX3N0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBgaJYArWlbyuKG21i3zjW0u5eGz/m5bGY2QIaaSQTC3+5lsd
	fU+1jJaTEVHRfmtIWCapSHqv613deQERooyT2fjJgbwSPODbn7AjterkGiCO85Mvm1papXjt3SS
	a0KSgLe7jabmA4eb0SnSAv660hlT/nstgvoLg
X-Gm-Gg: ASbGncv8gMh5ewV6Za2ExOzQk8vK83+OZ10xXXHRxMA3WL3sA6Gk5jJrGKf09vw4xqG
	VKHthFp+NS4EcdpQpouRLXjdhryGgIUNjG3YcRI/9a1bw8BfG1SWJurQKHcvdt9V92tJLgAJIGz
	kxsBlT6Uhs1jxzuNcq1wkAYFzps+qEi+0Mw0seL/90enM/0pIKTulLjCgWrallo98=
X-Google-Smtp-Source: AGHT+IEUpl49m15csoisl4xdaOkvHB8pMtPnENRpafG0hTYq79/CSmqGTNA7Wf/Eyj58fOjm/pwvBRSNin5jsVrWKfM=
X-Received: by 2002:a05:6512:ac6:b0:545:225d:6463 with SMTP id
 2adb3069b0e04-549c3989a09mr7738e87.42.1741901166311; Thu, 13 Mar 2025
 14:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12627587.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12627587.O9o76ZdvQC@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Mar 2025 14:25:29 -0700
X-Gm-Features: AQ5f1Jqh94uLmKYTj2Ojq8OmsbxaVGGM4qAQ2zcuSBghRC-ys5SVAMfqNlmaOJs
Message-ID: <CAGETcx-sydVJcigqin-zO=ANc65kuz5F3X51a8-SnM0X2zKhMw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Fix handling devices with direct_complete
 set on errors
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 9:00=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> When dpm_suspend() fails, some devices with power.direct_complete set
> may not have been handled by device_suspend() yet, so runtime PM has
> not been disabled for them yet even though power.direct_complete is set.
>
> Since device_resume() expects that runtime PM has been disabled for all
> devices with power.direct_complete set, it will attempt to reenable
> runtime PM for the devices that have not been processed by device_suspend=
()
> which does not make sense.  Had those devices had runtime PM disabled
> before device_suspend() had run, device_resume() would have inadvertently
> enable runtime PM for them, but this is not expected to happen because
> it would require ->prepare() callbacks to return positive values for
> devices with runtime PM disabled, which would be invalid.
>
> In practice, this issue is most likely benign because pm_runtime_enable()
> will not allow the "disable depth" counter to underflow, but it causes a
> warning message to be printed for each affected device.
>
> To allow device_resume() to distinguish the "direct complete" devices
> that have been processed by device_suspend() from those which have not
> been handled by it, make device_suspend() set power.is_suspended for
> "direct complete" devices.
>
> Next, move the power.is_suspended check in device_resume() before the
> power.direct_complete check in it to make it skip the "direct complete"
> devices that have not been handled by device_suspend().
>
> This change is based on a preliminary patch from Saravana Kannan.
>
> Fixes: aae4518b3124 ("PM / sleep: Mechanism to avoid resuming runtime-sus=
pended devices unnecessarily")
> Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-2-saravanak=
@google.com/
> Reported-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Saravana Kannan <saravanak@google.com>

> ---
>  drivers/base/power/main.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -938,6 +938,9 @@
>         if (dev->power.syscore)
>                 goto Complete;
>
> +       if (!dev->power.is_suspended)
> +               goto Complete;
> +
>         if (dev->power.direct_complete) {
>                 /*
>                  * Allow new children to be added under the device after =
this
> @@ -963,9 +966,6 @@
>          */
>         dev->power.is_prepared =3D false;
>
> -       if (!dev->power.is_suspended)
> -               goto Unlock;
> -
>         if (dev->pm_domain) {
>                 info =3D "power domain ";
>                 callback =3D pm_op(&dev->pm_domain->ops, state);
> @@ -1005,7 +1005,6 @@
>         error =3D dpm_run_callback(callback, dev, state, info);
>         dev->power.is_suspended =3D false;
>
> - Unlock:
>         device_unlock(dev);
>         dpm_watchdog_clear(&wd);
>
> @@ -1669,6 +1668,7 @@
>                         pm_runtime_disable(dev);
>                         if (pm_runtime_status_suspended(dev)) {
>                                 pm_dev_dbg(dev, state, "direct-complete "=
);
> +                               dev->power.is_suspended =3D true;
>                                 goto Complete;
>                         }
>
>
>
>

