Return-Path: <linux-kernel+bounces-523515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D125A3D7DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E6C7A6864
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CBA1EE7B6;
	Thu, 20 Feb 2025 11:09:49 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF41D79B6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049789; cv=none; b=ZpIrXDZ0Wc9proScszVY3LtZMq+IFSykP5IERFNNQmAAaVONNjyTQylzWIEYfFGdHVEZG0oil88L3urQF7CpUP1p+qfcOCkOlW4KzZh0sF2pMUsZSYl2SGmUvPJxMiwp1cIYNE+3yARr027fWhRJqGBs7Z5KewMi9xbvjfBe3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049789; c=relaxed/simple;
	bh=lT83+dbljiF/9iIwJ+SC1zlhoroyt91FCB95C8Nac68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7Ix8oOIHp/CDTM6kSl7btrGSVFwVYxGh8mW8i2O+e62P232T8y5Ya/43rjdVXZHtDCEpPu68fKtJc5XRhBssJ5eMeyrQ+jCRQwL2x+1EIq23Rya1PU8ObzDyYauE05xxrMiYaewj8Ln4y8cS9v73VeShlBjmsq+jhfzOy5o63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-54-67b70d741b4e
Date: Thu, 20 Feb 2025 20:09:35 +0900
From: Byungchul Park <byungchul@sk.com>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20250220110935.GA64704@system.software.com>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220103223.2360-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsXC9ZZnoW4J7/Z0g3df1CwO/HzOYnF51xw2
	i3tr/rM6MHts+jSJ3WPSC3ePz5vkApijuGxSUnMyy1KL9O0SuDJe7DnOVPBCqGLH3Y/MDYz7
	+LoYOTkkBEwk9u36xAhjf51xjQXEZhFQlXj3aj07iM0moC5x48ZPZhBbREBZovPCLFYQm1nA
	X2LCrQ1g9cICERJPDp1gArF5BSwkfn1+AGYLCSRIvJ66nx0iLihxcuYTFoheLYkb/14C1XAA
	2dISy/9xgIQ5BUwlGs8fBRsvCrTqwLbjQCVcQKf9ZJW4fGYLC8SdkhIHV9xgmcAoMAvJ2FlI
	xs5CGLuAkXkVo1BmXlluYmaOiV5GZV5mhV5yfu4mRmBwLqv9E72D8dOF4EOMAhyMSjy8M1q3
	pQuxJpYVV+YeYpTgYFYS4W2r35IuxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6Yklq
	dmpqQWoRTJaJg1OqgbEoirPzpurcnXzR4eGf0myen5pjYakSquW3zCahR5L17YZPi/94z7EO
	mLNlD9O97gkFPbErnUsDN4qzNewqLYo7+SbupsOS3WHOfCI8822OlD4+qsOrO9H9bdWkI/KN
	3ftS42yvnTvyIyGUd/2cq27Nn3YdZXF8trK/MnZ+1I5VUnvXqjGUvFdiKc5INNRiLipOBAAQ
	bMCoSgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsXC5WfdrFvCuz3d4HOXpMWBn89ZLA7PPclq
	cXnXHDaLe2v+szqweGz6NIndY9ILd4/FLz4weXzeJBfAEsVlk5Kak1mWWqRvl8CV8WLPcaaC
	F0IVO+5+ZG5g3MfXxcjJISFgIvF1xjUWEJtFQFXi3av17CA2m4C6xI0bP5lBbBEBZYnOC7NY
	QWxmAX+JCbc2gNULC0RIPDl0ggnE5hWwkPj1+QGYLSSQIPF66n52iLigxMmZT1ggerUkbvx7
	CVTDAWRLSyz/xwES5hQwlWg8fxRsvCjQqgPbjjNNYOSdhaR7FpLuWQjdCxiZVzGKZOaV5SZm
	5pjqFWdnVOZlVugl5+duYgSG2rLaPxN3MH657H6IUYCDUYmH98HjrelCrIllxZW5hxglOJiV
	RHjb6rekC/GmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTAG
	f/D5+Ln72MWFbFsmPA9dIvVF2virVPP7zXJm7FEdnFtnZvp2bLkbzFuxdsOnP/ufMitz7rh9
	NvKL3Yk959kt5/VsVZ9uuMPWVafHK5Tnr9kZBff6s8+Mt6ieWhNl/nieS8Vf2dUnFPe3e3iX
	/MhY4vdt7sMQ5gZbpX9FJTuVG8U+rLTN852sxFKckWioxVxUnAgAN+jY2jECAAA=
X-CFilter-Loop: Reflected

On Thu, Feb 20, 2025 at 06:32:22PM +0800, Hillf Danton wrote:
> On Thu, 20 Feb 2025 14:20:01 +0900 Byungchul Park <byungchul@sk.com>
> > To check luf's stability, I ran a heavy LLM inference workload consuming
> > 210GiB over 7 days on a machine with 140GiB memory, and decided it's
> > stable enough.
> > 
> > I'm posting the latest version so that anyone can try luf mechanism if
> > wanted by any chance.  However, I tagged RFC again because there are
> > still issues that should be resolved to merge to mainline:
> > 
> >    1. Even though system wide total cpu time for TLB shootdown is
> >       reduced over 95%, page allocation paths should take additional cpu
> >       time shifted from page reclaim to perform TLB shootdown.
> > 
> >    2. We need luf debug feature to detect when luf goes wrong by any
> >       chance.  I implemented just a draft version that checks the sanity
> >       on mkwrite(), kmap(), and so on.  I need to gather better ideas
> >       to improve the debug feature.
> > 
> > ---
> > 
> > Hi everyone,
> > 
> > While I'm working with a tiered memory system e.g. CXL memory, I have
> > been facing migration overhead esp. tlb shootdown on promotion or
> > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > migration through hinting fault can be avoided thanks to Huang Ying's
> > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > is inaccessible").
> > 
> > However, it's only for migration through hinting fault.  I thought it'd
> > be much better if we have a general mechanism to reduce all the tlb
> > numbers that we can apply to any unmap code, that we normally believe
> > tlb flush should be followed.
> > 
> > I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), that defers tlb
> > flush until folios that have been unmapped and freed, eventually get
> > allocated again.  It's safe for folios that had been mapped read-only
> > and were unmapped, as long as the contents of the folios don't change
> > while staying in pcp or buddy so we can still read the data through the
> > stale tlb entries.
> >
> Given pcp or buddy, you are opening window for use after free which makes
> no sense in 99% cases.

Just in case that I don't understand what you meant and for better
understanding, can you provide a simple and problematic example from
the u-a-f?

	Byungchul

