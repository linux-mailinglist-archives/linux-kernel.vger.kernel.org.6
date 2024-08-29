Return-Path: <linux-kernel+bounces-305930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4964A96368C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1C61C20F99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F4BF4E7;
	Thu, 29 Aug 2024 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEhsA3CW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EDD360
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889683; cv=none; b=HKokX5BrOWAi0gLs8Jdp2rWUVHB47hXyN7HQXlCPGKxhmfsCJ+VoQ/C7qSIdgL79VjK4Uq6VJK3ARTRs8MqlBLHUNXaRTJb9NJe1rrtq3wtrfvEnfOuR+IZCBUPFoyyjFq7Ss4jwfEZ2K3sYe4691KeaNzGJRKXcSRpscToKPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889683; c=relaxed/simple;
	bh=GjbzIuAlthsXz27K5RH+SfP2AqIbwbU2yVfqjSwCkD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljkYn2AoT7j8gn5MEfBJzRvMLQXe/xS/8Ev5AzNoTaqAcNiBZMPoXJCffqVde1rKuuYeY/ZrE4QE4S7JcEddulTC/y2nvddvuECdmoSImByi7xYVNs7fv/4p2/3NZg/8h4fexya1Bpv8jiS2ZEvONTrqQDRpWs5SwWZh600fB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEhsA3CW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724889682; x=1756425682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GjbzIuAlthsXz27K5RH+SfP2AqIbwbU2yVfqjSwCkD8=;
  b=dEhsA3CWeoI/12HkmWZRvDAePRlzm+ufGa2IFFD18/Pp7vu6c2Nzw4aJ
   mfLI9VbEYOdyzMTtVHJqnw6jl6/2zA6U+vIxxmpG/OVdoP5yhVWAqn6Ev
   v+kZCnPLEw5vqv0iO/nxaGRR/IKTB8PDSBw58kgEcSaU9UFRNhzDV9mBZ
   VOQqL4XTv438/h499eTWRivIVcNnLVQN8wI/FEbs9HdDJlLasamLqgztd
   wyiK2SPXu19gCkV+JRoQC4ORc5xJHwuUrBTTsmoPK9v0QNKfdYbeX/4lA
   VTiNLsxPqnMmNajRcpowq2X2+2E4gslhl5QgHUkVpRss5LSUFAJc3zyLz
   w==;
X-CSE-ConnectionGUID: RukKH2MYTyCWHC6VM4Ws5A==
X-CSE-MsgGUID: 5LK6E24/SWSVfsDVGxh7Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="48836062"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="48836062"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 17:01:21 -0700
X-CSE-ConnectionGUID: aqLplJCLQ3Wx8KWYYBDddw==
X-CSE-MsgGUID: AuNe0ePUT7qjG5UtAGJeGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="86589208"
Received: from njkybert-mobl.amr.corp.intel.com (HELO [10.125.160.160]) ([10.125.160.160])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 17:01:20 -0700
Message-ID: <8538c0b5-fde8-4e54-be91-24bcfb31c7ab@linux.intel.com>
Date: Wed, 28 Aug 2024 17:01:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/bugs: Add missing NO_SSB flag
To: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc: pawan.kumar.gupta@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20240828224011.4043872-1-daniel.sneddon@linux.intel.com>
 <9e510f2e-4b11-4001-b6c0-7a3766b8abb4@intel.com>
 <dc28f36b-87fa-4aac-8578-6468ae311b16@linux.intel.com>
 <4ff867b7-e5b1-4b91-87cf-127b2e908025@intel.com>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <4ff867b7-e5b1-4b91-87cf-127b2e908025@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/28/24 16:54, Dave Hansen wrote:
> On 8/28/24 16:50, Daniel Sneddon wrote:
>> On 8/28/24 16:36, Dave Hansen wrote:
>>> On 8/28/24 15:40, Daniel Sneddon wrote:
>>>> The Moorefield and Lightning Mountain Atom processors are
>>>> missing the NO_SSB flag in the vulnerabilities whitelist.
>>>> This will cause unaffected parts to incorrectly be reported
>>>> as vulnerable. Add the missing flag.
>>> It'd be really cool to add two things to these changelogs: First, who
>>> figured this out and how?  Basically, who cares and why?  Second, what
>>> public Intel documentation supports this change?
>> The first thing I can do no problem. The second..... 🙁
> 
> Heh, I went looking just after I asked.  These CPUs are ghosts as far as
> the docs are concerned.  I assume because they are end-of-life'd (or
> whatever the proper name is).  But even saying _that_ in the changelog
> would be helpful.

Will do!

