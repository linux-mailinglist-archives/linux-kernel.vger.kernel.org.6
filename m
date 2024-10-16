Return-Path: <linux-kernel+bounces-368009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2C9A09B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C6C282826
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AF7209F4D;
	Wed, 16 Oct 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzCWVhC1"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D274209F40
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081619; cv=none; b=BpuU263/CEtlbuYB5KFAOav9ppX2dpOy0Xegk8Ly1fud8L7TR/XlQfqCaS+l5c+0mfOvtc8VKNgY1GZ8HuHeGUJmvF43xMDR2O7xBp8VLeWeddpbXI0ANLRp2tgN44c3LgAH/YNNr7cfJlwmjcY05NaDdM9obid9ate7kICzvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081619; c=relaxed/simple;
	bh=LDwPhIuQaJcIoTLcEGw7L99PYLDr1WASkARfaDEZm+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGWCZZgtZG4crWJJLAb1GUbERFQ6N41ujE7VGFgl+4LQtr8fOMp2T/JMqrcYzVf1xh/IyH+VxLKTxP+WrZTAO1r94u9MRF6deu1St0FmLIBqFuPixScvnc5gp1Zv3KDuWkVuQWYOLih5mhp0LiGGaEVfEaiBUTfCw2DifPgWMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzCWVhC1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c96936065dso4820783a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729081616; x=1729686416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5XkYbhD7GQ/UM3/ZFxDvMxdDBYYQYu99C2uqRsaiV8=;
        b=GzCWVhC1MAdf0M2EPwrUl4zc9Jy6ML2awzj0cIr9byxCoWo2z5UYjvIxAiEZ88EIPG
         QwmG+toMCdtr2UKp4Q3PsWQyUx+05jnEmoH3hIHTdoq8AukmLjE6HY+CGhQttEc8Us/C
         5sojMb64OfcWjTbQ5n7cYLaQ8vB8I3PRDT2NZWRmu1ktAapSTlvRwHpPSdTHrej5ob6y
         BymhCg5sRp5TnjKbHbgJR49gojqLQt98Uhp46OTe72iDh3MaeQGD0yXThgotskpK1qZu
         iWgZUTn8+JgE8GAto61Qy1E3WnVZn70VQOj/DW9pacUzutki55m3LcqO4tzhFfE1pmo2
         s1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729081616; x=1729686416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5XkYbhD7GQ/UM3/ZFxDvMxdDBYYQYu99C2uqRsaiV8=;
        b=wolZrirCsgYpxBUPUn82+97MDKURJ2mBtUlx3AO/BVXzLbpmdJl1XPoU/XZRJHqbul
         4xZ7JEgjQjWgwM67qyXmlYd3Ms4lzz6mj7FKatKtTOj3PXD45G+FdNOqC6o44LmkfhUx
         dhqJP6B0t+epdIlKM7OOv7Kz3qT/hcRZTAZi0tLALY8DNhCdbi9aCTzX1fc7BsiKqHNr
         uZqdEoFr/HeijSaRLHkj6FQYGJ9P7jWeoQ6RJiCnT6wJd/yPJFrtoL9CelKFGbmebqSb
         a2XQEYcmCyTSLQ+zq5nQL95cqa5q15puwq1tH7td63oIKOCJqarJIbh09fjImtMqqezI
         9xiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV66IbLCPVKiAKDPDRjbdgtJ4rw7FmsRDrCwTaqINa/kfdNBdlDVojJjtygJfkRLQV4BvPP7CUO2VYxVcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkASRuf8Ie8/v0D/fpl2ypX+/PXGNlL7cp4scUnb2HkKi3XD5l
	FFig3p8YF/7L7dhHaTg+Tu8J/6X0JDdeqxYqEEYjJq0XIJAH40TL
X-Google-Smtp-Source: AGHT+IFcnPGvv+07WP6skyv4hg/FfgbGscqMu7BmRbPY69IWoa1LmdxhGPZoAcM+AnYli8pZGFn0ow==
X-Received: by 2002:a05:6402:5210:b0:5c9:4a36:8f4e with SMTP id 4fb4d7f45d1cf-5c94a369527mr13528544a12.25.1729081615530;
        Wed, 16 Oct 2024 05:26:55 -0700 (PDT)
Received: from [192.168.42.132] ([81.95.8.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4d63fesm1659905a12.13.2024.10.16.05.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 05:26:53 -0700 (PDT)
Message-ID: <8d35081d-74cd-4d4c-ae31-b3b4e8ce65de@gmail.com>
Date: Wed, 16 Oct 2024 14:26:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mediatek: Fix color format MACROs in OVL
To: Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dianders@chromium.org
References: <20241016-color-v2-1-46db5c78a54f@chromium.org>
Content-Language: en-US
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20241016-color-v2-1-46db5c78a54f@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 13:08, Hsin-Te Yuan wrote:
> In commit 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in
> OVL"), some new color formats are defined in the MACROs to make the
> switch statement more concise. That commit was intended to be a no-op
> cleanup. However, there are typos in these formats MACROs, which cause
> the return value to be incorrect. Fix the typos to ensure the return
> value remains unchanged.
> 
> Fixes: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> Changes in v2:
> - Clarify that the commit get fixed was intended to be a no-op cleanup
> - Fix the typo in tag
> - Link to v1: https://lore.kernel.org/r/20241015-color-v1-1-35b01fa0a826@chromium.org
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 89b439dcf3a6af9f5799487fdc0f128a9b5cbe4a..1632ac5c23d87e1cdc41013a9cf7864728dcb63b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -65,8 +65,8 @@
>   #define OVL_CON_CLRFMT_RGB	(1 << 12)
>   #define OVL_CON_CLRFMT_ARGB8888	(2 << 12)
>   #define OVL_CON_CLRFMT_RGBA8888	(3 << 12)
> -#define OVL_CON_CLRFMT_ABGR8888	(OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP)
> -#define OVL_CON_CLRFMT_BGRA8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP)
> +#define OVL_CON_CLRFMT_ABGR8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP)
> +#define OVL_CON_CLRFMT_BGRA8888	(OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP)
>   #define OVL_CON_CLRFMT_UYVY	(4 << 12)
>   #define OVL_CON_CLRFMT_YUYV	(5 << 12)
>   #define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
> 
> ---
> base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
> change-id: 20241015-color-e205e75b64aa
> 
> Best regards,


