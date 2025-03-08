Return-Path: <linux-kernel+bounces-552485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA43A57A4D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F33E3B276D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87721BEF90;
	Sat,  8 Mar 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="sdcOiWRh"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859A8BFF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741438735; cv=none; b=qDapUaUItjJmkNrdYEq9eGEKY6laY62hrqSAl9rGAdRnTSABZKMyTvw4ru77HW8LXTpYQmqginVj6lE1dTwYTkGwNBs3Cbsgb7FQMFMG+/j0c9tWmb7YRxx9MyIOjhHNPy68+jRZgSgS6w/5R3F4fkPePwwmy8v+VGX6USwRgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741438735; c=relaxed/simple;
	bh=pqRHaD0K95zvt04LXgJ9IAk+vY9xdxmc2+pPvcoJar8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bom+W5LQezkS4oYTU+psy/AtxSwpcnGNRaLzAgU1vj2hnl5ma9CArkWtkZHgDTkSblootTsFwy5QAOnhGsD5/+LA3NJnsMXH57LHOFtcgd6WSWAx5zXrHR9/ZPlG6EjdWQzqxcqDzxR8JupiRr2699tv/cQg1nyWCfCnB/fJ4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=sdcOiWRh; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <a081958f-0ae8-4b8b-b49f-81378f3c05a7@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741438729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1OfvKUB3yGmFTBmYKmHlndX8vBgO9snLZ4Ez7RHj2M=;
	b=sdcOiWRhA8YKwSSvH28gavOM/pAKtcK1NOjqOECLSCghy10BLInRpbL7DdBAQvhes+zDTB
	saEHyx00EVBMnaN1zM82rhYvwNepdPJAhCe8pDwXhxbo3Qi82DaOZjyxiokcmmExpvysmF
	jUKxwg0e0sxzHXKlMQIPLAYOUaGfIWoE0HzIPta4hTxnANepHy7tAMlbQD3yirdtmqA3Xu
	yMzgi8XuEOJRDu0xSiO6DJn28e5hTXTvm9eKkvFaRmVLrSG83ofr7HyDObpg998Yg2Q2ZM
	94zobioUlhlo+r5X/RZrzLfSJeMq5wYog+PDW44ecKRaMh2yWd6dptWtSb9oRQ==
Date: Sat, 8 Mar 2025 13:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] RISC-V CRC optimizations
To: Eric Biggers <ebiggers@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org,
 Zhihang Shao <zhihang.shao.iscas@gmail.com>, Ard Biesheuvel
 <ardb@kernel.org>, Xiao Wang <xiao.w.wang@intel.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, skhan@linuxfoundation.org
References: <20250216225530.306980-1-ebiggers@kernel.org>
 <20250224180614.GA11336@google.com>
 <87ikorl0r5.fsf@all.your.base.are.belong.to.us>
 <20250302220426.GC2079@quark.localdomain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <20250302220426.GC2079@quark.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello!

On 2/3/25 23:04, Eric Biggers wrote:
> So, quite positive results.  Though, the fact the msb-first CRCs are (still) so
> much slower than lsb-first ones indicates that be64_to_cpu() is super slow on
> RISC-V.  That seems to be caused by the rev8 instruction from Zbb not being
> used.  I wonder if there are any plans to make the endianness swap macros use
> rev8, or if I'm going to have to roll my own endianness swap in the CRC code.
> (I assume it would be fine for the CRC code to depend on both Zbb and Zbc.)

I saw this message the other day and started working on a patch, but I
would like to double-check I'm on the right track:

- be64_to_cpu ends up being __swab64 (include/uapi/linux/swab.h) 

If Zbb was part of the base ISA, turning CONFIG_ARCH_USE_BUILTIN_BSWAP 
would take care of the problem, but it is not the case. 

Therefore, we have to define __arch_swab<X> like some "arches"(?) do in 
arch/<ARCH>/include/uapi/asm/swab.h

For those functions to be correct in generic kernels, we would need to 
use ALTERNATIVE() macros like in arch/riscv/include/asm/bitops.h.
Would this be ok? I'm not sure if the ALTERNATIVEs overhead can be a
problem here.

Thanks in advance :)

