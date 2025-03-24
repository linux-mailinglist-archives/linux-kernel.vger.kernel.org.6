Return-Path: <linux-kernel+bounces-573651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EAAA6DA39
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261821894312
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF56925E838;
	Mon, 24 Mar 2025 12:41:17 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624A4A05
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820077; cv=none; b=sHG9Noc6I5eq/cvgX3lrjzT0s02vCBPbk3BJmUqzUaIxguQIRlDqBbTK8qqzf42T/+rRIEVdob1yvjNe7AnqX42P7MY3K1fabi8NewURU5UE9AGIoa7vDjs1mUUtjilfxBM6T3vX6lRCghpG/RHbbfvXYwPr16GdXqpjkYrnKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820077; c=relaxed/simple;
	bh=YMr8A1MXy/5ea3WPzuUp4F0jarvLktbbVfEpLA71n28=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LkM9210Oiqvo2yo6zy5zoQJNzcBLsVxy0i9ldzJPJYgbBeYXA0YmshpjWbJ41z8gXCoZEFP8io3OW6l7VBEUDFbMxx7czmA6dIfEVFkkUH/14TODxCujKbkffhHpwn1FttXfh1D/f70T2oXfbedzmjBAbkWbxdUJBgvyfihOTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZLsyh2dVWzHrGM;
	Mon, 24 Mar 2025 20:37:48 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B8C0A140123;
	Mon, 24 Mar 2025 20:41:04 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 24 Mar 2025 20:41:03 +0800
Message-ID: <ff11c8ac-7eb4-42cb-86d3-ad9924c9374b@huawei.com>
Date: Mon, 24 Mar 2025 20:41:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 drm-dp 5/9] drm/hisilicon/hibmc: Getting connector info
 and EDID by using AUX channel
To: Jani Nikula <jani.nikula@linux.intel.com>, <xinliang.liu@linaro.org>,
	<tiantao6@hisilicon.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <libaihan@huawei.com>, <shenjian15@huawei.com>,
	<shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <shiyongbang@huawei.com>
References: <20250319032435.1119469-1-shiyongbang@huawei.com>
 <20250319032435.1119469-6-shiyongbang@huawei.com> <87frj8c9ol.fsf@intel.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <87frj8c9ol.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500013.china.huawei.com (7.221.188.12)


> On Wed, 19 Mar 2025, Yongbang Shi <shiyongbang@huawei.com> wrote:
>> From: Baihan Li <libaihan@huawei.com>
>>
>> Add registering drm_aux and use it to get connector edid with drm
>> functions. Add ddc channel in connector initialization to put drm_aux
>> in drm_connector.
>>
>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>> ChangeLog:
>> v6 -> v7:
>>    - add if statement about drm aux in hibmc_dp_connector_get_modes(), suggested by Jani Nikula
> I don't understand this, and I did not suggest such a thing.
>
> BR,
> Jani.
>
Hi Jani,

Is the modification of v8 correct?


>> v5 -> v6:
>>    - move the detect_ctx() to the patch 7/9.
>> v2 -> v3:
>>    - Capitalized EDID and AUX, suggested by Dmitry Baryshkov.
>> v1 -> v2:
>>    - deleting type conversion, suggested by Dmitry Baryshkov.
>>    - deleting hibmc_dp_connector_get_modes() and using drm_connector_helper_get_modes(), suggested by Dmitry Baryshkov.
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   |  3 +-
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 35 ++++++++++++++++---
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  5 +++
>>   3 files changed, 37 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
>> index ded9e7ce887a..e0bb9b14d9d8 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
>> @@ -161,7 +161,8 @@ void hibmc_dp_aux_init(struct hibmc_dp *dp)
>>   				 HIBMC_DP_MIN_PULSE_NUM);
>>   
>>   	dp->aux.transfer = hibmc_dp_aux_xfer;
>> -	dp->aux.is_remote = 0;
>> +	dp->aux.name = kasprintf(GFP_KERNEL, "HIBMC DRM dp aux");
>> +	dp->aux.drm_dev = dp->drm_dev;
>>   	drm_dp_aux_init(&dp->aux);
>>   	dp->dp_dev->aux = &dp->aux;
>>   }
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> index 603d6b198a54..0256724d8b9b 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> @@ -15,11 +15,20 @@
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
>> +	if (!dp->aux.name)
>> +		return 0;
>> +
>> +	drm_edid = drm_edid_read_ddc(connector, &dp->aux.ddc);
>> +
>> +	drm_edid_connector_update(connector, drm_edid);
>> +
>> +	count = drm_edid_connector_add_modes(connector);
>> +
>> +	drm_edid_free(drm_edid);
>>   
>>   	return count;
>>   }
>> @@ -28,12 +37,28 @@ static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
>>   	.get_modes = hibmc_dp_connector_get_modes,
>>   };
>>   
>> +static int hibmc_dp_late_register(struct drm_connector *connector)
>> +{
>> +	struct hibmc_dp *dp = to_hibmc_dp(connector);
>> +
>> +	return drm_dp_aux_register(&dp->aux);
>> +}
>> +
>> +static void hibmc_dp_early_unregister(struct drm_connector *connector)
>> +{
>> +	struct hibmc_dp *dp = to_hibmc_dp(connector);
>> +
>> +	drm_dp_aux_unregister(&dp->aux);
>> +}
>> +
>>   static const struct drm_connector_funcs hibmc_dp_conn_funcs = {
>>   	.reset = drm_atomic_helper_connector_reset,
>>   	.fill_modes = drm_helper_probe_single_connector_modes,
>>   	.destroy = drm_connector_cleanup,
>>   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>> +	.late_register = hibmc_dp_late_register,
>> +	.early_unregister = hibmc_dp_early_unregister,
>>   };
>>   
>>   static inline int hibmc_dp_prepare(struct hibmc_dp *dp, struct drm_display_mode *mode)
>> @@ -103,8 +128,8 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>>   
>>   	drm_encoder_helper_add(encoder, &hibmc_dp_encoder_helper_funcs);
>>   
>> -	ret = drm_connector_init(dev, connector, &hibmc_dp_conn_funcs,
>> -				 DRM_MODE_CONNECTOR_DisplayPort);
>> +	ret = drm_connector_init_with_ddc(dev, connector, &hibmc_dp_conn_funcs,
>> +					  DRM_MODE_CONNECTOR_DisplayPort, &dp->aux.ddc);
>>   	if (ret) {
>>   		drm_err(dev, "init dp connector failed: %d\n", ret);
>>   		return ret;
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index d982f1e4b958..3ddd71aada66 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -47,6 +47,11 @@ static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
>>   	return container_of(connector, struct hibmc_vdac, connector);
>>   }
>>   
>> +static inline struct hibmc_dp *to_hibmc_dp(struct drm_connector *connector)
>> +{
>> +	return container_of(connector, struct hibmc_dp, connector);
>> +}
>> +
>>   static inline struct hibmc_drm_private *to_hibmc_drm_private(struct drm_device *dev)
>>   {
>>   	return container_of(dev, struct hibmc_drm_private, dev);

