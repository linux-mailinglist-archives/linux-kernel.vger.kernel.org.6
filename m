Return-Path: <linux-kernel+bounces-412758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F29D0EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD628276C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BF9198E99;
	Mon, 18 Nov 2024 10:34:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75491946A8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926086; cv=none; b=IxCLoydUJY49SVM5sE46ZS98kB02peEQDYzVi9uKUuupFdy1sYUmyp9o8ql/oVqg3840ICJgYLP8Ykbfw5k607vrliPy8CrgGkHO4qpdoV9F+UeuYpTPKurCQGYUllQVP/JhPzL0e28/xm82Rxh4/D4D6t0pvLWdiSv3TZ32X0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926086; c=relaxed/simple;
	bh=M0g1JGb2ojBKt6plFtfcHGWM3eXuSKNK2UgHx12TrcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwraO8CqT6ZxQJObLN6lnpscK9fDp+Twb95DvAXsTbxe6ZoAe21MPQxJnkdkrDa4DoAzjkmuobU2urbmMznjgA73rNr0XwT7jw5386pw6YaXle8j/YTr5GvkUOEtDIKYwSbreeEbLl1nbMDaydx6hlXRUMJFqTj8PS+x8uJ2Uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37DC7169C;
	Mon, 18 Nov 2024 02:35:13 -0800 (PST)
Received: from [10.57.67.249] (unknown [10.57.67.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B7B43F5A1;
	Mon, 18 Nov 2024 02:34:41 -0800 (PST)
Message-ID: <ea311a21-959d-4985-9364-7c85d256ab09@arm.com>
Date: Mon, 18 Nov 2024 10:34:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] coresight: etm4x: don't include 'pm_wakeup.h'
 directly
Content-Language: en-GB
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
 <20241118072917.3853-5-wsa+renesas@sang-engineering.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241118072917.3853-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/2024 07:29, Wolfram Sang wrote:
> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 66d44a404ad0..559972a00fdf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -23,7 +23,6 @@
>   #include <linux/cpu_pm.h>
>   #include <linux/coresight.h>
>   #include <linux/coresight-pmu.h>
> -#include <linux/pm_wakeup.h>
>   #include <linux/amba/bus.h>
>   #include <linux/seq_file.h>
>   #include <linux/uaccess.h>

If you plan to take this as a collection outside of CoreSight tree,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Otherwise, I can pick this up.


Suzuki

