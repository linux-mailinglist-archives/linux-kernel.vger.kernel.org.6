Return-Path: <linux-kernel+bounces-416803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419899D4A78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C1AB2155B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308601CC159;
	Thu, 21 Nov 2024 10:08:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B61A0B08
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183720; cv=none; b=mCgKX1rOlHbs6qyBIHctT81WSfmuf8lAKIwLf708THIO2nEliyoOXVsSgRXDgK6aChFl17x5bt/UbqMoE8pZ2NeOm6d+4doWpWKkKp3CoZG5GFI+mbJhJUBaLYzOZZYj0GVNKcY6fb8qO1kn/VSLZw/KDVEN8ra1PdylUQidhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183720; c=relaxed/simple;
	bh=Eulqd7hNf8dJDvELlztTs7OJMg/wuWLKkIuPumnh/20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtleSsGaFFrk/LtnvdcYN/lXC0lH70/chjPplc3w44pAH2svwJ2akbw9F5gaR0YI4jmPe+Ikja1RSPdeWEmrpYzvBTgdFQcJ70DsIMiOZbtnixMdqrgszgDOpODdpBGd+OXYI323CLQHjQoUVuvaHMSyB8OhyBtuu14ieVc+cbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 617931480;
	Thu, 21 Nov 2024 02:09:07 -0800 (PST)
Received: from [10.57.92.130] (unknown [10.57.92.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 727303F6A8;
	Thu, 21 Nov 2024 02:08:36 -0800 (PST)
Message-ID: <b7636597-b72e-4bea-ab07-c6ad6caf2aac@arm.com>
Date: Thu, 21 Nov 2024 10:08:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/arm-cmn: Ensure port and device id bits are set
 properly
To: Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Stephane Eranian <eranian@google.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
References: <20241121001334.331334-1-namhyung@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241121001334.331334-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-21 12:13 am, Namhyung Kim wrote:
> The portid_bits and deviceid_bits were set only for XP type nodes in
> the arm_cmn_discover() and it confused other nodes to find XP nodes.
> Copy the both bits from the XP nodes directly when it sets up a new
> node.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: e79634b53e39 ("perf/arm-cmn: Refactor node ID handling. Again.")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   drivers/perf/arm-cmn.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 49bd811c6fd6efdd..b20fa600e510c54f 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2178,8 +2178,6 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
>   			continue;
>   
>   		xp = arm_cmn_node_to_xp(cmn, dn);
> -		dn->portid_bits = xp->portid_bits;
> -		dn->deviceid_bits = xp->deviceid_bits;
>   		dn->dtc = xp->dtc;
>   		dn->dtm = xp->dtm;
>   		if (cmn->multi_dtm)
> @@ -2420,6 +2418,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>   			}
>   
>   			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
> +			dn->portid_bits = xp->portid_bits;
> +			dn->deviceid_bits = xp->deviceid_bits;
>   
>   			switch (dn->type) {
>   			case CMN_TYPE_DTC:
> 
> base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2


