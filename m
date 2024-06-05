Return-Path: <linux-kernel+bounces-202888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ADB8FD280
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D5EB239C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C0188CA3;
	Wed,  5 Jun 2024 16:09:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF0327450;
	Wed,  5 Jun 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603762; cv=none; b=Bm71ybfWfDLjRc3W3vpdSI83W68NuRQEPkwPigmfy2yd0nBVpF5vcNpQMmVH+e87mkjmUFKL3kI2I1f0/7tXwiB9TzzVlfj636VnpPuZr3QWuFdzejBHH6l0pElsyrrznHnDqUmZMl8rl8n4U6a+kNtfZHay5ideEDr+uXZSSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603762; c=relaxed/simple;
	bh=eBkn4utFAH7OSlBC/g1EBgVWMbx38sXX+1z4qb9G5KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZoLg54y4Zxf0MFEBcju/7jMRd6DUTeb5aahFvmho5fIyIW1RbDseKQQuWQsptiIea+KOmw3P1X1bd2Qg4mqSgEEf23xox3D2e11DTGV8P2x18ZDJM2GWLjx2PmNO5S5/OogDBLPRikUhp59OQsb2PVOI2CQ/XA1X5w65S4yR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E81F8339;
	Wed,  5 Jun 2024 09:09:43 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16D333F64C;
	Wed,  5 Jun 2024 09:09:17 -0700 (PDT)
Message-ID: <739d24fc-b557-4ef9-875d-d1a800f6c4db@arm.com>
Date: Wed, 5 Jun 2024 17:09:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/7] coresight: core: Add provision for panic callbacks
To: Linu Cherian <lcherian@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 suzuki.poulose@arm.com, mike.leach@linaro.org
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-4-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240605081725.622953-4-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/06/2024 09:17, Linu Cherian wrote:
> Panic callback handlers allows coresight device drivers to sync
> relevant trace data and trace metadata to reserved memory
> regions so that they can be retrieved later in the subsequent
> boot or in the crashdump kernel.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
> Changelog from v8:
> Added Reviewed-by tag.
> 
>  drivers/hwtracing/coresight/coresight-core.c | 37 ++++++++++++++++++++
>  include/linux/coresight.h                    | 12 +++++++
>  2 files changed, 49 insertions(+)
> 

[...]

>  static int __init coresight_init(void)
>  {
>  	int ret;
> @@ -1377,6 +1408,10 @@ static int __init coresight_init(void)
>  	if (ret)
>  		goto exit_bus_unregister;
>  
> +	/* Register function to be called for panic */
> +	ret = atomic_notifier_chain_register(&panic_notifier_list,
> +					     &coresight_notifier);
> +

ret isn't checked here

