Return-Path: <linux-kernel+bounces-573551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211B1A6D8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EEA16DC32
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508925DD1E;
	Mon, 24 Mar 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qtZNJJNZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rEc6EP4K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E025DD19
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814915; cv=none; b=a6CsPwAgXsRNv8e3nry2f6LZoTZBK7/kBYwumDobYa1yofd1flW67SPnrLflHVcw5qVOkvyeYu0tNNjPP50wegfNxatrJSY5j9rGSk2o/M3XTI8HmK/LcBz4TTpcvcQVp8sZCRL8ACrW3G0vsU3VMtUZn1DT5CZgYZXifbvjB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814915; c=relaxed/simple;
	bh=hZ5GbCzl/Fw4XjbhusZchqQNyyvFLq+89EztqsUraO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GedREjDblyT18739HkWRQ4yRtGQj4+j6YO8UrPWY6HpakpV3NNTbuIVsvQsIYTKXmpJDYs7kwjJn/VGyW1ZX59Cq14IuUeXh1uB/gjuP+Eavnvz2Ir6wjcZ8iW47k10AdI8twmCdbt5+VItaOzR+JEdFlIPXwEnLDDHPzfbZ3+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qtZNJJNZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rEc6EP4K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Mar 2025 12:15:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742814911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86m/cLxXP9bfNs1Ln11D5y3dZxfnOk7qTOhdH9UMKxk=;
	b=qtZNJJNZ0xux8VOBm84Ls0CCUhvjW5xt0HKjoR8ebj71eSGy+VSwFogWGspDaUrgVC+79c
	wUP1mwAIqvH6Rpc2sDAIo+FSG7j0Ne2E75uaOOYjKIBAUvhiCofQbjrtdD0E3k+T++wQ87
	1DQPfFyNXb1WpWNlyC8xNailwbYRUhDGOf3mpmmBmUUTiGETZWmYkwB2JIFdu6yc5rIU+w
	j7zscMi/7J+KWhfOGDn8MvAG3vLvxF4MVvOhGOeIvWNqoxXkTWh9RwalVl/vrZ8y+x4X4g
	iatO+lIJD0/d/mNNv71r/oR6wiKZJAm6NOf12xwmNjqxjQ/zxMtgEukJz6NY2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742814911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86m/cLxXP9bfNs1Ln11D5y3dZxfnOk7qTOhdH9UMKxk=;
	b=rEc6EP4KLiJw5DPcwsIAdDU0oL1zCwm7e0CxHExT4ByjW2oe0vs1aRtV8jFwxu9OgXOAcT
	LbUhQgAmx3TKI1CQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev
Subject: Re: [PATCH v3 22/29] x86/cpu: Use consolidated leaf 0x2 descriptor
 table
Message-ID: <Z-E-vXHVl3dLFYx0@lx-t490>
References: <20250319122137.4004-23-darwi@linutronix.de>
 <202503241523.6b53646b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503241523.6b53646b-lkp@intel.com>

Hi,

On Mon, 24 Mar 2025, kernel test robot wrote:
>
> [ 5.001760][ T0] BUG: KASAN: stack-out-of-bounds in intel_detect_tlb (arch/x86/kernel/cpu/intel.c:698 arch/x86/kernel/cpu/intel.c:688)
> [    5.001760][    T0] Read of size 1 at addr ffffffff8a607e80 by task swapper/0/0
> [    5.001760][    T0]
> [    5.001760][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.14.0-rc5-00152-ge114ca069e27 #1
> [    5.001760][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    5.001760][    T0] Call Trace:
> [    5.001760][    T0]  <TASK>
> [ 5.001760][ T0] dump_stack_lvl (lib/dump_stack.c:124)
> [ 5.001760][ T0] print_address_description+0x2c/0x3f0
> [ 5.001760][ T0] ? intel_detect_tlb (arch/x86/kernel/cpu/intel.c:698 arch/x86/kernel/cpu/intel.c:688)
>

I've reproduced the KASAN report and below hunk fixes it:

 | --- a/arch/x86/include/asm/cpuid/leaf_0x2_api.h
 | +++ b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
 | @@ -88,9 +88,9 @@ static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
 |   *		}
 |   *	}
 |   */
 | -#define for_each_leaf_0x2_entry(regs, __ptr, entry)			\
 | -	for (__ptr = &(regs).desc[1], entry = &cpuid_0x2_table[*__ptr];	\
 | -	     __ptr < &(regs).desc[16];					\
 | -	     __ptr++, entry = &cpuid_0x2_table[*__ptr])
 | +#define for_each_leaf_0x2_entry(regs, __ptr, entry)				\
 | +	for (__ptr = &(regs).desc[1];						\
 | +	     __ptr < &(regs).desc[16] && (entry = &cpuid_0x2_table[*__ptr]);	\
 | +	     __ptr++)

I'll include the fix in v4.

(It also makes sense that this was triggered at x86/cpu intel.c and not
 x86/cacheinfo, since in cacheinfo.c, CPUID(4) when available is always
 preferred to CPUID(2).)

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

