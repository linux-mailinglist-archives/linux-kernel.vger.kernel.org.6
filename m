Return-Path: <linux-kernel+bounces-544884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A7A4E6F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6C68C03D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605327BF65;
	Tue,  4 Mar 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev+4igjO"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBA126BF9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104553; cv=fail; b=fQVsNNGaYXCj25I4twRQBdulrYyFIaCaOxSqEXRAhJe0Ubl4f1zaC8NsVc13O+xrp+k1QbLUtzcG8a5w1D+OWQiAuDk93MzmkaUJ9Avh+EwY/GEs0oytPR5oZfE5zLVxj9Ku0AKsN9F96oMkVmpftls7PQtDMhmbvfTH42SjmE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104553; c=relaxed/simple;
	bh=DDx8zsCrW8tfDv+BP7lH3eyFT8+V8mBVDEocb0I5NmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baNfLcjf71Y+W2yIUqKWAon7e95gAAZlTrNOZ4CX55PAqPOGKKVWZrvvnY+1obV+bIN1UPXlO9OmJ73f2FJViBYxMwk6HgeX+hLfm2i7tEE372bywga8s5yaFC7GSuXJ522lQQyI0ssO1NQbbCa7svQ+MJDApyoKjvA/JIYSGOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev+4igjO reason="signature verification failed"; arc=none smtp.client-ip=170.10.129.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 106CF40D9743
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:09:10 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ev+4igjO
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gWx3bkYzG1sT
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:05:49 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 88E5E4275C; Tue,  4 Mar 2025 19:05:37 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev+4igjO
X-Envelope-From: <linux-kernel+bounces-541320-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev+4igjO
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id B11FF42EC6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:58:14 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 889CA3064C0B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:58:14 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0961885C4E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7657F1F17E5;
	Mon,  3 Mar 2025 09:57:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7661F130B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995858; cv=none; b=iVbApv8JIDIXsGMRfmI9hBVZH02GcdLg3MjN+LdpR76nVpwzptknskUNW3N+OkufDoFfR2PiZbjAylAMq0WXPSkeX/j8f4zOtsTVKk/J0H3JSMpErWFPVFBir4JnNhmbclRlKHWMRwxNPuN9AN2z1GIMRETBqJspvnkWpUrhW0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995858; c=relaxed/simple;
	bh=OlfOKlRc1CiBZb5Ud3wlY9YTANw9SXSmmOkIniwxfkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/NbPMbWctVa0XnjlNSTlq4Pa1IG/CTQrgu+BKjxzkf95C1NFGaDiHeR/79vXzCKLZaSyWskQjJhjMRprOw9iW1oSRgplVUWXGRnG4TQgWv/t1HaUsxySwDrRIk/1RuigJSHmbJltTCUerpOJ4oWlJMrAvl7FqOO4j5dSGcrXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev+4igjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740995855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ykua7q7gnustm8lPrA9ZG6NARq70FXycw/3eNBtt0hs=;
	b=Ev+4igjOAV2dZVTkYAenuccUQUPIn7GAD2BN8FUqVIdvUYxQs7Ouv4iPEphnkz4RBhGn5+
	k0Mipjdj++jEWS62Jl4ZhLyFRsHF1hFmnocDHb/UP85BAptmEPeY/UKed7Z3VlIw9PF/iG
	tj/zSukQMVkLahR8ClOjfago7lQPJuk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-N8lCu01ZPf-MWkL6NsmAGw-1; Mon, 03 Mar 2025 04:57:24 -0500
X-MC-Unique: N8lCu01ZPf-MWkL6NsmAGw-1
X-Mimecast-MFC-AGG-ID: N8lCu01ZPf-MWkL6NsmAGw_1740995844
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4393e89e910so23893615e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740995843; x=1741600643;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ykua7q7gnustm8lPrA9ZG6NARq70FXycw/3eNBtt0hs=;
        b=DkQVaghL2BwaQ/ajLPoz7c6Oh58HbCi693P/JeifOTDfFYsyupBG7fJLsC6lmvcYis
         wkw0y5Wq5YDeod0B4g2B6zQZDZEJFj9qWKTw1RVo3okDDaL5wTJPFgleoz+YPb/ZeFsn
         qOMk5fJ+j/30fb9I3n8jySr2QcFutaF0rXidsa15K2Eje6oYttGDUBYLtbQYzm2lj+YJ
         AURphv+ZcH4LgxIHAs1ZPZxw3q+kGQgw5Kwj9+BNryE4dC6uJxcPaD1EDWKraWufbK2Z
         YaYKimNoMZPvwFF+fW/+dQPlzKKn43UnFKpxaZivJ/+DiFHJ2U9L8J9gL0hn+vmJF0xG
         7q1g==
X-Forwarded-Encrypted: i=1; AJvYcCW9Sd6GIM8sArYbq2kR6Zw/2LhN8xiZwXYBM4H0A6Y0GLI4CAcj8mWyIlbnmsHuX77I4uGROq/4seO3mtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHWzlk8fPJ0pROjRXnX5mhTF/LmCYRFA3zecnn+Ts1F1OX7CO
	XE/DJHx/sy7iiZUC6KfBKMeJtuTom9sJaFDMJSErgVwSjGMhTDvxqNK1FcjGRToVYGOSTJLD+OM
	4EwP72s1qY+VHqfKp50MC0jMSbveopWSa4MNXFnw3FfhlqjqdICK+33hL1N2Y1g==
X-Gm-Gg: ASbGnctr23P6bm1f90OHVzo/BV1/+wMCwjdX/8dttzswHfuEOjNmyqdsPcbHqsR+2C2
	Kv5pdrBVkMKs5sJZOzVbcDtoWn/6jsw0f/L7sn+zi0wYZKyZbyhr9PjKjUeA0XdClLYwtwewXXN
	c5NhSoEzTi0jsh/hdzc8GViIoMOpcBaNgVZlAOAlf1EWzO/fjQ56tdqNaESQ1/8SmnSKBLS/Nsn
	IxRnhRolMeNZPJZk3QLSrhYW/XPJYiNZswX4XiPSVOyfz9uFGUHp5x1qd6VJW9QHcct8zzLf5TR
	hiDtmvHi73wTa6avn951G5t23GalfVLSUa3XGW6zAkQulAYNslijiQdRtJQBIavR4Xh5DMxB5sj
	MUF9X0VbD0M0YkDoDStiw+3tPvl9s1Xcl9po/XJh+qoE=
X-Received: by 2002:a05:6000:178b:b0:390:e7c1:59d3 with SMTP id ffacd0b85a97d-390ec7c6abamr9721388f8f.2.1740995843582;
        Mon, 03 Mar 2025 01:57:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyA1rt+UhzjYjejJGIWpt5BNfcz7BL9jMerlSYdXlUaUi7HhGoy2uwdvEypDw3lLTiKoqZLw==
X-Received: by 2002:a05:6000:178b:b0:390:e7c1:59d3 with SMTP id ffacd0b85a97d-390ec7c6abamr9721350f8f.2.1740995843219;
        Mon, 03 Mar 2025 01:57:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795da5sm14193732f8f.15.2025.03.03.01.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 01:57:22 -0800 (PST)
Message-ID: <7e987f17-ffcb-45e0-8588-2d569d90f776@redhat.com>
Date: Mon, 3 Mar 2025 10:57:21 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250303094947.GB13345@e133081.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gWx3bkYzG1sT
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709244.60401@nJ2FfmZFx6M4rQfx/3qbtQ
X-ITU-MailScanner-SpamCheck: not spam

On 03.03.25 10:49, Miko=C5=82aj Lenczewski wrote:
> Hi David,
>=20
> Thanks for taking the time to review.
>=20
> On Mon, Mar 03, 2025 at 10:17:12AM +0100, David Hildenbrand wrote:
>> On 28.02.25 19:24, Miko=C5=82aj Lenczewski wrote:
>>> If we support bbml2 without conflict aborts, we can avoid the final
>>> flush and have hardware manage the tlb entries for us. Avoiding flush=
es
>>> is a win.
>>>
>>> Signed-off-by: Miko=C5=82aj Lenczewski <miko.lenczewski@arm.com>
>>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    arch/arm64/mm/contpte.c | 3 ---
>>>    1 file changed, 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>>> index 145530f706a9..77ed03b30b72 100644
>>> --- a/arch/arm64/mm/contpte.c
>>> +++ b/arch/arm64/mm/contpte.c
>>> @@ -72,9 +72,6 @@ static void contpte_convert(struct mm_struct *mm, u=
nsigned long addr,
>>>    		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>>>    	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
>>> -
>>> -	if (system_supports_bbml2_noabort())
>>> -		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>>>    }
>>>    void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
>>
>> What's the point of not squashing this into #2? :)
>>
>> If this split was requested during earlier review, at least seeing pat=
ch #2
>> on its own confused me.
>=20
> This split is a holdover from an earlier patchset, where it was still
> unknown whether the removal of the second flush was permitted with
> BBML2. Partly this was due to us being worried about conflict aborts
> after the removal, and partly this was because the "delay" is a separat=
e
> optimisation that we could apply even if it turned out the final patch
> was not architecturally sound.
>=20
> Now that we do not handle conflict aborts (preferring only systems that
> handle BBML2 without ever raising aborts), the first issue is not a
> problem. The reasoning behind the second patch is also a little bit
> outdated, but I can see the logical split between a tlbi reorder, and
> the removal of the tlbi. If this is truly redundant though, I would be
> happy to squash the two into a single patch.

Thanks for the information.

Does patch #2 (reordering the tlbi) have any benefit on its own? I read=20
"other threads will not see an invalid pagetable entry", but I am not=20
sure that is correct. A concurrent HW page table walker would still find=20
the invalid PTE? It's just a matter of TLB state.

If there is no benefit in having patch #2 independently, I'd just squash=20
them. Reordering to then remove is more complicated than just removing=20
it IMHO.

--=20
Cheers,

David / dhildenb



