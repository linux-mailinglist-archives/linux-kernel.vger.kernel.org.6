Return-Path: <linux-kernel+bounces-432653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9DA9E4E31
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74ABF1881402
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7C1AE003;
	Thu,  5 Dec 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qy3MfN4E"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC464195390;
	Thu,  5 Dec 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383518; cv=none; b=ByP7kc3YI9JVp8Fd/mA+UVjSXut2Iriw3/bkh27h2ZNiLF2dWMpco0W0spJ3OyR4YEtRr9JiQdWGlClFo40jv3Zm1wRtAyGt4jtJkKtccEKywV9oQzOcJ/XfcTMuozVFeonC33GmuJaUtvdrl1x19tHBrGyEuoDQMa1s/39LBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383518; c=relaxed/simple;
	bh=/LXRxopnEOPAEItYg+Qvrhl2jiO9odl5xOZjKSOPbCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIZh7NBLr7uAwkhOR30jA38BAaRxx1PnYIHzNkTZxAM7bxBHYs+rO87tTL22iZK9oa8cjGUOQLeV8YljN05ngPEnoMo9lWzwwEfNd4qc/eafwFUsS7RaklaiJMIYuHSCZvYvgbP/+mOgUTy4yb+Rj33ld2pbAPcdZBckrrtKvy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qy3MfN4E; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733383513; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OSN8erpeN2GDGeA9Hv5gtA/lq0S3TmHXSQSI0exTd6I=;
	b=qy3MfN4EoFUFlxPRTJyJddv5AS81OMH3UuhTS234XHDEGpAQEtZuBpLeV+UcfXxiy5n+RYFh/SlsyD7LOqi0kcCr1mYZL/PkOM0XmR7/HUwA9+8AMQRDzki5XlhggmIYwPb1T5Dy53up8jsKy7Mijvgt75P8l+nM9llIlbFwsHs=
Received: from 30.74.128.237(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WKsWQ5e_1733383511 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 15:25:12 +0800
Message-ID: <9fa8c4b3-1585-4f2c-84df-d61d8c5c8329@linux.alibaba.com>
Date: Thu, 5 Dec 2024 15:25:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/dwc_pcie: Fix the event numbers
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241205061914.5568-1-ilkka@os.amperecomputing.com>
 <20241205061914.5568-2-ilkka@os.amperecomputing.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241205061914.5568-2-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/5 14:19, Ilkka Koskinen 写道:
> According to Databook, L1 aux is event number 0x08 and
> TX L0s and RX L0S is 0x09. Fix the event numbers for the
> two events.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 9cbea9675e21..890cf3bb43a2 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -199,8 +199,8 @@ static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
>   	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_1, 0x05),
>   	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_2, 0x06),
>   	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(CFG_RCVRY, 0x07),
> -	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(TX_RX_L0S, 0x08),
> -	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_AUX, 0x09),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_AUX, 0x08),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(TX_RX_L0S, 0x09),
>   
>   	/* Group #1 */
>   	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(tx_pcie_tlp_data_payload, 0x20),

LGTM.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.

Best Regards,
Shuai

