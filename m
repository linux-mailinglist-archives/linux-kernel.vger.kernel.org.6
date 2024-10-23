Return-Path: <linux-kernel+bounces-378315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A5A9ACE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0827C2825AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278FC19AA46;
	Wed, 23 Oct 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rzn/dP1j"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A0154439
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696436; cv=none; b=om3kiSY2+Zt9MfQd81OQgI5pm2aouOZwMP2CN+hHrgyHCrujln0VW6LFCGRXomBojnHbgOPx+ZAu+pjGA7bb3w610Gmpw0RHYPuvfTJl1kpwiRYhNT11nvRGckKeQe7zjHZxwGXjRe8pJY3RUr5GVtBmRmgYIFRwpyOxTa06vLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696436; c=relaxed/simple;
	bh=C1l56v3HMyOoYB5Hj6ka0yLfHWLITvZBAVXhHbTMyuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hV03IMM3/hi5/LPNYFzLxhJg1OG6RbXhDszFDhnMHRC1jcABmIr6zJ4mgcHkH1E7xCL2pGcJvFR0y054znj++jF73c0nRNVeB/eX1LpW3mV3SIQ8uBJJqZfztBqyhu4PlnqfsPJHx4+8YAEbcQVm8Yy+WxIzyUA4P7wvGWJ2WjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rzn/dP1j; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8ab33e8-cba8-48f9-b438-7e6f09f3b068@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729696431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QShPcvbnlf3AY+IgNeQhWdpvwedI8/s0p3vJE4J8yQ=;
	b=rzn/dP1jb/m1DsNvtBJNECwnFg5GQPlY/On+S943JW4glQtX+rBi/tum1hyw25KADruARB
	1g/6F92UUsWdUAgzv+2dRx0P90Q7ovXdvGPPYr1e8Kxu3SpkSlgc56gcPRq0e6GpZMORfJ
	AyD07fmA80xuImjGobpJyWlz28AwP/E=
Date: Wed, 23 Oct 2024 17:13:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc 2/5] RDMA/hns: Fix flush cqe error when racing with
 destroy qp
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
References: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
 <20241022111017.946170-3-huangjunxian6@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241022111017.946170-3-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/22 13:10, Junxian Huang 写道:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> QP needs to be modified to IB_QPS_ERROR to trigger HW flush cqe. But
> when this process races with destroy qp, the destroy-qp process may
> modify the QP to IB_QPS_RESET first. In this case flush cqe will fail
> since it is invalid to modify qp from IB_QPS_RESET to IB_QPS_ERROR.
> 
> Add lock and bit flag to make sure pending flush cqe work is completed
> first and no more new works will be added.
> 
> Fixes: ffd541d45726 ("RDMA/hns: Add the workqueue framework for flush cqe handler")
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>   drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  7 +++++++
>   drivers/infiniband/hw/hns/hns_roce_qp.c     | 14 ++++++++++++--
>   3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 73c78005901e..9b51d5a1533f 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -593,6 +593,7 @@ struct hns_roce_dev;
>   
>   enum {
>   	HNS_ROCE_FLUSH_FLAG = 0,
> +	HNS_ROCE_STOP_FLUSH_FLAG = 1,
>   };
>   
>   struct hns_roce_work {
> @@ -656,6 +657,7 @@ struct hns_roce_qp {
>   	enum hns_roce_cong_type	cong_type;
>   	u8			tc_mode;
>   	u8			priority;
> +	spinlock_t flush_lock;
spin_lock_init is missing?

The spin lock flush_lock should be initialized before used.

Zhu Yanjun
>   };
>   
>   struct hns_roce_ib_iboe {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index e85c450e1809..aa42c5a9b254 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -5598,8 +5598,15 @@ int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>   {
>   	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
>   	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
> +	unsigned long flags;
>   	int ret;
>   
> +	/* Make sure flush_cqe() is completed */
> +	spin_lock_irqsave(&hr_qp->flush_lock, flags);
> +	set_bit(HNS_ROCE_STOP_FLUSH_FLAG, &hr_qp->flush_flag);
> +	spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
> +	flush_work(&hr_qp->flush_work.work);
> +
>   	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
>   	if (ret)
>   		ibdev_err(&hr_dev->ib_dev,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index dcaa370d4a26..3439312b0138 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -90,11 +90,18 @@ static void flush_work_handle(struct work_struct *work)
>   void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>   {
>   	struct hns_roce_work *flush_work = &hr_qp->flush_work;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hr_qp->flush_lock, flags);
> +	/* Exit directly after destroy_qp() */
> +	if (test_bit(HNS_ROCE_STOP_FLUSH_FLAG, &hr_qp->flush_flag)) {
> +		spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
> +		return;
> +	}
>   
> -	flush_work->hr_dev = hr_dev;
> -	INIT_WORK(&flush_work->work, flush_work_handle);
>   	refcount_inc(&hr_qp->refcount);
>   	queue_work(hr_dev->irq_workq, &flush_work->work);
> +	spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
>   }
>   
>   void flush_cqe(struct hns_roce_dev *dev, struct hns_roce_qp *qp)
> @@ -1140,6 +1147,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
>   				     struct ib_udata *udata,
>   				     struct hns_roce_qp *hr_qp)
>   {
> +	struct hns_roce_work *flush_work = &hr_qp->flush_work;
>   	struct hns_roce_ib_create_qp_resp resp = {};
>   	struct ib_device *ibdev = &hr_dev->ib_dev;
>   	struct hns_roce_ib_create_qp ucmd = {};
> @@ -1151,6 +1159,8 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
>   
>   	hr_qp->state = IB_QPS_RESET;
>   	hr_qp->flush_flag = 0;
> +	flush_work->hr_dev = hr_dev;
> +	INIT_WORK(&flush_work->work, flush_work_handle);
>   
>   	if (init_attr->create_flags)
>   		return -EOPNOTSUPP;


