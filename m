Return-Path: <linux-kernel+bounces-193833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA818D32DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB99F1C23443
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D792169AF0;
	Wed, 29 May 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="HJi43AvB"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494C15CD41
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974551; cv=none; b=A8D1totbMdw7dPqGJ9IEV7LHZPL/YTGlNR072VHVpKNq3lTALIwH8zYf7a3ITPwlsuaAWcpU8Xc+K4WXeb9dxIyzMUe9kuC4qApTfZyYtin1PIsR/HV3COYpqEQeNMfmA9tZYDMwk48WSSzQ/DSO5SkLLYoZ6xBibjukq8Vdq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974551; c=relaxed/simple;
	bh=ra1NS+9fSWdb9q8/PcT29/DwMyhQPkUZ6X8Be6pbo2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tLE0HZ1SVv/z2QGkUGx9kmaFUWy/IJEqjNbX5tYiE8eVEWp28TcLmfOVmi2I5C1JDBCQ+Acrc40LsS/yL/kXPGD6dAyjgAokHaO56q6apHhQF2Xbi3VRFhy86E2ZyFaoZjJyU0R1/WKjLqzUm6eSBODohgit15ZFOWXccrxgC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=HJi43AvB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bf59381a11so1601545a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1716974549; x=1717579349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayGsdOx736/Ldjrgu8+xcuCXDa4GD/n6h1A7Kseqpio=;
        b=HJi43AvBd+VnmdGwGfLfcRBA6Xhz0R0JVa3gYo7AmrfDQBcKBdJO9F4j0iOE8ZOpFH
         DLH/wcP6Tm4TxMeYYtKOge9klBbvW7he+119IR5PY7Y5U8IDvt665EVts/SoWa/e52ER
         aIZm2ujr0kkqkt+Rkm+rIK1qUjiATk6kvOo7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716974549; x=1717579349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayGsdOx736/Ldjrgu8+xcuCXDa4GD/n6h1A7Kseqpio=;
        b=FCWSo+g/GQEe3EBt7GCS7+dLJVGslxGwqC5ohwv8cMs8gIyhp5YFp9z2usn52TUv7c
         w5Y3NOixBWWZZLOtWI4HAEK4M5qrQt69STpYCTESfD4bm7aUp9lzgH9ppRe2BiKfp9Az
         jF9rgonHo4pupmSGkwpzqyx79UPx1ZRB8W41srzLhHuj6aL+EaCqUDhANznDvp5Qp0jR
         +k0VY/K4MdfYsVc5NKuRDjDvU6+krLcN/MiDSCHNGtpSYV7Xjg/74EG+xMCg3y5xJdzc
         9/2G6Twfy7SsB5fdNd6NZQjKUy8OUqM0gACFRtD1yWJYcJcBFvCa/Eq+f/xk7nB9tLEV
         dLUA==
X-Forwarded-Encrypted: i=1; AJvYcCWNmmujWhhCRsIUagER39nolq+5vxxbQYYEejnCPRAkaqArQexcdmS/mlVWtAF3EPmfLC0zs55YK1X9VR3zf0kLEGmGkEb8PDW4FqBG
X-Gm-Message-State: AOJu0YxFK/AB3ple6fBPQr+5xHWQR+FxM/c5p57lEqcKxSeIVZFU4rVA
	kIcGzTbCJbUR8MNlpmAdckBGxra9RJSEPzB5A+ln6w3iJTR+/4qyISSaB3jRHFQ=
X-Google-Smtp-Source: AGHT+IHTpPNGZHMBxVEasDQE0AcmPyQY0xs7GX9k/r2GQYi+8iF3qtVD7NFoq5OWftN6Pr8hgG4yLQ==
X-Received: by 2002:a17:90a:e501:b0:2bd:9256:8ce0 with SMTP id 98e67ed59e1d1-2bf5ea3c2f8mr13150409a91.14.1716974548681;
        Wed, 29 May 2024 02:22:28 -0700 (PDT)
Received: from localhost.localdomain ([103.14.255.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c033ce1d0bsm786090a91.19.2024.05.29.02.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 02:22:28 -0700 (PDT)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: rafael@kernel.org
Cc: chunjie.zhu@cloud.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix kdump kernel cannot find ACPI RSDP
Date: Wed, 29 May 2024 09:21:15 +0000
Message-Id: <20240529092115.375113-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0gcyZM7PZPrKccLhNtNDhHvqrZsgD-+Xx+W9WesD3yhyw@mail.gmail.com>
References: <CAJZ5v0gcyZM7PZPrKccLhNtNDhHvqrZsgD-+Xx+W9WesD3yhyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: "Rafael J. Wysocki" <rafael@kernel.org>
> Date: Mon, 27 May 2024 12:52:19 +0200
> Subject: Re: [PATCH] fix kdump kernel cannot find ACPI RSDP
> To: Chunjie Zhu <chunjie.zhu@cloud.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
> 	linux-kernel@vger.kernel.org
> 
> On Fri, May 24, 2024 at 11:43=E2=80=AFAM Chunjie Zhu <chunjie.zhu@cloud.com=
> > wrote:
> >
> > kexec/kdump must pass acpi_rsdp (physical address of ACPI RSDP table) to =
> the
> > crash kernel, especially in EFI case, otherwise, the crash kernel fails t=
> o
> > locate ACPI RSDP table. Consequently, ACPI init runs into error, and APIC
> > mmio read page fault happens, finally crash kernel gets stuck.
> 
> Fair enough.
> 
> So has this ever worked before?  Presumably it has, in which case it
> has regressed and so it would be prudent to say when it broke and why
> and explain why the proposed change is the right one to make.

The existing code works only if the kexec() system call (CONFIG_KEXEC) is
enabled, however, we can enter the kdump kernel by one of the following
methods,

	1. kexec_file system call (CONFIG_KEXEC_FILE)
	2. Xen-initiated crash

Instead of CONFIG_KEXEC, setup_acpi_rsdp should depend on CONFIG_KEXEC_CORE,
which should be enabled in any case where kernel is used as a kdump kernel.

> 
> > Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
> > ---
> >  drivers/acpi/osl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index f725813d0cce..39474468dba1 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -174,7 +174,7 @@ void acpi_os_vprintf(const char *fmt, va_list args)
> >  #endif
> >  }
> >
> > -#ifdef CONFIG_KEXEC
> > +#ifdef CONFIG_KEXEC_CORE
> >  static unsigned long acpi_rsdp;
> >  static int __init setup_acpi_rsdp(char *arg)
> >  {
> > @@ -187,7 +187,7 @@ acpi_physical_address __init acpi_os_get_root_pointer=
> (void)
> >  {
> >         acpi_physical_address pa;
> >
> > -#ifdef CONFIG_KEXEC
> > +#ifdef CONFIG_KEXEC_CORE
> >         /*
> >          * We may have been provided with an RSDP on the command line,
> >          * but if a malicious user has done so they may be pointing us
> > --
> > 2.34.1
> >
> 

