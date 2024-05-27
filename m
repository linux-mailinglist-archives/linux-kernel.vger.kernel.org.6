Return-Path: <linux-kernel+bounces-190013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF88CF85C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5976A281EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235EBE68;
	Mon, 27 May 2024 04:26:01 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B57464
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716783961; cv=none; b=RIPHA1RbjMv+u+VK/t3ymnPwboxrvl0uZU36TpC21132axMHKM0/Y/8O445BdMDbSJFPIn8yyr3s/lOVcU/NC7EeT9Jq4yIyE0+OnRMMYjiD6hlB9q1kpQd6yvFS/v9qLQHz5EZtjFwDqq4XDshNiE8l/Jj15dtifR6Q1em1Hz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716783961; c=relaxed/simple;
	bh=2nkS9YJqi2q5hg2fjuiqBzOlQ+eCe7Zt5pjG4NGCcfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjYLnx4FlwbuxltpbsfbZC8qaERw8/RJt1TqxYMIINF1i6yAYJy5HsM0qX3KCGcdQCRKLJW9rHgUGeVNvdzs0qBER4sGakVwCXpMuajSoSIdDOoj29lWlaFuSxmUG8r/1R9UWGI28j2R1MO0WQCZ49JrfJCwU1Mxoo8ott3SfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-3b-66540b51522c
Date: Mon, 27 May 2024 13:25:48 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240527042548.GD12937@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <a28df276-069c-4d4d-abaf-efc24983211e@intel.com>
 <20240527034614.GA12937@system.software.com>
 <20240527041946.GC12937@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527041946.GC12937@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsXC9ZZnkW4gd0iawa5zZhZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnls/WXn0Tj1GpvH501yAXxRXDYpqTmZZalF
	+nYJXBnLbk9gLrjOW9Gz+wJbA+M2ri5GTg4JAROJ1S86mbsYOcDspg86IGEWAVWJc/OOMoPY
	bALqEjdu/ASzRYDsUyuXs3cxcnEwC/xnkrj/sBUsISwQIjHtwxomEJtXwELi+O2frCBFQgIr
	mCRmte1mg0gISpyc+YQFxGYW0JK48e8lE8hiZgFpieX/OEBMTgFLiXufpEAqRAWUJQ5sO84E
	MkZCYBu7xKztq9kgbpaUOLjiBssERoFZSKbOQjJ1FsLUBYzMqxiFMvPKchMzc0z0MirzMiv0
	kvNzNzECI3JZ7Z/oHYyfLgQfYhTgYFTi4c1wD04TYk0sK67MPcQowcGsJMIrMi8wTYg3JbGy
	KrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVANjcM7mvRw/Zr79bGSw
	0naz7NFDbAbPOx4KTXjDP8HXuUWhgmUOY/veXncjvoRfh4RWMyr4RJ7SejnZ2CRvtv6Zj3GX
	NZe8YTzx9YF1aW3hvWN5s+v+v7m3IvHTrpu2U6qslToK5jJdSA54Z+/c1Ff8rtTBaMZr4frZ
	9eyaE+dz1cg5XVafLvJYiaU4I9FQi7moOBEAOBSjaMQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXC5WfdrBvIHZJmML9Z2WLO+jVsFp83/GOz
	+PTyAaPFiw3tjBZf1/9itnj6qY/F4vDck6wWl3fNYbO4t+Y/q8X5XWtZLXYs3cdkcenAAiaL
	470HmCzm3/vMZrF501Rmi+NTpjJa/P4BVHxy1mQWByGP7619LB47Z91l91iwqdRj8wotj8V7
	XjJ5bFrVyeax6dMkdo93586xe5yY8ZvFY97JQI/3+66yeSx+8YHJY+svO4/GqdfYPD5vkgvg
	j+KySUnNySxLLdK3S+DKWHZ7AnPBdd6Knt0X2BoYt3F1MXJwSAiYSDR90Oli5ORgEVCVODfv
	KDOIzSagLnHjxk8wWwTIPrVyOXsXIxcHs8B/Jon7D1vBEsICIRLTPqxhArF5BSwkjt/+yQpS
	JCSwgkliVttuNoiEoMTJmU9YQGxmAS2JG/9eMoEsZhaQllj+jwPE5BSwlLj3SQqkQlRAWeLA
	tuNMExh5ZyFpnoWkeRZC8wJG5lWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiB8bWs9s/EHYxf
	LrsfYhTgYFTi4c1wD04TYk0sK67MPcQowcGsJMIrMi8wTYg3JbGyKrUoP76oNCe1+BCjNAeL
	kjivV3hqgpBAemJJanZqakFqEUyWiYNTqoFxeqQLe5bQzdvqVXPNJm2dLD/rQcfbG/PePHhR
	0/vpXanBMoG/T+R9V0XnPzOZJLNz3bXeI+GBU+fvfNRoN/m97Wcv9U3ZKSd285tzv/raNffl
	hccMJnd+lZspn5D6PL2q6eK6/tQuM0NP3hO9Gf7brvodv2Hr8kGqQ4/zS/vqE0JMftVWUk/U
	lFiKMxINtZiLihMB9x5nwqsCAAA=
X-CFilter-Loop: Reflected

On Mon, May 27, 2024 at 01:19:46PM +0900, Byungchul Park wrote:
> On Mon, May 27, 2024 at 12:46:14PM +0900, Byungchul Park wrote:
> > On Sun, May 26, 2024 at 07:43:10PM -0700, Dave Hansen wrote:
> > > On 5/26/24 18:57, Byungchul Park wrote:
> > > ...
> > > > Plus, I will add another give-up at code changing the permission of vma
> > > > to writable.
> > > 
> > > I suspect you have a much more general problem on your hands. Just
> > > tweaking the VFS or mmap() code likely isn't going to cut it.
> 
> What a stupid idiot I am.
> 
> I already discuss the exact cases with Nadav Amit at the very beginning
> around v1.  I didn't remember it when I was answering to you.
> 
> mmap() or changing the permission by user already performs TLB flush
> needed within that code, which LUF never touch.
> 
> Worth noting currently LUF touchs only unmapping during migration or
> reclaim.  Other updating mapping would perform TLB flush it needs, as is.
> I guess updating page cache is also already perform TLB flush needed.

This may not be the case tho..  I might need to work on page cache.

	Byungchul

> I need to check it.  Probably, it would already do.
> 
> 	Byungchul
> 
> > LUF is interested in limited folios that are migratable or reclaimable
> > in lru for now.  So, IMHO, fixing a few things is going to cut it.
> > 
> > > I guess we'll see what you come up with next, but this email was really
> > > just the result of Vlastimil and I chatting on IRC for five minutes
> > > about this set.
> > > 
> > > It has absolutely not been tested nor reviewed enough.  <fud>I hope the
> > > performance gains stick around once more of the bugs are gone.</fud>
> > 
> > Sure. It should be.
> > 
> > 	Byungchul

