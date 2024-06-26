Return-Path: <linux-kernel+bounces-230391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A420D917C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FD528A7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481A016F0D1;
	Wed, 26 Jun 2024 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/yRgxtP"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060C16EB68
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393149; cv=none; b=cM0817pbK95hao0IGnAkpXvqlVNES5318z4FcxwqdCu2VUTYGM9Uk20GDs7c37HGlS3J56ejYadWuWU1YW/wMZfuFaH9bVnuF4KsfX6lHvWOD5IXR4bhtSRJ4jFjKvjH5Z3PDtOMCV92FiXkW/2ROeCL12+SHkyhxpBSGKjjTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393149; c=relaxed/simple;
	bh=CxVZvsP8mJPz+oaA35+FButrh6bm59DMUjmqtKqhFZo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YOamawcrWc214JB5GmLTk7ssM5csgmM0Zz1obhOiDAQmxPSM+MZlGxB2inY7ftMEiFsP8rfQEF0xCgPlxUuK8Rdqo3vzlbLsjNv8xuPkHvMsBn+UVBIiqAsPed6GNxukWwTbpMQouDFVal87yv0jkUxC6pP4OsJ+aYgmxfFcIaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/yRgxtP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-363826fbcdeso4738771f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719393146; x=1719997946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJIDdwVD2k5g4CopGwX8Y+QYYGOC76Pl/4BHACHUhIw=;
        b=T/yRgxtPI2w8nr+LvzHgN5+d1YK08fZccdgh5zb0IkgK7wpFJZG6KtAoYvOhryr37x
         AJKHK+6riMuGQyJvFlkzq0ozv1TLXr/2lEyuEweH5iYxLnYVH8pbD8nsWRQxSJwqw0Up
         AhJRMW17ljvfksWDEZqbe2W0dzt3SkH8xAzoS3rpsYFrXMAQ8t/q/JE3J1nrw0MnLuBA
         L/BbtbbIe0f+INPRM5iVAC2Qtch6aAEnVH/gSOQsx+THoLxf2oFOBvC24ljgV8u1OuiM
         0U+5e/DQb5lQ03fXhOtxpMPlWlsZcGJOxG7gIisBJwewQo52U2QMpRvhpGY4mu26t9ty
         ko9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719393146; x=1719997946;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJIDdwVD2k5g4CopGwX8Y+QYYGOC76Pl/4BHACHUhIw=;
        b=n1sZ3r1mUkWwHZ/snFOE5oiPopeUnBSJkCmmoziNY0lgpTi5ymxfhzZgTEUEr+40Pu
         SxI4GkTufpcFqD2Ukjm6jXu+s+NY5i8Wh2SBiST13ZFRF2l8SnmySX2BlqPPjptsGBNq
         Si0pm8JXXKSLwEKye+Uyp2iBVCNmDXeAn/fbUrA680b3uKQHZiFZary0RDxUbddOqnFt
         GnAb0DBsHmtaAAqw2EpQGuc9LvjzvdxVQqPj8CGaWBrsCyib/eEtbWEAPr72wO3iDrlC
         oLUPjJkMKyOI+C7HsEScTJwnJj4m1bDcmVDi9qKQf31fwikqh67EZEMQ7pvpNXpzR3ZN
         EC2w==
X-Forwarded-Encrypted: i=1; AJvYcCXJKfMRklGbwode7UbM4fQpS1oLJWMgfoV8bhOKRDet0L3K8czirF3+iCc0WhQQsRBA0kk8zx1EG/RXkhWctny1sMlFZ7Kiu0uyWGhu
X-Gm-Message-State: AOJu0Yy+f1Ou4CL/SVckNBScz56ZRY3cMFfXYdl+JARRBUfofP1BU5he
	/yUJ/IkXzuwWPU/Kxzz88waaM5VlePYiyR90aT1X/p96YU5uGM+bv8CEtj1yFhU=
X-Google-Smtp-Source: AGHT+IGZiUiseO18+zxNZHL14SXXILWN1LiGMQkTEVTh7yA2B9xxXApJEzmPP2KVy/ZU3/5CveX2tw==
X-Received: by 2002:a5d:6551:0:b0:35f:20eb:cae3 with SMTP id ffacd0b85a97d-366e7a51ea9mr7327647f8f.67.1719393145291;
        Wed, 26 Jun 2024 02:12:25 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:fcf:4600:a281:d23c:1a8b:ab6? ([2a01:cb1c:fcf:4600:a281:d23c:1a8b:ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366666ff3f0sm14872928f8f.68.2024.06.26.02.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 02:12:24 -0700 (PDT)
Message-ID: <bb73744f-9b04-410b-b4ec-1c5071016d28@linaro.org>
Date: Wed, 26 Jun 2024 11:12:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] drm/panel: add lincoln lcd197 support
To: Jerome Brunet <jbrunet@baylibre.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org
References: <20240625142552.1000988-1-jbrunet@baylibre.com>
 <20240625142552.1000988-4-jbrunet@baylibre.com>
 <irzer3be5fj2rg2bmc2oqxqtaw6jybbdkgv3jgxpyhdvojwv24@e4i2v6d454nz>
 <1jmsn8gjq6.fsf@starbuckisacylon.baylibre.com>
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
In-Reply-To: <1jmsn8gjq6.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 11:02, Jerome Brunet wrote:
> On Wed 26 Jun 2024 at 07:41, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
>> On Tue, Jun 25, 2024 at 04:25:50PM GMT, Jerome Brunet wrote:
>>> Add support for the Lincoln LCD197 1080x1920 DSI panel.
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>   drivers/gpu/drm/panel/Kconfig                |  11 +
>>>   drivers/gpu/drm/panel/Makefile               |   1 +
>>>   drivers/gpu/drm/panel/panel-lincoln-lcd197.c | 333 +++++++++++++++++++
>>>   3 files changed, 345 insertions(+)
>>>   create mode 100644 drivers/gpu/drm/panel/panel-lincoln-lcd197.c
>>>
>>
>> [...]
>>
>>> +
>>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB9, 0xFF, 0x83, 0x99);
>>
>> - Please use lowercase hex instead
>> - Please consider switching to _multi() functions.
> 
> Could you be a bit more specific about these '_multi' function ?
> I've looked at 'drm_mipi_dsi.h' and can't really make what you mean.
> 
> Maybe I'm not looking in the right place.
> 
>>
>>
>>> +	usleep_range(200, 300);
>>
>> This will require new helper msm_dsi_usleep_range(ctx, 200, 300);
> 
> I don't really understand why I would need something else to just sleep
> ? Could you add some context please ?
> 
> Isn't 'msm_' usually something Qcom specific ?
> 
>>
>>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB6, 0x92, 0x92);
>>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xCC, 0x00);
>>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xBF, 0x40, 0x41, 0x50, 0x49);
>>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xC6, 0xFF, 0xF9);
>>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xC0, 0x25, 0x5A);
>>> +	mipi_dsi_dcs_write_seq(lcd->dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x02);
>>> +
>>> +	err = mipi_dsi_dcs_exit_sleep_mode(lcd->dsi);
>>> +	if (err < 0) {
>>> +		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
>>> +		goto poweroff;
>>> +	}
>>> +	msleep(120);
>>> +
>>> +	err = mipi_dsi_dcs_read(lcd->dsi, MIPI_DCS_GET_DISPLAY_ID, display_id, 3);
>>
>> This probably needs new _multi helper too.
>>
>>> +	if (err < 0) {
>>> +		dev_err(panel->dev, "Failed to read display id: %d\n", err);
>>> +	} else {
>>> +		dev_dbg(panel->dev, "Display id: 0x%02x-0x%02x-0x%02x\n",
>>> +			display_id[0], display_id[1], display_id[2]);
>>> +	}
>>> +
>>> +	lcd->prepared = true;
>>
>> Should not be required anymore.
> 
> The whole driver is heavily inspired by what is already in
> drivers/gpu/drm/panel/ and a lot are doing something similar.
> 
> Maybe there has been a change since then and the existing have been
> reworked yet. Would you mind pointing me that change if that is
> the case ?
> 
>>
>>> +
>>> +	return 0;
>>> +
>>> +poweroff:
>>> +	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
>>> +	gpiod_set_value_cansleep(lcd->reset_gpio, 1);
>>> +	regulator_disable(lcd->supply);
>>> +
>>> +	return err;
>>> +}
>>> +
>>
>>> +
>>> +static const struct drm_display_mode default_mode = {
>>> +	.clock = 154002,
>>> +	.hdisplay = 1080,
>>> +	.hsync_start = 1080 + 20,
>>> +	.hsync_end = 1080 + 20 + 6,
>>> +	.htotal = 1080 + 204,
>>> +	.vdisplay = 1920,
>>> +	.vsync_start = 1920 + 4,
>>> +	.vsync_end = 1920 + 4 + 4,
>>> +	.vtotal = 1920 + 79,
>>> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>>> +};
>>> +
>>> +static int lincoln_lcd197_panel_get_modes(struct drm_panel *panel,
>>> +					  struct drm_connector *connector)
>>> +{
>>> +	struct drm_display_mode *mode;
>>> +
>>> +	mode = drm_mode_duplicate(connector->dev, &default_mode);
>>> +	if (!mode) {
>>> +		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
>>> +			default_mode.hdisplay, default_mode.vdisplay,
>>> +			drm_mode_vrefresh(&default_mode));
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	drm_mode_set_name(mode);
>>> +	drm_mode_probed_add(connector, mode);
>>> +	connector->display_info.width_mm = 79;
>>> +	connector->display_info.height_mm = 125;
>>
>> drm_connector_helper_get_modes_fixed()
> 
> Thanks for the hint
> 
>>
>>> +
>>> +	return 1;
>>> +}
>>> +
>>
>>
>>> +
>>> +static void lincoln_lcd197_panel_shutdown(struct mipi_dsi_device *dsi)
>>> +{
>>> +	struct lincoln_lcd197_panel *lcd = mipi_dsi_get_drvdata(dsi);
>>> +
>>> +	drm_panel_disable(&lcd->panel);
>>> +	drm_panel_unprepare(&lcd->panel);
>>> +}
>>
>> I think the agreement was that there should be no need for the panel's
>> shutdown, the DRM driver should shutdown the panel.
> 
> I'm happy to drop that if there is such agreement. Again, most panel
> drivers do implement that callback so I just did the same.
> 
> Could you point me to this 'agreement' please, so I can get a better
> understanding of it ?
> 

please rebase on linux-next or drm-misc-next and use the new introduced macros
dmitry pointed out.

Neil

