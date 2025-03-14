Return-Path: <linux-kernel+bounces-561269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B21CA60F79
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FA87A7E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E91FCFDF;
	Fri, 14 Mar 2025 10:58:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA2C1F4175
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949893; cv=none; b=K4qm4szKpZMOztgbbZzBiZBjrJDCFo5hBP4Cr5HRP2qpmA1jPcI3sgmbAj7RFc7Sg6vwvFuE8Hi89g0IyGGmbrIatmKgKjtJRYvzWbdzd2V1jPctoZTmHbP2h0JhHYJmimSSLGacZ9yqM+fqxFbd52xMnBsN+6kvMGm3Edop9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949893; c=relaxed/simple;
	bh=cBb54nEWVFs0duxHFElWvMPXLySnL8gT+4m52nAo5CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFWhKKKqE4ywLhPNMef1edfcATBH/bKqlp3JhCN7d/FCS0SurTfY2CuovQmqmUKiEsStPycYOxHARJj/aUa8o3tRSOpRRCye6jgr8V+TZDoXQ6RCevEfGUlM1IeFiknXUX3JLbQ1DD4t6FDghOTzWq7BQ4TW9pUIxnSvIdlsa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36A61113E;
	Fri, 14 Mar 2025 03:58:21 -0700 (PDT)
Received: from [10.57.85.159] (unknown [10.57.85.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E15813F673;
	Fri, 14 Mar 2025 03:58:09 -0700 (PDT)
Message-ID: <36c70203-5203-44a1-bc08-479334b730c7@arm.com>
Date: Fri, 14 Mar 2025 10:58:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH 2/6] arm64: cpufeature: add AmpereOne to BBML2 allow
 list
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
 <20250304222018.615808-3-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250304222018.615808-3-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 22:19, Yang Shi wrote:
> AmpereOne supports BBML2 without conflict abort, add to the allow list.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 7934c6dd493e..bf3df8407ca3 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2192,6 +2192,8 @@ static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
>  	static const struct midr_range supports_bbml2_noabort_list[] = {
>  		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>  		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>  		{}
>  	};
>  

Miko's series will move back to additionally checking MMFR2.BBM, so you will
need to add an erratum workaround for these CPUs to set MMFR2.BBM=2 in the
per-cpu "sanitised" feature register. See:

https://lore.kernel.org/linux-arm-kernel/86ecyzorb7.wl-maz@kernel.org/

Thanks,
Ryan


