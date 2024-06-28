Return-Path: <linux-kernel+bounces-233634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4491BA82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A180282C29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607F814D422;
	Fri, 28 Jun 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UBDbLBJL"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5014E2DA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565004; cv=none; b=syLs77jdquoMrWwGA34nj2uPhQbzQyvqTqhk5YktiyJ7k+RNA2Shc6Rfl9q3SkSKUS/4X+oXuOfWa4ubBOQ84uXIU0HNgXockxQ96ltRNj71J6T32h12853hBR2TJgxIGzt/uKmrhLAHMxlqZxDHHaL7R/eySJSskC4XDValyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565004; c=relaxed/simple;
	bh=znXyHZwpRegc3NlJkQFlZs+vsfwKbAj6NOxYYmocGbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myknmk7tGV8xbTIhq+UnxyMXDH8nVHnlGRk4AKrECP2/P+bPSU8BPX5ev9wLMSDzhyTfUmn3iQW3F/Hfsw8xp5v2Sc6bevatY/ccqjvGTqnAGrMvOOA7TI0qW021sNomFqyzxN7YcGcbtdaw9KQsXLi8n6iZ8wa8hBiq6kP4HUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UBDbLBJL; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ABLvUC/ePHzSEuBbp1KLhmP8GQstWD4khOur3Y/Z+Is=; b=UBDbLBJLDaySytJdd/gG1JXQEK
	LUqoxxEwnrvLmfKs0klpIjjoUNPz66cElli4bZRd5uRmnrV9bs5GfoYvqtzdpLggOFlMfiT5N1DXv
	9imsnlKes9ddmUi4du72f9ekeb0kDCGIHENUjobK8hr1QOUUhvB86rRTnizukPD7NJgNhvr/fXn/A
	BsQqOXtms4TFyeztfb7NHID60EduJg3EwagzX7Y4soBxDPFkKEpjzEN31ze2/v1LVc1atm3GeiLsh
	g5LVCOMgCR6v5ftR9Pc+wRftfYg3HhFuLgebl7xxxIBCMdtJmQeoAZqFsulKch6I4QzTN3ROtYT5H
	NA9PT2bA==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sN7Oo-008XRH-Hh; Fri, 28 Jun 2024 10:56:06 +0200
Message-ID: <22e9cd24-1ed4-4f1d-b7de-b44cefca6009@igalia.com>
Date: Fri, 28 Jun 2024 09:56:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/numa_balancing: Teach mpol_to_str about the balancing
 mode
To: "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>
Cc: Tvrtko Ursulin <tursulin@igalia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Dave Hansen <dave.hansen@intel.com>,
 Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>
References: <20240625132605.38428-1-tursulin@igalia.com>
 <Zn3eBbJ377VeZGcc@casper.infradead.org>
 <87bk3lpxp1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <87bk3lpxp1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 28/06/2024 04:12, Huang, Ying wrote:
> Hi, Matthew,
> 
> Matthew Wilcox <willy@infradead.org> writes:
> 
>> On Tue, Jun 25, 2024 at 02:26:05PM +0100, Tvrtko Ursulin wrote:
>>>   		/*
>>> -		 * Currently, the only defined flags are mutually exclusive
>>> +		 * The below two flags are mutually exclusive:
>>>   		 */
>>>   		if (flags & MPOL_F_STATIC_NODES)
>>>   			p += snprintf(p, buffer + maxlen - p, "static");
>>>   		else if (flags & MPOL_F_RELATIVE_NODES)
>>>   			p += snprintf(p, buffer + maxlen - p, "relative");
>>> +
>>> +		if (flags & MPOL_F_NUMA_BALANCING)
>>> +			p += snprintf(p, buffer + maxlen - p, "balancing");
>>>   	}
>>
>> So if MPOL_F_STATIC_NODES and MPOL_F_NUMA_BALANCING are set, then we
>> get a string "staticbalancing"?  Is that intended?
>>
>> Or are these three all mutually exclusive and that should have been
>> as "else if"?
> 
> Yes, this is an issue!

Sigh, my apologies. I was sure I tested it as this patch was part of a 
larger series I have, but then I decided to extract it and send out and 
the problems obviously go deeper. What I think happened is that I 
probably only tested the other direction, setting of via mpol_parse_str().

Andrew please dequeue it if you haven't already?

> Dig the git history, in commit 2291990ab36b ("mempolicy: clean-up
> mpol-to-str() mempolicy formatting"), the support for multiple flags are
> removed.  I think that we need to restore it.
> 
> Done some basic testing.  It was found that when MPOL_F_NUMA_BALANCING
> is set, /proc/PID/numa_maps always display "default".  That is wrong.
> 
> This make me think that this patch has never been tested!
> 
> The "default" displaying is introduced in commit 8790c71a18e5
> ("mm/mempolicy.c: fix mempolicy printing in numa_maps").  We need to fix
> it firstly for MPOL_F_NUMA_BALANCING with more accurate filtering.  The
> fix needs to be backported to -stable kernel.

Will you work on this or I can follow up if you want?

Regards,

Tvrtko

