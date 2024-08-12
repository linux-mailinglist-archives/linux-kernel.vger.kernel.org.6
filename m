Return-Path: <linux-kernel+bounces-283044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA06394EC42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AFB1F227B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B1716BE2C;
	Mon, 12 Aug 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+9XbGfT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86F178365
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464143; cv=none; b=PST2XbehiKlkaln3QAOcSjbFql+PaAWOYuJPZwsmKgqeFziktUkvIHmd4lKcsnQCdf8RydI4PmRofBlAorG2HLj4LZUTr/tyV/jGASolhvJGC2fgjqWIKYtOHmKpLWD/QSKRGTnhJmTwhwlaUszaHWkC0rViXyZs20341sgKttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464143; c=relaxed/simple;
	bh=8H4HAPFbq/32ABjpdJmGYlbmMPVl2XZE/fhNuFn6Pac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niNH+YUU5ixvkae/sfpfYv2Gos99WgIJysonI1zC55fws1/SHE+65a7lIgUpE6h8qfd46krGpbtOUXpKp3D7ZmIcwevTyLM7C/5ADZWhGIJGA6nKsLLxwno/fk6Jx0knNBRMvfWdyJ6Zchfry+Kl80SlAoc+8Qf3qehfyct3m6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+9XbGfT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723464140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+65iu01NPIv7uWIeGGoac4SWkRO5zqtd9iaInoLAGw=;
	b=Y+9XbGfTniB1N/G1DqYtxrdBY9oE2+6a0hc+rpcECpDngUVkCyVsLwzpLvpTcErKjCvRSA
	X9DITCYrJblcAIhx9W4wSa/ykVxS2YdiIY9kWxBYIPiwAvzmak0eO/C9xMuKqHcS8yf7ZG
	d2ZyVMadPNwOBJql/sYh4Dfqos0F7Cc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-UP4YKnsDO-2dExx32TmH8w-1; Mon, 12 Aug 2024 08:02:17 -0400
X-MC-Unique: UP4YKnsDO-2dExx32TmH8w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso35276995e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723464136; x=1724068936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+65iu01NPIv7uWIeGGoac4SWkRO5zqtd9iaInoLAGw=;
        b=uH16rVdFTYOSI6naZvqNwbijfHfH9auCO6PLBvykc4ySB1/kLiL3LdgqjwW+Gjn61t
         cydZMdYDw5Dma2ELkydZ9ui4mhkkSqLb3IxTB28RHTh/fpJGFLSkA+YunmC6dwKFeDlL
         YICCTj372EOXWqTWjl0eiG/YbkcS4Q/wAR5osrRlBIyyCP2x4lj3VcDcIfmHKE7f1QXp
         VVSoyXG5PhikVSEF1usgzJUAgkQJIqYoPUsgXLSB7wDYg2pWONIBx8AkmYAxEinALCnz
         J13oeBHNFyq403uwPTLGZADHuHjWHEk4tmyITv9a2XeW8PSStgRLj7K8DabOCJr9JkMs
         hTJg==
X-Forwarded-Encrypted: i=1; AJvYcCW/+6eJpTER4+0TcUQJTLrDnR+zpI546ymwZO0GApPqBv8anPwjb9CCJNCCC/s89I9wRS3fr4gcviJLlnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygvFaize+tYhFRGWV5WzXMbsgcs0s07esqwxSJwbm2kdWrsvwl
	rYuZ7icutyg0/mGvCqH6L9eQBZs0gZq2xSrXMFMAHRwZF4dLTpIxLjGayW6uQf9imA5j6DRxa/y
	fXyo/hquGd3CJs1rVR4HcDflvQu9DRj+MlcLVFcZsn3NBz5i/CnR5cF9giRwpug==
X-Received: by 2002:a05:600c:354b:b0:426:6eb9:db07 with SMTP id 5b1f17b1804b1-429d4806c91mr1293385e9.13.1723464136429;
        Mon, 12 Aug 2024 05:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPKds0KQDqWQo7B86uduTnRYkpzEfbrS1jfTZcY8d0bGzXJK/SZcSeNZ7Myq5znt6/xAnuTA==
X-Received: by 2002:a05:600c:354b:b0:426:6eb9:db07 with SMTP id 5b1f17b1804b1-429d4806c91mr1293155e9.13.1723464135879;
        Mon, 12 Aug 2024 05:02:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750e57fsm99660975e9.12.2024.08.12.05.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:02:15 -0700 (PDT)
Date: Mon, 12 Aug 2024 14:02:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Peter Maydell <peter.maydell@linaro.org>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 09/10] target/arm: add an experimental mpidr arm cpu
 property object
Message-ID: <20240812140214.408158b9@imammedo.users.ipa.redhat.com>
In-Reply-To: <a60316927a84748517209a741bf904a802827b8e.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
	<a60316927a84748517209a741bf904a802827b8e.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 14:26:35 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Accurately injecting an ARM Processor error ACPI/APEI GHES
> error record requires the value of the ARM Multiprocessor
> Affinity Register (mpidr).
> 
> While ARM implements it, this is currently not visible.
> 
> Add a field at CPU storing it, and place it at arm_cpu_properties
> as experimental, thus allowing it to be queried via QMP using
> qom-get function.

looks fine to me, but it's upto ARM folk to ack this

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  target/arm/cpu.c    |  1 +
>  target/arm/cpu.h    |  1 +
>  target/arm/helper.c | 10 ++++++++--
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 19191c239181..30fcf0a10f46 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2619,6 +2619,7 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
>  
>  static Property arm_cpu_properties[] = {
>      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
> +    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
>      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>                          mp_affinity, ARM64_AFFINITY_INVALID),
>      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a12859fc5335..d2e86f0877cc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1033,6 +1033,7 @@ struct ArchCPU {
>          uint64_t reset_pmcr_el0;
>      } isar;
>      uint64_t midr;
> +    uint64_t mpidr;
>      uint32_t revidr;
>      uint32_t reset_fpsid;
>      uint64_t ctr;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8fb4b474e83f..16e75b7c5ed9 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4692,7 +4692,7 @@ static uint64_t mpidr_read_val(CPUARMState *env)
>      return mpidr;
>  }
>  
> -static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +static uint64_t mpidr_read(CPUARMState *env)
>  {
>      unsigned int cur_el = arm_current_el(env);
>  
> @@ -4702,6 +4702,11 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      return mpidr_read_val(env);
>  }
>  
> +static uint64_t mpidr_read_ri(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return mpidr_read(env);
> +}
> +
>  static const ARMCPRegInfo lpae_cp_reginfo[] = {
>      /* NOP AMAIR0/1 */
>      { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
> @@ -9723,7 +9728,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name = "MPIDR_EL1", .state = ARM_CP_STATE_BOTH,
>                .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
>                .fgt = FGT_MPIDR_EL1,
> -              .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
> +              .access = PL1_R, .readfn = mpidr_read_ri, .type = ARM_CP_NO_RAW },
>          };
>  #ifdef CONFIG_USER_ONLY
>          static const ARMCPRegUserSpaceInfo mpidr_user_cp_reginfo[] = {
> @@ -9733,6 +9738,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          modify_arm_cp_regs(mpidr_cp_reginfo, mpidr_user_cp_reginfo);
>  #endif
>          define_arm_cp_regs(cpu, mpidr_cp_reginfo);
> +        cpu->mpidr = mpidr_read(env);
>      }
>  
>      if (arm_feature(env, ARM_FEATURE_AUXCR)) {


