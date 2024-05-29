Return-Path: <linux-kernel+bounces-193431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E998D2BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB2A1C226DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18C15B558;
	Wed, 29 May 2024 05:00:59 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B19CA48
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716958858; cv=none; b=rS7KfnRoYNuA8cgiu+h6eWfsdSflGfwL9Yn6Swn0XioOK1aiUqFR6+TG1UwYy53/aZB7YqGOMoUcmApS7rcsUim7hAwWmAJjgfDTMSUVJvKVUtvbdqcR1/LCtA1cJCMHmNPhbSfPAqw0lRGokBaPtgnIUl/QrHy0QQjQL1MyUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716958858; c=relaxed/simple;
	bh=42DKLfdq51KggxPTbkiYyOCqUowHpFUBrFqz2zQtih0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0ymq4XgEYwZGKPMJ93bFpuxYV0xES86rqlWdbx1MDFN2mawYF9u02k/DMpc41KbJsRjSPiybLHElyx01fzWypRDdWEmP4rB0/tG6SYFYGscPj+Vy8IpSn8f+QvAUelOqQifoSP67D84JIbrDOW2/9Vh1Dey0YE5/LPBd6WTbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-d3-6656b683f724
Date: Wed, 29 May 2024 14:00:46 +0900
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
Message-ID: <20240529050046.GB20307@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsXC9ZZnkW7LtrA0g7YHXBZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnls/WXn0Tj1GpvH501yAXxRXDYpqTmZZalF
	+nYJXBlb9h9nLzjCV/FjZU0D40buLkYODgkBE4k9N1i6GDnBzAe7DzOB2CwCqhKvJu5jBLHZ
	BNQlbtz4yQxiiwDZp1YuZ+9i5OJgFuhnlvj/DsTh5BAWCJGY9mENWDOvgIXEnGebmUGKhAT+
	MUosXrcIKiEocXLmE7BtzAJaEjf+vWQCOYJZQFpi+T8OkDCngK3EjF8zwcpFBZQlDmw7zgQy
	R0JgE7vEko0b2CAulZQ4uOIGywRGgVlIxs5CMnYWwtgFjMyrGIUy88pyEzNzTPQyKvMyK/SS
	83M3MQIjclntn+gdjJ8uBB9iFOBgVOLhtTgQmibEmlhWXJl7iFGCg1lJhPfMJKAQb0piZVVq
	UX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRi2lKx5xr/sunPo/aU2x
	yZys146H9c/+c1465YHxvZIy4fce/8/uFj28YPumfWuSCl/MVuq/uPPJsdD6T3M+l2TszfEz
	rFio/Km+9IFd5dbTYg3FprOOGa1u+MuiHrGup/6bf0WKldLyX4+OrDcSr/TNuPzYgWdmVo7c
	xVWrGbWUTzVv2u38boISS3FGoqEWc1FxIgB7108wxAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5WfdrNu8LSzNoG+VkcWc9WvYLD5v+Mdm
	8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/Vovzu9ayWuxYuo/J4tKBBUwW
	x3sPMFnMv/eZzWLzpqnMFsenTGW0+P0DqPjkrMksDkIe31v7WDx2zrrL7rFgU6nH5hVaHov3
	vGTy2LSqk81j06dJ7B7vzp1j9zgx4zeLx7yTgR7v911l81j84gOTx9Zfdh6NU6+xeXzeJBfA
	H8Vlk5Kak1mWWqRvl8CVsWX/cfaCI3wVP1bWNDBu5O5i5OSQEDCReLD7MBOIzSKgKvFq4j5G
	EJtNQF3ixo2fzCC2CJB9auVy9i5GLg5mgX5mif/vQBxODmGBEIlpH9aANfMKWEjMebaZGaRI
	SOAfo8TidYugEoISJ2c+YQGxmQW0JG78ewkU5wCypSWW/+MACXMK2ErM+DUTrFxUQFniwLbj
	TBMYeWch6Z6FpHsWQvcCRuZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgRG2rPbPxB2MXy67
	H2IU4GBU4uE12BmaJsSaWFZcmXuIUYKDWUmE98wkoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
	r/DUBCGB9MSS1OzU1ILUIpgsEwenVAPj5rdv0j3T9098KW8WcFOE0adlh8w169Y1i2UuMMfs
	/bc8M/LNhanPNAtYxXiEPeN/rN/Qyv4hdfX2BWr8u8zv6XOEprlfMtZeaqksEbY0sPrQsnU/
	H7yYs+uh7DvV735bn/Gbv5zn+ETiRc5rqXbLF3n7+DmmiYRdFr8m9uLqMhU3liPGPZqtSizF
	GYmGWsxFxYkAZNKlOKwCAAA=
X-CFilter-Loop: Reflected

On Tue, May 28, 2024 at 08:14:43AM -0700, Dave Hansen wrote:
> On 5/26/24 20:10, Huang, Ying wrote:
> >> Thank you for the pointing out.  I will fix it too by introducing a new
> >> flag in inode or something to make LUF aware if updating the file has
> >> been tried so that LUF can give up and flush right away in the case.
> >>
> >> Plus, I will add another give-up at code changing the permission of vma
> >> to writable.
> > I guess that you need a framework similar as
> > "flush_tlb_batched_pending()" to deal with interaction with other TLB
> > related operations.
> 
> Where "other TLB related operations" includes both things that
> traditionally invalidate TLBs (like going Present 1=>0) and things like
> fault-in that go Present 0=>1 that can result in TLB population.
> 
> It's actually a really crummy problem to solve.  We don't have _any_
> machinery to say, "Hey, you know that PTE you wanted to install?  There
> was something there before you and we haven't flushed it yet.  Can you
> be a doll and do a flush before _populating_ that PTE?"

All the code updating ptes already performs TLB flush needed in a safe
way if it's inevitable e.g. munmap.  LUF which controls when to flush in
a higer level than arch code, just leaves stale ro tlb entries that are
currently supposed to be in use.  Could you give a scenario that you are
concering?

	Byungchul

> To solve it generically, I suspect you'll need some kind of special
> non-present PTE to say:
> 
> 	There _was_ a PTE here that wasn't flushed.
> 
> Sure, you can add gunk to the VMA to track when this happens.  But
> that'll penalize anyone populating a PTE anywhere in the VMA at least
> once.  If there were other threads faulting in pages to the same VMA,
> they'll just end up doing the flush that LUF tried to avoid in the first
> place.

