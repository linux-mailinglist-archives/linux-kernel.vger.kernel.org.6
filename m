Return-Path: <linux-kernel+bounces-407164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FBF9C698C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690601F23B98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF8F17DFEF;
	Wed, 13 Nov 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC0DwCLD"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6314F9FD;
	Wed, 13 Nov 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480856; cv=none; b=LrWzwJfW5RkcELFzowa6HtAz0Wazqg+Id40gYCLpm2NCuLtCEQww9f/1s/X6o6YQIQEuit2Rjnimd3jDoW945swUbTi5UemibtoNaSr3Jdj+/HjcX60R6iwBNJfJZhHPEadibaeXoKTcfrkzSW3ey+wG8eGorRczT+KR1dAQZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480856; c=relaxed/simple;
	bh=7HSaIoMJrVdHC+tynb+kXakIijxy7sLpdCWBt/E3LY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4vh6Sni77XxvRMvxJWGc62uvRelY3+5pwjEtjk+Q43LLyb6jpfJJXedvbDJqdgflOcSfxOfUSXcgWyNWctdaLRJlq1lDM7fnRtrW4xDrctnEeTWRfdMu9vKTJJOoy+sBqCC3ImeaLESyeEh13Cf7CEXznSn5Zh7D+NeLRo7ubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC0DwCLD; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e290222fdd0so6597440276.2;
        Tue, 12 Nov 2024 22:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731480853; x=1732085653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrNLjLsRQLr0ps1v+KNOvrbFDIEt75rdtQ0MEE2zWBA=;
        b=fC0DwCLDXDjZGS5WpDZp2jzTeyqdsIZ8t3DF1RHpAeLaE70m1tarLIO5Y49RHIdLPz
         ICpb0Mh4Udsa0kOp1xwm6WhIfwIaSkfNw0DD3Ove1EBDu1Zw/FxagnttnAxe5HePRT7n
         WYwICy+YlFP/pqrynbBOepoe2evTrzdKsUolAm0ZYNQCZFIFrfmGSrBgW+qPxFO6jrZJ
         i0r8syeSphwoYCaW/pOxZ/xTYnoYBFJxHUccLNFMREa24rPRcG3LbX5sGk9QGkpYMG+H
         rfXCFNfGbTGsJKqCKEWRmmUsbgctQD1RgszoApzswZofgotDE9Xzqs6tb9wDKT7SNF9U
         vNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731480853; x=1732085653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrNLjLsRQLr0ps1v+KNOvrbFDIEt75rdtQ0MEE2zWBA=;
        b=ZZCX18Aq4AY5LpcGRaX0G9suj3KhTFbMFMhh54bcBF6vHZQ/yRTiiNuqtfbnAolbja
         AbCPidJDQgKV6qVSGUjH0bBtzqVsru9fsH1GaICOMyGvE9rHrz9YPOctJ9b/kmuBxGyf
         5qfmrN/UZKeUzoDzknbHKg84pfp5Ms4XHeoWQ0CylbtPUVRG/1QAZzd5+Xd+Op/4FLIA
         cXFgUgTj+STvewYakpiUUCBu6TqvRJ/ASptq0mHwNQJgiu9V3jNUL4KGLg43+4lvC+QG
         N+DEsmn09CNSVlYaeM38t5uiPzdmWA4iRmNLPMyNLQoTmsKKsRv8ekNia3OSsMYGRrlB
         XyvA==
X-Forwarded-Encrypted: i=1; AJvYcCUd9T1+e3ckBiADfnPMFQ0YeLnb1wlKFACxvEFzgnOzaBYDgoPv5XpibBLKejML2nrzMX6LUoodKUk3IlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoho7ISBHXrAX2BiTL5LZzmp8rdPu1HMAZfvqmzlI4wk+lfD73
	SEj9mWdt5vEtF/STa24P6ejzuP7HT0TgAnb5z9CAbDdd0a/ryBDvS+SXs4l8kp5yp/x9aAYw9SX
	CwU3DNU8Ib1ZeyiULnSs0cGSIxK9Fy55Rwxk=
X-Google-Smtp-Source: AGHT+IE3s+f/mB7Mzho1Cx8JUwi955uUFzW3950xIWxEcHwHDXkgAv8AUNFp+sRxDBeLq71IKMirHv+8b96gGUJIvJA=
X-Received: by 2002:a05:6902:2b85:b0:e28:e4bd:13f6 with SMTP id
 3f1490d57ef6-e337f8c7018mr17328013276.33.1731480853490; Tue, 12 Nov 2024
 22:54:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHXL5pfQjhpANBxNY1YjURhWwU17WD9gX4rDqi4ezYOKeFs=gQ@mail.gmail.com>
 <2024111339-monogram-refried-f189@gregkh>
In-Reply-To: <2024111339-monogram-refried-f189@gregkh>
From: Jason fab <siliconfab@gmail.com>
Date: Wed, 13 Nov 2024 12:24:01 +0530
Message-ID: <CAHXL5pdW-3P4vJf8wmUHc=VBzXsFYkHXw=6yVc-hqfY-mE8wWA@mail.gmail.com>
Subject: Re: VTIO support on USB
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:48=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Nov 13, 2024 at 11:27:47AM +0530, Jason fab wrote:
> > Hello,
> >
> > I would like to know if the linux kernel usb subsystem supports
> > Virtualization based Trusted IO Management (USB VTIO)?
>
> What exactly is that, I can't seem to search for it and have not heard
> of it before.  Do you have a link to it somewhere?  Is there a USB.org
> specification published for it?

I came across the below xHCI document and am wondering if the
Linux kernel already supports it.

Here is the link to the document:
https://www.intel.com/content/dam/www/public/us/en/documents/technical-spec=
ifications/extensible-host-controler-interface-usb-xhci.pdf
Section 4.5 USB Virtualization Based Trusted IO Management (USB VTIO):

The USB Virtualization based Trusted IO Management capability provided
by the xHC is optional functionality that enables a multi SW/HW function
ownership and access model for the various XHCI defined memory structures
and messages. As an example we can view a PCI based xHC implementation
as using the PCI defined function as the method to comply with the USB VTIO
requirements.

The PCI Bus/Device/Function (BDF) for a given PCI function is determined du=
ring
the standard PCI enumeration of devices. PCI controllers captures its BDF w=
hen
it receives a downstream Type-0 Config Write (CfgWr0) cycle targeting its
Configuration header. This latched value is used as a "Requester ID" or
=E2=80=9CDMA Identification=E2=80=9D for all transactions initiated by the =
controller.
The PCI BDF
which is determined by the standard PCI discovery/enumeration process will =
be
referred to as the Primary DMA-ID.
>
> thanks,
>
> greg k-h

