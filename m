Return-Path: <linux-kernel+bounces-325893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081C3975F83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DC51F284B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40726AC1;
	Thu, 12 Sep 2024 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FONhYAPW"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB8A47
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110060; cv=none; b=aNFe6J3ljRoky3spBnjSdc1CnLKIBnb/gLrUHQtScwh6YMdYkiGLgqqzApey14uaHXXpmmfknuMEWHP9zdPZLBU9wiH5H6BqWZFJ5zWWGLQD5f2mynX9vhKUwSWBlVK5A9t87wetQcdzbGdWGavMwPG4SG4x0BJwKpwTuKuM4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110060; c=relaxed/simple;
	bh=Vg0odeBMHpgtKhX8NR4LCSnyU5789G2srGCsELN6ZwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLv6TVCAn+CGNKM6HmTnfbZugd70XV3gSiAY1+R6pO4AOrOUlmBDSUHTPTvtO8of0m+yTYa8xEOdJBr63P3Yrvrl15uwuM5DG+LfUqKip5Rhv9Ip4nKaiCFxD8VFknzdG0SoQqGOlt2uBlHItPHrZYooeh3ly8i8cICv/PhFvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FONhYAPW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CBDB03F32F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726110056;
	bh=nxAKAHN4ulQFF60B5qp2xJnEkFmB45s9ou21KSZ6DT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=FONhYAPW4UeESlOgTmQ4IwRqyhSgjyFGyExsc6ySQrG6YFg4uBIQMdq/SGHonrGzD
	 /n8AoNOfW4erPH1btfOJo5EJ8klwRvD9kkF3U3iwSUC6Ibndvd3dXj5zqw/HMt9Z/B
	 VCwpkdes1wbKLAIrK1Y6Sl1KnXJWtvSOz2RzMQaTF8HF98/Yc8NEsVJzxlyWeZvN6u
	 KL6Khjl05isGydrwuSfrPt6Ej5dU0KCo9sTg8b9sL3tIgJSrlUl6QRBoRHEKy/4j2V
	 IkeQRLhowWK0UriEICz8gd5BD09lQv3n3yTEjY1ij52e82LACJMVsRbBGhrXq88hiL
	 hpNGbq/9uGChQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c2465b7fc1so296489a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726110056; x=1726714856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxAKAHN4ulQFF60B5qp2xJnEkFmB45s9ou21KSZ6DT8=;
        b=VaxXaJS7Mo952cklaaxWEOeX7SaOsH3hWUtgkLaU8qX3RoVIgL/spIuN+kWN5QDD95
         PdL/mKhyXk14SczOgZHq1OPZZGtapoc1Jekta3kKNH/6KLTiyw1tlyxRQnPShZ5DwceG
         uc6Xq87r6n3qhZVUmEhfO+wbXihNKXKEXaBd24R95gc0XW5/SAeeGP/s5WpQOjqV7aw0
         cqF8DotoYn7g+ETuGWj65920QhXrWsywc9OXshr9I96aWQssl6wX5/Jmbawnlya9XMni
         LkKm2tM8UWJHxuo49SAy9a0cIFcSjDDL3AW6+sNhtl+AaJhWeJvuNk6nmZFpkFEMzPTC
         pb1w==
X-Forwarded-Encrypted: i=1; AJvYcCV74HRpBrH/9EZjkueUALd+LtTxt6SoHK2Ktjuofc8OLeDJme9/+BPofVMYw2VdairxUqz1agcqDs+luzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhuRP/SeAKv2NvemFfhUNjgjmLwfdyJFcnQhmabPf851LpFVj+
	TCHsJZFMdsDNmI83WVQfY3uXy6SZrk5Q3o6x3aGpLxiy8PaDYhJLYRafBa1cxEbADqDBuJ0G9gT
	oXnaC2W32CHY/VSU1myVYhVNQUXaK5GJzp8pDxIW6HoiG7tuudHLVPvD2WmIL6zXf5ELqvKJLsT
	jXe6VbD7qB574zuMxdiXX22QrUs08zRPBEwtIhXDNvhvc9kw5wjAaQ1303knNRe18=
X-Received: by 2002:a05:6402:2551:b0:5c4:1372:c1ee with SMTP id 4fb4d7f45d1cf-5c413e085eamr1054652a12.4.1726110056257;
        Wed, 11 Sep 2024 20:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHObdhdH1kylUh+cnsfLE2FnMRLgHzmKi6VYXrNEML58hz+m9YTNmCXyQHMYbrGa2cNfNJrXGeH/I45eJ+lA6g=
X-Received: by 2002:a05:6402:2551:b0:5c4:1372:c1ee with SMTP id
 4fb4d7f45d1cf-5c413e085eamr1054640a12.4.1726110055775; Wed, 11 Sep 2024
 20:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712062411.35732-1-kai.heng.feng@canonical.com> <20240911190516.GA644336@bhelgaas>
In-Reply-To: <20240911190516.GA644336@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 12 Sep 2024 11:00:43 +0800
Message-ID: <CAAd53p7vP8TcPj=u5TTuPMXFaWW15hwpJdECCprvXGBhigKD6Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mario.limonciello@amd.com, 
	mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Thu, Sep 12, 2024 at 3:05=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> > Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> > connected.
> >
> > The following error message can be found during shutdown:
> > pcieport 0000:00:1d.0: AER: Correctable error message received from 000=
0:09:04.0
> > pcieport 0000:09:04.0: PCIe Bus Error: severity=3DCorrectable, type=3DD=
ata Link Layer, (Receiver ID)
> > pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=3D0000008=
0/00002000
> > pcieport 0000:09:04.0:    [ 7] BadDLLP
> >
> > Calling aer_remove() during shutdown can quiesce the error message,
> > however the spurious wakeup still happens.
> >
> > The issue won't happen if the device is in D3 before system shutdown, s=
o
> > putting device to low power state before shutdown to solve the issue.
> >
> > I don't have a sniffer so this is purely guesswork, however I believe
> > putting device to low power state it's the right thing to do.
>
> My objection here is that we don't have an explanation of why this
> should matter or a pointer to any spec language about this situation,
> so it feels a little bit random.

I have the same feeling too. The PCIe spec doesn't specify what's the
correct power state for shutdown.
So we can only "logically" think the software should put devices to
low power state during shutdown.

>
> I suppose the problem wouldn't happen if AER interrupts were disabled?
> We already do disable them in aer_suspend(), but maybe that's not used
> in the shutdown path?

That was my first thought, so I modified pcie_port_shutdown_service()
to disable AER interrupt.
That approach didn't work though.

>
> My understanding is that .shutdown() should turn off device interrupts
> and stop DMA.  So maybe we need an aer_shutdown() that disables
> interrupts?

Logically we should do that. However that approach doesn't solve this issue=
.

>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219036
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pci-driver.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index af2996d0d17f..4c6f66f3eb54 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev=
)
> >       if (drv && drv->shutdown)
> >               drv->shutdown(pci_dev);
> >
> > +     /*
> > +      * If driver already changed device's power state, it can mean th=
e
> > +      * wakeup setting is in place, or a workaround is used. Hence kee=
p it
> > +      * as is.
> > +      */
> > +     if (!kexec_in_progress && pci_dev->current_state =3D=3D PCI_D0)
> > +             pci_prepare_to_sleep(pci_dev);
> > +
> >       /*
> >        * If this is a kexec reboot, turn off Bus Master bit on the
> >        * device to tell it to not continue to do DMA. Don't touch
> > --
> > 2.43.0
> >

