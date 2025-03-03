Return-Path: <linux-kernel+bounces-544457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6784A4E171
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3A7178006
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4EA276046;
	Tue,  4 Mar 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p4SoJfID"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEF25D522
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098936; cv=pass; b=HxQSgU4dglUn5QzJkrR6W0IWLnuQ4YKhsFeeKLxjcRD8iSP0QfweGF7lgCzHAg0VI59f7K3jzPRn63zB2de/7lX5B9ekZOSM7ZQ46XajYq173BWpFikZMtuuRs0Rnl9iHq1yM2z97RHALNCnLN7mj0coZHQbOi8uVdXd5RRqCOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098936; c=relaxed/simple;
	bh=anrVdYlvp+vutF77M+oNBrnX/luGXvKRsTQJKbdwgXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiYhI/eu8UqkyFfPbjLlSs+P2CKsWpBFSVH9W/tq/pLtcM+CQeAILWKThR4Edgr5DlINOoeL56uFV/Gj6WDUAU1LLAmGCL/FjA61o5a811m1XwDLJT7Btssldgsf6OqO8PbCU47iXoiOBhwrMMGdPQ+B4PI87ajGut5gO+wMXQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p4SoJfID; arc=none smtp.client-ip=90.155.92.199; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id E1F3C40CF12A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:35:32 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=p4SoJfID
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dRj3mJlzFwtf
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:32:01 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 66CCD42729; Tue,  4 Mar 2025 17:31:55 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p4SoJfID
X-Envelope-From: <linux-kernel+bounces-541266-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p4SoJfID
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 1B14A41E94
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:25:32 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 5B60E2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:25:31 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F627A5A72
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCF51F0E3A;
	Mon,  3 Mar 2025 09:25:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5941F12E7;
	Mon,  3 Mar 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993904; cv=none; b=Oei4ixUk4gyWY78cDP68Kz56AUkvguN2KTg1mOowp2G9vMsb8Q8Qd4r238cnho1qPWd7e6Ga1qNLmYvuWWAU63dGgoh86XVWsjOIKhsdXVME5sNfrNLgi8l4fBIUlVYdl/EDns1TCYfgZTWcxo4tQdzRR4LU0rFWminhnlm83d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993904; c=relaxed/simple;
	bh=anrVdYlvp+vutF77M+oNBrnX/luGXvKRsTQJKbdwgXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nod9g1i3kcKbUIzThnlVJ0cX39c5d2OXA1x5ErnvN/NADA7wsJRLqZLg9BiR+miGVheMv9wb2bYCQBQwR+QA0WOrFW6O1ugQdaQpXto5R3gBr070dqiLdMKHXcFuTxvJ2KIawUnqXJz0GhIo89wiA9hC8kM5Bf+MEKRqOo/WyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p4SoJfID; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vzlWwoYxaOsW2jKVbAk8xYIOxalJ85AZ7FYYDeZecek=; b=p4SoJfIDMgnfsHECQWncTbzWJf
	tHz8k1bZxPYtEtUzeMhqdI++F75l0/DlIRW00IoIoCe08qrQA2lJr/qVAsuZumhuKHglIPwPCfPyh
	CH+MFKGl57g4wZIF+IYhWj5aF9oGyFKNhcHxBTVvWvwlSb8gEuUnkgEd7xQSAnGyL4nF9AxuyX865
	vU3vchbEmgWsMrlBRCt6mk205kA1+qOJ45m9yQSd6vMRv0AQC5dK1iLK4Gm5G/yWpDMp1VEQi66Wu
	dqWuhkIdBuD+FJOKUxFcT+5r/7CE7JGUF8GoFbAG4GeuQREZdgTk4/gGotvwXl+W9ZGboQNb9w7uY
	Q2vqDgeA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp22m-00000004Wrl-0mFb;
	Mon, 03 Mar 2025 09:25:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BE6B930049D; Mon,  3 Mar 2025 10:24:59 +0100 (CET)
Date: Mon, 3 Mar 2025 10:24:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [tip:x86/core 16/17] vmlinux.o: warning: objtool: do_jit+0x276:
 relocation to !ENDBR: .noinstr.text+0x6a60
Message-ID: <20250303092459.GI5880@noisy.programming.kicks-ass.net>
References: <202503030704.H9KFysNS-lkp@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503030704.H9KFysNS-lkp@intel.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dRj3mJlzFwtf
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703609.72619@CjW8aVlEJU9H85Q01h0PdQ
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 07:47:57AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> head:   dfebe7362f6f461d771cdb9ac2c5172a4721f064
> commit: 0c92385dc05ee9637c04372ea95a11bbf6e010ff [16/17] x86/ibt: Implement FineIBT-BHI mitigation
> config: x86_64-randconfig-071-20250303 (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60

Thanks, below seems to cure it for me.

---
Subject: x86/ibt: Make cfi_bhi a constant for FINEIBT_BHI=n
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Mar 3 10:21:47 CET 2025

Robot yielded a .config that tripped:

  vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60

This is the result of using __bhi_args[1] in unreachable code; make
sure the compiler is able to determine this is unreachable and trigger
DCE.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cfi.h    |    5 +++++
 arch/x86/kernel/alternative.c |    3 +++
 2 files changed, 8 insertions(+)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -100,7 +100,12 @@ enum cfi_mode {
 };
 
 extern enum cfi_mode cfi_mode;
+
+#ifdef CONFIG_FINEIBT_BHI
 extern bool cfi_bhi;
+#else
+#define cfi_bhi (0)
+#endif
 
 typedef u8 bhi_thunk[32];
 extern bhi_thunk __bhi_args[];
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -936,7 +936,10 @@ void __init_or_module apply_seal_endbr(s
 #endif
 
 enum cfi_mode cfi_mode __ro_after_init = __CFI_DEFAULT;
+
+#ifdef CONFIG_FINEIBT_BHI
 bool cfi_bhi __ro_after_init = false;
+#endif
 
 #ifdef CONFIG_CFI_CLANG
 struct bpf_insn;


