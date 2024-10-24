Return-Path: <linux-kernel+bounces-379812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F99AE418
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9767C1F2474B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9D1D31AF;
	Thu, 24 Oct 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HnS2WQG8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218051D0171
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770326; cv=none; b=VxpQNqfUzHg7tByHQSCnT/8rQ9lIWkmjzZwhUigTzGvwSsec0AYgUHAQFhlj8KBqs99+G9wjU6h3KQWmkb2zE1lgLT23xPZ2MBph082gPJ8K9HsG5N1M7u94B43x2fQw6biRe34kHW9siDxXgtA12gYNHA9KN2OGkiaC69ZB3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770326; c=relaxed/simple;
	bh=YV4I2QVaqnBO2IW3pvFq8nhSSCGuatOd5xz1HRAVSjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BN6FqOU4suBb6p5hx2qFPI2zuAbhFEeBbawftDF9Cs0BUVG7oKOIcm6q4EsKb7pFCSSoTe8hg5BQxozFWXsmMewZTx0eydW7YEYoH5WUDfooq+G0/vqEXF4dGeJ91brKkip1EFnVF2a8YaeDJiULs4c2ZEbTIjlZhziSt0URC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HnS2WQG8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso901195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729770322; x=1730375122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CL2wCU2HH+fd4vHOU7eIexO99AmYoDs4dDo7720ek4=;
        b=HnS2WQG812yBB2XGmiTi+3NsW+KjsUCC7uZ/HzgntN2w4kT29Dxd9B9RyJcjNXFVf4
         sVE53drdgyHSCrli0DC1PkBX/hypn8ARmrmfaCml9eZTkdJIp76rHG4XipDSS5NUJknd
         Fvd+LdYDG65Enm1YibQh07KhQINOx9MrSeC83C9Rk52W/VH9FPXvMhpXiE5CTzaymaE4
         vQkp366b3C6snoIFRTNaJYfvvnMDhnOJ1PGkJ9Y8lTCZ1TqccATfcxSkosvACNXHfPl/
         29A4Y3aVqyNQrgRpADrRZsxj7sc9WY7ITxG/PVMvIe8a8K92niy0MK1qHkLAm0LnpaGL
         zxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729770322; x=1730375122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CL2wCU2HH+fd4vHOU7eIexO99AmYoDs4dDo7720ek4=;
        b=ZJgvOIOyjpLz7d5rMTdqwL6n/kOhMgRRC/ceJRGuiZtF0r3sriceaIn40+mwzfkXCx
         IkmOS8/Y6AB3xgGHhDQh8uRIHx+M0VgEhslGxs2NDG2A9F4fA69lAnI9niNX4sc1HVrp
         ZMQQ6wh4s0B5aswwNAaYEXRS1GnDyHHT33BjyfD5gZyATKkHjI1vLR4adP2eqzZLziRX
         jz/hAhyDygGgRtWgbn36KLpQHfeWglgLUyPL/fsOkdhWUp+0u8PwvMNdEOk8WPa/rqJR
         kAMcOWC7TME1f2WZH+R6adxVd7hXUNJSx7hijRvPGMFgDhNEzisl7yHohM7GCNknWaSx
         ou3g==
X-Forwarded-Encrypted: i=1; AJvYcCVrpye9LvrMWpy7ezoSsWF8ZkKmKVdmoFjZNctWFiZY0V/2lTqaSxLey9ee6jtbaVqURCJZPjq9cRsRbBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylpwfocr5cRPOVPCg5ksdX6/JXeqULzC0LThOdcw4Pm5C7fg4/
	FYyeDx+BUj9Qs+gRxIFuV5W9y7LMOMKcWrDah+FVI19zBuBRr4MTEc6nG1jU5j4=
X-Google-Smtp-Source: AGHT+IFA4GABsskGJAvhBVgwpM0Becu10rrF1/mPcNcESTyA5925ZJdl1RcPGWOTLM6OI2YjfLoBKg==
X-Received: by 2002:a05:600c:4f91:b0:42c:c0d8:bf49 with SMTP id 5b1f17b1804b1-4318408b98bmr20665275e9.0.1729770322153;
        Thu, 24 Oct 2024 04:45:22 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186be531esm42591215e9.18.2024.10.24.04.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:45:21 -0700 (PDT)
Date: Thu, 24 Oct 2024 13:45:19 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Thomas Tai <thomas.tai@oracle.com>, Andrew Morton
 <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, Greg
 Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241024134519.18ed4657@mordecai.tesarici.cz>
In-Reply-To: <df753b4a-0cf1-4544-b073-0ebf2bb71ef2@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
	<fed3b427-a600-4ce5-afef-4ccbfff64931@oracle.com>
	<df753b4a-0cf1-4544-b073-0ebf2bb71ef2@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 11:48:55 +0100
Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 23/10/2024 22:00, Thomas Tai wrote:
> >=20
> > On 10/17/2024 8:32 AM, Ryan Roberts wrote: =20
> >> On 17/10/2024 13:27, Petr Tesarik wrote: =20
> >>> On Mon, 14 Oct 2024 11:55:11 +0100
> >>> Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>> =20
> >>>> [...]
> >>>> The series is arranged as follows:
> >>>>
> >>>> =C2=A0=C2=A0 - patch 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Add macr=
os required for converting non-arch code to support
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 boot-time page size selection
> >>>> =C2=A0=C2=A0 - patches 2-36:=C2=A0 Remove PAGE_SIZE compile-time con=
stant assumption from all
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 non-arch code =20
> >>> I have just tried to recompile the openSUSE kernel with these patches
> >>> applied, and I'm running into this:
> >>>
> >>> =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/arm64/hyperv/hv_co=
re.o
> >>> In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
> >>> ../include/linux/hyperv.h:158:5: error: variably modified =E2=80=98re=
served2=E2=80=99 at file
> >>> scope
> >>> =C2=A0=C2=A0 u8 reserved2[PAGE_SIZE - 68];
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~
> >>>
> >>> It looks like one more place which needs a patch, right? =20
> >> As mentioned in the cover letter, so far I've only converted enough to=
 get the
> >> defconfig *image* building (i.e. no modules). If you are compiling a d=
ifferent
> >> config or compiling the modules for defconfig, you will likely run int=
o these
> >> types of issues. =20
> >=20
> > It would be nice if you could provide the defconfig you are using; I al=
so ran
> > into build issues when using the arch/arm64/configs/defconfig. =20
>=20
> git clean -xdfq
> make defconfig
>=20
> # Set CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> ./scripts/config --disable CONFIG_ARM64_4K_PAGES
> ./scripts/config --disable CONFIG_ARM64_16K_PAGES
> ./scripts/config --disable CONFIG_ARM64_64K_PAGES
> ./scripts/config --disable CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> ./scripts/config --enable CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>=20
> # Set ARM64_VA_BITS_48
> ./scripts/config --disable ARM64_VA_BITS_36
> ./scripts/config --disable ARM64_VA_BITS_39
> ./scripts/config --disable ARM64_VA_BITS_42
> ./scripts/config --disable ARM64_VA_BITS_47
> ./scripts/config --disable ARM64_VA_BITS_48
> ./scripts/config --disable ARM64_VA_BITS_52
> ./scripts/config --enable ARM64_VA_BITS_48
>=20
> # Optional: filesystems known to compile with boot-time page size
> ./scripts/config --enable CONFIG_SQUASHFS_LZ4
> ./scripts/config --enable CONFIG_SQUASHFS_LZO
> ./scripts/config --enable CONFIG_SQUASHFS_XZ
> ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
> ./scripts/config --enable CONFIG_XFS_FS
>=20
> # Optional: trace stuff known to compile with boot-time page size
> ./scripts/config --enable CONFIG_FTRACE
> ./scripts/config --enable CONFIG_FUNCTION_TRACER
> ./scripts/config --enable CONFIG_KPROBES
> ./scripts/config --enable CONFIG_HIST_TRIGGERS
> ./scripts/config --enable CONFIG_FTRACE_SYSCALLS
>=20
> # Optional: misc mm stuff known to compile with boot-time page size
> ./scripts/config --enable CONFIG_PTDUMP_DEBUGFS
> ./scripts/config --enable CONFIG_READ_ONLY_THP_FOR_FS
> ./scripts/config --enable CONFIG_USERFAULTFD
>=20
> # Optional: mm debug stuff known compile with boot-time page size
> ./scripts/config --enable CONFIG_DEBUG_VM
> ./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
> ./scripts/config --enable CONFIG_DEBUG_VM_RB
> ./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
> ./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK_ENFORCED
>=20
> make olddefconfig
> make -s -j`nproc` Image
>=20
> So I'm explicitly only building and booting the kernel image, not the mod=
ules.
> The kernel image contains all the drivers needed to get a VM up and runni=
ng
> under QEMU/KVM.

FWIW with the attached patch I was also able to boot the kernel on
Ampere Altra bare metal and using modules.

Petr T

diff --git a/arch/arm64/mm/pgtable-geometry.c b/arch/arm64/mm/pgtable-geome=
try.c
index ba50637f1e9d..4eb074b99654 100644
--- a/arch/arm64/mm/pgtable-geometry.c
+++ b/arch/arm64/mm/pgtable-geometry.c
@@ -15,8 +15,14 @@
  */
=20
 int ptg_page_shift __read_mostly;
+EXPORT_SYMBOL_GPL(ptg_page_shift);
+
 int ptg_pmd_shift __read_mostly;
+EXPORT_SYMBOL_GPL(ptg_pmd_shift);
+
 int ptg_pud_shift __read_mostly;
+EXPORT_SYMBOL_GPL(ptg_pud_shift);
+
 int ptg_p4d_shift __read_mostly;
 int ptg_pgdir_shift __read_mostly;
 int ptg_cont_pte_shift __read_mostly;

