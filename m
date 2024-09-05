Return-Path: <linux-kernel+bounces-316256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1048896CD1D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A81C21E18
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FED13CFB8;
	Thu,  5 Sep 2024 03:16:25 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754E2B9A8;
	Thu,  5 Sep 2024 03:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506185; cv=none; b=UBD/176MGLXQcWuY/2gPRUwWWqsWW2Fm4MGiMMKxMJqPQ5+OKqxcicnnFtzSdxdQpIjDdnUNOs6yBYJsqQP3Z6poBVgBA2ruyI6ajjDg712A5MHfGJuph/TZmRitiLmHbTzFCx39qA0oVCGHi6ypCxuYeYaTU2xs6mOprQdSYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506185; c=relaxed/simple;
	bh=+jIeBKrZyWvjOfMijD7iCJlICqgfNmV2HwI+cXbrejA=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I3U+rMe4d39sQNdB/qTnWcBpUWBkxftD0dPsaVlWq8DTHsvjFXfBx2HMzZZOB0FpnD1ZtqwHHe91lyLY93KhTEk8QOiKpLAmReX/1Zge8RNtpF8gL4vBfNYhkn2235jTi+7GYP7WT9QJTMeAWKtSRxDClrLMfZ8RCW6ayxOlkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wzky16KBWz146Yf;
	Thu,  5 Sep 2024 11:15:21 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D2D91800CF;
	Thu,  5 Sep 2024 11:16:20 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 5 Sep 2024 11:16:19 +0800
CC: <yangyicong@hisilicon.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] perf metrics: Fixes stat cmd cannot parse sys metrics
 when cpus MIDR mismatch
To: Junhao He <hejunhao3@huawei.com>, <irogers@google.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>
References: <20240807040002.47119-1-hejunhao3@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <00b3d618-628f-3366-7195-2300468eb450@huawei.com>
Date: Thu, 5 Sep 2024 11:16:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240807040002.47119-1-hejunhao3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/8/7 12:00, Junhao He wrote:
> On some platforms that do not use cpu MIDR mapping, such as hisilicon
> HIP09 platform. The list cmd can display the CPA metrics, but the stat
> cmd cannot work well to parse of CPA metrics.
> 
>   $ perf list metric
>   Metrics:
>     cpa_p0_avg_bw
>          [Average bandwidth of CPA Port 0]
>     cpa_p1_avg_bw
>          [Average bandwidth of CPA Port 1]
>   $ perf stat -M cpa_p0_avg_bw --timeout 1000 --> No error messages output
>   $ echo $?
>   234
> 
> Currently, the metricgroup__parse_groups() expects to find an cpu metric
> table, but the hisilicon/hip09 doesn't uses cpus MIDR to map json events
> and metrics, so pmu_metrics_table__find() will return NULL, than the cmd
> run failed.
> But in metricgroup__add_metric(), the function parse for each sys metric
> and add it to metric_list, which also will get an valid sys metric table.
> So, we can ignore the NULL result of pmu_metrics_table__find() and to use
> the sys metric table.
> 
> metricgroup__parse_groups
>  -> parse_groups
>      -> metricgroup__add_metric_list
>          -> metricgroup__add_metric
>              -> pmu_for_each_sys_metric   --> We've got the sys metric
> 
> Testing:
>   [root@localhost ~]# perf stat -M cpa_p0_avg_bw --no-merge --timeout 1000
> 
>    Performance counter stats for 'system wide':
> 
>    CPU0        1,001,121,239      cpa_cycles [hisi_sicl0_cpa0]     #     0.00 cpa_p0_avg_bw
>    CPU0                    0      cpa_p0_wr_dat [hisi_sicl0_cpa0]
>    CPU0                    0      cpa_p0_rd_dat_64b [hisi_sicl0_cpa0]
>    CPU0                    0      cpa_p0_rd_dat_32b [hisi_sicl0_cpa0]
>    CPU0        1,001,094,851      cpa_cycles [hisi_sicl2_cpa0]     #     0.00 cpa_p0_avg_bw
>    CPU0                    0      cpa_p0_wr_dat [hisi_sicl2_cpa0]
>    CPU0                    0      cpa_p0_rd_dat_64b [hisi_sicl2_cpa0]
>    CPU0                    0      cpa_p0_rd_dat_32b [hisi_sicl2_cpa0]
> 
>        1.001306160 seconds time elapsed
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

Tested-by: Yicong Yang <yangyicong@hisilicon.com>

The changes looks fine to me, I'd prefer to add some documents for this. See below.

> ---
>  tools/perf/util/metricgroup.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 69f6a46402c3..fa62fb3418b6 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1123,7 +1123,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
>  
>  	ret = add_metric(d->metric_list, pm, d->modifier, d->metric_no_group,
>  			 d->metric_no_threshold, d->user_requested_cpu_list,
> -			 d->system_wide, d->root_metric, d->visited, d->table);
> +			 d->system_wide, d->root_metric, d->visited, d->table ?: table);
>  	if (ret)
>  		goto out;
>  
> @@ -1239,7 +1239,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>  	int ret;
>  	bool has_match = false;
>  
> -	{
> +	if (table) {

may add a comment here. If !table then the metrics may belong to a system PMU.

>  		struct metricgroup__add_metric_data data = {
>  			.list = &list,
>  			.pmu = pmu,
> @@ -1696,8 +1696,6 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>  {
>  	const struct pmu_metrics_table *table = pmu_metrics_table__find();
>  
> -	if (!table)
> -		return -EINVAL;

may add a debug message to mention we're parsing metrics of system PMUs.

Thanks.

>  	if (hardware_aware_grouping)
>  		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
>  
> 

