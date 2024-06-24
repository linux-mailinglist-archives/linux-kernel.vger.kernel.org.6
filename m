Return-Path: <linux-kernel+bounces-226935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8265B91460C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51231C20944
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800D130495;
	Mon, 24 Jun 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCu8uLdU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB418E29
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220659; cv=none; b=R9k4wLWjKjB3h9jHCVt2LxHz1jnNh02KoACeDcZei+FHD2QQ0A3Ohu/t+YtolXtC2eycLOjoitUs3T7G18MY+ibZb6cr1OR7VOjIgDh2e42DAk5d9gqLX8y7VB1TiSPwiLb0U6xxrLkE12KFeTBteVpN8Rluw97NFaJFkVk8G10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220659; c=relaxed/simple;
	bh=iNco4OU84ax6PELf0P/Ayp8vbmxbgQORq4Wz1bM7TLo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PfvAiO0xoSa0GOfdtfbxQCyUadUCSJSgIGsNcpShPytLVKjVIti+3ARRsdblT4/HbfJidK9K0UidVkrgY/E/tLugO3vZ7YwlG/Pzan0JuP6Sfvz/6Pj7Z/qikYwayY96haI8A7auxORbKedviN6GxDiijSD/gAgtlYPIh5TwZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GCu8uLdU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217990f997so30312275e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719220655; x=1719825455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RjMX4Sxy+yhlFOobpnk3vjTo/Bzp1q3rVeZqfWSaNI=;
        b=GCu8uLdUFwRyDrV90Lfi2cCGHLTVqsE175qcrlYeXeGnnLl48v96ML9WEVvoVfdfxS
         cwjDFPfk3E7t02n5TJ89YqFE0zsLnMg9smVPa5C2+eTBTOYsB2kkyelX0NAshJVc59jX
         yPu4VX38hQb/Pdu/MspxNnA4gu1LJjWhVjej67nf75TESkSeByvNpxb3ae/LJST/Ykgn
         UA8dPkQ8BVbZxAHu6w+2KxOFfZHMTR4lCn3Nby18g4uHADCgPawOY9hdKQ6jduxFtTk5
         C/XnBeIsYGiC+eoFoZ7Mkk25T35pzVqKaCDg291VHvvcW7ssET/TSdjrDofLpKfsJmLG
         qyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719220655; x=1719825455;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1RjMX4Sxy+yhlFOobpnk3vjTo/Bzp1q3rVeZqfWSaNI=;
        b=PVE6Qvm3RlTrWVzge4nm2ga19Wk4RYaXHa+AhrJ7+RVlHptTgEQzAAewQgM6LWBK73
         Jdk1m6bZxSuYN8fNwXFqfav1t+RR4G+SMsE7BdyWdikBSTqoL9DHS1ncpnT48phhUNM1
         CR5gSSlOrJo6oh8LZe2q4xaujqWhgl9SfJ2ctmdTMwIxvU+afk8LZbZO2Wx2elXymY81
         ppBDEzwNS2MNZjx8DBlrfMq/x0XGwqq4tcu04LZ1w9imFUl4OMnid8DZ4CMPO7jYNfTU
         VLeQrV5ltGn9jtAoWLjCpEl/a1dnB9P6pnmKWCVDqy/0UmUqrHfKXXVcp1Iuv8i5axH9
         mPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDlQL86IG+Zt4dVZ9GFcLNPSFi6/1ujc7YQTrvRengfpqBc56IxKkQpfQiPZ5jw3lSF6/mNu6dZbPwGfFXphG2waclHBLIGDTxewD/
X-Gm-Message-State: AOJu0YymdnOlQIOhmdu62vU1V/TQ9KoHeUBjMibf+vTHi8Pv+HzzqxVa
	c6OjjX0V6u78MzkAkzUA0dHtmFJPC+07XZB4meg1gKXc9ABxs+RfAJKsqZsgKZc=
X-Google-Smtp-Source: AGHT+IHYUewn5hUFbxE8VqrCO8oFQ7eystcAYnrIuM5LjL1p71tVpIu4QEqNxCJfEOFEb8XQ45HPmw==
X-Received: by 2002:a05:600c:12d5:b0:423:b627:e3a5 with SMTP id 5b1f17b1804b1-42489e677e5mr39275355e9.38.1719220655034;
        Mon, 24 Jun 2024 02:17:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74? ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817b5549sm132033535e9.23.2024.06.24.02.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 02:17:34 -0700 (PDT)
Message-ID: <8ab7d216-4eb4-4bbb-8372-60ed527b7d4f@linaro.org>
Date: Mon, 24 Jun 2024 11:17:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 8/8] drm: bridge: dw_hdmi: Use display_info is_hdmi and
 has_audio
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240611155108.1436502-1-jonas@kwiboo.se>
 <20240611155108.1436502-9-jonas@kwiboo.se>
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
In-Reply-To: <20240611155108.1436502-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/06/2024 17:51, Jonas Karlman wrote:
> drm_edid_connector_update() is being called from bridge connector ops
> and from detect and get_modes ops for dw-hdmi connector.
> 
> Change to use is_hdmi and has_audio from display_info directly instead
> of keeping our own state in sink_is_hdmi and sink_has_audio.
> 
> Also remove the old and unused edid struct member and related define.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 32 ++++-------------------
>   1 file changed, 5 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a9c39584d31b..e162c2786178 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -43,8 +43,6 @@
>   #define DDC_CI_ADDR		0x37
>   #define DDC_SEGMENT_ADDR	0x30
>   
> -#define HDMI_EDID_LEN		512
> -
>   /* DW-HDMI Controller >= 0x200a are at least compliant with SCDC version 1 */
>   #define SCDC_MIN_SOURCE_VERSION	0x1
>   
> @@ -148,8 +146,6 @@ struct dw_hdmi {
>   
>   	int vic;
>   
> -	u8 edid[HDMI_EDID_LEN];
> -
>   	struct {
>   		const struct dw_hdmi_phy_ops *ops;
>   		const char *name;
> @@ -159,8 +155,6 @@ struct dw_hdmi {
>   
>   	struct i2c_adapter *ddc;
>   	void __iomem *regs;
> -	bool sink_is_hdmi;
> -	bool sink_has_audio;
>   
>   	struct pinctrl *pinctrl;
>   	struct pinctrl_state *default_state;
> @@ -2041,7 +2035,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>   		HDMI_FC_INVIDCONF_IN_I_P_INTERLACED :
>   		HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE;
>   
> -	inv_val |= hdmi->sink_is_hdmi ?
> +	inv_val |= display->is_hdmi ?
>   		HDMI_FC_INVIDCONF_DVI_MODEZ_HDMI_MODE :
>   		HDMI_FC_INVIDCONF_DVI_MODEZ_DVI_MODE;
>   
> @@ -2275,7 +2269,7 @@ static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
>   	if (hdmi->hdmi_data.enc_out_bus_format == MEDIA_BUS_FMT_FIXED)
>   		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>   
> -	hdmi->hdmi_data.rgb_limited_range = hdmi->sink_is_hdmi &&
> +	hdmi->hdmi_data.rgb_limited_range = display->is_hdmi &&
>   		drm_default_rgb_quant_range(mode) ==
>   		HDMI_QUANTIZATION_RANGE_LIMITED;
>   
> @@ -2295,7 +2289,7 @@ static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
>   	/* HDMI Initialization Step B.3 */
>   	dw_hdmi_enable_video_path(hdmi);
>   
> -	if (hdmi->sink_has_audio) {
> +	if (display->has_audio) {
>   		dev_dbg(hdmi->dev, "sink has audio support\n");
>   
>   		/* HDMI Initialization Step E - Configure audio */
> @@ -2304,7 +2298,7 @@ static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
>   	}
>   
>   	/* not for DVI mode */
> -	if (hdmi->sink_is_hdmi) {
> +	if (display->is_hdmi) {
>   		dev_dbg(hdmi->dev, "%s HDMI mode\n", __func__);
>   
>   		/* HDMI Initialization Step F - Configure AVI InfoFrame */
> @@ -2418,29 +2412,13 @@ static const struct drm_edid *dw_hdmi_edid_read(struct dw_hdmi *hdmi,
>   						struct drm_connector *connector)
>   {
>   	const struct drm_edid *drm_edid;
> -	const struct edid *edid;
>   
>   	if (!hdmi->ddc)
>   		return NULL;
>   
>   	drm_edid = drm_edid_read_ddc(connector, hdmi->ddc);
> -	if (!drm_edid) {
> +	if (!drm_edid)
>   		dev_dbg(hdmi->dev, "failed to get edid\n");
> -		return NULL;
> -	}
> -
> -	/*
> -	 * FIXME: This should use connector->display_info.is_hdmi and
> -	 * connector->display_info.has_audio from a path that has read the EDID
> -	 * and called drm_edid_connector_update().
> -	 */
> -	edid = drm_edid_raw(drm_edid);
> -
> -	dev_dbg(hdmi->dev, "got edid: width[%d] x height[%d]\n",
> -		edid->width_cm, edid->height_cm);
> -
> -	hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
> -	hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
>   
>   	return drm_edid;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

