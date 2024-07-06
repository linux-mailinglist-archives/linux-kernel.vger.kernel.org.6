Return-Path: <linux-kernel+bounces-243339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7109294D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15081C212B0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F413BC26;
	Sat,  6 Jul 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FhkiUXjD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDE29414
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720285982; cv=none; b=Hl+xtsrg1nT7e3mXHUpqeZX3U7PEHGfDDRZZLrggi11QmTBoVDIBsAwAkaykfhZOSNMym7i4pbw+UX0K+5w0C3hICICy7f+gd4LiYl1PgTDhgsLhSnIIHBtET75XO+OWnrL5fOnDr41q7dS6Fj7LwdCSY6xJ08k8oi4R/zssTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720285982; c=relaxed/simple;
	bh=FdzhW8jckQ9Gfs/TGcGvimbU0+jBM8TysWBJmSELGmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6Ah2pAII8z/4XXH20uIOrPDUCZdJkIPdkVc2ctSvSalkHBVK4NjgBUfa+Af5QEUcHAv+0737NpbvSY/GTsaayxfhefAO4GkAbE3eXxZvXdAo2Hr0PrVdqqD0+B34WMufxH/f2vcHdy5eb5PiskEyujWEMYcrMyYk47ith/kzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FhkiUXjD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e98087e32so2920773e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720285979; x=1720890779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIHDkPjH3WVeZvlg0BnUYWSb8SNl5wUtj3icTP0TxI0=;
        b=FhkiUXjDQZC7b9B2WQSjZNl42nJ+1beh8umM7xDUslWrF+DH+h5ld+vIYGtK7xfzPP
         gRMfLYFtaHpQh0owRY95RaPGC4rFF9tmz2U1l8qDCwcMhQvcIpAWh0bHB7XX9T01gLTi
         FD37E6c3//8mW3c+3ajl4rjxEeGierdk/KZOKY0mlITnTXRwcc+3S6yML6Ff+BX2CXbh
         WTFrPe5RcKHInUZuyjEA4qbAUHQa4tJ2lzsLqtbVsYQM7ZlSjp/0wQCqAJN9hc/H7BHx
         9J259wZSNE4eKjJY+fj2SrvYPR4WUy5QIMHjOb5v1wLY1EE173y/kp2dcsRhltCBx2pL
         eLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720285979; x=1720890779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIHDkPjH3WVeZvlg0BnUYWSb8SNl5wUtj3icTP0TxI0=;
        b=EW/7iMl0qIBCHwFBRvR2UI35qHrz0cY3b7W2+MtpO75+3uwfVSirvr2q1Z0m1etyJx
         r4XqkodvIsuTWXfKcd+I+YP/HVoWJKltbj9NNKfzY78qIw2ijYOz4xKdS3dp5c3T3A9N
         CWcCX1BfTubQRPKS4HiWVYdkR676oTCnkZBMQ0D50jDNDBttSR3CvYGuZTkOzQtYs+OK
         rMPz/SdE2HjHk7brgkha1IzuczAIpDccHYTpOvhnhuULHiTuij7L99a0adPgr3/Yeggv
         mweqCrtW+cYOShwFF4URyGXh5+0kASm6E/qaWQKxAqdAt+fqrj379QuosHL/Yz3DMEQr
         HGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMzBgv5isO1QTzVxYs2Yo7/FOX3d5oMA5FAe5I7AtLY03BXAfCTbHCRLnaunu14igxK+VxZGvQ5FA+KfOCDYYHEMsFn7mW7L+tLNkr
X-Gm-Message-State: AOJu0Yy1H62BeNVXBeSvekdMXdcEiGxE4Z/LTu01jLU8+k4IbjlUi0QD
	DUwISMSth+FYh3PszID1YQakqFeYu9vDVC7zJL0QmkU0uayz0FauRVWaP+VzNQ3SZDSMoFEyekm
	QB5tGGBTVAJVWUsWWWEvgpjv8v4mfoeR4D9ymPg==
X-Google-Smtp-Source: AGHT+IHr8D+f+x90g+9LqHGNVFw5Ew01Hdekxrn8HMMGKFPoL76ifPylZFsoFm8kiPgvrQKiKpfSbCcCqu0cm2Km+Cc=
X-Received: by 2002:ac2:5dcc:0:b0:52e:9c26:5c0c with SMTP id
 2adb3069b0e04-52ea0639ae9mr5147645e87.37.1720285979207; Sat, 06 Jul 2024
 10:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703091535.3531-1-spasswolf@web.de> <CAMRc=Md=PnpHVGGO6Nb_efVZ0a3cMxWbLvYmkka5Wznks70drw@mail.gmail.com>
 <ZokDkyfn2Xt2Ki-i@wunner.de>
In-Reply-To: <ZokDkyfn2Xt2Ki-i@wunner.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 6 Jul 2024 19:12:48 +0200
Message-ID: <CAMRc=McBpqP=qSbxDGcreTcktq_0vQH_PrtQS0V=Mw3w-_Zmwg@mail.gmail.com>
Subject: Re: [PATCH] pci: bus: only call of_platform_populate() if CONFIG_OF
 is defined
To: Lukas Wunner <lukas@wunner.de>
Cc: Bert Karwatzki <spasswolf@web.de>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	caleb.connolly@linaro.org, bhelgaas@google.com, amit.pundir@linaro.org, 
	neil.armstrong@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 10:43=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Wed, Jul 03, 2024 at 11:32:05AM +0200, Bartosz Golaszewski wrote:
> > On Wed, Jul 3, 2024 at 11:15 AM Bert Karwatzki <spasswolf@web.de> wrote=
:
> > > If of_platform_populate() is called when CONFIG_OF is not defined thi=
s
> > > leads to spurious error messages of the following type:
> > >  pci 0000:00:01.1: failed to populate child OF nodes (-19)
> > >  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> > >
> > > Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child O=
F nodes of the port node")
> > > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > > ---
> > >  drivers/pci/bus.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > index e4735428814d..b363010664cd 100644
> > > --- a/drivers/pci/bus.c
> > > +++ b/drivers/pci/bus.c
> > > @@ -350,6 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >
> > >         pci_dev_assign_added(dev, true);
> > >
> > > +#ifdef CONFIG_OF
> > >         if (pci_is_bridge(dev)) {
>
> Per section 21 of Documentation/process/coding-style.rst,
> IS_ENABLED() is strongly preferred to #ifdef.
>
>
> > There's a better (less ifdeffery) fix on the list that I'll pick up
> > later today[1].
> >
> > [1] https://lore.kernel.org/lkml/20240702180839.71491-1-superm1@kernel.=
org/T/
>
> That other fix doesn't feel very robust as it depends on
> of_platform_populate() never returning -ENODEV in the
> CONFIG_OF=3Dy case.
>

If we even have to play these ifdef games then the stubs for
of_platform_populate() are broken and should probably return 0 with
!OF as otherwise the stubs themselves are useless.

Bart

