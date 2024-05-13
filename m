Return-Path: <linux-kernel+bounces-177084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4258C39E4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 03:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F81A1C209EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 01:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3471F9CC;
	Mon, 13 May 2024 01:44:39 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCCE541
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715564679; cv=none; b=SjSKRlp4hjDxGJ7uDpFWGsVmC9d634MbYw169CP2jQ1hmcMsunCaRAjTvrdNjzIWqN8xczu62scEzj4O+DczWLCu6u2M+cmA6JyKGx3Ysi+L4Jd7BklLaGQqOF09VxRZhpFUin9Unn2GVtpPhktTaA4bxkrtfXTN5MCe7QdKzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715564679; c=relaxed/simple;
	bh=zxyPelvY/Imn1+ZX+DOanZkQ1iX7PGydqSCP2eHX2uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APMOidHo4fa/6aFl1AALDtnM4CIy2ijlOnw/dSgKQmPLFlNPYGZZhnl20QR5OFLMtW4lamQqMkArySma7FpGZd8Kse1hBVVwm6j0YhliLOGhAOlxBbVIk9J9XrivFcF7Z8d5ESgbcvtbaUq9UUFKKCGgizUn/ufVy8m4hbfv9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ae-66417082ef79
Date: Mon, 13 May 2024 10:44:29 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240513014428.GB38851@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <87eda8g6q2.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eda8g6q2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsXC9ZZnoW5TgWOaweG/YhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugSvj
	+NEG5oK5XBX3ejQbGCdydDFyckgImEg82rGctYuRA8yesjwGJMwioCqx7u4vJhCbTUBd4saN
	n8wgtoiAhsSnhcvZuxi5OJgFnjNJ/H7zmx0kISwQIjHtwxqwBl4BC4mLny6DxYUEMiWWrZ0H
	FReUODnzCQuIzSygJXHj30smkL3MAtISy/+BncMpYCdxfM9MsBJRAWWJA9uOM4HskhBYxy7x
	8OAzRoibJSUOrrjBMoFRYBaSsbOQjJ2FMHYBI/MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMAo
	XFb7J3oH46cLwYcYBTgYlXh4E047pAmxJpYVV+YeYpTgYFYS4XUotE8T4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwOh+f3vKqeNmu7znz/BValaxWXTa
	e6KTkeCRK9XzljCtPxLrxb6iewnfCdfPkSciNaYeKK5LfCLoLMkotqBCP3PmoU8pN6oZE/un
	PnsjuHqJ7pJfoq/ebXr1OkXBP/rY43d35720+e93oim3kf1/y7oWe+s976xZelaF8UdmnFtj
	/sewLq/d8KkSS3FGoqEWc1FxIgATQDtXvgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXC5WfdrNtU4Jhm8OoPm8Wc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4Mo4fbWAumMtVca9Hs4FxIkcXIweHhICJxJTlMV2MnBwsAqoS6+7+YgKx2QTU
	JW7c+MkMYosIaEh8WricvYuRi4NZ4DmTxO83v9lBEsICIRLTPqwBa+AVsJC4+OkyWFxIIFNi
	2dp5UHFBiZMzn7CA2MwCWhI3/r1kAtnLLCAtsfwfB0iYU8BO4viemWAlogLKEge2HWeawMg7
	C0n3LCTdsxC6FzAyr2IUycwry03MzDHVK87OqMzLrNBLzs/dxAiMqWW1fybuYPxy2f0QowAH
	oxIPb8JphzQh1sSy4srcQ4wSHMxKIrwOhfZpQrwpiZVVqUX58UWlOanFhxilOViUxHm9wlMT
	hATSE0tSs1NTC1KLYLJMHJxSDYxiTH8jdQ1vtxQfWnltp+CDVVISDIzvfh21O3ineEONHpuB
	5rKexKoS7fP8jjJHQhyXfZUN9lrQun1WxSZXv+Q6zy2/z//8OjdwlsmkxeVz3RcY+eewHd/r
	F7O47Dtzw7Xrm45Um+/uO6d5YbWl3KaN7w+vKhH8uHhpn/EP52Vhy1KMm/6ULr+uxFKckWio
	xVxUnAgAXsgVcKUCAAA=
X-CFilter-Loop: Reflected

On Sat, May 11, 2024 at 03:15:01PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Hi everyone,
> >
> > While I'm working with a tiered memory system e.g. CXL memory, I have
> > been facing migration overhead esp. tlb shootdown on promotion or
> > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > migration through hinting fault can be avoided thanks to Huang Ying's
> > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > is inaccessible").  See the following link for more information:
> >
> > https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> 
> And, I still have interest of the performance impact of commit
> 7e12beb8ca2a ("migrate_pages: batch flushing TLB").  In the email above,
> you said that the performance of v6.5-rc5 + 7e12beb8ca2a reverted has
> better performance than v6.5-rc5.  Can you provide more details?  For
> example, the number of TLB flushing IPI for two kernels?

Okay.  I will test and share the result with what you asked me now once
I get available for the test.

	Byungchul

> I should have followed up the above email.  Sorry about that.  Anyway,
> we should try to fix issue of that commit too.
> 
> --
> Best Regards,
> Huang, Ying
> 
> [snip]

