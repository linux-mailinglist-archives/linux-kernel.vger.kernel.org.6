Return-Path: <linux-kernel+bounces-364164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB699CC06
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93771C22F63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0A19C557;
	Mon, 14 Oct 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxQCGtbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E218638
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914218; cv=none; b=VQfbgYOs9l5raAXcjZcNQ0bttPPPVSNZejtkgdnXyvCpw55bBP6sHXAkV2nHGg4xNCQvdUoiYetGv4LRFEaqQGWYZyvG/b1SO8I64++S06TA2zYxoLQoUrxGVKEHe8Lzj92qdgSSpmLqJOGFPPDICTe1+Uov+Vyiy1Y8wsTPQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914218; c=relaxed/simple;
	bh=/2rnqSH2UxIB2spi0zaBHsCaTHRSad7uEBcWJvCbIQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk8bEJ0w8GmrloN3zs2osnu2QsrRS4xJMyLfBK4v5KyKSNlBZaYDREM5xIzbT+xoeSkj7V0Z4iDCmnFdjTWXthfyWU6qgOVeXgDZj9JVyXGGTkedrdb8Q2Kj+C1qEMDHEpacTnA40PUUE/DBEQzt7phJ8zyc9D5PXLSm7piKS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxQCGtbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0444C4CEC3;
	Mon, 14 Oct 2024 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728914218;
	bh=/2rnqSH2UxIB2spi0zaBHsCaTHRSad7uEBcWJvCbIQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxQCGtbcQbgSqQlIJnGgPhUZo+iRZD6dUApE7AUq7grSUddEJsdsMWXy6hR1yQfMt
	 rVS7f0FAwarx3lGPJrC4Am4lj62FBy1G9ZaUR7UfQRyBEXEvTBANlAJLvUetTKRxKP
	 V4eGXQ0DJ3xT8FWvL/eBo9gKDnFk5d1L6vop6othJMAtNy613j5sebb5Pd/uyfojha
	 o6HZpk8/XcDUQYAFlS20cN4rPKZK20BkjQaU0r99rK2Ne7WFjJUFCIvsR9FWMtReMh
	 CKF6fYPbr3KAQxJ2epZSqgh/hqZ44Z+kqLheWsIqNissQ4gbC16/MNcs5nWK8QqYj0
	 X8ksWdPZrSe/w==
Date: Mon, 14 Oct 2024 14:56:53 +0100
From: Will Deacon <will@kernel.org>
To: Youwan Wang <youwan@nfschina.com>
Cc: jonathan.cameron@huawei.com, yangyicong@hisilicon.com,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: hisi: Fix readl DDRC_VERSION stuck
Message-ID: <20241014135653.GA17505@willie-the-truck>
References: <20241010084217.37540-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010084217.37540-1-youwan@nfschina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 10, 2024 at 04:42:17PM +0800, Youwan Wang wrote:
> The CPU of the device I am using is kunpeng 920,
> which can start normally with version 5.4 kernel.
> However, when installing version 6.6 kernel, the
> kernel gets stuck when loading the "hisi_dddrc_pmu"
> driver. I went to debug and found that it gets stuck
> when "readl (ddrc_pmu ->base+DDRC_VERSION)". I suspect
> that the hardware does not support it. My modification is:
> for the "HISI0233" device, according to the implementation
> of version 5.4 kernel, the identity is not obtained from
> the register. For "identifier" sysfs, identifier: 0
> 
> Signed-off-by: Youwan Wang <youwan@nfschina.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> index b804e3738113..3cecad46b01f 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> @@ -321,6 +321,9 @@ static int hisi_ddrc_pmu_init_data(struct platform_device *pdev,
>  		return PTR_ERR(ddrc_pmu->base);
>  	}
>  
> +	if (strstr(pdev->name, "HISI0233"))
> +		return 0;

If your firmware is advertising devices that don't exist, then you should
fix that rather than adding a hack to the driver.

Will

