Return-Path: <linux-kernel+bounces-520286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D006A3A7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0401889A79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776F1E832F;
	Tue, 18 Feb 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/RP4gEZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C421B9FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908013; cv=none; b=PB5PTdjDaskk54lPuBGSbUCkzMkCIZPYjjbv0/Vcj7VlvUe+onm2fZBAsqjkT/U8xycEeDHyoyiPqRp137up3BZf24wY4TAKZ+pd+E/XGn9OqQ7On6pR4bNz7WuYcoa1g55I/O3/Hwco9+tnpB+HolLcU8CjMw+HUzEyEGuRuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908013; c=relaxed/simple;
	bh=pL+YwqNJy9ZFMxbibhGCNVWj4yE1A7x52CS1b9szg0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYcgUsiudhOoFIgSIAdbmCe0SzcOxCNOS2P2m4Zl9vF6P4i4fronxPxvev7d2vcVpcg4LHN19Ns4AGVCrU0k9IBch3VNfg6W2rqGFnZV3VZdpohh6MrJ85jEwoKQ2qp7J2uff3jmt4ezpObcY9qNnMcqfrzHFxQEVlQDY0FT3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/RP4gEZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739908012; x=1771444012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pL+YwqNJy9ZFMxbibhGCNVWj4yE1A7x52CS1b9szg0g=;
  b=M/RP4gEZ8xpip1nEs/2LWCh8VGVie5Ja/QiyS+omka4vkiFSt+25ZAgx
   FF4GQoD9ZaeJSoHvxfH4Jbegduc2T3yiJGZ4XMiasXqJFzM7Aya9W3qXD
   HH6eZZW3SwhNJ5XKJ/nt40Zf0jj503WDjRaPDBNBtGG0IEoTEgqUoIjX5
   sLDmrMjlBqxRxJewnGrmd9hyBbaW1hOjbtb+RQ3Aa9cCml1lwRf111e99
   1+BxcoTI/y52G4Yfyul6Ao/8HfGY5QqTa5YP/JAaHoZSgE6TIpROvWYuf
   CqeaCYkr9IVdDc/eIrSNGf/dM65Em1vtWIUVV/79Dz3oaD1wgmWxqO1Q7
   A==;
X-CSE-ConnectionGUID: HcCV8cvHRJuX+JLt9cia4Q==
X-CSE-MsgGUID: iFyoL6KoT0WTTzMYTMVP5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40641133"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="40641133"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 11:46:51 -0800
X-CSE-ConnectionGUID: ee0euvK1QfOmbEtKQOCphQ==
X-CSE-MsgGUID: qT2x98PfQH+tPeXKC+r0DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119473286"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.167]) ([10.125.109.167])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 11:46:50 -0800
Message-ID: <a5fb8318-1039-4db5-bd6e-3e45b453c4c2@intel.com>
Date: Tue, 18 Feb 2025 11:46:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/12] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
To: Rik van Riel <riel@surriel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali Shukla <Manali.Shukla@amd.com>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-9-riel@surriel.com>
 <cfa6e15f-3fe5-42bc-a877-fd46bb3c9f88@intel.com>
 <af2ad6d448a551ec0fdf8235195a9d8078da2b13.camel@surriel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <af2ad6d448a551ec0fdf8235195a9d8078da2b13.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 11:31, Rik van Riel wrote:
> On Fri, 2025-02-14 at 10:51 -0800, Dave Hansen wrote:
>> Would that make sense here? It would also preserve the "common case"
>> optimization that's in arch_tlbbatch_flush().
>>
> What we do in this patch goes out the window in patch
> 10. This is just a temporary stage along the way to
> what we have at the end of the series, needed to make
> sure we don't break bisect partway through the series.
> 
> I'm not sure we should be doing much with this patch.
> 
> I could fold it into the next patch, but that would
> make things harder to read.

Ahh, that makes sense. If it's going out the window, could it be
temporarily commented, please? Add the comment here and remove it in
patch 10 (or whatever).

