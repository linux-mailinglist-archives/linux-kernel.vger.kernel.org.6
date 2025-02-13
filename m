Return-Path: <linux-kernel+bounces-512799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E48A33DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04713A6B22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2F3227E88;
	Thu, 13 Feb 2025 11:23:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BEF227E89
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445794; cv=none; b=eImqGty64PJ3AaRYCro7FiYg8L/VlEmWtRPY77Gk8z4Kwt68nAMn+6lKRFqcf0AiyJ+zKHrzQyFbtIUK4/Qe4Z+inP13R/bQMojO8gCuds/STlNUW8959XRDwaQvvdRRW5noTK2fH3QK3R8aidnnpUHyYmbh/h+MtlAs0qMaH8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445794; c=relaxed/simple;
	bh=pGicAIPIJ5udsEWbeRQ3aV2sMqKEdKQgtTwF1JXboRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByrpbDJim0mPbkTKYaOnJU6AEyXbCxwpE4e7/g4F4IoaVNeB0xw5JZuz8XsMfBxOMGaw4ujjBP/9TjkSrtuiZjAgWFI+9MiLmHfybLKKebsN9VmY/kdXuX8P2/K0+yBnYVu/bmtcv0TioiMSBWXnb57pYo2kdL4C0GyauvS0VvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2DF726A4;
	Thu, 13 Feb 2025 03:23:32 -0800 (PST)
Received: from [10.1.32.44] (e122027.cambridge.arm.com [10.1.32.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CA3D3F6A8;
	Thu, 13 Feb 2025 03:23:10 -0800 (PST)
Message-ID: <0141324f-19e9-4e40-9500-df3bc140f2d0@arm.com>
Date: Thu, 13 Feb 2025 11:23:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm: Make DEBUG_WX depdendent on GENERIC_PTDUMP
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: christophe.leroy@csgroup.eu, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-3-anshuman.khandual@arm.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20250213040934.3245750-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 04:09, Anshuman Khandual wrote:
> DEBUG_WX selects PTDUMP_CORE without even ensuring that the given platform
> implements GENERIC_PTDUMP. This problem has been latent until now, as all
> the platforms subscribing ARCH_HAS_DEBUG_WX also subscribe GENERIC_PTDUMP.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  mm/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 41a58536531d..a51a1149909a 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -186,6 +186,7 @@ config ARCH_HAS_DEBUG_WX
>  config DEBUG_WX
>  	bool "Warn on W+X mappings at boot"
>  	depends on ARCH_HAS_DEBUG_WX
> +	depends on GENERIC_PTDUMP
>  	depends on MMU
>  	select PTDUMP_CORE
>  	help


