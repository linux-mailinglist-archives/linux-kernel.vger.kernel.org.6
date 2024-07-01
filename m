Return-Path: <linux-kernel+bounces-236402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD98E91E1C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9092881DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB9E15F409;
	Mon,  1 Jul 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN0yh+vT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17B15EFD7;
	Mon,  1 Jul 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842514; cv=none; b=soepm39NcTVh3u+paZmgdeenUyrd9DxFoBviab/Czo+nK2C94ltOhFFH9mSI+mqKI1thVwMedIDrcIyybHAi7BWfk65xsE8mqayx3ROks21mQPHkx5knVCbtatSeL+or+ebq8u9O2ngBojgJ73ECYM4T2dHn+LQppwE12VMXyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842514; c=relaxed/simple;
	bh=20YPDUoXAJDrBbYupizuXUs4fTv2sy6ElV8nDW+FiMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTpbcTtfFDQokwpxU9L5xdS4rdZ/1/e8waee3obgpYHtndMVnTy7oBwQlh7GQyNZG+JqPUpVIEtjjdBz28xIVrKepGmKOP0t/sXtfN0/TUsIkYkDTqDyWbmGKXCnC6Z4wijbmqiOabeOzcKKYX5BwEDrrMrBhGEnuFF/G5RLR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN0yh+vT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F375BC116B1;
	Mon,  1 Jul 2024 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842513;
	bh=20YPDUoXAJDrBbYupizuXUs4fTv2sy6ElV8nDW+FiMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tN0yh+vTRJWSlWjh8Ff5jl1Zibx/qsLzn9HSYxcTHT76KEHK0ztHvccCDnryAg1tc
	 KKGDsfumRfkqBMn9FIAwgWvNRpBqK8YjB1OM9iY2wH2tNSWUyGe/JHVrhD31W+8FQ6
	 phN90Fl2DWWW+NIkZyl7iX6N8x8XRI+2FJiJ953ftSoD2FUC3e2UkSbg3fUzl0MgLf
	 QcA4KgpwCBsfmF2TuhH41/Wx4BXtMDVvjacw925SQ89m9vxyoGxTV40b0IPFSvcHGh
	 xlXOGX3BzQKZ1BpPMggotUytSx+JaDRfrfCnGJ43UPCm0Ejfx4bUUSErViifROOLv6
	 +A5zUPivL8/Ag==
Date: Mon, 1 Jul 2024 15:01:48 +0100
From: Will Deacon <will@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>, Asahi Lina <lina@asahilina.net>,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drivers/perf: apple_m1: fix affinity table for event
 0x96 and 0x9b
Message-ID: <20240701140148.GE2250@willie-the-truck>
References: <tencent_7B71486CE305DF8AE084B6BB6313EE550C06@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7B71486CE305DF8AE084B6BB6313EE550C06@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 20, 2024 at 11:04:28AM +0800, Yangyu Chen wrote:
> Events 0x96 and 0x9b can be installed on counter 7 only. Fix this to avoid
> getting the wrong counter value.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  drivers/perf/apple_m1_cpu_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
> index f322e5ca1114..b8127e5428e1 100644
> --- a/drivers/perf/apple_m1_cpu_pmu.c
> +++ b/drivers/perf/apple_m1_cpu_pmu.c
> @@ -107,12 +107,12 @@ static const u16 m1_pmu_event_affinity[M1_PMU_PERFCTR_LAST + 1] = {
>  	[M1_PMU_PERFCTR_UNKNOWN_93]	= ONLY_5_6_7,
>  	[M1_PMU_PERFCTR_UNKNOWN_94]	= ONLY_5_6_7,
>  	[M1_PMU_PERFCTR_UNKNOWN_95]	= ONLY_5_6_7,
> -	[M1_PMU_PERFCTR_UNKNOWN_96]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_96]	= BIT(7),
>  	[M1_PMU_PERFCTR_UNKNOWN_97]	= BIT(7),
>  	[M1_PMU_PERFCTR_UNKNOWN_98]	= ONLY_5_6_7,
>  	[M1_PMU_PERFCTR_UNKNOWN_99]	= ONLY_5_6_7,
>  	[M1_PMU_PERFCTR_UNKNOWN_9a]	= BIT(7),
> -	[M1_PMU_PERFCTR_UNKNOWN_9b]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_9b]	= BIT(7),
>  	[M1_PMU_PERFCTR_UNKNOWN_9c]	= ONLY_5_6_7,
>  	[M1_PMU_PERFCTR_UNKNOWN_9f]	= BIT(7),
>  	[M1_PMU_PERFCTR_UNKNOWN_bf]	= ONLY_5_6_7,

It would be great if somebody with access to M1 hardware (and/or any
PMU insight) could Test or Ack this, please.

Cheers,

Will

