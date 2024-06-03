Return-Path: <linux-kernel+bounces-198551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBEA8D7A23
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04B11F21633
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA51CA7D;
	Mon,  3 Jun 2024 02:45:59 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B85250
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382758; cv=none; b=eyAbT7Agyb8rCI/yXIP2C7fgzeAyfS2j0bbVnbn7f8u6g35MSLnK0jKdkw0jd1yIyX737ZwbB9n4W0skc3dh2I7XSR/5iuahkZGwlJmx4mPbz0IZTZWFtwv5+IF6pQcezuP7qTsY9drUDDYhPziyzoyXHX/VUVA2Q8vBmtFkBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382758; c=relaxed/simple;
	bh=WwGcRP6mCBmbf/YWltCakJ7KiVVOy2rpd5H+yMpxcZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pfglr3eVz5QwfTvK6kNefHP1VibfxwgjyVZi0E5Xonh/P5OQcZ+ifFFd0fj71Xhf+fQIE4kr1jC1hS1jH6rtvqgxoNf4ysx6vitRHBrFk2sayiisKToRLkUUlwmFfqLS4/ZIrM9YJrWsUdKchEDR0bEShab3HP8YfcpN2QIohEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VsylP5N6Nz4x12;
	Mon,  3 Jun 2024 12:45:53 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Samuel Holland <samuel.holland@sifive.com>
Cc: kernel test robot <lkp@intel.com>, Guenter Roeck <linux@roeck-us.net>, Andrew Morton <akpm@linux-foundation.org>, Christian König <christian.koenig@amd.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240529162852.1209-1-samuel.holland@sifive.com>
References: <20240529162852.1209-1-samuel.holland@sifive.com>
Subject: Re: [PATCH] powerpc: Limit ARCH_HAS_KERNEL_FPU_SUPPORT to PPC64
Message-Id: <171738271138.1517513.7328136672025419201.b4-ty@ellerman.id.au>
Date: Mon, 03 Jun 2024 12:45:11 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 09:28:50 -0700, Samuel Holland wrote:
> When building a 32-bit kernel, some toolchains do not allow mixing soft
> float and hard float object files:
> 
>     LD      vmlinux.o
>   powerpc64le-unknown-linux-musl-ld: lib/test_fpu_impl.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
>   powerpc64le-unknown-linux-musl-ld: failed to merge target specific data of file lib/test_fpu_impl.o
>   make[2]: *** [scripts/Makefile.vmlinux_o:62: vmlinux.o] Error 1
>   make[1]: *** [Makefile:1152: vmlinux_o] Error 2
>   make: *** [Makefile:240: __sub-make] Error 2
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Limit ARCH_HAS_KERNEL_FPU_SUPPORT to PPC64
      https://git.kernel.org/powerpc/c/be2fc65d66e0406cc9d39d40becaecdf4ee765f3

cheers

