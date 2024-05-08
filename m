Return-Path: <linux-kernel+bounces-173609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E508C02D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E769CB22AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF2524AF;
	Wed,  8 May 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="H9DTgRrM"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886A63E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188537; cv=none; b=TForp98tm/9KUsC8ifA8jMzE6kv2g8HBOmXNVcDCGVSjVhxGRzML3rPZzkmlyO5I9a5NHVPiwLRU9vgt2lyFGxAh6wrrMtbUnAu2NY7coZvzVP8HSda2EWfD6AnttSaO2IwikRLgamMA2LKeSYxKfYUBvT3qSiNXq85d5VpMNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188537; c=relaxed/simple;
	bh=CPDYOJthGwxvd6Ww1/rBsQAd3NnJHGJPANIpBp0Zf0k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UEEiJAguwmB7cEvX2T3xpxxAeCViX5+lpdiRFeZLkmNQkfQcy3o8sd6tewMRG6TlHt1CPeZyDhWe45kqNLKW/9EubewGukwRVXRZ+IbNo4CsZTMpupyjfgd3HH6fNsRynBDS4skrilYChluJTflUycOz6QKhSO+Zn3qUrKhTrfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=H9DTgRrM; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1715188528;
	bh=CPDYOJthGwxvd6Ww1/rBsQAd3NnJHGJPANIpBp0Zf0k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=H9DTgRrMRH2cfFgHxweDWIGneBqH6vz46oKu6AgtazBfQzt2RHmP0t4nyzHCZGzwu
	 WYrVvxt+ctAp/iKmq1/DBV3JvdeSQ6J0omjTwrSNvlDduxZyawEOCU32CvXkDYKY+/
	 O6ONFbiBAuGcg+D+V1iEuLiGSr+4j7JETim4j39s=
Received: by gentwo.org (Postfix, from userid 1003)
	id DE8AD40926; Wed,  8 May 2024 10:15:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id DCFF540925;
	Wed,  8 May 2024 10:15:28 -0700 (PDT)
Date: Wed, 8 May 2024 10:15:28 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com, 
    will@kernel.org, scott@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW
 instructions
In-Reply-To: <c9c3c0d5-bb61-4eed-8b89-b0341a2c6f5c@arm.com>
Message-ID: <c1ba9ba3-b0d6-4c6c-d628-614751d737c2@gentwo.org>
References: <20240507223558.3039562-1-yang@os.amperecomputing.com> <c9c3c0d5-bb61-4eed-8b89-b0341a2c6f5c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 8 May 2024, Anshuman Khandual wrote:

>> The atomic RMW instructions, for example, ldadd, actually does load +
>> add + store in one instruction, it may trigger two page faults, the
>> first fault is a read fault, the second fault is a write fault.
>
> It may or it will definitely create two consecutive page faults. What
> if the second write fault never came about. In that case an writable
> page table entry would be created unnecessarily (or even wrongfully),
> thus breaking the CoW.

An atomic RMV will always perform a write? If there is a read fault 
then write fault will follow.

>> Some applications use atomic RMW instructions to populate memory, for
>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
>
> But why cannot normal store operation is sufficient for pre-touching
> the heap memory, why read-modify-write (RMW) is required instead ?

Sure a regular write operation is sufficient but you would have to modify 
existing applications to get that done. x86 does not do a read fault on 
atomics so we have an issue htere.

> If the memory address has some valid data, it must have already reached there
> via a previous write access, which would have caused initial CoW transition ?
> If the memory address has no valid data to begin with, why even use RMW ?

Because the application can reasonably assume that all uninitialized data 
is zero and therefore it is not necessary to have a prior write access.

>> Some other architectures also have code inspection in page fault path,
>> for example, SPARC and x86.
>
> Okay, I was about to ask, but is not calling get_user() for all data
> read page faults increase the cost for a hot code path in general for
> some potential savings for a very specific use case. Not sure if that
> is worth the trade-off.

The instruction is cache hot since it must be present in the cpu cache for 
the fault. So the overhead is minimal.


