Return-Path: <linux-kernel+bounces-194486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A708D3D01
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF4C1C2164B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE68184114;
	Wed, 29 May 2024 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfx1a8y/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFBF8BFF
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000886; cv=none; b=djIDeQ6JKL9a98q7KWHCQrBeH+KqMdGpTTO93awcH1/IbvkUC/pnDnE73V+Ccwg4c4+IdOX+t37S3jQ3NeaYF0PiS07iA8IvhslQOngNMzCHRQVfxwccC/77PYTRQfCYtk0BtZbJaZG/EF1axUKez6LkW5eBJvS/ExQEQnWv31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000886; c=relaxed/simple;
	bh=BF0OQFpBMKfRbCkesEFwsRRFCuRZMVJpF9iMn/WCfF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iy64fnFf2XV1bvhGX4EQsvyR7k8odqm9S23ZtRjedLoqYs4gQF+VSpPHqEDecP36PNm9jOc+l3ONH45OKqfn0OQHKnL2Do2+J811nvQwtzaDSTpj5X7Twj2adHZhtf7Y0E03e9fYyKdNc27zrQGNjLYNqkDi+P3+WIOCPnEVkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfx1a8y/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717000885; x=1748536885;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BF0OQFpBMKfRbCkesEFwsRRFCuRZMVJpF9iMn/WCfF4=;
  b=bfx1a8y/K4buwIPzQaZPsMwSJv1rUaX+ZYx/NYY2+XHZi566tM/mhe3z
   /jiseRTWFgva1CGCDit8GlHbnZBGrRvgvEQd6D+vlqREaPHRCeN8xt/m2
   Ut7EZC8G8NkCTed1rqW9PritrYHddClAEKpZKYO5LnYUAapyJzUsaRCNb
   NDJ8eWy0hmny0+7lT6LrM9EhleszdpqFimhYqEsa9A1bTFVea2VWtp4+A
   xi0c7tc/boNHmuvYDJT2vztuKcgn9PTQYcYVD/JcKlLqMDRPn90d+iyKt
   FumvHznyhI+drw8Wow386knRXbeCa4pgEaC+uThuHw2ffF4XXevNjBfgA
   w==;
X-CSE-ConnectionGUID: QtaYWujmSze6WTVlPmigeQ==
X-CSE-MsgGUID: tXtJiuBdTfWiMjftQg24dA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13372390"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13372390"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:41:25 -0700
X-CSE-ConnectionGUID: G80LEDOmSAylmCLCHSRfGg==
X-CSE-MsgGUID: 4cIPuAd3RueYH9hdPiHLSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35577994"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO [10.125.111.96]) ([10.125.111.96])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:41:24 -0700
Message-ID: <961f9533-1e0c-416c-b6b0-d46b97127de2@intel.com>
Date: Wed, 29 May 2024 09:41:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers over
 90%
To: Byungchul Park <byungchul@sk.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, akpm@linux-foundation.org,
 vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
 willy@infradead.org, david@redhat.com, peterz@infradead.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
 <20240529050046.GB20307@system.software.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240529050046.GB20307@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 22:00, Byungchul Park wrote:
> All the code updating ptes already performs TLB flush needed in a safe
> way if it's inevitable e.g. munmap.  LUF which controls when to flush in
> a higer level than arch code, just leaves stale ro tlb entries that are
> currently supposed to be in use.  Could you give a scenario that you are
> concering?

Let's go back this scenario:

 	fd = open("/some/file", O_RDONLY);
 	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
 	foo1 = *ptr1;

There's a read-only PTE at 'ptr1'.  Right?  The page being pointed to is
eligible for LUF via the try_to_unmap() paths.  In other words, the page
might be reclaimed at any time.  If it is reclaimed, the PTE will be
cleared.

Then, the user might do:

	munmap(ptr1, PAGE_SIZE);

Which will _eventually_ wind up in the zap_pte_range() loop.  But that
loop will only see pte_none().  It doesn't do _anything_ to the 'struct
mmu_gather'.

The munmap() then lands in tlb_flush_mmu_tlbonly() where it looks at the
'struct mmu_gather':

        if (!(tlb->freed_tables || tlb->cleared_ptes ||
	      tlb->cleared_pmds || tlb->cleared_puds ||
	      tlb->cleared_p4ds))
                return;

But since there were no cleared PTEs (or anything else) during the
unmap, this just returns and doesn't flush the TLB.

We now have an address space with a stale TLB entry at 'ptr1' and not
even a VMA there.  There's nothing to stop a new VMA from going in,
installing a *new* PTE, but getting data from the stale TLB entry that
still hasn't been flushed.

