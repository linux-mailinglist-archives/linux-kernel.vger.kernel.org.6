Return-Path: <linux-kernel+bounces-233687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F110D91BB89
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE00283D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952A15278C;
	Fri, 28 Jun 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvkNPBwm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220022139A8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567248; cv=none; b=ERgtu4aZP1WKd5Xalv/SnvEIn4vQjX0ix4XhHug5em3W+b5DXlzhpHI66rZyHLzVrbgv25ANugQhdtVpKHMDq7dvwIDbxz7A3XnAYdVB/CJJ9dbwbL3vv6m5wORq7q0X5p8lj3nimX9+uU6GIwpn7U7M7eU8XBYKU65/CfhK9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567248; c=relaxed/simple;
	bh=LEVvzNioSQDou1T1dnSAxbhkKOKKKilGUTvJu0AQs5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iV5RJFfTd1nBysSH+l/xDsqyU7WTs/goHT1dTZuYj/0epcvHjjdNHGuKp05Nxeq+P6lYKLPthT7mQ3RuAwRz2Fil1V7TqOmuMVB7rAcWaD2IB5uKtHc+UJ0AiTN99YO6u8AwmjYZLSC3y1WtWI+r1ooigMX4LHLi0J6/aWKlLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvkNPBwm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719567247; x=1751103247;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LEVvzNioSQDou1T1dnSAxbhkKOKKKilGUTvJu0AQs5M=;
  b=hvkNPBwmv9svLvZ8PhSbsd6w0Oy4enVR4zLsOC3zmPy+JwVbXEcrqLaq
   k+6gWOmvPOBL0pt8aWgWRU2dc4U7v2gUKsSGXE2Aw2bWCqV/uMVSnpb/T
   io4HGygRND2aF2NdopBmCpaA+sGnK9/56YNz70F5W+V44an/YU98iMiwo
   Wg3gUSSKOBoLAFr6kBBv0Xoq7iQj46zSEeQ26Qd3YHrpKqi/pHbzwhYCr
   vj4NaWcI4HPtZqCm9zwFa9w+aAEl4acClwz19aZ8OAw9B6cYWfNZ2UFff
   dmcBjrIsWDvV+uSlqTjrtLE7amz1TXrMyCASNhoH8Z46b/WSebi/C8p0u
   Q==;
X-CSE-ConnectionGUID: 8rkc5kebQFOpYz7IeYvCcw==
X-CSE-MsgGUID: 8bL1FWFoTSK4Vnsr6f4YSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27364259"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="27364259"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:34:07 -0700
X-CSE-ConnectionGUID: qRsbWrKJR1a+tDtL0TkKLg==
X-CSE-MsgGUID: e9HS4RXUQpKptKvk9Z+pMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="49026398"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:34:03 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Matthew Wilcox <willy@infradead.org>,  Tvrtko Ursulin
 <tursulin@igalia.com>,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kernel-dev@igalia.com,  Mel Gorman <mgorman@suse.de>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Rik van Riel
 <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Dave Hansen
 <dave.hansen@intel.com>,  Andi Kleen <ak@linux.intel.com>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
In-Reply-To: <22e9cd24-1ed4-4f1d-b7de-b44cefca6009@igalia.com> (Tvrtko
	Ursulin's message of "Fri, 28 Jun 2024 09:56:05 +0100")
References: <20240625132605.38428-1-tursulin@igalia.com>
	<Zn3eBbJ377VeZGcc@casper.infradead.org>
	<87bk3lpxp1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<22e9cd24-1ed4-4f1d-b7de-b44cefca6009@igalia.com>
Date: Fri, 28 Jun 2024 17:32:12 +0800
Message-ID: <87y16po1k3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Tvrtko Ursulin <tvrtko.ursulin@igalia.com> writes:

> On 28/06/2024 04:12, Huang, Ying wrote:
>> Hi, Matthew,
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>>> On Tue, Jun 25, 2024 at 02:26:05PM +0100, Tvrtko Ursulin wrote:
>>>>   		/*
>>>> -		 * Currently, the only defined flags are mutually exclusive
>>>> +		 * The below two flags are mutually exclusive:
>>>>   		 */
>>>>   		if (flags & MPOL_F_STATIC_NODES)
>>>>   			p += snprintf(p, buffer + maxlen - p, "static");
>>>>   		else if (flags & MPOL_F_RELATIVE_NODES)
>>>>   			p += snprintf(p, buffer + maxlen - p, "relative");
>>>> +
>>>> +		if (flags & MPOL_F_NUMA_BALANCING)
>>>> +			p += snprintf(p, buffer + maxlen - p, "balancing");
>>>>   	}
>>>
>>> So if MPOL_F_STATIC_NODES and MPOL_F_NUMA_BALANCING are set, then we
>>> get a string "staticbalancing"?  Is that intended?
>>>
>>> Or are these three all mutually exclusive and that should have been
>>> as "else if"?
>> Yes, this is an issue!
>
> Sigh, my apologies. I was sure I tested it as this patch was part of a
> larger series I have, but then I decided to extract it and send out
> and the problems obviously go deeper. What I think happened is that I
> probably only tested the other direction, setting of via
> mpol_parse_str().
>
> Andrew please dequeue it if you haven't already?
>
>> Dig the git history, in commit 2291990ab36b ("mempolicy: clean-up
>> mpol-to-str() mempolicy formatting"), the support for multiple flags are
>> removed.  I think that we need to restore it.
>> Done some basic testing.  It was found that when
>> MPOL_F_NUMA_BALANCING
>> is set, /proc/PID/numa_maps always display "default".  That is wrong.
>> This make me think that this patch has never been tested!
>> The "default" displaying is introduced in commit 8790c71a18e5
>> ("mm/mempolicy.c: fix mempolicy printing in numa_maps").  We need to fix
>> it firstly for MPOL_F_NUMA_BALANCING with more accurate filtering.  The
>> fix needs to be backported to -stable kernel.
>
> Will you work on this or I can follow up if you want?

Please go forward to work on this, Thanks!

--
Best Regards,
Huang, Ying

