Return-Path: <linux-kernel+bounces-524909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19CEA3E8A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9687F174CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E94266EF8;
	Thu, 20 Feb 2025 23:37:23 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F12B9AA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094643; cv=none; b=t/fbYmeWXvOC7OJwQiZU0owpE10ya4GaUdTOOgvnwqNysJhJCwEhUtob8nV+dpgd+Wd0p3AWZsgN2GjQE6CZOVDTRwUs4tu7f/RvRtPTg9k/sieXL3ePKrvDs84Y3JC0+rEzQXfmyQVa3gOE8Wfq5wkq/iqRS/pG3SWgD6s0cmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094643; c=relaxed/simple;
	bh=RrO2xl0zgRBrG7hJH/gMtLoi81v+CEpyWJYacx9omhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7zcTwiMZWvZ/IlVcBwFx/amvcAx6+5Kd53uNiHNqnyemwm+1FKF0vE4ojIutuZOg8lT9Y36efWv7ssZfsW72XR4xz870xQSh0hQ/QyvSpOjDMsOgwH2OUFgAluWscO3iqwfCsDiaKkGEFdOe1J1yo4q73On0KqJ1EnIh0U5pJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-d1-67b7bcabd130
Date: Fri, 21 Feb 2025 08:37:10 +0900
From: Byungchul Park <byungchul@sk.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, ying.huang@intel.com,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20250220233710.GB39373@system.software.com>
References: <20250220052027.58847-1-byungchul@sk.com>
 <8accbd91-ca59-43f8-b190-7e1ac3df5e11@intel.com>
 <fc94c383-5788-43c8-beb3-2fd76acae7bd@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc94c383-5788-43c8-beb3-2fd76acae7bd@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsXC9ZZnke7qPdvTDWbNMbKYs34Nm8XnDf/Y
	LD69fMBo8WJDO6PF1/W/mC2efupjsbi8aw6bxb01/1ktzu9ay2qxY+k+JotLBxYwWRzvPcBk
	Mf/eZzaLzZumMlvMbuxjtDg+ZSqjxe8fQB0nZ01mcRDy+N7ax+Kxc9Zddo8Fm0o9Nq/Q8li8
	5yWTx6ZVnWwemz5NYvd4d+4cu8eJGb9ZPOadDPR4v+8qm8eZBUfYPbb+svNonHqNzePzJrkA
	/igum5TUnMyy1CJ9uwSujI3PZ7EX9AtVbN78nbGBcRFfFyMnh4SAiUR72zo2GPve+4nMIDaL
	gKrE5UvdYDabgLrEjRs/wWwRARWJRxuOsnYxcnEwCyxhlljx7xkTSEJYIELiyaETYDavgIVE
	+/7X7CBFQgIzGSUmLjrAApEQlDg58wmYzSygJXHj30ugBg4gW1pi+T8OkDCngLVE/7J9jCC2
	qICyxIFtx5lA5kgIHGOXaLvziAXiUkmJgytusExgFJiFZOwsJGNnIYxdwMi8ilEoM68sNzEz
	x0QvozIvs0IvOT93EyMwUpfV/onewfjpQvAhRgEORiUe3gTT7elCrIllxZW5hxglOJiVRHjb
	6rekC/GmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamCcNK/k
	reHL/EAvwwVZD8VmLnY6H/n2LqtshVrqUlGmFOH0/69slnzgOdbLLtmYnfXj9/W4S23RWmbh
	1+SD5fsPR5Q1Tnrn9L5lXtDZnh8zY59v85Kd/+XmRb7zn15Kt2wJ6/ySIifc0Jzsk7NylU7Z
	3pK3Sxk32Bw3XFFWv+0Xd8iSi1vNGC8osRRnJBpqMRcVJwIAXw4c7tACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsXC5WfdrLt6z/Z0gynNahZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFofnnmS1uLxrDpvFvTX/WS3O71rLarFj6T4mi0sHFjBZ
	HO89wGQx/95nNovNm6YyW8xu7GO0OD5lKqPF7x9AHSdnTWZxEPb43trH4rFz1l12jwWbSj02
	r9DyWLznJZPHplWdbB6bPk1i93h37hy7x4kZv1k85p0M9Hi/7yqbx+IXH5g8ziw4wu6x9Zed
	R+PUa2wenzfJBQhEcdmkpOZklqUW6dslcGVsfD6LvaBfqGLz5u+MDYyL+LoYOTkkBEwk7r2f
	yAxiswioSly+1A1mswmoS9y48RPMFhFQkXi04ShrFyMXB7PAEmaJFf+eMYEkhAUiJJ4cOgFm
	8wpYSLTvf80OUiQkMJNRYuKiAywQCUGJkzOfgNnMAloSN/69BGrgALKlJZb/4wAJcwpYS/Qv
	28cIYosKKEsc2HacaQIj7ywk3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMj
	MO6W1f6ZuIPxy2X3Q4wCHIxKPLwJptvThVgTy4orcw8xSnAwK4nwttVvSRfiTUmsrEotyo8v
	Ks1JLT7EKM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgdN7l1f3pqNMk5mtbg9bO+X3+
	1nQfwTVLFyjPkD9xf8+OLU80ZjW+/r7MyXS1GH/mue99wvofZyrZbl66c9+8FZ++Jkw/MeXn
	oqx9RVwyzRYloRLXz0bPUmFR2nF7guknWfdVQQveC6zxEt4m5ZCa9PKZ254V/851Twi922vY
	JHfwzx2Jp+9W7LiuxFKckWioxVxUnAgA6om6xLcCAAA=
X-CFilter-Loop: Reflected

On Thu, Feb 20, 2025 at 04:29:51PM +0100, Vlastimil Babka wrote:
> On 2/20/25 16:15, Dave Hansen wrote:
> > On 2/19/25 21:20, Byungchul Park wrote:
> >> I'm posting the latest version so that anyone can try luf mechanism if
> >> wanted by any chance.  However, I tagged RFC again because there are
> >> still issues that should be resolved to merge to mainline:
> > 
> > I don't see anything fundamentally different here from the last 11
> > versions. I think the entire approach is dangerous and basically makes
> > things impossible to debug. It's not clear that some of the failure
> > scenarios that I've brought up in the past have actually been fixed.
> 
> Yes, and it's still an invasive change to the buddy allocator.

Didn't want.. but admit.

> IIRC at Plumbers the opinion in the audience was that there might be ways to
> improve the batching on unmap to reduce the flushes without such an invasive
> and potentially dangerous change? Has that been investigated?

Sure.  I tried like, by holding those pages not freed until either no
one accesses the interesting pages or memory pressure is high.  However,
unfortunately it was super hard to fix performance degradation by the
number of page reclaim increased due to the unfreed pages.

> Also "Rebase on akpm/mm.git mm-unstable(5a7056135b) as of Nov 22, 2024." is
> very outdated at this point?

Sorry for that.  I will rebase and share.

	Byungchul
> 
> Thanks,
> Vlastimil
> 
> > What I've said here still stands:
> > 
> >> https://lore.kernel.org/all/fab1dd64-c652-4160-93b4-7b483a8874da@intel.com/
> > 
> >> I think tglx would call all of this "tinkering".  The approach to this
> >> series is to "fix" narrow, specific cases that reviewers point out, make
> >> it compile, then send it out again, hoping someone will apply it.
> >> 
> >> So, for me, until the approach to this series changes: NAK, for x86.
> >> Andrew, please don't take this series.  Or, if you do, please drop the
> >> patch enabling it on x86.
> > 
> > I think I'd also like to stop being cc'd on this. If LUF is merged into
> > mainline and proven to work on arm64 or riscv for a year, I'd be happy
> > to take another look at enabling it on x86. I think that's just about
> > the only thing that would make me reconsider.
> > 

