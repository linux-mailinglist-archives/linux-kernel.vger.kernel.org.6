Return-Path: <linux-kernel+bounces-561153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF08A60E20
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065743B093D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A717B1F3BAE;
	Fri, 14 Mar 2025 10:01:43 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9F1F3B94
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946503; cv=none; b=ZGq1GdCvlU1UhpNYZ5zR2R/YfQijFmTBHk0xEe5Hr7sxUouCZMWRK322ynEBOjVdAutuTaGR06DVYXxzNgwMZzGNM1Bnz26KMp3O6+Yi9SilyeS8NG8cEEz6iCLxVgwJpanQYCY7IQJgYRuSTzETQXiHHb+rt+nBpT2vK0zuGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946503; c=relaxed/simple;
	bh=sNI20FOIW5DW3sqBRpeYgR362t3idDZCuXcjvqhF/eE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjTL5UTU+FU+tpDhgFkgYau+idLUlGk7TRfgJqmqobW2lWSzQD9HHlN9z7Vy753U+U11HwVBPSKcTnWLPtZC5tGoVctXj1bm0zBpX+nOzOojlCM3tan633JkCSDNtJSj8r8w4xEnsbYj0Big1bh6c+Kb2YPV1TPGFe30DAbfp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDfvR03nTz6J7r8;
	Fri, 14 Mar 2025 17:58:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C306140B39;
	Fri, 14 Mar 2025 18:01:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 11:01:37 +0100
Date: Fri, 14 Mar 2025 10:01:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Huisong Li <lihuisong@huawei.com>
CC: <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] soc: hisilicon: kunpeng_hccs: Fix incorrect string
 assembly
Message-ID: <20250314100136.0000416f@huawei.com>
In-Reply-To: <20250314082856.3257783-1-lihuisong@huawei.com>
References: <20250314082856.3257783-1-lihuisong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 14 Mar 2025 16:28:56 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> String assembly should use sysfs_emit_at() instead of sysfs_emit().
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
Fixes tag?

Otherwise looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index 8aa8dec14911..444a8f59b7da 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -1539,8 +1539,8 @@ static ssize_t used_types_show(struct kobject *kobj,
>  	u16 i;
>  
>  	for (i = 0; i < hdev->used_type_num - 1; i++)
> -		len += sysfs_emit(&buf[len], "%s ", hdev->type_name_maps[i].name);
> -	len += sysfs_emit(&buf[len], "%s\n", hdev->type_name_maps[i].name);
> +		len += sysfs_emit_at(buf, len, "%s ", hdev->type_name_maps[i].name);
> +	len += sysfs_emit_at(buf, len, "%s\n", hdev->type_name_maps[i].name);
>  
>  	return len;
>  }


