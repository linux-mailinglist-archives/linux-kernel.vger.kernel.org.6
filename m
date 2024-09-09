Return-Path: <linux-kernel+bounces-321654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E534D971DB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51DBCB223F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E535E20B35;
	Mon,  9 Sep 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="MIqkl1aN"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D21C286
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894773; cv=none; b=nQostCWuI6gnkhB+eoFQ5qRKeQQ6QpJky61IILeSbs0Bg9p0nveSu13fwy/Q3va9SkFnF0DmPtc2qMu+cvLr2UnXU0pgilXf4cCOVv3tu9NwBGbXSikYmt5AE8Q5BtJd+BOLXekOCkxAitcSFWLFx8lnvJ005AN7H/PCxGy+x48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894773; c=relaxed/simple;
	bh=sTpCcO1r9uldwT1ZLNILYgRSbmtWwZ+jFO/v7iD+6dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvuGipG1s8LNnEH1vFgkIiA+eCDbXl/8mIUGevpyTnKWBdPcJTtuHaIvgFX7Osl7CNgPIpSrEyONCLKNd+gfqtZhBn4lbW6GtmTYTWKJiTaVIADE2zNpmqusRN8cQXNLwPPD8aAeO7k0tKBZpPF5PmFTwIXJR14f15RpWzmm5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=MIqkl1aN; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1725894747;
 bh=FXnPDua9oM/F12XvXaMhSoJTKFM3q06IAOZGjPkHFmo=;
 b=MIqkl1aN/8T3im1dX1soziq8GA6pmwat9BiZDsmcsvx0koHbaQqPYdTzAO2B0ORiDMypeeY3D
 eJFCy3i0+21GFeJFpQFtuVFWtFGvyEQ5zp33XvPjebX9D3NZwoAf7osh9VxoVRlCTbCY5Uxp/NN
 4sNfPNM0CTJblZhnXo/dEMGkA1wYr9y53MaaJoeINEChbFv7tpUvqNrnBPaUKzzVPysMhW43x1Z
 DQBtQeI4u53d8fBEzJGTo57InOgT9VqdL1RZ2f4eOsaD08z5xHm7QxDo2ZlbzpMCimD06kM6Qyp
 9TGhRcpA+aZLELZ19nndamH8FxibujyVuJbuvxNEtCfQ==
Message-ID: <250d8e1e-20dd-4741-8cf7-c3b4ff9e82a8@kwiboo.se>
Date: Mon, 9 Sep 2024 17:12:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] drm: bridge: dw_hdmi: Only notify connected
 status on HPD interrupt
To: neil.armstrong@linaro.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240908132823.3308029-1-jonas@kwiboo.se>
 <20240908132823.3308029-3-jonas@kwiboo.se>
 <bc0b47d9-ad8d-4beb-aad4-6dff79f48842@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <bc0b47d9-ad8d-4beb-aad4-6dff79f48842@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66df105755874e972a5d499f

Hi Neil,

On 2024-09-09 15:16, Neil Armstrong wrote:
> On 08/09/2024 15:28, Jonas Karlman wrote:
>> drm_helper_hpd_irq_event() and drm_bridge_hpd_notify() may incorrectly
>> be called with a connected status when HPD is high and RX sense is
>> changed. This typically happen when the HDMI cable is unplugged, shortly
>> before the HPD is changed to low.
>>
>> Fix this by only notify connected status on the HPD interrupt when HPD
>> is going high, not on the RX sense interrupt when RX sense is changed.
>>
>> Fixes: da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event on link change")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: New patch
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 9e7f86a0bf5c..055fc9848df4 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -3123,7 +3123,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>>   			mutex_unlock(&hdmi->cec_notifier_mutex);
>>   		}
>>   
>> -		if (phy_stat & HDMI_PHY_HPD)
>> +		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
>> +		    (phy_stat & HDMI_PHY_HPD))
>>   			status = connector_status_connected;
>>   
>>   		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
> 
> Perhaps this should be also checked for the other lines checking HDMI_PHY_HPD ?

I think this is the only place we need to check to match the original
intent of da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug
event on link change").

The interrupt pattern I can see when physically unplugging are:
- RX interrupt:  HPD=high RX=low  -> triggered connected event
- HPD interrupt: HPD=low  RX=low  -> trigger disconnected event

Based on the commit message the intent was to trigger hotplug event:
- when HPD goes high (plugin)
- when both HPD and RX sense has gone low (plugout)

For plugin we should only trigger when HPD=high at HPD interrupt, as is
done after this patch, to avoid unnecessary events when RX changes.

For plugout the event should be triggered when both HPD=low and RX=low,
that can happen at either HPD or RX interrupt.

This should probably be revisited in future, I think we should ignore
RX sense and instead use a work queue and a small debounce timeout after
HPD interrupt or similar, to better support EDID refresh. Something for
a future series.

Regards,
Jonas

> 
> Neil


