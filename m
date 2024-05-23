Return-Path: <linux-kernel+bounces-186900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063C8CCA95
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC85A1F21E61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EB14685;
	Thu, 23 May 2024 02:05:53 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CD64C8C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716429953; cv=none; b=T6j6YdQqRoyxJ7Yw3NkSzmMTu/6ClucjyxdqpE+Y5pFZSYqHFSM+NPDNLzUPbhTHj6jjxIXzfO3gXM6HvgyQNWT+qwNCELCwCamgznOdkyzyDZK1nkyotm/kldl7bZVmO+EIKAKddgMg1TjPdC6emJb1ukFhcEAKOar0JINryAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716429953; c=relaxed/simple;
	bh=F0zJvS8EDjOOjkiSmJbJ0GSUuxIY/vMkpLOBll5ON2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8UziikQzbRtqb5yG2s0cFo8cP73D3nvMz1Kw7LFQsstX8EPIHbspdWLfg/M2Qr5hbJXxYvuFk4Tnmyjpz1JRPTKUjnHMqnNn7AcRpL6toZnYgQMprJSMFORoRFja924y7y7ebYZ0wRu1DLJWT7jfx1qUgbOr0BceRyhyN3ruiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-71-664ea4793e2c
Date: Thu, 23 May 2024 11:05:39 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [RESEND PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb
 numbers over 90%
Message-ID: <20240523020539.GA21061@system.software.com>
References: <20240520021734.21527-1-byungchul@sk.com>
 <20240522155641.a726c5cd3b25aa23e861045d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522155641.a726c5cd3b25aa23e861045d@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsXC9ZZnkW7lEr80g9/PhS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	j+tHWAu6+Sp6l2Q0ME7i7mLk5JAQMJHYcOo3M4z9recySxcjBweLgKrElquBIGE2AXWJGzd+
	gpWICOhKrHq+C8jm4mAWeMQksfzjKjaQhLBAtMTD689ZQWxeAQuJrSvugsWFBMokHsw4ywIR
	F5Q4OfMJmM0soCVx499LJpBdzALSEsv/cYCEOQW8JV7Ma2cEsUUFlCUObDvOBLJLQmAVu8SH
	Dbeg7pSUOLjiBssERoFZSMbOQjJ2FsLYBYzMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECo3BZ
	7Z/oHYyfLgQfYhTgYFTi4e2Q9UsTYk0sK67MPcQowcGsJMIbvdI3TYg3JbGyKrUoP76oNCe1
	+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAPj+vyZRfpVOQFM01NmFimulm8/E3FL
	1tNiofG/5uMcvjcyt/Lmvt3yujHxd9ktMabteeJ/XvyI/Dy7oEh5k4pyySwpma6eL/ZRgWeu
	/67nT3H9IrjwhZrl5EP+U157hXRE9AgF3/KNOCzA2Pxc7g+HxVvzCd/DTX8+aH+d/XNL36yD
	NRnPxKYrsRRnJBpqMRcVJwIAR89vRL4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXC5WfdrFu5xC/N4OJbVos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZfy4foS1oJuvondJRgPjJO4uRk4OCQETiW89l1m6GDk4WARUJbZcDQQJswmo
	S9y48ZMZxBYR0JVY9XwXkM3FwSzwiEli+cdVbCAJYYFoiYfXn7OC2LwCFhJbV9wFiwsJlEk8
	mHGWBSIuKHFy5hMwm1lAS+LGv5dMILuYBaQllv/jAAlzCnhLvJjXzghiiwooSxzYdpxpAiPv
	LCTds5B0z0LoXsDIvIpRJDOvLDcxM8dUrzg7ozIvs0IvOT93EyMwppbV/pm4g/HLZfdDjAIc
	jEo8vAm/fNOEWBPLiitzDzFKcDArifBGrwQK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00Q
	EkhPLEnNTk0tSC2CyTJxcEo1MJp/DVIM+/81U2q92knPRetnnz10Py323pKOP1zeC5XNZdgj
	m+Jnhr/8r3ts110nZ2PBk77x//0Y/Ru/f3zeX6Bic1mORZV/STOHwHTeUqeoG0XBjc2pK08t
	6fo69Z+m5oqzb28ur1eN6U891Grr9PSDpatbdXbMrD8WK2e/zlFbcJTn3P2tXUosxRmJhlrM
	RcWJAFm7ha6lAgAA
X-CFilter-Loop: Reflected

On Wed, May 22, 2024 at 03:56:41PM -0700, Andrew Morton wrote:
> On Mon, 20 May 2024 11:17:22 +0900 Byungchul Park <byungchul@sk.com> wrote:
> 
> > While I'm working with a tiered memory system e.g. CXL memory, I have
> > been facing migration overhead esp. tlb shootdown on promotion or
> > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > migration through hinting fault can be avoided thanks to Huang Ying's
> > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > is inaccessible").  See the following link for more information:
> > 
> > https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> > 
> > However, it's only for migration through hinting fault.  I thought it'd
> > be much better if we have a general mechanism to reduce all the tlb
> > numbers that we can apply to any unmap code, that we normally believe
> > tlb flush should be followed.
> > 
> > I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), defers tlb flush
> > until folios that have been unmapped and freed, eventually get allocated
> > again.  It's safe for folios that had been mapped read-only and were
> > unmapped, since the contents of the folios don't change while staying in
> > pcp or buddy so we can still read the data through the stale tlb entries.
> 
> Version 10 and no reviewed-by's or acked-by's.  Reviewing the review
> history isn't helped by the change in the naming of the patch series.
> 
> Seems that you're measuring a ~5% overall speedup in a realistic
> workload?  That's nice.
> 
> I'll defer this for a week or so to see what reviewers have to say.  If
> "nothing", please poke me and I guess I'll merge it up to see what

I will poke you and will be ready for that ;)

	Byungchul

> happens ;)

