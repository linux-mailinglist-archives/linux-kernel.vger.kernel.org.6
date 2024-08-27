Return-Path: <linux-kernel+bounces-303159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D648096083B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1541C1C2293F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFF19EEA4;
	Tue, 27 Aug 2024 11:12:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D8155CBD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757150; cv=none; b=L9+hpVE1UhYu3vHwh32DZ5InuI0HGoCCS7ELs2nlkhBHyAVVwDW1Q5JPHgz4haScaWjIDfPnuob8TN+nbekI3AEcu+tceh0dnPb5XIXd+4weZxiVQbQ3XmmD4yI8Vc1aZekLGLu+dNq8sQrEtTX8ZynVjzb54KGAQX7q0gJqHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757150; c=relaxed/simple;
	bh=WmjlgXASGmmZb1q4qDn67ScmzUJsm33t433K9hKVsNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OlysoTuJbL7rQe9qI6OO26ZMAd0dBjRP+dNG3CRqlE1jkXeollVvw13A4WVCtjXWBODDg15lMmp5qfzocssQmOOswaApWWJeeZxPYzCpLe13/NHEnHpcOYzYFOfTcx8Y3qPPtv+nxbzVTiDuHsRTm/5y1LmrbYVgI40L8/3aJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtPwh2F8TzpStT;
	Tue, 27 Aug 2024 19:10:44 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id CCE27140137;
	Tue, 27 Aug 2024 19:12:24 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 19:12:24 +0800
Message-ID: <716dc0b3-f663-b37d-6d97-fb3c3887a97b@huawei.com>
Date: Tue, 27 Aug 2024 19:12:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/6] soc: hisilicon: kunpeng_hccs: Add the check for
 base address and size of shared memory
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
 <20240823031059.32579-1-lihuisong@huawei.com>
 <20240823031059.32579-4-lihuisong@huawei.com>
 <20240823093858.00007047@Huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20240823093858.00007047@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/23 16:38, Jonathan Cameron 写道:
> On Fri, 23 Aug 2024 11:10:56 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> If the shmem_base_addr from PCCT is zero, hccs_register_pcc_channel will
>> return success. And then driver will access to illegal address when send
>> PCC command. In addition, the size of shared memory used for communication
>> between driver and platform is fixed, namely 64 Bytes which is
>> unchangeable. So add the verification for them.
>>
> As with previous, make it clear if this hardening or fix
> fix to catch a problem on shipping hardware (I assume not, but you never
> know!)
Ack
>
> A comment on existing code inline.  Not a suggestion for a change
> in this series, but maybe for the future.  There are a lot
> of goto err_mbx_channel_Free in here already and this patch adds
> another.  The cleanup there is trivial so DEFINE_FREE() and __free
> usage will make this code quite a bit nicer to read.
Yeah, it's a good way to simplify code on error path.
I will take into account it. thanks for your good suggestion.
>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 24 +++++++++++++++---------
>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> index 6e88f597f267..6055e5091cbd 100644
>> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -170,15 +170,21 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>>   		goto err_mbx_channel_free;
>>   	}
>>   
>> -	if (pcc_chan->shmem_base_addr) {
>> -		cl_info->pcc_comm_addr = ioremap(pcc_chan->shmem_base_addr,
>> -						 pcc_chan->shmem_size);
>> -		if (!cl_info->pcc_comm_addr) {
>> -			dev_err(dev, "Failed to ioremap PCC communication region for channel-%u.\n",
>> -				hdev->chan_id);
>> -			rc = -ENOMEM;
>> -			goto err_mbx_channel_free;
>> -		}
>> +	if (!pcc_chan->shmem_base_addr ||
>> +	    pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
>> +		dev_err(dev, "The base address or size (%llu) of PCC communication region is invalid.\n",
>> +			pcc_chan->shmem_size);
>> +		rc = -EINVAL;
>> +		goto err_mbx_channel_free;
> Worth considering for the future: Maybe a DEFINE_FREE for pcc_mbox_free_channel) makes sense,
> though if you do you should only assign cl_info->pcc_chan after all possible error paths.
Ack
>
>> +	}
>> +
>> +	cl_info->pcc_comm_addr = ioremap(pcc_chan->shmem_base_addr,
>> +					 pcc_chan->shmem_size);
>> +	if (!cl_info->pcc_comm_addr) {
>> +		dev_err(dev, "Failed to ioremap PCC communication region for channel-%u.\n",
>> +			hdev->chan_id);
>> +		rc = -ENOMEM;
>> +		goto err_mbx_channel_free;
>>   	}
>>   
>>   	return 0;
> .

