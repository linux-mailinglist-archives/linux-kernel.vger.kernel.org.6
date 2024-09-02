Return-Path: <linux-kernel+bounces-311896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9AF968F21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B481C22263
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7A61A3A9B;
	Mon,  2 Sep 2024 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="kDv/6r5g"
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176019CC0A;
	Mon,  2 Sep 2024 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725311578; cv=pass; b=UQdsDOcp1OA/BKrpwLnEqpGvHFOt4yVdaz0V6eFsj4S9CHxgcY0uDOvq0ErwY3RGBN2IAnVwAv0M8McWe3UzEQMRc6uwzEs8tmr+xDHtOFO9Gki6JKYPZWHYHzaCGo8OW657lbPHIFm0qu4RLJC4xwBEvElpRMNtOB0F3DZJfhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725311578; c=relaxed/simple;
	bh=82JS3J8b4G3g22pxevQZoT45sO0ad2YjVMFeqqnzguY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWe3a6Q0FNaE2zuhMOnOBTA7HHXXryLd/G/Z8PmnaaLQ0rF0maXbtndXDKoEfwiGwiNtGUR8aljYXHueGiV//s3oMLXES7HMvSrCBvZgZYQBad4ScLHw7pDaR4sXDtI0vzzvARYts+09lN6b5xYMSpkbMWsIMilG0axx9Ii/NTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=kDv/6r5g; arc=pass smtp.client-ip=136.143.184.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725311533; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JwAKCfgdatJkOj+LpW6Ekfn324S4piCedRCyzcE3OihQ52UM3hR04c6dURjvhz0mvqCHAh2q7TFiOsMvsps8jPK8C9AeC5SO0jyrrluM/ELIrj/j2ajamuoBCXYikopmWUeIh9LyrKiXCGiAKcqV8pos47rR/CDYIchX5pIs6iU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725311533; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gcEMGv0FHpr9nNpZ/Gd7YBKiaJiXZ1zN6+bJa53L2CY=; 
	b=ei+qCc4NjAw/WmxNzbGYXPc53dO+llpzmDkXRd3tOUSvprAOSkIMx0CdEBKrymrFMKhhbhHeJNdHMDHZmWBcxQC7cQYO1oz9qt25H/lXcrqzNmXI8vBLfFKLEmdTuHEJD2+O7cCxEBCjE7Do+9+q21jP+iuR4evwxO60Bht5mcc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725311533;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gcEMGv0FHpr9nNpZ/Gd7YBKiaJiXZ1zN6+bJa53L2CY=;
	b=kDv/6r5gyxkyU9MDc6BAPTO89AvtwgPqAhRwO7Hnk9p3rAulIJEVMA+Av0DHG4MI
	6vkXDc+5X9MyQoBzbFP9+IVSaLbfKYulR29gc/KWMvQkU6kxXlurxK091YcXWH6s9rB
	3zAMs5y9MOLWK8tZOwikhRKyQ7Pf8pdUDD04vk4w=
Received: by mx.zohomail.com with SMTPS id 1725311530551764.3736823391141;
	Mon, 2 Sep 2024 14:12:10 -0700 (PDT)
Message-ID: <6e20410a-a24d-4454-8577-2cff65319a2a@collabora.com>
Date: Tue, 3 Sep 2024 00:12:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] drm/bridge: synopsys: Add DW HDMI QP TX Controller
 support library
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <20240819-b4-rk3588-bridge-upstream-v4-2-6417c72a2749@collabora.com>
 <20240827-armored-magnificent-badger-ffb025@houat>
 <34422b7a-ce70-445d-a574-60ac36322119@collabora.com>
 <20240902-turtle-of-major-glory-efb4e8@houat>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20240902-turtle-of-major-glory-efb4e8@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/2/24 10:36 AM, Maxime Ripard wrote:
> On Sat, Aug 31, 2024 at 01:21:48AM GMT, Cristian Ciocaltea wrote:
>> On 8/27/24 11:58 AM, Maxime Ripard wrote:
>>> On Mon, Aug 19, 2024 at 01:29:29AM GMT, Cristian Ciocaltea wrote:
>>>> +static irqreturn_t dw_hdmi_qp_main_hardirq(int irq, void *dev_id)
>>>> +{
>>>> +	struct dw_hdmi_qp *hdmi = dev_id;
>>>> +	struct dw_hdmi_qp_i2c *i2c = hdmi->i2c;
>>>> +	u32 stat;
>>>> +
>>>> +	stat = dw_hdmi_qp_read(hdmi, MAINUNIT_1_INT_STATUS);
>>>> +
>>>> +	i2c->stat = stat & (I2CM_OP_DONE_IRQ | I2CM_READ_REQUEST_IRQ |
>>>> +			    I2CM_NACK_RCVD_IRQ);
>>>> +
>>>> +	if (i2c->stat) {
>>>> +		dw_hdmi_qp_write(hdmi, i2c->stat, MAINUNIT_1_INT_CLEAR);
>>>> +		complete(&i2c->cmp);
>>>> +	}
>>>> +
>>>> +	if (stat)
>>>> +		return IRQ_HANDLED;
>>>> +
>>>> +	return IRQ_NONE;
>>>> +}
>>>
>>> If the scrambler is enabled, you need to deal with hotplug. On hotplug,
>>> the monitor will drop its TMDS ratio and scrambling status, but the
>>> driver will keep assuming it's been programmed.
>>>
>>> If you don't have a way to deal with hotplug yet, then I'd suggest to
>>> just drop the scrambler setup for now.
>>
>> Thanks for the heads up!
>>
>> HPD is partially handled by the RK platform driver, which makes use of
>> drm_helper_hpd_irq_event(). Since the bridge sets DRM_BRIDGE_OP_DETECT
>> flag, the dw_hdmi_qp_bridge_detect() callback gets executed, which in turn
>> verifies the PHY status via ->read_hpd() implemented as
>> dw_hdmi_qp_rk3588_read_hpd() in the platform driver.
> 
> It's not only about hotplug detection, it's also about what happens
> after you've detected a disconnection / reconnection.
> 
> The framework expects to keep the current mode as is, despite the
> monitor not being setup to use the scrambler anymore, and the display
> remains black.

AFAICS, the ->atomic_enable() callback is always invoked upon
reconnection, hence the scrambler gets properly (re)enabled via
dw_hdmi_qp_setup().

>> During my testing so far it worked reliably when switching displays with
>> different capabilities.  I don't have a 4K@60Hz display at the moment, but
>> used the HDMI RX port on the Rock 5B board in a loopback connection to
>> verify this mode, which triggered the high TMDS clock ratio and scrambling
>> setup as well.
> 
> How did you test exactly?

I initially tested with Sway/wlroots having an app running
(eglgears_wayland) while unplugging/replugging the HDMI connectors in
every possible sequence I could think of (e.g. several times per
display, switching to a different one, repeating, switching again, etc).

I've just retested the whole stuff with Weston and confirm it works as
expected, i.e. no black screen (or bad capture stream for the 4K@60Hz
case) after any of the reconnections.

Regards,
Cristian

