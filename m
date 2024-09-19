Return-Path: <linux-kernel+bounces-333150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B1F97C48F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670B31F232DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF1D18FC7B;
	Thu, 19 Sep 2024 06:58:40 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6818F2E2;
	Thu, 19 Sep 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729119; cv=none; b=RGPZ+smbRQ7PT9tcmquMdR6oF/bnFq4T+CqfD+c832+aScmFERPuMNqfEQ++KYwQqUhmYBQUL6zHfwQUbCRe3eBxrxqOjUj7JpItT3I++eEx/dTZtaz9Dzcc1XJVaoqStRlwXC2hcPflAvnZ0Hk4dBJ3cIWc71QM6j5uVsl788s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729119; c=relaxed/simple;
	bh=mFJzT8NxDzwmo84tEQEj9nuCkL5wGjlrqpqaPfBgUFk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=cSlNxv94DwBn1at4I9YbtWHv5fjaVLiufZ5z86aDjyfjdyypQPHlj7thgPh6X/B/vLLKDgBvDLk5z5BQnCHWMPSfR9zvBMCy3szXde9f46jur0MuliQptpE3v2VOGiEELPHrzZkSb8UNydN/JeIS5H4RdxpJuLwISsV3K4TigPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X8QsB3cDlzpW1t;
	Thu, 19 Sep 2024 14:41:18 +0800 (CST)
Received: from kwepemj200011.china.huawei.com (unknown [7.202.194.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F2A118007C;
	Thu, 19 Sep 2024 14:43:22 +0800 (CST)
Received: from [10.67.108.52] (10.67.108.52) by kwepemj200011.china.huawei.com
 (7.202.194.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Sep
 2024 14:43:21 +0800
Message-ID: <e73e7301-2d73-4bd8-b84f-df379119c440@huawei.com>
Date: Thu, 19 Sep 2024 14:43:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: qedf: Fix potential null pointer dereference
Content-Language: en-US
From: "liaochen (A)" <liaochen4@huawei.com>
To: <GR-QLogic-Storage-Upstream@marvell.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <skashyap@marvell.com>, <jhasan@marvell.com>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<njavali@marvell.com>
References: <20240913033627.1465713-1-liaochen4@huawei.com>
In-Reply-To: <20240913033627.1465713-1-liaochen4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemj200011.china.huawei.com (7.202.194.23)

On 2024/9/13 11:36, Liao Chen wrote:
> qedf is checked to be null in this if branch, accessing its member will
> cause a null pointer dereference. Fix it by passing a direct NULL into
> the error function.
> 
> Fixes: 51071f0831ea ("scsi: qedf: Don't process stag work during unload and recovery")
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>   drivers/scsi/qedf/qedf_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
> index 4813087e58a1..9d4738db0e51 100644
> --- a/drivers/scsi/qedf/qedf_main.c
> +++ b/drivers/scsi/qedf/qedf_main.c
> @@ -4021,7 +4021,7 @@ void qedf_stag_change_work(struct work_struct *work)
>   	    container_of(work, struct qedf_ctx, stag_work.work);
>   
>   	if (!qedf) {
> -		QEDF_ERR(&qedf->dbg_ctx, "qedf is NULL");
> +		QEDF_ERR(NULL, "qedf is NULL");
>   		return;
>   	}
>   
gentle ping

Thanks,
Chen

