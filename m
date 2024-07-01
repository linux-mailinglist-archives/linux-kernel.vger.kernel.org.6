Return-Path: <linux-kernel+bounces-236624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B22491E51B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8391B1C20751
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F216D4E8;
	Mon,  1 Jul 2024 16:18:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A092562E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850685; cv=none; b=Fs0WJGLVzVPihz0M2+zolT11ijCKrsoffjKwxfs4pgucosAOIfLulvvZlcbQQ4ddBU90OSfFvxE+a6HtuYbQwWnZO02yy9lRYhYyqzXyg4CaOO9Y06iXP9E9aEZAEbWHWLWufJjoxCW3/iu1iImeh1KLhoI4XhUtlhdEbxgvxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850685; c=relaxed/simple;
	bh=cjTLkb892M+5M8PyfWqf5VWeG9UroP1/A8E4dST4H4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eV4RYnx19ffitPkiRXZ7WvW90Uq0zuwTD5u8Vr4HwG6nD7QP3UKaYLbPQj8bXdgWg8EMJd4asiuV9xyrPO64EC4gRuQJnyCxRVjCDunGKJr6IXdVpWiRfnfsEgZrha3GV/xTPQO8mjjzB5DEXFL/oegy2tErxTdoIrbHTs2MsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E16339;
	Mon,  1 Jul 2024 09:18:26 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 441A23F73B;
	Mon,  1 Jul 2024 09:18:01 -0700 (PDT)
Message-ID: <f98d7d30-ea54-4f46-9052-9027a4580d87@arm.com>
Date: Mon, 1 Jul 2024 17:17:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] vdso: Add comment about reason for vdso struct
 ordering
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
 <20240701-vdso-cleanup-v1-2-36eb64e7ece2@linutronix.de>
 <ca4f5359-0999-440b-be5d-becfe7f500c8@arm.com> <87jzi5p1qs.fsf@somnus>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <87jzi5p1qs.fsf@somnus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/07/2024 16:31, Anna-Maria Behnsen wrote:
> Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
> 
>> On 01/07/2024 15:47, Anna-Maria Behnsen wrote:
>>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>>
>> nit: Can you please add something in the commit message?
> 
> Sure, I would propose the following:
> 
> The struct vdso_data is optimized for fast access to the often required
> struct members. The optimization is not documented in the struct
> description but it should be kept in mind, when working with the
> vdso_data struct.
> 
> Add a comment to the struct description.
> 
>>
>> Otherwise:
>>
>> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Thanks!
>

Works for me. Thanks!

>>> ---
>>>  include/vdso/datapage.h | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
>>> index d04d394db064..7647e0946f50 100644
>>> --- a/include/vdso/datapage.h
>>> +++ b/include/vdso/datapage.h
>>> @@ -77,6 +77,10 @@ struct vdso_timestamp {
>>>   * vdso_data will be accessed by 64 bit and compat code at the same time
>>>   * so we should be careful before modifying this structure.
>>>   *
>>> + * The ordering of the struct members is optimized to have fast access to the
>>> + * often required struct members which are related to CLOCK_REALTIME and
>>> + * CLOCK_MONOTONIC. This information is stored in the first cache lines.
>>> + *
>>>   * @basetime is used to store the base time for the system wide time getter
>>>   * VVAR page.
>>>   *
>>>

-- 
Regards,
Vincenzo

