Return-Path: <linux-kernel+bounces-292404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210C4956F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412EC1C20EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B17716B753;
	Mon, 19 Aug 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngAEwYIK"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83139768FC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082073; cv=none; b=QZwiN/zalgmvJ9ymQeux3rH/Uw+W03fI8g0ivSB46Mvja6+A8Mks0sQwttH6Z/CBTQ69tlW86Q3TK4a53wdck8ZCfBMJBfjWO3hOX/jd0kYi9E8DwZP079mZE1Y3g6o1cJNoszoRtycOwsSQp50K3X6SgqACJqh/tS1YP99BhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082073; c=relaxed/simple;
	bh=0D1MH02bz6Vy5wol/7/ekCDY5+vHDaQXLy5SNPCWagc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EH/eIvMWZe3QBWhwWXDeJYEDiTPjBoQXv1DlGa4E0b4TKf0073XpphpQTvJ5iZfvyP4AqEc093uriOdL7zwMKSANpQNI4JzvN37MgqZh4vyUmCZ5NwK2DMdq9NRaZoAUsmb3N3rSmBlJm7fTAq+ctsP9drt/XWE9x4TNeWNyGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ngAEwYIK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371a9bea8d4so1135326f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724082070; x=1724686870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrzATe8rYIud1EQmdYYD4F8xYF1fCvbf9TZacojasoA=;
        b=ngAEwYIKo6Q0FRVMtp3ENoysSH7HgVh+rGsJ1utnrfrh5JVmwkJrDtuFkqLpbRKmkU
         NUxWFuCuxmn2f6iM8oMySg/HYZfraaLUvA8TNEfOKjPQGKf7xGqkc5XzU6JBkKsSrNt5
         S0HB2/ddhKeqkaUJxFZf3ijX+V/zeQnu9TfaBQ1x2dZuShqEC4X9B+rmXfPF+xGq1d9Q
         vSrnTP6bqGrZ8m+WpVObe0gMMWR4gvsu1bsJ/emF53Ol+ndFKVcyFTyc/sP7bWdHOt9T
         Sv4NRe+K19YfAteHMaWuLzl7W+/TPcQYNku7ihc3X4riHO+ywGJE+K44eQeLROB5p8XC
         ob6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082070; x=1724686870;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MrzATe8rYIud1EQmdYYD4F8xYF1fCvbf9TZacojasoA=;
        b=O9xHj+039aRCbGCCfwxsXuevoNi443OvoOMKbJy8gjVV/anTxe4axcpWFSM702E8Pj
         02Nzs+/g4AB4PblUxjdt8fcHprwpgSyTQooa8GlcHJ5XlA4ppbweQTPjSaM3EVEYjKy4
         zi8jEXudrz8OVtfCUmvjh8OPftwsklRld9dsecq+UBp4OrJsmIHZARs1Zw9vsBb1V/4X
         5MW4HLzuPZaCZAr1OBtmpgymxifN3xsEcjpQ+UTOV5v46WX3T0uC/xC7ASdDywsZAN9j
         Y4begQa/vBQSk3p8gsyB+C9OKqh0D6UbL5lSPiU6siqZNXJAVvZNzFyjOFf0W7AqG8cp
         QJZw==
X-Forwarded-Encrypted: i=1; AJvYcCV6JWD2VCfHmLQqUbo4mUIKoQUPM0hxnW+z7rcoqol0AVO81M/S0HsRRciaHwiMcmYPQ0Sy+dC1O6A/510=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ZSUyTflIrY/AO14rnkilopCIhAcCICERrONfJCFw2L73FVuU
	dOAr4107W8MOfDMJ+pnHdwExwNvfsebpYWdfd05WbBqDAec029QMTkPjzG4q2Ek=
X-Google-Smtp-Source: AGHT+IGbaGgDjlkcjOOxjw1s5hMx81Sydj4FWl7Oz+csh+yXsVHvtIbKTUYageb60ZuUGTwv5aH3nQ==
X-Received: by 2002:a5d:408f:0:b0:368:5b80:b8d with SMTP id ffacd0b85a97d-37194456508mr6323850f8f.21.1724082069174;
        Mon, 19 Aug 2024 08:41:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a286sm10817742f8f.54.2024.08.19.08.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 08:41:08 -0700 (PDT)
Message-ID: <b783f932-851f-4ea5-a2cc-d39061c60652@linaro.org>
Date: Mon, 19 Aug 2024 17:41:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: ili9341: Add comments for ILI9341 register
To: Abhishek Tamboli <abhishektamboli9@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
 skhan@linuxfoundation.org, rbmarliere@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20240812171019.561321-1-abhishektamboli9@gmail.com>
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
In-Reply-To: <20240812171019.561321-1-abhishektamboli9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2024 19:10, Abhishek Tamboli wrote:
> TODO : Add missing comments for ILI9341 register definition.

Please rephrase the commit message, and explain why in a proper english sentence.

Neil

> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> index 775d5d5e828c..cba6a6952568 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> @@ -121,19 +121,19 @@ struct ili9341_config {
>   	const struct drm_display_mode mode;
>   	/* ca: TODO: need comments for this register */
>   	u8 ca[ILI9341_CA_LEN];
> -	/* power_b: TODO: need comments for this register */
> +	/* power_b: Power control B (CFh) */
>   	u8 power_b[ILI9341_POWER_B_LEN];
> -	/* power_seq: TODO: need comments for this register */
> +	/* pdtcaower_seq: Power on sequence control (EDh) */
>   	u8 power_seq[ILI9341_POWER_SEQ_LEN];
> -	/* dtca: TODO: need comments for this register */
> +	/* dtca: Driver timing control A (E8h) */
>   	u8 dtca[ILI9341_DTCA_LEN];
> -	/* dtcb: TODO: need comments for this register */
> +	/* dtcb: Driver timing control B (EAh) */
>   	u8 dtcb[ILI9341_DTCB_LEN];
> -	/* power_a: TODO: need comments for this register */
> +	/* power_a: Power control A (CBh) */
>   	u8 power_a[ILI9341_POWER_A_LEN];
>   	/* frc: Frame Rate Control (In Normal Mode/Full Colors) (B1h) */
>   	u8 frc[ILI9341_FRC_LEN];
> -	/* prc: TODO: need comments for this register */
> +	/* prc: Pump ratio control (F7h) */
>   	u8 prc;
>   	/* dfc_1: B6h DISCTRL (Display Function Control) */
>   	u8 dfc_1[ILI9341_DFC_1_LEN];
> @@ -147,7 +147,7 @@ struct ili9341_config {
>   	u8 vcom_2;
>   	/* address_mode: Memory Access Control (36h) */
>   	u8 address_mode;
> -	/* g3amma_en: TODO: need comments for this register */
> +	/* g3amma_en: Enable 3G (F2h) */
>   	u8 g3amma_en;
>   	/* rgb_interface: RGB Interface Signal Control (B0h) */
>   	u8 rgb_interface;
> --
> 2.34.1
> 


