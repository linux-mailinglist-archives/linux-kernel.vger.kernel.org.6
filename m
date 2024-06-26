Return-Path: <linux-kernel+bounces-231112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C91991864F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E372819AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDA18EFC3;
	Wed, 26 Jun 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kqWsH43w"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815F18E776
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417227; cv=none; b=RLJGNEVjGokBPaFeGfLxuN/5ggGEEOhBNG7YrbO1d7FKZ9c5ki8HVQAA5lJoK6+Oktc7Tboch5kHmWVUzCSh2xVfJ+n2a/w2RYfJSHe2s1wuZigBEv7b8YAH9oC0gI+1qIAdRfmX7Vq+E2UHs1DcQScCzac91LEcKYCdh4Sq/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417227; c=relaxed/simple;
	bh=1IZh4xEQWMKnAW2kmKyoJwXV0mG3qqnDY0HTqt9psJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akvXj5+NzSovjMDd+MTV/kQx7XH/EF4tZMp++ZKaxKllhooiKfeBk+RMjhibIwcR3m5td+ThR2Bbgt2eKrHSgtMVc3cujHWXtIe3+jzLgi8AxVQpFZsX6Go+wrAnVftWu5ZhKn2V8/xolVnVnCzxQ58SMEelIPw0BUlx/frnowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kqWsH43w; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-144-210.elisa-laajakaista.fi [91.158.144.210])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 667394CF;
	Wed, 26 Jun 2024 17:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1719417200;
	bh=1IZh4xEQWMKnAW2kmKyoJwXV0mG3qqnDY0HTqt9psJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kqWsH43wVqCAN+HvWIqvgFiLhnz3V0maHoj5QbWNUvxfkO+a41nrQaNeTAKKT/qsq
	 cxIT3kUy2oCkIFWRpt5lFND4ekcr9g+H0IYbJBkA+YHXESNPcpeNA7CkBBZFU729/i
	 QHv2R2dEz2voWtPkmW9FFXJNpwJ5LUS11ICf6RIs=
Message-ID: <b7cf71b8-76fd-4638-a7b6-cc8dbae635bf@ideasonboard.com>
Date: Wed, 26 Jun 2024 18:53:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mipi-dsi: Fix devm unregister & detach
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240619-dsi-devres-fix-v1-1-a5c59310a52e@ideasonboard.com>
 <20240626-gabby-ladybug-of-freedom-08e6eb@houat>
 <66ab4206-d1c8-4aad-99a7-c4c316e343a9@ideasonboard.com>
 <20240626-warping-nondescript-mustang-bfce27@houat>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240626-warping-nondescript-mustang-bfce27@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 18:07, Maxime Ripard wrote:
> On Wed, Jun 26, 2024 at 12:55:39PM GMT, Tomi Valkeinen wrote:
>> On 26/06/2024 11:49, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Wed, Jun 19, 2024 at 12:07:48PM GMT, Tomi Valkeinen wrote:
>>>> From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>>>>
>>>> When a bridge driver uses devm_mipi_dsi_device_register_full() or
>>>> devm_mipi_dsi_attach(), the resource management is moved to devres,
>>>> which releases the resource automatically when the bridge driver is
>>>> unbound.
>>>>
>>>> However, if the DSI host goes away first, the host unregistration code
>>>> will automatically detach and unregister any DSI peripherals, without
>>>> notifying the devres about it. So when the bridge driver later is
>>>> unbound, the resources are released a second time, leading to crash.
>>>
>>> That's super surprising. mipi_dsi_device_unregister calls
>>> device_unregister, which calls device_del, which in turn calls
>>> devres_release_all.
>>
>> Hmm, right.
>>
>>> If that doesn't work like that, then it's what needs to be fixed, and
>>> not worked around in the MIPI-DSI bus.
>>
>> Well, something causes a crash for both the device register/unregister case
>> and the attach/detach case, and the call stacks and debug prints showed a
>> double unregister/detach...
>>
>> I need to dig up the board and check again why the devres_release_all() in
>> device_del() doesn't solve this. But I can probably only get back to this in
>> August, so it's perhaps best to ignore this patch for now.
>>
>> However, the attach/detach case is still valid? I see no devres calls in the
>> detach paths.
> 
> I'm not sure what you mean by the attach/detach case. Do you expect
> device resources allocated in attach to be freed when detach run?

Ah, never mind, the devres_release_all() would of course deal with that too.

However, I just realized/remembered why it crashes.

devm_mipi_dsi_device_register_full() and devm_mipi_dsi_attach() are 
given a device which is used for the devres. This device is probably 
always the bridge device. So when the bridge device goes away, so do 
those resources.

The mipi_dsi_device_unregister() call deals with a DSI device, which was 
created in devm_mipi_dsi_device_register_full(). Unregistering that DSI 
device, which does happen when the DSI host is removed, does not affect 
the devres of the bridge.

So, unloading the DSI host driver causes mipi_dsi_device_unregister() 
and mipi_dsi_detach() to be called (as part of 
mipi_dsi_host_unregister()), and unloading the bridge driver causes them 
to be called again via devres.

  Tomi


