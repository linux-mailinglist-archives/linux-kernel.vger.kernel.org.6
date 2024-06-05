Return-Path: <linux-kernel+bounces-202295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD38FCADB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9F1B22D06
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2D190050;
	Wed,  5 Jun 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmSZspYq"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973014D447
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588095; cv=none; b=DfNYOJuOpczcnKIMSBzyNWhDyUchIHjum94ToI3vciz5tN7N5MunuL7V/jHakOQ19Es8ji4MmveJ6wOwEZ8EM0tCsmt9XE3SRQTQ4zEFe4rThdh+njEXJNS0PRrQwGp2Ru7U9yNxochk3MbGjphbBgjwAYtYXh1sDv50npOUB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588095; c=relaxed/simple;
	bh=DwmE/HJViHW0vSvn1az5xz1JgTTxQ9iyyQrMHPsDVOs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c9llATwMMUg4nZ30PKDS80DU5NpVGniRfWYEpIdqAPxQJiO6DXLu7UX9am+kyp1ZqsE7Z2xOMzIkl+7zb25qNBdPPDjQ1fUdgzcVMZa7sT1Es4IefgvhidmTkVe8sSYblSG2QdzBMx6PPIVqT/52P7VESnre4PBlJWYu7hyBGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FmSZspYq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35dc04717a1so4988050f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717588092; x=1718192892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sq/Mg5xdkn7VG051aeSlr0cnodPM8eEq6trD79vAGKI=;
        b=FmSZspYq6Q2dPVgdsPVC4IYUnRE6lpfP/TdYe3E4nupADPDVaBIZJr6NEoXoi5ObTS
         DZqeb+45JeGzYgyEwq6iZYe69nV0/aIZsx3MvCc/Wvq/QRmQ4uhnBg+eAyj5t3OUC16o
         cPtJNqwm6iQ6soyQndu0GJ+OLmw+Q3Ux4RlZ4HH0BVDwGgi4Sxp7Vjveu+N7H68uAKZu
         OXpsyk6jEIfRCdcScb95PMTs1RUzSQACSdzOc7GGlnvtHmmHGM5+01K//JXKXXUfNhVN
         aDLi0nFFU/vLg0QuwM2lWPO7ZFHuHHmKQVzID4PV4GQRJhs5K06HyzFsw82dmqJHxp7P
         3NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717588092; x=1718192892;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sq/Mg5xdkn7VG051aeSlr0cnodPM8eEq6trD79vAGKI=;
        b=WEuau3ybkepaDl+usqivRtTDZ3QcVBgaiLGsNvXmJjpwDdblZV63z49zxWulSMulBF
         LxlIJzFackvllaiGiKi31BNxs2iI0atWKdoMBzGKlFMVddBOIvkZ/s1Yj0mEqA6QR0K3
         0vdUqub3HF7Mi51rHFQldiHxm5WS/99LBeB7ETNiPKZyAQYcq86k+m88JE7j6u3cTNN9
         2kyzEJCEptO4RW5xurqQKWYKEPktIeIURIImeD77UY4S6NqROl/h3+rlJjGEpBEtiQRE
         tqggmZlw4AYZrWx8eQhbQpjcL0phqyb5KPDnqXx37DdKis1ANkGuXcKWzXHtUD2yCE4r
         VzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfif1AlM7MzY8J6s4CiwA0YT1DjEPs8fsGEyZtwnWa8+JkJVTxPGCOnrqrhs/pa04HPeAr4cTuxHrmo1bvL8+BKvINo1eG6gbcM977
X-Gm-Message-State: AOJu0YzvNRvf+YHhxFmegZk6c8LnvK8Lya8vNiI7FjDh7oJsN3xZ+fj4
	YeJYCpCi3W0u6mLuM1z2jY61WitdNhLLBWAmyAg1JtEwVG9aGcA6dZFqKU4DJhg=
X-Google-Smtp-Source: AGHT+IHlR2SK96JLCdyyN00srFLb5WsC8iq/TUAeaI5Vi/UOfNYzNfpAYVSwhJmvRN6a17FGY+m4Ng==
X-Received: by 2002:a05:6000:b84:b0:35a:dff9:73bd with SMTP id ffacd0b85a97d-35e8ef8fc97mr1926848f8f.56.1717588092369;
        Wed, 05 Jun 2024 04:48:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c7ce:7756:462d:a8bd? ([2a01:e0a:982:cbb0:c7ce:7756:462d:a8bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04cac9asm14374570f8f.34.2024.06.05.04.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 04:48:11 -0700 (PDT)
Message-ID: <5dc16b34-d638-4fab-84e1-cb7db08ad80e@linaro.org>
Date: Wed, 5 Jun 2024 13:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 13/14] drm/bridge: synopsys: Add DW HDMI QP TX controller
 driver
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <20240601-b4-rk3588-bridge-upstream-v1-13-f6203753232b@collabora.com>
 <20240601143226.GA2003970@ravnborg.org>
 <59519381-2729-4839-9882-65a981a0c551@collabora.com>
 <20240604204110.GA84949@ravnborg.org>
 <f656c72e-fac8-4345-9b65-1031ebe81c25@collabora.com>
 <304b4602-8722-4ed0-a555-8dada573ee79@collabora.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <304b4602-8722-4ed0-a555-8dada573ee79@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/06/2024 12:11, Cristian Ciocaltea wrote:
> On 6/5/24 12:34 AM, Cristian Ciocaltea wrote:
>> On 6/4/24 11:41 PM, Sam Ravnborg wrote:
>>> Hi Cristian.
>>>
>>> On Tue, Jun 04, 2024 at 10:32:04PM +0300, Cristian Ciocaltea wrote:
>>>> Hi Sam,
>>>>
>>>> On 6/1/24 5:32 PM, Sam Ravnborg wrote:
>>>>> Hi Cristian,
>>>>>
>>>>> a few drive-by comments below.
>>>>>
>>>>> 	Sam
>>>>>
>>>>>
>>>>>> +
>>>>>> +static const struct drm_connector_funcs dw_hdmi_qp_connector_funcs = {
>>>>>> +	.fill_modes = drm_helper_probe_single_connector_modes,
>>>>>> +	.detect = dw_hdmi_connector_detect,
>>>>>> +	.destroy = drm_connector_cleanup,
>>>>>> +	.force = dw_hdmi_qp_connector_force,
>>>>>> +	.reset = drm_atomic_helper_connector_reset,
>>>>>> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>>>>>> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>>>>>> +};
>>>>>> +
>>>>>> +static int dw_hdmi_qp_bridge_attach(struct drm_bridge *bridge,
>>>>>> +				    enum drm_bridge_attach_flags flags)
>>>>>> +{
>>>>>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>>>>>> +
>>>>>> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>>>>>> +		return drm_bridge_attach(bridge->encoder, hdmi->next_bridge,
>>>>>> +					 bridge, flags);
>>>>>> +
>>>>>> +	return dw_hdmi_connector_create(hdmi, &dw_hdmi_qp_connector_funcs);
>>>>>> +}
>>>>>
>>>>> Are there any users left that requires the display driver to create the
>>>>> connector?
>>>>> In other words - could this driver fail if DRM_BRIDGE_ATTACH_NO_CONNECTOR
>>>>> is not passed and drop dw_hdmi_connector_create()?
>>>>>
>>>>> I did not try to verify this - just a naive question.
>>>>
>>>> I've just tested this and it doesn't work - dw_hdmi_connector_create()
>>>> is still needed.
>>>
>>> Hmm, seems the display driver or some other bridge driver fails to
>>> support "DRM_BRIDGE_ATTACH_NO_CONNECTOR".
>>> what other drivers are involved?
>>
>> Could it be related to the glue driver (updated in the next patch) which
>> is also responsible for setting up the encoder?
>>
>>> Note that my comments here should be seen as potential future
>>> improvements, and do not block the patch from being used.
>>
>> Thanks for the heads up! Will try to get back to this soon and investigate.
>   
> IIUC, modern bridges should not create the connector but rely on display
> drivers to take care of, which in this case is the VOP2 driver. However,
> it also handles some of the older SoCs relying on the non-QP variant of
> DW HDMI IP. Hence the existing dw-hdmi driver would be also impacted in
> order to come up with a proper solution.
> 
> A quick check shows there are several users of this IP:
> 
> $ git grep -E '= dw_hdmi_(bind|probe)\('
> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c:    hdmi->dw_hdmi = dw_hdmi_probe(pdev, plat_data);
> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:      hdmi = dw_hdmi_probe(pdev, plat_data);
> drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c:        hdmi->hdmi = dw_hdmi_probe(pdev, match->data);
> drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c:      hdmi = dw_hdmi_probe(pdev, &ingenic_dw_hdmi_plat_data);
> drivers/gpu/drm/meson/meson_dw_hdmi.c:  meson_dw_hdmi->hdmi = dw_hdmi_probe(pdev, &meson_dw_hdmi->dw_plat_data);
> drivers/gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c: hdmi = dw_hdmi_probe(pdev, &rcar_dw_hdmi_plat_data);
> drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c:            hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
> drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c:  hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
> 
> I didn't check which display drivers would be involved, I'd guess there
> are quite a few of them as well. So it seems this ends up being a pretty
> complex task.

If this would be a brand new driver, then it should only support DRM_BRIDGE_ATTACH_NO_CONNECTOR,
so you should not create a connector from the driver.

The fact dw-hdmi accepts an attach without the flag is for legacy purpose
since some DRM drivers haven't switched to DRM_BRIDGE_ATTACH_NO_CONNECTOR yes,
but it's a requirement for new bridges so at some point you'll need to make
sure the rockchip glue and drm driver supports DRM_BRIDGE_ATTACH_NO_CONNECTOR.

This will greatly simplify the driver!

Neil

> 
> Cristian


