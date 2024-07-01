Return-Path: <linux-kernel+bounces-235502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750BC91D5E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B752816B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA91748E;
	Mon,  1 Jul 2024 01:50:51 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813C320C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719798651; cv=none; b=nT+k6jtpppB8CVaeQyLmXrXxv9IY1VJEXDE2pKjtcX9wa2BJMSAxrsG7nciXVm5oETIw/Eb5c/0eEEygq4d4cMowCzAbVlFzriRHRMs3JThp7XllFLfKWlGHu/b+c91EWCaysjBJ3odQQlpU3ZTt2mxMJLydmGzjouC7YAF9Pd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719798651; c=relaxed/simple;
	bh=IO66rTH3gOY9h3YRvz5aJeHDd0m97MAxApDzcb8zXwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jm/uC0oVLaLF/CZQZ2HAiSiFEOp/MYxfcOvQ7ucU/24x/Ooz/B0KzNpQVu/Rx+aRvMS7lJPl2zZj8pEKqCtkn+vMZOlF5AqG/puQ3XnjrezC9LuvboDLyrzXwTv4jXn0Bz/2/7Cu2eDW7s1in61cgdcP32jW0i35agkGTQl28Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WC86Q1bHZz1ytj4;
	Mon,  1 Jul 2024 09:46:54 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 515C71A016C;
	Mon,  1 Jul 2024 09:50:39 +0800 (CST)
Received: from [10.174.176.253] (10.174.176.253) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jul 2024 09:50:38 +0800
Message-ID: <d53026fd-70dc-403e-acc9-a1633bb48a23@huawei.com>
Date: Mon, 1 Jul 2024 09:50:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/53] scsi: libsas: Simplify the create*_workqueue()
 calls
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
CC: Lai Jiangshan <jiangshanlai@gmail.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, John Garry
	<john.g.garry@oracle.com>, Damien Le Moal <dlemoal@kernel.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-34-bvanassche@acm.org>
From: Jason Yan <yanaijie@huawei.com>
In-Reply-To: <20240630222904.627462-34-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Bart Van Assche 於 2024/7/1 6:26 寫道:
> Pass a format string to create*_workqueue2() instead of formatting the
> workqueue name before create*_workqueue() is called.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/libsas/sas_init.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

祝一切顺利

