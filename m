Return-Path: <linux-kernel+bounces-550824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563BCA56490
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4646E3A6E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167D20D500;
	Fri,  7 Mar 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkeR45pM"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57691C84B5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341814; cv=none; b=oMPkfeB2ALotp/hwBIhr+Y1z3MRtisgtJxNNylZP5StsZzfc/+RHTIC6JIAqkiOdcX47r86XRyQY3/NMxNJNsu8LDX0ankf8iNjtntMICp1KmyWjt1ToNynGPTBohVAAlgB+Nh9U6sRKg62GRQmFgzJVR4cwc8NRJBZ/FdIotu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341814; c=relaxed/simple;
	bh=ffs5WxX6CtIqt1DXQK+BJGJcSLN5xGGKWGiMMZROz2A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KylabxAYeTtTnQd/POg/EqSwTakSrjxD3GbZu7w0vByI2VwGdhoLr69yNmeVhHIdWYMUOAy/V5GRUbzv83c+m60na+XH0iQcfz4qd0Dd0pP6MThpLDtcoewxV7xDP6SnPhseEA1K3BHOIfTEtbDdpIUCNjELpJpogv1Q5UiMcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jkeR45pM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3910e101d0fso900097f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741341811; x=1741946611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5coBjYAR+KkcY316sSLQxCrPrRJBZlHcoLTLt78E9VI=;
        b=jkeR45pMfnKbumSeQOazgSfwBfx4KgTWgCBAmr49xFFFIypYW8pFufKIxaPnxIbWfB
         QtMFwUyNkFhkpnqhIAE6J62KDfzQI9qt66sM8BtsQj+niD0yP1/EePBVyWdEaxjBzfJZ
         gATGRtIJSCdRs9qTiaGAsN3cH1chTf9m+mXnGU6+GMSYhf/UI+P1MkdcUPaTWE7BcS9D
         ewzq5DF+2rneyww8RjUUranp5VDEx9EWXL9rsnezLwDigX9FUGLTJnX4O0nm/FuVJ9kR
         YRhdUxEYucOdJ84fGstOZEsTpSLwecc5uIH2q5FbYwbVqEINZ3S81WKkOEUUqiBz7hni
         Q2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741341811; x=1741946611;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5coBjYAR+KkcY316sSLQxCrPrRJBZlHcoLTLt78E9VI=;
        b=E5mSWF1WyVNnaI0F0EFqit0AKSN5do9eMTqQanSeo3eXtpw4ULVWpb1B01St6xBH/Y
         8UtmQIl6L33CBWB/cyFpX9Cy+yBWA92t/OCxrsjauEsOg7GJEGtQU9xGoBhHpGTiIYjS
         V3sAHHvTHjv2uezFWmQpouvQ4cAnk2KVP7deCpX9JESpdiS/Mlk6iHnYbUTrqPFFCj7M
         Hw6v8Iw6m40hXCJmqVYbcOFw/YojPIXxJRwJ9+c3YyQ9ISltLO75wj44iUdmwc1M80G8
         ysdsvCaT1RXPjM/TzPlmJlk/BwaNTd2PmMQ8F8ftoY9+2WNaBuvqD0UrHJDCooawEptj
         Axyg==
X-Forwarded-Encrypted: i=1; AJvYcCUbb4W1wRQsRdkgxeeglwo+ji5ZavfnQgmGDRaKdEiaNglAAGKihAEOqFP6ztmXeZ0RolqLe3j3t2UCOi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKlz1jFmsaRor8dja176ArnX5cc3W0fm+yQVs9SbZd4dJYDyf6
	PZjbh+uD9ZjxTO7U05u3zW92Y0XxMLgFQaHuVyoRB2lOMaCk5iOAGiVnQke2n5Y=
X-Gm-Gg: ASbGncsSp3a/pApJqvD5Q1O5kMMLRLVasUSsBDuDyD6XnlFS6rZjoOAht8etpwBVD/m
	Q5CHVBLksK5QzeHjyeM9bDrX7PcpHWA3+cAQaQ2AEDJNkKyOMRxqzLDikZTKlWeRxAqpJ5cs3ym
	Tq7DXg9ul1Vt5Gb4hN18KD4phwLU7GxmvR1zYSWpVJR6sAitDREDAfAqD0DwHIhdam2IWQFEjph
	U7y2kzPmLtZc0Y9Ke+aBMDObVmnbNxSxjgNWw2HSlH8DHVDE0m44uMN/8W+cakXmRy9UhpndwGq
	SNK+PF1sF+ZW4xZZjfqYZmoBPEPe0lpC3saDpgG58GS+kJm9Pv9wMDGxRL7MJ8Uvzax31k95oVB
	byvzTQt7HC7/+vxHitdFlxA==
X-Google-Smtp-Source: AGHT+IGo5lIfayWuQKBOZu/tc6K26BU8mCl+TXqRzocjAtATUAyaGx0M3aWMwY8mYe+1quyVtarCZA==
X-Received: by 2002:a05:6000:1fa1:b0:390:fb37:1ca with SMTP id ffacd0b85a97d-39132dbb25amr1401061f8f.53.1741341810940;
        Fri, 07 Mar 2025 02:03:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1ea4:9158:5668:7977? ([2a01:e0a:982:cbb0:1ea4:9158:5668:7977])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfbb4sm4953874f8f.30.2025.03.07.02.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 02:03:30 -0800 (PST)
Message-ID: <4bdeab38-d884-4864-8654-c6a70ef06288@linaro.org>
Date: Fri, 7 Mar 2025 11:03:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: Add mipi_dsi_dual_msleep
To: Tejas Vipin <tejasvipin76@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 lujianhua000@gmail.com
Cc: quic_jesszhan@quicinc.com, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 asrivats@redhat.com
References: <20250307091519.245889-1-tejasvipin76@gmail.com>
 <20250307091519.245889-2-tejasvipin76@gmail.com>
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
In-Reply-To: <20250307091519.245889-2-tejasvipin76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/03/2025 10:15, Tejas Vipin wrote:
> Introduces mipi_dsi_dual_msleep to make it easier to use msleep in the
> case of a double-DSI panel.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>   include/drm/drm_mipi_dsi.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index bd40a443385c..d9bc0d79dd82 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -306,6 +306,12 @@ ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
>   			usleep_range(min, max);	\
>   	} while (0)
>   
> +#define mipi_dsi_dual_msleep(ctx1, ctx2, delay)				\
> +	do {								\
> +		if ((!(ctx1)->accum_err) || (!(ctx2)->accum_err))	\
> +			msleep(delay);					\
> +	} while (0)
> +
>   /**
>    * enum mipi_dsi_dcs_tear_mode - Tearing Effect Output Line mode
>    * @MIPI_DSI_DCS_TEAR_MODE_VBLANK: the TE output line consists of V-Blanking

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

