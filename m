Return-Path: <linux-kernel+bounces-569151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAEAA69F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669E618834DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704D1D5AB8;
	Thu, 20 Mar 2025 05:13:44 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD82940F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742447624; cv=none; b=Dk/Bsn/Z5JqZy6Cj5vFDpK+R3FVIHe9Zt1mnSZqH9qMW2XgiAEkwOnK9fOLF0AL6Om6pSQRkXAESZ2qhAXgea0vfM7f8nclkvPkoCmI4kOSaCUCDKjXpVERM24+4hIptOn/+2X4WPDcdrfDnwUdFqEZnc8dWMF8oVesQcGZ/e5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742447624; c=relaxed/simple;
	bh=4MsQlf8PGz+lzBq5JTkQzeIU6qwE8pE/wxnMbHRukPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CgNAx7SJSPc6dHnN4h9RKv91eWBn02eYFk4BPHNSZfz8X7kDepzLiM+xLvdHmNEbZkCyYFQNysT2jkvQNlMpGIGMX95M7yH1buhvSWXx4uN0K2efEgU5RW9tLLqNTL+VoNY4WZyEKRdc7zl28ffq+Q38M94r9sO/7KbVTDu9N1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZJDHf33pXz1d0bX;
	Thu, 20 Mar 2025 13:13:18 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 018A41800EC;
	Thu, 20 Mar 2025 13:13:33 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 20 Mar 2025 13:13:31 +0800
Message-ID: <f619aa56-d41b-4142-8274-51cc3704baf0@huawei.com>
Date: Thu, 20 Mar 2025 13:13:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 drm-dp 5/9] drm/hisilicon/hibmc: Getting connector info
 and EDID by using AUX channel
To: Jani Nikula <jani.nikula@linux.intel.com>, <xinliang.liu@linaro.org>,
	<tiantao6@hisilicon.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <libaihan@huawei.com>, <shenjian15@huawei.com>,
	<shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <shiyongbang@huawei.com>
References: <20250310040138.2025715-1-shiyongbang@huawei.com>
 <20250310040138.2025715-6-shiyongbang@huawei.com> <87o6xyd5nn.fsf@intel.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <87o6xyd5nn.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500013.china.huawei.com (7.221.188.12)


> On Mon, 10 Mar 2025, Yongbang Shi <shiyongbang@huawei.com> wrote:
>> @@ -15,11 +15,17 @@
>>   
>>   static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>>   {
>> +	struct hibmc_dp *dp = to_hibmc_dp(connector);
>> +	const struct drm_edid *drm_edid;
>>   	int count;
>>   
>> -	count = drm_add_modes_noedid(connector, connector->dev->mode_config.max_width,
>> -				     connector->dev->mode_config.max_height);
>> -	drm_set_preferred_mode(connector, 1024, 768); // temporary implementation
>> +	drm_edid = drm_edid_read_ddc(connector, &dp->aux.ddc);
> drm_edid_read() should cover this if connector->ddc is set properly...

Thanks, I got it. I will change it to drm_edid_read() in next patch. I misunderstood what you meant before.


>> @@ -103,8 +125,8 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>>   
>>   	drm_encoder_helper_add(encoder, &hibmc_dp_encoder_helper_funcs);
>>   
>> -	ret = drm_connector_init(dev, connector, &hibmc_dp_conn_funcs,
>> -				 DRM_MODE_CONNECTOR_DisplayPort);
>> +	ret = drm_connector_init_with_ddc(dev, connector, &hibmc_dp_conn_funcs,
>> +					  DRM_MODE_CONNECTOR_DisplayPort, &dp->aux.ddc);
> ...which you seem to do here.
>
> BR,
> Jani.
>
>

