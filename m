Return-Path: <linux-kernel+bounces-430933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430629E3760
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B0F284FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5B1AE861;
	Wed,  4 Dec 2024 10:21:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D340618595B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307682; cv=none; b=LUF0FFrZuEQg68zbQJhEzkuDEhjv6JUdTC6SFD11RSdkmHs2dIoenQ/WYtTAE1ZeUsBcMEzunOrGKQItRud4nqGnqE3H8E0qVrA5bzSIq47JNIf6heBj6J64UVjH9h6A7vF/DqFwQ5Jhfp0ldTE9hhXJZ1vNluhwqmuAe7UbaMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307682; c=relaxed/simple;
	bh=LThP/7xnnYd2sBt6d+u03dXcoOpH7gTkDJ6tKMJa6Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqNrbbvHCwRCekiLNwYC5ltbEeaCQ9m2qufWmczNK8SKYuWn2vMBV0BE3qCYLyvBvSRj1gdA5s93f3qELWAT9uJKVyOn4oQs6ZxrIgdKw9k9sYtW5r6EDnY2fvVHQE01aL3IQzzk4Og280M9W23FSzI/V8OOk5ZOqKvuv7xo73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 523A01063;
	Wed,  4 Dec 2024 02:21:41 -0800 (PST)
Received: from [10.57.68.118] (unknown [10.57.68.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 267EC3F5A1;
	Wed,  4 Dec 2024 02:21:12 -0800 (PST)
Message-ID: <7860c682-f6a8-4b97-86bc-c5e706a7bb34@arm.com>
Date: Wed, 4 Dec 2024 10:21:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight-etm4x: add isb() before reading the TRCSTATR
Content-Language: en-GB
To: yuanfang zhang <quic_yuanfang@quicinc.com>, mike.leach@linaro.org,
 james.clark@linaro.org, alexander.shishkin@linux.intel.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241204101320.3692167-1-quic_yuanfang@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241204101320.3692167-1-quic_yuanfang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi


On 04/12/2024 10:13, yuanfang zhang wrote:
> From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> 
> As recommended by section 4.3.7 ("Synchronization when using system
> instructions to progrom the trace unit") of ARM IHI 0064H.b, the
> self-hosted trace analyzer must perform a Context synchronization
> event between writing to the TRCPRGCTLR and reading the TRCSTATR.
> 

Thanks for the patch. Please could you add the above in a comment
in the changes below ?

Also, add Fixes tag ? (It may go all the way back to initial support)

Otherwise looks sensible to me.

Suzuki

> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 66d44a404ad0..5da2c523c30a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -906,6 +906,7 @@ static void etm4_disable_hw(void *info)
>   	tsb_csync();
>   	etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
>   
> +	isb();
>   	/* wait for TRCSTATR.PMSTABLE to go to '1' */
>   	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
>   		dev_err(etm_dev,


