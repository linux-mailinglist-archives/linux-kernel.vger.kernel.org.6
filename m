Return-Path: <linux-kernel+bounces-400221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC1E9C0A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410541C22366
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF24215005;
	Thu,  7 Nov 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBUq0Id4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176102144CD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995048; cv=none; b=rS/T9gfBpXMt1xSIYe/2dWuTSIHuoEWPJVxFUa18ngHjSgl2uJaB50tTgggVgL3igyVAx4MR5At4qqDJaTE8GxnmFAxTyhU5+MLO0GMCuvLy5NbR7zwljrbDf14plAiPOaaJWrvwPRvVoJtQ4qAw5w2XMB7xSrxhvkZw0iq2S9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995048; c=relaxed/simple;
	bh=UChCxhDsJm0k4omS7XmsS92N+o64haxYMLvowMqzS44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=as2eWry+4/7PSqWbqGhLY3XLnydQmgpnujeIYniV9a3wAg6/+V9amDPInqiYzth8kOkL34vJLpQh49NQ5SdrSovZACjESd+nYwp8rIFodWJQQk+Mi0OMavDEeuJjOiR6n6GwNUUp0zheeJykeg6ectdqorvuc4qeKhyRTB2JY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBUq0Id4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730995046; x=1762531046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UChCxhDsJm0k4omS7XmsS92N+o64haxYMLvowMqzS44=;
  b=HBUq0Id4hmQu72f8QQj8liDWn3mud2Zx82IQH5SSVTOmNvtrD7ozjwYY
   MDoEoaa/c4vP1tuFd/vBUDa5asN7FFqnTob0eDq+2ulHOu7lUkkmOQqXa
   s17gT/ideVxE7J6dCuOdv1GPe/EsZkrWsYOrLk13wK8Dyms7j3uhDUh14
   MyS/0wjlrHRieeM2VLS/XHGEW7naS1j3KiBxTbEbldxbVrqzTBVx2AbQf
   o8riVy6LE8HvlTEpznLMyAaVH5uK4AIP4sI4Xh1I6JrX9pHEThfPtrmbo
   RVDvf5USeKUomaQfH4LDw/I6qB2tLA8UYcoNa+fJ0bhBOCgY4l7eNlTfk
   w==;
X-CSE-ConnectionGUID: cFUv4f9vRfifkXXggFPdbA==
X-CSE-MsgGUID: CCqfDWloQJSxvbo+65FDPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="33689926"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="33689926"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 07:56:57 -0800
X-CSE-ConnectionGUID: 26MWszDcSsm4FB0xRB8XCw==
X-CSE-MsgGUID: ruMVUHsIQVOv32AJNILKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="89662005"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.222.202]) ([10.124.222.202])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 07:56:56 -0800
Message-ID: <7819c425-5792-4cc5-96aa-9c8b012f1a06@intel.com>
Date: Thu, 7 Nov 2024 07:56:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Restore PKRU to user-defined value after signal handling
To: Rudi Horn <rudi.horn@oracle.com>,
 Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Joe Jin <joe.jin@oracle.com>, Jeff Xu <jeffxu@chromium.org>
References: <4225E088-6D34-421A-91AA-E3C4A6517EB7@oracle.com>
 <4d484280-3bed-453f-b2f6-0619df4e9914@intel.com>
 <SJ0PR10MB47208C97D877C27053E546DC9C5C2@SJ0PR10MB4720.namprd10.prod.outlook.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <SJ0PR10MB47208C97D877C27053E546DC9C5C2@SJ0PR10MB4720.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/24 03:41, Rudi Horn wrote:
>> But the suggested fix is just beyond hideous. 
> 
> I am new to the kernel mailing list, but I would like to refer to 
> https://subspace.kernel.org/etiquette.html#be-terse-but-polite.

Rudi,

I'd also call your attention to another section of that document that
you quoted:

https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying

Aruna, my apologies for referring to the code that you wrote the way
that I did.  It's not an excuse, but

>> It's yet another reason that the XSAVE architecture complexity hurts more than it helps.
> 
> The XSTATE architecture simply guarantees that an XRSTR using the state 
> recorded by an XSAVE yields the same processor state. It can prevent dirtying
> cache lines by specifying which processor state can just be restored to its 
> zero'd state. All we are doing with this change, is maintaining the invariant that
> the xfeatures value matches the remaining data stored in the xstate buffer.

I appreciate the information about the XSAVE architecture!  That's
certainly a slightly different perspective than I was considering.

I was actually trying to bolster the argument that the XSAVE
architecture really isn't working out well and should be replaced with
something new for new features.

>> Can't we just use the mask that xsave_to_user_sigframe() generated instead
>> of reading it back out of userspace three seconds after it is written?
> 
> This is technically sound, but at this point in the code it is making the
> assumption that xsave_to_user_sigframe() currently matches the value stored
> in the xstate. This is more fragile if any further changes to the xstate are made.

Tell me more, please.  What changes to the XSAVE area are you concerned
about?  There is currently vanishingly little code between the XSAVE and
overwriting the PKRU state.

> However, we could consider the the kernels representation of XSTATE to be 
> a pointer to the xsave buffer and a kernel value of the xfeature field. The
> xsave_to_user_sigframe() would then compute and return the xfeatures 
> field as you requested, and the xfeatures value should written to the xsave buffer 
> at the end of copy_fpregs_to_sigframe, possibly being conditional on if it was dirtied.
> 
> Then update_pkru_in_sigframe then just becomes:
> /*
>  * Update the value of PKRU register that was already pushed onto the signal frame.
>  */
> static inline int update_pkru_in_sigframe(struct xregs_state __user *buf,
> 					  u32 *xfeatures, u32 pkru)
> {
> 	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
> 		return 0;
> 
> 	if (pkru != 0) {
> 		/* Mark PKRU XSTATE section as in use. */
> 		*xfeatures |= XFEATURE_MASK_PKRU;
> 
> 		return __put_user(pkru,
> 				  (unsigned int __user *)get_xsave_addr_user(
> 					  buf, XFEATURE_PKRU));
> 	}
> 
> 	return 0;
> }
> 
> I think maintaining this invariant is a fair step to perform when fiddling
> with somewhat architecture-internal data structures.

That version seems to me like it would simply punt the complexity of
updating XSTATE_BV (aka xfeatures) to other code.

The question still stands as to whether the new XSTATE_BV value should
be calculated by the kernel or read directly from the userspace buffer.


