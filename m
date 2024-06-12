Return-Path: <linux-kernel+bounces-211689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0E90556E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF448281A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1A17E90B;
	Wed, 12 Jun 2024 14:41:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015FD17DE39
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203300; cv=none; b=Lc7A4yPjvK6/S7i4s0QR+z7EEevh45vBqb7VYQhnmB+4jQQC4flAaxeUwLVnSG75wfdKiPxkcZuzESnTYXUzG460QSvtwD261jXLoYlC837jCP+hKBVJK2tigQ75wLI5WqpOYJrGPE9PxV+FdS9RsnMea4qy1lOxEweoA9q46Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203300; c=relaxed/simple;
	bh=0siUzEVkYXXUYW3iE3IsxxtbWBH7AuYEgUlIWET3Ocg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4jUL1C9gPJ1xgvbAsz6dGyQZVc1Ik09zjRf62Nbt1o2TZ2SuJTgNS/r5bHKMIfESAbGRI72Q9JNWBeUuTm9XkKtyalENidBy/Z+ctN2gcBwnn9fsizPfjnhFIZ+s8NpoX/Bum1+1Qwemi29Sk6fiLNAC/Jdoyi6ETttVDfIW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB28F1042;
	Wed, 12 Jun 2024 07:42:02 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEDD13F64C;
	Wed, 12 Jun 2024 07:41:35 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:41:32 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>, maz@kernel.org,
	oliver.upton@linux.dev, qperret@google.com, qwandor@google.com,
	suzuki.poulose@arm.com, tabba@google.com, will@kernel.org,
	yuzenghui@huawei.com, lpieralisi@kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 4/4] KVM: arm64: Use FF-A 1.1 with pKVM
Message-ID: <ZmmznNcHDXDXpcyO@bogus>
References: <20240515172258.1680881-1-sebastianene@google.com>
 <20240515172258.1680881-5-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515172258.1680881-5-sebastianene@google.com>

On Wed, May 15, 2024 at 05:22:58PM +0000, Sebastian Ene wrote:
> Now that the layout of the structures is compatible with 1.1 it is time
> to probe the 1.1 version of the FF-A protocol inside the hypervisor. If
> the TEE doesn't support it, it should return the minimum supported
> version.
>

LGTM,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index f9664c4a348e..bdd70eb4114e 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -458,7 +458,7 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
>  	memcpy(buf, host_buffers.tx, fraglen);
>
>  	ep_mem_access = (void *)buf +
> -			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
> +			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
>  	offset = ep_mem_access->composite_off;
>  	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
>  		ret = FFA_RET_INVALID_PARAMETERS;
> @@ -537,7 +537,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
>  	fraglen = res->a2;
>
>  	ep_mem_access = (void *)buf +
> -			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
> +			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
>  	offset = ep_mem_access->composite_off;
>  	/*
>  	 * We can trust the SPMD to get this right, but let's at least
> @@ -846,7 +846,7 @@ int hyp_ffa_init(void *pages)
>  	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
>  		return 0;
>
> -	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_0, 0, 0, 0, 0, 0, 0, &res);
> +	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_1, 0, 0, 0, 0, 0, 0, &res);
>  	if (res.a0 == FFA_RET_NOT_SUPPORTED)
>  		return 0;
>
> @@ -866,7 +866,11 @@ int hyp_ffa_init(void *pages)
>  	if (FFA_MAJOR_VERSION(res.a0) != 1)
>  		return -EOPNOTSUPP;
>
> -	hyp_ffa_version = FFA_VERSION_1_0;
> +	if (FFA_MINOR_VERSION(res.a0) < FFA_MINOR_VERSION(FFA_VERSION_1_1))

It can be even <= instead of <, in that way else part is just handling
downgrading part and will be explicit. But that's just my taste and not
a must change as nothing changes with or without it.

--
Regards,
Sudeep

