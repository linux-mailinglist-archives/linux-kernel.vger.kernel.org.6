Return-Path: <linux-kernel+bounces-387218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D139B4E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A468B217E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5D1946B1;
	Tue, 29 Oct 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mv2sLZuq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0BF2BAF9;
	Tue, 29 Oct 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216037; cv=none; b=rbjm593hwsQ5PydUbEVgOgkR8k723hA1/B0GlpX9Ioz+vUPVm2AMSDUCxNCsmotmWmZHUsFoYcb/qX1Xl5YPFyuOfarzp5a+a9g7U80PQOPnqtdaAs2JO0rIPvESgianLN9CiRbUMH/uL/eD/HBcXxEE48+3p5CQYHoZXxfOgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216037; c=relaxed/simple;
	bh=RYKnZEqv2AHz7GCuZ5H2lCG+grAInnpuLE/fCCTz1r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Udn26tAyh8mc3R6LZTeoCpdcLL9MsQdotGW7afTmrUN1UvJ3Bz5JfeB+1JqL/MpsXGdWbNUCp+L3QfkyqF68/NFK8+yCsl0q2gNexxSCdKatMG4B+aGVpzb7BFcvGywwP1aoXgCrEumorRiREYBNq1qOQegSqfFV5oxRSJlDvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mv2sLZuq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730216035; x=1761752035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RYKnZEqv2AHz7GCuZ5H2lCG+grAInnpuLE/fCCTz1r0=;
  b=Mv2sLZuq0bdK9RpS6m/zJ5hfkm1SJh+yw6PzcwmJG+NayApKQSDHnXaG
   RsvzRFpJ+Y7iSrKCCq2yU7y6fA3PXB1d9SV4+3Gyk1IHbULq3GnrYOcYb
   yU8uQUZunhege5TJHrGqGvuzWU8tb2alSB6cnxqdA/XjTbjsyahu912Kn
   56osHchO/vLJWbbh5GIXfV8UBHoCzQMvnWzrQDc+tdF74UKAUUYt/+Ebp
   uPiHcWCPy4w9qSsRUCAw6wSxewkUzcWYTl8UWP1HEKUOlrkX76kyWravc
   ZeHqHICuGeSazHSxmDLYbbVM3iQbV5E0Z/3f4i1eB3FdvqMkQ0OCnqu0C
   A==;
X-CSE-ConnectionGUID: xHwpOvutTwywtS05OBZiCQ==
X-CSE-MsgGUID: YHEhFR9lR3WmBVT3L/PawA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="40479788"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="40479788"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:33:54 -0700
X-CSE-ConnectionGUID: SCEnkM6XSQWvufkUdTgvgQ==
X-CSE-MsgGUID: 39/2vntDTvC1Ppbl3e09Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86557459"
Received: from jerrycli-mobl2.amr.corp.intel.com (HELO [10.125.224.112]) ([10.125.224.112])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:33:52 -0700
Message-ID: <f82878e8-fdf7-4a73-93a1-2edf52fc0145@linux.intel.com>
Date: Tue, 29 Oct 2024 08:33:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/bugs: Clean-up verw mitigations
To: Borislav Petkov <bp@alien8.de>, David Kaplan <David.Kaplan@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, hpa@zytor.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
 <20992658d2c79f27de91a474a7b122782be5f04b.1730158506.git.daniel.sneddon@linux.intel.com>
 <20241029113702.GUZyDI3u_6IxiCWOBJ@fat_crate.local>
 <c5fa82d7-e5e9-4612-a238-3c58152c40d0@linux.intel.com>
 <20241029150022.GJZyD4ht9wYcVetdDS@fat_crate.local>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20241029150022.GJZyD4ht9wYcVetdDS@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 08:00, Borislav Petkov wrote:
> On Tue, Oct 29, 2024 at 07:40:28AM -0700, Daniel Sneddon wrote:
>> Sure, I'll split this up as much as possible.
> 
> Actually, thinking about this more and looking at David's rework:
> 
> https://lore.kernel.org/r/20240912190857.235849-1-david.kaplan@amd.com
> 
> his basically is achieving what you're doing - a post-everything routine which
> selects the final mitigation strategy once all the mitigation options have
> been parsed and evaluated.
> 
> So I'm wondering if we should simply take his directly...
> 
> He removes that md_clear* function:
> 
> https://lore.kernel.org/r/20240912190857.235849-8-david.kaplan@amd.com
> 
> in favor of doing the final selection in the ->apply* functions and keeping
> each mitigation functions simple.
> 
> Yours does this in a single function.
> 
> Practically speaking, the end result is the same.
> 
> Hmm...
> 
I really like the attack vector idea David is using. I suspect people really
care about "protect my kernel from bad users" or "protect my host vm from
guests" more than "protect me from mds and rfds." I was trying to get rid of the
need to do a call to any kind of update function where he took the existing
function and split it into one for each mitigation that needs it. Like you said,
different approach same end result really.

