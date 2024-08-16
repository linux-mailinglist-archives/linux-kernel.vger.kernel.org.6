Return-Path: <linux-kernel+bounces-289451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D898E95465C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A5FB250DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820F172BD3;
	Fri, 16 Aug 2024 10:00:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2CB170A35
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802412; cv=none; b=VoJI84rOCGA8tp0oPB2tUsCaNSlCufshPFbkMYJ9I1p6i8w5AtUylHXsu0y+y6or1bGobvvFSWmcq5ZGKvTIJZZQNcdZ594xTVpS+6shpYtl3CUmpyM3kpgRKZfpvrEEiaJTlUx5H85TRlPteL2r+Iog3PcF+RwvRl6TlsWynWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802412; c=relaxed/simple;
	bh=X2ffU21u6Ap0PPxxdBwbgacsHCZnDZy693IcNtn+jUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHYYSVtfHcTLZxqQbi30/9IKr1EUYXTT4SL7bviXc/CVobz3E870faOT6BpR8CBmp7Qwmi8qUpk422RHHh+0/mBuFlP52wtADV2Lbva6KrXxAL1VooC3ZlIyF0kn4uZvdQAH/8QrmKEYeUyw4bzShyST//7jpGNnFIElDlch73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6146A143D;
	Fri, 16 Aug 2024 03:00:35 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798953F73B;
	Fri, 16 Aug 2024 03:00:08 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:00:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 2/8] perf/arm-cmn: Fix CCLA register offset
Message-ID: <Zr8jJq3l9sfvJuil@J2N7QTR9R3>
References: <cover.1723229941.git.robin.murphy@arm.com>
 <e73b31da42a7840d4247fc8a4a3cea805c2ab618.1723229941.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73b31da42a7840d4247fc8a4a3cea805c2ab618.1723229941.git.robin.murphy@arm.com>

On Fri, Aug 09, 2024 at 08:15:41PM +0100, Robin Murphy wrote:
> Apparently pmu_event_sel is offset by 8 for all CCLA nodes, not just
> the CCLA_RNI combination type.

Was there some reason we used to think that was specific to CCLA_RNI
nodes, or was that just an oversight?

Looking at the CMN-700 TRM and scanning for pmu_event_sel, we have:

	16'h2000	por_ccg_ha_pmu_event_sel
	16'h2000	por_ccg_ra_pmu_event_sel
	16'h2008	por_ccla_pmu_event_sel
	16'h2000	por_dn_pmu_event_sel
	16'h2000	cmn_hns_pmu_event_sel
	16'h2000	por_hni_pmu_event_sel
	16'h2008	por_hnp_pmu_event_sel
	16'h2000	por_mxp_pmu_event_sel
	16'h2000	por_rnd_pmu_event_sel
	16'h2000	por_rni_pmu_event_sel
	16'h2000	por_sbsx_pmu_event_sel

> Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index fd2122a37f22..0e2e12e2f4fb 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2393,10 +2393,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>  			case CMN_TYPE_CXHA:
>  			case CMN_TYPE_CCRA:
>  			case CMN_TYPE_CCHA:
> -			case CMN_TYPE_CCLA:
>  			case CMN_TYPE_HNS:
>  				dn++;
>  				break;
> +			case CMN_TYPE_CCLA:
> +				dn->pmu_base += CMN_HNP_PMU_EVENT_SEL;
> +				dn++;
> +				break;

When reading this for the first time, it looks like a copy-paste error
since CMN_HNP_PMU_EVENT_SEL doesn't have any obvious relationship with
CCLA nodes.

I reckon it'd be worth adding CMN_CCLA_PMU_EVENT_SEL, and replacing the
existing comment above the definition of CMN_HNP_PMU_EVENT_SEL, e.g.

/*
 * Some nodes place common registers at different offsets from most
 * other nodes.
 */
#define CMN_HNP_PMU_EVENT_SEL		0x008
#define CMN_CCLA_PMU_EVENT_SEL		0x008

That way the switch looks less suspicious, and the comment is a bit more
helpful to anyone trying to figure out what's going on here.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  			/* Nothing to see here */
>  			case CMN_TYPE_MPAM_S:
>  			case CMN_TYPE_MPAM_NS:
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

