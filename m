Return-Path: <linux-kernel+bounces-567922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2592EA68BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144847AD07A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D28255E53;
	Wed, 19 Mar 2025 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+qaj8ma"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0332625332F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384466; cv=none; b=KM0vUWspewx+OFrD76GCGTTnYLIKlT5SsB5pbX+ULy7t83EdFM0gL0tcSBDFMASRguTnYdajUa/3IQffy/hp6txDBpyhyP7COaZxz5M5rkhD+oUi5hjLspqSILXnrS06rPJIKldc8UVbejntqs/CODoWyD/pr91ccJO02PmVIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384466; c=relaxed/simple;
	bh=QN4TukBKcr7GCstePwybtb0ft9vY9vxyq4OwjIpkHrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVylRB25UptKFlZ1QJS6XK/PVzpWl6XTcZF/5HDa0bI1cmxAB933kE/n7CaJOh7VUi09braRPyL5R4aNLNDzMnKadID7ygx9iGonVGh6mm/mpXX+c7R9B0/9JKcPh6gTE1k0+40lrAmuoEJP92S6UnJM2e0YV39hsKi8rw0IlQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V+qaj8ma; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2aeada833so133038966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742384462; x=1742989262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8MTVrzHn47D07QaIZqTqMn4oOq2XC0e3Is4UWL2ono=;
        b=V+qaj8majjDdDl3HUtX0Pz5hHUyvEEPO8oFQIykMTLjWZZjnOPFUPfjB463wakD4D/
         ZQPxlCl6woS4hg9Jc3M3t15AKavoQGeSVVK/mhabWs9ZDbxOHUh+Oz17l6+goIeDuhVH
         T/9DzAUEjpst491JXCAgSwMHfKzmvafHiGf0HsnnfJH1R8u6/4+4hYB2yI1KmVPrzcIm
         qS6vM4Y4cbB6zXYYwHhcLUPpC7n95iMtTzb4CHGd2iPgnm5K9YTcX3QEaXE0XnhALRVx
         fYDtFjf5lwolfLipriEZ1Y0I0uMmRTPx3SZJ8E8oXZCDXFq3SdORI+hQtRCLt+XA/FT6
         GPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384462; x=1742989262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8MTVrzHn47D07QaIZqTqMn4oOq2XC0e3Is4UWL2ono=;
        b=IeFpm6Cuaz3ShF3kkzgJL8Zr1jiwMpb7ZiU4jcL7Ai3cFoJpujf8YD4+LqRTUm/3DK
         Ipuib/74vq4V7z9VDH363VMQt5AL7xHBRXq+piSNjOrCm2uya9vUD05mcDolIqaiVW9X
         lL/xWRKaf6RAY9a3xQqVAgBXc3/qD2Xpco1Dpu6AadZV70iYAFaoz850nqgUarbN+zHk
         diBfWBrWdDtXdewjpTK/09/hyVodPg0M6zUOcwOUBIwgxCv7dCV6s1cjab7JBcCQIGR9
         VgqGvfDoObF4eWgIWqYdHX/f+BkZNsxytoyYQFyzou+7wwgpkA4+ztSDfu8Eo50ny8iJ
         /0mw==
X-Forwarded-Encrypted: i=1; AJvYcCVRu+bUQCMFXRdFGyHLCd0APdTEaoiesHjeys2Nr2JAxN/++Vf0ZiFMPvDB4SZ9adRUXcKq7WrMnEQE+0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8pJ9YIaKZ+8JGAZ5MxbtSrps/UnhBUfKOEbo1yEXULPUe41Y
	QPbxRgy5xty4URYazN7AFdWJfnvdbRW+IAjYcXkH32zkCxopHSA/gvopJXIurolTJXHB2eHWV4n
	Pfz4FTW9WdZ5KnFGl3YOaYNoTf+iHxPSLuGdtGQ==
X-Gm-Gg: ASbGncuPW/dPKw5VBWGuAIJf7n7LzqoiBVyQhgIgKaWh+1NBcjUEsg/0CZEHfftswlB
	z6qIHQHcFInW2HLlMYhRolZsCf+6EjVQ0QYuRFFaAA+1mp3Q0VQ28SoK0Vdf6ftP3XHGUicMuLA
	8wAi/5JJK0XLSKAHfUE4oqVmronvo=
X-Google-Smtp-Source: AGHT+IG9mKS0iIWb3TO2ivefr79iMICflm2Da/NDX55DveFEcqxff+kn7i1aSb8ulYyq8ga428bcN003oK5dIc0IuVM=
X-Received: by 2002:a17:907:3f17:b0:abf:6bba:9626 with SMTP id
 a640c23a62f3a-ac38f7c6017mr680301066b.12.1742384462329; Wed, 19 Mar 2025
 04:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312121712.1168007-1-ulf.hansson@linaro.org>
 <CAOCHtYjGuw9szeChihrDZ39_2+w5xOverbp6mAjjLjR=QkK1zg@mail.gmail.com>
 <CAPDyKFqPdDjoECXeBqx0P+fpbgVN1g_jWM2fQiH8Mw6HGMSPNA@mail.gmail.com> <20250319035911.GB4957@atomide.com>
In-Reply-To: <20250319035911.GB4957@atomide.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Mar 2025 12:40:24 +0100
X-Gm-Features: AQ5f1JoOnwE3rFuTS8HijWcK8WnN5Pk8S5_GLHE89xJrW0hiLHYLTnkhrSGUYQg
Message-ID: <CAPDyKFpFcL=c2g72tHJUJbKYZqoxZ_puVy+hYMByGRFFN7n=ew@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: Disable MMC_CAP_AGGRESSIVE_PM for eMMC/SD
To: Tony Lindgren <tony@atomide.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, linux-mmc@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	David Owens <daowens01@gmail.com>, Romain Naour <romain.naour@smile.fr>, 
	Andrei Aldea <andrei@ti.com>, Judith Mendez <jm@ti.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2025 at 04:59, Tony Lindgren <tony@atomide.com> wrote:
>
> * Ulf Hansson <ulf.hansson@linaro.org> [250317 10:51]:
> > On Sun, 16 Mar 2025 at 21:54, Robert Nelson <robertcnelson@gmail.com> w=
rote:
> > >
> > > On Wed, Mar 12, 2025 at 7:17=E2=80=AFAM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > We have received reports about cards can become corrupt related to =
the
> > > > aggressive PM support. Let's make a partial revert of the change th=
at
> > > > enabled the feature.
> > > >
> > > > Reported-by: David Owens <daowens01@gmail.com>
> > > > Reported-by: Romain Naour <romain.naour@smile.fr>
> > > > Reported-by: Robert Nelson <robertcnelson@gmail.com>
> > > > Tested-by: Robert Nelson <robertcnelson@gmail.com>
> > > > Fixes: 3edf588e7fe0 ("mmc: sdhci-omap: Allow SDIO card power off an=
d enable aggressive PM")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/mmc/host/sdhci-omap.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci=
-omap.c
> > > > index 54d795205fb4..26a9a8b5682a 100644
> > > > --- a/drivers/mmc/host/sdhci-omap.c
> > > > +++ b/drivers/mmc/host/sdhci-omap.c
> > > > @@ -1339,8 +1339,8 @@ static int sdhci_omap_probe(struct platform_d=
evice *pdev)
> > > >         /* R1B responses is required to properly manage HW busy det=
ection. */
> > > >         mmc->caps |=3D MMC_CAP_NEED_RSP_BUSY;
> > > >
> > > > -       /* Allow card power off and runtime PM for eMMC/SD card dev=
ices */
> > > > -       mmc->caps |=3D MMC_CAP_POWER_OFF_CARD | MMC_CAP_AGGRESSIVE_=
PM;
> > > > +       /*  Enable SDIO card power off. */
> > > > +       mmc->caps |=3D MMC_CAP_POWER_OFF_CARD;
> > > >
> > > >         ret =3D sdhci_setup_host(host);
> > > >         if (ret)
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > Thanks Ulf, i also have this exact revert running on the target in ou=
r
> > > ci farm, i think we should be good.  But I'll validate it in 4 weeks!
> > >
> > > Regards,
> > >
> > > --
> > > Robert Nelson
> > > https://rcn-ee.com/
> >
> > Thanks Robert for helping out!
> >
> > In the meantime I decided to queue this up for next, to allow it to
> > get more testing in linux-next.
>
> Thanks looks good to me too.
>
> Regards,
>
> Tony

Thanks, I have added your Reviewed-by tag too.

Kind regards
Uffe

