Return-Path: <linux-kernel+bounces-289496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CB19546C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BC01C21D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193718D64B;
	Fri, 16 Aug 2024 10:25:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC718D622
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803934; cv=none; b=cqh9khPt+a0PDOIdwFLjswkq50IhLARZAfiZj6uyPVNj3XYSdsOvPI2/HxMpLImKQ/DXIFj0UQBz4RW9P/ou6aTA/bPblrc8iqc+EBRDJAxiTkEt4/QdJpzcA3TN7BfZucdfKYZUwYyk0UeV4J0DpQ39y1Gij2Bb4Eof1OXWYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803934; c=relaxed/simple;
	bh=Umeo+naeMeIk6r8p8MVZvWpOoOb1QeoYsyAHHILEIZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thvzPV1m9wOwE8QYHJR7hvAam408ZUadz01IPzeidMjPz6YwQo6HGu8JHeza/Vks0cfV2ogfw+hg8aR3sXsq8D/i/8rseb+ebvLYrm22B4GuvwzEupq3eKjIMih5D+LjcRYLYiO5g48AWS/Mrc40SXf3qtnAUq5oTSH6v6kHtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B1AC143D;
	Fri, 16 Aug 2024 03:25:57 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B71FE3F73B;
	Fri, 16 Aug 2024 03:25:30 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:25:28 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 5/8] perf/arm-cmn: Make cycle counts less surprising
Message-ID: <Zr8pGEMmzmexNGL8@J2N7QTR9R3>
References: <cover.1723229941.git.robin.murphy@arm.com>
 <570c473134426b8e11bb043aa59e3cde3dab8af3.1723229941.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570c473134426b8e11bb043aa59e3cde3dab8af3.1723229941.git.robin.murphy@arm.com>

On Fri, Aug 09, 2024 at 08:15:44PM +0100, Robin Murphy wrote:
> By default, CMN has automatic clock-gating with the implication that a
> DTC's cycle counter may not increment while the domain is sufficiently
> idle.

Similar is true for the cycles event on the CPU side, so this has some
precedent.

> Given that we may have up to 4 DTCs to choose from when scheduling
> a cycles event, this may potentially lead to surprising results if
> trying to measure metrics based on activity in a different DTC domain
> from where cycles end up being counted. Make the reasonable assumption
> that if the user wants to count cycles, they almost certainly want to
> count all of the cycles, and disable clock gating while a DTC's cycle
> counter is in use.

As above, the default does match the CPU side behaviour, and a user
might be trying to determine how much clock gating occurs over some
period, so it's not necessarily right to always disable clock gating.
That might need to be an explicit option on the cycles event.

Do we always have the ability to disable clock gating, or can that be
locked down by system integration or FW?

Mark.

> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 8f7a1a6f8ab7..4d128db2040c 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -115,6 +115,7 @@
>  /* The DTC node is where the magic happens */
>  #define CMN_DT_DTC_CTL			0x0a00
>  #define CMN_DT_DTC_CTL_DT_EN		BIT(0)
> +#define CMN_DT_DTC_CTL_CG_DISABLE	BIT(10)
>  
>  /* DTC counters are paired in 64-bit registers on a 16-byte stride. Yuck */
>  #define _CMN_DT_CNT_REG(n)		((((n) / 2) * 4 + (n) % 2) * 4)
> @@ -1544,9 +1545,12 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
>  	int i;
>  
>  	if (type == CMN_TYPE_DTC) {
> -		i = hw->dtc_idx[0];
> -		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + CMN_DT_PMCCNTR);
> -		cmn->dtc[i].cc_active = true;
> +		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
> +
> +		writel_relaxed(CMN_DT_DTC_CTL_DT_EN | CMN_DT_DTC_CTL_CG_DISABLE,
> +			       dtc->base + CMN_DT_DTC_CTL);
> +		writeq_relaxed(CMN_CC_INIT, dtc->base + CMN_DT_PMCCNTR);
> +		dtc->cc_active = true;
>  	} else if (type == CMN_TYPE_WP) {
>  		u64 val = CMN_EVENT_WP_VAL(event);
>  		u64 mask = CMN_EVENT_WP_MASK(event);
> @@ -1575,8 +1579,10 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
>  	int i;
>  
>  	if (type == CMN_TYPE_DTC) {
> -		i = hw->dtc_idx[0];
> -		cmn->dtc[i].cc_active = false;
> +		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
> +
> +		dtc->cc_active = false;
> +		writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
>  	} else if (type == CMN_TYPE_WP) {
>  		for_each_hw_dn(hw, dn, i) {
>  			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

