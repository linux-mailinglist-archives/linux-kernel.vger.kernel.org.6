Return-Path: <linux-kernel+bounces-537092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3414BA48804
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD22188845A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8925EF9C;
	Thu, 27 Feb 2025 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZoK0+1M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C621C160
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681702; cv=none; b=Aw71HX3u9hg2jgU2gQwuyauOjBYrnmPCSwkutN+ZRPMjj65kz55mBbWkHtzVia7LNm2tl/T7LvKc0wM60kxX6tqhwbQZKqyxDjeo5rzwr6BAJ2zBgBu3g3g87l5HjtQAKBqL6HGHCdv/OIFkmcmlKvMHajF0JARBGDfE1MA6fV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681702; c=relaxed/simple;
	bh=ETOaYhPjXGmZkiakzSlAaPfRYM+txKLp21G5z67NWO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM+zRDxkF5hnRCQ25HJXFMVeoJJqiacaUcwoa/HJMYy8mGd9Drg9dvOtlix0/9MQJVFhZCuSjMctXdasfBXVYWqe2zYuIzLOczrER6ZXQuCkz2NFuVlD0EXXzRIDTnuCXOAbcQGTLM0X5X6RZCDPTY7VRPSMNTL13VOgp5IdQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZoK0+1M; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681700; x=1772217700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ETOaYhPjXGmZkiakzSlAaPfRYM+txKLp21G5z67NWO8=;
  b=kZoK0+1MUi+lD8MYIhGbe62Hgr8Mq1ur4qcYEgNyPfnnp4j1PZwDbP7I
   O0TUA8+Do0lqSat2k0bbjv0klmzL/A0ddLsfa30eLK09Rgt/jd1vXZZYW
   cjeLi5ulfbmpW9ZuDazz+tI5NLSyYkO4bHiFTeTYDQerzbjA4QeriSY4B
   CPgRGuNzXiWJQ9/T+XGPkbMSWI0kLuYjcVN8oQEjgJXMsjNl4Xn+Hh4+Z
   +2bOEfxHY5DFJbV7nsfcrK/NRZLBXW/yIToyB0tCWBipff+jpmk91avgo
   LF0AMBnZEkytpoOcjNh23dz4d0LhIlPY5G0ZarK4Fn5/Fww/yuQ+4l656
   Q==;
X-CSE-ConnectionGUID: 1K+SbC0rQFKAEGfHzm3LFg==
X-CSE-MsgGUID: 3GRFel2nQS6WNoHUnEn8QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53000319"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53000319"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:41:40 -0800
X-CSE-ConnectionGUID: gkbmOA3aRQOyTDlqaaSsCA==
X-CSE-MsgGUID: F+YkDjecTxGbHL20R9byeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="122054644"
Received: from jgarnacx-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.170])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:41:39 -0800
Date: Thu, 27 Feb 2025 10:41:33 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Simplify and make CALL_NOSPEC consistent
Message-ID: <20250227184133.lxm43awa2jgdpl4q@desk>
References: <20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com>
 <497a3694-cb0d-4678-9622-d9443bf8a40d@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <497a3694-cb0d-4678-9622-d9443bf8a40d@citrix.com>

On Thu, Feb 27, 2025 at 12:49:48AM +0000, Andrew Cooper wrote:
> On 26/02/2025 9:03 pm, Pawan Gupta wrote:
> > @@ -420,20 +420,28 @@ static inline void call_depth_return_thunk(void) {}
> >  
> >  #ifdef CONFIG_X86_64
> >  
> > +/*
> > + * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
> > + * to the retpoline thunk with a CS prefix when the register requires
> > + * a REX prefix byte to encode. Also see apply_retpolines().
> > + */
> 
> Technically, both comments aren't quite accurate.  __CS_PREFIX() emits a
> conditional CS prefix in a manner compatible with
> -mindirect-branch-cs-prefix, not the full 5/6 byte jmp/call.

You are right, I will update the comment, and also the ASSEMBLY version
where this comment came from:

  /*
   * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
   * to the retpoline thunk with a CS prefix when the register requires
   * a REX prefix byte to encode. Also see apply_retpolines().
   */
  .macro __CS_PREFIX reg:req
          .irp rs,r8,r9,r10,r11,r12,r13,r14,r15
          .ifc \reg,\rs
          .byte 0x2e
          .endif
          .endr
  .endm

> > +#define __CS_PREFIX(reg)				\
> > +	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15;		\
> > +	.ifc \\rs, \reg;				\
> 
> Why are these escaped differently?  Given they're all \r of some form or
> another, I guess something is going wonky with __stringify(), but its
> still weird for them to be different.
> 
> Do you have a fully pre-processed source to hand to see how CALL_NOSPEC
> ends up?

Below is the pre-processed source for test_cc() generated with "make arch/x86/kvm/emulate.i".

- This is with double backslash in ".ifc \\rs, \reg":

	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \\rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "call __x86_indirect_thunk_%V[thunk_target]\n"
                                                                                  ^
	This ends up emitting the CS prefix byte correctly:

	2e e8 51 c9 32 01       cs call ffffffff824289e0

- This is with single backslash in ".ifc \\rs, \reg":

	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "c      all __x86_indirect_thunk_%V[thunk_target]\n"
                                                                                  ^
	This version does not emit the CS prefix byte:

	e8 52 c9 32 01          call   ffffffff824289e0

I tried looking in gcc inline assembly documentation but could not find
anything that would explain this. :(

