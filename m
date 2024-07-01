Return-Path: <linux-kernel+bounces-237100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031CF91EB54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23F628354B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE6172798;
	Mon,  1 Jul 2024 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcdayEMp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6438DD9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719876151; cv=none; b=iW00NmWfxXX1Ifl3x2BcFqazJXxkGcId1JP94dZ8n0XoEMlOOymCLex1T7p+dl6m/BzLRrxO6u8nVERqB5ZRYKSE9Ufhnt/38nlfosQQa/SMpti26B+hMDzL2/6xazjdt2xNPBrcBVwrc6HbkhC8CqlZShq5XPLvnZF0jQRRgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719876151; c=relaxed/simple;
	bh=T9boFwHyOqkR+gnmoiDwMfYuzObkmnZgIuZTryYTvEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLq5gC67lz6vQy2ylsOYEWJ9iXcWI5VRawfv7vz3SNRVemlhPPcK5Q9N4fAnhOCAIDOCLtEev76T0lNxHwbr8bU1W4YjXhPsnnt5sFkeIkHVYdNEuxiO8EoOAn/Uhv064oBlV0UWHkYgcLLkyAjiu9OrTrSkmD2qvswxwHEDhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcdayEMp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719876150; x=1751412150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T9boFwHyOqkR+gnmoiDwMfYuzObkmnZgIuZTryYTvEY=;
  b=QcdayEMpZk9POjydE8a7HZQ/lYfiP7yb3GGkkM8rkqFhFgh3EIrIyvS2
   lxuugFW6RvHbp5iTwUcqDj2//nEAF+O+CxeNyNTsGM5HMpa8RTHr4ZdNc
   jB752udtU5fS8a797ftz8n6IZXdOIOEXK45XpjMzlh2q94JOD+KdWytBg
   Abn3pOVsOnbyHLE2EMhNqhkelgfoZLwdSiicyEpRWl/4CspNuuFWRtAdq
   TgZVon2cnJGp3mRjU4v8ee9MRI9+aX8QI2LZPrdEHzgoavpigfO0/0TR0
   i30xX1O24aKsWaY5OixwUfXDjkfp5GLuW9oaFRi1SslkoVIUhLs0zZ175
   w==;
X-CSE-ConnectionGUID: j29l3DfrQcGdZmhXXW/Qrw==
X-CSE-MsgGUID: pnp/pBQOR6u92953uQV7fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16692435"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="16692435"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 16:22:29 -0700
X-CSE-ConnectionGUID: xHe13+12QamC3GkXup67XA==
X-CSE-MsgGUID: lcUMT8CYTYibJlfKhGlGXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45586068"
Received: from aadeosun-mobl.amr.corp.intel.com (HELO desk) ([10.209.8.130])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 16:22:28 -0700
Date: Mon, 1 Jul 2024 16:22:21 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: Re: [PATCH v3] x86/entry_32: Move CLEAR_CPU_BUFFERS before restoring
 segments
Message-ID: <20240701232221.s4egkkyctgrasulr@desk>
References: <20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com>
 <CAMzpN2iJHO01499VsarF1a3ZyjCLUn36FpNqEZeAaXuCoc9GwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2iJHO01499VsarF1a3ZyjCLUn36FpNqEZeAaXuCoc9GwA@mail.gmail.com>

On Mon, Jul 01, 2024 at 03:22:44PM -0400, Brian Gerst wrote:
> Perhaps I should have been a bit clearer, but I meant adding the SS
> override to the VERW instructions in their present locations, instead
> of moving it into RESTORE_REGS.

I did consider that way, but moving it to RESTORE_REGS saves a callsite for
CLEAR_CPU_BUFFERS. I believe Dave prefered it within RESTORE_REGS, but that
was before the SS override. Unless anyone has a strong preference, I will
change the current callsites to include the SS override, and not move
CLEAR_CPU_BUFFERS to RESTORE_REGS.

> IIRC we don't want data reads (including stack pops) between the VERW
> instruction and IRET/SYSEXIT.

Stack pops are okay if the memory *and* the registers doesn't contain
sensitive data, which doesn't seem to be the case here. But, SS override is
a safer option.

BTW, Dave pointed out that CLEAR_CPU_BUFFERS needs to be done after
RESTORE_ALL_NMI in the NMI return path, that adds an extra callsite:

---
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814efbff6..9b58d2cbdfef 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1144,7 +1144,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1165,6 +1164,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1206,6 +1206,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 *  1 - orig_ax
 	 */
 	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 #endif
 SYM_CODE_END(asm_exc_nmi)

