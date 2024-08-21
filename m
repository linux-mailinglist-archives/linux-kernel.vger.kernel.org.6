Return-Path: <linux-kernel+bounces-295439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B52959AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9999F1C213DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4919B1B78ED;
	Wed, 21 Aug 2024 11:42:54 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4F1B78E3;
	Wed, 21 Aug 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240573; cv=none; b=n/SqlXGYNrpJymioi9p7K8tUyZROWqBLrhnNiACZu1bCgsftTYIaT5RSCfov+rMO2a3bDHmmU9CO/F4EqGyGrprD+Qmc53WhomsF5mbakqnLJSEn0DM95JLrsZgktj58IdzoiA9tqrnr6bPTL9d9RLeskHEba+682WqZ6k3iV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240573; c=relaxed/simple;
	bh=PtP0v4NswzYqpRoTUMv7eSWgqnhqfDAD+g400vLNJlk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAZO2+YzzTcTJz3R7cExhhE92prsuKUQRGUxn3NI/TJL9Cum8xLFAlBVmunqXvbQGW5hE8mdcwglsyRPZmIM3R6SkKoPlpnJkdKXPCzHWFEVMgZn9znlSiRdmJtwYjur+Vr9aZQ3RRVZN8kcWL8k6BwlAySy/6nFWDYt9dA5bSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WpkrG05xqz6FHYm;
	Wed, 21 Aug 2024 19:39:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ED51B1400DB;
	Wed, 21 Aug 2024 19:42:48 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 12:42:48 +0100
Date: Wed, 21 Aug 2024 12:42:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shanker Donthineni <sdonthineni@nvidia.com>
CC: James Morse <james.morse@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Rohit Mathew <rohit.mathew@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH] arm_mpam: Fix T241-MPAM-4 workaround
Message-ID: <20240821124247.000067fc@Huawei.com>
In-Reply-To: <20240819220818.201870-1-sdonthineni@nvidia.com>
References: <20240819220818.201870-1-sdonthineni@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 19 Aug 2024 17:08:18 -0500
Shanker Donthineni <sdonthineni@nvidia.com> wrote:

> The workaround for T241-MPAM-4 was applied incorrectly, leading to
> MBW_MIN being programmed with a zero value when the user specifies
> MBW_MAX is less than 5%.
> 
> This patch ensures that MBW_MIN is programmed with a non-zero value,
> set to 1 to fix the T241-MPAM-4 as expected.
> 
> Fixes: 13ff1b527e40 ("arm_mpam: Add workaround for T241-MPAM-4")
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Hi Shanker,

I can guess which branch this fix is for, but good to mention it
in the patch given it's not mainline.

Jonathan

> ---
>  drivers/platform/arm64/mpam/mpam_devices.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> index a802ca1c9f05..e49a27c02c66 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -2990,7 +2990,7 @@ static void mpam_extend_config(struct mpam_class *class, struct mpam_config *cfg
>  	}
>  
>  	if (mpam_has_quirk(T241_FORCE_MBW_MIN_TO_ONE, class) &&
> -	    cfg->mbw_min == 0) {
> +	    cfg->mbw_min <= min_hw_granule) {
>  		cfg->mbw_min = min_hw_granule + 1;
>  		mpam_set_feature(mpam_feat_mbw_min, cfg);
>  	}


