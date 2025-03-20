Return-Path: <linux-kernel+bounces-569656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DEA6A5B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6BC1887C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB3021D5A6;
	Thu, 20 Mar 2025 12:00:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8519F21D581
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472003; cv=none; b=aNE3VHGR/0JXaxC5Sb2IfHnRLkHA+yVMTPTKhAnM6xf7aCO7sdsULUn2tbFD7lzc3Z8Qd+T+5rMqk6sf4OOojpbutXIhNF3EsVlmuUyzN341sdB4Xxd6979qHB/pVScxcJ1CWti1aSW3YlsRuaBxVJS2TPHBQkrh9cCk+Rp/IAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472003; c=relaxed/simple;
	bh=PStqZjhIP7YBTl7FChlnJ2YLpQT/+dBrheYhiEeXbaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzLbKjs1Pvr5EqByfKzyhxSjiVtmRVmsVGrQINh/VHVqVCa4YLf5mbM8v5HGdCvc5QtkF6ej7LHDwg6pUdxOZa9KpSTf9MmYyS1iXkFQxMHaVh9327Hxan30Lg35Jtb9ovXs4m8iexHj7SE6Qi51DlvMiNgnLBK7EHvsJIwLmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70BA4106F;
	Thu, 20 Mar 2025 05:00:08 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3943F673;
	Thu, 20 Mar 2025 04:59:59 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:59:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: stable-rc: Fast model boot fail Internal error Oops BTI -
 kernfs_iop_permission
Message-ID: <Z9wDOguDLJ17juz2@J2N7QTR9R3.cambridge.arm.com>
References: <CA+G9fYtucEt8Hp6RsV0o+OWSz1E=hXBvhHa-P9C-bPnb7cyGaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtucEt8Hp6RsV0o+OWSz1E=hXBvhHa-P9C-bPnb7cyGaQ@mail.gmail.com>

On Thu, Mar 20, 2025 at 04:05:14PM +0530, Naresh Kamboju wrote:
> Regressions on arm64 Fast model (FVP-aemva) boot failed with stable-rc 6.13.
> 
> First seen on the stable-rc 6.13.8-rc1
>  Good: v6.13.8
>  Bad:  6.13.8-rc1 (v6.13.7-242-g14de9a7d510f)

That "Good" tag doesn't look right. Is that meant to be v6.13.7?

AFAICT there is no v6.13.8 tag yet.

> Regressions found on FVP:
>  - boot
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducible? Yes

Can you bisect this?

> Boot regression: Fast model boot fail Internal error Oops BTI
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> NOTE:
>   LKFT is currently running FVP Fast Models version 11.24.
>   Planned upgrade to the Fast Models version 11.28 in this sprint.
> 
> ## Boot log
> [   12.812790] Internal error: Oops - BTI: 0000000036000002 [#1] PREEMPT SMP
> [   12.812886] Modules linked in: drm fuse backlight ip_tables x_tables
> [   12.813120] CPU: 6 UID: 0 PID: 136 Comm: udevadm Not tainted 6.13.8-rc1 #1
> [   12.813245] Hardware name: FVP Base RevC (DT)
> [   12.813317] pstate: 163402809 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=-c)
> [   12.813450] pc : kernfs_iop_permission+0x4/0xe4
> [   12.813585] lr : inode_permission+0xb8/0x174

This is one instruction into kernfs_iop_permission(), which suggests
that either the caller has branched to a corrupted address, or somehow
the model has skipped the BTI.

> [   12.813728] sp : ffff800080d63bb0
> [   12.813796] x29: ffff800080d63bc0 x28: 0000000000002e2e x27: 00000000fffffff6
> [   12.813978] x26: 0000000000000030 x25: 2f2f2f2f2f2f2f2f x24: 61c8864680b583eb
> [   12.814161] x23: 0000000000000000 x22: fefefefefefefeff x21: ffffa991682c84b8
> [   12.814344] x20: ffff0008006704d0 x19: 0000000000000001 x18: 00000000fffffffb
> [   12.814525] x17: ffff000801bf8021 x16: e0acaabd2f000000 x15: ffffffffff000000
> [   12.814711] x14: 0000000000000002 x13: ffffffffffffffff x12: 0000002e00000000
> [   12.814893] x11: 0000002d00000000 x10: 0000002d00000000 x9 : ffff0008006704d0
> [   12.815076] x8 : ffffa991665f0ff8 x7 : 0000000000000000 x6 : 0000000000000000
> [   12.815253] x5 : 0000000000000000 x4 : 0000000000004050 x3 : 2f7375622f737973
> [   12.815432] x2 : 0000000000000001 x1 : ffff0008006704d0 x0 : ffffa991682c84b8
> [   12.815613] Call trace:
> [   12.815670]  kernfs_iop_permission+0x4/0xe4 (P)
> [   12.815830]  link_path_walk+0x2b8/0x388
> [   12.815962]  path_lookupat+0x68/0x120
> [   12.816073]  filename_lookup+0xe0/0x1e0
> [   12.816196]  do_readlinkat+0x6c/0x1d8
> [   12.816337]  __arm64_sys_readlinkat+0x20/0x30
> [   12.816481]  invoke_syscall+0x40/0xf8
> [   12.816623]  el0_svc_common+0xa8/0xd8
> [   12.816765]  do_el0_svc+0x1c/0x28
> [   12.816904]  el0_svc+0x38/0x68
> [   12.817050]  el0t_64_sync_handler+0x78/0x108
> [   12.817203]  el0t_64_sync+0x198/0x19c
> [   12.817359] Code: a8c27bfd d50323bf d65f03c0 d503245f (373806c2)
                                                  ^^^^^^^^
						  BTI C

As we can see here, there's a BTI C immediately beafore the instruction
that triggers the BTI exception, so as above either the call has branch
to a bogus address or the model has somehow skipepd the BTI.

Assuming there isn't a model bug, this is likely to be either a bug in
inode_permission(), or some sort of memory corruption.

Mark.

> [   12.817444] ---[ end trace 0000000000000000 ]---
> 
> 
> ## Source
> * Kernel version: 6.13.8-rc1
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> * Git sha: 14de9a7d510fcfb3bd35e275eda09724bda4d440
> * Git describe: v6.13.7-242-g14de9a7d510f
> * Project details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-242-g14de9a7d510f/
> 
> ## Build
> * Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-242-g14de9a7d510f/testrun/27684866/suite/boot/test/clang-20-lkftconfig-no-kselftest-frag/log
> * Build history:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-242-g14de9a7d510f/testrun/27684866/suite/boot/test/clang-20-lkftconfig-no-kselftest-frag/history/
> * Build details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-242-g14de9a7d510f/testrun/27684866/suite/boot/test/clang-20-lkftconfig-no-kselftest-frag/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uXZoz8Lc7Ue3i4mVWAM8Y800oz/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2uXZoz8Lc7Ue3i4mVWAM8Y800oz/config
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

