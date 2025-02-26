Return-Path: <linux-kernel+bounces-533466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990AA45AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E077AB3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA772459CF;
	Wed, 26 Feb 2025 09:55:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836F023817E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563707; cv=none; b=g0uxDqEeOM860vatNOnwImDb8sk/9UGu9IODeHmP6f1toVz4ULUd1GOfrm83y9c2Yfm1hNFb68rWMkD+q6UDYG7L1LuQWHLz7pp7gDJ+Gs5Yr1YPNoAw+uFy0mPW4h1eqEZYjGjz4/rr46zK9CRTJyosWdaZBC0fJruhRowv5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563707; c=relaxed/simple;
	bh=GuF2zhBiuHNUMkgF1b0uzct85c9ZWKI0+WqJvodQPdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxEpkTgcUdAV57eDVDxyU5a4GkdrGzHLOarjACFvSQAuhf9Kt+Soz3ciemPSPeh7VVeSa70Nkg8hsfB/7cIsxxROMOSRNxu7tW1y+C8dWO/C8lMPIX49VXEMHEbu3PHhPi/6oWNaBNSJCk0/+8AvFj54cirbWvOqEc/L4raiLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC9E150C;
	Wed, 26 Feb 2025 01:45:52 -0800 (PST)
Received: from [10.57.84.229] (unknown [10.57.84.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 849503F6A8;
	Wed, 26 Feb 2025 01:45:35 -0800 (PST)
Message-ID: <2c465bdf-8028-4b05-8e18-3154735ce906@arm.com>
Date: Wed, 26 Feb 2025 09:45:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Luiz Capitulino <luizcap@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
 <CAMj1kXHNO+iB4vNFz-4tR_9CPzv96hn+RW=eqyZXMGy_AySDpw@mail.gmail.com>
 <20250226001047.GA24197@willie-the-truck>
 <CAMj1kXH=tPuM+irCsKgycUTbts8h9vD4m3tEtw51YFzWafdSUA@mail.gmail.com>
 <b0578d21-95cd-4d8a-add1-87299f36b491@arm.com>
 <CAMj1kXHJGC9aYCwwb2XTWfhAjH6GDKQptNdLwO+hfv6hazivHQ@mail.gmail.com>
 <b6b999c9-79cd-4945-9d7a-c5ee8158b7dc@arm.com>
 <CAMj1kXHesY77QhnW_U19UURGUqiBuQrNcL-kWQs7niaMa4nAng@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXHesY77QhnW_U19UURGUqiBuQrNcL-kWQs7niaMa4nAng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2025 09:04, Ard Biesheuvel wrote:
> On Wed, 26 Feb 2025 at 09:55, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 26/02/2025 08:33, Ard Biesheuvel wrote:
>>> On Wed, 26 Feb 2025 at 09:07, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 26/02/2025 06:59, Ard Biesheuvel wrote:
>>>>> On Wed, 26 Feb 2025 at 01:10, Will Deacon <will@kernel.org> wrote:
>>>>>>
>>>>>> On Tue, Feb 25, 2025 at 07:05:35PM +0100, Ard Biesheuvel wrote:
>>>>>>> Apologies for the breakage, and thanks for the fix.
>>>>>>>
>>>>>>> I have to admit that I was a bit overzealous here: there is no point
>>>>>>> yet in using the sanitised value, given that we don't actually
>>>>>>> override the PA range in the first place.
>>>>
>>>> But unless I've misunderstood something, parange is overridden; Commit
>>>> 62cffa496aac (the same one we are fixing) adds an override to force parange to
>>>> 48 bits when arm64.nolva is specified for LPA2 systems (see mmfr2_varange_filter()).
>>>>
>>>> I thought it would be preferable to honour that override, hence my use of
>>>> arm64_apply_feature_override() in the fix. Are you saying we don't need to worry
>>>> about that case?
>>>>
>>>
>>> I wouldn't think so (but I'm glad you brought it up because this
>>> didn't occur to me at all tbh)
>>>
>>> With arm64.nolva, both the VA and PA ranges will be reduced, and so
>>> the range of the linear map will be 47 bits. So if the PA range is
>>> being reduced from 52 to 48, it will still exceed the size of the
>>> linear map, and so it should make no difference in this particular
>>> case.
>>
>> OK, so I think you're saying it'll happen to work correctly even if we ignore
>> that override? That sounds a bit fragile to me. Surely we should be consistent
>> and either always honour the override or remove the override in the first place?
>>
> 
> I'm trying to walk a fine line here between consistent use of the
> override, and fixing something that I broke in a nasty way all the way
> back to 6.12.
> 
> So yes, I agree that it would be better to use the override
> consistently, and this is what we should do going forward. But the
> purpose of the original patch was mainly to ensure that we
> consistently program the MMU either in LPA2 or in non-LPA2 mode, and
> not in a mix of the two. The linear mapping randomization change was
> kind of secondary.
> 
> So perhaps this should be two patches:
> - backing out the use of the sanitised register, as proposed by Will,
> with cc:stable
> - a follow up based on your proposal, which can be backported later if
> needed, but without tagging it for stable.

I suspect I'm misunderstanding something crucial about the way the linear map
randomization works (TBH the details of the signed comparisons went a little
over my head).

But my rough understanding is that there are 2 values you want to compare; the
size of the linear map and the PA range. If the PA range is significantly bigger
than the linear map size then we conclude we have enough room to randomize. (I
think this assumes that VA size is always GTE PA size). But if linear map size
is based on an overridden VA and overridden PA size (which I assume it must be,
given the pgtables will be limitted to the overridden VA size) and PA size is
not overridden, isn't it possible to wrongly conclude that there is enough room
to randomize when there really is not?

By that logic, you must include any PA override in this decision and so Will's
patch does not fix this case. Mine does.

But as I say, I'm not confident I understand this logic properly. If my
understanding is incorrect, let's go with your proposal.

Thanks,
Ryan



