Return-Path: <linux-kernel+bounces-380919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559139AF7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9001F217A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958618B47A;
	Fri, 25 Oct 2024 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATE2DbBR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4FDC8DF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825499; cv=none; b=M/jn96lY7r2WwoR0xGOT2bKhwY8j6YI35PLNNRtMOQZfp8iWIHnHhTaPY92ipUb5PGbPOh8eHZZBZZ9NjxHOeN7B5Xt4P+xul4IW8tqjvxOuihGtrNVVBO4Q17Wb6mRTg/stH7pKYnoz2IuCnI9lb/ENC1UwaL6WG9RR9CBIh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825499; c=relaxed/simple;
	bh=OfxptnZPGObA1IoIA3jQGTNI9UkLBP3VWd4uZQs7j2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DhKYKRRPf12jbB9Qj5d8QX68tcIfNWuVWpt/7AdyKYAy0MNaxrmzqEPuxapa6WPye9P19+/TsRufJwRBW9U5kxs/ha0OCoipN55R+6fxxAr/GT/DWJE0CqBcN3egu6uVZ5zi3zdjJa1E8za6W+aclsmVZZJHWCIQ4zXiuyaCd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATE2DbBR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825497; x=1761361497;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OfxptnZPGObA1IoIA3jQGTNI9UkLBP3VWd4uZQs7j2A=;
  b=ATE2DbBRSuH4rg+4FfYnXU0FdVt67IW2CxETKWAkpMcEOy1CNUrBSEkw
   IY+dfVGHDqP2xM/s2taWxQJv+L+3GkZ7A/wyvl0cXk0RNZHQtdkNZsaqc
   bCz9Xo5ECmUUadooD8mCuSjx5KmHgXHDjI6JHWXsv8wHN1HeP9gO/dmBy
   jND7v5ZQFzns8UbwrEphtaIDYmxdixOPotT6MKKmMdyORLfZnbw1b2EE3
   1UmvqxdCqkHRwQjcidDl01NnIhvperQtf2rMQq1wOVdlC35SqZbuDbCCB
   NNzIB8GAfxFFfxJxZX1fom0fgTDCMgV4RraV5yFI6zf3B6QEoGx47f09k
   Q==;
X-CSE-ConnectionGUID: MRz49byxT26sxp57jeKkKA==
X-CSE-MsgGUID: e38hD6FYTLCUTmR5On+hVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40029114"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40029114"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:04:56 -0700
X-CSE-ConnectionGUID: EtM16k/bTCCuCPvAcFxTJg==
X-CSE-MsgGUID: RnYbu3bkSdKSBztYqWHoww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80890979"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:04:53 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Peter Zijlstra <peterz@infradead.org>,  Ingo
 Molnar <mingo@redhat.com>,  Will Deacon <will@kernel.org>,
  linux-kernel@vger.kernel.org,  kernel-team@android.com,  Waiman Long
 <longman@redhat.com>,  "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH v3 3/3] lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS
 calculation
In-Reply-To: <20241024183631.643450-4-cmllamas@google.com> (Carlos Llamas's
	message of "Thu, 24 Oct 2024 18:36:28 +0000")
References: <20241024183631.643450-1-cmllamas@google.com>
	<20241024183631.643450-4-cmllamas@google.com>
Date: Fri, 25 Oct 2024 11:01:20 +0800
Message-ID: <87ed443myn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Carlos Llamas <cmllamas@google.com> writes:

> Define a macro AVG_LOCKDEP_CHAIN_DEPTH to document the magic number '5'
> used in the calculation of MAX_LOCKDEP_CHAIN_HLOCKS. The number
> represents the estimated average depth (number of locks held) of a lock
> chain. The calculation of MAX_LOCKDEP_CHAIN_HLOCKS was first added in
> commit 443cd507ce7f ("lockdep: add lock_class information to lock_chain
> and output it").
>
> Suggested-by: Waiman Long <longman@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: J. R. Okajima <hooanon05g@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

LGTM, Thanks!  Feel free to add

Acked-by: "Huang, Ying" <ying.huang@intel.com>

in the future versions.

> ---
> v3: collect tags
> v2: switched the comment for a macro as suggested by Waiman Long.
>
>  kernel/locking/lockdep_internals.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index bbe9000260d0..20f9ef58d3d0 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -119,7 +119,8 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
>  
>  #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
>  
> -#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
> +#define AVG_LOCKDEP_CHAIN_DEPTH		5
> +#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS * AVG_LOCKDEP_CHAIN_DEPTH)
>  
>  extern struct lock_chain lock_chains[];

