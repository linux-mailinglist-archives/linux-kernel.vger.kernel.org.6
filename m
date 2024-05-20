Return-Path: <linux-kernel+bounces-183686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB3A8C9C98
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439761C21FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3A54BE8;
	Mon, 20 May 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X2Di+fr3"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D350286
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205740; cv=none; b=rC+/l23UQqdsLDzkQC+5ngxUijW30nslnp2HocOZv2SEQr46FGNR0mOtR/+yaahf1N0mOugcYegD8qcJSQ+jfUIS0OOTTdhlyW5uCiBgp83kkaB4LnzWsKEjVx60fQ21pnsojCzbpGZcsjTa7boEY2/pae4Gw6nKTnNxBPJJOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205740; c=relaxed/simple;
	bh=VqdUX1NcNE2BcJqTv3t4UDHdwoGSwHfd9igVtnhIEeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvTlmGLxMOIvPffcCfA6z88OR29+AA11fs6Unkt86PA1wZsH6PQXSzHL880jC0TAk0246QK/wYdwkZFGxnskA3NsLRAZMnuiz1BbrU0IGhEML1cw4+5FbGVJgwFIiMV8YmKQgYIga0uwoiUJcSTx7+0rOR7yDEwo458zP/UBNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X2Di+fr3; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dmitry.baryshkov@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716205735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/2jIMHpQ5bz88ELVTIuNNb4NQxUzvaS8gU5mTaBGSc=;
	b=X2Di+fr32ouYtT2RQoCqmcywfTyjnqOfZwcx88Ts3so/uxK3xC6/dfwwU8kqtpQ9GDfEe1
	bOFxOZB8nCsCcidXjxYqZRPcD/Mim24m42bsN5Bn4DsQH1OODajRu1CgSIdNCNmWFtTfgD
	VG0DdNhqelDu7nJcuYP0CBGQy1b0zik=
X-Envelope-To: victor.liu@nxp.com
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: andrzej.hajda@intel.com
X-Envelope-To: neil.armstrong@linaro.org
X-Envelope-To: rfoss@kernel.org
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: biju.das.jz@bp.renesas.com
X-Envelope-To: u.kleine-koenig@pengutronix.de
X-Envelope-To: aford173@gmail.com
X-Envelope-To: jani.nikula@intel.com
X-Envelope-To: bli@bang-olufsen.dk
Message-ID: <acc508e2-b067-47ef-b3e2-fcac51403fe0@linux.dev>
Date: Mon, 20 May 2024 19:48:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/bridge: adv7511: Exit interrupt handling when
 necessary
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 biju.das.jz@bp.renesas.com, u.kleine-koenig@pengutronix.de,
 aford173@gmail.com, jani.nikula@intel.com, bli@bang-olufsen.dk
References: <20240516101006.2388767-1-victor.liu@nxp.com>
 <evnxopqt5be56vxuxqdj4l3mcd5nrrvucio7jhwgg4emraai3t@gherubdynyip>
 <e2d4e8b4-bab4-448f-8b67-21f2902fdcd2@linux.dev>
 <CAA8EJppH1rYQ5pzkGP+V-=cOPBYMWm=ZK2Ei1ttjOiN6GRDP+w@mail.gmail.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJppH1rYQ5pzkGP+V-=cOPBYMWm=ZK2Ei1ttjOiN6GRDP+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/20/24 19:13, Dmitry Baryshkov wrote:
> On Mon, 20 May 2024 at 14:11, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>>
>> Hi,
>>
>> On 5/20/24 06:11, Dmitry Baryshkov wrote:
>>> On Thu, May 16, 2024 at 06:10:06PM +0800, Liu Ying wrote:
>>>> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
>>>> fails to consider the case where adv7511->i2c_main->irq is zero, i.e.,
>>>> no interrupt requested at all.
>>>>
>>>> Without interrupt, adv7511_wait_for_edid() could return -EIO sometimes,
>>>> because it polls adv7511->edid_read flag by calling adv7511_irq_process()
>>>> a few times, but adv7511_irq_process() happens to refuse to handle
>>>> interrupt by returning -ENODATA.  Hence, EDID retrieval fails randomly.
>>>>
>>>> Fix the issue by checking adv7511->i2c_main->irq before exiting interrupt
>>>> handling from adv7511_irq_process().
>>>>
>>>> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
>>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>>> ---
>>>>    drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>>>> index 6089b0bb9321..2074fa3c1b7b 100644
>>>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>>>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>>>> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>>>>               return ret;
>>>>
>>>>       /* If there is no IRQ to handle, exit indicating no IRQ data */
>>>> -    if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
>>>> +    if (adv7511->i2c_main->irq &&
>>>> +        !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
>>>>           !(irq1 & ADV7511_INT1_DDC_ERROR))
>>>>               return -ENODATA;
>>>
>>> I think it might be better to handle -ENODATA in adv7511_wait_for_edid()
>>> instead. WDYT?
>>>
>>
>> I think this is may deserve another patch.
> 
> My point is that the IRQ handler is fine to remove -ENODATA here,

[...]

> there is no pending IRQ that can be handled. 

But there may has other things need to do in the adv7511_irq_process()
function.

So instead of continuing
> the execution when we know that IRQ bits are not set, 

Even when IRQ bits are not set, it just means that there is no HPD
and no EDID ready-to-read signal. HDMI CEC interrupts still need
to process.


it's better to
> ignore -ENODATA in the calling code and go on with msleep().
> 

So, It's confusing to ignore the -ENODATA here.

-- 
Best regards
Sui

