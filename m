Return-Path: <linux-kernel+bounces-539815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6616A4A94F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D751C176065
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9431A1C1F21;
	Sat,  1 Mar 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBCwc1Lb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877A1BD9C7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740811435; cv=none; b=ctD8Pfc3eAyjBj8net75umtxUiEw/KynTSfXgUIEVxz5Av0w3UzNU118Lgx8C16VBdw2LWv2Cq3Bfqo170JgZ+XvUpyeKkADDJJYi4I32Sdy6USj9UGtlkAB9nfwMmK4wwYhud6I+p/x4doeVCXb2m1mKkhZFyv4VNOzQnBZRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740811435; c=relaxed/simple;
	bh=cpfdLDnv01K3lMmbWvGqTS+lBbMcEeQPx8Q2+PRAk6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpJDkxVDIybVobbZ2O4X+RYHphsclfMidNBtcyROQtdfHf4cDBQ5KWACaH4iXb6JAgk6McaJHFS0Y/0mIXdVz0H7ua1LNxIwR7wxnVKw2Dp4eVWNNFDJVkjdaUr73YWzWvC9u6cokEqGA8yZuzhZWKgmW3Ju9G22uwPt3zgEm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBCwc1Lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FECC4CEDD;
	Sat,  1 Mar 2025 06:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740811434;
	bh=cpfdLDnv01K3lMmbWvGqTS+lBbMcEeQPx8Q2+PRAk6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VBCwc1LbLIfrWcd2iFWFdFCGkh25i+cvKkfjbHveyU1eRK0idLhodj1FF5WZ7d2pc
	 nZc6FQQ+j0HJyKlHwKt96vhEZB7/XJQpiX/y7uEnYhETIo8s9wWmP3VLBNUiQtkh4t
	 MkI0J5gDMdTspVZWZSM6Btg3dwJ/rDh3NM6I2hoD28vhlbnZaFoZd70o4mi1syvi/c
	 xJ5AIM0zkaZG0sz3WJyIaCVjAPiMu9njQk6enRDEvFAnt7o44RBHlXhPC2CsjGPEoS
	 /+j4wyainajsE/xtwbFKvy9xB3UIiJu7Sc4Pc0F9b5VQ+wn9E4AUX3MvCGNYw9I5ki
	 MtUFkpvUFGZRQ==
Date: Sat, 1 Mar 2025 06:43:49 +0000
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com,
	yangyicong@hisilicon.com, wangyushan12@huawei.com
Subject: Re: [PATCH 4/9] drivers/perf: hisi: Use ACPI driver_data to retrieve
 SLLC PMU information
Message-ID: <20250301064347.GB27700@willie-the-truck>
References: <20250218092000.41641-1-yangyicong@huawei.com>
 <20250218092000.41641-5-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218092000.41641-5-yangyicong@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 18, 2025 at 05:19:55PM +0800, Yicong Yang wrote:
> From: Junhao He <hejunhao3@huawei.com>
> 
> Make use of struct acpi_device_id::driver_data for version specific
> information rather than judge the version register. This will help
> to simplify the probe process and also a bit easier for extension.
> 
> Factor out SLLC register definition to struct hisi_sllc_pmu_regs.
> No functional changes intended.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 191 ++++++++++++------
>  1 file changed, 125 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> index dbd079016fc4..c1fd60d397c3 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> @@ -36,11 +36,14 @@
>  #define SLLC_SRCID_NONE			0x0
>  #define SLLC_TGTID_EN			BIT(5)
>  #define SLLC_TGTID_NONE			0x0
> -#define SLLC_TGTID_MIN_SHIFT		1
> -#define SLLC_TGTID_MAX_SHIFT		12
> -#define SLLC_SRCID_CMD_SHIFT		1
> -#define SLLC_SRCID_MSK_SHIFT		12
> +#define SLLC_TGTID_MIN_MSK		GENMASK(11, 1)
> +#define SLLC_TGTID_MAX_MSK		GENMASK(22, 12)
> +#define SLLC_SRCID_CMD_MSK		GENMASK(11, 1)
> +#define SLLC_SRCID_MSK_MSK		GENMASK(22, 12)
>  #define SLLC_NR_EVENTS			0x80
> +#define SLLC_EVENT_CNTn(cnt0, n)	((cnt0) + (n) * 8)
> +#define SLLC_FIRST_BIT(_mask)		(find_first_bit((const unsigned long *)&(_mask), 32))
> +#define SLLC_FIELD_PREP(_mask, _val)	(_mask & (_val << SLLC_FIRST_BIT(_mask)))

It's a bit of a shame to have to compute this dynamically given that the
input mask is constant for a given device. Is it not possible to use the
generic FIELD_PREP macro in per-device code and then just dispatch to
that, instead of funneling everything through hisi_sllc_pmu_regs?

Will

