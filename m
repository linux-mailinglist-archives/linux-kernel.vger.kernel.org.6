Return-Path: <linux-kernel+bounces-354247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F61993AA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A323E1C22890
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80D618CBFD;
	Mon,  7 Oct 2024 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0rFlX9q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00113D8B1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342515; cv=none; b=uHQE1z9Wa2W85PapK4vAhXY6MfDakq8C4V6fyPiK06BOq0wgyeh+5h3/ORRyWfQeejbtpFCXFOBdQzl2VTjE/eECR0ziExOhCEWzFHWqyalROQxFcu1e1RDy+C/y8zFW+Na72bkNqlJvBPFDqx1e/Yf0LScOhRlYrvl0RFC3Iys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342515; c=relaxed/simple;
	bh=sFKC8oum4eACHS/9pWNfotlCf3EQRPXmA4khW9IqDfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUvaHmkPmV6sIt77ICCsMWXROJ4WOIRN0NexSwM7imvvHWYD1lG24brCWmIcjizAIKrHxDr2CmAi8kDL5Be7/hGsu8P305n96IRArB3/4378FQOe6AAkZu2Ekt/oOu15YTQSRb5W8THXhyeedVVrEIcBY1YvyBfTL3vVIsoVQE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0rFlX9q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728342512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfJmONIqkrrRodARYVzXrl8zpLHbhe4TWvVFD3MTZqg=;
	b=M0rFlX9qPVCKtpD3aYSdEJnKpurHFsbSeMVlKyF4tFl0YS061ZInAumB907dP6Doo9CQ87
	Jg4O9wU1os3eMC7d8o0273LfwVaeBIwII5dPr7Ta9NekD4Ws9mfGQenVQfBNnCbV2J4Z7I
	NWWGhFuRQt4GtMgpvH+9ygYaOWT4MGQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-nuQ4WN1lMUut1nyNwoyC6w-1; Mon, 07 Oct 2024 19:08:30 -0400
X-MC-Unique: nuQ4WN1lMUut1nyNwoyC6w-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2070e327014so48597695ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 16:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728342509; x=1728947309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfJmONIqkrrRodARYVzXrl8zpLHbhe4TWvVFD3MTZqg=;
        b=WC4uZFLLrWuKsYitgV7TfozGNQUi6m7yUgy2tOKxARTWchVLBqBKATvs1wo547l3qa
         dEnVyE4Lm6UK8ageukzNh9uCh+7RF71fOBqbB8anL9OSwIKR4NOKlkMYye41LbRZheQf
         wRFgxJJeDXt1ssX8vBBjJFGcvlhQUHQ9Ojgkf7GXKMAB/FpVA9+W41aUwWIRbG4iG834
         tRsUJn5432/75UhJAR7RJRSJ35Ef20wiKMgQeOFghfrvYo2UJaWZ93SChIcpz0zJR60Y
         ECv2RZvzU4MIbmsmn9vsjHUQmFnujDtDHy8GRUyotGzbpEbkUn+bqE06GDMnUF1/jRu9
         YSUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFlmll4rcQHo7HdX4C9clcC7MIlEWvYWORCpOmJEAqeSDpNZk59IzYPmqYj88mokb4qMTkyIz896Fsc90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAOb7jtMA6HnmkM+vJdnUkFinQyS+ljl4yKv2Q96oxRG7Evc6
	0D/EYpi7QjKySdD0qm0pIhksuuTGeKLSY/AmuHINTVNcCFDqs7Uru8uDmPGPMskQR4a9G/mzSYB
	WJ+d/hSliwvKs4fXL1fheZrrxEIN1bWGK3tQxcNmOdwZctUhcy6gXbLQNQwv3Tg==
X-Received: by 2002:a17:903:40d1:b0:205:9220:aa37 with SMTP id d9443c01a7336-20bfdfd31c5mr168800665ad.22.1728342509513;
        Mon, 07 Oct 2024 16:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxry6Ql2xA8l+3h1gl4I/L2BZcrkbVPn5b4zTTD+RDz9IJ0w2m9Xz1rJHClf446EHVSuntWw==
X-Received: by 2002:a17:903:40d1:b0:205:9220:aa37 with SMTP id d9443c01a7336-20bfdfd31c5mr168800285ad.22.1728342509084;
        Mon, 07 Oct 2024 16:08:29 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393175csm44740705ad.140.2024.10.07.16.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 16:08:28 -0700 (PDT)
Message-ID: <2ed92455-b97f-40ba-b5d6-695e885be62f@redhat.com>
Date: Tue, 8 Oct 2024 09:08:18 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] arm64: rsi: Add RSI definitions
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Gavin Shan <gshan@redht.com>
References: <20241004144307.66199-1-steven.price@arm.com>
 <20241004144307.66199-2-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241004144307.66199-2-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/24 12:42 AM, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> The RMM (Realm Management Monitor) provides functionality that can be
> accessed by a realm guest through SMC (Realm Services Interface) calls.
> 
> The SMC definitions are based on DEN0137[1] version 1.0-rel0.
> 
> [1] https://developer.arm.com/documentation/den0137/1-0rel0/
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Gavin Shan <gshan@redht.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---

[...]

> +
> +static inline unsigned long rsi_set_addr_range_state(phys_addr_t start,
> +						     phys_addr_t end,
> +						     enum ripas state,
> +						     unsigned long flags,
> +						     phys_addr_t *top)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(SMC_RSI_IPA_STATE_SET, start, end, state,
> +		      flags, 0, 0, 0, &res);
> +
> +	if (top)
> +		*top = res.a1;
> +
> +	if (res.a2 != RSI_ACCEPT)
> +		return -EPERM;
> +
> +	return res.a0;
> +}
> +

Similar to rsi_attestation_token_init(), the return value type needs to be 'long'
since '-EPERM' can be returned from the function.

> +/**
> + * rsi_attestation_token_init - Initialise the operation to retrieve an
> + * attestation token.
> + *
> + * @challenge:	The challenge data to be used in the attestation token
> + *		generation.
> + * @size:	Size of the challenge data in bytes.
> + *
> + * Initialises the attestation token generation and returns an upper bound
> + * on the attestation token size that can be used to allocate an adequate
> + * buffer. The caller is expected to subsequently call
> + * rsi_attestation_token_continue() to retrieve the attestation token data on
> + * the same CPU.
> + *
> + * Returns:
> + *  On success, returns the upper limit of the attestation report size.
> + *  Otherwise, -EINVAL
> + */
> +static inline long
> +rsi_attestation_token_init(const u8 *challenge, unsigned long size)
> +{
> +	struct arm_smccc_1_2_regs regs = { 0 };
> +
> +	/* The challenge must be at least 32bytes and at most 64bytes */
> +	if (!challenge || size < 32 || size > 64)
> +		return -EINVAL;
> +
> +	regs.a0 = SMC_RSI_ATTESTATION_TOKEN_INIT;
> +	memcpy(&regs.a1, challenge, size);
> +	arm_smccc_1_2_smc(&regs, &regs);
> +
> +	if (regs.a0 == RSI_SUCCESS)
> +		return regs.a1;
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * rsi_attestation_token_continue - Continue the operation to retrieve an
> + * attestation token.
> + *
> + * @granule: {I}PA of the Granule to which the token will be written.
> + * @offset:  Offset within Granule to start of buffer in bytes.
> + * @size:    The size of the buffer.
> + * @len:     The number of bytes written to the buffer.
> + *
> + * Retrieves up to a RSI_GRANULE_SIZE worth of token data per call. The caller
> + * is expected to call rsi_attestation_token_init() before calling this
> + * function to retrieve the attestation token.
> + *
> + * Return:
> + * * %RSI_SUCCESS     - Attestation token retrieved successfully.
> + * * %RSI_INCOMPLETE  - Token generation is not complete.
> + * * %RSI_ERROR_INPUT - A parameter was not valid.
> + * * %RSI_ERROR_STATE - Attestation not in progress.
> + */
> +static inline int rsi_attestation_token_continue(phys_addr_t granule,
> +						 unsigned long offset,
> +						 unsigned long size,
> +						 unsigned long *len)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RSI_ATTESTATION_TOKEN_CONTINUE,
> +			     granule, offset, size, 0, &res);
> +
> +	if (len)
> +		*len = res.a1;
> +	return res.a0;
> +}
> +

The return value type of this function needs to be 'unsigned long' even it's
converted to 'int' in arm_cca_attestation_continue(). In this way, the wrapper
functions has consistent return value type, which is 'unsigned long' or 'long'.

Thanks,
Gavin


