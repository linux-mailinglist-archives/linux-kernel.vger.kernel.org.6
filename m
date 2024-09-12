Return-Path: <linux-kernel+bounces-326028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EEE976183
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0B7283859
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3618BB99;
	Thu, 12 Sep 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="X4HO/w1D"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B7188A00
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122520; cv=none; b=Bm3OsPSCIxGHVHiU0/djFh0SwHC+qPCgwYj+lhZ4cTQRzni3v9gV53cnyiOuL8oumVyduzLlxukuKzfuOdPpsW7+lbjHDX3FYYg4S1HJMYYedIxR7pYS/xaKZQhRCb/2lWPMSiXydxNWNNUHmFCdnHUXjs+XRbzoh6kCYj754CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122520; c=relaxed/simple;
	bh=C4dY2+lEUwUAR7oupuEUzuOC7BMjVqo9q+11nVeJbFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogJqU6BEVwVHGB9K95RDEtHmSNXn9x/+dgFD2jc0ih5acErLMxLw/LhgHnhNnDcOOpzYBChX36C3raG5ZJD8qU5AdU6kQXXvBh0qSrL3jgRRDY5duJTN7bNVrTEpojD1s3y00wiXn2os+JNJi/J7w2nZP49k7atD919+XY9HbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=X4HO/w1D; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8379E3F5B0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726122510;
	bh=sa6+SBaAxzMT/3eIq2BIGYwjKRAOqA6pxbefKSvrzAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=X4HO/w1DjWoHzoJzeEpEWDGCZAM+zO6Eq/zSm4U1gMHC7IytLA3/aKuLWI2PF0yGr
	 CDvsAzDyzRjZx2UeUZkk85TfEbE8jW2VAaoofxdUYroMl+stEbq9M8Hm7xS0lWycef
	 GW+1kfjMXBnFfSqlBGX5aHceZA33PX4OFK4Tq2qbtYWGWEnFylJIOEGbKmKV+RmxeQ
	 GtaoHdwY3rZmZJs1dQe9ya1uabGwZTWmBsywm8E5WjQ+o5NMvTOiYWZOUQX+VR7oXY
	 nFceJVyeJVCnLyCKyftRLCWceROgDqjNlWf8omgTspH+NrTSYa7ApF0H5ez+Nn+qES
	 +LOLgw/5oouJg==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f403189d83so4599461fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726122510; x=1726727310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sa6+SBaAxzMT/3eIq2BIGYwjKRAOqA6pxbefKSvrzAA=;
        b=k9TG0nBFFZxtla+dRYFSdF4AoLpZ5dUVGoqqVNPkmgiIhfsmuG3sHcnfJh/ZhgLQQe
         NGqyLba+zjqAecbHxQmxEm+2MH2CPkVRd0BcbgRT3YyxpaORY/86JGedJTmYmZBe4g6H
         fBv+ZjjvWPXqaBdDBNuoAvMLwK52XzJi295qyF2K446daW7cf/sEin2/d0jIXCaGNs61
         xZ0xBHlQGMMP+v4L+HTiyhm3rS4DVR+Y42wdnAibE+GxHkmOsYutqTZRvKt2tK2zlWu2
         XSwE+htaJjuNbZvR4rLdSCZpHuFDpFhvKWfioYpaK+LVGL1xvUWsimi3UORu82SlDEgH
         jmvg==
X-Forwarded-Encrypted: i=1; AJvYcCVRgcVLbYIlG0nZTUn+/moJdqf09ieFTwh7qWa+SJuMThFhjh9zxz0HitwdkaigoZZWrhfkBjN4imWUYDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQM46UEF1jpA5o1WyYRdYh99bcEwMyPP9oqzAwJw2xJKdPFMN
	ggfmK8kek8SFVZ1rlzUPsMvYf3Xqf1n+cbhxb7+HmjGPF6UAermaOl+ratr637+ROGK0lejMwFg
	1TiIt7cc0+2Qiqi1CTz8ERl34KVEaKCGpg43IiIT9HacHwat5N6uwe30nBCCfhVUyKUF4+1gPll
	WtDFPIX2851VbkXRT5szEnZqSvzzWDME1WX35pL/1G/80vSfUm/OY5xDKLjG19l2s=
X-Received: by 2002:a2e:bc25:0:b0:2f7:5a83:a90b with SMTP id 38308e7fff4ca-2f787d9f3c0mr9289161fa.8.1726122509699;
        Wed, 11 Sep 2024 23:28:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGePUOXOpmSriCJ/cXhQP4iqCGWM2kJ4JGiFuk2QqgtfeNpV7EU8/DJsqI0olqw//BMDbX3WSHIoUF3JmCwjs0=
X-Received: by 2002:a2e:bc25:0:b0:2f7:5a83:a90b with SMTP id
 38308e7fff4ca-2f787d9f3c0mr9288801fa.8.1726122509043; Wed, 11 Sep 2024
 23:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906053047.459036-1-kai.heng.feng@canonical.com>
 <d8600868-6e4b-45ab-b328-852b6ac8ecb5@rowland.harvard.edu>
 <CAAd53p4i1zzW2DsVfirjXVsQX0AgXy1XbzWaM-ziWmAmp8J1=A@mail.gmail.com>
 <7be0c87a-c00f-4346-8482-f41ef0249b57@rowland.harvard.edu>
 <CAAd53p7c4-jpZ6OsW+H9qw2mvvr8kSfX2UEf8YrsWJt5koYbAA@mail.gmail.com> <fe0d3259-c60b-4ef8-aa42-edb5ca2e2d90@rowland.harvard.edu>
In-Reply-To: <fe0d3259-c60b-4ef8-aa42-edb5ca2e2d90@rowland.harvard.edu>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 12 Sep 2024 14:28:15 +0800
Message-ID: <CAAd53p67c0qQijUreu0AShsKucgPY03OQP+RGw=P7-vCV3Y6eg@mail.gmail.com>
Subject: Re: [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne 440
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org, 
	jorge.lopez2@hp.com, acelan.kao@canonical.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, kaihengfeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 9:13=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Tue, Sep 10, 2024 at 11:33:02AM +0800, Kai-Heng Feng wrote:
> > On Mon, Sep 9, 2024 at 10:39=E2=80=AFPM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Mon, Sep 09, 2024 at 11:05:05AM +0800, Kai-Heng Feng wrote:
> > > > On Fri, Sep 6, 2024 at 10:22=E2=80=AFPM Alan Stern <stern@rowland.h=
arvard.edu> wrote:
> > > > >
> > > > > On Fri, Sep 06, 2024 at 01:30:47PM +0800, Kai-Heng Feng wrote:
> > > > > > The HP ProOne 440 has a power saving design that when the displ=
ay is
> > > > > > off, it also cuts the USB touchscreen device's power off.
> > > > > >
> > > > > > This can cause system early wakeup because cutting the power of=
f the
> > > > > > touchscreen device creates a disconnect event and prevent the s=
ystem
> > > > > > from suspending:
> > > > >
> > > > > Is the touchscreen device connected directly to the root hub?  If=
 it is
> > > > > then it looks like there's a separate bug here, which needs to be=
 fixed.
> > > > >
> > > > > > [  445.814574] hub 2-0:1.0: hub_suspend
> > > > > > [  445.814652] usb usb2: bus suspend, wakeup 0
> > > > >
> > > > > Since the wakeup flag is set to 0, the root hub should not genera=
te a
> > > > > wakeup request when a port-status-change event happens.
> > > >
> > > > The disconnect event itself should not generate a wake request, but
> > > > the interrupt itself still needs to be handled.
> > > >
> > > > >
> > > > > > [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, =
id 11, portsc: 0x202a0
> > > > > > [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
> > > > >
> > > > > But it did.  This appears to be a bug in one of the xhci-hcd susp=
end
> > > > > routines.
> > >
> > > I failed to notice before that the suspend message message above is f=
or
> > > bus 2 whereas the port change event here is on bus 1.  Nevertheless, =
I
> > > assume that bus 1 was suspended with wakeup =3D 0, so the idea is the
> > > same.
> >
> > Yes the bus 1 was already suspended.
> >
> > >
> > > > So should the xhci-hcd delay all interrupt handling after system re=
sume?
> > >
> > > It depends on how the hardware works; I don't know the details.  The
> > > best approach would be: when suspending the root hub with wakeup =3D =
0,
> > > the driver will tell the hardware not to generate interrupt requests =
for
> > > port-change events (and then re-enable those interrupt requests when =
the
> > > root hub is resumed, later on).
> >
> > So the XHCI_CMD_EIE needs to be cleared in prepare callback to ensure
> > there's no interrupt in suspend callback.
>
> Not in the prepare callback.  Clear it during the suspend callback.
>
> But now reading this and the earlier section, I realize what the problem
> is.  There's only one bit in the command register to control IRQ
> generation, so you can't turn off interrupt requests for bus 1 (the
> legacy USB-2 bus) without also turning them off for bus 2 (the USB-3
> bus).
>
> > Maybe this can be done, but this seems to greatly alter the xHCI suspen=
d flow.
> Yes, this approach isn't feasible.
>
> > > If that's not possible, another possibility is that the driver could
> > > handle the interrupt and clear the hardware's port-change status bit =
but
> > > then not ask for the root hub to be resumed.  However, this would
> > > probably be more difficult to get right.
> >
> > IIUC the portsc status bit gets cleared after roothub is resumed. So
> > this also brings not insignificant change.
> > Not sure if its the best approach.
>
> It should be possible for this to work.  Just make the interrupt
> handler skip calling usb_hcd_resume_root_hub() if wakeup is not enabled
> for the root hub getting the port-status change.  When the root hub
> resumes as part of the system resume later on, the hub driver will check
> and see that a connect change occurred.

This can work. But should the change be made in
usb_hcd_resume_root_hub() or by the caller?
The issue can potentially happen to all USB controllers, not just xHCI.

Kai-Heng

>
> Alan Stern

