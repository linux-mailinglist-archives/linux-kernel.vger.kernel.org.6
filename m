Return-Path: <linux-kernel+bounces-303710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C39961417
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E272285091
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08B1CDA23;
	Tue, 27 Aug 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4bdlIuh"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0A61CC142
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776330; cv=none; b=cZ7v8/rJ6TXUdoeYfp2gsZyju3qNSainpofkQlUbF6GsKnrzTWNQvlpNInJZnT+2e9wACOtuYIDJwS9WOR1v8soUZAVjQ5YVE559gFaS5N8XqI5R/YK4YZEA8uop316J4gdPW8fN2femJOKBF4PwbFZAjaQYkqR0cKNSRZB20PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776330; c=relaxed/simple;
	bh=3c8Z3fjRZy+h1EuBVQHFN/DbWe4QfIrkWCZ+o/YgEWw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=STXCVvfuneHQgXGwcdHxBJl83dDxBwIB5px+N2vvpcSFwqVXUxOb02y8jZN8oY6vd9HCO28Etz7zJ3pjF3EmB2MoiESXaFUOT8K/MPFyhbgq8qlncWWWhoCTApKwwyIbAj2eJcKEwRjaSVKLcmn7dCzd7PwETY2Sxvxb0WIBIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n4bdlIuh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37182eee02dso3127819f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724776327; x=1725381127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2GA1kFg4bwsjPats8Iqr30M6pzfeQqTgWzcSHQLlMQ=;
        b=n4bdlIuhRQx5Or2v3p0UO03gQWcYtGEL/OapaTgtMRqI2a/XX8czH8tPMDYWWPflXd
         QNdNnNVgqDe93N6VphUKHsMrjjGERnTtGIiJKHWASsp+BgszgHC5gUv98FpNfuU7C7Fz
         W+ETZWSN1PHlPjLTN6f+69DgCMisq7nCZQHvMnhnjYqZhVJlqwCqIUvUOJJxzLnOF0zY
         foXPEAGoy6tULRlkHJdWrQQ0FjHNf0R7xXwQf2bo3NKoGufu4fRIq7ixiV65EE0ySLNm
         mpzovTXhb/Cynm0ISbdTd5nxkoEB00LsXLNqnzMdkPo3iDGTVbmrh+S8vCPT5aNr+/cC
         CX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724776327; x=1725381127;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N2GA1kFg4bwsjPats8Iqr30M6pzfeQqTgWzcSHQLlMQ=;
        b=nFJPfWLdW0Rlwj6V5uevM6V9l6R973/idX7C7yWO4HF4XlahF8T4cjzVV+oBhchhL5
         TuxzOFqRBdbbWfuwEFDg1R8LueOSpgDXap3//QaW3GXztTx+RhTpM8Z2tm6oOrF23fUN
         USklGhEn0zBMfP+T3nmwsK28bytGfL4IyvbELMjLXsMaoEu9Vp8LhFZvFXx1EdNJ24Zz
         FdTe2RrI70TSySXck5OAlurQrK9IUJsXF14MNfU2Ctvf2Q+xAhKc+pes8EMAGXvN9H+R
         PSJy7TO2++J/u/5MDwKfE+g9hu9gagtfv85BvHc4lQK+HExGaCmTtw9zNv3mU02HkSCi
         22Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXcEU6N22dbxU+KEUcvZvX6nLlPEAQl3V6fhLkrtrsob/0XHBpUbR2OjCky/0sODcwTSTFwa8prxCfPgT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDxcvYHWKRCsjhxFUDmxIN03mzNRSUmcdA8D8aSSx7GcAOAcL
	UEn62WPZaRAxoRVlbOBxnMppK9bqChdx610oLgOC5uHHezRPV95QdVXZQ3ulruM=
X-Google-Smtp-Source: AGHT+IFh450mSgeYREKHVr3vSUg/8Mffx5Z7eXeTZGxL+qvQuWQYOdeLe4RVD68qvdHzv+ZisuQBhA==
X-Received: by 2002:adf:ecd0:0:b0:366:eadc:573f with SMTP id ffacd0b85a97d-3748c89dd9cmr2174194f8f.27.1724776326372;
        Tue, 27 Aug 2024 09:32:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cedc:30f:887e:7717? ([2a01:e0a:982:cbb0:cedc:30f:887e:7717])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc62dbsm227485595e9.30.2024.08.27.09.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 09:32:05 -0700 (PDT)
Message-ID: <fd75381f-e39c-404c-b71d-19364e958226@linaro.org>
Date: Tue, 27 Aug 2024 18:32:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: novatek-nt35950: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240824084422.202946-1-tejasvipin76@gmail.com>
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
In-Reply-To: <20240824084422.202946-1-tejasvipin76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2024 10:44, Tejas Vipin wrote:
> Changes the novatek-nt35950 panel to use multi style functions for
> improved error handling.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt35950.c | 214 ++++++------------
>   1 file changed, 70 insertions(+), 144 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> index 028fdac293f7..fa4db7a3bc25 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> @@ -100,106 +100,89 @@ static void nt35950_reset(struct nt35950 *nt)
>   
>   /*
>    * nt35950_set_cmd2_page - Select manufacturer control (CMD2) page
> + * @dsi_ctx: context for mipi_dsi functions
>    * @nt:   Main driver structure
>    * @page: Page number (0-7)
> - *
> - * Return: Number of transferred bytes or negative number on error
>    */
> -static int nt35950_set_cmd2_page(struct nt35950 *nt, u8 page)
> +static void nt35950_set_cmd2_page(struct mipi_dsi_multi_context *dsi_ctx,
> +				  struct nt35950 *nt, u8 page)
>   {
>   	const u8 mauc_cmd2_page[] = { MCS_CMD_MAUCCTR, 0x55, 0xaa, 0x52,
>   				      0x08, page };
> -	int ret;
>   
> -	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], mauc_cmd2_page,
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, mauc_cmd2_page,
>   					ARRAY_SIZE(mauc_cmd2_page));
> -	if (ret < 0)
> -		return ret;
> +	if (dsi_ctx->accum_err)
> +		return;
>   
>   	nt->last_page = page;
> -	return 0;
>   }
>   
>   /*
>    * nt35950_set_data_compression - Set data compression mode
> + * @dsi_ctx: context for mipi_dsi functions
>    * @nt:        Main driver structure
>    * @comp_mode: Compression mode
> - *
> - * Return: Number of transferred bytes or negative number on error
>    */
> -static int nt35950_set_data_compression(struct nt35950 *nt, u8 comp_mode)
> +static void nt35950_set_data_compression(struct mipi_dsi_multi_context *dsi_ctx,
> +					 struct nt35950 *nt, u8 comp_mode)
>   {
>   	u8 cmd_data_compression[] = { MCS_PARAM_DATA_COMPRESSION, comp_mode };
>   	u8 cmd_vesa_dsc_on[] = { MCS_PARAM_VESA_DSC_ON, !!comp_mode };
>   	u8 cmd_vesa_dsc_setting[] = { MCS_PARAM_VESA_DSC_SETTING, 0x03 };
>   	u8 last_page = nt->last_page;
> -	int ret;
>   
>   	/* Set CMD2 Page 0 if we're not there yet */
> -	if (last_page != 0) {
> -		ret = nt35950_set_cmd2_page(nt, 0);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	if (last_page != 0)
> +		nt35950_set_cmd2_page(dsi_ctx, nt, 0);
>   
> -	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_data_compression,
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_data_compression,
>   					ARRAY_SIZE(cmd_data_compression));
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_vesa_dsc_on,
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_vesa_dsc_on,
>   					ARRAY_SIZE(cmd_vesa_dsc_on));
> -	if (ret < 0)
> -		return ret;
>   
>   	/* Set the vesa dsc setting on Page 4 */
> -	ret = nt35950_set_cmd2_page(nt, 4);
> -	if (ret < 0)
> -		return ret;
> +	nt35950_set_cmd2_page(dsi_ctx, nt, 4);
>   
>   	/* Display Stream Compression setting, always 0x03 */
> -	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_vesa_dsc_setting,
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_vesa_dsc_setting,
>   					ARRAY_SIZE(cmd_vesa_dsc_setting));
> -	if (ret < 0)
> -		return ret;
>   
>   	/* Get back to the previously set page */
> -	return nt35950_set_cmd2_page(nt, last_page);
> +	nt35950_set_cmd2_page(dsi_ctx, nt, last_page);
>   }
>   
>   /*
>    * nt35950_set_scaler - Enable/disable resolution upscaling
> - * @nt:        Main driver structure
> + * @dsi_ctx: context for mipi_dsi functions
>    * @scale_up:  Scale up function control
> - *
> - * Return: Number of transferred bytes or negative number on error
>    */
> -static int nt35950_set_scaler(struct nt35950 *nt, u8 scale_up)
> +static void nt35950_set_scaler(struct mipi_dsi_multi_context *dsi_ctx,
> +			       u8 scale_up)
>   {
>   	u8 cmd_scaler[] = { MCS_PARAM_SCALER_FUNCTION, scale_up };
>   
> -	return mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_scaler,
> -					 ARRAY_SIZE(cmd_scaler));
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_scaler,
> +					ARRAY_SIZE(cmd_scaler));
>   }
>   
>   /*
>    * nt35950_set_scale_mode - Resolution upscaling mode
> - * @nt:   Main driver structure
> + * @dsi_ctx: context for mipi_dsi functions
>    * @mode: Scaler mode (MCS_DATA_COMPRESSION_*)
> - *
> - * Return: Number of transferred bytes or negative number on error
>    */
> -static int nt35950_set_scale_mode(struct nt35950 *nt, u8 mode)
> +static void nt35950_set_scale_mode(struct mipi_dsi_multi_context *dsi_ctx,
> +				   u8 mode)
>   {
>   	u8 cmd_scaler[] = { MCS_PARAM_SCALEUP_MODE, mode };
>   
> -	return mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_scaler,
> -					 ARRAY_SIZE(cmd_scaler));
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_scaler,
> +					ARRAY_SIZE(cmd_scaler));
>   }
>   
>   /*
>    * nt35950_inject_black_image - Display a completely black image
> - * @nt:   Main driver structure
> + * @dsi_ctx: context for mipi_dsi functions
>    *
>    * After IC setup, the attached panel may show random data
>    * due to driveric behavior changes (resolution, compression,
> @@ -208,43 +191,34 @@ static int nt35950_set_scale_mode(struct nt35950 *nt, u8 mode)
>    * the display.
>    * It makes sense to push a black image before sending the sleep-out
>    * and display-on commands.
> - *
> - * Return: Number of transferred bytes or negative number on error
>    */
> -static int nt35950_inject_black_image(struct nt35950 *nt)
> +static void nt35950_inject_black_image(struct mipi_dsi_multi_context *dsi_ctx)
>   {
>   	const u8 cmd0_black_img[] = { 0x6f, 0x01 };
>   	const u8 cmd1_black_img[] = { 0xf3, 0x10 };
>   	u8 cmd_test[] = { 0xff, 0xaa, 0x55, 0xa5, 0x80 };
> -	int ret;
>   
>   	/* Enable test command */
> -	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_test, ARRAY_SIZE(cmd_test));
> -	if (ret < 0)
> -		return ret;
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_test, ARRAY_SIZE(cmd_test));
>   
>   	/* Send a black image */
> -	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd0_black_img,
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd0_black_img,
>   					ARRAY_SIZE(cmd0_black_img));
> -	if (ret < 0)
> -		return ret;
> -	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd1_black_img,
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd1_black_img,
>   					ARRAY_SIZE(cmd1_black_img));
> -	if (ret < 0)
> -		return ret;
>   
>   	/* Disable test command */
>   	cmd_test[ARRAY_SIZE(cmd_test) - 1] = 0x00;
> -	return mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_test, ARRAY_SIZE(cmd_test));
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_test, ARRAY_SIZE(cmd_test));
>   }
>   
>   /*
>    * nt35950_set_dispout - Set Display Output register parameters
>    * @nt:    Main driver structure
> - *
> - * Return: Number of transferred bytes or negative number on error
> + * @dsi_ctx: context for mipi_dsi functions
>    */
> -static int nt35950_set_dispout(struct nt35950 *nt)
> +static void nt35950_set_dispout(struct mipi_dsi_multi_context *dsi_ctx,
> +				struct nt35950 *nt)
>   {
>   	u8 cmd_dispout[] = { MCS_PARAM_DISP_OUTPUT_CTRL, 0x00 };
>   	const struct nt35950_panel_mode *mode_data = nt->desc->mode_data;
> @@ -254,8 +228,8 @@ static int nt35950_set_dispout(struct nt35950 *nt)
>   	if (mode_data[nt->cur_mode].enable_sram)
>   		cmd_dispout[1] |= MCS_DISP_OUT_SRAM_EN;
>   
> -	return mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_dispout,
> -					 ARRAY_SIZE(cmd_dispout));
> +	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_dispout,
> +					ARRAY_SIZE(cmd_dispout));
>   }
>   
>   static int nt35950_get_current_mode(struct nt35950 *nt)
> @@ -284,109 +258,68 @@ static int nt35950_on(struct nt35950 *nt)
>   {
>   	const struct nt35950_panel_mode *mode_data = nt->desc->mode_data;
>   	struct mipi_dsi_device *dsi = nt->dsi[0];
> -	struct device *dev = &dsi->dev;
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
>   	nt->cur_mode = nt35950_get_current_mode(nt);
>   	nt->dsi[0]->mode_flags |= MIPI_DSI_MODE_LPM;
>   	nt->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
>   
> -	ret = nt35950_set_cmd2_page(nt, 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = nt35950_set_data_compression(nt, mode_data[nt->cur_mode].compression);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = nt35950_set_scale_mode(nt, mode_data[nt->cur_mode].scaler_mode);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = nt35950_set_scaler(nt, mode_data[nt->cur_mode].scaler_on);
> -	if (ret < 0)
> -		return ret;
> +	nt35950_set_cmd2_page(&dsi_ctx, nt, 0);
> +	nt35950_set_data_compression(&dsi_ctx, nt, mode_data[nt->cur_mode].compression);
> +	nt35950_set_scale_mode(&dsi_ctx, mode_data[nt->cur_mode].scaler_mode);
> +	nt35950_set_scaler(&dsi_ctx, mode_data[nt->cur_mode].scaler_on);
> +	nt35950_set_dispout(&dsi_ctx, nt);
>   
> -	ret = nt35950_set_dispout(nt);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set tear on: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = mipi_dsi_dcs_set_tear_scanline(dsi, 0);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set tear scanline: %d\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0);
>   
>   	/* CMD2 Page 1 */
> -	ret = nt35950_set_cmd2_page(nt, 1);
> -	if (ret < 0)
> -		return ret;
> +	nt35950_set_cmd2_page(&dsi_ctx, nt, 1);
>   
>   	/* Unknown command */
> -	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x88, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x88, 0x88);
>   
>   	/* CMD2 Page 7 */
> -	ret = nt35950_set_cmd2_page(nt, 7);
> -	if (ret < 0)
> -		return ret;
> +	nt35950_set_cmd2_page(&dsi_ctx, nt, 7);
>   
>   	/* Enable SubPixel Rendering */
> -	mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_EN, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MCS_PARAM_SPR_EN, 0x01);
>   
>   	/* SPR Mode: YYG Rainbow-RGB */
> -	mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_MODE, MCS_SPR_MODE_YYG_RAINBOW_RGB);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MCS_PARAM_SPR_MODE,
> +				     MCS_SPR_MODE_YYG_RAINBOW_RGB);
>   
>   	/* CMD3 */
> -	ret = nt35950_inject_black_image(nt);
> -	if (ret < 0)
> -		return ret;
> +	nt35950_inject_black_image(&dsi_ctx);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
>   
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret < 0)
> -		return ret;
> -	msleep(120);
> -
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret < 0)
> -		return ret;
> -	msleep(120);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
>   
>   	nt->dsi[0]->mode_flags &= ~MIPI_DSI_MODE_LPM;
>   	nt->dsi[1]->mode_flags &= ~MIPI_DSI_MODE_LPM;
>   
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int nt35950_off(struct nt35950 *nt)
>   {
> -	struct device *dev = &nt->dsi[0]->dev;
> -	int ret;
> +	struct mipi_dsi_device *dsi = nt->dsi[0];
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	ret = mipi_dsi_dcs_set_display_off(nt->dsi[0]);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set display off: %d\n", ret);
> -		goto set_lpm;
> -	}
> -	usleep_range(10000, 11000);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
>   
> -	ret = mipi_dsi_dcs_enter_sleep_mode(nt->dsi[0]);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
> -		goto set_lpm;
> -	}
> -	msleep(150);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 150);
>   
> -set_lpm:
> -	nt->dsi[0]->mode_flags |= MIPI_DSI_MODE_LPM;
> -	nt->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
> +	if (dsi_ctx.accum_err) {
> +		nt->dsi[0]->mode_flags |= MIPI_DSI_MODE_LPM;
> +		nt->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
> +	}
>   
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int nt35950_sharp_init_vregs(struct nt35950 *nt, struct device *dev)
> @@ -427,7 +360,6 @@ static int nt35950_sharp_init_vregs(struct nt35950 *nt, struct device *dev)
>   static int nt35950_prepare(struct drm_panel *panel)
>   {
>   	struct nt35950 *nt = to_nt35950(panel);
> -	struct device *dev = &nt->dsi[0]->dev;
>   	int ret;
>   
>   	ret = regulator_enable(nt->vregs[0].consumer);
> @@ -452,10 +384,8 @@ static int nt35950_prepare(struct drm_panel *panel)
>   	nt35950_reset(nt);
>   
>   	ret = nt35950_on(nt);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +	if (ret < 0)
>   		goto end;
> -	}
>   
>   end:
>   	if (ret < 0) {
> @@ -469,12 +399,8 @@ static int nt35950_prepare(struct drm_panel *panel)
>   static int nt35950_unprepare(struct drm_panel *panel)
>   {
>   	struct nt35950 *nt = to_nt35950(panel);
> -	struct device *dev = &nt->dsi[0]->dev;
> -	int ret;
>   
> -	ret = nt35950_off(nt);
> -	if (ret < 0)
> -		dev_err(dev, "Failed to deinitialize panel: %d\n", ret);
> +	nt35950_off(nt);
>   
>   	gpiod_set_value_cansleep(nt->reset_gpio, 0);
>   	regulator_bulk_disable(ARRAY_SIZE(nt->vregs), nt->vregs);

Looks fine!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

