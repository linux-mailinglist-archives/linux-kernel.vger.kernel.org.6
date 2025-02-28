Return-Path: <linux-kernel+bounces-537627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E51A48E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F7C1882FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248783CC7;
	Fri, 28 Feb 2025 02:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMId/STe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B523125B2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708515; cv=none; b=bn4PtmcdVZOojepjLlTcv7ApHvt1KbMMV9/+3zt62gjDEufc7lVYC2HUqPj/lpf2YZvZLfwO5JVOAX1/4iHUP1kYUP1JgAkeF3kyvpls0PvREejqpvEd56Y9Tk8MBSHfnOSC8ll8NvI4/pXNBf6+9rAHpnM4BQeAX4j7YFiCiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708515; c=relaxed/simple;
	bh=ntMRFDWO+IFXNxwNxjfm8PreVjt8JX+kXRYeGVuWOBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a737akE3nR4ByeNaBSjE5liZU9TDxoyiOYsAcuh84TI5qQK+VOo3FJf0FflpDx2J/o67am+I89MuLnrhD6PPwb0KB+CEdAxHaudGEdOXRI8A+fVssDKE4VuD9Xg3Ece8gatuZmaacuhtyliHBtX/UeMLP6bcP3OWG/NnBrmQd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMId/STe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740708509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQ/Fl0HwXzRHNyxsWxoDbaxOZuT2N+fcGDEHmXA1hb0=;
	b=IMId/STe+3oQLfDC8ekxjcNJo2zPo+RR1Di1+ncSZ7Gmw98eycPNK/BXVIkyE0ncp/jNmw
	fDOSbGDcIyMv9c8Jk9/QVT/hHeog4LOZ25E6LZzqImk4EbGEHjwHY4vqc3qbcXc0I1NEYC
	JdDT8jRXz/zgoVhyoKc0Wf3wlpEyIvA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-9ZY6KbgNMO61NAuIsXyA0w-1; Thu, 27 Feb 2025 21:08:27 -0500
X-MC-Unique: 9ZY6KbgNMO61NAuIsXyA0w-1
X-Mimecast-MFC-AGG-ID: 9ZY6KbgNMO61NAuIsXyA0w_1740708506
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2234dddbd6fso37184895ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740708506; x=1741313306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ/Fl0HwXzRHNyxsWxoDbaxOZuT2N+fcGDEHmXA1hb0=;
        b=N3pUCqxFdphmXr0639RDNcFwjnNOBzh5CjgNue3gvJltidVLn1iaSW/QfJWgeshuTB
         UKsyie1c02zYgCz15M/oUkhu8YvtPaaEGodlflF5avP4Iur0ZpTurq2pDy8AM2v47u4t
         erPeFOCT+rTfURE4KZWF1bes8gG533PMTT4+R53Ulwz9gzNbayANYttTDiuHcHZQUYLN
         rh/rPJTxV4liHbt9wKx0cG70MTJgkLBMHRqaalPkp7d6EFOBVdl+pW7XJ5zVbu1QFULT
         tQyk6Asxdq44UXmnT3bV7NOz4YB8SjmL4YBnaMTzzw8u/ZylshyACxfKpHuKhswooJqg
         ldFA==
X-Forwarded-Encrypted: i=1; AJvYcCWzseqsDWUAZpOnt18hjZd3tIg7WuPVW+VmLq4B8iqV65Bw323CrtgDyNLLplaP6O2Nzs5ie7/Flxur+DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwg1RCayUJXOrNwblWy2uvizbnZI00T19QfwOc06IBOC8I/O3B
	kx/eEDFglAk5IovUnhym66dpr4U3RltxKxv4kgbwMHMWeHVVBFcLzsfCtX4P+Dz03HPi7pKteuq
	p6hMxXcVaSv9geMcU8m9v+0+c+qNwUh+X98z3SnRwRzWbH3JsezNpM7SN5wjMtw==
X-Gm-Gg: ASbGnctnA4uhxmBHPnPmKUMCHIqVrTf/CPmxjeNr4wikC/CK0zwtFiqY1WDte7AecZj
	opLXfwiSTKuERnZYgW+oizz8JbOoRkQZrOsYvhTbBHLxDy8xQ6akaVPdlJuXXE7uDUztLfSLgwE
	zMNztlN90kF5/23CjCkZM0r8QE/dMnQUj2iHEwroY/5x9wnn8hxnKOztOxzMhsB1XcE56h42b68
	aLrG2+edoCSpcVPIFLRUYnhjZE5t6XJ7I7TdY/E2dJyokUqFub5yPd3ZkXn5fdW3KdYcl+3ngZ7
	ZikyyUrIa1iY0zFPIw==
X-Received: by 2002:a17:902:e88f:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-2236750c421mr28814185ad.25.1740708506485;
        Thu, 27 Feb 2025 18:08:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqsxG1w4CFgPe7zp+BHrGfr4zyqy2gKPJF3ydIcoqOzD/vMt4rTiKChpT0/GXLXVDP/aNN0g==
X-Received: by 2002:a17:902:e88f:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-2236750c421mr28813865ad.25.1740708506147;
        Thu, 27 Feb 2025 18:08:26 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fae0esm22661535ad.93.2025.02.27.18.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 18:08:25 -0800 (PST)
Message-ID: <5c59d489-f9f9-4383-a90d-93badfb65291@redhat.com>
Date: Fri, 28 Feb 2025 12:08:19 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: realm: Use aliased addresses for device DMA
 to shared buffers
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org
Cc: will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
 <20250227144150.1667735-4-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250227144150.1667735-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/25 12:41 AM, Suzuki K Poulose wrote:
> When a device performs DMA to a shared buffer using physical addresses,
> (without Stage1 translation), the device must use the "{I}PA address" with the
> top bit set in Realm. This is to make sure that a trusted device will be able
> to write to shared buffers as well as the protected buffers. Thus, a Realm must
> always program the full address including the "protection" bit, like AMD SME
> encryption bits.
> 
> Enable this by providing arm64 specific dma_addr_{encrypted, canonical}
> helpers for Realms. Please note that the VMM needs to similarly make sure that
> the SMMU Stage2 in the Non-secure world is setup accordingly to map IPA at the
> unprotected alias.
> 
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
>   - Drop dma_addr_encrypted() helper, which is a NOP for CCA ( Aneesh )
>   - Only mask the "top" IPA bit and not all the bits beyond top bit. ( Robin )
>   - Use PROT_NS_SHARED, now that we only set/clear top bit. (Gavin)
> ---
>   arch/arm64/include/asm/mem_encrypt.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


