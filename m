Return-Path: <linux-kernel+bounces-537631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80899A48E55
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC653B79FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C1214375D;
	Fri, 28 Feb 2025 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWB9cJDS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1692BAF8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708563; cv=none; b=GNDWIUTQL/u7jxo03HLQ07q9P+AAgOKn6eAbwu2BpcTFBQsbhTKlIhpbRFMaYHTPtvXNEuM3on+QUH4eSUIdXuray5zbFd/gdx+W8SKNdVrlnuU6QdI/QSPBY9tjHcbaz1NeFGLUyHnOs8bqH6JxnEbs4of1bYLgUsJCA0Fy3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708563; c=relaxed/simple;
	bh=a5JsqXiaGY36Hh7eU8AAOIHxZeTBUupCcWWH+g6XLY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyHsMad+t5Wcq3jAxOrWv5M9Pb/LRFlayY6PVHyW1rhQuQqCqdxX1n8g1WRbvepFzECZkclJKlWbgQTMWiTcnuPSWd7rmVQMApLbOK+rT3bZzHnjGtNWJBSqtAzPjgSV/4vEDcs+xCIJ6Fu7GmNofUoZuAqfMv4lwlOHmHJBJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWB9cJDS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740708560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTGEdMvMyyKhNYQ+tRKpSv2O6+mM21XzlC4cogCh4sA=;
	b=hWB9cJDShBtyJyGh8LsCuMfTJftlGKhKGAlEQLW8kN8wuKiZPjmHmymhR9++JKZ2JsmSje
	RG4/pk8BB5/+4Hopg5RNFJaQSQ8awOSJNk2NW3aOSpCOyhv3Kg46A962cO6epbKXCbkVR1
	nZmx68efu+gIQxSBvRzSWs0Snmkp7Zo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-BNaNzFdmOAqnsvuQyQjUtg-1; Thu, 27 Feb 2025 21:09:19 -0500
X-MC-Unique: BNaNzFdmOAqnsvuQyQjUtg-1
X-Mimecast-MFC-AGG-ID: BNaNzFdmOAqnsvuQyQjUtg_1740708558
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso5766995a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740708558; x=1741313358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTGEdMvMyyKhNYQ+tRKpSv2O6+mM21XzlC4cogCh4sA=;
        b=ItpY5EhDHoSRuGl8p/Q/cvywb2gp8eDiCbNiaEJe00Z94zMed02i0vZIlY7vPO9Buz
         olUZGURQwM90QjjjbV2uKAWmHzrhaiaRR1KsIwIr8hs8clJF5VptrKv7NnVPofujVDp0
         3JOX6ghDxG/GNZI9rfEwEdjI2b8BY7dvO7Ak/eFFwAIxBe7Dx74pkG4bNj+/J+GWmvbk
         P7dBk+s5ffsQg8Tht0OqR3xm0V9WYB13R7bevrDlPtRHADGmyZiOqdRdgTTBJp4u2VWa
         QPy5UDs7n0eCNnX2Y5A4AI5246H7zC5KqZSch7a+rCH79ZH+4A9TFuHzjzIR3m95yCvI
         RAtw==
X-Forwarded-Encrypted: i=1; AJvYcCXRdX3RqBcTaCEM4wT8nTYnp4SZluB+St4qHXGhDXFu7MGr6LXPzlq5vNvNizO9CWhGRgYvLoCh+ckN5ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMJgbU+SW05P5gUD6Q5aITITBYSyi6v3fxGJmpOZ7RhSJCpbe
	UU4itv4q8toFm1sZlqYzke0cypq03NAxwRAVwS/iCacSl/511qD642R1sUP6vEJWanudbdw60A8
	h+tZgQ5yMDF0w1nKs+l6Q4dbCZDYIC1fRviVQagx1TgLH2Mnh9HQp8qX40V8ZmQ==
X-Gm-Gg: ASbGncvdl1dW7anoB7YWVPzsLlay56AtoLFlBQsxe8WOFmzPgjbx148qqegbvjR4zUJ
	HisH7LUljQN+oUWIy+VMr72W1Kw1dXlDz4Re5I0CfzFReAa+0LUeoS0+9sGd3u8tX6hViTSLUVt
	/Yxp0tpP5C3bHh8neKfN+s98oPjSyGlA9vr2Ybm881JwwFNnN464p7CeiOj+S7nwZqAmryckwsU
	1ASf84hu8wQCO/TMvcP1QIoT9nIe9cob4+o3uLjfB0kYPF8zwn9aPnt8v5X06ZXBVu1/h3iJ+3l
	7G+m9ZsoC2cUueNAiQ==
X-Received: by 2002:a05:6a21:7890:b0:1ee:6d23:20ab with SMTP id adf61e73a8af0-1f2f4cc635emr2465276637.10.1740708558018;
        Thu, 27 Feb 2025 18:09:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEakws3JelgzGBAXf9l9mWjjAqu+6D7t+HRXAz0cviZfFNy9/h1CazsxywKOWIf5xzhjUujVA==
X-Received: by 2002:a05:6a21:7890:b0:1ee:6d23:20ab with SMTP id adf61e73a8af0-1f2f4cc635emr2465237637.10.1740708557737;
        Thu, 27 Feb 2025 18:09:17 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dec49f1sm2250674a12.58.2025.02.27.18.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 18:09:17 -0800 (PST)
Message-ID: <b46da29d-73ff-4166-b0dd-bf252e9d6457@redhat.com>
Date: Fri, 28 Feb 2025 12:09:10 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dma: Introduce generic dma_addr_*crypted helpers
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org
Cc: will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
 <20250227144150.1667735-3-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250227144150.1667735-3-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 12:41 AM, Suzuki K Poulose wrote:
> AMD SME added __sme_set/__sme_clr primitives to modify the DMA address for
> encrypted/decrypted traffic. However this doesn't fit in with other models,
> e.g., Arm CCA where the meanings are the opposite. i.e., "decrypted" traffic
> has a bit set and "encrypted" traffic has the top bit cleared.
> 
> In preparation for adding the support for Arm CCA DMA conversions, convert the
> existing primitives to more generic ones that can be provided by the backends.
> i.e., add helpers to
>   1. dma_addr_encrypted - Convert a DMA address to "encrypted" [ == __sme_set() ]
>   2. dma_addr_unencrypted - Convert a DMA address to "decrypted" [ None exists today ]
>   3. dma_addr_canonical - Clear any "encryption"/"decryption" bits from DMA
>      address [ SME uses __sme_clr() ] and convert to a canonical DMA address.
> 
> Since the original __sme_xxx helpers come from linux/mem_encrypt.h, use that
> as the home for the new definitions and provide dummy ones when none is provided
> by the architectures.
> 
> With the above, phys_to_dma_unencrypted() uses the newly added dma_addr_unencrypted()
> helper and to make it a bit more easier to read and avoid double conversion,
> provide __phys_to_dma().
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v2:
>   - Rename helpers- s/dma_*crypted/dma_addr_*crypted (Robin)
> ---
>   include/linux/dma-direct.h  | 12 ++++++++----
>   include/linux/mem_encrypt.h | 23 +++++++++++++++++++++++
>   2 files changed, 31 insertions(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


