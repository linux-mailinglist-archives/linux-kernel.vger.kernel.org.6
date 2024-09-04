Return-Path: <linux-kernel+bounces-315328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C166996C121
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7833028378C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E91DC07B;
	Wed,  4 Sep 2024 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Asn+0wpT"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C51DB548
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461286; cv=none; b=agy0D66p0yMiEVWDm/EmeNXLv8P8b12drYizf7Uk+v4sRyw5fh6CTJAKHy4r9C2r1+s3FEjmvBaJGPJ5xVI8ZiSptdzkKB8LUXLerbjd+T7xGHvOpXH6ucbMK0nKg9vKIuF1UjgoqrmgVqRYnzzSnR3wdQDYH1RIZSzcEl73hDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461286; c=relaxed/simple;
	bh=zwkevx0JOA1sU3/G6Uk1dmNSxwY1PH5EmMk1/KtzlkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHIbvlgkvTy3rcXbLHIH3qye03Sci3jfE7+3H7Bp2qo7rPwVS1mc6aG/FZG1IvMtwGEkrh0eFJKJGdkGXxbtcFV+iV+uNpbAZr+ypWBF/CPPgVj3z7g3o0BTz8EUfHjtvqUtk0T6a6Y6/fkOraa8wNEp7soxWQImUrf0C+9xsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Asn+0wpT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so47033865e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725461283; x=1726066083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6kEIYFtkOtx+DJY9n3gGx8oC/72d34oJtC4eMa+2Jo=;
        b=Asn+0wpTHemfiJQDjxEd62JM06+gVADtIFWCMpECwKqfx15B4QNIk0iqFQTwVxjHAj
         Pq6SH/serdvBRZjmdveGp+rwsN8wZMo1C1z/DxBV8eapfomAzS0sjcVP0Kkh/HJWcmiI
         aqWb8L+DLJ9Cpbbu8REj/FQHjfU8zz/dVsrP8T4FFrod6fn7HHlpWGHRL4pLoGJk85iX
         O9+jenjQ5wNOG2G2GLhjZFWdySTxcwlfxAXnIc15wEAi3hiyxYBovkFTSqUX5wCCSIZe
         8EVXCakApavMXmFWhGBqi/XG2Z0CYEMDTN+cnJoXdxrAD9DyNpisGEjKZm6GfAXjiLkz
         BqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461283; x=1726066083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6kEIYFtkOtx+DJY9n3gGx8oC/72d34oJtC4eMa+2Jo=;
        b=USuG6Jxuuhu1SAwVV9CPvS2a1lNwOdSJNyetAk+DW9PAOd/ZRL88Yx2EBTex1+QyPa
         wUu0edAtSiGU9S8bhZ8VLJtTfpJSxWf4AF/nL8QJatGl68EmXl0zyizyHe7V2Nq9vNPW
         McTArsTmKTvH4qSQst77Et6qWU8leYJgTrV5QURBWaXkn8TI3GZcb8RBq0X87RR7a/eI
         Mn2SyvfIm5dKxu5+5o+sdBPgMXGYpTKqXUXmLSzcv++DiEvjkWp+F4ueHxnbQDfn9DQZ
         9d9Nx1SIw423YrSUFONdwqqbwAfypZiMBlT2/1uEPcpbOJtzydPa+zatus+E5FuK/eRD
         9rqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK64KLFec2CbyMjO4aClpL+5/48cdEajoiXUNurI5ff/SE2eQ2kCL8LsQ4XTBW1dPEv8hXMRma0XZE8Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8E5cZ3sDZ4DrETvXHzIZ1P6uw4Od3Fgpk8347tIbZ8RGM5Xs5
	Lfeme4f8XZfqljgwR/BNUNpjXpbg9Xh88FxkrTyplYT5xxsZj7qus2FjY2TrTdE=
X-Google-Smtp-Source: AGHT+IHKZyt11Lslz0HlasHPTxHt7BSYAR0Jjt79ONBZBuyaQ3ymGqrpolN3WJVQPOJE6wYCFvw0hQ==
X-Received: by 2002:a05:600c:3b8e:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-42bb01b556bmr164929245e9.15.1725461282171;
        Wed, 04 Sep 2024 07:48:02 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb01d300csm218202355e9.15.2024.09.04.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:48:01 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:48:21 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>
Subject: Re: [PATCH v4 21/43] arm64: RME: Runtime faulting of memory
Message-ID: <20240904144821.GA223966@myrica>
References: <20240821153844.60084-1-steven.price@arm.com>
 <20240821153844.60084-22-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821153844.60084-22-steven.price@arm.com>

On Wed, Aug 21, 2024 at 04:38:22PM +0100, Steven Price wrote:
> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
> index 2c4e28b457be..337b3dd1e00c 100644
> --- a/arch/arm64/kvm/rme.c
> +++ b/arch/arm64/kvm/rme.c
> @@ -627,6 +627,181 @@ static int fold_rtt(struct realm *realm, unsigned long addr, int level)
>  	return 0;
>  }
>  
> +static phys_addr_t rtt_get_phys(struct realm *realm, struct rtt_entry *rtt)
> +{
> +	bool lpa2 = realm->params->flags & RMI_REALM_PARAM_FLAG_LPA2;

At this point realm->params is NULL, cleared by kvm_create_realm()

Thanks,
Jean

> +
> +	if (lpa2)
> +		return rtt->desc & GENMASK(49, 12);
> +	return rtt->desc & GENMASK(47, 12);
> +}
> +
> +int realm_map_protected(struct realm *realm,
> +			unsigned long base_ipa,
> +			struct page *dst_page,
> +			unsigned long map_size,
> +			struct kvm_mmu_memory_cache *memcache)
> +{
> +	phys_addr_t dst_phys = page_to_phys(dst_page);
> +	phys_addr_t rd = virt_to_phys(realm->rd);
> +	unsigned long phys = dst_phys;
> +	unsigned long ipa = base_ipa;
> +	unsigned long size;
> +	int map_level;
> +	int ret = 0;
> +
> +	if (WARN_ON(!IS_ALIGNED(ipa, map_size)))
> +		return -EINVAL;
> +
> +	switch (map_size) {
> +	case PAGE_SIZE:
> +		map_level = 3;
> +		break;
> +	case RME_L2_BLOCK_SIZE:
> +		map_level = 2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (map_level < RME_RTT_MAX_LEVEL) {
> +		/*
> +		 * A temporary RTT is needed during the map, precreate it,
> +		 * however if there is an error (e.g. missing parent tables)
> +		 * this will be handled below.
> +		 */
> +		realm_create_rtt_levels(realm, ipa, map_level,
> +					RME_RTT_MAX_LEVEL, memcache);
> +	}
> +
> +	for (size = 0; size < map_size; size += PAGE_SIZE) {
> +		if (rmi_granule_delegate(phys)) {
> +			struct rtt_entry rtt;
> +
> +			/*
> +			 * It's possible we raced with another VCPU on the same
> +			 * fault. If the entry exists and matches then exit
> +			 * early and assume the other VCPU will handle the
> +			 * mapping.
> +			 */
> +			if (rmi_rtt_read_entry(rd, ipa, RME_RTT_MAX_LEVEL, &rtt))
> +				goto err;
> +
> +			/*
> +			 * FIXME: For a block mapping this could race at level
> +			 * 2 or 3... currently we don't support block mappings
> +			 */
> +			if (WARN_ON((rtt.walk_level != RME_RTT_MAX_LEVEL ||
> +				     rtt.state != RMI_ASSIGNED ||
> +				     rtt_get_phys(realm, &rtt) != phys))) {

