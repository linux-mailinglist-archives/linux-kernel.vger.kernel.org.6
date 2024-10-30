Return-Path: <linux-kernel+bounces-389169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779419B6979
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94791C219F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349F214422;
	Wed, 30 Oct 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nFJ/Pnzu"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B2199381
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306745; cv=none; b=KSbQr/NTw0oBLrRyaa1NCzdbFAoiuAx9iGq2U5fR/uD1H7+uhE1AsIpUb2UsFlMSx1zI5miSWfRyrlBmSzAwSiLBDYHqtbN/MCKHyIB/rjFE+heCwtFM5B0CriURzoswp40aL5j5dFRxqIEsTAoBdJHWgtkTGLgoFp0ISCscAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306745; c=relaxed/simple;
	bh=hcFBMSRwI7XyLVXiwju9iNxMgHCXtPSFdswCTiWGT8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECFXEZDO8bkmDTvRQ+0YwB57ZUEduqU0vnz43RPv2eYdm0zWlkQWl7fQasp2SiQfQ1LmxkUskUJcaev6jCGzPQoJ0ThsWQDIzPOpwy3IDEtCBmvZ1FjEI/AtBAfgshjGy21+bRd9zGD0Bd3aBi6e/+v30WFh0kKnmnSQJLnFMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nFJ/Pnzu; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f2119a4d-7ba3-4f11-91d7-54aac51ef950@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730306737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IImZ1cZVsIXJIGIFBIuoTjHne0xPtt9XDcxUzdxcbs=;
	b=nFJ/PnzuiZtjPkvI0PKl64gdNlEDUbL7oSAq78a1QvDclqZGoe1La2Ah6XdSp1vzNooun7
	bCwWvVAvHmL8gchTeI60zfM3b/WoGPP/2zLD0EmFLUI0Odu5eYChun3lBUKye2a73LAIIs
	yadQopyWqNnFMUSZFHBPqPAtYd1KtN8=
Date: Thu, 31 Oct 2024 00:45:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ux2lfkaeoyakulhllitxraduqjldtxrcmpgsis3us7msixiguq@ff5gfhtkakh2>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ux2lfkaeoyakulhllitxraduqjldtxrcmpgsis3us7msixiguq@ff5gfhtkakh2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/10/18 23:43, Dmitry Baryshkov wrote:
> On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
>> The assignment of the of_node to the aux bridge needs to mark the
>> of_node as reused as well, otherwise resource providers like pinctrl will
>> report a gpio as already requested by a different device when both pinconf
>> and gpios property are present.
>> Fix that by using the device_set_of_node_from_dev() helper instead.
>>
>> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
>> Cc: stable@vger.kernel.org      # 6.8
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>> Changes in v2:
>> - Re-worded commit to be more explicit of what it fixes, as Johan suggested
>> - Used device_set_of_node_from_dev() helper, as per Johan's suggestion
>> - Added Fixes tag and cc'ed stable
>> - Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org
>> ---
>>   drivers/gpu/drm/bridge/aux-bridge.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


Technically speaking, your driver just move the burden to its caller.
Because this driver requires its user call drm_aux_bridge_register()
to create an AUX child device manually, you need it call ida_alloc()
to generate a unique id.

Functions symbols still have to leak to other subsystems, which is
not really preserve coding sharing.

What's worse, the action that allocating unique device id traditionally
is the duty of driver core. Why breaks (so called) perfect device driver
model by moving that out of core. Especially in the DT world that the
core knows very well how to populate device instance and manage the
reference counter.

HPD handling is traditionally belongs to connector, create standalone
driver like this one *abuse* to both Maxime's simple bridge driver and
Laurent's display-connector bridge driver or drm_bridge_connector or
whatever. Why those work can't satisfy you? At least, their drivers
are able to passing the mode setting states to the next bridge.

Basically those AUX drivers implementation abusing the definition of
bridge, abusing the definition of connector and abusing the DT.
Its just manually populate instances across drivers.

  

-- 
Best regards,
Sui


