Return-Path: <linux-kernel+bounces-320575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF5C970C1E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98216B21BB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6781ACDE3;
	Mon,  9 Sep 2024 03:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hmd0NIx5"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB181581EB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725851128; cv=none; b=i/XsvZMdIxUdMB1Pml/k2gqOdTpUXKQM5SiHli1n46OyJxAK56YbCBWmUuW5zQAjQFXwPMWfwqcDulwmuS1oPl+vP6mFPShHm7VF/UCQXp7uz8Md2TTPch3yuS+5YEBSOylAV57O8EzXMzF7WOfysoV0Yv3WOIi3QlhVZwkyoQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725851128; c=relaxed/simple;
	bh=uibYA0DDhkVGM1oULcHE7FcHV+h/M6ULLQSMEo15LJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2xTUaxzIFcF58QX482m3eoy2N66v/6eacILmaT2sxxR6vCHSXMVvIcGhQkCmrg/TiMAWLEKFx8Pof++kc63Fuf8g7T6PCd5i930XbfDumYC2d8V9xJd45ILXqjkLamqxmptir5srPx53BNZLt/s2HPeDN5bmfclnHqGWxxurdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=hmd0NIx5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3B2683F1E8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 03:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725851119;
	bh=GjcxPsYBfm9i0vtMaX4QCNll1ePzYeiDXIPkGdzVHmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=hmd0NIx5RyRHlKqj9LfPffk54BYtAhkjYnwfWVoesEPrro9ig+RnT6yfPktUsLruH
	 ReEOvtbH273NhMTk9dfYXbroOfMTEE0Hm3XbIOMNgl1Sq0rcy/XUfwRpAMuUTyNGla
	 WPtQU57xjEpdc+RjNg/IFtLZx1J9y5hB6pBYECpL/SDtNY29nXaacbicIb7mUKRupG
	 fpGD1NqJ53MJoIs9dfS5cbM36W/MDRo7H2MeIHRSdDd1cQOxsUJ5kkpzUxhk45WoID
	 FAr/nSyXzQfm7TkxEHVlSm7eIw8wscJWr8iq9z1f8FOC4eN3w84dRvpANDM1Xgufl9
	 cjcgFsHemLtJA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8711c48990so403033466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 20:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725851118; x=1726455918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjcxPsYBfm9i0vtMaX4QCNll1ePzYeiDXIPkGdzVHmU=;
        b=qmIq1MiZ/RJgbjnC97boxLROGUiCefFIgplBa0Ir/iyJqjXGoBEJDFN4lPpsHh0oyr
         k23vmITDtw0dTK9tYvUEOnFHl0o/gjhCwMWNQHvUqoILZ6j2W6By3VI+2wn/ATP4lBKF
         TcOWekEW9nEY/mm/16xGDybWfluyeFPLau1o34HpkzhuPuV296sYAYLfDt9aYMYstDDk
         4posNsZfkyXtLQ/NJPQ6Ln0IUG8rZcvI2IL7kpmWexFbfA8p/iWRwNcKO0KDLEtWeGiP
         pRsLWj0vSPEXpCMki+yiW85sGnbG/ZruTAptSeUE4qHauN7qW3ny2mQsrapQteJO3uw/
         KlOA==
X-Forwarded-Encrypted: i=1; AJvYcCVHPOs8eJvKD0VMs76MLL6znQMXsZF7U2VFHTAJq6k9HrATumnlNjJn2OfSjWbckoePrwli2H2vV4tzbN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3ZKlDFDqxqPjMnHMfs3ZhSCAe8Sb08tyMO9eZvcKG6p6fhsi
	zkWV2ZAGAvakcPVj5+iWIOaX8GkbFCDDqu3uiXRJzcSriENHsSyl8x6y0fNLQnlTYwK7wG2TX/D
	WfL4jNIo/gwV7R6C6mL8E2awoD77ExGRiA0Nz+lFsM1aMtedrYpZ6mWMA6CxJKbHnPjtY8xuc+y
	3EAFHV9+Y9XXv+hK+SglLtIFI8WoOnGZG5rOCRyZa0rPG6i6drht75
X-Received: by 2002:a17:907:8686:b0:a8a:66b6:58d with SMTP id a640c23a62f3a-a8d1c4d7913mr662532466b.41.1725851118564;
        Sun, 08 Sep 2024 20:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuG/c1pV3OAm6nu2vGlRvKv9U2b23ZY+JOWpXPKoYpNvuHAMLNmrC0KbsLPzB4znzP3SjrhcsA8LUxfwmEUvU=
X-Received: by 2002:a17:907:8686:b0:a8a:66b6:58d with SMTP id
 a640c23a62f3a-a8d1c4d7913mr662529366b.41.1725851117993; Sun, 08 Sep 2024
 20:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906053047.459036-1-kai.heng.feng@canonical.com> <d8600868-6e4b-45ab-b328-852b6ac8ecb5@rowland.harvard.edu>
In-Reply-To: <d8600868-6e4b-45ab-b328-852b6ac8ecb5@rowland.harvard.edu>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 9 Sep 2024 11:05:05 +0800
Message-ID: <CAAd53p4i1zzW2DsVfirjXVsQX0AgXy1XbzWaM-ziWmAmp8J1=A@mail.gmail.com>
Subject: Re: [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne 440
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org, 
	jorge.lopez2@hp.com, acelan.kao@canonical.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 10:22=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, Sep 06, 2024 at 01:30:47PM +0800, Kai-Heng Feng wrote:
> > The HP ProOne 440 has a power saving design that when the display is
> > off, it also cuts the USB touchscreen device's power off.
> >
> > This can cause system early wakeup because cutting the power off the
> > touchscreen device creates a disconnect event and prevent the system
> > from suspending:
>
> Is the touchscreen device connected directly to the root hub?  If it is
> then it looks like there's a separate bug here, which needs to be fixed.
>
> > [  445.814574] hub 2-0:1.0: hub_suspend
> > [  445.814652] usb usb2: bus suspend, wakeup 0
>
> Since the wakeup flag is set to 0, the root hub should not generate a
> wakeup request when a port-status-change event happens.

The disconnect event itself should not generate a wake request, but
the interrupt itself still needs to be handled.

>
> > [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, p=
ortsc: 0x202a0
> > [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
>
> But it did.  This appears to be a bug in one of the xhci-hcd suspend
> routines.

So should the xhci-hcd delay all interrupt handling after system resume?

>
> Alternatively, if the touchscreen device is connected to an intermediate
> hub then that intermediate hub should not be allowed to generate wakeup
> events.  That's determined by userspace, though, not by the kernel.

It's connected to roothub.

Kai-Heng

>
> Alan Stern

