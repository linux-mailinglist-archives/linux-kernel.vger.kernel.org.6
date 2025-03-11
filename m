Return-Path: <linux-kernel+bounces-556381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624ACA5C5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866721884A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92525DD0F;
	Tue, 11 Mar 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PpvvgpV/"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF92571D8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706063; cv=none; b=X7hnAGDVJIeKMFG+eOkkap7v+OqxQ67jHnSEEEg3dNfdh9DkMeWO1gom3L+Z4QYQZAceLESEEnQPrzXBpirbI2Qt+pYLKQXichpwHKjRXx3alwvSmd2/U7fc65yDAFNhjTI96P9HqhfT7XytJjHqtIijgqbrRrGnskuHBp1kXYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706063; c=relaxed/simple;
	bh=iBv0SBI0u0mqJ2hLDa+I/+nk5rpoHMCvlmD4u1xS/9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAvE7gwPQFDBqozTB/MFAwDNytoCwVKkPpbxSzMqJ8Z+8kBZpAozeAq6uZ9EwPAoWCXukkhHDenaIjaqKKnWJ7fKJpytXgDftz822Qo0Rq5/UNSc//ffRvb94vjdNVfDA+k1/tASuL/GBxb/WmzLKxf5ShiCPa1yvNKu2cdbF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PpvvgpV/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c55500cf80so162718785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741706060; x=1742310860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Evy3i/UzIkhyI0KxEccbdCNHkQedTc8R4M/ZChk2KNY=;
        b=PpvvgpV/NLuHfdiYMspZ6IHKTAu+rOTZU1Nh0B0YZZQXC95ea57I2qaodMMNZA2t+b
         B47Mm8OukEQe+CM/hMinDhRl8iJ4n6/DOroAR5tnxl5Pg574dWV+uaGrhUXC4Jtt7zS4
         S3xyjcgTBqT5UonvENBQPoQIj4mbmi86rwEvvUBuwQHCjT8SLtIotGtu8gHTgnuZi8Bm
         cwEV0MXxUQmTNZEizpc1Q2/sdMhizV4PQNVvIOqcGu+ONEEOZPuzHFcBLXqdo4Rq2C02
         gyPcGxCKEv3tSt5G8sgLdWDABZE2FQC6HBnBnhP3TO8a8otKmlOCNTcRFGV174I4JJ36
         CsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706060; x=1742310860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Evy3i/UzIkhyI0KxEccbdCNHkQedTc8R4M/ZChk2KNY=;
        b=Dv9SJ1D32IZu+CI928GPq30UYKubLFGqe6U6ybvXzdkbHi2gQDKK0Fb52J9pymNHPH
         T6pi/MS9SAN/Imaa2wdsbDjJOF4o54wvHKnjel0A+RHG/QAAr/2QdxVtVGTd7FApHY8b
         cSNXI4HtEq9fECijdjhIGtOsl/0lmpAuYRhBZMz0Exz5vHeAUqJpM2Ui8XQKJp9lxYYr
         aIsUmGVSl0g3ZCBEMvF2xDQGKDmu/WFEtfe6DwEQOcD/YPycrEIXOa0De3edDu0orD1o
         ElNVLU7lPL/J6tK7E2hp8zHKzOr1LOr+a+7y1bopntqE/W7aljQ7W9jYMIhTX4PrUl7/
         kSpw==
X-Forwarded-Encrypted: i=1; AJvYcCWvQ9Aei/dLyG6/WueaqpVl2YwZ7OZ4xoMm/+jV1NHdrBi0O31EaLexQNcKSXx1DawhPDwaISkdNngMRjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwptWMXWqbhR8pYl36DCes4am1+37Jh2dx1VYqCFxcabMJ41h
	KegF8yC0sWmA++GQaW/HVfum8+y0sNh+IN7zOe8kqkdUUlE+QLpXm1FdcabS3OZio1vFnI8jTI9
	LmFz6zTIiThxd4p3xqvxNiePYbKIJA5u/gRm7
X-Gm-Gg: ASbGncuXJZBh61jcnttTJya85AYwLahjaawgyOpTGl4+F2/ObaW02tiTgKGxmQj0Hyb
	dfdHWRNSq+h3hF3FuOsrmxZIm6imcbow87b6w0LDrsJPJ+0LHx9uf7ZNwLeegCoIC8hyP8xVzdO
	GNjM5jt/BXoUqg3fft3fJvrB855g==
X-Google-Smtp-Source: AGHT+IFSa2EhAAeUGu4Iit9E0/qpbd2+7yC/0N9EYTysdPGCdpU8ni/m9o25fyB0KM5SpgmA8E6N/2aHbDADMxT2F18=
X-Received: by 2002:a05:620a:618e:b0:7c5:4c49:76a5 with SMTP id
 af79cd13be357-7c54c4981admr1323514285a.12.1741706060070; Tue, 11 Mar 2025
 08:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <20250311133731.GB17395@linux-l9pv.suse>
In-Reply-To: <20250311133731.GB17395@linux-l9pv.suse>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 11 Mar 2025 11:14:08 -0400
X-Gm-Features: AQ5f1Jqr4_hVE1x1R6hZKxzTP8FN-7YzAhoE2LEe81DYBasZfYzjWj8gWtHnCQg
Message-ID: <CAHC9VhQxhe6Gqjzri+SXi_OdW_7tSM06A7M9_O=FPef1AsuTkA@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: joeyli <jlee@suse.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, nathan@kernel.org, Jiri Kosina <JKosina@suse.cz>, 
	Michal Suchanek <msuchanek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:37=E2=80=AFAM joeyli <jlee@suse.com> wrote:
>
> Hi KP,
>
> On Thu, Aug 01, 2024 at 07:17:47PM +0200, KP Singh wrote:
> > With LSMs using static calls, early_lsm_init needs to wait for setup_ar=
ch
> > for architecture specific functionality which includes jump tables and
> > static calls to be initialized.
> >
> > This only affects "early LSMs" i.e. only lockdown when
> > CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.
> >
> > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static =
calls")
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> I have tested acpi table override function by
> CONFIG_ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD option. As this patch
> description, the early LSM can NOT lockdown acpi table override in early
> boot stage now.

It's been years since I've had to an ACPI DSDT override, but just so
I'm clear, this replacement table needs to be bundled in the initrd,
yes?  Assuming that's the case, I think that's likely okay as anyone
who cares enough about kernel integrity to run Lockdown should also be
protecting the kernel/initrd with a firmware and bootloader chain that
ensures only authorized images are booted.  If the user doesn't put
any protections in place to ensure only authorized kernels/initrds are
booted, Lockdown is a bit silly anyway.

> Do you have any plan to fix the early lockdown LSM? Or I missed any fix
> patch in kernel mailing list?

--=20
paul-moore.com

