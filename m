Return-Path: <linux-kernel+bounces-544969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9963A4E748
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3145F19C721B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F8529CB5C;
	Tue,  4 Mar 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIldS06+"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542629CB46
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105837; cv=fail; b=B2jYoJp5p1Sh3uT+0e1xrcVNFkb675hPxgX72kl8Qi4KiR5Gqj0M3xIuUqSJMbC6ytRkV5+CFJI2dfwweFI32eSoY8RGaH1e6B91Fd7ZesFLFM7eTlfq8KiPmBG7Z7R12CC7L5lRWFEa6WJWtDIEweEkE3asmpbKNgCYvgIsog4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105837; c=relaxed/simple;
	bh=BcbMSdTCTAMrHi+ED8uX4f4o/u/6f7OnU8huYKBAoN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnsFVLWcTTr4BwjBvfwU2KlysAGIyWp3zvuC0FrLghTTCjp+wTQDnlSq6RH13JqsjkLNGrjuCLoOisqkFj0pWOQWe7EUK48s13pYVyYpR+iX51haMcGL5We7kCbDgZQEeDksJ3SMe6Vpv60c6y79pcB0zii3ymaAz5QJbVK2ZPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIldS06+ reason="signature verification failed"; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id EA8A8408B5FC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:30:33 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BIldS06+
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h3G24D0zG3Gp
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:29:30 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5873F41898; Tue,  4 Mar 2025 19:29:29 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIldS06+
X-Envelope-From: <linux-kernel+bounces-541611-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIldS06+
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id D6D65420DD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:42:37 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id A4599305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:42:37 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860891889DD6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1DD202F9C;
	Mon,  3 Mar 2025 11:42:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC820298E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002143; cv=none; b=rW1VIbP2LWMCqkorD+gPHS6Sii93JArzkwhG5WQ22Um+6MssfT/8zFu6UHmhmYgolY+gADEobyU0MlmYPE/gFToJc/WaEYUzrHteR6zB5fY5gN/N0uhETr64lIgXwcG7YzeyvLVOZCRCHQnd01SKzkNqeFNtxDhBklRQqT1SMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002143; c=relaxed/simple;
	bh=oyoGpoAogNlFLsEfP7tF62uwgGj7bpQ4UrXetHF74oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5atHEvcdWVkSslwf8FT6EdznRDQJ125VAxGKeo7Y9M6gUUbT8flc0URlUMLSuSM7wJTFkCQRyEKIUjZMGH5AWrgkbBvOrDg19l10YXzTdWxz0BLFAkgf70gA86j7/lkpk7asEXl0vn03TU8I8lX60EXle4FK+o4DEIXQI3sY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIldS06+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741002140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GK+r8CB/zopdHXRJVOxigdSQmwtLGrthh+WgPUejIE4=;
	b=BIldS06+DAZmGjaNxP9m5gzL5IEb7oC+0yQXrtCFSX3j1MhQSRFLqRJRAqIsCYz6hc95OO
	jy5vZvjkF3B1xne2C8HYaVL9FJ8NqHdO6IMaH2G3hWR0w8Bunx210brIpBjvSTyWRk79oA
	ruqzhfeJj/wCCIyBx/9OVbjpbweJTjk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-VcFBPu_-OOSUfqb_EdzrGw-1; Mon, 03 Mar 2025 06:42:19 -0500
X-MC-Unique: VcFBPu_-OOSUfqb_EdzrGw-1
X-Mimecast-MFC-AGG-ID: VcFBPu_-OOSUfqb_EdzrGw_1741002138
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so19160445e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002138; x=1741606938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GK+r8CB/zopdHXRJVOxigdSQmwtLGrthh+WgPUejIE4=;
        b=hIw4+ME0iNaNxtWHPQlMtNlG9PthK5O+AwzqGOgGI/ooaEqNqtElIBQ2fwnkptzwox
         4JPtSQD1DD6L9/D541QWQ8sFXGLOutlUoTYxW5rFsDAj/gk6jTul4oW6CPwnu5+qmYUI
         jOV4vKRjQidyMkp8DYn+tFXgJgrA0dKJG0/TQR2PfFjEUlSL3w0BheQMUIlPHBa7FySg
         BHWJwto9vraLfmreU1l0ira8mhJab1DalZ6fUUvfVzIjPK1N2PCC10MDrPyYrF9zaMlE
         i0yG9P1LAJUymrZKA0H343vxVIumT0+5wABngF/8FVnr1gQMWrbGmvBMuSQTaU2OsL47
         cCoA==
X-Forwarded-Encrypted: i=1; AJvYcCXFT+IdYIQa0fASCbcR2ptwhSr2o272pTnR69q7EpNy0uQBkNAZDVDC2barqG9pdVRo8TLW0rIDGy5gKCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+t4Jd0SxB/hgWApGWWJCf7MzqbCdkU2VDzU6u789Uc68gBvpe
	MLAzH3UHH9OWOHD2gJAP69+5Xr1qv/nKiRwNyvKFTckA64Gs5YNbOXV0vCMocfMEkwF6OfBeKsD
	GHEn8Wb1REQDiKWGiFkJ18k2U99L0BaQJ+uG2spqENSrQA0kZwg4RZn4f2+JllA==
X-Gm-Gg: ASbGnctUewIlgImsuGTNf6IBb1qWZUk8MiBKJe1xXofAa5PA8iVDnbRHAZc+uVVeDY5
	5gaZqcDaSvjQ/iwPBMeMHQXxTmHxzmDhTKwPVtyFR9s0Du/UztsAiBUF07R3rsHGuCMGVrNVtVu
	+u14JjW1B89rdFgAkpT8MMDxoGe8q5vhi5ub+NlKwNQVqHzfWZIYeKRBaebYTNZyhrne1d5KHxm
	uGobSX0DwUfK3cX0JMiPS82IY/UfI580MVuVGx9th6l+Oww4uUqwN0tpqLHyVH39WyupX6Mlh9p
	uNFC4Avttrla1sv30mAxg804/uNnNJ34/iiuNgrj9K2oIOEW8rzGMhq+wlOcXz/Z/iXhKxGqUnB
	eW3MD1Rznsy6NSVh57NFeDCTTa7rfnWyBhZYvoK35PjE=
X-Received: by 2002:a05:600c:3506:b0:439:8e46:ee73 with SMTP id 5b1f17b1804b1-43ba6704446mr119492665e9.15.1741002138229;
        Mon, 03 Mar 2025 03:42:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe6WbxcsGzXZWMC0pjNXpsivZUSmi+rYJFcr/S86qicmIKfyXyNyDXrqfgaMGgOQqTiegQEw==
X-Received: by 2002:a05:600c:3506:b0:439:8e46:ee73 with SMTP id 5b1f17b1804b1-43ba6704446mr119492405e9.15.1741002137875;
        Mon, 03 Mar 2025 03:42:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532ba6sm186494095e9.12.2025.03.03.03.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 03:42:17 -0800 (PST)
Message-ID: <0ff27dbb-401b-4793-be70-1ff9c8010e4a@redhat.com>
Date: Mon, 3 Mar 2025 12:42:11 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
 yang@os.amperecomputing.com, catalin.marinas@arm.com, will@kernel.org,
 joro@8bytes.org, jean-philippe@linaro.org, mark.rutland@arm.com,
 joey.gouly@arm.com, oliver.upton@linux.dev, james.morse@arm.com,
 broonie@kernel.org, maz@kernel.org, akpm@linux-foundation.org, jgg@ziepe.ca,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-5-miko.lenczewski@arm.com>
 <f270bb5d-aa54-45d3-89ed-2b757ab3a4b0@redhat.com>
 <20250303094947.GB13345@e133081.arm.com>
 <7e987f17-ffcb-45e0-8588-2d569d90f776@redhat.com>
 <20250303105539.GA74129@e133081.arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250303105539.GA74129@e133081.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h3G24D0zG3Gp
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710575.30338@CjbbVp6bq17kqN3A4lrnAQ
X-ITU-MailScanner-SpamCheck: not spam

On 03.03.25 11:55, Miko=C5=82aj Lenczewski wrote:
> On Mon, Mar 03, 2025 at 10:57:21AM +0100, David Hildenbrand wrote:
>> On 03.03.25 10:49, Miko=C5=82aj Lenczewski wrote:
>>> Hi David,
>>>
>>> Thanks for taking the time to review.
>>>
>>> On Mon, Mar 03, 2025 at 10:17:12AM +0100, David Hildenbrand wrote:
>>>> On 28.02.25 19:24, Miko=C5=82aj Lenczewski wrote:
>>>>> If we support bbml2 without conflict aborts, we can avoid the final
>>>>> flush and have hardware manage the tlb entries for us. Avoiding flu=
shes
>>>>> is a win.
>>>>>
>>>>> Signed-off-by: Miko=C5=82aj Lenczewski <miko.lenczewski@arm.com>
>>>>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>     arch/arm64/mm/contpte.c | 3 ---
>>>>>     1 file changed, 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>>>>> index 145530f706a9..77ed03b30b72 100644
>>>>> --- a/arch/arm64/mm/contpte.c
>>>>> +++ b/arch/arm64/mm/contpte.c
>>>>> @@ -72,9 +72,6 @@ static void contpte_convert(struct mm_struct *mm,=
 unsigned long addr,
>>>>>     		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3)=
;
>>>>>     	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
>>>>> -
>>>>> -	if (system_supports_bbml2_noabort())
>>>>> -		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>>>>>     }
>>>>>     void __contpte_try_fold(struct mm_struct *mm, unsigned long add=
r,
>>>>
>>>> What's the point of not squashing this into #2? :)
>>>>
>>>> If this split was requested during earlier review, at least seeing p=
atch #2
>>>> on its own confused me.
>>>
>>> This split is a holdover from an earlier patchset, where it was still
>>> unknown whether the removal of the second flush was permitted with
>>> BBML2. Partly this was due to us being worried about conflict aborts
>>> after the removal, and partly this was because the "delay" is a separ=
ate
>>> optimisation that we could apply even if it turned out the final patc=
h
>>> was not architecturally sound.
>>>
>>> Now that we do not handle conflict aborts (preferring only systems th=
at
>>> handle BBML2 without ever raising aborts), the first issue is not a
>>> problem. The reasoning behind the second patch is also a little bit
>>> outdated, but I can see the logical split between a tlbi reorder, and
>>> the removal of the tlbi. If this is truly redundant though, I would b=
e
>>> happy to squash the two into a single patch.
>>
>> Thanks for the information.
>>
>> Does patch #2 (reordering the tlbi) have any benefit on its own? I rea=
d
>> "other threads will not see an invalid pagetable entry", but I am not =
sure
>> that is correct. A concurrent HW page table walker would still find th=
e
>> invalid PTE? It's just a matter of TLB state.
>=20
> I think I understand what you mean. I agree that it is possible for a
> concurrent walk to see an invalid TLBI state, if it is on the same TLB
> that the repaint is happening on. For other TLBs, the flush has not yet
> propagated our invalidated PTEs (from `__ptep_get_and_clear()`) though?

What I am saying is: if there is no TLB entry yet, HW will walk the page=20
table to find no present PTE and trigger a fault.

> That invalidation will only be seen by other TLBs after the
> `__flush_tlb_range()`, so we should save a few faults because only
> "local" threads will ever see the invalid entry, as opposed to all
> threads that try to read our modified range?

So what you say is, that deferring the flush means that if there is=20
already a TLB entry, flushing deferred reduces the likelihood that a=20
page table walk is triggered that could find no present PTE:=20
consequently, reducing the likelihood that a page fault is triggered.

(I use the word likelihood, because I assume other action could result=20
in a TLB entry getting flushed in the meantime, such as TLB entry reuse)

Correct?

Or it is the case that I
> have misunderstood something basic here, or that I have misinterpreted
> what you have written?

No, that makes it clearer, thanks.

--=20
Cheers,

David / dhildenb



