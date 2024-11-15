Return-Path: <linux-kernel+bounces-410201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C19CD635
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB74AB236BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5716F851;
	Fri, 15 Nov 2024 04:25:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094412C80
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731644749; cv=none; b=tTuSRftRh0FdRcArM0Y6CARm6XImRZKxTT/41da6j6fCGeaoeRYhDXP8/3CNEcBMOQjZNpMqP+9gWeqd257vU5U1P+h1k+hA7FjlFcdzygzbpq8JbWYFlZlija391O7S97P1xthloH9y7iPey0Rv26tj8Wy85kQ9FEPgJnYns7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731644749; c=relaxed/simple;
	bh=QZ1wWgOgt/zvn0VGyh8mGWo9Vj5c6oNbN1JYI8LoDTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faGZDXYFe9ngnpwoJZxamHnyYFB5PA4gQnMwmmTnfGCoW63h/Xuq1Kvl6M9Rg//CU8HmI02SQcJlY5nYjdYpt6ZFBLztpcdDlLKSaHhJSBuu/yxISG/3+RM1qV7W0U4pa/PofAPL4taREAt3/m7kNTPkDPQ+Z7NjCzUv6LcWQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB66315BF;
	Thu, 14 Nov 2024 20:26:14 -0800 (PST)
Received: from [10.163.45.151] (unknown [10.163.45.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9651C3F66E;
	Thu, 14 Nov 2024 20:25:40 -0800 (PST)
Message-ID: <5e836e52-bc10-462b-b819-f3e4d33bf876@arm.com>
Date: Fri, 15 Nov 2024 09:55:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Refactor conditional logic
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 will@kernel.org, broonie@kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joey Gouly <joey.gouly@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241114142333.18210-1-hardevsinh.palaniya@siliconsignals.io>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241114142333.18210-1-hardevsinh.palaniya@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A small nit.

The subject line could have been more specific to where this
change applies (example below), otherwise it is too broad in
the entire arm64 platform context.

arm64/cpufeature: Refactor conditional logic in init_cpu_ftr_reg()

On 11/14/24 19:52, Hardevsinh Palaniya wrote:
> Unnecessarily checks ftr_ovr == tmp in an extra else if, which is not
> needed because that condition would already be true by default if the
> previous conditions are not satisfied.
> 
> 		if (ftr_ovr != tmp) {
> 		} else if (ftr_new != tmp) {
> 		} else if (ftr_ovr == tmp) {
> 
> Logic: The first and last conditions are inverses of each other, so 
> the last condition must be true if the first two conditions are false.
> 
> Additionally, all branches set the variable str, making the subsequent
> "if (str)" check redundant
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---
> 
> Changelog in V2:
> 
> - remove str check 
> 
> Change in V3:
> 
> - Add logic in commit msg 
> - Add review tag
> ---
>  arch/arm64/kernel/cpufeature.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 718728a85430..728709483fb7 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -989,17 +989,16 @@ static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  				/* Override was valid */
>  				ftr_new = tmp;
>  				str = "forced";
> -			} else if (ftr_ovr == tmp) {
> +			} else {
>  				/* Override was the safe value */
>  				str = "already set";
>  			}
>  
> -			if (str)
> -				pr_warn("%s[%d:%d]: %s to %llx\n",
> -					reg->name,
> -					ftrp->shift + ftrp->width - 1,
> -					ftrp->shift, str,
> -					tmp & (BIT(ftrp->width) - 1));
> +			pr_warn("%s[%d:%d]: %s to %llx\n",
> +				reg->name,
> +				ftrp->shift + ftrp->width - 1,
> +				ftrp->shift, str,
> +				tmp & (BIT(ftrp->width) - 1));
>  		} else if ((ftr_mask & reg->override->val) == ftr_mask) {
>  			reg->override->val &= ~ftr_mask;
>  			pr_warn("%s[%d:%d]: impossible override, ignored\n",

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

