Return-Path: <linux-kernel+bounces-389877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584729B725F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5801C23301
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9913126BF5;
	Thu, 31 Oct 2024 02:04:13 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87812FF9C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340253; cv=none; b=OC2nDTeCneoCPUgwqZk6JqsrgKvS0hjbCR256KXFlOU/fAIlV2qAqHId08vW8GKTP9T67nKIGo4aNBnJlVyQ8WftVHgWL5Lf+wtEeFWbC6VlBp/INmRknxZv1a1UKgv9Z2EefnxhNkyh72Oo76qSBMRXN0l37XflhZAtRkXH0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340253; c=relaxed/simple;
	bh=YDUmfcPcA0+P/Z+iLWIaQSmgTxKG13gKCC3Z1BRXON4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kPErCYQ6qzQzQPUnoi4i/IQsK6ysQ5JoAyhr0o0bod13VWSpjRYScymnriUwR0zcZHA2ZSrmWo5J/RRuvNZPSYPrPzgjQognBHmzoYJw84HHlESj2xa6C5q6Ok/uFz1GRNtPPZ1E+iMpwDSj1/y5tyOr+4U2tZsWfOAeTnT7fwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xf6gS4DJpz1T9Qn;
	Thu, 31 Oct 2024 10:01:56 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D7CE1402E1;
	Thu, 31 Oct 2024 10:04:08 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 10:04:07 +0800
Subject: Re: [PATCH] drm/nouveau/gr/gf100: Fix missing unlock in
 gf100_gr_chan_new()
To: Lyude Paul <lyude@redhat.com>, <kherbst@redhat.com>
CC: <dakr@redhat.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<colin.i.king@gmail.com>, <rdunlap@infradead.org>, <bskeggs@redhat.com>,
	<dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20241026173844.2392679-1-lihuafei1@huawei.com>
 <10f8d1c07a3bf49d643a06ae0b6c11bd4c9dd880.camel@redhat.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <67c66881-231f-1a35-caab-0a6327365e58@huawei.com>
Date: Thu, 31 Oct 2024 10:04:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <10f8d1c07a3bf49d643a06ae0b6c11bd4c9dd880.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/10/30 2:42, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Will push upstream in a moment
>
Thank you for reviewing.

Thanks,
Huafei
> On Sun, 2024-10-27 at 01:38 +0800, Li Huafei wrote:
>> When the call to gf100_grctx_generate() fails, unlock gr->fecs.mutex
>> before returning the error.
>>
>> Fixes smatch warning:
>>
>> drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:480 gf100_gr_chan_new() warn: inconsistent returns '&gr->fecs.mutex'.
>>
>> Fixes: ca081fff6ecc ("drm/nouveau/gr/gf100-: generate golden context during first object alloc")
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
>> index 060c74a80eb1..3ea447f6a45b 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
>> @@ -443,6 +443,7 @@ gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_chan *fifoch,
>>  		ret = gf100_grctx_generate(gr, chan, fifoch->inst);
>>  		if (ret) {
>>  			nvkm_error(&base->engine.subdev, "failed to construct context\n");
>> +			mutex_unlock(&gr->fecs.mutex);
>>  			return ret;
>>  		}
>>  	}
> 

