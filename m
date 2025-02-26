Return-Path: <linux-kernel+bounces-534302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F96A4653B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F6C1894E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC6621D591;
	Wed, 26 Feb 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="in2ltHiy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD521D585
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584374; cv=none; b=QEzZPkqeBHRgfBxiztJdwn6Qv5K+QSr63yU95jL/m3RiGeRksPtJsaAKUbm9PBC/qy19WSRkthZLJ9YbAypI62CRAsIHal+3y9xWTkNKsCEUcj1K6gLzXT6GCmNt+far8ZoFkU4XseS+HjIf9Q6ZS2Pu4torikrTmfAlF/6OteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584374; c=relaxed/simple;
	bh=kqO8ICVCs/g0H5zTi0fDdYONbsaDC6OQ13FHNmLQVDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tlu6UcpTd3nArP5NtcW0XcEpnV0qo8IAqLAp/qA2W1gJONgfkVScrpkswZOFKmxduu1yFNyBH9iER4fhMRDrYqX0dFt7shjIjWPMEWmT+wK2WDd3KoND/o4pWPErTh8R3y2Gt/DNZVtuEa8I8b74AoEnv5Pl/l+fhutKbKTaK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=in2ltHiy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740584372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IbCPFo4ukPMUk4ZCGzV7Llomohq6p/OUxLx79C9nwNc=;
	b=in2ltHiyzZL3lknaOztBjFHQybVoBtz5uXfP/aoS1cK9b6PE9PAhHijYE97AhwwtggqCwm
	41JVrLqu3nAQw2p7a5mQw1HOe9a4cwqaIxuU7kU9elStNwueGQ185BPTJPQ+UfJ4OLsMPh
	exLiwGC+l4eW5zxWelimDwuwDy0Znb0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-3nRJo7S8P8exVuhwk9o2oQ-1; Wed, 26 Feb 2025 10:39:30 -0500
X-MC-Unique: 3nRJo7S8P8exVuhwk9o2oQ-1
X-Mimecast-MFC-AGG-ID: 3nRJo7S8P8exVuhwk9o2oQ_1740584369
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so35274555e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584369; x=1741189169;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IbCPFo4ukPMUk4ZCGzV7Llomohq6p/OUxLx79C9nwNc=;
        b=bUHjGViAds+qvBKMTv1/t+hlzm+//lDLi/EO8FTcG2ShPnkFzDrAwlR6K7Xut6NU5s
         rw9csj+RoowbBDpJuWLEO4iBPisaFeGfKNdPRzQKB4+s/tEvTVatQuzpdVorH0MXoSn/
         RZlX73fTaqEY+/GLlsF8CvzZV6obibWX1ehDrP3v2/Pu0pK+w7tX+fpFfULQtWP2mfsv
         kHOZPhtylnYxOr5tcmJISXjHBSzTh7lbhxFVlSfTicfi2jkTN+r1PPuNrrK20T5nmwGu
         Ch8ot8Jk672MelXz9QgSQmsSobZ7AGn89KZERkgEGi9rr38XIsmsjCqkaxvMoKMMyyb8
         0voQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHXv4DBjJVbM+/dwEQ54CEA6wWfT2YSoDrEgldL+kijgXnSIX9vSUAT7ZrgY3i9S6GA/b0MRre1VBst/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44xJ7Ybg5fDpoI7IdzN7N6KMqHnXvDJQ0iQ3UDSrUXgukYD38
	94oJegvC4sjcJWbsxtUQg6IQK1C7aQ46Z9PsJpMX0gitrjAy7iFZScBybSCMfRdRCjM8pO5mzst
	ckRSbWNzXl/Jla0e6ECHMp1Q+2TNbWmQgR3z7SEsOYgaO24A1AeMCB6sGpgY7Cw==
X-Gm-Gg: ASbGnct1BsnTq3bbpRiECcnrwmFgMN9gDhc9ViapPtXks89+cEt/mAlRwqV+2FautC9
	oQfUhY/Fj7YrapubH35IIhow81xMkqUa10k60HehXegY56QAnDZb3SeLSjeypc4SuzGyEvniJNT
	MNy+bm9mdB+OeHY3Ye8ITgMUMu0nrkS8XQO4G6DEbHIDVxKnsg4nWw40iN6xxJdT//rXNT8DsFe
	39koACaX6Zw6Y8zmbWA0MxLRvoOenNdky2JS8yMMFAcCfeUpZ5IP6Q5FLyCHfn3tuMWkYY8Ss4m
	h0pYhQtGxCHYciFTtr8ydvs3D9XBKSMA9Y9KEwXl/WwHZPwnjPwLDMX0G/lWQNTGrfJLANCC33+
	5asOkXgTljcY/Sd06qVzzf+9YCwyyTzho1V57vT/OFjY=
X-Received: by 2002:a05:600c:1c1d:b0:439:9496:181c with SMTP id 5b1f17b1804b1-439aebdc9e1mr174249645e9.29.1740584369356;
        Wed, 26 Feb 2025 07:39:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ9rr83hpuWF3pq1XFAqgfUctJX1UIekAvCRlt8R0Q7Qa23qZ/5oV/Uf5f10GLP/kQVS86tg==
X-Received: by 2002:a05:600c:1c1d:b0:439:9496:181c with SMTP id 5b1f17b1804b1-439aebdc9e1mr174249455e9.29.1740584368988;
        Wed, 26 Feb 2025 07:39:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b7ecsm25549415e9.3.2025.02.26.07.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 07:39:28 -0800 (PST)
Message-ID: <2a4d6ef6-d7e5-46b9-a4ed-b7aad7a1c20d@redhat.com>
Date: Wed, 26 Feb 2025 16:39:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zswap: use ATOMIC_LONG_INIT to initialize
 zswap_stored_pages
To: Sun YangKai <sunk67188@gmail.com>, yosry.ahmed@linux.dev
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 "open list:ZSWAP COMPRESSED SWAP CACHING" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250226124141.22218-1-sunk67188@gmail.com>
 <20250226153253.19179-1-sunk67188@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250226153253.19179-1-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 16:32, Sun YangKai wrote:

Something for the future: if you send a v2, indicate that in the patch 
subject ("[PATCH v2]") and ideally, describe the change since v1 under 
the "---", and don't send it as reply to the original patch.


> This is currently the only atomic_long_t variable initialized by
> ATOMIC_INIT macro found in the kernel by using
> `grep -r atomic_long_t | grep ATOMIC_INIT`
> 
> This was introduced in 6e1fa555ec77, in which we modified

the correct way to reference to commits ids even in text is the format 
you use below.

But here it's sufficient to not be repetitive and simply say

"We changed the type of zswap_stored_pages to be an atomic_long_t, but 
didn't change the initialization."

Acked-by: David Hildenbrand <david@redhat.com>

> the type of zswap_stored_pages to atomic_long_t,
> but didn't change the initialization.
> 
> Fixes: 6e1fa555ec77 ("mm: zswap: modify zswap_stored_pages to be atomic_long_t")
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>   mm/zswap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index ac9d299e7d0c..23365e76a3ce 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -43,7 +43,7 @@
>   * statistics
>   **********************************/
>   /* The number of compressed pages currently stored in zswap */
> -atomic_long_t zswap_stored_pages = ATOMIC_INIT(0);
> +atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
>   
>   /*
>    * The statistics below are not protected from concurrent access for


-- 
Cheers,

David / dhildenb


