Return-Path: <linux-kernel+bounces-190141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E056C8CFA0C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95628281051
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EF61AAA5;
	Mon, 27 May 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OrAlROMt"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D617BBF
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794737; cv=none; b=asBtzB1xFiK4dYdhJPHAv/YofN5KxMIXJO/fb0IDc061RQDcYb7hebG8pHaFaOi5bzJMySGjUaiL8tZcqujkXSSlf6xALF+eujtkuD/J60J/4th5NLn8WOSFDMxb5xmGOqNVuqDendLun0SQFAlM7lB15c2FoFeP/gXeZIGr/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794737; c=relaxed/simple;
	bh=QfeiE0U40NEGf0asP0MvksnI9i8b173bQCHhKoQYjZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HPuaN106i1Sb8qYqxEmlo6ulpqfxOAXkq53FIr5xqSqrvuTZPprUF6fN5MM7y4BsEc95H9WHu5pxcJBMQH9pgARbwRIoCDD6BYnF7SyLNwyVjHNJBSrXCkCn1USBf6/Jvs4oHxC9YVJQGnE9Y3aRkiKszKY2rfhV6g+C3p3mawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OrAlROMt; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44R7PHbK089293;
	Mon, 27 May 2024 02:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716794717;
	bh=gg/2NUdGsCVlHuMqI515D/cJ1DeVonBL1Ro+MsON7QU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OrAlROMtYR9Iv36t+7dSdEurT784F1cdMcFIvz0toxbjAbv60k54ke3/ZoqzzSuAN
	 Q5i2get1oYXX9t5PCZzbQbIeS0W0X4eI/LLufT2BJ3MheYHawC7HzVB5QXF287mKgV
	 gnQkVCQnA8nG/oUApvSR7plElzn6Aj6jAw8VDK9g=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44R7PHLK061750
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 02:25:17 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 02:25:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 02:25:16 -0500
Received: from [172.24.227.102] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44R7PAmo049060;
	Mon, 27 May 2024 02:25:11 -0500
Message-ID: <5e7c1f01-70ad-4383-a785-91b0405f3b7d@ti.com>
Date: Mon, 27 May 2024 12:55:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Add mode_valid hook for the
 drm_bridge_funcs
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <u.kleine-koenig@pengutronix.de>, <a-bhatia1@ti.com>,
        <javierm@redhat.com>, <nikhil.nd@ti.com>, <jani.nikula@intel.com>,
        <amishin@t-argos.ru>
References: <20240524071348.106210-1-j-choudhary@ti.com>
 <unpyokzp44mxbycjam375zp3xhxz4vtrhjbafg2hnwycm6e3g3@ywv6hwkdenlz>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <unpyokzp44mxbycjam375zp3xhxz4vtrhjbafg2hnwycm6e3g3@ywv6hwkdenlz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 24/05/24 15:13, Dmitry Baryshkov wrote:
> On Fri, May 24, 2024 at 12:43:48PM +0530, Jayesh Choudhary wrote:
>> With the support for the 'DRM_BRIDGE_ATTACH_NO_CONNECTOR' case,
>> the connector_helper funcs are not initialized if the encoder has this
>> flag in its bridge_attach call. Till now we had mode_valid hook only in
>> the drm_connector_helper_funcs. Add this hook in drm_bridge_funcs to
>> validate the modes in this case as well.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 31 +++++++++++++++----
>>   1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> index 8a91ef0ae065..0aee038f5db7 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> @@ -1617,12 +1617,10 @@ bool cdns_mhdp_bandwidth_ok(struct cdns_mhdp_device *mhdp,
>>   	return true;
>>   }
>>   
>> -static
>> -enum drm_mode_status cdns_mhdp_mode_valid(struct drm_connector *conn,
>> -					  struct drm_display_mode *mode)
>> +static enum
>> +drm_mode_status cdns_mhdp_mode_valid(struct cdns_mhdp_device *mhdp,
>> +				     const struct drm_display_mode *mode)
>>   {
>> -	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
>> -
>>   	mutex_lock(&mhdp->link_mutex);
>>   
>>   	if (!cdns_mhdp_bandwidth_ok(mhdp, mode, mhdp->link.num_lanes,
>> @@ -1635,6 +1633,16 @@ enum drm_mode_status cdns_mhdp_mode_valid(struct drm_connector *conn,
>>   	return MODE_OK;
>>   }
>>   
>> +static enum drm_mode_status
>> +cdns_mhdp_connector_mode_valid(struct drm_connector *conn,
>> +			       struct drm_display_mode *mode)
>> +{
>> +	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
>> +	const struct drm_display_mode *mod = mode;
>> +
>> +	return cdns_mhdp_mode_valid(mhdp, mod);
>> +}
>> +
>>   static int cdns_mhdp_connector_atomic_check(struct drm_connector *conn,
>>   					    struct drm_atomic_state *state)
>>   {
>> @@ -1678,7 +1686,7 @@ static int cdns_mhdp_connector_atomic_check(struct drm_connector *conn,
>>   static const struct drm_connector_helper_funcs cdns_mhdp_conn_helper_funcs = {
>>   	.detect_ctx = cdns_mhdp_connector_detect,
>>   	.get_modes = cdns_mhdp_get_modes,
>> -	.mode_valid = cdns_mhdp_mode_valid,
>> +	.mode_valid = cdns_mhdp_connector_mode_valid,
> 
> Just move it to bridge_funcs and drop it from connector_helper_funcs. It
> should be enough.

Okay.
Will change in v2.

Thanks,
Jayesh

> 
>>   	.atomic_check = cdns_mhdp_connector_atomic_check,
>>   };
>>   
>> @@ -2233,6 +2241,16 @@ static const struct drm_edid *cdns_mhdp_bridge_edid_read(struct drm_bridge *brid
>>   	return cdns_mhdp_edid_read(mhdp, connector);
>>   }
>>   
>> +static enum drm_mode_status
>> +cdns_mhdp_bridge_mode_valid(struct drm_bridge *bridge,
>> +			    const struct drm_display_info *info,
>> +			    const struct drm_display_mode *mode)
>> +{
>> +	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>> +
>> +	return cdns_mhdp_mode_valid(mhdp, mode);
>> +}
>> +
>>   static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
>>   	.atomic_enable = cdns_mhdp_atomic_enable,
>>   	.atomic_disable = cdns_mhdp_atomic_disable,
>> @@ -2247,6 +2265,7 @@ static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
>>   	.edid_read = cdns_mhdp_bridge_edid_read,
>>   	.hpd_enable = cdns_mhdp_bridge_hpd_enable,
>>   	.hpd_disable = cdns_mhdp_bridge_hpd_disable,
>> +	.mode_valid = cdns_mhdp_bridge_mode_valid,
>>   };
>>   
>>   static bool cdns_mhdp_detect_hpd(struct cdns_mhdp_device *mhdp, bool *hpd_pulse)
>> -- 
>> 2.25.1
>>
> 

