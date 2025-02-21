Return-Path: <linux-kernel+bounces-526634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B834A40155
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451AA17CE37
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC424FC1E;
	Fri, 21 Feb 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VA1+jkJY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20621EE028
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171056; cv=none; b=GKNr/x4r6PcrHxeND/a8ElA8BxTNi+30rMjWmil0/I5Y/wjsjhCX/byQVe3uAt8s0KVidAA/Ujknrm8i0AdqW6J1xARxRorRtwPZuxz3oqezeSt84riSbzU4IszKh9dKwKa52mX6nyQEs24pR4P+jH836ojaHxexrYITxV4zdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171056; c=relaxed/simple;
	bh=R4Gd/0PqgqBgOjam/WcC8XGdif0HDapNSAKmsg0sOu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3Rgu1vj1vAhEVIBHITbvYuEMPFS5VtaE/b5Q+4aMSPkMKITPYIFRW5ZBfEgMzMxmLAWfTl1Gtu2c4wmWBEpEgi4lPUropPu6MUGlEAaKx4PQSUEwIePbAPwZvtSoL0GBvTuPrtBTRu4bpKnzQkImCSYQjy9bcS0rAZ6p10CO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VA1+jkJY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740171055; x=1771707055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R4Gd/0PqgqBgOjam/WcC8XGdif0HDapNSAKmsg0sOu8=;
  b=VA1+jkJY7iGSBObs4nbMRgL7q99q8V0a/zaqW6lkQY/f0K5mJggsc8i0
   8kqIcg70ToaON/+96ezGmOWbAytobKa33DdEvrQ/LFzGrWIN9Ym2N7YSG
   P5WZavh08zSu/w9CKRY8i9tRAW01Xh95WpE2JI6pTXxMFv5fWBLmM7v1K
   YCt88CXvq1tFZcZsk8quDa6R3JWT/k6UH0cgsUZ/ZWtX9tYFMA3Fr8sZ+
   yRtXiljvQoZRmkaWO9CaEArgHaVzHfJk3H+QrV1CoAXTpc+SPOLGO4j8A
   orESFkKV1VSs7n71vhxLiYNCBMGBtt7XJAtrbaRfKwchIeEnPOR2cGlWr
   g==;
X-CSE-ConnectionGUID: Xb6VZQsgQDW6XZPZ0EbBOg==
X-CSE-MsgGUID: 8wu0w4CCRo6HZyI70IX//Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63476026"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="63476026"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:50:54 -0800
X-CSE-ConnectionGUID: U1BtcQHZTx6ajled2tQKcw==
X-CSE-MsgGUID: pfh0/r8JQ6q908IYSymM6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119591139"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.110.177]) ([10.125.110.177])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:50:53 -0800
Message-ID: <c793e1d0-e508-4cf5-a18b-29d30d5e401f@intel.com>
Date: Fri, 21 Feb 2025 12:50:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <81d94ec3-16af-45a7-87c6-ef76570953f8@intel.com>
 <6ada635e-973d-4e32-ab47-1fda12ee7ce7@efficios.com>
 <90a36a64-8ea5-4ea1-965f-bcec604c7d5b@intel.com>
 <6ad30642-c3b5-4ab8-9ed6-1fa8c56a8995@efficios.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <6ad30642-c3b5-4ab8-9ed6-1fa8c56a8995@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 12:05, Mathieu Desnoyers wrote:
> On 2025-02-21 14:48, Dave Hansen wrote:
>> On 2/21/25 11:38, Mathieu Desnoyers wrote:
>>> I agree that switching to permissive key in the fast path would be
>>> simpler. AFAIU, the switch_to_permissive_pkey_reg() is only a pkey
>>> read when the key is already permissive.
>>
>> Unfortunately, on x86, PKRU is almost never in its permissive state. We
>> chose a policy (stored in the global init_pkru_value variable) that
>> allows R/W access to pkey 0, but disables access to everything else.
>> It's 0xfffffff5, IIRC.
>>
>> This ensures deny-by-default behavior and ensures that threads cloned
>> off long ago don't have a dangerous PKRU value for newly-allocated and
>> pkey-protected memory.
>>
>> If I had a time machine, it'd be interesting to go back and try to make
>> PKRU's default value be all 0's and also represent the logically most
>> restrictive value.
> 
> Can we assume (or require) that struct rseq and struct rseq_cs reside in
> pkey-0 memory ?

Maybe. Signal stacks are _practically_ only able to use pkey-0. You can
technically protect them with anything you want and then WRPKRU as the
first instruction once you hop into the signal handler (since
instruction fetches aren't affected by x86 pkeys), but I seriously doubt
anybody would go to the trouble.

> In that case, we could add something to the pkey API that switches to a
> permissive state only if pkey 0 cannot be accessed.
> 
> Therefore it would only trigger a pkey read in the common case, and
> issue a pkey write only if pkey 0 is not accessible.
I think that's a sane policy. An rseq access can happen at any time
(from the app's perspective) so the access would theoretically be done
with a random PKRU value from a random point in the thread's lifetime.

But it is a different policy that we've chosen with signals and "remote"
accesses, which is to just ignore pkeys entirely.

I don't have a strong opinion. It's hard to balance performance and
consistency with the other ABI here.

