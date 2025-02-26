Return-Path: <linux-kernel+bounces-533807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22665A45E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01C67AAB38
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B0D214803;
	Wed, 26 Feb 2025 12:19:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FA918DB32
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572382; cv=none; b=YNuiW+SFSbgdUPXaYHd00B0Af7WG5WtTqjoCKTHPLg1laU8HH7OyfXjg+xpB2CGE0BvfaMM6vwos4fwVQeZ+givBAvprDObYSuWuehDE9VAkqE3uA4TcGeLeh9YkyhK4hnfe0GbxUg2SC5IsExG5JyvIEnG1W28RfcuWiAfJaek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572382; c=relaxed/simple;
	bh=5BFhmlMNZIExsCioWXEcpblgs0IJadNX+ccBqCHmH+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8LdvtLjkALEreLMiPjJVM4GPLdMP/QNOc5uxgMU3XXOBcX0U6KM0y1FMxs9XXCx9s88J8fzR0mrj0sKaLzViXjJuKwmhKPI/a6o27k5/0nG3izPTJ6kvA7X3OSVgqadN/Ju1A5JcqNPTk9uhOsFfYHbK1mo/mojR7y6Ck6HYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8399113D5;
	Wed, 26 Feb 2025 04:19:56 -0800 (PST)
Received: from [10.57.84.229] (unknown [10.57.84.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85E6C3F5A1;
	Wed, 26 Feb 2025 04:19:39 -0800 (PST)
Message-ID: <795a1d11-b47f-4ea1-aeab-484a434ea905@arm.com>
Date: Wed, 26 Feb 2025 12:19:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Explicit cast conversions to correct data type
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250219035646.536707-1-anshuman.khandual@arm.com>
 <Z724Q1ofM1GvKquV@J2N7QTR9R3> <9e1721a1-54a4-4007-a0f5-d651f5f21ae2@arm.com>
 <Z73LEkHklpjvIlmZ@J2N7QTR9R3.cambridge.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z73LEkHklpjvIlmZ@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2025 13:52, Mark Rutland wrote:
> On Tue, Feb 25, 2025 at 01:00:40PM +0000, Ryan Roberts wrote:
>> On 25/02/2025 12:32, Mark Rutland wrote:
>>> On Wed, Feb 19, 2025 at 09:26:46AM +0530, Anshuman Khandual wrote:
>>>> From: Ryan Roberts <ryan.roberts@arm.com>
>>>>
>>>> When CONFIG_ARM64_PA_BITS_52 is enabled, page table helpers __pte_to_phys()
>>>> and __phys_to_pte_val() are functions which return phys_addr_t and pteval_t
>>>> respectively as expected. But otherwise without this config being enabled,
>>>> they are defined as macros and their return types are implicit.
>>>>
>>>> Until now this has worked out correctly as both pte_t and phys_addr_t data
>>>> types have been 64 bits. But with the introduction of 128 bit page tables,
>>>> pte_t becomes 128 bits. Hence this ends up with incorrect widths after the
>>>> conversions, which leads to compiler warnings.
>>>
>>> Does 128-bit page table not imply 52-bit PAs?
>>
>> Not to my knowledge. For now the prototype code base is explicitly sticking to
>> 48-bit PA and 44-bit VA (for initial simplicitly because that's the limit for 4
>> levels).
> 
> Fair enough; info dump below, but hopefully nothing of consequence.
> 
> I assume that you're relying on the VMSAv9-128 PA bits [48:12] being in the
> same place as in the VMSAv8-64 descriptors, and being handled by the same
> PTE_ADDR_LOW mask that we use for CONFIG_ARM64_PA_BITS_52=n.

Yes that's what the prototype is doing for now.

> 
> From a quick scan of ARM DDI 0487 L.a, the VMSAv9-128 translation table
> descriptor format always contains a 56-bit PA (though PARange could be
> smaller than that). Bits [51:49] are packed differently than in
> VMSAv8-64 descriptors, and bits [55:52] are obviously new.

Indeed. But given we are running on a platform with 48 bit PA, the prototype
always treating [55:52] as 0 is not getting in the way of anything.

> 
>>>> Fix the warnings by explicitly casting to the correct type after doing the
>>>> conversion.
>>>
>>> I think it would be simpler and clearer if we replaced the macros with
>>> functions, such that __pte_to_phys() and __phys_to_pte_val() are
>>> *always* functions.
>>
>> Yeah, agreed. This was initially just a hack I did to get things working.
> 
> Cool; sounds like we're aligned.
> 
> Mark.


