Return-Path: <linux-kernel+bounces-334019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2197D16E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5E51F220A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7066341C72;
	Fri, 20 Sep 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qKtBaoQG"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82892CA5
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815865; cv=none; b=QE9xzuLpOfabUeIoJpQzRC1oGJxIcF5Y5rxDAVb5z0JscQLITMP3POGRsE1yO25OdDM2sv2pSJKpvO/pvMMGBDQUXwHMl+7y251p7WSv6G5N9Vh0RNYaHq6Q8cfMbLzIJFTMab3yzXwb83fcv/FSGchvP/KOIiqM0Tr5bQVmTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815865; c=relaxed/simple;
	bh=/NZGPoXKSymMx1PjbyTtLBYVitseKApMOG9T9VuN5m8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R1t/yOxxWElPXcJEWEE5vUjXAu+65HCNAxBskRCUObFMYTSgthdunA8wOTC4zA7U+UuAmRpDgO4bIOBaO/MAy4enW3inTakBmlOinMZojAFTjcX7xZCbxWKuv1v18MOB1HP4MiqSu6X12+8x/BOaA4Nn7g6QGlWbGsDdfhcrx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qKtBaoQG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so14052445e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726815862; x=1727420662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEk9Erg33oAKF+NP+nw1TwEyfMvfxRqOWUUv41eeefs=;
        b=qKtBaoQGMZSg87oYSvZDyZ9DEkWh/T//SZ0TEKTTK/TGSeZRNyPKGTNXfi0gEdscCF
         /6fJ2nq/OzfzEyDrofiL7G+vOgJfTf7GOEce3eeVTOW5GiT8TYd5SqJC/u2gxDIW5rxY
         1Z5YfiFbWclzHuEiLBk6mG3lBbN5/Qlsq3OwfKyJtREiue+tiAtkPjoe9tEZ192N3r6l
         Z0mFWbTERked87puXd2TR1oDXpZ6rKyg5NGxlOeKTUx5aF7fV0LxOxYwzoBuzUyl8keL
         NHHvMjYnYThmqRkPA42qiWReTQTWgN8tB2/hyq8kUWzEET+rm8AaXN+t7b4+3X5r05lk
         NAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726815862; x=1727420662;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AEk9Erg33oAKF+NP+nw1TwEyfMvfxRqOWUUv41eeefs=;
        b=mgQfpdJQwSVHlU8MrGRy8qx+ggPK3DmcIriYfxVuue8udLjOwKZBMgbQYcw6XKNmH5
         ybyBfQaEb0lUBrSVH+GVLTuY2s+W4RA7c7or/E7JXmzebQvUDmRNffuLPnGHk6rd/O4R
         IERAOBZxC77R0mD6h/9AzFuHwhrbXgIq69UzTjfetqNvV/PhJc9Je5s70nCkektLssON
         pVQ7KbZW+KsEhfFmVluohWyhU+LwfbTgKGUh3CkXp1Gu7izUXiRih/rF8BC61XsJFrdE
         8N3oEeuYPYg7yky908Oh50ptzJBuRNM+eZN8jYp+fpM6u60UJqfzbLIrVpTYrm+T2em9
         UCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP6md2LWM5Q1Dtav+qKhrQUVCoX7md2Bq2hREJ7iEUmwLcBCOWMGdSTNHH0K36j3xDcAdPswLKOgAK4ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoM+BDQwb2ljXjeXfwLnTNEHKxiZ5uVwm2uA/p61nR+cgdzavs
	Tty4a2ygmQqLsa/scxuOGdS+35f1wMpC3RATZr9bMcCI4tDRjhnEtJVcQNaKHDM=
X-Google-Smtp-Source: AGHT+IGNO1dkgtnCZ5YKP/6A9L3EnlKsnH+ZENC9f0ny9GIW8vEezb6z+4c9DmLBMtGeBqMGf/ZOOA==
X-Received: by 2002:a05:600c:354a:b0:42c:c1f6:6ded with SMTP id 5b1f17b1804b1-42e7ad9afabmr11697595e9.29.1726815861834;
        Fri, 20 Sep 2024 00:04:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f? ([2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7aff08b1sm14316095e9.40.2024.09.20.00.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 00:04:21 -0700 (PDT)
Message-ID: <e865e42c-a528-45bb-bdf5-df1cd103e695@linaro.org>
Date: Fri, 20 Sep 2024 09:04:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 09/10] drm: bridge: dw_hdmi: Update EDID during hotplug
 processing
To: Jonas Karlman <jonas@kwiboo.se>, Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240908132823.3308029-1-jonas@kwiboo.se>
 <20240908132823.3308029-10-jonas@kwiboo.se>
 <4bc6a5e6-f2cf-43ab-8555-4f8aaf9f2cd0@linaro.org>
 <0dcb03be-dae1-4dcb-84d8-6ec204eab6ba@kwiboo.se>
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
In-Reply-To: <0dcb03be-dae1-4dcb-84d8-6ec204eab6ba@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2024 22:34, Jonas Karlman wrote:
> Hi Neil,
> 
> On 2024-09-13 10:02, Neil Armstrong wrote:
>> On 08/09/2024 15:28, Jonas Karlman wrote:
>>> Update successfully read EDID during hotplug processing to ensure the
>>> connector diplay_info is always up-to-date.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> v2: No change
>>> ---
>>>    drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> index c19307120909..7bd9f895f03f 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> @@ -2457,6 +2457,18 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>>>    
>>>    	status = dw_hdmi_detect(hdmi);
>>>    
>>> +	/* Update EDID during hotplug processing (force=false) */
>>> +	if (status == connector_status_connected && !force) {
>>> +		const struct drm_edid *drm_edid;
>>> +
>>> +		drm_edid = dw_hdmi_edid_read(hdmi, connector);
>>> +		if (drm_edid)
>>> +			drm_edid_connector_update(connector, drm_edid);
>>> +		cec_notifier_set_phys_addr(hdmi->cec_notifier,
>>> +			connector->display_info.source_physical_address);
>>> +		drm_edid_free(drm_edid);
>>> +	}
>>> +
>>>    	if (status == connector_status_disconnected)
>>>    		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
>>>    
>>
>> I wonder why we should read edid at each dw_hdmi_connector_detect() call,
>> AFAIK it should only be when we have HPD pulses
> 
> That is what this change intends to help do.
> 
> As stated in the short comment EDID is only updated at HPD processing,
> i.e. when force=false. To be on the safe side EDID is also only updated
> here when connected and EDID could be read.
> 
> drm_helper_probe_detect() is called with force=true in the
> fill_modes/get_modes call path that is triggered by userspace
> or the kernel kms client.
> 
> After a HPD interrupt the call to drm_helper_hpd_irq_event() will call
> check_connector_changed() that in turn calls drm_helper_probe_detect()
> with force=false to check/detect if connector status has changed. It is
> in this call chain the EDID may be read and updated in this detect ops.
> 
> Reading EDID here at HPD processing may not be fully needed, however it
> help kernel keep the internal EDID state in better sync with sink when
> userspace does not act on the HOTPLUG=1 uevent.


I understand but if somehow a dw-hdmi integration fails to have HDP working
properly, EDID will be read continuously which is really not what we want.

HDMI 1.4b specifies in Section 8.5 and Appendix A:
============><==========================================
An HDMI Sink shall not assert high voltage level on its Hot Plug Detect pin when the E-EDID
is not available for reading.
An HDMI Sink shall indicate any change to the contents of the E-EDID by driving a low
voltage level pulse on the Hot Plug Detect pin. This pulse shall be at least 100 msec.
============><==========================================

So this is OK with the first sentence, and should also work with the second one because
right after the pulse we will read the EDID again, but I think we should have a much
more robust way to detect those 100ms pulses, no ?

Maxime, do you have an opinion on this ?

Neil

> 
> Regards,
> Jonas
> 
>>
>> Neil
> 


