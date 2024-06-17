Return-Path: <linux-kernel+bounces-218044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEA290B877
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E811F250D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9619409A;
	Mon, 17 Jun 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dS24VKWF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83210A2B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646698; cv=none; b=rCnnkQKK+KuTXHIZ0eBjq8jP2LRpBY5ajz375zuDPGgsjVauxer03tJKnVffOBwZBXZPbb9yn4w0DVm0dg5H+FO1oBGnf5bAdAqiZx872aNW6QimttD8uezJ19aTw1VZmhxK8SbPC6ms7Z8Mw9b5OFtPjWrG783yV64k7id4v1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646698; c=relaxed/simple;
	bh=05DKzXm7ufvNYjMNjhhavu6W7fJrGElPjR2YxQcqIwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1K/AkXqXRmu9wIfePMkTxkNnJNBRG6aJcmQiIKMKNj/2ZoPAxvhaA+AR5FDnev+x1m/A/PqoUp3zwVoid+YBOsknF4+trEdSDbcvXWMYvd8AudTAbxQ7tXb3q5dmYnpC3aF7W3O5eCyFKcTH/uugsLue1YL1kM3A6uI2cHbuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dS24VKWF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718646695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UNxZ0AHOB5x7G6gJUqvguXQHUKcvpr7QKbf1RuHG8ZM=;
	b=dS24VKWFzrvgjIZl5qVsfFiPaC9zEzTSw+rEoo/j5LWEN3NdsboT7kei6nj0yVgyl0xtWM
	ROMy5K2+IRl1Dl7kPadquln/1ylpAFhTisYGYjI1n9TCv0CUOcdGETTGOB1Ku7AKTwBEWk
	muXCo2dgo7/d9fWdvwntilXB0sUJKgA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-VGwjcKcrPgK4SDUMc9REuA-1; Mon, 17 Jun 2024 13:51:34 -0400
X-MC-Unique: VGwjcKcrPgK4SDUMc9REuA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f06558bc3so3135311f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718646693; x=1719251493;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UNxZ0AHOB5x7G6gJUqvguXQHUKcvpr7QKbf1RuHG8ZM=;
        b=LTwas/Ul5uPP2XoToDSgaIfWVEUCb/H3BJ7Wv6TP0i4mwRrs0ls8Il+8U7uJdMbUaN
         ytobgXsagB7QhOl5FJ51Cwz0lkfW+8AXrX1IVuc7IMgb+rK0zq7uSSfoYoqHwOWUvChg
         goeyDggwjIt2Siv/m8crY5cySIMx092UN7nxKHdBzfdcaSI441L44guLrm21zKobibVn
         fuq8GPJtGuVtezJjm1qmlSZ/caHuECkuDY2lR3b2TtvYeufTng9Rt8t2yP5r1KMzNKR8
         n0GFsM1nKsa0NGOiosiIt6jzCqv+TYwBAetUewz5gHN8gdDYfSMlqL3G/8Mf9YIIK7wl
         dSYA==
X-Forwarded-Encrypted: i=1; AJvYcCXJwSr9b5voBdGofEFagb6w4Cy4tT6YaZvyt25iiMww+jAsiufcM8LxgHMicdrKjb5FH8LZuWFLpnKeIoouDBfj8Bd+Tm8ZCrY7wkDH
X-Gm-Message-State: AOJu0YwFhPkRhBlDUwzjQee1L8VllGq1UXFTdnTMKOKBYFR1MCHwZ93s
	Gwqe4S+y2V13vjdcp9IRPC00yLUHWUdYfIa4SYCCM+G0zoW2EHaRGlu2sNihvJfwMenb53AuJWa
	vzgx8iGhTQ464RhigIzYv52RKUNPT4NaOVI4xALoJqipJDmkmGw37mtXOrE/j/w==
X-Received: by 2002:adf:efc9:0:b0:360:7277:e827 with SMTP id ffacd0b85a97d-3607a77af20mr6492742f8f.45.1718646693312;
        Mon, 17 Jun 2024 10:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFedNAp8cvOulKaXIRn4zohRYMTE4Lz/Tokc0vmwD9YEiho0CETYRC8xhv59MptPCzjIDORJA==
X-Received: by 2002:adf:efc9:0:b0:360:7277:e827 with SMTP id ffacd0b85a97d-3607a77af20mr6492730f8f.45.1718646692909;
        Mon, 17 Jun 2024 10:51:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:2200:95d8:cbf4:fffd:7f81? (p200300cbc740220095d8cbf4fffd7f81.dip0.t-ipconnect.de. [2003:cb:c740:2200:95d8:cbf4:fffd:7f81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f228asm12410582f8f.73.2024.06.17.10.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 10:51:32 -0700 (PDT)
Message-ID: <fbd652ad-2f3f-4fa7-9a4c-96e0876b6397@redhat.com>
Date: Mon, 17 Jun 2024 19:51:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
 <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
 <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
 <2cda0af6-8fde-4093-b615-7979744d6898@redhat.com>
 <aadae460-3797-4d10-a380-5d4fe8189e20@bytedance.com>
 <24480cd6-0a13-4534-8d64-4517e73f0070@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <24480cd6-0a13-4534-8d64-4517e73f0070@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.06.24 05:32, Qi Zheng wrote:
> Hi David,
> 
> How about starting with this:
> 
> a. for MADV_DONTNEED case, try synchronous reclaim as you said
> b. for MADV_FREE case, add a madvise(MADV_PT_RECLAIM) option to mark
>      this vma, then add its corresponding mm to a global list, and then
>      traverse the list and reclaim it when the memory is tight and enters
>      the system reclaim path.
> 
>      (If this option is for synchronous reclaim as you said, then the
>       user-mode program may need to start a thread to make a cyclic call.
>       I'm not sure if this usage makes sense. If so, I can also implement
>       such an option.)
> c. for s390 case you mentioned, maybe we can set a CONFIG_FREE_PT first,
>      and then s390 will not select this config until the problem is solved.

CONFIG_PT_RECLAIM or sth. like that, that would depend on 
CONFIG_ARCH_SUPPORTS_PT_RECLAIM.

Then we can start with what we know works and was tested (e.g., x86).

-- 
Cheers,

David / dhildenb


