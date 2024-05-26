Return-Path: <linux-kernel+bounces-189588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7800C8CF27E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 05:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13DD1C2093B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 03:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166EC1854;
	Sun, 26 May 2024 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5ad+WQu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80617D2
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716695811; cv=none; b=nr/mfHvfmNiXlDvnJgVWLNNE3TKfL9JMmbLt9OfLJ1J0SSFB9LLsEDS2lJpgdy13qQ9YYj3/2bbOfQpxMAxIyeHhI0fQYJpjS1iAaMtBzwvQ7NYYNAMAn8lXh7UdrmOazucnJh3azhnrkijZJaIPJsQxI96izxD1rTPJMqIuB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716695811; c=relaxed/simple;
	bh=m+gcHnNq77DKhAKBiyivo/WElrH5X/4adlw42x6cyaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFxb32XfwBQYx0ibj+Tee0a1fma3XCbZomobQUeTdKkO1l0veFSE+BdKYQzgDwNhJiCvS3B/7K6SXDdLTrzuzrMrTifliSDNK2i5RDUN2V5tMmX9SftVT1esNMKxA6JsKLnJUXB5/Touw8J9jSv5WOP1zTF4Po/Q7kMv5AjC4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5ad+WQu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716695808; x=1748231808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m+gcHnNq77DKhAKBiyivo/WElrH5X/4adlw42x6cyaY=;
  b=X5ad+WQuKR14DO29TcmRHWQz1CcM6h9udonHOyqGHJfy0PDYb4iCn3x7
   wfNGH2f6xh79W1FdMD4t08qIZQDEJZ2bvSJ7Eqxka3Xk4OXDbh5BNHwFO
   LNpQjOm1SZKgGNLGFVLpHdIWPkX80y64uqo7YzOQ5MvKfQe2BHWiIwB6O
   JdRM7JkY+CfsquqJ04c1jF6ERmwhFgmICAv4/BizLiMscJjLoPTewlCML
   ZPzTtAMHhUwQPA0oNeS7Cf7T2TRWHCvvk+yAZE5elixXlyUNioxl3IQ+M
   HlI6OBzUgZFMl9+kAdQddWNn259jV1WVYVXdMjqvDKqlDFSA7i/zT8e59
   Q==;
X-CSE-ConnectionGUID: ki+Yo+uLS2GT71oXQHlZUg==
X-CSE-MsgGUID: USol1O55RtmbnqmBurCVOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="13256993"
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="13256993"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 20:56:48 -0700
X-CSE-ConnectionGUID: FuJwPHbUReq1V/Ye9tTYdg==
X-CSE-MsgGUID: I9Bkf1YFT+qVPo33+JITNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="71824088"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 May 2024 20:56:45 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sB4zy-0007il-2A;
	Sun, 26 May 2024 03:56:42 +0000
Date: Sun, 26 May 2024 11:56:31 +0800
From: kernel test robot <lkp@intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH] x86/asm/bitops: Change function return types from long
 to int
Message-ID: <202405261132.5bA1MUEH-lkp@intel.com>
References: <20240525174448.174824-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525174448.174824-2-thorsten.blum@toblux.com>

Hi Thorsten,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0b32d436c015d5a88b3368405e3d8fe82f195a54]

url:    https://github.com/intel-lab-lkp/linux/commits/Thorsten-Blum/x86-asm-bitops-Change-function-return-types-from-long-to-int/20240526-014828
base:   0b32d436c015d5a88b3368405e3d8fe82f195a54
patch link:    https://lore.kernel.org/r/20240525174448.174824-2-thorsten.blum%40toblux.com
patch subject: [PATCH] x86/asm/bitops: Change function return types from long to int
config: x86_64-randconfig-121-20240526 (https://download.01.org/0day-ci/archive/20240526/202405261132.5bA1MUEH-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240526/202405261132.5bA1MUEH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405261132.5bA1MUEH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/emulate.c:5105:21: sparse: sparse: arithmetics on pointers to functions
   arch/x86/kvm/emulate.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
>> arch/x86/kvm/emulate.c:5105:49: sparse: sparse: non size-preserving pointer to integer cast
>> arch/x86/kvm/emulate.c:5105:49: sparse: sparse: non size-preserving integer to pointer cast

vim +5105 arch/x86/kvm/emulate.c

cbe2c9d30aa69b Avi Kivity          2012-04-09  5099  
3009afc6e39e78 Sean Christopherson 2020-01-21  5100  static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
e28bbd44dad134 Avi Kivity          2013-01-04  5101  {
e28bbd44dad134 Avi Kivity          2013-01-04  5102  	ulong flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
4548f63e651164 Josh Poimboeuf      2016-03-09  5103  
b9fa409b00a1ed Avi Kivity          2013-02-09  5104  	if (!(ctxt->d & ByteOp))
e28bbd44dad134 Avi Kivity          2013-01-04 @5105  		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
4548f63e651164 Josh Poimboeuf      2016-03-09  5106  
1a29b5b7f347a1 Peter Zijlstra      2018-01-25  5107  	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
b8c0b6ae498fe5 Avi Kivity          2013-02-09  5108  	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
1a29b5b7f347a1 Peter Zijlstra      2018-01-25  5109  	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
b8c0b6ae498fe5 Avi Kivity          2013-02-09  5110  	    : "c"(ctxt->src2.val));
4548f63e651164 Josh Poimboeuf      2016-03-09  5111  
e28bbd44dad134 Avi Kivity          2013-01-04  5112  	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
b8c0b6ae498fe5 Avi Kivity          2013-02-09  5113  	if (!fop) /* exception is returned in fop variable */
b8c0b6ae498fe5 Avi Kivity          2013-02-09  5114  		return emulate_de(ctxt);
e28bbd44dad134 Avi Kivity          2013-01-04  5115  	return X86EMUL_CONTINUE;
e28bbd44dad134 Avi Kivity          2013-01-04  5116  }
dd856efafe6097 Avi Kivity          2012-08-27  5117  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

