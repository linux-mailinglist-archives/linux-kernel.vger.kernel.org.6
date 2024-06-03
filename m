Return-Path: <linux-kernel+bounces-199414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0138D86EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9041F22B84
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366113440A;
	Mon,  3 Jun 2024 16:06:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90812DDAF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430797; cv=none; b=kwZUwB36CNQyUvLVU0Ig0spCBRtIf1WIhhwglwKCFkGRgcQTGYr/OvbxkopH4CXhenfmvihKr0e8fL3I+P3TDX9EsqNm1T5a/R57vRtn4axD6QL0ZOn4kKUJmr8PklSTkeYDa5v+goWnIB7vqhTylFNcvzu21pjn7RcehsgGYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430797; c=relaxed/simple;
	bh=0UZs62B0uzeyHX9BtFQPsGHhAg28qGNYuN152C5hu24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMTQcUuPoBkaj2agdl1WZvoAXnyc1DnASZmjHvQp5eLcD3gh0txYP/BV6n/T7eRBpWxQSSuhjB67TeoOGS5+v3qYnZ0FkrJQ9QDoGTl04t5QzFyomwFIiOvGpzK7jmeLJFLvua7B44l0OMWXWh3f4ryrUSN8c3xYdRsYODyD9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9859DC2BD10;
	Mon,  3 Jun 2024 16:06:35 +0000 (UTC)
Date: Mon, 3 Jun 2024 17:06:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>, will@kernel.org,
	anshuman.khandual@arm.com, scott@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <Zl3qCajhEbC9pNAm@arm.com>
References: <20240520165636.802268-1-yang@os.amperecomputing.com>
 <Zk93vBqAD3LgmbGb@arm.com>
 <640f8606-2757-4e82-721f-9625d48ded65@gentwo.org>
 <Zk-SNVyEHT1UsxqD@arm.com>
 <ad87bb77-a9a5-2c0d-b4b2-13db09615d7c@linux.com>
 <Zk-2a7s2pvkVsm2C@arm.com>
 <d18611c7-9108-46f7-a5a5-6c8e0069de9b@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d18611c7-9108-46f7-a5a5-6c8e0069de9b@os.amperecomputing.com>

On Thu, May 23, 2024 at 03:13:23PM -0700, Yang Shi wrote:
> On 5/23/24 2:34 PM, Catalin Marinas wrote:
> > On Thu, May 23, 2024 at 12:43:34PM -0700, Christoph Lameter (Ampere) wrote:
> > > On Thu, 23 May 2024, Catalin Marinas wrote:
> > > > > > While this class includes all atomics that currently require write
> > > > > > permission, there's some unallocated space in this range and we don't
> > > > > > know what future architecture versions may introduce. Unfortunately we
> > > > > > need to check each individual atomic op in this class (not sure what the
> > > > > > overhead will be).
> > > > > 
> > > > > Can you tell us which bits or pattern is not allocated? Maybe we can exclude
> > > > > that from the pattern.
> > > > 
> > > > Yes, it may be easier to exclude those patterns. See the Arm ARM K.a
> > > > section C4.1.94.29 (page 791).
> > > 
> > > Hmmm. We could consult an exception table once the pattern matches to reduce
> > > the overhead.
> > 
> > Yeah, check the atomic class first and then go into the finer-grained
> > details. I think this would reduce the overhead for non-atomic
> > instructions.
> 
> If I read the instruction encoding correctly, the unallocated instructions
> are decided by the below fields:
> 
>   - size
>   - VAR
>   - o3
>   - opc
> 
> To exclude them I think we can do something like:
> 
> if atomic instructions {
>     if V == 1
>         return false;
>     if o3 opc == 111x
>         return false;
>     switch VAR {
>         000
>             check o3 and opc
>         001
>             check 03 and opc
>         010
>             check o3 and opc
>         011
>             check o3 and opc
>         default
>             if size != 11
>                 check o3 and opc
>     }
> }
> 
> So it may take 4 + the possible unallocated combos of o3 and opc branches
> for the worst case. I saw 5 different combos for o3 and opc, so 9 branches
> for worst cases.

Or we have a sorted table of exclusions and do a binary search. Not sure
which one is faster.

> But if they will be allocated to non-atomic instructions, we have to do
> fine-grained decoding, but it may be easier since we can just filter out
> those non-atomic instructions? Anyway it depends on how they will be used.
> Hopefully this won't happen.

Actually, the atomics table has LD64B and LDAPR already which are load
instructions, no write permission needed. So we need to exclude these
and all the unallocated space in this range.

-- 
Catalin

