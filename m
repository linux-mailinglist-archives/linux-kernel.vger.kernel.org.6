Return-Path: <linux-kernel+bounces-344811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3F298AE79
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438961C2247F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBDE199EB0;
	Mon, 30 Sep 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLC6t//0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6B17BEB7
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728567; cv=none; b=czSwy5IthgnzHy3Tmi91PT/wu6d6s30cLZjc0uA6EcjffCahFpsIYZcCH3CEikFG5nBH5EwHm7IaRfHGQR2Hg3cJRHRw5Y8XDcpYXVhM/iYPgZ6MKwOcwMGSiQR2rks3vGB0F88YWWiibvFzxEw1zxENNAGTOgF6C6AW2zINWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728567; c=relaxed/simple;
	bh=kwMQv++wS4/zjkDhjMwF7Ge76niivNs6WB8YTzJmx+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+KJvv7AlWk5dWeJuEymUgrV7za+5T8sA0B//qLuDCr9dX6G+TpwgrJAB5uRPeSn/4BRvMnFpP2oeBC8YPhQ5V4MYNV4xKqpq/5+qKiuT9DmAV8bcR9bYNTszB1TSpQaHlO0saKI2VddNgl4s0yi/AYGA/13GW4nwVcYB91Iync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLC6t//0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727728563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2FibqoMV4KH2b/O0uu8pexBB0roEdkUJjQp/7wKoxLo=;
	b=RLC6t//0DOJV3REEtLos4hAm16AOngvS4dLxNrdE9ncBAls8Any0Gp4TzzAORhFoAkXglI
	EQ4xg6UVycFCCAf31RHk2Ih1GNeNwCIy8BN+PTHUk/yenpqneGcQotKzikzG8sUth+8tXM
	+F4fpnl8GdeW4PKg93CIyFCbsMmsIKY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-Q6Ndw0zDNpeFyiwHs9KwDg-1; Mon, 30 Sep 2024 16:36:02 -0400
X-MC-Unique: Q6Ndw0zDNpeFyiwHs9KwDg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8bso29473635e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728561; x=1728333361;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FibqoMV4KH2b/O0uu8pexBB0roEdkUJjQp/7wKoxLo=;
        b=NxNxlfiHg2vs8tlQBJ0Li9Sj5JqHKEoNzon5BOb+GTtIK5dY0uVPxMF6XWCMWAJ5ZA
         1UWwJOt//MVS84aWLkYtyB+cfVeUwst9//YGPQEf2/88B+qjq2prp8JW4MHI3wUqjBtA
         S6nKKGIB3s86PdvWsNJxb3Dajk3hH3nJjHjaDGMr8qCwNxdw30xlWghwtf/c6pbIz977
         HQemkaMoYyLNq22it2WAw6E+GN1B9gM7E27HzIuSf45BtcdDojfybxlifE6BBVOoaQtM
         4b2IuvC1D1AgICRmy190bwLNVcKwlqfAseUrIdQlkN22swrVE+DdoCdzDlDAMGpgFjJX
         wuFg==
X-Gm-Message-State: AOJu0Yw3CuI8zkATe/cZMrZona2RTCb6QihJPn84MQhKqHL/66RmfSEO
	TaanA3/gpWbEW6EzkM7jVVwL4EQQ4Osz0GlNigiQnF57GzCP8Xx2R/86xq7CXkgWUQ4L5fP7b+C
	LKXQzLu4vKY9sdU3xKagOJufqgrsqwFkL79oHpi7TEDthvo20vud37dsYUFt9NNio1BjimxGxPz
	vZSa6hNINH9WoJxjNnGtnFb8DjUg0Hfx05W0FClvQKXmnw
X-Received: by 2002:a05:600c:1ca4:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-42f5840a012mr88611075e9.6.1727728561208;
        Mon, 30 Sep 2024 13:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPc+wSmQqWjRkxJNcd6MsSlLcAH2jAo0oLYZSzKF4LPXn4jvh6QuxjN5NfiJWHauRcOPvB6g==
X-Received: by 2002:a05:600c:1ca4:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-42f5840a012mr88610935e9.6.1727728560689;
        Mon, 30 Sep 2024 13:36:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:9900:adb1:b447:d06e:820a? (p200300cbc7299900adb1b447d06e820a.dip0.t-ipconnect.de. [2003:cb:c729:9900:adb1:b447:d06e:820a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a56fd1sm160146565e9.48.2024.09.30.13.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:36:00 -0700 (PDT)
Message-ID: <db84157d-94bc-4334-9d2d-a7e43cbc0208@redhat.com>
Date: Mon, 30 Sep 2024 22:35:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: check pmd_special() only after
 pmd_present()
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
 syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com,
 Peter Xu <peterx@redhat.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20240926154234.2247217-1-david@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240926154234.2247217-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.24 17:42, David Hildenbrand wrote:
> We should only check for pmd_special() after we made sure that we
> have a present PMD. For example, if we have a migration PMD,
> pmd_special() might indicate that we have a special PMD although we
> really don't.
> 
> This fixes confusing migration entries as PFN mappings, and not
> doing what we are supposed to do in the "is_swap_pmd()" case further
> down in the function -- including messing up COW, page table handling
> and accounting.
> 
> Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/66f15c8d.050a0220.c23dd.000f.GAE@google.com/
> Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> I yet have to do more testing, but sending this out already.

Testing looks good. Andrew please queue this, it's a rather unpleasent 
behavior if we fork() with a PMD migration entry that should be fixed 
upstream soonish :)

(no idea how I could have missed CCing Andrew once more)

-- 
Cheers,

David / dhildenb


