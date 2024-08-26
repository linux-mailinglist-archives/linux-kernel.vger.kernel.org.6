Return-Path: <linux-kernel+bounces-301919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A5C95F760
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73BEFB21AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8C0198E61;
	Mon, 26 Aug 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgbAOvZO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954F198A2A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691831; cv=none; b=qIy35nrKlAmRlgYymocTZzv5GL3Iz3ko5nDJIzWeUkUZCgGU1HiASovB+SIfJ4hZDbQbMKzmhfPJa7r6GbQW8Ghm8NzqTcWh2Ss75SGY+nh6RG5dhMQ3mkLX9gt74Vy4FufFpMIgAqK8CayylGOF2UbW82jZVj8OwGr5dWpjFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691831; c=relaxed/simple;
	bh=Wpvxfsl/xKIsB/r3un3pYadBMwRn5bfSxhS+Vdj8uoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqTZgjSmyE1VoSXBBGPUzmrt3L9Z9p06+tiOzify8tLMd326yeyhKwIGYYjiv+5T8rfUJ+UUMDqelmsVZ9IeKhyUaw6cI5LWR903EuAgGsV9ckQZUZzDe47l9+HVyhA9sydxRjfHNWEhwKVzErKoDkDu9TOCRxnTwBFZUF5G2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgbAOvZO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724691829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kFsu14f4i4LlQVERSc8Pt6nldSMLT5wVXv/WD9oSBYc=;
	b=MgbAOvZOX1XDAiLc++uidOFAVqZ6OK7en+JPly9YepVDPZRN4+SJPWmHdd6Jr9kTAz07u4
	9c4GsJhibcQpzTl8d47/hlQ7J6EUSIoHs8S4SMNsvmnGDDYi4fyOjZP6iUVVs2ZNo3xx04
	JElIHeuqjb1yGmr2H+Jz44C0qrgjcjc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-wle8p8HaOjGJ2Sf-ktLeOA-1; Mon, 26 Aug 2024 13:03:47 -0400
X-MC-Unique: wle8p8HaOjGJ2Sf-ktLeOA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280ec5200cso41729945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691826; x=1725296626;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kFsu14f4i4LlQVERSc8Pt6nldSMLT5wVXv/WD9oSBYc=;
        b=uBP0dnxLVExCHNOjHCc12JcTBXZjVxdf5LZ5rHfVuUrfywu6syuASG13zaofDxhDeE
         0Jzcz2YMYw9qdLogtkVyoOjlPv5hacQSvdnFs0mYEIpcFAwLELzG1almPNqesAg6YGvo
         bl19Pw5qOdyu/uh+ZIWceA52E8YLpnOIiNPpF8f319xAkT8amAX8AE25GZZ2xr8fTGEQ
         U/DPuvJfq6fCxsg9avXK68FM2XZUJPvNrZ8qjLa/Hls/7q6r8Jh3HJfoGlVxH+inKkSs
         SCfL+37h2eT7VRw+RR9W31rhbLov9rd5EGf8JRQlKbwG5lrxO0apJYcUBa6MomlWlWeP
         0gVA==
X-Forwarded-Encrypted: i=1; AJvYcCWc+vibWX6TwHPTGIhihXO2D6MXWY7IdRngWZAB2ne8u8l5nzsnmvtMNhuZK9JppLkFc6in3e9gi3GPa+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3A3AymAdXP+cQiEIKGLeoe2m12aYWyZUsOAtKi91xHmwD6RM
	e9maSl9KhsPhGd8S5Zedhy+6Wgg6yAs7zFqsfgCwa1Bs5RD3cyZyaFVORHNIlRDvkFOwEXwyWxq
	1chgCDDcwBm3D7oAehYI3ULnupRlyfXYdBbMPiTmpwk62vOBlUWZabOCiNevUCw==
X-Received: by 2002:a05:600c:4ec6:b0:426:6153:5318 with SMTP id 5b1f17b1804b1-42acc8dd87amr70862455e9.19.1724691826456;
        Mon, 26 Aug 2024 10:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw0uS9vEu6BBNlQmGLpFGxf9J44mEDsF3d6bu7BGQEnYzWfUlzaaAKoGAE30FgbsvLO6D+9g==
X-Received: by 2002:a05:600c:4ec6:b0:426:6153:5318 with SMTP id 5b1f17b1804b1-42acc8dd87amr70862145e9.19.1724691825621;
        Mon, 26 Aug 2024 10:03:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1900:16b0:8dc:77e:31af? (p200300cbc737190016b008dc077e31af.dip0.t-ipconnect.de. [2003:cb:c737:1900:16b0:8dc:77e:31af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b8a351d3asm100411805e9.13.2024.08.26.10.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 10:03:45 -0700 (PDT)
Message-ID: <6f3020e7-f7e8-4d40-b9ce-32a02932a656@redhat.com>
Date: Mon, 26 Aug 2024 19:03:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 opensource.kernel@vivo.com
References: <20240823150206.565-1-justinjiang@vivo.com>
 <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
 <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
 <1109aeab-fd4a-4c83-a110-04d01177d72d@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1109aeab-fd4a-4c83-a110-04d01177d72d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.08.24 08:42, Lorenzo Stoakes wrote:
> On Sun, Aug 25, 2024 at 01:06:40PM GMT, zhiguojiang wrote:
>>
>>
>> 在 2024/8/25 0:26, Lorenzo Stoakes 写道:
>>> [Some people who received this message don't often get email from lorenzo.stoakes@oracle.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
>>>> After CoWed by do_wp_page, the vma established a new mapping relationship
>>>> with the CoWed folio instead of the non-CoWed folio. However, regarding
>>>> the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
>>>> not same, the avc binding relationship between them will no longer be
>>>> needed, so it is issue for the avc binding relationship still existing
>>>> between them.
>>>>
>>>> This patch will remove the avc binding relationship between vma and the
>>>> non-CoWed folio's anon_vma, which each has their own independent
>>>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>>>
>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>
>>> NACK (until fixed). This is broken (see below).
>>>
>> Hi Lorenzo Stoakes,
>>
>> Thank you for your comments.
>>> I'm not seeing any numbers to back anything up here as to why we want to
>>> make changes to this incredibly sensitive code?
>> I added a debug trace log (as follows) in wp_page_copy() and observed
>> that a large number of these orphan avc-objects still exist. I believe
>> this will have a certain redundant overhead impact on anonymous folios'
>> rmap avcs, so I want to remove it, which is also the most essential
>> value of this patch.
> 
> Sorry nack to that idea unless you can provide actual _data_ to demonstrate
> an overhead.

Agreed.

-- 
Cheers,

David / dhildenb


