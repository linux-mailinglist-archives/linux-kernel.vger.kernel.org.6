Return-Path: <linux-kernel+bounces-539813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9BA4A943
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17ADA7AA823
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DFB1C32FF;
	Sat,  1 Mar 2025 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0klQzH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6EBA3D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740810230; cv=none; b=RZzdfJrP1Kmc60iSx+4OYfxW/WLijeH+GW9ZwDuqpkuF6XmohTD5XemBxyu9uCuTAQTkKfhMwnDSWOMR0FyDVI0T707rYqw/MBRyGvFo1DJIIfxiRru2WK5IglaMNDP0wRccqfYK2e1D/1XdO180TL4QXqeeCoq7+ioFz12QdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740810230; c=relaxed/simple;
	bh=ykUC0yVuYh8esAQTZSAX9HlvVvWcsQQeaxtZoPbiGnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZLCgrObUOrvGK/fuEClKqpOsuTbJGV8QuOY3IS7pVmMqaPfZG0xC1GHka6Er4qhNYI8QabF+lYpxkfp7fJS+EgzLmEQwlIC+f5yqBoa1o4VP1wDqbhcxCNmAxsYmHJs/NmmYSIvFAEBt0j+6admIQArphP49yWE5Sa4ArQmOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0klQzH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E075AC4CEDD;
	Sat,  1 Mar 2025 06:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740810229;
	bh=ykUC0yVuYh8esAQTZSAX9HlvVvWcsQQeaxtZoPbiGnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0klQzH3S/kOg2+U3PiboIBD/0DApyEpcWc51PTaK4+EvuJzkfV3BUZYdKTIFwUhf
	 a4Y4HtuR9MysUHyVwfojyaz3q4IQQFr7Gim3wrx9z14EDa9QxW1iG/NZufl/bJmPy9
	 4yeAFqiZcIUsceGrX7TYrmtbDRWS3eYlh0TzucVJIhSgUxaHwbidLpTh98AJx71V4y
	 xRjouKwn/+BW6MMkj8PUFfXpePFFSNXC5fm8zw5GPKH28Ur7PRM8YsI+R+av9+8Cgh
	 Qo1l4UcGcc94Lhvz8eka2/gn/ie8siTLrEoPprfy2CqiZiS6YvihIHL8Y02IIBkEms
	 WyKiFDwDo7X+A==
Date: Sat, 1 Mar 2025 06:23:44 +0000
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com,
	yangyicong@hisilicon.com, wangyushan12@huawei.com
Subject: Re: [PATCH 1/9] drivers/perf: hisi: Extend struct hisi_pmu_dev_info
Message-ID: <20250301062343.GA27700@willie-the-truck>
References: <20250218092000.41641-1-yangyicong@huawei.com>
 <20250218092000.41641-2-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218092000.41641-2-yangyicong@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 18, 2025 at 05:19:52PM +0800, Yicong Yang wrote:
> From: Junhao He <hejunhao3@huawei.com>
> 
> The counter bits and event range may differ from versions of a
> certain uncore PMU. Make this device specific information into
> struct hisi_pmu_dev_info. This will help to simplify the
> initialization process by using a list of struct hisi_pmu_dev_info
> rather than checking the version.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_pmu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> index f4fed2544877..777675838b80 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> @@ -72,6 +72,8 @@ struct hisi_uncore_ops {
>  struct hisi_pmu_dev_info {
>  	const char *name;
>  	const struct attribute_group **attr_groups;
> +	u32 counter_bits;
> +	u32 check_event;
>  	void *private;
>  };

This doesn't really do anything on its own; please just fold it into the
patch where the new fields are used.

Will

