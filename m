Return-Path: <linux-kernel+bounces-385474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489CC9B379A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB621F23057
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690181DF254;
	Mon, 28 Oct 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyJQ1bte"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2BC1DD533
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136406; cv=none; b=ubFJTy/xAaN+w6GTanFtwLz/fTI4RMonHlPC86JPe+YZhPVVf549iZ0dbbsniM5P97p+qBEQKJKXJY6z/wJqc0nKSKyQeK1iXLC1zXmFZ6LVN9PTKKw9n6omYANiZyEnnGqQmVeg2yrtcvHrL3PzluUxUcnnCu6kyuo386vlo4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136406; c=relaxed/simple;
	bh=iAVY34FBZgrgDnkrhxmBrx4/gGYpqtHQkoJXg67SYGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5PAuDNdf9o7fi5PSjKuqzwxl9+SdtCScry9BsoJGc1Z9oTi6hK71vTjVNOB4VJiv8AuOuDs+peYr6ajNRaeR49BDuMHeq5IKhZb0opppxb0DibGeLRR0+OxipVk2Hwj6Rotx97MKSBtNcyzM/3i8UK6eXmzgSVizUcrWfkAync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyJQ1bte; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730136403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9UdB2rePe9j8NgmiBvbEzEGN/wd2cHKxjDUNBVkCuIY=;
	b=dyJQ1bteGxdnMQ6rfeEqESoVgUV7yOkPfwII93KJ0+kKn0PAc+3WfaJPAtQBb30Ms/kiCQ
	7O/9QWTedNbdOlDlxTHC/3/9z1fnQVUyXQybt0FIp6nFBh2x0lnfqQ3yG+MMZZ1xVypDYa
	JkwIvzU9SrEbmzp50V7PmFeN/N9xXBg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-7AQFftyFPD-djsZBflYQKA-1; Mon, 28 Oct 2024 13:26:41 -0400
X-MC-Unique: 7AQFftyFPD-djsZBflYQKA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539e294566dso3492188e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136400; x=1730741200;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9UdB2rePe9j8NgmiBvbEzEGN/wd2cHKxjDUNBVkCuIY=;
        b=tbi84H4wYKFBrN6SS1AOCuaAVn02QtAo9053a1uylCHZCcA6eiDqsgMA1tr0nxSPNX
         N2KiatXn3b2+Ln/nv/9helBgT01RYa8ucCN3/RVIk9EIGs+xidmDRVVqEYXP4QDfHLLe
         HFOkYNTaXICgdC3a+Cz/AX2m8Eb1audZ3HUHxSWOfYW7h4styr3kyR1NSST9tIAHk9Fq
         lXfe7WYCJJFPANxANodU3dV87kOQFRbiTZiLJoAf/PUohJBZPj2Vunjo/AaLoCNOE5B9
         guGui4LxKpEx0f8GTRpMDX/Rfc6Y5M9SDCqCoYLTXdN5tXxFNSxzPUV2dpFaMm+EtWdh
         qMBw==
X-Forwarded-Encrypted: i=1; AJvYcCWyNQLu7a12Ym05qK0bI9+E96bKMNlAzgoQGhjt6N7NLlytrQ0vTEBITEf+vMhOQh/eggIY6Su+Lt9AKdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DXMmFhHpSBVH3SO/NcOdrADD2Tw/wN/7L+WU8OvLQ/36hH0/
	PGGWHa2lS/VN+Ce5IAP6Tebc+hYaOuqbG7hlgP1motm/+c+4mt0TvYZKkmdFzKKvhcvAESx4tJk
	XF9coM4uwhm/8gGCrSm8P8USMnauXdVOPV3+lG8zgtjcekwfpy/q92Rr8Lrjcxw==
X-Received: by 2002:a05:6512:b02:b0:539:9720:99d4 with SMTP id 2adb3069b0e04-53b348d7013mr4511333e87.28.1730136400278;
        Mon, 28 Oct 2024 10:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Gw3rOIQM579xou8kP4HxdK21C7Lo6mDQjFGb967ZJXzwgz92d2vXILeNtEnTGi2poFBlkA==
X-Received: by 2002:a05:6512:b02:b0:539:9720:99d4 with SMTP id 2adb3069b0e04-53b348d7013mr4511310e87.28.1730136399815;
        Mon, 28 Oct 2024 10:26:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c722:3c00:70fc:90a8:2c65:79b4? (p200300cbc7223c0070fc90a82c6579b4.dip0.t-ipconnect.de. [2003:cb:c722:3c00:70fc:90a8:2c65:79b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47946sm10112152f8f.47.2024.10.28.10.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:26:38 -0700 (PDT)
Message-ID: <aa16f931-8244-4afe-a744-fa52c0b2fdee@redhat.com>
Date: Mon, 28 Oct 2024 18:26:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix v2 2/2] mm/thp: fix deferred split unqueue naming
 and locking
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
 <8dc111ae-f6db-2da7-b25c-7a20b1effe3b@google.com>
 <154430c4-7b17-443f-8628-ef3bb7738ae9@redhat.com>
 <c47c355f-fc2a-d8f4-4c8d-4a7a1468f0b2@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c47c355f-fc2a-d8f4-4c8d-4a7a1468f0b2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> https://lkml.kernel.org/r/20241025012304.2473312-3-shakeel.butt@linux.dev
>>
>> So I wonder ... as a quick fix should we simply handle it like the code
>> further down where we refuse PTE-mapped large folios completely?
> 
> (I went through the same anxiety attack as you did, wondering what
> happens to the large-but-not-PMD-large folios: then noticed it's safe
> as you did.  The v1 commit message had a paragraph pondering whether
> the deprecated code will need a patch to extend it for the new feature:
> but once Shakeel posted the ripout, I ripped out that paragraph -
> no longer any need for an answer.)

Ah, missed that.

> 
>>
>> "ignore such a partial THP and keep it in original memcg"
>>
>> ...
>>
>> and simply skip this folio similarly? I mean, it's a corner case either way.
> 
> I certainly considered that option: it's known to give up like that
> for many reasons.  But my thinking (in the commit message) was "Not ideal,
> but moving charge has been requested, and khugepaged should repair the THP
> later" - if someone is still using move_charge_at_immigrate, I thought
> this change would generate fewer surprises - that huge charge likely
> to be moved as it used to be.

Fair enough, I'd have kept it simpler for this almost-dead code :)

Looks good to me, thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


