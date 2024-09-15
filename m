Return-Path: <linux-kernel+bounces-329820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC440979666
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A33EB22536
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5391C3F04;
	Sun, 15 Sep 2024 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuviuyn7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB0184E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726397706; cv=none; b=Vgi1YdCMhP3CwsqkGkyfx0ImZwqwhlsUzdNt1P7bAbCdEN90GqIEfTsTaSSuTGIcaKOAl4oL7JmXEx1/ZLmmYcD515F5YEkvCJBelIjoZA0r2gwdn3p0spodrzl7/b+8Fe/yy43W5L/+1MAXut/dfIqObPRd8cZcOQMEfW0m6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726397706; c=relaxed/simple;
	bh=WFoiRQi5eiVQqJJgt9Ptci+hSBbY9xGbXGG/H6dFknU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvrNjfsp/vItdas9F7GLRZjT1aGMD8ah+79XHuuqGS4rqkskx4b3JRy8EHK+rxEbN7Pnvah0glgOMRItrMdHNO7ZlbjMmNPu4hvV+8eHYt7l218wC7/DrSwJp/TBol9dQKmQEsq1o/HgEMiJpjkCIaH1Bpmyf4ETESi2SYDVXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuviuyn7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so30612395e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 03:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726397703; x=1727002503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfJHt9roWykgi6iCo8OJXtKub6FZQX7k2pQODR1XVPY=;
        b=fuviuyn7R6tUGOTSKsxN+jzbpPOrH3zOqkefGzMcEY0zsThrenfPcd0WQlmK9F8Hs/
         Z9QLouBPQgdGfeqVJmGl0ptgPKVrcuz733JdnS1BCf1/6ilDvGMZxc5zi3CWQYwf424g
         HFiqGzuUr4/FUAJ3DJTbWPsBC0AOJA74LkhzA6Wm97suCd8rzNgHQwbCs55qeZtcoWJ0
         q0e0iEaHXFoBqixMI1fuTei4ue09FGWYY1wM5Asa+PdY1Ox+kUdJsfDMawTl/5UDl7Qg
         iMdAPw637QAXVmme53XumCyShIiucIf/3dmVU0kulFJfpJSln1az2nMz/Sh2Y7VJUV6H
         Y25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726397703; x=1727002503;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfJHt9roWykgi6iCo8OJXtKub6FZQX7k2pQODR1XVPY=;
        b=c+vYA2/uq5cfFzhl152ByqWHPy263/y3XAyW8WaDmQIuD6ZKolcQi+qrxDQP0ijoAI
         AI9UgVDdVMnFKryHbeNHJON5Iwb7nRD4v0tjPS3Aq4uW7YtPWlzRmdqeHzJ0ChtDc8I4
         8fmD49lth5p+Z9ZKgll9qZ3lLvNuWWdA4B6Nx963tFk61rWqEe6Uwa3fG2YWsw45klkz
         LQ4FikzxEul/uGooY62S/zf/m4CqGjlYPJVGOJkdjBj3x4FGi9rf8qzsGNTGp4uuRhQM
         /3sDKUDCTgAvkpoPtHSdnvVaQ8LpSZ2WjnH3iEynw0/WIhtYOFHVjzcEfRFhXOAhfX4M
         eCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFJaYqKZDLgUx3X9FyeNPLBAzvOupehIpU62OyuKFGeu+i9cpSb0PMBQr7uX0Rs2+N4+X9qnfC7vZh++A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqK5eW3N8MKUswktYReu1lboUgARTN09VKW8wkCG73OcsPyUT
	D6aq2/CU5X6U+eUI265juNvY/UQNENBKm85Ok/JJL4MDGNdoCLDz
X-Google-Smtp-Source: AGHT+IE7YoEPsvKgdohHfPyJvwpQ7Im0rUIBUpBdVjvxGocvco6SAce7YBX2SYunJXDZO0VL5oYdrg==
X-Received: by 2002:a5d:5e12:0:b0:378:c2f3:defd with SMTP id ffacd0b85a97d-378c2f3e021mr6334242f8f.13.1726397702891;
        Sun, 15 Sep 2024 03:55:02 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b87a9sm46384925e9.6.2024.09.15.03.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 03:55:02 -0700 (PDT)
Message-ID: <c8f8d556-77bf-4b60-abd9-bfcf7ac40ac5@gmail.com>
Date: Sun, 15 Sep 2024 13:54:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: ovl: Add fmt_support_man for MT8192 and
 MT8195
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Singo Chang
 <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240914201819.3357-1-jason-jh.lin@mediatek.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <20240914201819.3357-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2024-09-14 23:18 +03:00, Jason-JH.Lin wrote:
> OVL_CON_CLRFMT_MAN is an configuration for extending color format
> settings of DISP_REG_OVL_CON(n).
> It will change some of the original color format settings.
> 
> Take the settings of (3 << 12) for example.
> - If OVL_CON_CLRFMT_MAN = 0 means OVL_CON_CLRFMT_RGBA8888.
> - If OVL_CON_CLRFMT_MAN = 1 means OVL_CON_CLRFMT_PARGB8888.
> 
> Since OVL_CON_CLRFMT_MAN is not supported on previous SoCs,
> It breaks the OVL color format setting of MT8173.
> So add fmt_support_man to the driver data of MT8192 and MT8195
> to solve the downgrade problem.
> 
> Fixes: a3f7f7ef4bfe ("drm/mediatek: Support "Pre-multiplied" blending in OVL")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 28 ++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 89b439dcf3a6..aa575569f996 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -70,10 +70,18 @@
>  #define OVL_CON_CLRFMT_UYVY	(4 << 12)
>  #define OVL_CON_CLRFMT_YUYV	(5 << 12)
>  #define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
> -#define OVL_CON_CLRFMT_PARGB8888 ((3 << 12) | OVL_CON_CLRFMT_MAN)
> -#define OVL_CON_CLRFMT_PABGR8888 (OVL_CON_CLRFMT_PARGB8888 | OVL_CON_RGB_SWAP)
> -#define OVL_CON_CLRFMT_PBGRA8888 (OVL_CON_CLRFMT_PARGB8888 | OVL_CON_BYTE_SWAP)
> -#define OVL_CON_CLRFMT_PRGBA8888 (OVL_CON_CLRFMT_PABGR8888 | OVL_CON_BYTE_SWAP)
> +#define OVL_CON_CLRFMT_PARGB8888(ovl)	((ovl)->data->fmt_support_man ? \
> +					((3 << 12) | OVL_CON_CLRFMT_MAN) : \
> +					OVL_CON_CLRFMT_ABGR8888)

Should be OVL_CON_CLRFMT_ARGB8888 (*RGB* vs *BGR*)?

Otherwise I still see broken colors, but in blue instead of red.

> +#define OVL_CON_CLRFMT_PABGR8888(ovl)	((ovl)->data->fmt_support_man ? \
> +					(OVL_CON_CLRFMT_PARGB8888 | OVL_CON_RGB_SWAP) : \

Compile error, likely (OVL_CON_CLRFMT_PARGB8888(ovl) | ...)?

> +					OVL_CON_CLRFMT_ABGR8888)
> +#define OVL_CON_CLRFMT_PBGRA8888(ovl)	((ovl)->data->fmt_support_man ? \
> +					(OVL_CON_CLRFMT_PARGB8888 | OVL_CON_BYTE_SWAP) : \

Same as above, OVL_CON_CLRFMT_PARGB8888(ovl)

> +					OVL_CON_CLRFMT_BGRA8888)
> +#define OVL_CON_CLRFMT_PRGBA8888(ovl)	((ovl)->data->fmt_support_man ? \
> +					(OVL_CON_CLRFMT_PABGR8888 | OVL_CON_BYTE_SWAP) : \

Same as above, OVL_CON_CLRFMT_PABGR8888(ovl)

> +					OVL_CON_CLRFMT_RGBA8888)
>  #define OVL_CON_CLRFMT_RGB565(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
>  					0 : OVL_CON_CLRFMT_RGB)
>  #define OVL_CON_CLRFMT_RGB888(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \

With those changes, colors are fine on my MT8173, MT8183, MT8186 
Chromebooks.

