Return-Path: <linux-kernel+bounces-289500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3ED9546CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF41F21DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADBE1917F1;
	Fri, 16 Aug 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GueLXV7B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E02A1CF;
	Fri, 16 Aug 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804357; cv=none; b=TsPecQ6zvIipZ1PqVbO1+NNOrlFr9NtqSRVP4G1ajUSPqAGOCxX3H8ACqOdmDoaitoSOoHFuLVf/Yz3nkyKYC8H+ijrsisa30nurRMVKOJRwBvV2MmyRKKMfU+/74g4sSrUpg/6d/1YxW4zbN2yLWYNqq/PmVIRu4GIBiHyAwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804357; c=relaxed/simple;
	bh=pLofTd91o0wWJU8JNixZlY8Ra/SBDdCcVleCazLmwnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejv4+NY3ekMKMem/GCRTvqYVE0BAAFGfjpoh7bYJyEHBEmUfySIHgdUwLxEWYbpOxqQABszgNIZsQwSKnhcQljT4r378dB4A00VauhH7Hx3Wi5Y/CPIGRA4AjY//WDGBrbt0eiMrcKEKyy8q4LRM/+NGRS10ij4gjTk0MNI3S6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GueLXV7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2250C32782;
	Fri, 16 Aug 2024 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723804356;
	bh=pLofTd91o0wWJU8JNixZlY8Ra/SBDdCcVleCazLmwnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GueLXV7BGwG7fZy4I0fbUI/Z0Ej3v+TzrxB2dUCWaYCMASrZQDWylsPr0rSVf0siv
	 GkN3GgDeOtOhwAyp2pz456HiamKFeeMgIq8HVOKO/yYfjLfdtpZhah16JbwAPj+/oD
	 AbD/r7vPdPfMRci1hp19hQA+21bTXwlBXiR1t64XqS4rFLYGLs0Me+6g4R8ITDsn2z
	 3CoZ5lVMTDjzrYY1VezX53j723Rhsb3qi9y0SPL9JnOHLVHEBd7KQmTSn6HcqqDE+z
	 Wb3qCP0pCAL+lKTtVf4rFhVji8uoTLOrCs/jeJkg/eFQdegbT+Km69by0m7hliJKLp
	 Vax9mvUyE4xKw==
Message-ID: <5949965e-0155-4ad1-a019-df220140b085@kernel.org>
Date: Fri, 16 Aug 2024 19:32:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ata: libata: Fix memory leak for error path in
 ata_host_alloc()
To: Yu Kuai <yukuai1@huaweicloud.com>, Zheng Qixing <zhengqixing@huawei.com>,
 cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240816035820.2055747-1-zhengqixing@huawei.com>
 <3dfa5352-01d3-dc16-5a75-0b38e5893246@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <3dfa5352-01d3-dc16-5a75-0b38e5893246@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/16/24 15:42, Yu Kuai wrote:
> 在 2024/08/16 11:58, Zheng Qixing 写道:
>> In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
>> for a port, the allocated 'host' structure is not freed before returning
>> from the function. This results in a potential memory leak.
>>
>> This patch adds a kfree(host) before the error handling code is executed
>> to ensure that the 'host' structure is properly freed in case of an
>> allocation failure.
>>
>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>

I did not receive this patch and I do not see it on the list either. Something
went wrong...
Can you resend please ? Thanks.

>> ---
>>   drivers/ata/libata-core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index e4023fc288ac..f27a18990c38 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -5663,8 +5663,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
>>   	}
>>   
>>   	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
>> -	if (!dr)
>> +	if (!dr) {
>> +		kfree(host);
>>   		goto err_out;
>> +	}
> 
> Looks correct, dev_set_drvdata(dev, host) is not called yet.
> ata_devres_release won't free host in this case.
> 
> I'll suggest to return NULL directly here, and then the 'err_out'
> tag can be removed as well.

I do not think so. Since devres_open_group() was called, need to call either
devres_remove_group() or devres_release_group().

> 
> Anyway, with or without the cleanup:
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>>
> Thanks!
>>   
>>   	devres_add(dev, dr);
>>   	dev_set_drvdata(dev, host);
>>
> 

-- 
Damien Le Moal
Western Digital Research


