Return-Path: <linux-kernel+bounces-410369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346189CDA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0AC2835DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7D18B492;
	Fri, 15 Nov 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYH503cF"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1D1442F4;
	Fri, 15 Nov 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659463; cv=none; b=h7tAg5tO5/3buii3Ocl0VebMR7Xo8MP+Upyz57wx5VdlSeE91GM0jqTRlMK9qoaaRn09YzmBa6Ka8g46giyFek7E3DvdfefVqwQb2e5tlSxr8ZQNTuwuD6hUwiDd0d3LuTdBafHwYDr0GN93EzkVCUh3kdIqwSSu6Oj4YpJYzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659463; c=relaxed/simple;
	bh=aepKhY3q7EiZgbqSDNNifX5wqjXSYMCFZqfrRtPFLRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxSSohYVILUyNK+s+sv/C2ZA3434iE7gCNplPoyvi51zkYIaX3PzetUoyrdAkkIQgVzKbBFx4JWMody+yEev3W5CHly7YkEvv37XnFsSVan4KPq/xqS98xQH8f2TINIZGftQFsGuQy5yCIbTF9euByZVLSxDo7wVdxRmrnz+aTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYH503cF; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e383bbcef9dso183012276.3;
        Fri, 15 Nov 2024 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731659460; x=1732264260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHL/ci9VxK9VKzFDJdgaWG+Fff8ppDWDOwB2XTtPdQQ=;
        b=lYH503cF7yphphttilW9IPOeUujw712ork4A+xIwAX2l9cdgdsjhUeNMXCOJYAlZWY
         3Z3WnsZC/dw0jHdtNgE5tdwFtFbazLc3woHQiXBJo8HLBEsdba56giWIHI6GP+cqStxc
         7XmqagHCRtjg2zwouVEiTnCVSxxGRkPePwBfgPmBbO2+Ilbc/ILy85j/TGPmUMa42hxU
         nDhrEiD7+UA1dV9TGeAYusvANf6zeSXYzKvNpkuqJz1ZcXdyQTlhhDx8ADYyWXPzih1a
         XFlpTzOOII3KVV6B+rEch6qyn/u72xLPDrByzZN4uEzYCvvM3imBLoWfTkut5agpmT7o
         H4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731659460; x=1732264260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHL/ci9VxK9VKzFDJdgaWG+Fff8ppDWDOwB2XTtPdQQ=;
        b=dDFMJGfUgbmn/mWlSIoQit+HMvVGNcnOAnjtmJmWMt+Zc/hYKsEdEillVVFh+L4Ls3
         3Nfn3QKSm/N0ncf1dEJLiuF1/aN0otm2pJmb8m80/2h1EILsI3Cd4IVDO55N6UekegDR
         yynf2hSsH5Cr+DkQc8MvwiCDNyO4hc+ZcGk2b1Yfkoh8g+e9nvcouZ5IjS+j13fvswQ1
         5MrAsprh6S/0eWcqxWzHYLZ8vFRcd5lEClYfOkuaXw6f99gvTHKqZiEwMAn9jwnID1sp
         ph/6a0YfXSWr+RH9wifl48wZj+f+3N234SVu7qg2kwTHgXdIexWcXvUalHN8goTjpnu2
         4dZA==
X-Forwarded-Encrypted: i=1; AJvYcCXmTOhPjHVwRfuEx9TEBbx0DjuEgYcuz2O0I99gVSZKG1rM62qvVKFgfLhYyHxCHavcFv5tbxUB+Dh4b5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB83nXwtNgdm32NnQ4hoMWmb/rx/zm1Ge8iy4xkZv2AdE0uCoT
	JiMfT6bODyJdqF/HgYG19S3U8i2tKBRtImv4I7igJ9XhUzVLoW/w4tjMVejqc1vURxmY0Ydo48F
	zraZX4ncxggPKLcXku6KK+FyWvzStKg==
X-Google-Smtp-Source: AGHT+IEeIlTtLPul9ftiLGdznxoImq9rc+LVtgWtMqUBcyddRPwn4tya2o7Mj6XYFvro68rkyBJ1w/oHKEVmL/Vnk/4=
X-Received: by 2002:a05:6902:1001:b0:e2e:472d:b107 with SMTP id
 3f1490d57ef6-e38265e0a6dmr1770716276.52.1731659460580; Fri, 15 Nov 2024
 00:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHXL5pfQjhpANBxNY1YjURhWwU17WD9gX4rDqi4ezYOKeFs=gQ@mail.gmail.com>
 <2024111339-monogram-refried-f189@gregkh> <CAHXL5pdW-3P4vJf8wmUHc=VBzXsFYkHXw=6yVc-hqfY-mE8wWA@mail.gmail.com>
In-Reply-To: <CAHXL5pdW-3P4vJf8wmUHc=VBzXsFYkHXw=6yVc-hqfY-mE8wWA@mail.gmail.com>
From: Jason fab <siliconfab@gmail.com>
Date: Fri, 15 Nov 2024 14:00:49 +0530
Message-ID: <CAHXL5pfiy-yyDfhXnBjPREQULP4UFqTZHhOM9OXFxA07Q9LUpQ@mail.gmail.com>
Subject: Re: VTIO support on USB
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 12:24=E2=80=AFPM Jason fab <siliconfab@gmail.com> w=
rote:
>
> On Wed, Nov 13, 2024 at 11:48=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> >
> > On Wed, Nov 13, 2024 at 11:27:47AM +0530, Jason fab wrote:
> > > Hello,
> > >
> > > I would like to know if the linux kernel usb subsystem supports
> > > Virtualization based Trusted IO Management (USB VTIO)?
> >
> > What exactly is that, I can't seem to search for it and have not heard
> > of it before.  Do you have a link to it somewhere?  Is there a USB.org
> > specification published for it?
>
> I came across the below xHCI document and am wondering if the
> Linux kernel already supports it.
>
> Here is the link to the document:
> https://www.intel.com/content/dam/www/public/us/en/documents/technical-sp=
ecifications/extensible-host-controler-interface-usb-xhci.pdf
> Section 4.5 USB Virtualization Based Trusted IO Management (USB VTIO):

I would like to know if Linux Kernel supports the above USB VTIO
feature. If yes, appreciate if someone can share steps/documents to
enable it.

-Thanks

>
> The USB Virtualization based Trusted IO Management capability provided
> by the xHC is optional functionality that enables a multi SW/HW function
> ownership and access model for the various XHCI defined memory structures
> and messages. As an example we can view a PCI based xHC implementation
> as using the PCI defined function as the method to comply with the USB VT=
IO
> requirements.
>
> The PCI Bus/Device/Function (BDF) for a given PCI function is determined =
during
> the standard PCI enumeration of devices. PCI controllers captures its BDF=
 when
> it receives a downstream Type-0 Config Write (CfgWr0) cycle targeting its
> Configuration header. This latched value is used as a "Requester ID" or
> =E2=80=9CDMA Identification=E2=80=9D for all transactions initiated by th=
e controller.
> The PCI BDF
> which is determined by the standard PCI discovery/enumeration process wil=
l be
> referred to as the Primary DMA-ID.
> >
> > thanks,
> >
> > greg k-h

