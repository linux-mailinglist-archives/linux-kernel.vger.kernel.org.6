Return-Path: <linux-kernel+bounces-305201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F68F962AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6AC1C22CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A550C19DF40;
	Wed, 28 Aug 2024 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jalgkQ9Q"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8E19AA75
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857155; cv=none; b=FaIEZ86HizGdXPJe4BalCESygeh7TE9c7nszxTKTeI0dg6sDT+l/sZAXQp5w8FqHAU383cFI7UfLabApY3QlFG5pe+1mra8s63CnbNKfTvpyLsmcg/l5r4NuIkt9z4ChYpnyPQ6YVRrkjwHQtWUhrisX2S3ch5PVSygLU1KFK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857155; c=relaxed/simple;
	bh=4UNfrrrvypOXbGF1696LSllFlEGPK4iGpCwoIEZEm6M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UcuCSvg7usvWPsg40UZBoSnxdsCUngyi0rBgpFyQwMaulmrRRwABwUozu5kGTi9sKgzVf2nEBrB4Mb1dTcxAq59qSiYAKuYGIwYZdtV7kqjNue30YshsaVRrjV4obS4x4XBvtICdfLs4IatMyTlYwdXZ/Nw/TQcHZhnKPpLPyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jalgkQ9Q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso3237275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724857152; x=1725461952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO/kUq3HaX92Ly9XzMaKjjt6nL2ysMBapj0XMvCm3k8=;
        b=jalgkQ9Q2AmukeXSuBuQAxhbndY5EY7Rw7JMMfabg3qljTWO/lg/M3ELMUdRf/O3mz
         Va1UwRSAMFIeCBkFyGWVBne3+xUu6cKcCwShHphIib/smyTbxeaHJ9EQcDDxJF47G4SQ
         WavejaeFErxRGM1JEcY3ukFSIG0SwJsRZQn5J4fdZDw+cUjRv64VfMhmWbbn2X+7eKQP
         CYK6TBfBN5ZV11wLCoFHyWfC3PmJ/8d4Rmv65xIgDmGs4HWhVrkq925Tevcsj1oM4yur
         IecluCFi3+aFCnP6RTnV0yluRxT+mRS8TSH5ueaB2DBvUuGgr0a9xwyuihgtv4XMEt+w
         G7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857152; x=1725461952;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KO/kUq3HaX92Ly9XzMaKjjt6nL2ysMBapj0XMvCm3k8=;
        b=I8ffYXjVoTN3behGlqiyJ6j0Gt0fAkWZuOrolZ9SYyjw1FAKDnDP/+6sikcINNb5pu
         1VWM91C+6PopcQiDs25iiVBM/Sz/JTinb6P9UYZIK4KAWwWBw+oQUBlSbG1C683Se4hw
         1H1IyTbyPQcScheCPpNUjhLAiptBzWmUpsCHwJrVEedd00B5kOxbGpvL0mv8ONPOYIgw
         3MiPtxo+g/KlWFS+bwFZuYaPJoHKH387sV2rBB8P5os4XYbSVevoJ8cJwSm7IjKiPj/a
         /AkwY7678wsJ4VU3u/m3V96TLaCFJPr2jS8iUlAvXUvtns58vvSIYokS6Y+cq+DfJbEC
         WvBg==
X-Forwarded-Encrypted: i=1; AJvYcCVUIoZKy/LFgWwLTkhzxE7qF88junwwYtH/BGt3m5pFwBe+iQJ+2HBmeIzCVNRitKiBMmh/TwgwJT+jCWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8QvJJEz3LXIlpOeNiW30ghf+X0zyhcTglu7Z39doHXW83niWx
	E0Nz8357iBAGsxSjnwlQSLKB4Ms/9CUSXbmDL/MYlQHKdTA9pJfDWuF0Ac+Qc18=
X-Google-Smtp-Source: AGHT+IGpYyl2oFuEHSkvy/FLwK15pAaH4MgP4JJbb6daH2SnrD/XOuBjv4Vd9IkQ8xwpgzVSDO+D3w==
X-Received: by 2002:a05:600c:4fc8:b0:427:abfd:4432 with SMTP id 5b1f17b1804b1-42ba5708dd6mr14626585e9.12.1724857152032;
        Wed, 28 Aug 2024 07:59:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:765d:64ff:5f38:550? ([2a01:e0a:982:cbb0:765d:64ff:5f38:550])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baf7fa745sm4356805e9.31.2024.08.28.07.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:59:11 -0700 (PDT)
Message-ID: <35ab4327-4736-41e8-afaf-c2dea58f0406@linaro.org>
Date: Wed, 28 Aug 2024 16:59:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] drm/panel: add BOE tv101wum-ll2 panel driver
To: Doug Anderson <dianders@chromium.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240828-topic-sdm450-upstream-tbx605f-panel-v2-0-0a039d064e13@linaro.org>
 <20240828-topic-sdm450-upstream-tbx605f-panel-v2-2-0a039d064e13@linaro.org>
 <CAD=FV=WqmdjrM3jgpGEX=DqrJLYySpgQ9w+zK0mR=os_5wA35g@mail.gmail.com>
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
In-Reply-To: <CAD=FV=WqmdjrM3jgpGEX=DqrJLYySpgQ9w+zK0mR=os_5wA35g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2024 16:11, Doug Anderson wrote:
> Hi,
> 
> On Wed, Aug 28, 2024 at 2:22 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> +static int boe_tv101wum_ll2_off(struct boe_tv101wum_ll2 *ctx)
>> +{
>> +       struct mipi_dsi_device *dsi = ctx->dsi;
>> +       struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>> +
>> +       dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>> +
>> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>> +
>> +       mipi_dsi_msleep(&dsi_ctx, 70);
>> +
>> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>> +
>> +       mipi_dsi_msleep(&dsi_ctx, 20);
>> +
>> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x5a);
>> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x5a);
>> +
>> +       mipi_dsi_msleep(&dsi_ctx, 150);
>> +
>> +       return dsi_ctx.accum_err;
>> +}
> 
> optional nit: now that the single caller of this function isn't
> looking at the error code, you could make boe_tv101wum_ll2_off()
> return "void".

Indeed, I'll spin a v3 with this and you review and apply it

> 
> In any case, this looks good.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!
Neil


