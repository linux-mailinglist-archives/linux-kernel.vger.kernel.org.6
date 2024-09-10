Return-Path: <linux-kernel+bounces-322352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAAB9727AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1682D1F22FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67B97E101;
	Tue, 10 Sep 2024 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iLzMt6Rr"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F9134A8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725939206; cv=none; b=d5uC2K6x89j1UW3RZPsSLG1TAI0enJkI3bMC+movE7DmmUKMHbWNJMaYZNPgfv71ePnaLbDI+wkyj00ql27lwE4svR5PWr9yhAPxXLe+pCiKis8ugg1R56zipQk5fs8+fOgCwD+NWsVugOJ0hCqPt8AktNssN1cPk07VmFSdFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725939206; c=relaxed/simple;
	bh=M1uP5T0syaPKmILBGoKjk5yrtVDRgj+U0SiUidxvyAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7rvJsM+fGpP5PU0HCsFrcNj2RcZDLESEWwZE9J7o9b16QizB7cVAJ9+ZFhnD2bgjMEla7HuyCYGy+LpGE0KkwGRTFEGB9GE18m7gNjA1wDnOBzyC7FJyhmKCbXpNeL5tNeuT3N4bXmjM/1/gAU+cY7tUoqh/+Pw+F1+P0/4cQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iLzMt6Rr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB5C73F62B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 03:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725939195;
	bh=bdVMALNY4Nj+ezeanQrYsAz9ac60a7efpGm9G6VkDpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=iLzMt6RrcY/ZBpNhgEiTF/27CPwOyLascBuCqlV7dHfIaWZ1RhmHyWj5TlMSKFiR4
	 VIOqW/wdwRE+39E4H2F3AANxFMNv6qWubVgk3uAFaLvnx6JoN4Hi5S/B7omSWLc14M
	 G8rKFtgNfoo9xvkGojSh9FMQAMhLcTmRGTfSYp9vy5RvMAzRNr390fEN5s+Y/RJg36
	 IgdeXaC8R1yOGmFDiG8SC6BXAoxzOnGWCCMpiAFN3FAkUkknLIWNtm+hePnT0+9pT9
	 JqxhiCWCWarlvTAqSGV+L3+RzFpmxCU1JfKD64AJfqW6/ZfFF1TVd5gCmU9QCnFOTh
	 ju3wlraIPzaiQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a92ab4cdbso21148966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 20:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725939195; x=1726543995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdVMALNY4Nj+ezeanQrYsAz9ac60a7efpGm9G6VkDpg=;
        b=oC3tgzGy07p0KejhAgmQPmfcjZCpcW3+a5P0RwjV2eHhKqzgneInRUhJQyLyzJivUN
         EbQXJckPWIzilgu5/B91DTZQ8u3x2dFDJgyq91lr/nJDSckSY4uVHuF/k3nQxmusg4cA
         wGiyZ+OGdRgss6ieFpq7Z/RHJUiqzJ5HrzSS187oTii08ZKBS56OQRgRFYyTE1CGv1KG
         xcy2lwKgsElxqzYJcgmia/g4DFk+Rof0+8BCiQwxBMHtcCxWQ8N4/cyJsvAHBN9ZqRiz
         j6syzD0i8JzTdrj7KIK7OfnWWLi0FQUr5xxKYtnTEfmGMhmi3xD2YUP63HYtdCJgCaTK
         u3qA==
X-Forwarded-Encrypted: i=1; AJvYcCW3xHH07zwJk4K7Ji+EQuAmGKfOoCwjzpaHau8Q/o8L2sAsK34fEa8BLcWedlwyjYx8thaXGXRpON+0bjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfvJ4M9yD6V/98bjYkVSr3vzudRpIhHEsY0oIIkoqq24yz9rMk
	HwdK7wipaUzF7zSJz9JuYkcwR1K8HmW/ujkoABGjVD3QaABYmONCY7dj3RlLHWTN1Hc4Ha6K8FH
	1a9z9Z1IFKGNZfB5wN9etkU5FZwsGBLbFP36BPzVbjsZS0WZIl6U+abb+L61d1d1RDJYvRMfmq1
	+LWKiikulDbonSdYuGvj5VWvTDp1SFDld2joxhSQEgeYrcQMLTveVR
X-Received: by 2002:a17:907:2cc4:b0:a8d:439d:5c25 with SMTP id a640c23a62f3a-a8d439d5dd4mr610728266b.4.1725939194990;
        Mon, 09 Sep 2024 20:33:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZXtqOWZQ5DP9i2k8x9bhsn2QouSJ03mlNURHgsOx/klP+Z9vIiP/N3mGSJraaI3jlqXXbyC2kGjXcONaqKGg=
X-Received: by 2002:a17:907:2cc4:b0:a8d:439d:5c25 with SMTP id
 a640c23a62f3a-a8d439d5dd4mr610726466b.4.1725939194421; Mon, 09 Sep 2024
 20:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906053047.459036-1-kai.heng.feng@canonical.com>
 <d8600868-6e4b-45ab-b328-852b6ac8ecb5@rowland.harvard.edu>
 <CAAd53p4i1zzW2DsVfirjXVsQX0AgXy1XbzWaM-ziWmAmp8J1=A@mail.gmail.com> <7be0c87a-c00f-4346-8482-f41ef0249b57@rowland.harvard.edu>
In-Reply-To: <7be0c87a-c00f-4346-8482-f41ef0249b57@rowland.harvard.edu>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 10 Sep 2024 11:33:02 +0800
Message-ID: <CAAd53p7c4-jpZ6OsW+H9qw2mvvr8kSfX2UEf8YrsWJt5koYbAA@mail.gmail.com>
Subject: Re: [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne 440
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org, 
	jorge.lopez2@hp.com, acelan.kao@canonical.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:39=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Mon, Sep 09, 2024 at 11:05:05AM +0800, Kai-Heng Feng wrote:
> > On Fri, Sep 6, 2024 at 10:22=E2=80=AFPM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Fri, Sep 06, 2024 at 01:30:47PM +0800, Kai-Heng Feng wrote:
> > > > The HP ProOne 440 has a power saving design that when the display i=
s
> > > > off, it also cuts the USB touchscreen device's power off.
> > > >
> > > > This can cause system early wakeup because cutting the power off th=
e
> > > > touchscreen device creates a disconnect event and prevent the syste=
m
> > > > from suspending:
> > >
> > > Is the touchscreen device connected directly to the root hub?  If it =
is
> > > then it looks like there's a separate bug here, which needs to be fix=
ed.
> > >
> > > > [  445.814574] hub 2-0:1.0: hub_suspend
> > > > [  445.814652] usb usb2: bus suspend, wakeup 0
> > >
> > > Since the wakeup flag is set to 0, the root hub should not generate a
> > > wakeup request when a port-status-change event happens.
> >
> > The disconnect event itself should not generate a wake request, but
> > the interrupt itself still needs to be handled.
> >
> > >
> > > > [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 1=
1, portsc: 0x202a0
> > > > [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
> > >
> > > But it did.  This appears to be a bug in one of the xhci-hcd suspend
> > > routines.
>
> I failed to notice before that the suspend message message above is for
> bus 2 whereas the port change event here is on bus 1.  Nevertheless, I
> assume that bus 1 was suspended with wakeup =3D 0, so the idea is the
> same.

Yes the bus 1 was already suspended.

>
> > So should the xhci-hcd delay all interrupt handling after system resume=
?
>
> It depends on how the hardware works; I don't know the details.  The
> best approach would be: when suspending the root hub with wakeup =3D 0,
> the driver will tell the hardware not to generate interrupt requests for
> port-change events (and then re-enable those interrupt requests when the
> root hub is resumed, later on).

So the XHCI_CMD_EIE needs to be cleared in prepare callback to ensure
there's no interrupt in suspend callback.
Maybe this can be done, but this seems to greatly alter the xHCI suspend fl=
ow.

>
> If that's not possible, another possibility is that the driver could
> handle the interrupt and clear the hardware's port-change status bit but
> then not ask for the root hub to be resumed.  However, this would
> probably be more difficult to get right.

IIUC the portsc status bit gets cleared after roothub is resumed. So
this also brings not insignificant change.
Not sure if its the best approach.

>
> Alan Stern

