Return-Path: <linux-kernel+bounces-356008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249A1995AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9210CB2575D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C02221E3C;
	Tue,  8 Oct 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="apcjcLNn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AFld67In"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0B221E4F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427132; cv=none; b=NR5xHSoXQw5CXXRj/3OFrL5cMy+YRXY9KEBAaOCBtELwb4jxHojlsN7LeE92RryHE5Z7JvXfhM86IhKqMW3R1rtoQlN1DnsTc2GOGRKed9Yhewr+RybgX4MpfeGt+W0tbkahyuZiBD2tFfCxJsz2SCST6poaxwRrgo1ZC6jK0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427132; c=relaxed/simple;
	bh=vdt0BFkXg/F8vam3hFh2SekFTx3Y4X2xLSskb8nBBVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XRcZv7WEIIWYSWUvnzOorTCYfsDsvGf6LlOtRIarcpvID/jFswlLPtDB3iHZfhb9SB/T9znwxC0+4MxUWLNzO+h8+mdXZqdUoI4+jyogKI88D0ggiOdijaUZGPnYeAkk9xhuGYfURB+5plsvd974XHv47GtQidfTrxRfHDkTmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=apcjcLNn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AFld67In; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728427128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vbJPGi4LXURvqwE6imdzbJITS0vamNpNMhgomK1oaXA=;
	b=apcjcLNnvmR8ZG7sOI7wJmHUjg18GhHyZCNngoncJkw7vzB19yKepo3m5XLYt8OfZ0CLIG
	2Zhf/5BW+MNBkKWCWEuUJO2vSu8DXxPutGbIz7uVQlJGWVJThXP4xBAp8l0JSroqVpTdRJ
	dv/phWE0QOziXTdxRJG1kdGQCFUmZu3AEGdEEYCnhxljAqrN9T8yPyGNmry61lwNdsoMy4
	DSVuItmpANWlySuIKhbYGnNiuZ/E45p1yJcabN5ff57itJa1ZSkwoS7WufeDL5gnbh5vpf
	FDECWrHBrXAjOCgxqhejAr/e1Cz3a+gXHzT6E7KDB5caJsE03rJuTDUxeASCfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728427128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vbJPGi4LXURvqwE6imdzbJITS0vamNpNMhgomK1oaXA=;
	b=AFld67InhiiphUtCZWUWLad+Q0U1b2Ss6LjhpXc9xujCgAO6KTz+YtnVcYOrden2LgF75k
	jgR6Do72DuTYOOBw==
To: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
 mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: Oliver Sang <oliver.sang@intel.com>, Dhananjay Ugwekar
 <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
In-Reply-To: <ed3c066f-5040-4573-a91f-3ee95014c951@linux.intel.com>
References: <20240913171033.2144124-1-kan.liang@linux.intel.com>
 <875xq2tv05.ffs@tglx>
 <3b65fd68-8f5b-4029-8dbd-46c0b2cc34c7@linux.intel.com>
 <87ploas5rb.ffs@tglx> <87msjes56x.ffs@tglx>
 <ed3c066f-5040-4573-a91f-3ee95014c951@linux.intel.com>
Date: Wed, 09 Oct 2024 00:38:47 +0200
Message-ID: <87ed4qrzig.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 08 2024 at 17:05, Kan Liang wrote:
> On 2024-10-08 4:36 p.m., Thomas Gleixner wrote:
>>>
>>>  1) Start your kernel with maxcpus=2 (not recommended, but ...)
>>>  2) Load the module
>>>  3) Online the rest of the CPUs from userspace
>>>
>>> If your machine has more than one die you might be surprised...
>
> Thanks. I will find a 2 sockets machine and give it a try.
>
>> 
>> You can make this work because the new topology code allows you to
>> retrieve the possible number of cores/dies/packages even when they have
>> not been onlined yet. 
>>
>
> Actually, I think the possible CPU mask should be good enough here. The
> init_rapl_pmu() just intends to allocate the space for a pmu in each die.
>
> The worst case of using a possible mask is that some space may be
> wasted, when there is no online CPUs on a die. But it should be an
> unusual case. It should be harmless.

Right, but you can't use the regular topology functions which are used
by cpu to rapl ID for that because they depend on the CPU being
online. The x86 specific ones which parse the APIC ID topology
information can provide that information.

I.e. you only need

     topology_max_packages()
     topology_max_dies_per_package()
     topology_num_cores_per_package()

which provide you the required information to allocate upfront. Later
when the CPUs are actually online the existing mapping functions work.

Thanks,

        tglx

