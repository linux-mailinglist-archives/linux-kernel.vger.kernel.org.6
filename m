Return-Path: <linux-kernel+bounces-229447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4E916FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1507F1F230E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110F7175567;
	Tue, 25 Jun 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieTC1yBl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F37F6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338520; cv=none; b=YS6nh9LySwFOicv0+Dxesi6n+wW266M7qORnFJZahYwnakanPivwdHad9MzzujNnh7QZAfUOgQeDgYtwme9fvDpLZ0+XPOfKDdEIXB7dKmyw1Nnn45vbpuP284lHZ4BSL2FukCbmF28MwPCrFiBa6HGhB2+TJZsTkG/EcpEX0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338520; c=relaxed/simple;
	bh=yIrGqZsoXWjyCqtML+uDvdM/jwBAs2FsGlClg8xbN9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYhdWOyFf3Ejtah93/HSiabgfTh2cmdC2F4Eb+mAzQmUt8KwBDm/aBBGjUee/kUJHdCQ0G6AJSpU4vQl+x4STzFzt194c+7aN5TYK1ijDo5ToQ3Q5FPuslTsVTn9GQ5eya7V3tlY/Cnt6esdUDWw3AcADP0cubRCEtT+T00sG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieTC1yBl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719338518; x=1750874518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yIrGqZsoXWjyCqtML+uDvdM/jwBAs2FsGlClg8xbN9E=;
  b=ieTC1yBlr+Q3FJXfLqslko4KHqmz/FcFY40TEjbGGipek2a1r0bP6ZuS
   ZM/qF0t7ZhjIng+PdkNCkKrykBHRGgz8vqZeYnVILNuSB6MUUtmW3jFiL
   YEaIFW+qxKROXmIHL2GK0Yfie9MJEAXy0Ec4PY5efKeZFvTHU9c21fVPV
   j8D7MSpo2eErbVgyc0PCpr5LS9WI8puj++JUnWOzxk3R2zOgpjIf++m+A
   194VZy0EW/MOsdbpwMCDUhbQQAf6+SOpPhNVPluMiG+edwkV4+qlawWTe
   3w9UPdEEPeqpVlWbkoECWA6VVIbW/ljf70UkknDVqMi61g/ZqTURHx7nn
   g==;
X-CSE-ConnectionGUID: KqxrOf5sSBW0rw3vGADbnQ==
X-CSE-MsgGUID: bvKQdFA6Qy2SmsyJDpyRGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16525175"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16525175"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:01:57 -0700
X-CSE-ConnectionGUID: uw8vkD8eRvypVi40aCAc4Q==
X-CSE-MsgGUID: v7rWvoZ3SES7/wLKyKTjAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43843811"
Received: from rprzybyl-mobl.amr.corp.intel.com (HELO desk) ([10.209.8.143])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:01:57 -0700
Date: Tue, 25 Jun 2024 11:01:50 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Stable linux-5.10.x regression triggered by MDS mitigation
Message-ID: <20240625180150.7awxiyvmztcuu4pw@desk>
References: <IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com>
 <20240624170921.mep2x6pg4aiui4wh@desk>
 <yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com>

On Tue, Jun 25, 2024 at 01:49:17PM +0000, Jari Ruusu wrote:
> On Monday, June 24th, 2024 at 20:09, Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> > Below patch (for v6.10-rc5) should fix this. I didn't send this patch
> > earlier because I havn't got a chance to make sure if it will work for
> > other cases like modify_ldt().
> 
> Thank you for fixing this regression.
> 
> I tested your patch on 32-bit linux-5.10.220 inside VM, and now
> dosemu seems to work OK.
> 
> I do have a related question:
> In SYSENTER code path (that is not used by virtual-8086 mode),
> there is CLEAR_CPU_BUFFERS just before STI and SYSEXIT, but that
> CLEAR_CPU_BUFFERS happens after flags are restored with POPFL.
> VERW opcode inside that CLEAR_CPU_BUFFERS modifies ZF flag.

Thanks for pointing this out, CLEAR_CPU_BUFFERS should happen before POPFL.
Below patch moves it before POPFL and also adds a safer version that
switches to KERNEL_DS before executing VERW. This should ensure VERW works
in all cases:

---
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index c963abc17a96..2680be38e5cb 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -253,6 +253,17 @@
 .Lend_\@:
 .endm
 
+/* Make sure ds has a safe value so that VERW does not #GP */
+.macro CLEAR_CPU_BUFFERS_SAFE
+	ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
+	pushl	%ds
+	pushl	$(__KERNEL_DS)
+	popl	%ds
+	verw	_ASM_RIP(mds_verw_sel)
+	popl	%ds
+.Lskip_verw\@:
+.endm
+
 .macro RESTORE_INT_REGS
 	popl	%ebx
 	popl	%ecx
@@ -878,6 +889,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Now ready to switch the cr3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	CLEAR_CPU_BUFFERS_SAFE
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
@@ -888,7 +900,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.

