Return-Path: <linux-kernel+bounces-356457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77CA99615F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087B01F21BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9F17C9AC;
	Wed,  9 Oct 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMsyV1mx"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACF185B6F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460075; cv=none; b=oSleBqsAKlL8HZaEs3xaUWTDVMjVBD9HYT8tNGPZPlAfxBHcJiaOgMxwm8nSJaM5fj9oMk/p3gV54/9dhOdjEpwX/Mj687lPnKA0i9jswXfScr4L74RfEiuUKHuU+9StufUtAGzE7vwluOSAmGDYMigwc3+RsNRH2Qx4LnBz/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460075; c=relaxed/simple;
	bh=xLJuETlXDaB5r76RL1J8fcgdskxq67CUY0B2qrnqXhU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cqmy9xCJzTCydHMPAXfa/zfSfmetQe7DvvI1dxW+7mz6u74Bt+5GnyY3vywJyM5B05Yk+tLXTFl6lrC49cVjyBqKRVJRc8dlgr53V94gUczUYa3qW6FDai/Rm5++lL/sYQxveaVAJIF/bzEM2RBa1++PTihbe38qN8+Nz5tsvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PMsyV1mx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d39d9f782so367657f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728460072; x=1729064872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6d/wEUJmoAyjx81Rr68K4zml6B0H5nLhQoMhNeac2Go=;
        b=PMsyV1mxu1Chxs4sIO74QbEHRqkpWFiDTT1K/VdHx4KOVXdB1pGizLfSx7YHJIsGCX
         +gpgLIEZcodvY77RzL1URK6KQNO9qLJCDwv0KWzuyE5KPXJM9gus1kivrpO9ChOdI2os
         RKk1oNAJIX6kQt5QY7X0hqJiFBalagbnI/nBifxPI/zTbwEs5+d0H9bY1hnZl3szS5Mg
         uWOlV3+/KgbU6QkFBGzJc1TAoD6DUb9k9fQ9VscEvE1AVit94JQv5iL3l7jvFody78ow
         3Gn78w1w3ls6tqHw8FntqKfmXjb3wwEzvGqPpaTqij5per/hxMZ9D7ZOwYCd/p/oW5K3
         ViyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460072; x=1729064872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6d/wEUJmoAyjx81Rr68K4zml6B0H5nLhQoMhNeac2Go=;
        b=uqObj8twOJzeokcuwXeF0n2Uu6HYiy2i9CTLdkppBGb8S77h/h5i4X7Q/cF2REeZ6P
         YUmJD+gP5Y0wJgXwTlGT/wOtzQKwpmiobakb0VC+JsSvjdCmBpUoAPeRPQfYHusqxqm+
         SGGLQepI3tH7XPEuWeJqwPg12MSWcxcWiJo9VGSWtc1WR10/vKg2dgkNMiePKraleFrj
         2jSi1sckIUm+CdiY2vhL56j4bpGLzPvPv2Yecwr09Yq7kckh9ffGQlu/NL4QutAGfVtI
         kDi5JBFi/woM2N3HZ+wh/fx8qfd2EgJPu1XEV/hmvSZuuKGTCLBbZt69VPgpM9KmC68s
         CBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsd2u/Zwdnt618hZFpEcoymeOSUtUOWQALRbIpqIYrf+jCNfunBRIS6y2U8HizdqrMOKDjmM4/2bXZ1DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGl1Zc60TLwYRe8iKTdOd0/oPKnf1K6w2NqiqXg42m+ZqgLe2O
	9YqNbx9bwd3byaMDlgDxgUekDL2gOLyXLyg/axCap+0jwFfT9Fm7C31wxrp3KVs=
X-Google-Smtp-Source: AGHT+IEvrnhIoAuMTon6xqmvCaAZoTWYymMHH2lK6WFOt4s+0AuzWuqn1dU2NJTUF+byVEcH1O0HGg==
X-Received: by 2002:adf:fa46:0:b0:374:c269:df79 with SMTP id ffacd0b85a97d-37d3aa413e5mr783367f8f.22.1728460071858;
        Wed, 09 Oct 2024 00:47:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:767b:a30:4bcb:fcaf? ([2a01:e0a:982:cbb0:767b:a30:4bcb:fcaf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d39cb1358sm1208476f8f.25.2024.10.09.00.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 00:47:51 -0700 (PDT)
Message-ID: <2d6aa5af-f4b9-4585-9ed5-8ae4abd9e4af@linaro.org>
Date: Wed, 9 Oct 2024 09:47:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_0/2=5D_drm/panel=3A_ilitek-ili9881c=3A_Sup?=
 =?UTF-8?Q?port_in-panel_180=C2=B0_rotation?=
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20240626-drm-panel-ili9881c-rotation-v1-0-e0ff54173e32@pengutronix.de>
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
In-Reply-To: <20240626-drm-panel-ili9881c-rotation-v1-0-e0ff54173e32@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2024 16:40, Philipp Zabel wrote:
> The Ilitek IL9881C controller can rotate the image by 180°. This
> might be desirable on devices with their display mounted upside down,
> that don't have rotation capability in the SoC display controller.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Philipp Zabel (2):
>        drm/panel: ilitek-ili9881c: Explicitly set address mode, allow 180° rotation
>        drm/panel: ilitek-ili9881c: Report subpixel order according to rotation
> 
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240626-drm-panel-ili9881c-rotation-54d53a885d7c
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

