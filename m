Return-Path: <linux-kernel+bounces-317982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDCA96E6A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7ABB2395A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7811FDD;
	Fri,  6 Sep 2024 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmGug765"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58362F4A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581514; cv=none; b=W/U3LbuV4Y16f8At7lkT0evPY1hUz9iUAtvYUgTWn4TzTYIwOCoCeqHJWkyE0MbfaWJHqCyJjN/YFM00AhIgsdHb5pG+7+8s+mUNPGH1P//NYgV9Nnb2sBMzsDoBpTUZz1GfDX3/xLxHjNHf5PxJudl/tRBmSlIz+KN5v1/wgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581514; c=relaxed/simple;
	bh=WiXv8hX9YZancIkVdHpHwSwJynH9Vx0kkTy6hfFFNvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvHvBuH92Ns9fk7l0LQRA8FAebrwQIEtA1p15HuKAz906RKnK5b1TnliwaMwsRcN7okahKuHRwgIKPY/BAW1ZY6LlLwACfxipE2TtIsxl17RNmTd5Y1Xdwvqztd5K1xQfMBWoZyHN5+fRWBo0WIL+0TRPX7lHLhN/m+hOucdmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmGug765; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725581511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCf63UUAEsoVjhHUgMARlZrjCRqgXN/a16VIpsPHI30=;
	b=fmGug765axj+S9OMTSzB66N4PD4oE3/FDgIdWPFqGes9hnAJ74m/XIPlF8mv8W06R+TWB+
	5LVtAOIlha9wAsxIOYWTx7OjnR+c+JHjZ7fEaUp+TaNGH2fllRMKkUwRLH6evTE0VWzrga
	137uteBRMRlNFHkbqr8iDqp/nQR+G7o=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-1DpZEgDmP-uvyvtg0VzP3A-1; Thu, 05 Sep 2024 20:11:50 -0400
X-MC-Unique: 1DpZEgDmP-uvyvtg0VzP3A-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7178f096d62so1656691b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725581509; x=1726186309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCf63UUAEsoVjhHUgMARlZrjCRqgXN/a16VIpsPHI30=;
        b=YJVdWzstfGjT/cONROnSiY/KQSsWRyy4+w5A+fbpBdx43OexNYJllllmV7V/bFbEdA
         4sllKhi0LjyW9DGXnoXD/2ydJxsLUlWKFr5+LXaUg55PTNUxIGFeLUw9D5U9pWTt9tkL
         OC2YZjLRfNBYR3vB45vxcP/PK4u3PI7BXIDaquNMwLOlYK+ufWfVG1Z+xJpyDJrrWqhi
         GSlI9/bWIy70hcgX7FwVso8oLA5d/UP1Vp+6xkcWx92XD5WtaOLMXlgPRqqF9WSpIE3c
         95CDKJrDqekf1fjr1CQZAgfzXHj93GEUx0GW1bqbhseoVKIWRip40Wynl2LrHdzQw5lw
         bEBw==
X-Forwarded-Encrypted: i=1; AJvYcCWQAbUmZnqHMu3h54eQ8y9/lsZjssa4J26G4tuwc19l8hZyEogWwN1mkYq+VK9q7Ai5fPyzQqpLj64W4WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1U+ppaavMKQqKspHSRhTBpIcnERnrzk1GbfV2bGMH8lBHEAo
	ruMgu3zErSqNav7bhG//yFCZEBS8rdDJ5O+gcXtPccZ8EUlMK7AQxg6EWOjcWia83KC5jCBQjVt
	snp9OjWKCCG0EQSIovubb/8F4MHuznCwPJkW7JmDdAukzNJyD07qi8j9t7Wv87g==
X-Received: by 2002:a05:6a00:2d89:b0:717:90df:7cbb with SMTP id d2e1a72fcca58-718d5f32a78mr828860b3a.22.1725581509043;
        Thu, 05 Sep 2024 17:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ1mDgKhDpSBr33m3qRjdU1KN0Ixr0d3LiEv3WDkhrTsLXZpCco0dlZ/A1QyM+Jkkdv532Jg==
X-Received: by 2002:a05:6a00:2d89:b0:717:90df:7cbb with SMTP id d2e1a72fcca58-718d5f32a78mr828823b3a.22.1725581508457;
        Thu, 05 Sep 2024 17:11:48 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718087d92ffsm535625b3a.153.2024.09.05.17.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 17:11:46 -0700 (PDT)
Message-ID: <fc168fe2-2b19-4930-85cf-047260aeaef0@redhat.com>
Date: Fri, 6 Sep 2024 10:11:37 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/43] arm64: RME: Add SMC definitions for calling the
 RMM
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>
References: <20240821153844.60084-1-steven.price@arm.com>
 <20240821153844.60084-6-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240821153844.60084-6-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven,

On 8/22/24 1:38 AM, Steven Price wrote:
> The RMM (Realm Management Monitor) provides functionality that can be
> accessed by SMC calls from the host.
> 
> The SMC definitions are based on DEN0137[1] version 1.0-rel0-rc1
> 
> [1] https://developer.arm.com/-/cdn-downloads/permalink/PDF/Architectures/DEN0137_1.0-rel0-rc1_rmm-arch_external.pdf
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v3:
>   * Update to match RMM spec v1.0-rel0-rc1.
> Changes since v2:
>   * Fix specification link.
>   * Rename rec_entry->rec_enter to match spec.
>   * Fix size of pmu_ovf_status to match spec.
> ---
>   arch/arm64/include/asm/rmi_smc.h | 253 +++++++++++++++++++++++++++++++
>   1 file changed, 253 insertions(+)
>   create mode 100644 arch/arm64/include/asm/rmi_smc.h
> 

[...]

> +
> +#define RMI_FEATURE_REGISTER_0_S2SZ		GENMASK(7, 0)
> +#define RMI_FEATURE_REGISTER_0_LPA2		BIT(8)
> +#define RMI_FEATURE_REGISTER_0_SVE_EN		BIT(9)
> +#define RMI_FEATURE_REGISTER_0_SVE_VL		GENMASK(13, 10)
> +#define RMI_FEATURE_REGISTER_0_NUM_BPS		GENMASK(19, 14)
> +#define RMI_FEATURE_REGISTER_0_NUM_WPS		GENMASK(25, 20)
> +#define RMI_FEATURE_REGISTER_0_PMU_EN		BIT(26)
> +#define RMI_FEATURE_REGISTER_0_PMU_NUM_CTRS	GENMASK(31, 27)
> +#define RMI_FEATURE_REGISTER_0_HASH_SHA_256	BIT(32)
> +#define RMI_FEATURE_REGISTER_0_HASH_SHA_512	BIT(33)
> +#define RMI_FEATURE_REGISTER_0_GICV3_NUM_LRS	GENMASK(37, 34)
> +#define RMI_FEATURE_REGISTER_0_MAX_RECS_ORDER	GENMASK(41, 38)
> +

Those definitions aren't consistent to tf-rmm at least. For example, the latest tf-rmm
has bit-28 and bit-29 for RMI_FEATURE_REGISTER_0_HASH_SHA_{256, 512}. I didn't check the
specification yet, but they need to be corrected in Linux host or tf-rmm.

   git@github.com:TF-RMM/tf-rmm.git
   head: 258b7952640b Merge "fix(tools/clang-tidy): ignore header include check" into integration

   [gshan@gshan tf-rmm]$ git grep RMI_FEATURE_REGISTER_0_HASH_SHA.*_SHIFT
   lib/smc/include/smc-rmi.h:#define RMI_FEATURE_REGISTER_0_HASH_SHA_256_SHIFT     UL(28)
   lib/smc/include/smc-rmi.h:#define RMI_FEATURE_REGISTER_0_HASH_SHA_512_SHIFT     UL(29)

Due to the inconsistent definitions, I'm unable to start a guest with the following
combination: linux-host/cca-host/v4, linux-guest/cca-guest/v5, kvmtool/cca/v2.

   # ./start_guest.sh
   Info: # lkvm run -k Image -m 256 -c 2 --name guest-152
   [  145.894085] config_realm_hash_algo: unsupported ALGO_SHA256 by rmm_feat_reg0=0x0000000034488e30
   KVM_CAP_RME(KVM_CAP_ARM_RME_CONFIG_REALM) hash_algo: Invalid argument

Thanks,
Gavin


