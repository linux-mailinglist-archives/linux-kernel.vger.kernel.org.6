Return-Path: <linux-kernel+bounces-440238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FC99EBA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D595A163C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131FF226877;
	Tue, 10 Dec 2024 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGrYPiMl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EE22689B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861127; cv=none; b=ar+nwNviZw1RM0uPeDN24Bxt+AEMayCK+eOLcoIyF4KwXGCVqe2nqqgXet1Bq/4y4COkAE0GdmuWXIC6oz35WVayDsKhEcX+iNXvI8UMA9oRJn9bNgM/2B1kRpuTKgOmTdYtMaiAxGTUDuwWBoxe5E36ZO0nUGyRKCUGOpDHB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861127; c=relaxed/simple;
	bh=TTy+cnTsnryXvEPFzasG+65YEXrbE+iRWaJPGjE0KI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kpis9bRD/+6D55IK+cpedKBTdE2sXvhMMjHlveJmvCfJLVuqpCqQhLuVjOGjzz8TiAHfiJBrntzy1HQ5KJw/yRdXPRjyf2sSnQ6KjsAfLGfp2FW/rQBQWX2xNzBy4LMudKTtDguYbE9F1+hwNRIlYWQ59e7k52gGUBHlv8GKlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGrYPiMl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733861124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pFFkZ3VZlfueixmWZNduueBtyjekkzH41Zaa8QErBac=;
	b=RGrYPiMlZSdVD6vkgoqb3v4wy2o/4wNGwlEur+cfS//BhG4RsYSqA0Pc19PCiphG2PJ42F
	lvMDJ5sLgr0ccQ9wfXWpvkY0bqkzvevPjiBHGJV9Qwjt8B0gbEYInaWdYvNyXwWllqPjL9
	KSY2hFdkq4gzfWzoZtPBsdJHGJ4eIko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-UFvbfo69OS-yMOBB4pFX6Q-1; Tue, 10 Dec 2024 15:05:23 -0500
X-MC-Unique: UFvbfo69OS-yMOBB4pFX6Q-1
X-Mimecast-MFC-AGG-ID: UFvbfo69OS-yMOBB4pFX6Q
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f3a758dbso25408875e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861122; x=1734465922;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pFFkZ3VZlfueixmWZNduueBtyjekkzH41Zaa8QErBac=;
        b=KGW/5BwsUJaUyVK1/7qnyLkDzI/9g5XM48WDivMXH5rJ9AaOoblrb9NX3Bgc/TtuZc
         OSF0W39Cuzks04ZM5/WHD6S9CM28r1wNcyQGqGT1BOfa6sG91409eatv5VGPp2x6bvCV
         mdsV2P3Ee0SYDGRBbkmniXgQV+U+csTlDg/4d1c9S9ZuoDXJ/P1NUBuUJ8400v+CLqT/
         VLhiEPTCHa36leeMGzg3om5PG0qmVZ0/tNB3WjLuJpW2PleEBTuS/PSgSbKllELeO7k4
         YW32HEj2A+ofS77Ga5/mI5LlfKeIxt6hmdp09jPbmgBLjjH4C2qdRiknjyazd6SKVr6D
         gb7Q==
X-Gm-Message-State: AOJu0YzcSJln5PXrm5TZM26m72T5OtNvgbLjRZihw8LrIdWABMCqyqqD
	TaVKtaaMzaeP2f8IGtTRiKMtmOIHmHUZM/+TLjkowml+bkKWcJRZsUU2qqyh4fjOgnfw8Qvx6NX
	f0LZBO4+XfWji/ptmS1LbuiH9kkqJhkcVnEVLDVna7+Be8PAJStAh8oyGRcL7Fw==
X-Gm-Gg: ASbGncsFbFNk5bBzolPZDxheW5rkpa7gdnOKY1/7eR87cCJR2TbTSLNx2XR+bLdZIWs
	CaHBZW6zGqbBEfEbxHY8E31yZvwuVlPmCSc3WaCrIjwheHbvI0df0x0akLwYvE9NfD8NwaNCDfM
	EZuif6TZh9fhe9WtOQMyEShJLmh9Rh/8jYMQU2qA6Kabwg2T+7dABuEMFM69+OfNQj6YsT3NvNF
	7fppg05u/DnGwUkjpqHSyhgq6mpSwcssBBcqABSEOQoRlCNPZAYpLWjqDpa+LWkb9TZNWR6jvcq
	zeZ3CuRvMHxgNJUOQ50bULLLCZCvv9wPunaVX9VdPUfywCQOdna1wh5eyuyuqFzi/9Zcu2C2QBY
	HWnTWMg==
X-Received: by 2002:a05:600c:1c01:b0:434:f0df:9fd with SMTP id 5b1f17b1804b1-4361c393cb6mr1305215e9.2.1733861121988;
        Tue, 10 Dec 2024 12:05:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQx54egW4eFig7gk+YqIDLvP0RDhsg4Pj/m/z5PX77rimnLqcdsYFQRaluVZJrVHVkvjnIvg==
X-Received: by 2002:a05:600c:1c01:b0:434:f0df:9fd with SMTP id 5b1f17b1804b1-4361c393cb6mr1305025e9.2.1733861121603;
        Tue, 10 Dec 2024 12:05:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3? (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f3d89b75sm101188805e9.15.2024.12.10.12.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 12:05:20 -0800 (PST)
Message-ID: <3a457ce5-3c5c-4165-996b-f5a46fcda194@redhat.com>
Date: Tue, 10 Dec 2024 21:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v4] ksm: add ksm involvement information for
 each process
To: Andrew Morton <akpm@linux-foundation.org>, xu.xin16@zte.com.cn
Cc: linux-kernel@vger.kernel.org, wang.yaxin@zte.com.cn, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20241203192633836RVHhkoK1Amnqjt84D4Ryd@zte.com.cn>
 <20241203165643.729e6c5fe58f59adc7ee098f@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241203165643.729e6c5fe58f59adc7ee098f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.12.24 01:56, Andrew Morton wrote:
> On Tue, 3 Dec 2024 19:26:33 +0800 (CST) <xu.xin16@zte.com.cn> wrote:
> 
>> From: xu xin <xu.xin16@zte.com.cn>
>>
>> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
>> KSM_mergeable and KSM_merge_any. It helps administrators to
>> better know the system's KSM behavior at process level.
> 
> It's hard for me to judge the usefulness of this.  Please tell us more:
> usage examples, what actions have been taken using this information, etc.

Seconded.

> 
>> KSM_mergeable: yes/no
>> 	whether any VMAs of the process'mm are currently applicable to KSM.
> 
> Could we simply display VM_MERGEABLE in /proc/<pid>/maps?

We indicate in /proc/<pid>/smaps "mg" for VM_MERGEABLE already.

The "nasty" thing about smaps is that it does all the page table walking 
to gather memory statistics, which can be rather expensive.

I was recently asking myself whether we should have a "cheaper" way to 
obtain such details about mappings. /proc/<pid>/maps is likely 
impossible to extend (similarly display flags) I suspect.



-- 
Cheers,

David / dhildenb


