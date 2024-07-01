Return-Path: <linux-kernel+bounces-236573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40291E434
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8E91C22BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF716D9B3;
	Mon,  1 Jul 2024 15:32:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D8A16D4C6;
	Mon,  1 Jul 2024 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847965; cv=none; b=jvKLApgolcQ+ho2K8zYzux7iWlevjVYwBxysCY3zrFvlXYZHT8gq9beLA3qBytkOpkmkUEf3+GBDvKBXf2T1x8E5JH/FbGiwl1F/blxagKDTClc41h0CWHUTQl/Z9EJnLLz3cNta/68KaLRgFY5F9IwiYSWq9BHcTUTNALm+Nzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847965; c=relaxed/simple;
	bh=szQdPiyo9yNxRagpcSjdtxIPW5x4G5ULZpn487xWoFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIBTKJaKyPapvR3tm9C4zlCDcb1KQ9ENiEX6rNVFZvc2vcfz74e8oEmDafmZq0OfmMKidjJ5ytajgLXHmFUL0BFfBtm8ehYmicdR+E7AILJdxqVgIQm+aH+6Xo5JqDEFmMLKPcCvzRTm66Amdj+XJktY+MQCEkFLRgmi/aaIVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5AED339;
	Mon,  1 Jul 2024 08:33:07 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC6433F73B;
	Mon,  1 Jul 2024 08:32:41 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:32:39 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH 1/3] Add Kconfig option for scmi debug statistics
Message-ID: <ZoLMF5AFa60iefpA@pluto>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
 <20240701142851.1448515-2-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701142851.1448515-2-luke.parkin@arm.com>

On Mon, Jul 01, 2024 at 03:28:49PM +0100, Luke Parkin wrote:
> Add a new config option for statistic tracking in SCMI subsystem.
> 
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>
> ---
>  drivers/firmware/arm_scmi/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Hi,

> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index aa5842be19b2..fac50fd0be72 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -55,6 +55,16 @@ config ARM_SCMI_RAW_MODE_SUPPORT_COEX
>  	  operate normally, thing which could make an SCMI test suite using the
>  	  SCMI Raw mode support unreliable. If unsure, say N.
>  
> +config ARM_SCMI_DEBUG_STATISTICS
> +	bool "Enable SCMI Raw mode statistic tracking"

I would add also a depends on DEBUG_FS like in RAW...and maybe in the
future move such all of such depends on ARM_SCMI_NEED_DEBUGFS
instead...but for now it is easier and less potentially disruptive to
the build to just add a depends here.

> +	select ARM_SCMI_NEED_DEBUGFS
> +	help
> +	  Enables statistic tracking for the SCMI subsystem.
> +
> +	  Enable this option to create a new debugfs directory which contains
> +	  several useful statistics on various SCMI features. This can be useful
> +	  for debugging and SCMI monitoring. If unsure, say N.
> +

Moreover you should move this Kconfig patch after the patches in the
series that includes the logic underneath this...here really you are
defining some option that, if enabled, at this point it really still
does NOT enable anything.

Thanks,
Cristian

