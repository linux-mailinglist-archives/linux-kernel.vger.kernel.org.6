Return-Path: <linux-kernel+bounces-515864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35DA369F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318EE3AFC09
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC52F4ED;
	Sat, 15 Feb 2025 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAmgBlee"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB02904
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739579349; cv=none; b=Z1U7P3Thd9jUv4ciyVQeZCSeyi8ke2ycYWSeaCmFKaZHYi/scdOE1kQ+S4LzlnlR0T1vKJz/7uCaJ8WozXo2i6wD96JRdepVxH9ekhga9R6xYCR4KQUVTVf+uRTxWw1r2YsUoJBiaaM6biDUGVGRROolZPG5b7vYBWDnKF/S6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739579349; c=relaxed/simple;
	bh=P27/hT/weIjtquGnBx330wbjO66MKgMe+qdGrdfJqYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ic7JbRM4l0Qhcmu5ie2z0PokmpMIo4LtyCtQz9Y4OvocaWuTXqdXO9nLAmP1R4eCMx0cGbn13k3zWRyzNImtcbZY3OZhgLWMwSgeL/UOmgQe1uV57OR6eDSQlcRQ62iP+MR79+Qx1eUGV2yFcRPsZiRjFPui5sVZ9ainAqE3yqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAmgBlee; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739579348; x=1771115348;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P27/hT/weIjtquGnBx330wbjO66MKgMe+qdGrdfJqYk=;
  b=mAmgBleeDYJ0zbhohcZIcwiectcNaBawZ/YJb5mFxjpkvEJ4Dc9a4ad0
   TtGUbnSGUUklS0032+H1cnEKLWhok6OM2hKjCSnbGGRlvCI32GS2uGnj7
   kTwKERzAepPDb8BX4nw+wO+ZYs0lIHih9MRMymB7NggN8QYKtv+ItJBG7
   WNanP8uOAnPpsV4YC2v7ql7b6Hrj1EqM8YMEqaZnNSPP8x9L6PPE0nOb2
   89ArWpmDZyPcxhU67LEslDc6/KDDHNuUZHqusXS4SNL8m/GkssJvzmlmw
   p4r5m+rZNwgQZret7XklfoloywiS/1VWBXu+Bf25Add90iQGZHeTahkX3
   g==;
X-CSE-ConnectionGUID: aLs19telRi6czc+zuRAgnw==
X-CSE-MsgGUID: mVZXnF1oRbe/dnylLk8+CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43174084"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="43174084"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 16:29:07 -0800
X-CSE-ConnectionGUID: k3YRP63cT6GkTgSeG5TQhQ==
X-CSE-MsgGUID: 41fCpgYbRKWLGEctqiFZhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="113561237"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.93]) ([10.125.109.93])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 16:29:08 -0800
Message-ID: <0bed366e-a0e5-4d1a-b677-afad23235bcf@intel.com>
Date: Fri, 14 Feb 2025 16:29:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] x86/vmemmap: Add missing update of PML4 table / PML5
 table entry
To: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 linux-kernel@vger.kernel.org, osalvador@suse.de, byungchul@sk.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 akpm@linux-foundation.org, max.byungchul.park@sk.com,
 max.byungchul.park@gmail.com
References: <20250214195151.168306-1-gwan-gyeong.mun@intel.com>
 <20250214195151.168306-2-gwan-gyeong.mun@intel.com>
 <25b9d3f5-bfe8-48a9-b11b-819d19cfae1e@intel.com>
 <Z6_d1MvorGFpxdU1@MacBook-Air-5.local>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <Z6_d1MvorGFpxdU1@MacBook-Air-5.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/25 16:20, Harry (Hyeonggon) Yoo wrote:
> On Fri, Feb 14, 2025 at 11:57:50AM -0800, Dave Hansen wrote:
>> On 2/14/25 11:51, Gwan-gyeong Mun wrote:
>>> when performing vmemmap populate, if the entry of the PML4 table/PML5 table
>>> pointing to the target virtual address has never been updated, a page fault
>>> occurs when the memset(start) called from the vmemmap_use_new_sub_pmd()
>>> execution flow.
>>
>> "Page fault" meaning oops? Or something that we manage to handle and
>> return from without oopsing?
> 
> It means oops, because the kernel accesses part of vmemmap that's not
> populated (yet) in current process's page table.

Your 0/1 cover letter got to me after this mail did. I see the oops
there clear as day now.

> This oops was observed after increasing the size of struct page (as a part of
> developing a debug feature), but the real cause is that page table entries are
> only installed in init_mm's page table and then sync'd later, but in the mean
> time the process that triggered hot-plug accesses new portion of vmemmap.
> 
> If the process does not directly use the page table of init_mm (like swapper)
> this oops can occur (e.g., I was able to trigger with `sudo modprobe hmm_test`
> after increasing the size of struct page).

Makes sense.  Thanks for the explanation.

>>> This fixes the problem of using the virtual address without updating the
>>> entry in the PML4 table or PML5 table. But this is a temporary solution to
>>> prevent page fault problems, and it requires improvement of the routine
>>> that updates the missing entry in the PML4 table or PML5 table.
>>
>> Can we please skip past the band-aid and go to the real fix?
> 
> Yes, of course it'd best to skip a temporary fix.
> The intention is to report/discuss the problem and a fix as a starting point.

Do you have a better fix in mind?


