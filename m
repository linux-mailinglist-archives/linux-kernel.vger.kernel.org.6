Return-Path: <linux-kernel+bounces-567410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F3AA68593
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E00421506
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428CE24EF61;
	Wed, 19 Mar 2025 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HAdDviIa"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DE20D4FA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368336; cv=none; b=HlBNOnlH+FXVf/VB3FFV1b4wB3/+xqH4/0p7Tmq3tX2ntKOsBwEd0EkQEHTlxnEMj+CBPcdMX86Jm+ruaPI0ZQzU1aAAQlRb3NJgyB3MNfhhBPIv0nsgM/MYtBF3mk+/Sran3KSlRuaSNb2bzrR/OupuAb1WfDRWNq8KMPDQkNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368336; c=relaxed/simple;
	bh=gAPl73nB1/HYJwqwFsCBDZYKVaVTHM6tgFaD9NMhd5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJeJzi89qA3Y4Hn7PS5Pb+sK2ixdZeTB2LOfF9gpHd9yj06fBRNE7IoE+5uNrz1lIPfPAzfkbExvRN1icLp3U6+QlJfnRyAasUj4b4qB/fWZKWYRUbHM5t0g7JivtbiqhYqzvCe43mgIKHn8pyHEQtYIUQwyc/CnC5ySbRp/MNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HAdDviIa; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f12442a9-c8b9-4cda-9f15-3a3091250685@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742368322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c39d0sN46EFBdX+bBun70+OOV7ydvqD1sY/1k8B9HpI=;
	b=HAdDviIadASHNtZvPD7I+l54Z0VOHEPJKwl/00sC8cHoHPixbKKBQy9vyjAtJwLIMFSk5F
	8ERkpGaixDqRgPZA1f3+yGQx+N0lg03O26ASCDjAB1M6HpESUCQAzPVx1bc7yhPPi3s7vr
	fGs9+D5ijxQ4CtWFgpkaylQJCWKHKpc=
Date: Wed, 19 Mar 2025 15:11:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH next] pinctrl: tegra: Fix off by one in
 tegra_pinctrl_get_group()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Prathamesh Shete <pshete@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <82b40d9d-b437-42a9-9eb3-2328aa6877ac@stanley.mountain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <82b40d9d-b437-42a9-9eb3-2328aa6877ac@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/19 15:05, Dan Carpenter wrote:
> This should be >= pmx->soc->ngroups instead of > to avoid an out of
> bounds access.  The pmx->soc->groups[] array is allocated in
> tegra_pinctrl_probe().
>
> Fixes: c12bfa0fee65 ("pinctrl-tegra: Restore SFSEL bit when freeing pins")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/pinctrl/tegra/pinctrl-tegra.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
> index 0246acba7703..11ecbd6a9b2a 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -306,7 +306,7 @@ static const struct tegra_pingroup *tegra_pinctrl_get_group(struct pinctrl_dev *
>   {
>   	struct tegra_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
>   
> -	if (group_index < 0 || group_index > pmx->soc->ngroups)
> +	if (group_index < 0 || group_index >= pmx->soc->ngroups)
>   		return NULL;
>   
>   	return &pmx->soc->groups[group_index];

Reviewed-by: Kunwu Chan <kunwu.chan@linux.dev>

-- 
Thanks,
   Kunwu.Chan(Tao.Chan)


