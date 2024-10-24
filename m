Return-Path: <linux-kernel+bounces-379794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B99AE3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659B11F234DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4714BF87;
	Thu, 24 Oct 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfi75Jq7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF526CDBA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769527; cv=none; b=myDq61mU/1hGwu5EJy9QIP09MpoXyrhl0AkmDq2gMiAnyyb/pyCO5HeAPUU2vocePuY44E0j612ZGnw5JmqYykBe0VgWAKxmRJGel5qMwBxxva/7zQZQI9apWYb2QRXuk1EpHueL3QO5GuMpKmmicmKQc8Ocup8wTzzHoFHJnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769527; c=relaxed/simple;
	bh=ivnxlBIjC5nMC+d51jAvAbt6k0K2kSFd6G5M3K32Jqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMubdrp2ZHs3PC8Yxtxxpk2oovWZx2wWAEf/tRkE80UtWw6jKuefjq6TWAQA+niIFTi17zyDqnBkqJpHhpoR8zZdjwMVaw8RJOQeo+pueC4l6LJXl1RNM/4l4+1BzS7ViKphqmGEBLyyHYDRA1ckbaTpQE/TMJ4iKoha8YRUFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfi75Jq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD4FC4CEC7;
	Thu, 24 Oct 2024 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729769526;
	bh=ivnxlBIjC5nMC+d51jAvAbt6k0K2kSFd6G5M3K32Jqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rfi75Jq7W2Zl/mTc50A88zDCnOHygVfLeFyaGoqPHEfU5ZwMHi3pfrrl7LXmauTmP
	 XXFp66XtyzW83xoyGGXLMiREPgI/FUR20H1Q/tBVa/9uH0EcscJghkp/ik5f/Jwroc
	 v46ff96cAW0ToJoqfh+sx9DaIT8eGYCECt+3nf3WaF2s9F+e/K5743Vq2qSs03//RO
	 nqnUWcqOTPyAdZ5Y+OpBU2ggWhnTG55qWtiL1056NsuATh0sgAmUNuRLQPmP0mhjdD
	 i9wNZR+azLAP9+XOGI9AntcoHBF0YAT8HNcLohcfyjQe59PsyUEcORD1eOpkHAixG+
	 DIpdtu4hnN6LA==
Date: Thu, 24 Oct 2024 12:32:02 +0100
From: Will Deacon <will@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/dwc_pcie: Load DesignWare PCIe PMU driver
 automatically on Ampere SoCs
Message-ID: <20241024113201.GA30270@willie-the-truck>
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
 <20241008231824.5102-3-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008231824.5102-3-ilkka@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 08, 2024 at 11:18:23PM +0000, Ilkka Koskinen wrote:
> Load DesignWare PCIe PMU driver automatically if the system has a PCI
> bridge by Ampere.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/perf/dwc_pcie_pmu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 3581d916d851..d752168733cf 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -782,6 +782,16 @@ static void __exit dwc_pcie_pmu_exit(void)
>  module_init(dwc_pcie_pmu_init);
>  module_exit(dwc_pcie_pmu_exit);
>  
> +static const struct pci_device_id dwc_pcie_pmu_table[] = {
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_AMPERE, PCI_ANY_ID),
> +		.class		= PCI_CLASS_BRIDGE_PCI_NORMAL,
> +		.class_mask	= ~0,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, dwc_pcie_pmu_table);

Hmm, won't this only work if the driver is modular? Should we be calling
pci_register_driver() for the builtin case?

Will

