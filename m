Return-Path: <linux-kernel+bounces-337173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FE698464B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19E41C22CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88F71A7059;
	Tue, 24 Sep 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2+pyMWp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C03FE55
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182710; cv=none; b=OANPSgraxwLDq3PslDS/DCV7ygvG9cifjw04+ht3e9AmCTsR86nXbn1+GoSYoVEgGyroHDaRdNUPnvuS7dKbOqE+AoiOysnrsjvnzWh6P/ZZZxQjeyXKr2YOq4/c0QGplmsbJ9ML0jhDGG7ZRcx0YmrqUBcITrFowkk0t/PTZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182710; c=relaxed/simple;
	bh=EKEorE8R3jH2Z1DLrd7yr/ooZ5B1dCh5WEWxtctJUZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHK+8MmOK9INodhcQa2inS9Yt2jpEeWhG+iUiDcmHYZtnI2TMXH6SyDnGN9MQ0GGfqWYEd1va+zXXQVlfBMO409MG+KIdpTXSekPOj8pYjg/37nFW/9mISg9oVy5ryRpvDGJUrHkfQsYNDLHQ+zT7dZxpEsn8KOCx4qolwD6jlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2+pyMWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727182707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xC9UCBhzwUAOQFao/KUDqH/apeuIr1frJEI+ucMu8PU=;
	b=A2+pyMWp53rwRrHaUXcDuRhhEwA0RW0RZu3SFQ+VJ1fIngHNZeNW0R8CTbt3EtAkPNP2BX
	ilQrwQpoMRZPfEgTpgOucV+f/Pjvf12hWQPZNfFXZJVcitfw2f188u52kXds+4QwEgWfw2
	Awy4LunyxfLIRetVoc8XqIodKRP66ms=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-TwWijEfmNZOkhFmYeIAEDA-1; Tue, 24 Sep 2024 08:58:26 -0400
X-MC-Unique: TwWijEfmNZOkhFmYeIAEDA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42caca7215dso36790675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182705; x=1727787505;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xC9UCBhzwUAOQFao/KUDqH/apeuIr1frJEI+ucMu8PU=;
        b=ddMaLtPtvcydn4GgOR0p3Ld+VoXrxsV/yla0Ir5K+GwZKgRnAQxgbaFdTxkbzHcoZ6
         RoOSSsp4OUX4MqvhLQHMulUZpMdIknfOcdpig7USXni8rP4UA9qo+QAJz5W5y1gsl22L
         P6iaZTXHGdtj3KlGi/nvXKmINiun+cdP1dxHjwY2gatjxBp97COOJgl2vUarr3sN7f/j
         VyRw7wTRV1aLfvRDM7vhQfpsRi7Zor2Mspuz/xX0Y69tsq8ZHK/fWLhD/24m6usGBA9y
         ckGy7U9A3EhH1XDqFB/3FSxBLApREWYc/wkeP/v1iz0C7gyP7cSYs/Mx1/pSE+xQBu6q
         w/uA==
X-Gm-Message-State: AOJu0Yxpq2s0Cvz7s9Fonvy/cfz38eq1Co+T9FKicNB456CFFG0Us5KB
	jCxJK9hIS75E1AuZXheMr7lXZxEJtGHognOpVY688hCC41ATLZy5TipMPycBBYsYWTJCTe5vv3I
	05hljg27uPPm6EMspMXzNrYsfkb4wfpL8VV/lKmmtcdGnTzRDeKb0Pj8x9drj4g==
X-Received: by 2002:a05:600c:4f55:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-42e7c193efbmr109030435e9.26.1727182704969;
        Tue, 24 Sep 2024 05:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI4EF96B1PEOenADb7Illije/hnjtwV8J24MIjfh4CgMke7FEiL5+zsiMwccSuAGfVWsgegw==
X-Received: by 2002:a05:600c:4f55:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-42e7c193efbmr109030165e9.26.1727182704575;
        Tue, 24 Sep 2024 05:58:24 -0700 (PDT)
Received: from [10.202.151.204] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a6f82sm158012075e9.37.2024.09.24.05.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 05:58:24 -0700 (PDT)
Message-ID: <4f9dffe7-a652-4476-ae18-15997085e5b4@redhat.com>
Date: Tue, 24 Sep 2024 14:58:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] mm: pgtable: introduce
 pte_offset_map_{ro|rw}_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
 <1a4fea06f8cada72553a8d8992a92e9c09f2c9d4.1727148662.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1a4fea06f8cada72553a8d8992a92e9c09f2c9d4.1727148662.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.24 08:09, Qi Zheng wrote:
> Currently, the usage of pte_offset_map_nolock() can be divided into the
> following two cases:
> 
> 1) After acquiring PTL, only read-only operations are performed on the PTE
>     page. In this case, the RCU lock in pte_offset_map_nolock() will ensure
>     that the PTE page will not be freed, and there is no need to worry
>     about whether the pmd entry is modified.
> 
> 2) After acquiring PTL, the pte or pmd entries may be modified. At this
>     time, we need to ensure that the pmd entry has not been modified
>     concurrently.
> 
> To more clearing distinguish between these two cases, this commit
> introduces two new helper functions to replace pte_offset_map_nolock().
> For 1), just rename it to pte_offset_map_ro_nolock(). For 2), in addition
> to changing the name to pte_offset_map_rw_nolock(), it also outputs the
> pmdval when successful. It is applicable for may-write cases where any
> modification operations to the page table may happen after the
> corresponding spinlock is held afterwards. But the users should make sure
> the page table is stable like checking pte_same() or checking pmd_same()
> by using the output pmdval before performing the write operations.
> 
> Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
> will be read-only/read-write protected.
> 
> Subsequent commits will convert pte_offset_map_nolock() into the above
> two functions one by one, and finally completely delete it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


