Return-Path: <linux-kernel+bounces-173424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6698C0041
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7D91C20CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB986628;
	Wed,  8 May 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ck87vCEI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6385639;
	Wed,  8 May 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179236; cv=none; b=PjKkxTtKclV35XrZotfXFoZNBTcxpLLctt+3OH1j54fFYmQuxbsalt/nG3n+Sb+hSgKGlZoZOb10fQGQM8Pa9W7961U2urWbOBYNtMudDgrtFstE20IOATxGyG6NQRSe1rlUs0SpOKQ7C5S9wTUuFSkC0ozfl5DHfkQsHaaDfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179236; c=relaxed/simple;
	bh=Ed3e92ntMBI2EJUpaYIV7OyD99mhk3MQm6HsDzueS60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NB8QA+vmVlAXaLAoa4oS9+fxprRN9790XgKn79570JEorc9Zg7J/OSMKo4D9duQGbKE1Q7ZUcsVYfw1AgfcV2I9bICPevvXcZMTdGWrnC6En7MDs1MtfXk2bEzQVzYu47hjK+WLfBBNF74JYJ7nhUQExTD+dlN8hyg93iQtQxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ck87vCEI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715179234; x=1746715234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ed3e92ntMBI2EJUpaYIV7OyD99mhk3MQm6HsDzueS60=;
  b=Ck87vCEIoTw7ATym50cKUvhH1/GkU0R2W8Q2jwe6U3H//LsffXv/mtqo
   KMYEmneRf++eG29DE+hGXftftqqqXzPEDmSe3jDcCIZlbTkxENm2IN7xT
   fLLNfjrXn/nf91kGkA8MD3R+tLOFxv5uPk+zUOOQM0P38IKAOVdpEz7a9
   SJBKpVCJ3kwHVdh5t4MXjzGd5lpqJFsA/qF0PqDpDUgT6xVwq4MEjB4Ua
   XQN1DNn8wf+DqF5ZYI1sNYNpEwf8xOLlvNN9ZAAq02L1kcmn6If1/ndvl
   GQErcHusnnjX+sGHNTgJ1ndhFdIKFyk/hxxqGxWVRwDt2nF1Kij4KGzV7
   w==;
X-CSE-ConnectionGUID: taGRvRtYQxSpxUE/EnYE+Q==
X-CSE-MsgGUID: AHiyek6bQhSSitFyMtlzPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10880018"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10880018"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:40:33 -0700
X-CSE-ConnectionGUID: XkQvqP5AR66cRcmpUqT1fw==
X-CSE-MsgGUID: TwrouHAQTCSGFZ0M3PnIGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29001573"
Received: from hemanthr-mobl.amr.corp.intel.com (HELO [10.209.17.69]) ([10.209.17.69])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:40:32 -0700
Message-ID: <f82879a5-f3ca-436f-8c4a-96d4c5d90354@intel.com>
Date: Wed, 8 May 2024 07:40:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to
 initialize AMX state
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, platform-driver-x86@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, tony.luck@intel.com,
 ashok.raj@intel.com, jithu.joseph@intel.com
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-2-chang.seok.bae@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240507235344.249103-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The subject should probably be:

	Allow kernel FPU users to initialize AMX state

On 5/7/24 16:53, Chang S. Bae wrote:
> The In-Field Scan (IFS) test [1] is a destructive process, overwriting
> the existing state to test the logic on the fly. As part of this test
> process, the architectural state is saved before the test begins and
> then restored upon completion.

This should say "_most_ architectural state".

> However, due to resource constraints in storage, AMX state is excluded
> from the scope of state recovery. Consequently, AMX state must be in its
> initialized state for the IFS test to run.

This doesn't mention how this issue got introduced.  Are we all bad at
reading the SDM? :)

> When AMX workloads are running, an active user AMX state remains even
> after a context switch, optimizing to reduce the state reload cost. In
> such cases, the test cannot proceed if it is scheduled.

This is a bit out of the blue.  What does scheduling have do do with IFS?

> System administrators may attempt to mitigate this issue, by arranging
> AMX workloads not to run on CPUs selected for the tests. However, this
> approach is disruptive for managing large-scaled systems, diminishing the
> benefit of the live testing.

I personally prefer to go and mention alternative solutions *after* I've
discussed the things that are truly relevant to the problem and fix.  I
think this distracts from the real issue.

> The kernel can help by properly initializing the state before the test.
> This initialization impacts the performance to some degree. But, this
> approach is considerably cheaper than adding hardware resources and
> simpler than a userspace approach.
> 
> While fpu_idle_fpregs() can initialize the AMX state, its usage should be
> limited to specialized cases, primarily before entering the sleep state.
> The restore_fpregs_from_fpstate() function offers a suitable mechanism
> for initializing fpstate in general, which remains within the core code.

I'm not sure those last two paragraphs add much value.  I'd try to
banish most of that content to *after* you talk about the solution.  Or
maybe put it in the cover letter.

> Extend kernel_fpu_begin_mask() to allow the IFS driver to initialize AMX
> state through restore_fpregs_from_fpstate().

The function names are pretty blatantly obvious from the patch.  No need
to copy them here.

As I look closer, I'm not sure I think this is a good match for the two
other KFPU_* flags.  I don't think either KFPU_387 or KFPU_MXCSR causes
any XFEATURE to be tracked as init.  The SDM says that FNINIT "sets the
FPU control, status, tag, instruction pointer, and data pointer
registers to their default states."

Off the top of my head, I don't know how that maps to the XSAVE init
tracking but I do know that MXCSR has a very weird mapping to the first
two XSAVE features.

I really think it would be simplest to just have this whole thing do this:

	kernel_fpu_begin();

	// Zap AMX state

	kernel_fpu_end();

Where the zap is either an os_xrstor() or an explicit tile release
instruction.

It's just a matter of whether you want this to work like a regular old
kernel FPU user or you want to tie it to *only* being able to run in its
own kernel thread. -- Aside: I don't think I realized IFS had its own
thread earlier.


