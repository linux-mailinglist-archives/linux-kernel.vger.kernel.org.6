Return-Path: <linux-kernel+bounces-318306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9BF96EB94
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638682859CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8615314A0B9;
	Fri,  6 Sep 2024 07:06:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B83B1A2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606408; cv=none; b=lQFzASkJKHOPjO2gfRe/Q+z3mtuXEq/bf6u4KpNmKmm5kGzGhoeTj0m3jpYwBgKrzyQOTY01keMA7KhkOt5uGkCEp+jhuRQWXV9bLLRutwTB25FwwNezXUt57uTlfv8p/EECKT18BBLFdbHGJ0SkIcU1rSWxdbbcS/jbu4mH2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606408; c=relaxed/simple;
	bh=BwK4HAKCP87hWzuJZvVv5l9FhBD3eOTmmf0I1i7erP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG1Nd9f+jNSBy92RqvaI6YYn5xppYQwbLfeawBhmMiUyrtwXF4OeIw73V6+6NwdMO7wmU/SuKwAZBHlbL8+A1NLQPU5x+CmVuMMQg2f8KIyMuH5UrEZuypju+LNc4EkieT6XWBGZKfUok1poiHITBV8MvclSFvB6ebR9wlEhSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69D0EFEC;
	Fri,  6 Sep 2024 00:07:12 -0700 (PDT)
Received: from R5WKVNH4JW (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D6703F66E;
	Fri,  6 Sep 2024 00:06:41 -0700 (PDT)
Date: Fri, 6 Sep 2024 09:06:33 +0200
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, yangyicong@hisilicon.com,
	linuxppc-dev@lists.ozlabs.org, bp@alien8.de,
	dave.hansen@linux.intel.com, mingo@redhat.com,
	linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
	peterz@infradead.org, tglx@linutronix.de, sudeep.holla@arm.com,
	will@kernel.org, catalin.marinas@arm.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, xuwei5@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH v5 3/4] arm64: topology: Support SMT control on ACPI
 based system
Message-ID: <Ztqp-SUinu8C9a-P@R5WKVNH4JW>
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-4-yangyicong@huawei.com>
 <a998c723-7451-439a-9c88-7c8b5c1b890b@arm.com>
 <00e6110a-462a-c117-0292-e88b57d27a05@huawei.com>
 <3947cb79-3199-4cd6-b784-51a245084581@arm.com>
 <1a7b5ac7-f040-672f-07a0-d7f3dc170c88@huawei.com>
 <6c05e39c-41f3-451c-b119-7b8662c1ceee@arm.com>
 <7f722af2-2969-aae5-1fb5-68d353eb95b9@huawei.com>
 <277bd093-422b-4301-92a3-d0a58eb41af5@arm.com>
 <10082e64-b00a-a30b-b9c5-1401a54f6717@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10082e64-b00a-a30b-b9c5-1401a54f6717@huawei.com>

Hi Yicong,

On Thu, Sep 05, 2024 at 08:02:20PM +0800, Yicong Yang wrote:
> On 2024/9/5 16:34, Pierre Gondois wrote:
> > Hello Yicong,
> > 
> > If a platform has CPUs with:
> > - 1 thread
> > - X (!= 1) threads
> > Then I think that the asymmetry is not detected
> 
> Ah ok, I only handle the case where there are several thread numbers except no SMT CPUs in the
> system. For this case I was thinking we don't need to handle this since there's only one kind
> of SMT core in the system, control should works fine for the SMT CPU clusters and we may not
> care about the CPUs with no SMT.
> 
> Below code should handle the case if we initialize the max_smt_thread_num to 0. I also
> reword the warning messages to match the fact. For heterogeneous SMT topology we still
> support control SMT by on/off toggle but not fully support setting the thread number.
> 
> 	int max_smt_thread_num = 0;
> 	[...]
> 	/*
> 	 * This should be a short loop depending on the number of heterogeneous
> 	 * CPU clusters. Typically on a homogeneous system there's only one
> 	 * entry in the XArray.
> 	 */
> 	xa_for_each(&hetero_cpu, hetero_id, entry) {
> 		/*
> 		 * If max_smt_thread_num has been initialized and doesn't match
> 		 * the thread number of this entry, then the system has
> 		 * heterogeneous SMT topology.
> 		 */
> 		if (entry->thread_num != max_smt_thread_num && max_smt_thread_num)
> 			pr_warn_once("Heterogeneous SMT topology is partly supported by SMT control\n");

What does 'partly supported' mean here?

If the SMT control doesn't work as intended for this topology, I don't
think it should be enabled for it.

Morten

