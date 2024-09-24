Return-Path: <linux-kernel+bounces-337405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D898499E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318F4B23A78
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD01AB6E9;
	Tue, 24 Sep 2024 16:29:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854601B85D2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195340; cv=none; b=SAE5tizZ+HQf8PWKduCA265wDI5gf5nndTl9NP7ZjKfufcjW9CKZ9161vxtc6TjA8cHjepiL7Hrm3f/hGdM3CgaQQKqTv07LBaGQjz8GRMD1WlPXk9k5cOUWDjFu7wsbuUYI3fr7HQZzzx/ZHs30atQGzB28gCYw098jKMDjBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195340; c=relaxed/simple;
	bh=0EJ4H0VGxNnTz37z2THiHhAONQCTq6KAKm8c2hv4+4M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrsA5S1IDrtXzhPW2MAjepBV7zrygcbjHdkuFAxrRSHXhAjNI6bbuURd6To2AR0zGHh8Xxi9krwjkWgnr3ggP78ji8bY88XxNLzKwPSInuWOQXWG3ihrbs5oj7OYmo8Q6nwnVZPGQ742p29lbvmLUXknJhz1hJpYt6jNdUOAERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XClYc2X8Bz6K5rf;
	Wed, 25 Sep 2024 00:24:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AED01401F3;
	Wed, 25 Sep 2024 00:28:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 18:28:54 +0200
Date: Tue, 24 Sep 2024 17:28:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v8 4/6] perf/marvell: Odyssey DDR Performance monitor
 support
Message-ID: <20240924172853.0000647e@Huawei.com>
In-Reply-To: <20240919074717.3276854-5-gthiagarajan@marvell.com>
References: <20240919074717.3276854-1-gthiagarajan@marvell.com>
	<20240919074717.3276854-5-gthiagarajan@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Sep 2024 13:17:15 +0530
Gowthami Thiagarajan <gthiagarajan@marvell.com> wrote:

> Odyssey DRAM Subsystem supports eight counters for monitoring performance
> and software can program those counters to monitor any of the defined
> performance events. Supported performance events include those counted
> at the interface between the DDR controller and the PHY, interface between
> the DDR Controller and the CHI interconnect, or within the DDR Controller.
> 
> Additionally DSS also supports two fixed performance event counters, one
> for ddr reads and the other for ddr writes.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Follow on comments. Given I'm late to the game and none of this
is critical, you can ignore if maintainers think current code
is fine.

Jonathan

> ---
>  Documentation/admin-guide/perf/index.rst      |   1 +
>  .../admin-guide/perf/mrvl-odyssey-ddr-pmu.rst |  80 ++++++
>  drivers/perf/marvell_cn10k_ddr_pmu.c          | 257 +++++++++++++++++-
>  3 files changed, 335 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst
> 
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 7eb3dcd6f4da..d673ccfea903 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -14,6 +14,7 @@ Performance monitor support
>     qcom_l2_pmu
>     qcom_l3_pmu
>     starfive_starlink_pmu
> +   mrvl-odyssey-ddr-pmu
>     arm-ccn
>     arm-cmn
>     xgene-pmu
> diff --git a/Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst b/Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst
> new file mode 100644
> index 000000000000..2e817593a4d9
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst
...

> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
> index 65422fd5ddd2..95818bc035e4 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c

> -static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
> +static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
> +				     struct cn10k_ddr_pmu *ddr_pmu)
>  {
>  	switch (eventid) {
>  	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
>  	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
>  		*event_bitmap = (1ULL << (eventid - 1));
>  		break;
> +	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
> +		if (ddr_pmu->version == DDR_PMU_V2)
> +			*event_bitmap = (1ULL << (eventid - 1));
> +		else
> +			goto err;
> +		break;
>  	case EVENT_OP_IS_ENTER_SELFREF:
>  	case EVENT_OP_IS_ENTER_POWERDOWN:
>  	case EVENT_OP_IS_ENTER_MPSM:
>  		*event_bitmap = (0xFULL << (eventid - 1));
>  		break;
>  	default:
> -		pr_err("%s Invalid eventid %d\n", __func__, eventid);
> +err:		pr_err("%s Invalid eventid %d\n", __func__, eventid);

Hmm. Not pretty. I'd print that the event is not supported prior to
v2 in where you have goto err above.

>  		return -EINVAL;
>  	}
>  
c void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
>  {
>  	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
> +	u64 ctrl_reg = pmu->p_data->ddrc_perf_cnt_op_mode_ctrl;
>  	struct hw_perf_event *hwc = &event->hw;
>  	int counter = hwc->idx;
>  
>  	local64_set(&hwc->prev_count, 0);
>  
>  	cn10k_ddr_perf_counter_enable(pmu, counter, true);
> +	if (pmu->version == DDR_PMU_V2) {
As below.  Just use a flag for whether to do this.
That flag can give it a clear name rather than basing it on 
a magic version number.

> +	/* Setup the PMU counter to work in manual mode */
> +		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, pmu->base +
> +			       DDRC_PERF_REG(ctrl_reg, counter));
> +
> +		cn10k_ddr_perf_counter_start(pmu, counter);
> +	}
>  
>  	hwc->state = 0;
>  }
> @@ -495,7 +636,7 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
>  	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
>  		/* Generic counters, configure event id */
>  		reg_offset = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
> -		ret = ddr_perf_get_event_bitmap(config, &val);
> +		ret = ddr_perf_get_event_bitmap(config, &val, pmu);
>  		if (ret)
>  			return ret;
>  
> @@ -524,6 +665,9 @@ static void cn10k_ddr_perf_event_stop(struct perf_event *event, int flags)
>  
>  	cn10k_ddr_perf_counter_enable(pmu, counter, false);
>  
> +	if (pmu->version == DDR_PMU_V2)
> +		cn10k_ddr_perf_counter_stop(pmu, counter);
Use a flag in pdata to decide if this needs doing, not a version check.
Versions are just not flexible enough once a significant number of
them exist and there is very little cost in avoiding them in the first place.

Also, use device names not v1 and v2.


Jonathan

> +
>  	if (flags & PERF_EF_UPDATE)
>  		cn10k_ddr_perf_event_update(event);
>  
> @@ -640,6 +784,66 @@ static void ddr_pmu_overflow_hander(struct cn10k_ddr_pmu *pmu, int evt_idx)
>  	cn10k_ddr_perf_pmu_enable(&pmu->pmu);
>  }
> 

