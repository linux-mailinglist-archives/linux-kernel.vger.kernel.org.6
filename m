Return-Path: <linux-kernel+bounces-317490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB23B96DF0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5D9285CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973A19EEB1;
	Thu,  5 Sep 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTFLpjdM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AFA19E82C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552055; cv=none; b=ELpe61mkzNLG6SZ8xMV7/qnmf4fzBfygo6CPUqygDzaP94KLIUdSEVOU4NIQ/jPZpFjOwZzPCmCkx/AS4lXASQQUIh26Qsg+l3s8oRtxhZJPO6OTYQGLeejDgDmpO+hrVGs7CUJjzJkQUv8Hgnn83ht+J54FSejAqO/UNJPQFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552055; c=relaxed/simple;
	bh=7XNLoPjMi2p0yPNBVBbQHtFB3VyLvnKB24qCJaKJbNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/KUY1zbrv7LaHmuIj/HmFZbWIWfyuR1qtEHBz1XC8TWIAP91+J4BW9EeE04uadWUz778b4O7YBxCA5a+yBME0/D+ZWl5MFBdqa2VkKbK/egbu6lg+ZGOtv9K6sDPbvp+YZCZLwTQOnCcDdwnmNqSoYdaTpgC8LvFO3vj1wwD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTFLpjdM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725552054; x=1757088054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7XNLoPjMi2p0yPNBVBbQHtFB3VyLvnKB24qCJaKJbNM=;
  b=bTFLpjdMaAgbP4ScvYv0bNlsdZQT9QHBp8VlE1NPTgtbJG4Og6S/M1CW
   T+fSyHvS1GZGEc0XncQhhmjMWl8uN3w1j81Geg6xu0zyJdUHCkjPFgtpl
   SU8d/dTqB9Mhe5YR/gSSE2KB0mNW6+jMBqtSDOALRsIJkd93/3oLGYtTT
   v460qCfgwKejDNuGRgCUl4/V+suo7wSCuQtQmoBfkZ445ENkE1YenJakr
   Z0OQp1+j6uCR23dDDKVWDNlD1OT7dd6RXhWP/U6gmY1NoE9YqTNo3E7dz
   6y/OmcK+1sPgAPLUAJRFxZEdArzPA59ws8qkDp7m8A4IyeEPHSyCQQAvW
   g==;
X-CSE-ConnectionGUID: z2qDCLQHRUq3eBBZPTk1lA==
X-CSE-MsgGUID: EglFYrGHSm+j9VvMVfdf7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="35665992"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="35665992"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:00:53 -0700
X-CSE-ConnectionGUID: jnljNIoWQdu3jDy0bQ/NsA==
X-CSE-MsgGUID: U13ZolXrRVG4RY8Hr6TrHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="69816294"
Received: from bllerma-mobl2.amr.corp.intel.com (HELO desk) ([10.125.147.102])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:00:53 -0700
Date: Thu, 5 Sep 2024 09:00:51 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: [PATCH v6 2/3] x86/entry_32: Clear CPU buffers after register
 restore in NMI return
Message-ID: <20240905-fix-dosemu-vm86-v6-2-7aff8e53cbbf@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com>

CPU buffers are currently cleared after call to exc_nmi, but before
register state is restored. This may be okay for MDS mitigation but not for
RDFS. Because RDFS mitigation requires CPU buffers to be cleared when
registers don't have any sensitive data.

Move CLEAR_CPU_BUFFERS after RESTORE_ALL_NMI.

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Cc: stable@vger.kernel.org # 5.10+
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 9ad6cd89b7ac..20be5758c2d2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1145,7 +1145,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1166,6 +1165,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1207,6 +1207,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 *  1 - orig_ax
 	 */
 	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 #endif
 SYM_CODE_END(asm_exc_nmi)

-- 
2.34.1



