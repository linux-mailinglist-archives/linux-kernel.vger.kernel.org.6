Return-Path: <linux-kernel+bounces-570100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59374A6AC05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61EB7AF874
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9567C224236;
	Thu, 20 Mar 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMBRyfW5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7932144C9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491876; cv=none; b=kaInD08qSpMR/MoWfUFTLaC3gnxoqNfUgbBkOwRW+8FnkD+glLNHmSa6yKM6RS33h9m9UWdwjYnbf4CvqGnownWbzROkfYnZcnZHy5vc1FvIMKfT5B8YS5y5oOo7GGUVSo5lG5grq7fUjpgA7/knpNu7C/S7qvCe0cVMSemcVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491876; c=relaxed/simple;
	bh=soFbqUr3oF8SA23mqFbjb7rs05LKmXU7PMJJNAX8p4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InRXS3DyKNsbO/mBRrqQpVyg7NSt4QMemy8X9j5i1K3XsKxdLkB6TZrPRJBDHJvEzv3S25gLLWi+qIhw1u9ot0N2ze+xsUD7lEy0eEkTM/uMTAXTj6qDz7oxk/KVVIsGnHBKZaM9PGWl17nM98OSZkash7yRadn3+8VHsBvEaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMBRyfW5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742491874; x=1774027874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=soFbqUr3oF8SA23mqFbjb7rs05LKmXU7PMJJNAX8p4U=;
  b=gMBRyfW51NOicHndIgfYKiRIRbYk5wQsVZ5g8dtktnOrVuvo8KQEiFjF
   1mhAlzXsfzzTEC9WMFoRV9gFUjjgBWK5fEFHgUIb5/eq9EaW+vpjDVkX9
   oVTN/fuiXvLCirCD6Emw40EnM29UEnVH3g0engL0+Kd+DoSmMRp6gw45G
   5cNtTlEq6BlXLU07oj3NLOqstSqUdHLMLzLkK0ka9yMMVjoP8VQ+JDFnQ
   zgtOKQIn3xbqNOCSPV2cByUwPUsLJPVDZtyt0RzNfhopQcDnO5msjOPjM
   wTIG2bd+8rlKBh8vAceT1sQrLCpBV16pslBLkO5rZ+jjLO0MQ3kVdwb8L
   g==;
X-CSE-ConnectionGUID: zgLOJe37SqGLV2obAXxjOw==
X-CSE-MsgGUID: 479hpQwpTROni32nKl2kxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69095419"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="69095419"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:31:14 -0700
X-CSE-ConnectionGUID: staVE5iLRNOXpGgPxamkIw==
X-CSE-MsgGUID: JHMDyS7uS8qLU2EMXjDxWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="146383640"
Received: from agrisant-mobl2.amr.corp.intel.com (HELO [10.125.1.252]) ([10.125.1.252])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:31:13 -0700
Message-ID: <659f2fb8-97de-4a3e-9d8d-0a61f8ad552d@linux.intel.com>
Date: Thu, 20 Mar 2025 10:31:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: move hugetlb_sysctl_init() to the __init
 section
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250319060041.2737320-1-marc.herbert@linux.intel.com>
 <20250319002228.44e220b1ffadb4cc994ad4cf@linux-foundation.org>
Content-Language: en-US
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <20250319002228.44e220b1ffadb4cc994ad4cf@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025-03-19 00:22, Andrew Morton wrote:
> On Wed, 19 Mar 2025 06:00:30 +0000 marc.herbert@linux.intel.com wrote:
> 
>> hugetlb_sysctl_init() is only invoked once by an __init function and is
>> merely a wrapper around another __init function so there is not reason
>> to keep it.
>>
>> Fixes the following warning when toning down some GCC inline options:
>>
>>  WARNING: modpost: vmlinux: section mismatch in reference:
>>    hugetlb_sysctl_init+0x1b (section: .text) ->
>>      __register_sysctl_init (section: .init.text)
>>
> 
> Huh.  I wonder why this just started happening.

As I just mentioned, I see this warning only because I'm playing with
GCC flags.

Not sure how good is that page but its name is perfect here:
https://stackoverflow.com/questions/59388740/gcc-shows-different-warnings-depending-on-optimisation-level

Also, https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Warning-Options.html
> The effectiveness of some warnings depends on optimizations also being
> enabled. For example -Wsuggest-final-types is more effective with
> link-time optimization and some instances of other warnings may not be
> issued at all unless optimization is enabled. While optimization in
> general improves the efficacy of control and data flow sensitive
> warnings, in some cases it may also cause false positives.

That particular warning was very minor but simple and valid; not a false 
positive. It was also the only "section mismatch" warning found in my
entire configuration.

Marc

PS: who needs expensive static analysis tools when unusual combination of
compiler flags can find issues? :-D

