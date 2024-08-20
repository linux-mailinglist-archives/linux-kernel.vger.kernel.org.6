Return-Path: <linux-kernel+bounces-294564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A9958F47
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B282856F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E81BB6A3;
	Tue, 20 Aug 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Efi/Nfdy"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201A450E2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186735; cv=none; b=iTW01vPqlcP7WREurn2q2XCWKU4FJYAoFtxURQCAOOgF1PzuuZvHxEe2gu4B27VRZRIczM8W1D/mRE3Yb4913nXP8/e2fofobPxhsBvUWFVOXx7f9tEiebw/zxdjkiYWpikVymCPzzOn6WVtgjlzm3WGEi01Jfjboyfn7u5wRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186735; c=relaxed/simple;
	bh=WhQc0HaHmJ9fverjUpscIOx+j5ESzLExjWwfzXBzNJo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jij+FLeT6sUNqa62zThVXhlDXDp+nKLuty/lgjAW2sNeFoZiIB7TXiYILodlm/YnbmplL5lMDFxDh2VujsBKdW/c6jzNp1xYtxIaYtZtMTyAGCWfLHXL2eTyxGkO13ygzsbjozDBxSctyF1RoQvCfUxVz4T6N6wxe44/ejxInAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Efi/Nfdy; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724186729;
	bh=WhQc0HaHmJ9fverjUpscIOx+j5ESzLExjWwfzXBzNJo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Efi/NfdyoNnmYpn2qa4nDm2rsdq7rPc9yqf3L5uj2hTc83p3BpzQj2Qw2GB1gw1GU
	 K8NP0NHbAwZj/WbDecA8zVGE9k6fra1mOqGVRDEcG4Ju+PCF//VnQGrCP7IVjq1kzg
	 YSVQ/3mwiEOCYN6xhtq/sxunpDAfcyRtkKn5/C8mIOHiZhQxV2Chfywm1NMrOvMj+D
	 Wjz2LDUozmC/CVR9A3iTWyQvRiVOii0jEgAyDGxsk6ovpS56uiOvrzeWWnzUfangUM
	 lOu7zm3hXx0IqA9KM2eFy+m34y/8zYKBarkxXerfpBvpqXIr12plqJ2SENnmj7bQAg
	 xwvFhiy0TnnOQ==
Received: from [192.168.1.5] (109.56.13.38.mobile.3.dk [109.56.13.38])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WpM140lW9z1J1r;
	Tue, 20 Aug 2024 16:45:27 -0400 (EDT)
Message-ID: <df068816-7269-4275-a673-d9ed5c050365@efficios.com>
Date: Tue, 20 Aug 2024 22:45:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] lib: Implement
 find_{first,next,nth}_notandnot_bit, find_first_andnot_bit
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
 <20240819142406.339084-2-mathieu.desnoyers@efficios.com>
 <ZsOatkpPqzMF6B_c@yury-ThinkPad>
 <1207b505-0842-40cc-a581-44e595f67601@efficios.com>
Content-Language: en-US
In-Reply-To: <1207b505-0842-40cc-a581-44e595f67601@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-20 19:19, Mathieu Desnoyers wrote:
> On 2024-08-19 21:19, Yury Norov wrote:
[...]
>>> +/**
>>> + * find_next_notandnot_bit - find the next bit cleared in both 
>>> *addr1 and *addr2
>>> + * @addr1: The first address to base the search on
>>> + * @addr2: The second address to base the search on
>>> + * @size: The bitmap size in bits
>>> + * @offset: The bitnumber to start searching at
>>> + *
>>> + * Returns the bit number for the next bit cleared in both *addr1 
>>> and *addr2.
>>> + * If no such bits are found, returns @size.
>>> + */
>>> +static inline
>>> +unsigned long find_next_notandnot_bit(const unsigned long *addr1,
>>> +        const unsigned long *addr2, unsigned long size,
>>> +        unsigned long offset)
>>> +{
>>> +    if (small_const_nbits(size)) {
>>> +        unsigned long val;
>>> +
>>> +        if (unlikely(offset >= size))
>>> +            return size;
>>> +
>>> +        val = (~*addr1) & (~*addr2) & GENMASK(size - 1, offset);
>>> +        return val ? __ffs(val) : size;
>>> +    }
>>> +
>>> +    return _find_next_notandnot_bit(addr1, addr2, size, offset);
>>> +}
>>> +#endif
>>> +
>>
>> It's not said explicitly, but some naming conventions exist around bitmap
>> searching.
>>
>> If you're looking for a clear (unset) bit in a mask, you'd use a 'zero'
>> modifier. We have only 2 such functions now: find_{first,next}_zero_bit,
>> both taking one bitmap. I think it's time to extend this rule for
>> many bitmaps and write down the naming rules.
>>
>> With the following, the find_next_notandnot_bit() should be named
>> like; find_next_zero_and_bit(). It's not perfect, but still sounds
>> better to me than 'notandnot' thing.

Actually, now that I come to think of it in terms of logic gates:

~A & ~B == ~(A | B)

So this "notandnot" is simply a "NOR" gate.

I therefore intend to name it "find_next_nor_bit" if that's OK with
you.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


