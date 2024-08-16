Return-Path: <linux-kernel+bounces-289487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C49546AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223D71F2136C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B217C9BA;
	Fri, 16 Aug 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGEMQvfR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EFC157A41
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803687; cv=none; b=V/0DXXO0LwzW6EpGCiWH9hYBNXcxUKARHg7CVe1DTXP5VqSm9NsI0jOdl8//ZMhDOA7sMqrtz8tQ4qzM5Uz5MO9UABfQSjmOxY1lJb14jVLjcERffLem0025WxW4ogYlz/bgMwKBKGcuqHGHMQ1oz1rIfz+f6FA5rymUPW/llAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803687; c=relaxed/simple;
	bh=dZudbnW9De/vyRfT6hlGxKOJBL0eMeehzQII2AG09d8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=csB9WEtOWEpKSye1cko/9cx867XQqz2pD31ef7DQwf5W/dwwhmx0IXhsTT9GNgV569sUxPAzMAVwlFbI4rGbkZ5Kisvknu7Ps/xFdN8zgknpMAN+2C9CPDuE52NFo6vPiKvOZZivyvbGdxd7FHeg/A4z05VEQLmknLM47wyCi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGEMQvfR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723803683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dZeVJV1/flJkdL8JPpnGe9cmRQqqqzWPB1mzyyDgeQY=;
	b=YGEMQvfRXawjBDH8OrS+vxd7DdpuWeFp1A9rn6ZyRBIfOU1TIX1PoYMENRCjJnMkCuczHY
	VDScP/uFdERhOgfrpA4SQFE5lzJnAQ5aoVMqOOAbfThnZDmhBfUnzSSqsbkM/y5HTnEdFL
	7CB3onGIywSPhc5h8mv0zvg9EojPrgk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568--T8APgJZMXaV1mFfayUREg-1; Fri, 16 Aug 2024 06:21:22 -0400
X-MC-Unique: -T8APgJZMXaV1mFfayUREg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281f8994adso12926375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723803681; x=1724408481;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZeVJV1/flJkdL8JPpnGe9cmRQqqqzWPB1mzyyDgeQY=;
        b=vIXYtdVO9h3BuaZxj5fA4VE+sCYBX+4kUYTqtuR6g2F4yr6eoQVKhN5calvCZtX1zr
         BxsyZVH5pti47N++rvp81BVCBief+1rF1DmM2ulRqyD2t4E6ApzG6S179eohvQnyNITm
         h+rykOBrdfeTfwC/rVwVMfUPdtQxJr6/EDuDZWCPlKDqZortsRomJivzXRCdPrHNDakG
         jXRg8Ci2xz808wMpgRBEfvd50YnpzouVPemrNA4miXnUyN/vaYypwyEuoBZmyWM5TOcC
         3MnrBPmUF6iIEa97temwYJGTvuuNWqST21XM7QHqLB1oyW1HwFM74Qpbtf/0CoAHwjiZ
         WuYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW1iPeqRLvbyeSBQtY1RS+27/8riu/n1WudyU73IBjIBGfYgl+GdEZYsCO2Uu1wZXweugYBISHkDt1PviF6FnONY8lkLSx5vai9SOB
X-Gm-Message-State: AOJu0YwY11gtNz4yq0hZIV0VQBCLfy0n0BR5bMUMHSGHvmzXi7fZjewI
	Wqr3Fu4leL9VjFU0Rj9VZrqYV9bYNGTNAsDDKrNIZFNGWQqWytGXletCEOll/Qdu6em/liRwH85
	epvzmYMvNi0Qznl3fXCiUWAqpzPwe68fkl4XJHW145hHtfGVDwvmZLMxlK21VYw==
X-Received: by 2002:a05:600c:4688:b0:426:6ed5:fd5 with SMTP id 5b1f17b1804b1-429ed7a5f5dmr15838195e9.6.1723803680982;
        Fri, 16 Aug 2024 03:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbTEEr3Iw1qrDKn60q1vYiJxeQxy92dQpVFN6gDXWHFSHPqexbut7JBDu9FRkvgSyTEIRruQ==
X-Received: by 2002:a05:600c:4688:b0:426:6ed5:fd5 with SMTP id 5b1f17b1804b1-429ed7a5f5dmr15838005e9.6.1723803680427;
        Fri, 16 Aug 2024 03:21:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c721:b900:4f34:b2b7:739d:a650? (p200300cbc721b9004f34b2b7739da650.dip0.t-ipconnect.de. [2003:cb:c721:b900:4f34:b2b7:739d:a650])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7841a1sm18783995e9.29.2024.08.16.03.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 03:21:19 -0700 (PDT)
Message-ID: <905d6a3b-d0ac-4e5a-979b-40a49e345305@redhat.com>
Date: Fri, 16 Aug 2024 12:21:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
From: David Hildenbrand <david@redhat.com>
To: gaoxu <gaoxu2@honor.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Shaohua Li <shli@fb.com>,
 yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
 <883bf552-f339-474f-805b-4355ef49e526@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <883bf552-f339-474f-805b-4355ef49e526@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.24 12:19, David Hildenbrand wrote:
> On 16.08.24 09:48, gaoxu wrote:
>> Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_lazyfree_fn:
>> 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If it's
>>      moved to the LRU tail, it allows for faster release lazy-free folio and
>>      reduces the impact on file refault.
>> 2. When mglru is enabled, the lazy-free folio is reclaimabled and should be
>>      added using lru_gen_add_folio(lruvec, folio, true) instead of
>>      lru_gen_add_folio(lruvec, folio, false) for adding to gen.
>>
>> With the change in place, workingset_refault_file is reduced by 33% in the
>> continuous startup testing of the applications in the Android system.
>>
> 
> The patch subject does not match what you do in the patch -- at all.
> 
> "mm/swap: use lruvec_add_folio_tail() in lru_lazyfree()" ?

Ah, sorry, I read it too fast. Yours does make sense :)

(mm/swap might make sense, though)

-- 
Cheers,

David / dhildenb


