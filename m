Return-Path: <linux-kernel+bounces-379831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9879AE463
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0FA1C21475
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9731D0498;
	Thu, 24 Oct 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9ZvJA2a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEE1C4A0E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771672; cv=none; b=YG5GsjVmS4jBeasAQsOVZX55vwfUYnjEMVCWWAd/ViiMeI9yDyREtcampQiqT9tFzzrjVATmc4JdnrwHsCMciCyh5uI9WBc9XMLR0M0Aa6PKOe9DppVrDseX04bf5daowENiWBa7pTVElElJqijdweKWn4bx5yL/sQ6/kkosYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771672; c=relaxed/simple;
	bh=8/4aou3tP+TXpUdsvrdRG2gFHM9wjSSRJmGYWThrHzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMislReb7pawPjAhymIRl5u/OSydPr1QUXpuk4Ly/bFG8OyA6HDKNdIvXmysIPb+lRpz/fbujN1PK4+HKBttXYdrlrxp2eqbAc0NPUxGTeVPyEJvrUVeQxz2qjwdI9VdC+JlOZOxa+Kjx92ewrlcUsLvxPQSCtAVwRGwAE3Pofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9ZvJA2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EF3C4CEC7;
	Thu, 24 Oct 2024 12:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729771672;
	bh=8/4aou3tP+TXpUdsvrdRG2gFHM9wjSSRJmGYWThrHzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9ZvJA2aZby3yuYqjVMqt8obh6t4aJeIESgD3SwGqQr5XpGfzPACDiiJMv0AcQ5sG
	 kSVL3ee7DA6h7HcXpE3oKBLCg511hye73L2X3H8k0VZcAqeH2DxZmWFCtXlvqoQ91q
	 dqoTbf/G7zKLFpiADp8U9HRG49wV96jMIRoOyiO+4/rPbWYIn3SMlBt8QiaZh4kgZm
	 bAtS5DAKACaROx2CvElOiu6CfinGvEfVrzRgXmUskjZ+WUKLtYJNRO/tFWLiAd/NwJ
	 hGm41QMN6fTOmImbAnnu3vNkQzi8QsoFABy6VdUNLWFdxaTxxc0gbdY5g1RHA+Npt5
	 6bL4ARWgGGqkQ==
Date: Thu, 24 Oct 2024 13:07:47 +0100
From: Will Deacon <will@kernel.org>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bbhushan2@marvell.com,
	gcherian@marvell.com, sgoutham@marvell.com,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v9 3/5] perf/marvell: Odyssey DDR Performance monitor
 support
Message-ID: <20241024120746.GA30510@willie-the-truck>
References: <20241016080153.3546353-1-gthiagarajan@marvell.com>
 <20241016080153.3546353-4-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016080153.3546353-4-gthiagarajan@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 16, 2024 at 01:31:51PM +0530, Gowthami Thiagarajan wrote:
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
> ---
>  Documentation/admin-guide/perf/index.rst      |   1 +
>  .../admin-guide/perf/mrvl-odyssey-ddr-pmu.rst |  80 ++++++
>  drivers/perf/marvell_cn10k_ddr_pmu.c          | 261 +++++++++++++++++-
>  3 files changed, 339 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst

[...]

> @@ -297,20 +405,27 @@ static ktime_t cn10k_ddr_pmu_timer_period(void)
>  	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * USEC_PER_SEC);
>  }
>  
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
> +		if (ddr_pmu->p_data->is_ody)
> +			*event_bitmap = (1ULL << (eventid - 1));
> +		else
> +			goto err;
> +		break;

You could tidy this up a little with a fallthrough:

	int err = 0;

	switch (eventid) {
	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
		if (!ddr_pmu->p_data->is_ody) {
			err = -EINVAL;
			break;
		}
		fallthrough;
	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
		*event_bitmap = (1ULL << (eventid - 1));
		break;
	default:
		err = -EINVAL;
	}

	if (err) {
		pr_err("%s Invalid eventid %d\n", __func__, eventid);
		return err;
	}

>  static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
>  {
>  	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
> +	u64 ctrl_reg = pmu->p_data->cnt_op_mode_ctrl;
>  	struct hw_perf_event *hwc = &event->hw;
> +	bool is_ody = pmu->p_data->is_ody;
>  	int counter = hwc->idx;
>  
>  	local64_set(&hwc->prev_count, 0);
>  
>  	cn10k_ddr_perf_counter_enable(pmu, counter, true);
> +	if (is_ody) {
> +	/* Setup the PMU counter to work in manual mode */
> +		writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, pmu->base +

Existing typo: OP_MODE_CTRL_VAL_MANNUAL

I guess you could fix that in one of the earlier refactoring patches, if
you wanted to.

> +			       DDRC_PERF_REG(ctrl_reg, counter));
> +
> +		cn10k_ddr_perf_counter_start(pmu, counter);
> +	}

Why not put this inside cn10k_ddr_perf_counter_enable()?

>  
>  	hwc->state = 0;
>  }
> @@ -486,7 +630,7 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
>  	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
>  		/* Generic counters, configure event id */
>  		reg_offset = DDRC_PERF_CFG(p_data->cfg_base, counter);
> -		ret = ddr_perf_get_event_bitmap(config, &val);
> +		ret = ddr_perf_get_event_bitmap(config, &val, pmu);
>  		if (ret)
>  			return ret;
>  
> @@ -511,10 +655,14 @@ static void cn10k_ddr_perf_event_stop(struct perf_event *event, int flags)
>  {
>  	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> +	bool is_ody = pmu->p_data->is_ody;
>  	int counter = hwc->idx;
>  
>  	cn10k_ddr_perf_counter_enable(pmu, counter, false);
>  
> +	if (is_ody)
> +		cn10k_ddr_perf_counter_stop(pmu, counter);

Same here.

Will

