Return-Path: <linux-kernel+bounces-386956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7F29B4A26
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A1E1C2281C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3BA204927;
	Tue, 29 Oct 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNogKg6t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2F8F6E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206224; cv=none; b=FR2cPY4nBylWmiYLik0SlmqW4rOnA45J1o5HJS7Tltq1mVF6aTPoK2VzsbB1x0FC6t23z4+ghIcy7rOmQWNuZwyL+txT7bkSiMnSiiwCeCDBa5ZXUMOe2td/yU7ec1SYmqs88ws/Dp/kmkrYoPToHB3KY2/He1DL6BOVAwMEbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206224; c=relaxed/simple;
	bh=qpqKiCVwGj7SngGYaK80lZw41JwmB+AhSP70a/Xdq1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4ZBdeeW2Ps6It2OhQascEk5/+8C0pxoq8CAzGWt8a/LsIUv0WdAeRuh2KRMfEF5mJQwxQz+B+uoEGuZZbhqOaRij37TUvIPG1rEVJv/Cld95wuZHhLyIeY1u5EyWepO/qdXD9OELvzjACqlQZtk1jKc9zYW61QfGVS7KPQXR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNogKg6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA46C4CEE5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206223;
	bh=qpqKiCVwGj7SngGYaK80lZw41JwmB+AhSP70a/Xdq1E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CNogKg6tqY6sYLa0yTfsV5VM6EVLVTHwA1XFvDsJBdjbefzq6skxJ2WRC8h5F/ZPN
	 wgnZnZQ+atgQhNinzsM/BjTs64o5NG9aYccpy2M/gVvSPGWys7inlm3bQjtkNIF8Rv
	 f28N24sPOhuixaI4XoricXRxRM+Ry4NHkSCcJ9W4W277irpfVL7H76HqAdvdorKQTy
	 L0XV8KPLxvoqaIlo0lmAAqHwdl7MQ9HwIdZNnkzqcElJkRuDHPtZFY8qt9lBVPxjBd
	 CkgtcqqdCO8j00EDtB0yTB5SMmjnoBj+nwQjZ5nKOm/UmV8yx8ETrcDGXIvPXtHkCt
	 OBa+cUmjZWkNQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so54127301fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:50:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YwMYB8fApOza9DtMDciVOBWEGjWab3jUvHJdp2vxDHEqQRTCt14
	NGRhY7xMRpz1BY6BnwMbR3NdMgQMdx36K2PQoYKyD4fYfcBCfZpn1pW/KJDBjMozvfOGkgJNYTI
	AE3fm+Trjz6/1ammu58qRcrYJkHc=
X-Google-Smtp-Source: AGHT+IE13vCSXiGikajW15oEuXQauuOovUNSx/7h82mtO6lP6mJ0KIW1b6Z6Cr+GGo7IZepi0dmFbUBD16EkW4eCRpY=
X-Received: by 2002:a05:651c:2204:b0:2fb:6057:e67e with SMTP id
 38308e7fff4ca-2fcbe08cdc1mr50995891fa.32.1730206222187; Tue, 29 Oct 2024
 05:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009160438.3884381-7-ardb+git@google.com>
In-Reply-To: <20241009160438.3884381-7-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 29 Oct 2024 13:50:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHzahaLRH_0nSQaS7L+so0WRwh4R6SLdb1R+Hm3s-o1dA@mail.gmail.com>
Message-ID: <CAMj1kXHzahaLRH_0nSQaS7L+so0WRwh4R6SLdb1R+Hm3s-o1dA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] x86/xen: Drop absolute references from startup code
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 18:09, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> This series was broken out of the series I sent recently [0], after
> Jason pointed out that my Xen startup code changes conflict with his
> changes to make the PVH startup code position independent.
>
> Jason's work reduces the delta of my changes, and given that my other
> series will likely advance at a much slower pace, the Xen changes are
> presented here so they can be merged independently.
>
> The end result after applying this series (see below) is that there are
> no longer any Xen-related absolute relocations that need to be applied
> to .head.text, a section which carries code that may be invoked from the
> 1:1 mapping of memory before the kernel virtual mapping is up.  The use
> of absolute references in this code section has resulted in a few boot
> issues that were very hard to track down (Clang built kernels running
> under SEV-SNP in particular, which does not provide the best debug
> experience).
>
> Even though the occurrences in the Xen startup code were fine, there is
> now a lot of C code emitted into .head.text as well, and so it would be
> helpful to teach objtool to reject absolute references entirely in this
> section (or rely on the linker for that). Therefore, not relying on them
> in the first place is a step towards that goal.
>
> Changes since v2 [2]:
> - add Jason's Tested-by to patch #4
> - use a better name for the linker defined symbols used in the ELF notes
>   (patch #4)
> - add a comment in the linker script explaining why the symbol values
>   are constructed in the way they are
> - rebase onto v6.12-rc2
>
> Changes since v1 [1]:
> - add Jason's Rb to patches #2, #3 and #5
> - drop the use of a 32-bit field for the ELF note- QEMU reads a u64 and
>   so the top word needs to remain 0x0
> - tweak #ifdefs in patch #4 so the hypercall_page linker symbol does not
>   depend on CONFIG_XEN_PV
> - rebase onto v6.12-rc1
>
> Changes wrt [0]:
> - add Jason's Rb to patch #1
> - rebase onto xen/tip's linux-next branch
> - split out fix for GDT descriptor size field
> - add patch to remove the zeroing of phys_base, which is no longer
>   needed
> - use a 32-bit field for XEN_ELFNOTE_PHYS32_ENTRY, and use its contents
>   to obtain the build time physical address of pvh_startup_xen()
>
> [0] https://lore.kernel.org/all/20240925150059.3955569-30-ardb+git@google.com
> [1] https://lore.kernel.org/all/20240926104113.80146-7-ardb+git@google.com/
> [2] https://lore.kernel.org/all/20240930071513.909462-7-ardb+git@google.com/
>
> Relocation section '.rela.head.text' at offset 0xb428 contains 15 entries:
>   Offset          Info           Type           Sym. Value    Sym. Name + Addend
> 000000000018  000800000002 R_X86_64_PC32     0000000000000000 .init.data + 18
> 00000000002f  000e00000002 R_X86_64_PC32     0000000000000000 pvh_start_info + 2f
> 000000000037  000f00000002 R_X86_64_PC32     0000000000000000 pvh_start_info_sz + 37
> 000000000042  000800000002 R_X86_64_PC32     0000000000000000 .init.data + 4092
> 000000000060  001000000002 R_X86_64_PC32     000000000000002c xen_elfnote_phys3[...] + 60
> 000000000068  001100000002 R_X86_64_PC32     0000000000000000 phys_base + 68
> 00000000006e  001200000002 R_X86_64_PC32     0000000000005000 pvh_init_top_pgt + 6e
> 000000000089  001300000002 R_X86_64_PC32     0000000000006000 pvh_level3_ident_pgt + 89
> 000000000091  001400000002 R_X86_64_PC32     0000000000008000 pvh_level3_kernel_pgt + 91
> 0000000000a3  001500000002 R_X86_64_PC32     0000000000009000 pvh_level2_kernel_pgt + a3
> 0000000000be  001200000002 R_X86_64_PC32     0000000000005000 pvh_init_top_pgt + be
> 0000000000de  000800000002 R_X86_64_PC32     0000000000000000 .init.data + 1c
> 0000000000e9  001600000002 R_X86_64_PC32     0000000000000000 xen_prepare_pvh - 4
> 0000000000f8  001700000002 R_X86_64_PC32     0000000000000000 pvh_bootparams - 4
> 0000000000fd  001800000004 R_X86_64_PLT32    0000000000000000 startup_64 - 4
>
> Relocation section '.rela.note.Xen' at offset 0xb668 contains 1 entry:
>   Offset          Info           Type           Sym. Value    Sym. Name + Addend
> 00000000002c  001a00000002 R_X86_64_PC32     0000000000000000 xen_elfnote_phys3[...] + 0
>
> Cc: Jason Andryuk <jason.andryuk@amd.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: x86@kernel.org
> Cc: xen-devel@lists.xenproject.org
>

Ping?

