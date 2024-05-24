Return-Path: <linux-kernel+bounces-188674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E58CE538
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D62282108
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC61272D5;
	Fri, 24 May 2024 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wEv8x/8u"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B086ADC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553479; cv=none; b=o4xJfNg1wwdZblT0YoiOZtdfOYWvyyE9o1L7XbpPmeCWowLBe0yKKSlxNCNnyg81yMxmeSkEKbwJ4hGwJwG4WV+kFpWo0pH3hapH6f1VIQKRNvXxb2HOnV6ok8xqlxAeXLv/uJnXiA0nzzm7g7RCuxo/iyaahoZJJrjBiYK2pJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553479; c=relaxed/simple;
	bh=8/a7npM7hJqrQbYOsMWig+hn/LOVNlmliFUO66jQTgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SYEuXeIsm7OAyOJHsMDO7IdH40a1sLA4dSAroYoTJM7wQ7SY/DZSAhJQv6a61WjDxLNEwXGBVPyaWNLXfMd+paHfcyr1LNHI063JQ2BVvRL5QBIwCSt5MgO5LEMEkZgNkaNaG1d/VW3wdC/3Kya6CakENvnE3eQHoViyh4ZWdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wEv8x/8u; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44OCOAeB072566;
	Fri, 24 May 2024 07:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716553450;
	bh=3qMBw6WRH8Qi98NWykEp6y7Qays0g4/TXrxegpA4IRg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wEv8x/8u7GA+R60hURzHW2DHcLRKNDLaSzbzJ5xtKx2Zyas18lPRLGu33jmOqCgYy
	 zd8R4KRTUWOSUQDCp42AzAXGuIwoQhcAPggFV9wz8ixKQAnpZIBx6knsskXX69QBdd
	 brlOEHu7XruS4mfYBvkIR2bRZkjnXX6dhAtdFvj4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44OCOAET003898
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 07:24:10 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 07:24:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 07:24:09 -0500
Received: from [172.24.227.102] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44OCO4k8051568;
	Fri, 24 May 2024 07:24:05 -0500
Message-ID: <4cd64cf5-d2b0-4aa9-b958-6b6fc54f0bf2@ti.com>
Date: Fri, 24 May 2024 17:54:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/bridge: sii902x: Fix mode_valid hook
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <sam@ravnborg.org>,
        <mripard@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>
References: <20240524093509.127189-1-j-choudhary@ti.com>
 <20240524093509.127189-2-j-choudhary@ti.com>
 <y6ersd72tp2d6k4i2hja7bg37lahnvye2qion67urxeakw6rju@dher7oomt2ks>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <y6ersd72tp2d6k4i2hja7bg37lahnvye2qion67urxeakw6rju@dher7oomt2ks>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Dmitry,

On 24/05/24 15:11, Dmitry Baryshkov wrote:
> On Fri, May 24, 2024 at 03:05:08PM +0530, Jayesh Choudhary wrote:
>> Currently, mode_valid hook returns all mode as valid and it is
>> defined only in drm_connector_helper_funcs. With the introduction of
>> 'DRM_BRIDGE_ATTACH_NO_CONNECTOR', connector is not initialized in
>> bridge_attach call for cases when the encoder has this flag enabled.
>> So add the mode_valid hook in drm_bridge_funcs as well with proper
>> clock checks for maximum and minimum pixel clock supported by the
>> bridge.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

[...]

>> +
>>   static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
>>   					       struct drm_display_mode *mode)
>>   {
>> -	/* TODO: check mode */
>> +	struct sii902x *sii902x = connector_to_sii902x(connector);
>> +	const struct drm_display_mode *mod = mode;
>>   
>> -	return MODE_OK;
>> +	return sii902x_validate(sii902x, mod);
> 
> There is no need to. The drm_bridge_chain_mode_valid() should take care
> of calling bridge's mode_valid callback and rejecting the mode if it is
> not accepted.

I need some clarity here.

IIRC, if the bridge does initialize the connector in case
where the encoder does not attach the bridge with the
DRM_BRIDGE_ATTACH_NO_CONNECTOR (DBANC) flag (referring to tidss
encoder before we implemented the DBANC feature), then
drm_connector_helper_func are called and drm_bridge_funcs
are NOT called (atleast from what I have seen in detect
hook for cdns-mhdp-8546 driver which is there in both
structures).

I do not have any platform to test non-DBANC encoders.
And I did not want to break any platform that were still using
bridge_attach without DBANC flag.
That is why I kept mode_valid hook in both structures.

Are you implying that if connector_helper_funcs are not there
then there will be some sort of fallback to bridge_funcs instead
of passthrough for mode_valid check? Because that goes against my
previous observations.

Thanks,
Jayesh



