Return-Path: <linux-kernel+bounces-263268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67993D37D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2471C2301E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087917BB0F;
	Fri, 26 Jul 2024 12:50:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53917B434
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998223; cv=none; b=EAGq94TdsR/+b0revTqzWAWBcHmlWo0pP1j6NiIqRlwj/fSLc10Xy4MFBqzYyrrcnZquY1nIJn7LVHk2uMCoFPzXpqE/fgnh+6Fif/oczT2lfKJ30osnjv9NL1O2n4gHcANoIMKoIwfy3lLkSDTkA4l2MRc+dnwaJ//aCwrzGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998223; c=relaxed/simple;
	bh=vbu5wmuE6kiLqfTheOJqcqpBoX82AomStFdgGqq+3ik=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOCotoGFrtr6GEAsqiUC+pJQ3nvuDU2/zlHwkcqMAbJkWiDMYpyg1G6vLgwu/gHhnXp3N8PyJU8TGYPSj5pdyhsolMHT6jkdWq/X6oW8iX0dEk/2MxQVA+M3kphwUeMFZEg92M5VaZ0GwzyssTRTQKLyWRDVLs6/dGys0oNQDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVnbk1YYmz6K5mp;
	Fri, 26 Jul 2024 20:48:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 82E13140B63;
	Fri, 26 Jul 2024 20:50:18 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 13:50:18 +0100
Date: Fri, 26 Jul 2024 13:50:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, Peter Maydell
	<peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 5/7] target/arm: preserve mpidr value
Message-ID: <20240726135017.00003cdb@Huawei.com>
In-Reply-To: <acdc77f8b53ed570aa7a59fdc83fb8ab5f79ca19.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<acdc77f8b53ed570aa7a59fdc83fb8ab5f79ca19.1721630625.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jul 2024 08:45:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There is a logic at helper to properly fill the mpidr information.
> This is needed for ARM Processor error injection, so store the
> value inside a cpu opaque value, to allow it to be used.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Seems reasonable to me, but not really my area of expertise.
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  target/arm/cpu.h    |  1 +
>  target/arm/helper.c | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
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
> index ce319572354a..2432b5b09607 100644
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


