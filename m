Return-Path: <linux-kernel+bounces-553954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E31A59116
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5366216C31B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA59226559;
	Mon, 10 Mar 2025 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="D7E3vw1X"
Received: from mail-m15586.qiye.163.com (mail-m15586.qiye.163.com [101.71.155.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B9223716;
	Mon, 10 Mar 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602290; cv=none; b=C24dC28OJA0o7LhbYj8JUHDPUylzB6y93uCAgBaGxzs4QZEW5YDv6jeHL1coGlkYRzZcbodvccyobea448w+de96ytIleAfetXBWDISkvX8tas41xTOyzxqKX5BfPbkOnVFVPSCL4SKtpsPynoy2w34IPd7veo/2PNvDDx2xs/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602290; c=relaxed/simple;
	bh=2pIsOvXJeycb7I0Vkk7F9tXEkPBowlnhNuR9vZC2+qI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kxhLznnjna5oMBVzYX19OLalwZnMr7euM9JexzRstyGkQfiZmkZvEZ+Tw9gV81jghAJpX6YWZ+p8cQXkVLPwLk4atszHcliJPJVjCIobFK+Iz5bwQaKZzYR+/WD7NoK5V4x1D9BalzA5U5Eabhl7V9/O94ybN4LNMaWoLxJmWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=D7E3vw1X; arc=none smtp.client-ip=101.71.155.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id dc09eef1;
	Mon, 10 Mar 2025 18:09:19 +0800 (GMT+08:00)
Message-ID: <5dc47134-fabb-4f9c-acc3-8bf37d2cc733@rock-chips.com>
Date: Mon, 10 Mar 2025 18:09:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v7 10/15] drm/rockchip: analogix_dp: Add support to get
 panel from the DP AUX bus
To: Doug Anderson <dianders@chromium.org>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dmitry.baryshkov@linaro.org,
 sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com,
 boris.brezillon@collabora.com, l.stach@pengutronix.de,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250224081325.96724-1-damon.ding@rock-chips.com>
 <20250224081325.96724-11-damon.ding@rock-chips.com>
 <CAD=FV=WS_2JAKMyFFmrNtaN7-O4dh2hOXHc25FytDxXAjAr+5A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAD=FV=WS_2JAKMyFFmrNtaN7-O4dh2hOXHc25FytDxXAjAr+5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNOTFZDTUsfGh1NGkgaH09WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a957f87c7c203a3kunmdc09eef1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORQ6Ghw*MDIMNiM5Vjk6LzNK
	A0IKCg1VSlVKTE9KTUtKSE1KTk5DVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ01DNwY+
DKIM-Signature:a=rsa-sha256;
	b=D7E3vw1XXB1XCYg4ojtoHQqelLn3tRxuF/YnJiS7eKtAHcAJmK6eZVh8POr/PKSys+Oh0rYtPLotv2Gp8EdLwkFeVgjH1md2nhhGOO5PUuohiFVFMSqdP7tYsL4Cg+HhG6fnpIVHcx0r3/pX2DKi4Tz3OBEz6CkZfH4o1zPqTlU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8oDl0bBs3tCfqgA77qPG8Vr+30J/oYlSYqhSGqmt52Q=;
	h=date:mime-version:subject:message-id:from;

Hi Doug,

On 2025/2/25 9:42, Doug Anderson wrote:
> Hi,
> 
> On Mon, Feb 24, 2025 at 12:14 AM Damon Ding <damon.ding@rock-chips.com> wrote:
>>
>> @@ -392,11 +393,27 @@ static const struct component_ops rockchip_dp_component_ops = {
>>          .unbind = rockchip_dp_unbind,
>>   };
>>
>> +static int rockchip_dp_link_panel(struct drm_dp_aux *aux)
>> +{
>> +       struct analogix_dp_plat_data *plat_data = analogix_dp_aux_to_plat_data(aux);
>> +       struct rockchip_dp_device *dp = pdata_encoder_to_dp(plat_data);
>> +       int ret;
>> +
>> +       ret = drm_of_find_panel_or_bridge(dp->dev->of_node, 1, 0, &plat_data->panel, NULL);
>> +       if (ret && ret != -ENODEV)
>> +               return ret;
> 
> Can you explain why you treat -ENODEV as a non-error case here? Maybe
> this is for the non-eDP case (AKA the DP case) where there's no
> further panels or bridges? Maybe a comment would be helpful to remind
> us?
> 

I think the commit 86caee745e45 ("drm/rockchip: analogix_dp: allow to 
work without panel") can help the Analogix DP driver work when the 
bridge is driver-free or when the user uses the eDP IP as a DP.

And I will add some comments in the next version.

> 
>> +       ret = component_add(dp->dev, &rockchip_dp_component_ops);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return ret;
> 
> nit: the above could just be:
> 
> return component_add(dp->dev, &rockchip_dp_component_ops);
> 

Yeah, it is a good idea.

> 
>> @@ -448,9 +460,16 @@ static int rockchip_dp_probe(struct platform_device *pdev)
>>          if (IS_ERR(dp->adp))
>>                  return PTR_ERR(dp->adp);
>>
>> -       ret = component_add(dev, &rockchip_dp_component_ops);
>> -       if (ret)
>> -               return ret;
>> +       ret = devm_of_dp_aux_populate_bus(analogix_dp_get_aux(dp->adp), rockchip_dp_link_panel);
>> +       if (ret) {
>> +               if (ret != -ENODEV)
>> +                       return dev_err_probe(dp->dev, ret,
>> +                                            "failed to populate aux bus : %d\n", ret);
> 
> IIRC this -ENODEV case is for old legacy panels that aren't listed
> under the aux bus in the device tree. Maybe a comment would be helpful
> to remind us?

I will add a comment here if devm_of_dp_aux_populate_bus() returns -ENODEV.

> 
> nit: don't need the %d in your error message. dev_err_probe() already
> prints the error code.
> 

I will remove it in the next version.

> 
>> +               ret = rockchip_dp_link_panel(analogix_dp_get_aux(dp->adp));
>> +               if (ret)
>> +                       return ret;
>> +       }
>>
>>          return 0;
> 
> You can get rid of a few of your return cases by just returning "ret" here.
> 

Yeah, it is better.

> 
> -Doug
> 
> 

Best regards
Damon

