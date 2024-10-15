Return-Path: <linux-kernel+bounces-365966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 513BE99EEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091231F257C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868241B2188;
	Tue, 15 Oct 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqAyl/AE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5C1FC7C2;
	Tue, 15 Oct 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001164; cv=none; b=GftPcsB4gjmxiv050afd6iix5JS6mMfhck7+T4h1iQcmNCMdRQfo/DuM7g30SL/0SIwrWE/9IC85WoBstqwNNMVqtykfZe+MS3eVmEGoDW5X20IAP6OSZC0IvfGbr0SO9+/9dG5jGv6t9NfatZDcP5lllkcRF1zVzx+62bBczUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001164; c=relaxed/simple;
	bh=27r1rSES3j8OsA1TExPXvfMgHp9/LLg3V6a5TV01u5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llc1chzFfftvkT6ajBctOTQc2QvPFi/ldE1gGc9Xvs5aW5gGDqf33OOfXrfWUfo9LhIW2Ws0hHxmzVpFALi8c4Qza31qdcQc5pqYFJ6AUkCdyJCAlxzjjwYIR0NmV23XAjSjSItOfi8249n1H2f2dcvuEZMSR2rInWq4N/dqa1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqAyl/AE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729001162; x=1760537162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=27r1rSES3j8OsA1TExPXvfMgHp9/LLg3V6a5TV01u5U=;
  b=gqAyl/AEKY4ZG7us/DUZ5yDFpWKbTwGWlOzxadU6iqSFTuPxZjg1XdaU
   v8wnkWCQKyqH2CIKp205CeVqT2dW1Yr2QgyrG0ZFm4rq8M/vr2svDVJGw
   M33EThwYdnfw1274OG7CmuhzebSiKZii26khb82vVCGJTJYspJ+gWPa6b
   a3xmocwHoYZpz2YM0D+6ePVzMMxs1wVcmP71+Oy9U+vJnCrHr8T7SAFXI
   FWfqhxR4hQg+ndGgzx5kp28C/DZY8HnrdfKWqJDn138sddNlT7KMnncct
   gJKywtseehL/yTmWRKGb3l+uO14Y0B3YV1cAXE2TsX56BoHNQGbIC4WVt
   A==;
X-CSE-ConnectionGUID: 47rypLQ9RtKxewLwwgUmHQ==
X-CSE-MsgGUID: U/g9tqBjSrChj9K7nUF3UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28523532"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="28523532"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:06:02 -0700
X-CSE-ConnectionGUID: lHd+9ScYQiWAUQn2Cej4dg==
X-CSE-MsgGUID: BZp6zln0RGa6PMkeK2H5Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="78721214"
Received: from sabrown-mobl1.amr.corp.intel.com (HELO [10.125.224.227]) ([10.125.224.227])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:06:00 -0700
Message-ID: <9ed4ce15-68b8-4604-bbe1-34fb8ca1f9eb@linux.intel.com>
Date: Tue, 15 Oct 2024 07:05:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "Kaplan, David"
 <David.Kaplan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>
References: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
 <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241010045219.vgpcl7nfqaimqrne@treble.attlocal.net>
 <20241010145737.GOZwfrYaGxCOOlaVhy@fat_crate.local>
 <88baaae8-d9fe-4c8a-a5e2-383d6b641e2c@linux.intel.com>
 <20241015135231.GCZw5zn0fnI8dXpHtw@fat_crate.local>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20241015135231.GCZw5zn0fnI8dXpHtw@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 06:52, Borislav Petkov wrote:
> On Mon, Oct 14, 2024 at 08:42:26AM -0700, Daniel Sneddon wrote:
>> The reason I did the patches this way wasn't so much "need" as it just seemed a
>> simpler way to do it. Why have 4 knobs when there is really only 1 mitigation
>> under the hood? My question for you then is what you mean by "proper sync"? I'm
>> guessing you mean that if any one of those 4 mitigations is set to off then
>> assume all are off? 
> 
> Well, up until now at least, we have handled under the assumption that not
> every user knows exactly what needs to be configured in order to be safe.
> 
> So, we have always aimed for a sane default.
> 
> IOW, if a user wants to disable one mitigation but all 4 are mitigated by the
> same thing, then we probably should issue a warning saying something like:
> 
> 	"If you want to disable W, then you need to disable W, X and Y too in
> 	order to disable W effectively as all 4 are mitigated by the same
> 	mechanism."
> 
> And problem solved.

Makes sense. I'll drop the new parameter and add a warning.

Thanks,
Dan
> 
> IOW, I don't expect someone would consciously want to disable a subset of
> those mitigations but leave the remaining ones on. What usually happens, is
> people do "mitigations=off" in order to regain their performance but not do
> this selective thing which doesn't make a whole lot sense to me anyway.
> 
> Thx.
> 


