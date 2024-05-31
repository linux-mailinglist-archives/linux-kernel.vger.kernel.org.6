Return-Path: <linux-kernel+bounces-196179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0AB8D5881
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232651F2709A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ED4757EE;
	Fri, 31 May 2024 02:07:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB0B4C7C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717121227; cv=none; b=Phvdmh50kUWhFRLWJHVIXJwgVJGVpWb4JOwVTIaVzeC1AokhKKZPd0Dh4ZYApcH8hKX0r7bFTAtdZPyGBI/SnAvC8ykbzWkJ8mCNbd86/gpWB+AzehTGtGRiiuTvV30WWCfSc7HgAcN5spFNPAAwousV8nN6XO7mqoBrrHAPWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717121227; c=relaxed/simple;
	bh=/gelQHkEy0gA9zQPsWDwqnpmfANPeyIi/aRpF75xs3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giSy2a6W4i0Dn34QObyZoOE3/ZHCKlZxE4XoXyonokO+VGY/XIm1yh6fNHtwlB/Ym5EUW5fyLhWHfh/A9QngoYS4kxeXhIJQneeAFpqZpQWglPc20XmKqGYv9Sjtwo6GKS5euzr4EVvgEXN1nSX+rkH/hXPCV8QLtbJD5FXi9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-3a-665930c4cb00
Date: Fri, 31 May 2024 11:06:54 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240531020654.GA62639@system.software.com>
References: <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
 <20240529050046.GB20307@system.software.com>
 <961f9533-1e0c-416c-b6b0-d46b97127de2@intel.com>
 <20240530005026.GA47476@system.software.com>
 <87a5k814tq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240530071847.GA15344@system.software.com>
 <871q5j1zdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240530084120.GA12940@system.software.com>
 <2a0f8cc9-a061-45cd-81df-b65d4b454b77@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0f8cc9-a061-45cd-81df-b65d4b454b77@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsXC9ZZnoe4Rg8g0g65f4hZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnls/WXn0Tj1GpvH501yAXxRXDYpqTmZZalF
	+nYJXBnH9nSzFuzhqng6+z1rA+Nkji5GTg4JAROJaZ3NjF2MHGD2lhOGIGEWAVWJLac+MIHY
	bALqEjdu/GQGsUWA7FMrl7N3MXJxMAv0M0v8fwficHIIC4RITPuwBqyBV8BCor+rjQ2kSEjg
	F7PEs33boBKCEidnPmEBsZkFtCRu/HvJBLKYWUBaYvk/sHs4BWwllq99BLZMVEBZ4sC240wg
	cyQEtrFLvNj/gh3iaEmJgytusExgFJiFZOwsJGNnIYxdwMi8ilEoM68sNzEzx0QvozIvs0Iv
	OT93EyMwJpfV/onewfjpQvAhRgEORiUe3oCKiDQh1sSy4srcQ4wSHMxKIry/0oFCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGD1+bEwV4RdRFv/SG2Iq
	/k94z7S/t/8Kb7jz6sjsY2YsEhyHJ+inbV/Ncd/JTnBdtKt60hzV4MPblvjMtql/u/G6pZOo
	xJtvaiuWdK24rLFw37yrZgJHvV2qTk0+b/N748/te6sUepPiZGtl5puo97TmRT5ODvBrWuP1
	874F266lPyfHOSk8/63EUpyRaKjFXFScCAAry0AExQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5WfdrHvEIDLN4NcdDos569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8NzT7JaXN41h83i3pr/rBbnd61ltdixdB+TxaUDC5gs
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUPHJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8SS6A
	P4rLJiU1J7MstUjfLoEr49iebtaCPVwVT2e/Z21gnMzRxcjBISFgIrHlhGEXIycHi4CqxJZT
	H5hAbDYBdYkbN34yg9giQPaplcvZuxi5OJgF+pkl/r8DcTg5hAVCJKZ9WAPWwCtgIdHf1cYG
	UiQk8ItZ4tm+bVAJQYmTM5+wgNjMAloSN/69ZAJZzCwgLbH8HwdImFPAVmL52kdgy0QFlCUO
	bDvONIGRdxaS7llIumchdC9gZF7FKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGGHLav9M3MH4
	5bL7IUYBDkYlHt6Aiog0IdbEsuLK3EOMEhzMSiK8v9KBQrwpiZVVqUX58UWlOanFhxilOViU
	xHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYwKAg9OznrFZSBt9q1E89n8593iIpde93c1fr7a
	nmnHl9savZ9N3rb68mLz7M5vl4q6w5mjWI1SPT+8lzi8+NeSqo9dJ38qTgyYzxLW69nD9dMz
	Z+I9YW75d9OVc7aYsto8Tl17rKHYvrv1coqp5mm9hbuyHiyyZdcxeH8j68vk2x+cWzY6/Fdi
	Kc5INNRiLipOBAC4rsA8rAIAAA==
X-CFilter-Loop: Reflected

On Thu, May 30, 2024 at 06:50:48AM -0700, Dave Hansen wrote:
> On 5/30/24 01:41, Byungchul Park wrote:
> > LUF should not optimize tlb flushes for mappings that users explicitly
> > change e.g. through mmap() and munmap().
> 
> We are thoroughly going around in circles at this point.
> 
> I'm not quite sure what to do.  Ying and I see a problem that we've
> tried to explain a couple of times.  We've tried to show the connection
> between a LUF-elided TLB flush and how that could affect a later
> munmap() or mmap(MAP_FIXED).
> 
> But these responses seem to keep going back to the fact that LUF doesn't

I just wanted to understand exactly what Ying meant.  My answer might be
done in a wrong way if I wrongly got him.

> directly affect munmap(), which is true, but quite irrelevant to the
> problem being described.
> 
> So we're at an impasse.
> 
> Byungchul, perhaps you should spin another series and maybe Ying and I

I don't think the current implementation is perfect.  I just wanted to
know what I'm missing now but.. yes.  It would be much better to
communicate with a real bug if existing.

I will respin the next version shortly.

	Byungchul

> have to write up a test case to show the bug that we see.  Or perhaps
> someone else can jump into the thread and bridge the communication gap.

