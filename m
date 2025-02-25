Return-Path: <linux-kernel+bounces-530847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E30A43936
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F4E17F77D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71524215772;
	Tue, 25 Feb 2025 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+UKbjAT"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C1262D29
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474907; cv=none; b=owvlpZN1pPugdzghJgGKwpQQsh4sJG8Izlpmr7/VWMtHcfYGl0jZ3wJSiNFsH5/mLKUhw198Q2ScvKMSEP/PjWQGZxSIhX4O7dCyJI9MjmTZgAcfz3wtD/nT5nMmHSuJ0nv7GznAEqycZ6XYHjoMpYhPRcOiFh8yFNIg8rFEFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474907; c=relaxed/simple;
	bh=/aoKHTFCh/xZrGmXea5tqIzv5tq6WilIrV4jsOaJ6AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8vp/GgCUXi9EzDKnf7TXXAiEdnRzIFeL6ZAJDxfKkpZm3Z7xUTz7ZZzRpsT1VS0uyDO7bkNkZJ7bhkSE8ElM3TKKYDTa2Sl4OceP9yTv6Kks5vCEt1qod+pWUWgtN/XjksROZIRGFD4AqdQ173FJBeMZ4z3CynGw5bcRBq5Mt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+UKbjAT; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a042e0ff-3c9e-45f9-a621-c15a8fc27965@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740474904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwOgRv8FWM7xC0FLic5dPPFOQVWWI1lXpTN1kw/ZIng=;
	b=C+UKbjATfvY0KqJWT6lphcLfXqHfKo7sdCeqWUhAYnvzIZ4Yr1OGgyBr+bJvChgYPNaTW5
	TpxMuj2FPHWVPSBP7hLMCJsjU0skTjFQehT+r5cBYNUPKViVXigjO7QrL7b+XxdYtJLE96
	WGniK67QN5MD30Jb6CMLXv1kbwh13ew=
Date: Tue, 25 Feb 2025 17:14:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 4/4] stmmac: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Philipp Stanner
 <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>,
 Feiyang Chen <chenfeiyang@loongson.cn>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250224135321.36603-2-phasta@kernel.org>
 <20250224135321.36603-6-phasta@kernel.org>
 <f1c3e538e19aca7fd46dd7f10da190d691bace83.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <f1c3e538e19aca7fd46dd7f10da190d691bace83.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/25/25 3:16 PM, Philipp Stanner 写道:
> On Mon, 2025-02-24 at 14:53 +0100, Philipp Stanner wrote:
>> From: Philipp Stanner <pstanner@redhat.com>
>>
>> The PCI functions
>>    - pcim_iomap_regions() and
>>    - pcim_iomap_table()
>> have been deprecated.
>>
>> Replace them with their successor function, pcim_iomap_region().
>>
>> Make variable declaration order at closeby places comply with reverse
>> christmas tree order.
>>
>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 11 ++++-------
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 14 ++++++------
>> --
>>   2 files changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index f3ea6016be68..25ef7b9c5dce 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -521,10 +521,10 @@ static int loongson_dwmac_acpi_config(struct
>> pci_dev *pdev,
>>   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct
>> pci_device_id *id)
>>   {
>>   	struct plat_stmmacenet_data *plat;
>> +	struct stmmac_resources res = {};
>>   	struct stmmac_pci_info *info;
>> -	struct stmmac_resources res;
>>   	struct loongson_data *ld;
>> -	int ret, i;
>> +	int ret;
>>   
>>   	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>>   	if (!plat)
>> @@ -554,13 +554,11 @@ static int loongson_dwmac_probe(struct pci_dev
>> *pdev, const struct pci_device_id
>>   	pci_set_master(pdev);
>>   
>>   	/* Get the base address of device */
>> -	ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
>> +	res.addr = pcim_iomap_region(pdev, 0, DRIVER_NAME);
>> +	ret = PTR_ERR_OR_ZERO(res.addr);
>>   	if (ret)
>>   		goto err_disable_device;
>>   
>> -	memset(&res, 0, sizeof(res));
>> -	res.addr = pcim_iomap_table(pdev)[0];
>> -
>>   	plat->bsp_priv = ld;
>>   	plat->setup = loongson_dwmac_setup;
>>   	ld->dev = &pdev->dev;
>> @@ -603,7 +601,6 @@ static void loongson_dwmac_remove(struct pci_dev
>> *pdev)
>>   	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
>>   	struct stmmac_priv *priv = netdev_priv(ndev);
>>   	struct loongson_data *ld;
>> -	int i;
> Just saw that this is a left-over that actually should be in patch 3.
> Will fix.
>
Yeah, with this


Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng


