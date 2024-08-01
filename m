Return-Path: <linux-kernel+bounces-271150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D381944A29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F31C217C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0610F189BA7;
	Thu,  1 Aug 2024 11:11:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051E189536
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510681; cv=none; b=VwNW+vqVR8VWmWlV15fqAITEMecqgfCPcorMXZLWJYLxCxyRZNw9klNpyrhs68Tsfy435FJ7ZyVftpym+iVK6kgKvYvpZo67DTuG651F0AwSu6s4b4YFvHiKGvWAQzfwCguEvMju27qSBT2J9/tbJHKdsVfs7Yv7VertmSSUYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510681; c=relaxed/simple;
	bh=EZ9EsVhvdR0LXKDsUdxVje+GuBZs2xzlNDYWIEaTzys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1YMlCfIAhtfjBh4luC6zwm9F0gJ6RULFJ1jn8qmKbPremL/Ta75ocynet9cJjkAbBScin7UAcXqdkUGG4wCSTO8rz8lBCZXBx4+zLuxefYmvRct8Ws4UpsoyIzscqDLCt315rmsVShPoyrpica1cNMeyj2lAGPXT7BjXibquz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5770915A1;
	Thu,  1 Aug 2024 04:11:45 -0700 (PDT)
Received: from [10.163.56.112] (unknown [10.163.56.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCD8F3F5A1;
	Thu,  1 Aug 2024 04:11:17 -0700 (PDT)
Message-ID: <efea6d1d-afee-4e80-94d0-1ca99f9dc9c2@arm.com>
Date: Thu, 1 Aug 2024 16:41:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_pmu: Use of_property_present()
To: "Rob Herring (Arm)" <robh@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240731191312.1710417-15-robh@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240731191312.1710417-15-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/24 00:42, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/perf/arm_pmu_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 4b1a9a92ea11..118170a5cede 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -59,7 +59,7 @@ static int pmu_parse_percpu_irq(struct arm_pmu *pmu, int irq)
>  
>  static bool pmu_has_irq_affinity(struct device_node *node)
>  {
> -	return !!of_find_property(node, "interrupt-affinity", NULL);
> +	return of_property_present(node, "interrupt-affinity");
>  }
>  
>  static int pmu_parse_irq_affinity(struct device *dev, int i)

After this change there are no of_find_property() instances left
in the drivers/perf directory.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

