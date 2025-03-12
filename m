Return-Path: <linux-kernel+bounces-557880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8603A5DF07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2E7189EB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFAA23BCF6;
	Wed, 12 Mar 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lLBEz6zr"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56E8635E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789988; cv=none; b=XNLPyf8+DyrunoyapIMMj7B7wohjFUhi0894RqPIRgFgBeUWALXkwO//tJA4nsRxfc7ifrvY480XupWiO465JRJhxIsruK2bzrgLIgoS6Lwl+IuR5uOZjL2kezKg7SIElh5mgCDVI66x240gfwuRB/41ex6J60F6WxxWt3E2ATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789988; c=relaxed/simple;
	bh=AixPktbXyhYgNZLL/XJCQek2JdSsnYFd9qTxfsG+zwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrC12ZgeWQHTOhlFGGZhtc7BnnBiZITfUF/VSqTwji2vcyA78EKn5wcREkvkMYM992+msRH+fWBTUd1MAvZMGGiD1sIhghrQ96kath4DCHHtsDa2jXUtW/fQCv4ud86/w8tEOMEN1AgqUx9oqjSqpUBxauJta7Ps5iGpI9hlfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lLBEz6zr; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476b4c9faa2so3836951cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741789985; x=1742394785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxLGV/gTabQc22y8Dfo+hpafOImuUut6Nenup2mQyaY=;
        b=lLBEz6zrekSPYEoWuANzrY+WhNxqI+VKMWYWHM2ZSzfdeYMafuAMDabGC6sls33RRz
         YpXUrkQOenLBPSm2XcR/n84oGLS9hRJP4RmpNzXdGVJXIXkV+A//CPYGxuhirXOM8YYl
         S5aOU+PiA+0TlOSt9zJqob4pUtUpfRprp1sSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789985; x=1742394785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxLGV/gTabQc22y8Dfo+hpafOImuUut6Nenup2mQyaY=;
        b=CmWRUC6gfBoDdxYdRV3ZTLdor0ESeLiV3ZjFSNOSr4HNdaZzvMjQrTtLq0a+Vgr778
         9HlcdyxiNub3ctcj+vbtiun1effOk//xDDed+TTPAboqymPA8731wxHgygkzcrOfO/5H
         DJpu8apPRpHfTbkkyQ7qsUWy8+MMzxr2qqrbyw6cg5cjlWUZTBlU1k7+aDQAi8IupjBL
         UPwPh6d/pkQ6Doyo63dYRBMDI7gmlKGLYopcAWx8GELEQxR6uTIKndNcj28/38dmUzQ6
         55rJg9n9rodWAOtNsov/zqFVVNcLkDUNzTIcWzl9gVLoXCqUkmrsdfqSrACeI7Q9M1H0
         hDSw==
X-Forwarded-Encrypted: i=1; AJvYcCUPo43b4zPHjCOoYt12E2amXTZp8fk3jIX3m4GD/tx8V3HxJklrxF9TeNyB3BZq+2wiRoH8jbjYl6zXYMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgpyVlZTRrFZVYzsMrMb8boANBGSpPjcPT0pf5VemmETUifrk
	Yv0QcAkXlOoLzrnKjWkao2vxBASEx8H5XL1WS93VhI0A5V4z6UJu10UDMbJXfyof3GDplTEb5Aa
	ISw==
X-Gm-Gg: ASbGncvVMDFrZrJOzM/fEPiiauffdmHxUpeT9AeFOfqe5iivhQ+FhqSOv8QR0uZzXKG
	E4nJhWkKFB8PWM4m4izcrcuytwJAXkNhDXl5a1CoO1jjQOGpszM6N4g9kv0w7Nztkznwe/bh/cD
	aTRTIVg+X12ipSPm1VHwUDOyOaLsz6PXaFd/DUM7/DBSitQDOCdV/Iknt5ijcQE9fnVfuxNGQJi
	Cvv0p1mye5pe3/i2guyriCRb0lb1kfKM4T9FBfrfxpd/4+SUOtLRMZq7GKgdasDxu0Bbg+ap4wF
	0sP5ZnJChFKSKkiM5yZtNSy+qauCoKizI0tMOtgeQ7XzdNq/c3AGCLzx+0ta4kHGyfIE5wpJe7K
	z4Uf0RXKrq3KA
X-Google-Smtp-Source: AGHT+IGjvlSqc0zZc7Aij7M2xOcnVbm8HYZOu2WKhyL5y/B6w0ir/0WFDPvQODnEXefpXW32rWbw/Q==
X-Received: by 2002:a05:622a:5b8a:b0:476:9dc9:3c2a with SMTP id d75a77b69052e-4769dc9444emr81634551cf.48.1741789985094;
        Wed, 12 Mar 2025 07:33:05 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4768affa969sm41549571cf.73.2025.03.12.07.33.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 07:33:04 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476693c2cc2so263861cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:33:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQBX0+5uZRFsLcb98taO9g5qwq+pturZ4mgH7CL0kSYAmZhOEB2qNQeEijT+gxiHMNut4At5+MbIVqvOk=@vger.kernel.org
X-Received: by 2002:ac8:7d8a:0:b0:474:b44f:bb88 with SMTP id
 d75a77b69052e-476adf0e170mr3551051cf.27.1741789983956; Wed, 12 Mar 2025
 07:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-dead_site-v1-1-7ab3cea374f2@chromium.org> <b3df5e8178107b2a133126e1daf111d10f1b0333.camel@linux.ibm.com>
In-Reply-To: <b3df5e8178107b2a133126e1daf111d10f1b0333.camel@linux.ibm.com>
From: Fritz Koenig <frkoenig@chromium.org>
Date: Wed, 12 Mar 2025 07:32:52 -0700
X-Gmail-Original-Message-ID: <CAMfZQbxoO0QX=r6ECcVHBToR7jaqAz3HD6ZaOf-Z3nP2RuYFdw@mail.gmail.com>
X-Gm-Features: AQ5f1JqjD2DWXGYq02-0yYL-x2rBYXh6GczZW-B2jC0-D-TCZJLFB5aqywzcsmw
Message-ID: <CAMfZQbxoO0QX=r6ECcVHBToR7jaqAz3HD6ZaOf-Z3nP2RuYFdw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ocxl.rst: Update consortium site
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Fritz Koenig <frkoenig@chromium.org>, Frederic Barrat <fbarrat@linux.ibm.com>, 
	Jonathan Corbet <corbet@lwn.net>, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:20=E2=80=AFPM Andrew Donnellan <ajd@linux.ibm.com=
> wrote:
>
> On Tue, 2025-03-11 at 11:24 -0700, Fritz Koenig wrote:
> > Old site no longer associated with consortium.
>
> Thanks for catching this!
>
> >
> > Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
> > ---
> > After mergers the OpenCAPI Consortium does not seem to exist.
> > The github page is the only seemingly relevant site, but it
> > has not been updated in 4 years.
> > ---
> >  Documentation/userspace-api/accelerators/ocxl.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/accelerators/ocxl.rst
> > b/Documentation/userspace-api/accelerators/ocxl.rst
> > index db7570d5e50d..5fc86ead39f4 100644
> > --- a/Documentation/userspace-api/accelerators/ocxl.rst
> > +++ b/Documentation/userspace-api/accelerators/ocxl.rst
> > @@ -3,8 +3,8 @@ OpenCAPI (Open Coherent Accelerator Processor
> > Interface)
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  OpenCAPI is an interface between processors and accelerators. It
> > aims
> > -at being low-latency and high-bandwidth. The specification is
> > -developed by the `OpenCAPI Consortium <http://opencapi.org/>`_.
> > +at being low-latency and high-bandwidth. The specification is
> > developed
> > +by the `OpenCAPI Consortium
> > <https://opencapi.github.io/oc-accel-doc/>`_.
>
> This link is to the OC-Accel framework documentation, which isn't the
> core set of OpenCAPI specifications. Those specs are now hosted by CXL,
> post-merger.
>
> I think I'd update this to say:
>
> The specification was developed by the OpenCAPI Consortium, and is now
> available from the `Compute Express Link Consortium
> <https://computeexpresslink.org/resource/opencapi-specification-archive/>=
_.
>
Thanks for the feedback, V2 posted.

-Fritz

> Thanks,
> Andrew
>
> --
> Andrew Donnellan    OzLabs, ADL Canberra
> ajd@linux.ibm.com   IBM Australia Limited

