Return-Path: <linux-kernel+bounces-533364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68638A45911
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820CA3A43E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD6E20DD4D;
	Wed, 26 Feb 2025 08:55:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265EF258CF6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560134; cv=none; b=MKdPucjyEl1k8xL/aLCOPdn7Xkrqsc/0ckYl4I9je0IhXO5yf8rbZmeRuoFa1vGAbtvZJi/2IMiwiOKYCzytXuvAxYDdWfOALXQZclR6XE1pQzLOoEofUFlQ9TbP1NONbGd/fp2yjMZH4zwTDF82nkQL3PNpZhqjfTuR2uV467U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560134; c=relaxed/simple;
	bh=0+51M4Nbyf6waNQ4dGj4iEc36P0jrC4pTrry9E2QESw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeMdWZ6XlcvHBF3l9NqrkUbVNDbo6NRT252ZofWBKfLXX54eOZLXmzhzzP3lnI9fV09VZsimhinb/JJvzhpKILlsYZf59q+0JWBJn4cdCVC+jX5TPMuKJJ8Iua7BmsAaoioAJQbNrog3nYi78RG/6VMWONBQoRj6OyKat70wTes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 777091063;
	Wed, 26 Feb 2025 00:55:47 -0800 (PST)
Received: from [10.57.84.229] (unknown [10.57.84.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 523C43F6A8;
	Wed, 26 Feb 2025 00:55:30 -0800 (PST)
Message-ID: <b6b999c9-79cd-4945-9d7a-c5ee8158b7dc@arm.com>
Date: Wed, 26 Feb 2025 08:55:28 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXHJGC9aYCwwb2XTWfhAjH6GDKQptNdLwO+hfv6hazivHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2025 08:33, Ard Biesheuvel wrote:
> On Wed, 26 Feb 2025 at 09:07, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 26/02/2025 06:59, Ard Biesheuvel wrote:
>>> On Wed, 26 Feb 2025 at 01:10, Will Deacon <will@kernel.org> wrote:
>>>>
>>>> On Tue, Feb 25, 2025 at 07:05:35PM +0100, Ard Biesheuvel wrote:
>>>>> Apologies for the breakage, and thanks for the fix.
>>>>>
>>>>> I have to admit that I was a bit overzealous here: there is no point
>>>>> yet in using the sanitised value, given that we don't actually
>>>>> override the PA range in the first place.
>>
>> But unless I've misunderstood something, parange is overridden; Commit
>> 62cffa496aac (the same one we are fixing) adds an override to force parange to
>> 48 bits when arm64.nolva is specified for LPA2 systems (see mmfr2_varange_filter()).
>>
>> I thought it would be preferable to honour that override, hence my use of
>> arm64_apply_feature_override() in the fix. Are you saying we don't need to worry
>> about that case?
>>
> 
> I wouldn't think so (but I'm glad you brought it up because this
> didn't occur to me at all tbh)
> 
> With arm64.nolva, both the VA and PA ranges will be reduced, and so
> the range of the linear map will be 47 bits. So if the PA range is
> being reduced from 52 to 48, it will still exceed the size of the
> linear map, and so it should make no difference in this particular
> case.

OK, so I think you're saying it'll happen to work correctly even if we ignore
that override? That sounds a bit fragile to me. Surely we should be consistent
and either always honour the override or remove the override in the first place?

> 
> The use case I had in mind was to allow the PA range to be reduced to
> a value that is substantially less than the range of the linear map,
> e.g, 40 bits on a 48-bit VA kernel. On the Android side, the issue of
> the missing linear map randomization has come up a couple of times,
> but there is no clear direction at this point, so adding this feature
> here was premature (mea culpa)


