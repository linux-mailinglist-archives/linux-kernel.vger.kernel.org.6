Return-Path: <linux-kernel+bounces-449432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1A9F4EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6ED1883CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DA1F7074;
	Tue, 17 Dec 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="slaz++ay"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76799148850
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448159; cv=none; b=lclSGDSu+nz8yTZPsTPJoxia2B/UqbVkMdbhm6fZQiE9tlr2lZRTjd96oaVd6N9k5oa7a7/DG/RtcF8FuLvKQDu/T82tn3COMfrKewwiELWr5ZeIZiBsAXzRTKuCj4ryO03KcWpWb4AUW520JpcmFJOvgTdtIVR+If+vu7Qq8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448159; c=relaxed/simple;
	bh=t8Vs683urZA2aCYmnDvsgfI9tVP0SgQmznGh5Uf5YEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u37D5qUWGrKzrq/d6n4IoqNK/u0jLeCS4PGWeYp4+QB6uQTdWx5D2qm/Wr8LRkZLmyBkIP6YqGe/rS7dCuP6wLNb6ASChJnIU9BT7jc06m8qMil9LbZlDAO39yJTvEvskaniNN2MSrYsc1RbUdmhhAXNB6XQAz7tc6HeUDR92/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=slaz++ay; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3035210e2d1so20040671fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734448155; x=1735052955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJMaV7UmSOqQnJmmYNC2YNSOGH/6QVrTZ9CiZALJymE=;
        b=slaz++ayrsGcyEiTL4WDQ/UWJcxdZTl3koP06SBN5QQraatDdb9TxYRXhb0oPSYOiE
         8+3WkAdxdX0EARKx9UC4Q5h9HQLNB9fIZMIOD1RFPNhT6RSXOVbWonYPSsaa4Np6YgDh
         t19bYLOSZ5wGJhKB0TCQ4NfOqv1BGCp5Z/S9fu9ss+ieXFK3wRXZ4CcEnTAALCCwzJ/p
         rUUFSouV4IEW/QJIdep/dbbsIQ9dzcuxxSSwmPbA5NYAezi3SI2GOm+Dl15/x60jexYt
         v9KLZwdIvEqbwoHWfpm4LEZ74LGcP8pkto2kkmLvsAahUPBh6xotJgkiOIJ7Fps69xt6
         rCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734448155; x=1735052955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJMaV7UmSOqQnJmmYNC2YNSOGH/6QVrTZ9CiZALJymE=;
        b=gP3xuPnAB7py3sM5Mt3Fk73Di59eOOajfLfVcST3Lyv7b+AId6Usr/kqbg7XFdK7oU
         pXGJQGKUEPvo/Jmp5HDlmqtEUauPjcB2Wa+3Mu2uZ+qWUM2k6b7Ib2Cvhb6PuiZ/XZKd
         E0QFohpfMHvLjOA0w4VW/D4sV8qgLdbCWtSma3NYSoG/NxOjvP4lPzQ9Ac0gEfCTgSH6
         GzW/XIQ1EZiPFcbi+Q5ZO1/22Smhx6o2WTkYbq118xIikAmtkVZiMz9+s7KN27OqIat3
         W8al3oPFAd39+57U+/O8ecmWhSM4cjTGYal5fiv1BrZM7JCgv/kNfkmPCxUN/X6CJEhQ
         8nbA==
X-Forwarded-Encrypted: i=1; AJvYcCWFYcj8vvK0a3hYnPB0Z1bJvFrqXXL1BRzhIgofqT1rPOWUUTFNcQ7Qv0h5c0xtwaKEyN3Js+hyaeBM94o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiH3SNXqP4+N7kBckswtWxwLaClm9/7vp2gAE9ZlvMBnd+4Ja0
	K0sErsAzryhJXQWWZZ46ZBUrCBQcpgnFYYnAXYJLIkeqzLhQBS+bu/FSPDKppkj7SICWLKPZPPl
	Di5cgsYywnDJZFAfx6MoE4nwH/n7LmvFrsKmkOg==
X-Gm-Gg: ASbGncuBera8olg/E8ib4nZcL95sT81QXsH3tIgtn0aIQqoxI9vtIpiwYQ0RENzSb+E
	rszZ5c2bb7jxwnGraKd0ASieLWzkT8AZuaYlrWB3XmTK3aLZiiokz+4zOqVkTrCVHMAItfw==
X-Google-Smtp-Source: AGHT+IHn2z+8xFDM1ych7/SJHm2I1uCOb9OrGIC/DxV/OB5hK1sRyL/vbFsj0eFSDsONM3UlyR1ROcXDvtoGtKLL2Z8=
X-Received: by 2002:a2e:bc12:0:b0:300:1f12:bbc9 with SMTP id
 38308e7fff4ca-302544cbdb2mr63979171fa.34.1734448155392; Tue, 17 Dec 2024
 07:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217130714.51406-1-brgl@bgdev.pl> <20241217140325.qgm6m7qf2fdj35j2@thinkpad>
In-Reply-To: <20241217140325.qgm6m7qf2fdj35j2@thinkpad>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 17 Dec 2024 16:09:04 +0100
Message-ID: <CAMRc=Mf7bcfD3+vu9veWrd44hqiHZZnSgiiaObeMUfajLRqPmQ@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: explain why we need the
 WLAN_EN GPIO hack
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:03=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Dec 17, 2024 at 02:07:14PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > With the recent rework of the PCI power control code, the workaround fo=
r
> > the wlan-enable GPIO - where we don't set a default (low) state in the
> > power sequencing driver, but instead request the pin as-is - should no
> > longer be needed but some platforms still fail to probe the WLAN
> > controller. This is caused by the Qcom PCIe controller and needs a
> > workaround in the controller driver so add a FIXME to eventually remove
> > the hack from this driver once this is done.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/power/sequencing/pwrseq-qcom-wcn.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power=
/sequencing/pwrseq-qcom-wcn.c
> > index cc03b5aaa8f2..9d6a68ac719f 100644
> > --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > @@ -396,6 +396,14 @@ static int pwrseq_qcom_wcn_probe(struct platform_d=
evice *pdev)
> >               return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
> >                                    "Failed to get the Bluetooth enable =
GPIO\n");
> >
> > +     /*
> > +      * FIXME: This should actually be GPIOD_OUT_LOW. The driver model=
 can
> > +      * correctly handle provider <-> consumer dependencies but there =
is a
> > +      * known issue with Qcom PCIe controllers where, if the device is
> > +      * powered off abrubtly (without controller driver noticing), the=
 PCIe
> > +      * link moves to link down state. Until the link-down handling is
> > +      * addressed in the controller driver, we need to keep this worka=
round.
>
> Maybe we should add some info on how GPIOD_OUT_LOW causes link down. Like=
,
>

Sure.

>         /*
>          * FIXME: This should actually be GPIOD_OUT_LOW. But doing so wou=
ld
>          * cause the WLAN power to be toggled, resulting in PCIe link dow=
n.
>          * Since the PCIe controller driver is not handling link down cur=
rently,
>          * the device becomes unusable. So we need to keep this workaroun=
d until
>          * the link down handling is implemented in the controller driver=
.
>          */
>
> But the comment applies to gpiod_direction_output() call as well, right?
>

Yes, but there is already a comment above it.

Bartosz

