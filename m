Return-Path: <linux-kernel+bounces-514539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B81FA35840
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757653AAE72
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF4321CA13;
	Fri, 14 Feb 2025 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJ4T87nm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162921B1A3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519697; cv=none; b=M33Yqb0jylWVeWLL6Y3LubBgVUgDvS0h0yeB8f2N3u9ASjfInVfdfOnyXQAvsRKsr6xM5vMXI2jyrxP2SP2tc3EcPHbvOdd/NumsJMk1OVEujS0hHROi0ZBZebwgID6wKJcLZgkHlLLITQGsQ/cU7FuYN3YPZeMpwueOEWpJZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519697; c=relaxed/simple;
	bh=02mkrvmyAIMO1ihRFnFAVKPJObR4kcETHtbMPh2qeCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdEOfS2nqPcYwkeiKixomVX7B55xfdr6/LTU4w9yo1SGgJvM7xBacL6hE69FH5Ij9nTvPt2lkgmPjlzC/fBdNdbG3V+dFJBpdwS62erAksiGBMLcL5KqwzmJsSjlnUxvzF0TsLBTNgRRwDtQ5nv9aW38vEvbxNqUfxSWFq8jEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJ4T87nm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739519694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OARAhs+wQnmqjNErYQqOOm/3zAOTImpPywVA6YJL0K0=;
	b=XJ4T87nmhflyS1/wDcTYzDIvLdVzmGdPYqUcZ1To5MslsGbknmv0uPNSGoI0AzCUAV/vxH
	AxfrUd/jIkaiYJ8R79R0Hsm/oDX8DrAR/Jy0GRHqvAEdygyOkYxgpXg0kbOo1XFposaav2
	d9cO6bBDfi9kPP3xKyLo+Bmhl/FI9oQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-JIOBS03KOS6ni6WlWrcsbg-1; Fri, 14 Feb 2025 02:54:53 -0500
X-MC-Unique: JIOBS03KOS6ni6WlWrcsbg-1
X-Mimecast-MFC-AGG-ID: JIOBS03KOS6ni6WlWrcsbg_1739519692
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4395ff90167so9559995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739519692; x=1740124492;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OARAhs+wQnmqjNErYQqOOm/3zAOTImpPywVA6YJL0K0=;
        b=kdvmJUn4N5xIKCACoMYYATytg+G+lCBvNaPOrprj3VSORv8+t7I45aXQCWaQdOXzBy
         MvyhgZyK1R2uJKwBx4PbO14XMjt1Oy3PIx5EEYY5CtverJAOxlGPMEgWe6WTDc1oc67o
         qezObkP5IfQB0MaS0ax1nyoUohdBLbbjssUu1vSBOLrEkc2ISacOQzWOwnCAFaWOVEgo
         W7w71RX0d+4t+bzLip8O2UaAaN7Q9KIXpQg4P+Otpgoxs1WluEiLO70YEYDd0isxsLLz
         KVhOS62RlROjLQLm81uYeRYViiyP2+WYwr90kaT3yxlx3ZOyPVBViJ7JmkYGvBWjylig
         8HvQ==
X-Gm-Message-State: AOJu0Yw1izPbEI757kXxJRnXeXKprmiEShciskRDbktLK3DcHMNG+v+N
	8Qhfss3nfRzsnSfA+xWoBG69pQamvA+m63R8RLgoLDdOk9WbDbwZEgd0FBa8XhoXkU2268ZcGKH
	OqLSR75cD+SgvDkP6OvfLhB8cB7ytWKVaU6udzHyhds112idYVgeHoPJVAKc9uw==
X-Gm-Gg: ASbGnctATKsLMywOv2YZ+r2hBKNIwV2xGke676UynsmqpsO1XUmzFYY2UAQjpGn+hKj
	bBcpLJBnEVo2JUYY1OYu8XYKnh5DtZcsYAVfaBr/5w8NuAOLabkXLGeYz0tb74zKh5bv/tlyc7H
	VeS0hMz8UPoTpmXomD3TuFk1wiponCAqsIo4InsbLkPunO5gSzq7f4ddWSI1CBCychk913YCrmv
	6zR4O9ceVATaQtL3eO56Z+qH2NGRDL7zqHBS77v36uJzCdnYFkKNy1J38z+sT6dlvVGoJkQCsod
	avQRql4ObnoknxFI2sZrZWv5OleWROFXECInKCwOI02Kpyw2Rx3T+rjkbUQ5kpuAnUDC+7/ZsK0
	iYGb0P3D/EtqbT5HzPyCOAOpduO4qVQ==
X-Received: by 2002:a05:600c:4ecd:b0:439:6ace:4b1b with SMTP id 5b1f17b1804b1-4396acea03fmr1496835e9.29.1739519691897;
        Thu, 13 Feb 2025 23:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY+bCpnVtmmMD/2BKJCq3Xa5/SSdBTrWDm0VodmyaWkVrxNO2grzhqao7AoDLEamDM4oXkgQ==
X-Received: by 2002:a05:600c:4ecd:b0:439:6ace:4b1b with SMTP id 5b1f17b1804b1-4396acea03fmr1496555e9.29.1739519691510;
        Thu, 13 Feb 2025 23:54:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:a00:7d7d:3665:5fe4:7127? (p200300cbc7090a007d7d36655fe47127.dip0.t-ipconnect.de. [2003:cb:c709:a00:7d7d:3665:5fe4:7127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f22fsm68164395e9.5.2025.02.13.23.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:54:50 -0800 (PST)
Message-ID: <4df20b47-bf32-4772-8c71-2d7d46f370e5@redhat.com>
Date: Fri, 14 Feb 2025 08:54:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers/base/memory: Correct the field name in the
 header
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 akpm@linux-foundation.org
References: <20250214063504.617906-1-gshan@redhat.com>
 <20250214063504.617906-3-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250214063504.617906-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.02.25 07:35, Gavin Shan wrote:
> Replace @blocks with @memory_blocks to match with the definition
> of struct memory_group.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   include/linux/memory.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index c0afee5d126e..12daa6ec7d09 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -25,7 +25,7 @@
>   /**
>    * struct memory_group - a logical group of memory blocks
>    * @nid: The node id for all memory blocks inside the memory group.
> - * @blocks: List of all memory blocks belonging to this memory group.
> + * @memory_blocks: List of all memory blocks belonging to this memory group.
>    * @present_kernel_pages: Present (online) memory outside ZONE_MOVABLE of this
>    *			  memory group.
>    * @present_movable_pages: Present (online) memory in ZONE_MOVABLE of this

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


