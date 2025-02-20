Return-Path: <linux-kernel+bounces-523145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E04A3D2A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5A3179255
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328731E9B07;
	Thu, 20 Feb 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFSBuC1F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCA1E7660
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038327; cv=none; b=l/7U9M5ldcJxN1CdINjFwUhGEOY0aQEFBE3+vYSmBeDX4zDuWhNPiY6FPQeb62faZAPLM+L7AwqMWzVMOENkPBT3Zw8PNtbup46U/Y7Rrt0ZubKRdLnpNq9A6ZSEeNAlXMKSZilSsDweQvIYjtYzxbWxQFj0uZ9529IdIgW2Jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038327; c=relaxed/simple;
	bh=PpJNYD2lhmYApKCUTFbnIB2Oz9xNpyPKhkXzhRQ1kRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UdvfF/Ot1WSzI8LgaKHFviR6uMTOgpFGoTX75uUC0BZFrlxireHsMpkngAGQV4Fb7Mx3C3d5uromKalwauGUcgRVQaKZB1oK7M0AbRGJ7nYMKeb2pDA510Pv3/UsE8/DeuqrVn4BomJrE6MNw5i8jygl12yXqG8OXkvWrgJV5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFSBuC1F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740038324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDyq9aCOU4k6/OxS5NyOrQ8zBZnEHt3wS9LzAF8nhU4=;
	b=VFSBuC1FNe5dS54iLQuHnrjtzZGfOoPGtb1Ckd0DUbg3UorlxUrDE+Pdlbm592SErCvAAD
	ohJmmfh6YhfHfpOBBJrVXcoI5KlYSR5aHtSto3IX9hWopHrPJBPh5xqcukLCE5R2ZjXtox
	vYJZjPy/6UizDiVJTj/DdyYI5IbU5Co=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-N97tN1X9MfurIdZYduXnwA-1; Thu, 20 Feb 2025 02:58:43 -0500
X-MC-Unique: N97tN1X9MfurIdZYduXnwA-1
X-Mimecast-MFC-AGG-ID: N97tN1X9MfurIdZYduXnwA_1740038322
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947979ce8so2628745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740038322; x=1740643122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDyq9aCOU4k6/OxS5NyOrQ8zBZnEHt3wS9LzAF8nhU4=;
        b=v8r9/m3my8HDibTOcu0dprCF3iab2gFicI7UrBA2QZsQO8HX5jQbl1ia6tjc5a7+u0
         3czSi5m5Efdo/axby2XEWWUd+QLUVPOk6sxOeOS5OnTypSWYpcNzkNze70ju10z643fS
         jnZxwPstM0UUZCHtsY4CqWhj8KZCqgvC5K21YC0FVpngcCuvT+Jpw/2WdSlJttdW2oKC
         iV5WksBCEdOs1a+Vg9j37KqQrhVvZ+0Zw7Rm+OpM4Rf9z2Wejw46rpZZQ1tI794D1rJ1
         3ku0/FTeab4yDIgWi4yVuI9X/ahE54p2WxB9hfN5v7rmRkpaVsJK+Aa5JrQmCmWqU5oa
         tyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ75qR6dPHWOUNxGPUc8eh/QWJPx/g/MD9Qc8HOYGJJqI10dfISRyi+yqbB3GjbyWXP6qjL14nF7w1Pio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCfs993QW9eH7c+tED+6Yo0qfx2KQ7SnAfzgudufeQK0pBPHi
	jQIOxSa/pAL2AGFJ3NNcs/2eNXLEZ0Dpkt8Q/tLkCsaAcisfrNxiRQ9+14hRI/Qv8jEQBZouh53
	WDp9q5YZhZD31NP9mPlxIeJubkGncV3seSKRBBsawYxIRl0Q5MTLTlRxEafZxfA==
X-Gm-Gg: ASbGncvNbKrHb/G3dFd42qLlB6lxd1WMOJTp/TY25H0kyqezPvlJHN6rECRrJY4ggqs
	r8NZzeIhcnNIrMfnkLqu5l1S81NH4VrQCUS5TwgGdupd9SSGZqu70aTSxI50Co5ffS7qCIfUTGu
	Kv8NaL8cIc93GTMJwuxLomN/F9ZLjUaZGIMljMHR7f4WVhk59CnDDhZkKT0uW4rgIZZ1bNIGA6c
	V961pqxZCTwAfBD0W9qLZ9FzviE30fxatnoVdxN2k2jT6vWQXfcbNpX5fM86Q/qaOATXmKGX73m
	wgjp/v0FGEFafMD8sgPpRBx1AQICIEP4S4o=
X-Received: by 2002:a05:600c:1e89:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439a7b81c85mr5230885e9.17.1740038321789;
        Wed, 19 Feb 2025 23:58:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMZ/J4mT4eh+w4zVIHYL3J2TeyMMFBaqTsZEuN7XJULLXJfI3m9ZBVAO4oeESyI4i7d0LvUQ==
X-Received: by 2002:a05:600c:1e89:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439a7b81c85mr5230655e9.17.1740038321375;
        Wed, 19 Feb 2025 23:58:41 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7bcsm232584425e9.28.2025.02.19.23.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 23:58:40 -0800 (PST)
Message-ID: <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com>
Date: Thu, 20 Feb 2025 08:58:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet
 <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/15/25 7:04 AM, Akihiko Odaki wrote:
> tun simply advances iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This will become
> especially problematic when tun starts to allow enabling the hash
> reporting feature; even if the feature is enabled, the packet may lack a
> hash value and may contain a hole in the virtio header because the
> packet arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.

Should virtio starting sending packets only after feature negotiation?
In other words, can the above happen without another bug somewhere else?

I guess the following question is mostly for Jason and Michael: could be
possible (/would it make any sense) to use a virtio_net_hdr `flags` bit
to explicitly signal the hash fields presence? i.e. making the actual
virtio_net_hdr size 'dynamic'.

> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so replace advancing the iterator with writing zeros.
> 
> A user might have initialized the buffer to some non-zero value,
> expecting tun to skip writing it. As this was never a documented
> feature, this seems unlikely.
> 
> The overhead of filling the hole in the header is negligible when the
> header size is specified according to the specification as doing so will
> not make another cache line dirty under a reasonable assumption. Below
> is a proof of this statement:
> 
> The first 10 bytes of the header is always written and tun also writes
> the packet itself immediately after the 
> packet unless the packet is

 ^^^^^ this possibly should be 'virtio header'. Otherwise the sentence
is hard to follow for me.

> empty. This makes a hole between these writes whose size is: sz - 10
> where sz is the specified header size.
> 
> Therefore, we will never make another cache line dirty when:
> sz < L1_CACHE_BYTES + 10
> where L1_CACHE_BYTES is the cache line size. Assuming
> L1_CACHE_BYTES >= 16, this inequation holds when: sz < 26.
> 
> sz <= 20 according to the current specification so we even have a
> margin of 5 bytes in case that the header size grows in a future version
> of the specification.

FTR, the upcoming GSO over UDP tunnel support will add other 4 bytes to
the header. but that will still fit the given boundary.

/P


