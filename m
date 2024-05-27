Return-Path: <linux-kernel+bounces-189994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA15D8CF834
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EA1280F67
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D456FCB;
	Mon, 27 May 2024 03:46:27 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7E10E5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781587; cv=none; b=gBr7AMmjoY1PekexmKspvawSgpZhOcwlgDbVrzvAduaDA2C4Sbh5Hhp20QQsSKiGOedwO0e4STEbwc8p/g/pQO4vsYjQK3N58l4Mvm0bwgnd5s5gk2DWn+/pHxBED4NcJ7qCPqj62iDrcBVHXPTo9PXRwarCMztrWB60gwlygDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781587; c=relaxed/simple;
	bh=eEXS+I7ieXLR5ZpU0pu31fAUvLwHh9+1q0Ak8+u86Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koIwOvnbLC0XEe/GWYAeLdru04CBwYHuxLxvL7DDl6D/ujBXFZ34FAMy/YTdpLdnL5m/XCx4G0oaCyozXxdYo+a7qmKC53Q8SiGhpnHSaBl8/kEI6euuIgSv2sSAFpnkl1Xrj+7xQJ+PShRJT+Ys2wFOvagX4tbk6zKxE6JdYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-5f-6654020b6189
Date: Mon, 27 May 2024 12:46:14 +0900
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
Message-ID: <20240527034614.GA12937@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <a28df276-069c-4d4d-abaf-efc24983211e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28df276-069c-4d4d-abaf-efc24983211e@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsXC9ZZnkS43U0iawd0GW4s569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2Ty2/rLzaJx6jc3j8ya5AL4oLpuU1JzMstQi
	fbsErowjh+ezF5xmq3j2cC5zA2MfaxcjJ4eEgInE3U+XWWDsJ1MOM4HYLAKqEm+WfmcGsdkE
	1CVu3PgJZosA2adWLmfvYuTiYBb4zyRx/2ErWEJYIERi2oc1YM28AhYSuw8uZwIpEhI4xSjR
	d+kNM0RCUOLkzCdg25gFtCRu/HsJVMQBZEtLLP/HARLmFLCV2Dn3ATuILSqgLHFg23GwORIC
	29glrvX8ZYa4VFLi4IobLBMYBWYhGTsLydhZCGMXMDKvYhTKzCvLTczMMdHLqMzLrNBLzs/d
	xAiMymW1f6J3MH66EHyIUYCDUYmHN8M9OE2INbGsuDL3EKMEB7OSCK/IvMA0Id6UxMqq1KL8
	+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYzdl6cvsHHQTb8qO2/q1yyJ
	5I8/f/1bnGCY9ffFgx0Mf4wb5rRlX3tXu07wkEsAc3K5L99D9kkMhR4zGni37s8qX/ts2ZtY
	1n0xgV1TBaLX+TCvuya8SYQjYA/H4XcL1G1lGkT+KGaXmVksqC7Rdr2/7b1O27VUucSnp+4Z
	rRdarnNCWlvL7Y4SS3FGoqEWc1FxIgDwKFjPxgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXC5WfdrMvNFJJm0NCgbTFn/Ro2i88b/rFZ
	fHr5gNHixYZ2Rouv638xWzz91MdicXjuSVaLy7vmsFncW/Of1eL8rrWsFjuW7mOyuHRgAZPF
	8d4DTBbz731ms9i8aSqzxfEpUxktfv8AKj45azKLg5DH99Y+Fo+ds+6yeyzYVOqxeYWWx+I9
	L5k8Nq3qZPPY9GkSu8e7c+fYPU7M+M3iMe9koMf7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXw
	R3HZpKTmZJalFunbJXBlHDk8n73gNFvFs4dzmRsY+1i7GDk5JARMJJ5MOcwEYrMIqEq8Wfqd
	GcRmE1CXuHHjJ5gtAmSfWrmcvYuRi4NZ4D+TxP2HrWAJYYEQiWkf1oA18wpYSOw+uJwJpEhI
	4BSjRN+lN8wQCUGJkzOfsIDYzAJaEjf+vQQq4gCypSWW/+MACXMK2ErsnPuAHcQWFVCWOLDt
	ONMERt5ZSLpnIemehdC9gJF5FaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmCMLav9M3EH45fL
	7ocYBTgYlXh4M9yD04RYE8uKK3MPMUpwMCuJ8IrMC0wT4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zusVnpogJJCeWJKanZpakFoEk2Xi4JRqYJx/qk38Qv4bzoeHGbb3btdT5nRdyPlZ7fz8dzos
	YkomlZxCe6d8nr9pw8tZIlayP92+yfBaf7LQWhi1/XCq4etrvhNv1thcCJdwXKEhrfrgyu45
	Ux9s/niNxymyt+e148K8a+a7pZZ7fL009+H9D9eCGK+sXC3OV9Uks9BO8dU9rhmhjFIMdxKU
	WIozEg21mIuKEwEPJJMVrQIAAA==
X-CFilter-Loop: Reflected

On Sun, May 26, 2024 at 07:43:10PM -0700, Dave Hansen wrote:
> On 5/26/24 18:57, Byungchul Park wrote:
> ...
> > Plus, I will add another give-up at code changing the permission of vma
> > to writable.
> 
> I suspect you have a much more general problem on your hands. Just
> tweaking the VFS or mmap() code likely isn't going to cut it.

LUF is interested in limited folios that are migratable or reclaimable
in lru for now.  So, IMHO, fixing a few things is going to cut it.

> I guess we'll see what you come up with next, but this email was really
> just the result of Vlastimil and I chatting on IRC for five minutes
> about this set.
> 
> It has absolutely not been tested nor reviewed enough.  <fud>I hope the
> performance gains stick around once more of the bugs are gone.</fud>

Sure. It should be.

	Byungchul

