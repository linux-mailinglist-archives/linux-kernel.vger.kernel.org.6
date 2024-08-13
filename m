Return-Path: <linux-kernel+bounces-285378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDC2950CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10832815E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C63F19EEA2;
	Tue, 13 Aug 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTUawf91"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084F1A3BBD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575709; cv=none; b=cmOcOggFe4J8C6BkaMtBPGhHDHxKaySJ1J9oRXWfZYQyOMMVLsxF8c4yGD3P9zupDtGvgpyXPBgUmLnwtiYkaLf3rnkLSAsvLbo7Fdaz2KQU71zzZEAl5so/7d64uyXBazG1R9L3RiH3ZKI51cvPt7TTnymSjdT2CiE2p626bwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575709; c=relaxed/simple;
	bh=8EtjMhM2U1teepjliO2vNVFsTuA++Qo7Vih8/F79ILM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqxPezSoIiMxDbvPHStbTjS5C1Jg+HLfCAMkkoZo8FHH4T7M4DPTIjg7S/eTK6NzXtqrERygfk7eDQ041WBUwAJLVPxTsoSBD9nThVoCA1pfFLLRnssX+cAu0Ycx8rMauXplJkvSnzZxDt4GxO/wL6PMuNHTzjWgL/XXLRkVB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTUawf91; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723575706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69IESAqRf0OchHa21rgZCmxwZzdZyLUPDypH3+X6lMI=;
	b=hTUawf91Xmhw9pSI/y3Fjp8NM+y4kRG+OwSWxr9ouvGM+sLOTlHNkbm8kmlA4Lpv5a2pFx
	UXuLf715BdkQDjEBIgOUGzeoonV6V9NIlnIPAnnhxat7rVAGP7dDvs+NaY41BG3A36yP2n
	akbqZWhX0LgUBQVZagiLG3DyGeytSsU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-wRHYbsfVP2SbPK1KOYZPug-1; Tue,
 13 Aug 2024 15:01:42 -0400
X-MC-Unique: wRHYbsfVP2SbPK1KOYZPug-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 202EA18EA8EB;
	Tue, 13 Aug 2024 19:01:40 +0000 (UTC)
Received: from [10.2.16.208] (unknown [10.2.16.208])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BE2419560A3;
	Tue, 13 Aug 2024 19:01:37 +0000 (UTC)
Message-ID: <183ee6fa-1d42-4a01-8446-4f20942680d2@redhat.com>
Date: Tue, 13 Aug 2024 15:01:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Avoid memory barrier in read_seqcount() through load
 acquire
To: cl@gentwo.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 8/13/24 14:26, Christoph Lameter via B4 Relay wrote:
> From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
>
> Some architectures support load acquire which can save us a memory
> barrier and save some cycles.
>
> A typical sequence
>
> 	do {
> 		seq = read_seqcount_begin(&s);
> 		<something>
> 	} while (read_seqcount_retry(&s, seq);
>
> requires 13 cycles on ARM64 for an empty loop. Two read memory barriers are
> needed. One for each of the seqcount_* functions.
>
> We can replace the first read barrier with a load acquire of
> the seqcount which saves us one barrier.
>
> On ARM64 doing so reduces the cycle count from 13 to 8.
>
> Signed-off-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> ---
>   arch/Kconfig            |  5 +++++
>   arch/arm64/Kconfig      |  1 +
>   include/linux/seqlock.h | 41 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 47 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..3f8867110a57 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1600,6 +1600,11 @@ config ARCH_HAS_KERNEL_FPU_SUPPORT
>   	  Architectures that select this option can run floating-point code in
>   	  the kernel, as described in Documentation/core-api/floating-point.rst.
>   
> +config ARCH_HAS_ACQUIRE_RELEASE
> +	bool
> +	help
> +	  Architectures that support acquire / release can avoid memory fences
> +
>   source "kernel/gcov/Kconfig"
>   
>   source "scripts/gcc-plugins/Kconfig"
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2f8ff354ca6..19e34fff145f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -39,6 +39,7 @@ config ARM64
>   	select ARCH_HAS_PTE_DEVMAP
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_HW_PTE_YOUNG
> +	select ARCH_HAS_ACQUIRE_RELEASE
>   	select ARCH_HAS_SETUP_DMA_OPS
>   	select ARCH_HAS_SET_DIRECT_MAP
>   	select ARCH_HAS_SET_MEMORY

Do we need a new ARCH flag? I believe barrier APIs like 
smp_load_acquire() will use the full barrier for those arch'es that 
don't define their own smp_load_acquire().

BTW, acquire/release can be considered memory barriers too. Maybe you 
are talking about preferring acquire/release barriers over read/write 
barriers. Right?

Cheers,
Longman


