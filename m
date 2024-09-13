Return-Path: <linux-kernel+bounces-327734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF9977A79
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A24F1F26EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901EE15443F;
	Fri, 13 Sep 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qYujvOE6"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0131BD4EB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214537; cv=none; b=bw/wZeEMwR+B+uimMQFiWSWjdmlSTmJIw2HeH9dRGVAK1s58r+USdkpF1rCiDVbvY4/jDd9RCB6KY/Iw4bvgeuYARqtkCUQwu/TQcldRrDg8J+6X1blK/MXL/Shb03NKZ+1zaEJFwnD1V+50Jcaf6zwsL0WrCo0wcWTXuxzmI8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214537; c=relaxed/simple;
	bh=h+pFtVY954vE0hVzhY7ubcpyJvPCEto2CJEjgNZXKBs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cHlVhgZYlXvgZzAfMeWxJ06akmLsM7T29AvFtk3CX2VegHjNdRzmOuryqBvuF2iHl6111EYJjjIfLZeV5IXJdacwDTXopR+cptEOfycfHFGwiwz67qie9gQJ9BiLI4ZoYNhOGyC4+Rip01F0yh+dWBjEUiFe2DhOXhgqVpIElvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qYujvOE6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374ca65cafdso399447f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726214534; x=1726819334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAjUdoyXPSNHLiRF/5bnxLG0wpq4kPs9TC2hjddZOXw=;
        b=qYujvOE6U4YfN6RD+PVOKa8zbWKeQpjvJCFejLaqlRBQVRLCKCOJF1eCiyFvXhb+WO
         84o+pvupb1j1KvicPOTzukX5IBlhtJAZ58UmZatb3jsD8IxjMuxyZ3ivFXADOrFLPzK1
         Ot87ycZqQtfITupqD9WLMpmij4m54D0p47UDfhFtUrav90ZmRX7GITAMPUVwQmV/KTzk
         WsADGvCLu9etTXeyAu4lkbp+LvKF6hcB81MeDtJIuanePcgkRja83ycyJm6uy/6DzaKB
         PEMrVEZ7Vpv5+7Z/laKKGnQT47nJs/wckiz1jV8o8aBI5zz0mM9ePFDTlXJ9/+HNFWjL
         tb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214534; x=1726819334;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KAjUdoyXPSNHLiRF/5bnxLG0wpq4kPs9TC2hjddZOXw=;
        b=E9FKNBi754F+XZi6ZZz83JSNw+wWTn0utd9aC00GBMq9kisVOBnwjDZ5Kb44eZCndF
         OyJlJIISPa/58cJXIo6nCBbzkdoKGtNeLI83V1iWuCXDjOf8RLRQmkF6O08cPALdZAGD
         UmNoispTnv51QW1A2pw/E9p4RZPifmaEUBw8AtET84RujrrdFBjXdHnpwcH62ejoKpY8
         FV/qmuzLEve/miWVbsNuyrENOS/Hp0o0xXNETKmRqDo3xZa80tCo+XDuqtgrCOKmNgiq
         GRFkMMGv0LnNihZ2P5YtXmtkj96FWSGb11+wb9T0nuRzSkwSRPK2JnD+ofiGo0MnCjGa
         ttFA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Pfxt+Ab57sS02CMCRI00LrwuawMGCIK0iJJeeJYpOww5LHN6XBTn1VeZlHSKolZdnvc3dra3d8P2TxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAp4PNEmL07xgX5S7p9BvG89op8BrFwYfr2mBm9IAnX4Kzuaw9
	t+Yk8lZUwJmJmSQIzm28N5ZQHbFQxe4WC3cFMHnCT8AdIIkVDxYIftiFGB9XSa4=
X-Google-Smtp-Source: AGHT+IFqhk+bK1ONAFkVcGqoWxYXj5S5OT3U3eVNN4v3VLfYwyLCWyCWI1nrQX0GDWFegfWc7EvPkg==
X-Received: by 2002:adf:f045:0:b0:374:c101:32 with SMTP id ffacd0b85a97d-378d623c027mr995199f8f.46.1726214533967;
        Fri, 13 Sep 2024 01:02:13 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665108sm16057316f8f.28.2024.09.13.01.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:02:13 -0700 (PDT)
Message-ID: <4bc6a5e6-f2cf-43ab-8555-4f8aaf9f2cd0@linaro.org>
Date: Fri, 13 Sep 2024 10:02:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 09/10] drm: bridge: dw_hdmi: Update EDID during hotplug
 processing
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240908132823.3308029-1-jonas@kwiboo.se>
 <20240908132823.3308029-10-jonas@kwiboo.se>
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
In-Reply-To: <20240908132823.3308029-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 15:28, Jonas Karlman wrote:
> Update successfully read EDID during hotplug processing to ensure the
> connector diplay_info is always up-to-date.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index c19307120909..7bd9f895f03f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2457,6 +2457,18 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>   
>   	status = dw_hdmi_detect(hdmi);
>   
> +	/* Update EDID during hotplug processing (force=false) */
> +	if (status == connector_status_connected && !force) {
> +		const struct drm_edid *drm_edid;
> +
> +		drm_edid = dw_hdmi_edid_read(hdmi, connector);
> +		if (drm_edid)
> +			drm_edid_connector_update(connector, drm_edid);
> +		cec_notifier_set_phys_addr(hdmi->cec_notifier,
> +			connector->display_info.source_physical_address);
> +		drm_edid_free(drm_edid);
> +	}
> +
>   	if (status == connector_status_disconnected)
>   		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
>   

I wonder why we should read edid at each dw_hdmi_connector_detect() call,
AFAIK it should only be when we have HPD pulses

Neil

