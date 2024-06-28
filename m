Return-Path: <linux-kernel+bounces-233311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0DE91B55A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A3E28255D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491E91DFCB;
	Fri, 28 Jun 2024 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7U0Ea3Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC01CA9F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544478; cv=none; b=deLggnFRTW0HqZc1WNWOaUY6h52aYh3orzWE4SXl3Pwt+3QkSX7LOsTPGRMkWhyZDGzFCxJjlMQUMw03+nN3GIrwcySAE2Xbm5TNKK5dXusm4c2vMeut0B6rKv1MRAbVrs0iqOhrLHWtViC/KO5hW48gc74WW35GyLWgYw3Kvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544478; c=relaxed/simple;
	bh=Bzq47XhevB6u5PJXXfvJm5NF4hcYGfBkxsvTtTkm0s4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WvmNqTyQr2+zBcE/aCz8dNB1CLvEm9IRu1z+gOZB/Zm886NNCdr95Tjo/OFAj5gVWmTYh7I0SmRIA+xaStHDc+b0dPx16Pn+MMOBa7UCQUYDwWpVtJio/PbWbvv3bLk8McGxMOpWjETrCv//QkG7eLhPMxfjI/rTsv1rl096nFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7U0Ea3Y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719544477; x=1751080477;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Bzq47XhevB6u5PJXXfvJm5NF4hcYGfBkxsvTtTkm0s4=;
  b=J7U0Ea3YfbuQOtJ5BMhaZpQvo3GvWCD6z6ozdfR5c/ExRNCmM5d5iS/W
   V2P0vkvGIY1QjHC/Mld/tK74ixMo5e6tnQ0oC5vMH9RqsOkKlBn9R3AAU
   riXmmQqzsyqPRc7GlLj2DYBSnWKQoa0+HylUqDik5Ogl4RM7R2WfUcybv
   tyeMx3RQ0dRFHqdIfkNvq2syLAiNzV+yWoLcSxk1jIW/VpBR973y0VUUC
   eiZM/W3H6Kdksi880pRTYRGIYswnZlvzcw2OxjKW2A+QtiNkASTSmyY2F
   hi4uIeFB92uVfpIr+YVY7yUu3Bo6kutcpnRnHzuqJ8GNRZ0uWK57IBKQZ
   A==;
X-CSE-ConnectionGUID: lR9H9zSYQe6mDhirHjvhtA==
X-CSE-MsgGUID: Mkb+IyNqTKaz5TWXoelG+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20586201"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="20586201"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:14:36 -0700
X-CSE-ConnectionGUID: C5ITdqycQzubiTvSB+KJKA==
X-CSE-MsgGUID: nj28SOedSDuH1xIg37Yopg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="67799095"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:14:33 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Tvrtko Ursulin <tursulin@igalia.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com,  Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>,  Mel Gorman <mgorman@suse.de>,  Peter
 Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Rik van
 Riel <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Dave
 Hansen <dave.hansen@intel.com>,  Andi Kleen <ak@linux.intel.com>,  Michal
 Hocko <mhocko@suse.com>,  David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
In-Reply-To: <Zn3eBbJ377VeZGcc@casper.infradead.org> (Matthew Wilcox's message
	of "Thu, 27 Jun 2024 22:47:49 +0100")
References: <20240625132605.38428-1-tursulin@igalia.com>
	<Zn3eBbJ377VeZGcc@casper.infradead.org>
Date: Fri, 28 Jun 2024 11:12:42 +0800
Message-ID: <87bk3lpxp1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Matthew,

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Jun 25, 2024 at 02:26:05PM +0100, Tvrtko Ursulin wrote:
>>  		/*
>> -		 * Currently, the only defined flags are mutually exclusive
>> +		 * The below two flags are mutually exclusive:
>>  		 */
>>  		if (flags & MPOL_F_STATIC_NODES)
>>  			p += snprintf(p, buffer + maxlen - p, "static");
>>  		else if (flags & MPOL_F_RELATIVE_NODES)
>>  			p += snprintf(p, buffer + maxlen - p, "relative");
>> +
>> +		if (flags & MPOL_F_NUMA_BALANCING)
>> +			p += snprintf(p, buffer + maxlen - p, "balancing");
>>  	}
>
> So if MPOL_F_STATIC_NODES and MPOL_F_NUMA_BALANCING are set, then we
> get a string "staticbalancing"?  Is that intended?
>
> Or are these three all mutually exclusive and that should have been
> as "else if"?

Yes, this is an issue!

Dig the git history, in commit 2291990ab36b ("mempolicy: clean-up
mpol-to-str() mempolicy formatting"), the support for multiple flags are
removed.  I think that we need to restore it.

Done some basic testing.  It was found that when MPOL_F_NUMA_BALANCING
is set, /proc/PID/numa_maps always display "default".  That is wrong.

This make me think that this patch has never been tested!

The "default" displaying is introduced in commit 8790c71a18e5
("mm/mempolicy.c: fix mempolicy printing in numa_maps").  We need to fix
it firstly for MPOL_F_NUMA_BALANCING with more accurate filtering.  The
fix needs to be backported to -stable kernel.

--
Best Regards,
Huang, Ying

