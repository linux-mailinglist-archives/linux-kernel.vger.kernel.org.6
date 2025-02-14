Return-Path: <linux-kernel+bounces-515796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C525BA3692C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3537D7A28E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8821FDA79;
	Fri, 14 Feb 2025 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9Mjj4jI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DAF1DDC2A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576717; cv=none; b=dfq3oob/cUYf573Nv6vRvUuXvIWkpdzfEZZiZGLdg2o8l3mmMGptGxLiLoQuKON3k5ld/4kWmCOUBO1C80D8I1FJPhjtFVEn759kSM+tLwdsDvKxo2H457SWl3GO+o1lnG2QRNGocLYWsMwajOuk/Tu07MxLLlAur91Ssq4u8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576717; c=relaxed/simple;
	bh=DmpspbnN5UVFV+fyRKgwWbVCdOKcq8m+T8J7GWLtxRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4q432XbovMpD2Ay1df3Bcp5qMBet8qKHJDtJOMLWFQKNFH6ZU5LKUAJh7YTmDwSsbY7wINzlhIDD9BG3tOKqOFSwpanZuoZv2g7rgt9lGjxnkgn5tC/JHCBCqEI1Qs13o7O2HxMLPXIRU6d43I41B5hkW1Eb+kIew/XStEM4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9Mjj4jI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739576713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uueQUErYPXOogibQt2DkpBHVR/rr0cRQbTOjQ83kAU=;
	b=Y9Mjj4jIPBq++RiPuZAgAsY+qHG+OYzWOJcx8/wLWGmiaQwu6bEuidUZfAby/Y9AvU9VrZ
	wYdjUGAKoIq6l3EGohqud7jNsBVWxS1ctiJh70rRorL+xnDOef3pLa78s3vzblv1kzcUEq
	r6mX2cMOhKzB3Gm5+ZYbHh83FCOzUwU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-_P0ahnezMmmt0LBAWqe_rg-1; Fri, 14 Feb 2025 18:45:12 -0500
X-MC-Unique: _P0ahnezMmmt0LBAWqe_rg-1
X-Mimecast-MFC-AGG-ID: _P0ahnezMmmt0LBAWqe_rg_1739576711
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220fff23644so13410785ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739576711; x=1740181511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uueQUErYPXOogibQt2DkpBHVR/rr0cRQbTOjQ83kAU=;
        b=UR5SNeLEYGduNzPANMOTC9DrgLqu3n2cCeDllE7l374k7E+3czv2McLHRubqlHGOe3
         fq7oCPNZub+mDDJJ2lEYOvm8M2esA1rhemex+X1AA4X/BAp9fUnAR0N46OS45Xne6FMb
         S2n51SLXWGjAHAwgv/WfXr0akYAKqPR+B/jzQ0bvKcPAWRgYFwsirtVQnNJNnStekO62
         3dr5RJF63mqoqqeQXmvDsN3NN+tTtdj3kIIOwWR6kyCGzZRZiQTH9LpB+Nw32tARQ5Ko
         SXGcvjUZ5can4N7o0XWXuSLwXGV2aMHK/x/9g39ddgtYAIAQEmHQaeEH/pevZeHsxjUH
         Uh/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWp3pg11ZclojPu2IXOEw7VgY+PdiUBnPgiK4tO+FgWC9S9clB5oYuMWpzhH9ylo+VnDNlv/mMefQTCnog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxFDcG4Mt6r4lk5Fn5dwyTtrm0GdOAv5ynBtkCDd8BY3MH4KJ8
	rj+7EaNOzQzP7D5PGhmHdMSI5OwpCH8ZIbhriEkMTvOyVrT9AfJu5aYmI7pj0cc0Bc/czOvg8Y0
	oLkRCJZlYTt7/yViFyJ2BIu09eEs++omFTAzoG0tvxxTh9yIpl8Gt0w8NdYb0Gw==
X-Gm-Gg: ASbGncvFPmv4bNqhKacZqaUTQLIR9UfhO75EAhfdP+yQARFRlKioD7RObvdglJz6Bji
	vixIjamRGzH8wZbpfPm/WIqpnEOOC1UaI1VXrh+u5tt0v2k/18KdCfoKuWjEGA5BGDCl1FprSME
	puQXXWWidKNb9ebyE1sErMiuDs4/llUVJGvOc1sa8Wj4pltm7u+QlqK4LRPpmRD0NiYTIdMn5Hb
	N+zSwbTQpC5qPTa+THDpFAyIzwIO4A6WtuTjKFgXyVUWEGji861QIoSwSgWE3ryWegDp7cMzD6f
	HIvqdA==
X-Received: by 2002:a17:903:1cc:b0:220:d81d:f521 with SMTP id d9443c01a7336-221040c2513mr17359155ad.51.1739576711359;
        Fri, 14 Feb 2025 15:45:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1/UBEwliKz41Ij24ofXhRsnSPElyjOlGb6aP2vhhmo5j5L3SZcrvye5FgNNOK2T5S+zGO1g==
X-Received: by 2002:a17:903:1cc:b0:220:d81d:f521 with SMTP id d9443c01a7336-221040c2513mr17358795ad.51.1739576711018;
        Fri, 14 Feb 2025 15:45:11 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13b913easm3576649a91.39.2025.02.14.15.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 15:45:10 -0800 (PST)
Message-ID: <a33fcf3f-0694-427a-b10c-e99a50d36e02@redhat.com>
Date: Sat, 15 Feb 2025 09:45:05 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/base/memory: Simplify add_boot_memory_block()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
 osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org
References: <20250214063504.617906-1-gshan@redhat.com>
 <20250214063504.617906-2-gshan@redhat.com>
 <20250214145725.708746506f5937acc96783be@linux-foundation.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250214145725.708746506f5937acc96783be@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/25 8:57 AM, Andrew Morton wrote:
> On Fri, 14 Feb 2025 16:35:03 +1000 Gavin Shan <gshan@redhat.com> wrote:
> 
>> It's unnecessary to keep the variable @section_count in the function
>> because the device for the specific memory block will be added if
>> any of its memory section is present. The variable @section_count
>> records the number of present memory sections in the specific memory
>> block, which isn't needed.
>>
>> Simplify the function by dropping the variable @section_count. No
>> functional change intended.
>>
>> ...
>>
>>   static int __init add_boot_memory_block(unsigned long base_section_nr)
>>   {
>> -	int section_count = 0;
>>   	unsigned long nr;
>>   
>>   	for (nr = base_section_nr; nr < base_section_nr + sections_per_block;
> 
> mm/sparse.c has a for_each_present_section_nr() - is that usable here?
> 

It should be fine to use it. I will add one preparatory patch to expose
for_each_present_section_nr(). With it, the nested if statements can also
be avoided, Something like below.

         for_each_present_section_nr(base_section_nr - 1, nr) {
		if (nr >= base_section_nr + sections_per_block)
			break;

		return add_memory_block(memory_block_id(nr), MEM_ONLINE, NULL, NULL);
         }

	return 0;

>> -	     nr++)
>> -		if (present_section_nr(nr))
>> -			section_count++;
>> +	     nr++) {
>> +		if (present_section_nr(nr)) {
>> +			return add_memory_block(memory_block_id(base_section_nr),
>> +						MEM_ONLINE, NULL, NULL);
>> +		}
>> +	}
>>

Thanks,
Gavin


