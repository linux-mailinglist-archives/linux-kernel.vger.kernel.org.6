Return-Path: <linux-kernel+bounces-248084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D7D92D836
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DC51F21C86
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117D195FD1;
	Wed, 10 Jul 2024 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6Vts6Yc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED01922E3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635965; cv=none; b=IP/rZQq/uP7YV+EtGVTlp8wqv9U1b+LXMm3k9FAQgq4nmPemthCSQuA93HsU5Dv0kK5jBMPXtD5JbG39RtEoUGWN8jGZCrgFlRVHXpGIhpJcy9KfFvyUfgckFX21TUtTJZ633xXjue0FQnjnBfYZ1dnt2qNs/Hng9no9bflbdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635965; c=relaxed/simple;
	bh=HbqBwpERhoys6IIGkMxxMqtV+w+jB3wNftYPPPFFN0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AATO2wdxXdx2noPlorXvBrtGSd83F8v7S+Ty8GGQaFSKwKwCo52Yx7VTnxEzPGWRsPLT+K6AvuNutK4JgRdYMPXqYT12HOTxO/nPrdpD/hRRr1izXv7bljokJB4jDKxt+XJLfJ8ue76DfcRnbmrd5rrSBMrVrYATsJNPKnD8iKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6Vts6Yc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720635961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U2rEv51u4KMmIPEC5TxLnxrDMlUuZLWNG4UYs9k5I/4=;
	b=Y6Vts6Yc/HwRzJFnAw6p4U7ioTFzNuobfEYcEeD2cWHcDYH1TLVLmyD1922z6WeAT8y7wC
	tm/Ns3mWa8KMIARGA3Afqob0WRqG/7Ue8C/GbHlPCifmMX4Tj4Z6nGMbgLcoUdCbrmLqpd
	DwLb4xuKPDlJGX/pCcRTzfps9Kf8ESM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-SjvO92aeMaWRCZbRWNGX9w-1; Wed, 10 Jul 2024 14:25:59 -0400
X-MC-Unique: SjvO92aeMaWRCZbRWNGX9w-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fafb7eb163so169095ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635958; x=1721240758;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U2rEv51u4KMmIPEC5TxLnxrDMlUuZLWNG4UYs9k5I/4=;
        b=jftMJUkKWxe3FvobEDqGqSpbbiqQLjjq5OliUTa3/KZjM/gxJUDbOPwVAjgR5MC035
         Xl69AVvbqGOjSHxrinXyvvy40QRrz5J3X4HGLwmd7AV3fj1xdUYiBcmQ+TeTiEFs28HE
         N4QKcTP73LEe6weJPjjfCo0ksbETH83EG0QmHV/3cVtYpVGw3kKG9s//iwl93UkcCqsj
         +RHmXGOwvYfiaOf6MODpJ2ynkfU7fclnhMh74+ZPI10Bvg72bAE0jfwCEQQfTrKTbYIF
         vt8m/rJ2R3Ey4u8J4KttedkozN8Ybquc1/gg49NpZykPej9xWDRG87O4eGi6TcDHgvu4
         ZFwA==
X-Forwarded-Encrypted: i=1; AJvYcCWLKG+bzFKi8e2mvXSa6BUT9fPVDhqIIlt5qwJ9DDCzpWCRwv6gvMY6HTZZTiEs1GJGKG8XBSB6zxF9ZHnW1yPEejKuo2zpkEfgGQ+G
X-Gm-Message-State: AOJu0Yx+Oj+EgsoRXYVHqkSpSdxr35ZFnqK1kdtwCwEpNUpqMW625dMf
	kdB6jicpU3Q88VAeBQ17bcUUBfZ37wiK4enYPrz9+UyNceZZXX0LfcHneOtb42dOdG5XgiKY9Fu
	OzRKt1pHzC8yTSy2I7TSKg6N/snlV+ladLH3CcZmpMDVntNGEPV/6lux5XBzfnQ==
X-Received: by 2002:a17:902:e84f:b0:1fb:3b30:8ce0 with SMTP id d9443c01a7336-1fbb6ed5798mr58215205ad.44.1720635958048;
        Wed, 10 Jul 2024 11:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvpj3tgd4hi0jiKDDVqqCni4YVHK+oIJeh5jjCVBljWk6H2U0NmuoML9kUIYE9vLOVcbdsNA==
X-Received: by 2002:a17:902:e84f:b0:1fb:3b30:8ce0 with SMTP id d9443c01a7336-1fbb6ed5798mr58215085ad.44.1720635957674;
        Wed, 10 Jul 2024 11:25:57 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a424bcsm37779245ad.116.2024.07.10.11.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:25:57 -0700 (PDT)
Message-ID: <e9405f5d-2b43-40bf-b496-9eaae7c873c5@redhat.com>
Date: Wed, 10 Jul 2024 20:25:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] virtio-balloon: make it spec compliant
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <cover.1720611677.git.mst@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cover.1720611677.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.24 13:42, Michael S. Tsirkin wrote:
> Currently, if VIRTIO_BALLOON_F_FREE_PAGE_HINT is off but
> VIRTIO_BALLOON_F_REPORTING is on, then the reporting vq
> gets number 3 while spec says it's number 4.
> It happens to work because the qemu virtio pci driver
> is *also* out of spec.
> 
> To fix:
> 1. add vq4 as per spec
> 2. to help out the buggy qemu driver, if finding vqs fail,
> try with vq3 as reporting.
> 
> Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> Cc: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
> Reported-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Changes from v1:
> 	rebased on vhost tip
> 

Looks like you missed to include acks from me and Jason.

-- 
Cheers,

David / dhildenb


