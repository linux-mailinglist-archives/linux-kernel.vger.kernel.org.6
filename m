Return-Path: <linux-kernel+bounces-543780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25751A4D9D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2883C1897A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA51FCFDB;
	Tue,  4 Mar 2025 10:12:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3806225D6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083119; cv=none; b=nvGNJYH8L2mnDvBzqxn5vdPfkNrFKnsTwlYsIU7uTiudmfzjZCee3yRJtfgUx/QXdP6E4CK8y1vnp1XPj/JHDSCN1nyPO59szFbZutEf7O8eXYbAhm3mlxxm0DVIkNk2S11qTYF8GRQISFRegiziQeraGdzN61Ar5+O5c+kXCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083119; c=relaxed/simple;
	bh=1K2Z5TXNwJtGVBmeIdq1OM4WbcNKBN481sukzVQQoCc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpMOMvzV/yeU+r1sEDaEKXOWq+jN6wXHRovwWnb9TPgRcBIygwsXfSyu1MZroxWG7nfGvCeqshY+zz5Ecij4oXrTHZ0xFzdInzY27ZrMRKxM5zMe6jazRk6bDhygjWSzciL2ezU0KTNasvZG6QJbyjxo6HxIUROk5S2wEjvH7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6Wd1111qz6D8xW;
	Tue,  4 Mar 2025 18:09:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A3AF140D1D;
	Tue,  4 Mar 2025 18:11:53 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 11:11:50 +0100
Date: Tue, 4 Mar 2025 18:11:46 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH 6/9] drivers/perf: hisi: Relax the event number check of
 v2 PMUs
Message-ID: <20250304181146.000042b3@huawei.com>
In-Reply-To: <20250218092000.41641-7-yangyicong@huawei.com>
References: <20250218092000.41641-1-yangyicong@huawei.com>
	<20250218092000.41641-7-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 17:19:57 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> The supported event number range of each Uncore PMUs is provided by
> each driver in hisi_pmu::check_event and out of range events
> will be rejected. A later version with expanded event number range
> needs to register the PMU with updated hisi_pmu::check_event
> even if it's the only update, which means the expanded events
> cannot be used unless the driver's updated. However the unsupported
> events won't be counted by the hardware so we can relax the event
> number check to allow the use the expanded events.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 2 +-
>  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 7 +++----
>  drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 2 +-
>  drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 3 +--
>  4 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> index 26eaa6d20c00..21c494881ca0 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> @@ -53,7 +53,7 @@
>  #define DDRC_V1_PERF_CTRL_EN	0x2
>  #define DDRC_V2_PERF_CTRL_EN	0x1
>  #define DDRC_V1_NR_EVENTS	0x7
> -#define DDRC_V2_NR_EVENTS	0x90
> +#define DDRC_V2_NR_EVENTS	0xFF
>  
>  #define DDRC_EVENT_CNTn(base, n)	((base) + (n) * 8)
>  #define DDRC_EVENT_TYPEn(base, n)	((base) + (n) * 4)
> diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> index ca609db86046..78cd6d67f209 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> @@ -47,9 +47,8 @@
>  #define HHA_SRCID_CMD		GENMASK(16, 6)
>  #define HHA_SRCID_MSK		GENMASK(30, 20)
>  #define HHA_DATSRC_SKT_EN	BIT(23)
> -#define HHA_EVTYPE_NONE		0xff
> +#define HHA_EVTYPE_MASK		GENMASK(7, 0)
Using something called mask in places where we previously
had something called nr_events seems a little odd.

renaming EVTYPE_NONE to EVTYPE_MASK seems valid given the
useage but I'd have a different define for the number
of events and not make both changes in one patch.

>  #define HHA_V1_NR_EVENT		0x65
> -#define HHA_V2_NR_EVENT		0xCE
>  
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_cmd, config1, 10, 0);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_msk, config1, 21, 11);
> @@ -197,7 +196,7 @@ static void hisi_hha_pmu_write_evtype(struct hisi_pmu *hha_pmu, int idx,
>  
>  	/* Write event code to HHA_EVENT_TYPEx register */
>  	val = readl(hha_pmu->base + reg);
> -	val &= ~(HHA_EVTYPE_NONE << shift);
> +	val &= ~(HHA_EVTYPE_MASK << shift);
>  	val |= (type << shift);
>  	writel(val, hha_pmu->base + reg);
>  }
> @@ -453,7 +452,7 @@ static int hisi_hha_pmu_dev_probe(struct platform_device *pdev,
>  
>  	if (hha_pmu->identifier >= HISI_PMU_V2) {
>  		hha_pmu->counter_bits = 64;
> -		hha_pmu->check_event = HHA_V2_NR_EVENT;
> +		hha_pmu->check_event = HHA_EVTYPE_MASK;
To me this makes little sense.  Should be HHA_MAX_NR_EVENT
or something like that.

>  		hha_pmu->pmu_events.attr_groups = hisi_hha_pmu_v2_attr_groups;
>  		hha_pmu->num_counters = HHA_V2_NR_COUNTERS;
>  	} else {

Jonathan

