Return-Path: <linux-kernel+bounces-541307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C04A4BB28
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604181892B55
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B551F151E;
	Mon,  3 Mar 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uYdUwo3N"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD81F131C;
	Mon,  3 Mar 2025 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995355; cv=none; b=tYafWlFc0StdoWurTmcTK8E/RSRDPtKHi2dEfgXykPXMp/ijYAIJP00Z51cqbD34IuXarejZ6gvdQOXKXcWQj/dphye6yWp+/MGyswPHAxV+0t+fjqAeciebwgAzYq5rssP+9Omjx4qPZMOfCCq9IbgDorJ0qrJArnlqpdBCQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995355; c=relaxed/simple;
	bh=bKBTyhky71uYBsaxCFXi3vy/CYFmpwehRG1HobK2WLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptMl2TyNvNcxZ2QAfuKa9LVYHsBBk8beDR8oM5eSJ9iTiiTbMwCkBQGJCHJya4e6z4ED2DY6KN0MF5ER5o6vIkgwazK4nAKOhm9PowpQ9KG4a5wJ/o48hbwxIQSh+rDf3zOM8QefRD4Z18FIghhA/o9qd5cOH7SxEvMDI/EHp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uYdUwo3N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ex6mL5N3y2HnLj8Bam/c+5++LbL+FQRGmaE08QtykjE=; b=uYdUwo3NP446bW5DtXGr+gLlKm
	3q7P896CCaZPM1ZlewJ1QitoJ9p6puv6V5u85QQRjyB/RAYgFaem1YgOR+N2vYxG4/1oEwXpK/Vny
	ul9+2nxCC1iY8BgAyIrDrFROXKRBmOzdN1fT3S6ksMhlhXZNtPunLTL9N1IAengf8LG6244P4r8FA
	UXItZ73N7cP93YsjsXyVp7+cTd9w1IHFr0ijBc2A0BKK3iClchg0AWicyraF7CcIO8Kpy/PS660Nu
	RGW8hb8Mf5MfdgsuFloZXWHVC7xaApcE5Jlt0ebteSJlT/ekBi1KZCtm2bzaZjWr17u5Z1McimXsN
	cqatSMmA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp2QB-0000000BQR2-2UJu;
	Mon, 03 Mar 2025 09:49:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2EB2230049D; Mon,  3 Mar 2025 10:49:11 +0100 (CET)
Date: Mon, 3 Mar 2025 10:49:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [tip:x86/core 16/17] vmlinux.o: warning: objtool: do_jit+0x276:
 relocation to !ENDBR: .noinstr.text+0x6a60
Message-ID: <20250303094911.GL5880@noisy.programming.kicks-ass.net>
References: <202503030704.H9KFysNS-lkp@intel.com>
 <20250303092459.GI5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303092459.GI5880@noisy.programming.kicks-ass.net>

On Mon, Mar 03, 2025 at 10:24:59AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 03, 2025 at 07:47:57AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > head:   dfebe7362f6f461d771cdb9ac2c5172a4721f064
> > commit: 0c92385dc05ee9637c04372ea95a11bbf6e010ff [16/17] x86/ibt: Implement FineIBT-BHI mitigation
> > config: x86_64-randconfig-071-20250303 (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/config)
> > compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60
> 
> Thanks, below seems to cure it for me.
> 
> ---
> Subject: x86/ibt: Make cfi_bhi a constant for FINEIBT_BHI=n
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Mar 3 10:21:47 CET 2025
> 
> Robot yielded a .config that tripped:
> 
>   vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60
> 
> This is the result of using __bhi_args[1] in unreachable code; make
> sure the compiler is able to determine this is unreachable and trigger
> DCE.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 2f6a01f098b5..3e51ba459154 100644
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
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 32e4b801db99..bf82c6f7d690 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -936,7 +936,10 @@ void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
 #endif
 
 enum cfi_mode cfi_mode __ro_after_init = __CFI_DEFAULT;
+
+#ifdef CONFIG_FINEIBT_BHI
 bool cfi_bhi __ro_after_init = false;
+#endif
 
 #ifdef CONFIG_CFI_CLANG
 struct bpf_insn;
@@ -1070,11 +1073,15 @@ static __init int cfi_parse_cmdline(char *str)
 				pr_err("Ignoring paranoid; depends on fineibt.\n");
 			}
 		} else if (!strcmp(str, "bhi")) {
+#ifdef CONFIG_FINEIBT_BHI
 			if (cfi_mode == CFI_FINEIBT) {
 				cfi_bhi = true;
 			} else {
 				pr_err("Ignoring bhi; depends on fineibt.\n");
 			}
+#else
+			pr_err("Ignoring bhi; depends on FINEIBT_BHI=y.\n");
+#endif
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}

