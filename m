Return-Path: <linux-kernel+bounces-210944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E5904AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939021C23880
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B7381AF;
	Wed, 12 Jun 2024 05:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rQIhdXDt"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9E36AF5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169770; cv=none; b=Njdoq+cPlM6IvPmY01YpFbTKzx62eW0Njh0NB5wYLR7ujsjv1iRw9lDhYcP5nvl7hf3bmM6p6fYvfdjqt53yZ0CHFpY+QgaYdPR0xfdhpWG4mBBrbnGbBoRPWhwFqq9psxpy27Ic/g3u9vZnxwTtSNHmkYLDqP3u7kZLR5dMpAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169770; c=relaxed/simple;
	bh=35UcWIWYEQHwpKXq+bxmCMU3dqH3YGp239618H0CEGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ORv7IKoTbqLAREadORJ+/DcRgx73o3TxBa50HbNnYqYAEO6mdcbjnFXmpkSKGUKukmCEcFgdW7VQeMV0ZQRl08KegejA9Obrz64C1WWN/H0sSray04HFWxWr8AUtIcLpEC79b7diFtU1vUXPH1gQ9cdYDoZXH8ylS/21vi+y2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rQIhdXDt; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45C5M1ub058704;
	Wed, 12 Jun 2024 00:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718169721;
	bh=7dhCBqMpnOFGD2givG/XRMTkcJbao4lg4u/p3lcH/tI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rQIhdXDtWcbshKXgo7q4vYWzEJE7LgNbPs6k8Qg15WxKCJ2vA1LavmPYy6O6qCFKO
	 enjeCR9AttWLyrigNRDXU/wZ1kl/x7X6ut8QoOr+dQT6WhZATc0zHaxsPKaXuLCNd3
	 US0ffus9ealSwtJkvnDRaXRUqBCUI/qVjLa9T4Ig=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45C5M1PE010122
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 00:22:01 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 00:22:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 00:22:00 -0500
Received: from [172.24.227.55] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45C5Lt3U089569;
	Wed, 12 Jun 2024 00:21:56 -0500
Message-ID: <cc4553df-af5d-4c9f-8b0a-ed35e1cb36fb@ti.com>
Date: Wed, 12 Jun 2024 10:51:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,1/2] drm/bridge: sii902x: Fix mode_valid hook
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Sam Ravnborg <sam@ravnborg.org>
CC: <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <mripard@kernel.org>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
References: <20240530092930.434026-2-j-choudhary@ti.com>
 <e5ce13e6-1007-41c9-bedc-2045d6f75480@linux.dev>
 <20240531133324.GA1715839@ravnborg.org>
 <955a6d94-9a4c-4f7d-974c-819261579f14@linux.dev>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <955a6d94-9a4c-4f7d-974c-819261579f14@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Sui, Sam!

Thanks for the review.

(Sorry for delayed response. I was OoO last week)

On 31/05/24 19:34, Sui Jingfeng wrote:
> Hi, Jayesh
> 
> 
> On 5/31/24 21:33, Sam Ravnborg wrote:
>> Hi Jayesh,
>>
>>>> +
>>>>    static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>>>>        .attach = sii902x_bridge_attach,
>>>>        .mode_set = sii902x_bridge_mode_set,
>>>> @@ -516,6 +529,7 @@ static const struct drm_bridge_funcs 
>>>> sii902x_bridge_funcs = {
>>>>        .atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>>>>        .atomic_get_input_bus_fmts = 
>>>> sii902x_bridge_atomic_get_input_bus_fmts,
>>>>        .atomic_check = sii902x_bridge_atomic_check,
>>>> +    .mode_valid = sii902x_bridge_mode_valid,
>>
>> As you have the possibility to test the driver, it would be nice with a
>> follow-up patch that replaces the use of enable() / disable() with the
>> atomic counterparts.
>>
>> enable() / disable() are deprecated, so it is nice to reduce their use.
> 
> I agree with Sam.
> 
> Please using atomic uniformally with a follow-up patch, the mixed
> using of atomic API and non atomic API is a little bit confusing IMO.
> 
> 

I will change the enable and disable to their atomic counter parts in 
the next revision.

Warm Regards,
-Jayesh



