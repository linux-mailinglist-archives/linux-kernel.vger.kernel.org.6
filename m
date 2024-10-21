Return-Path: <linux-kernel+bounces-373579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3F9A590F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31A6282502
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775AD42A8F;
	Mon, 21 Oct 2024 02:59:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932BC17C98
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729479546; cv=none; b=SPES9sPyGtW/OYbtV/r9iAIc3HfKouODUhmxL3dr9VoEuqDiZkAqAjTTRxuuVDVwTzZOMfuxy/i9b2VdODLcpzZoTqxsbJnH8kOBa10c1XDpNur/tpVMGh6OFkGivgP94VVBPee8lzj7+tdUgXtMPCZnJZyF0nKpLTn5wlHDgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729479546; c=relaxed/simple;
	bh=cLyu+mKTxqfobb6QH/h5wv+B8ihfrTrDn0VVgG///as=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DVk9r+LHurlwrtbUn1OGzTvSqTVBa2vxQJEo5ia7iwbY1ppVe/zDOtfqove1DrvQctNqiRK+PQvYT23j2ZA8ehOQ6ab/d3uoeCF69wX6V3tII6O0tlAXrUq9lqsOjkoRFTtLGXnixSGJBjTzvVfNscZzTU1uB8/l6cgzkO7lWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B4AADA7;
	Sun, 20 Oct 2024 19:59:32 -0700 (PDT)
Received: from [10.162.16.109] (a077893.blr.arm.com [10.162.16.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 613C63F73B;
	Sun, 20 Oct 2024 19:59:00 -0700 (PDT)
Message-ID: <431e46b5-24f7-41f4-b321-70a6894c3831@arm.com>
Date: Mon, 21 Oct 2024 08:28:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] coresight: trbe: Fix return value check in
 arm_trbe_register_coresight_cpu()
To: Zhen Lei <thunder.leizhen@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241018140858.711-1-thunder.leizhen@huawei.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241018140858.711-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/18/24 19:38, Zhen Lei wrote:
> Function devm_kzalloc() returns NULL instead of ERR_PTR() when it fails.

Right, devm_kzalloc() calls devm_kmalloc() with additional __GFP_ZERO which
returns NULL on error.

> The IS_ERR() test in the return value check should be replaced with NULL
> test.
> 
> Fixes: 39744738a67d ("coresight: trbe: Allocate platform data per device")
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")

Actually this problem is caused by the following commit which had replaced
coresight_get_platform_data() with devm_kzalloc() for a dummy 'desc.pdata'
allocation. Earlier IS_ERR() test for the return value, was correct for
coresight_get_platform_data() which returns ERR_PTR() on error, but then
it should have been changed for devm_kzalloc() into a NULL check instead.

4277f035d227 ("coresight: trbe: Add a representative coresight_platform_data for TRBE")

Please add "Fixes:" tag for the above commit instead.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 96a32b213669940..93fe9860acf16bd 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1266,7 +1266,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>  	 * into the device for that purpose.
>  	 */
>  	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
> -	if (IS_ERR(desc.pdata))
> +	if (!desc.pdata)
>  		goto cpu_clear;
>  
>  	desc.type = CORESIGHT_DEV_TYPE_SINK;

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

