Return-Path: <linux-kernel+bounces-284536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EEE950212
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C882880CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF518A6B0;
	Tue, 13 Aug 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k7Cn0Ent";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jGwoRd/b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562E1607B9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543637; cv=none; b=pN1g4DU6RrXz/9+NkDK6aJIu0pAj5ctcf1k6DfIIKgvukYMyfv6ujZq2NMtucW3ut0uI7381uGIH444S1aNtd/nwVTjgQ23Fn5WJKSMPiDs7vS1S+GW2pFw3rt3G349cF3+WxEn2vstbhd39wndOoLEOO8G1WZTqqxT8+bxXlUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543637; c=relaxed/simple;
	bh=u9HaPF8Uk8LrAzH5hHjLoT6HdF8749RKz6Q/E86yhig=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=GxuIGQ3ajMhltcx8gOSvpCtDpaO9c49Su5iwOsRNaIbJIvSHY4VQi8fz3ogk1aDdvL8vMAqBXu8IsaQoYLcONIo6Qmxv9S2uzAOWthprDwxsfGokt+tadiXLokv2jhliiksEvqOtzoloNRkoW6pxJE/ljmQpdh+kFXy+bAffiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k7Cn0Ent; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jGwoRd/b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723543634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=oeOtyK5/Y72NdqGomahwoazRlA8zY1bqlmyUbtEjdrA=;
	b=k7Cn0EntSSkpolYv7M8iXevkrFcRHV/b1psZ4NYECrPYJ2AOZiSQpDHPCRZ3XvGrx1ogP4
	C2+deT/di8RYNLCzCW1uOZqxNNUP1qu7/GW27LEa3iNmDl2l/n6acE1yO+8MNOp6VIiR0P
	F0koucQaec8AcRqMulnJnJ07SmboWsMtQR3daJPghqrJEavvVVx3GgRx794rKMM86Cff79
	HH5zOAagf3OWDrBrojDgxRy3vfQdw3lWrTq3iOGX7FSspRypI9Rc9pbaTciUji2xaygMQQ
	42WYiD/IBPX5hhdqQ/MwOpop6yAsgtLHyQ7i6Oqy522aIbRQiLdkfMpyP2N0WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723543634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=oeOtyK5/Y72NdqGomahwoazRlA8zY1bqlmyUbtEjdrA=;
	b=jGwoRd/bsF1ccXE1DPZsYdHQu9h9H6pLkaJQ6S4G+Ju659u2pNmJLMfb9/5uA42PwwNjJj
	U9VmqlTeOZ83MmBA==
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
 andrew.cooper3@citrix.com, nik.borisov@suse.com,
 houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v2 0/3] Enable FRED earlier
In-Reply-To: <20240709154048.3543361-1-xin@zytor.com>
Date: Tue, 13 Aug 2024 12:07:13 +0200
Message-ID: <87a5hgrb1q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 09 2024 at 08:40, Xin Li wrote:
> Wenlong Hou from Ant group reported two problems during the FRED
> initialization:
> https://lore.kernel.org/lkml/cover.1718972598.git.houwenlong.hwl@antgroup.com/
>
> The first problem is that spurious_interrupt() gets called on the
> HYPERVISOR_CALLBACK_VECTOR vector.  Because kvm_guest_init(), being
> executed way before trap_init() in which it is decided that whether
> FRED will be enabled or not, calls sysvec_install() to install
> HYPERVISOR_CALLBACK_VECTOR's interrupt handler into FRED system
> vector dispatch table or IDT depending on whether FRED is enabled.
>
> The other problem is that the #PF handler gets a wrong faulting
> address from the stack instead of CR2 before FRED is enabled.
> Because the #PF handler fetches its faulting addresss from the
> stack or CR2 based on whether FRED is available rather than active.
>
> This patchset fixes the 2 problems with suggestions from tglx:
>
>   1) Parse cmdline param "fred=" in cpu_parse_early_param() to
>      minimize the gap mentioned above, before kvm_guest_init().
>
>   2) Enable FRED right after init_mem_mapping() to switch to FRED
>      from early IDT ASAP, avoid intermediately using the IDT #PF
>      handler.

I just noticed that there is another leftover regarding FRED:

arch/x86/kernel/cpu/cpuid-deps.c:86: { X86_FEATURE_FRED, X86_FEATURE_WRMSRNS },

We removed the dependency on X86_FEATURE_WRMSRNS, right? So this is
stale and should be removed too.

Thanks,

        tglx

