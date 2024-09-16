Return-Path: <linux-kernel+bounces-330905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E597A5F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86E2B21AED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E01591E3;
	Mon, 16 Sep 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ52yu+W"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361B13D62F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503963; cv=none; b=V9VK/95sW+ju3yBjj5v0ukPiDe/EVyPYDuXsDHnR+M8bs5qB+AAuhgWr0AC7bVFhXrBwGZFc7SOvUZ2i2T3/cW2xA/yNdGR4/aweF+QrKIkar/eOE9YlSh5/FKWR+CgX1AvudZ/DrnGPqV84Y4qhXRppGqHgHyGZUeLRduVpDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503963; c=relaxed/simple;
	bh=nDqWNawOOfba2CIVJPVm9qqnp4Hut/oNFxIDLqUDhBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnTtDNf7VGMIr1cdCuOxLC5RDvmQrdhPNm1kXpM8lPHaZGwzEPO2+12KyALW4k7CsHL2tOeoMoBXquLklz+rAFxC8r8Tc16xt9TmzW9baKyCjzHLyel84sQ7wo4gGS+DN/4A0RVal0CKSxV5Bf0++6EQJ2bTowH+jr//NBP/VsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ52yu+W; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so15905635e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726503960; x=1727108760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/DYkCdH/gmU3Os/Pwqx0cgxO12Vdt0xg3X05ImTUp8=;
        b=QJ52yu+WGmYLANZRlVo4XATsSlEYNZpl/FfHLCuIBAj73LxYFVXdDINFMflqDs9TlB
         c2Gi/WR7pD73ouZiGPPoEpGy8exWelbziz8cawERCoVlein9OUnj1fUpmvSIuEIvPuYC
         4dwUo5eZimpIiQdlqI9goGSF8yKvQcE0aIrNJg7qisXIJ0b7JOvUWdwdKm4L9YpSN0ED
         s4ZhwaOOpojCexgE3Tic3Yzwxw9RU2JQd/E6a7TGEFvZeXlsH+szLMBn/438mCrZj5Mx
         CiPhOx97C9j912AIYiuKYJ2+wqN++Z6O9mGJD2+2BDy+4a7CS9FoieXeYv4crZEuy29W
         7Cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726503960; x=1727108760;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/DYkCdH/gmU3Os/Pwqx0cgxO12Vdt0xg3X05ImTUp8=;
        b=X4lDgd9YWOTjGd5/ucBUExCtQ3K4M3mOdNycjTI5jaopmUzl8uwRkbm4Y48Fdfn0m3
         wwqFT6oX4gtKVhg3s3ECh17tZ2HSlGjrAzpn0CVUWg3yy93lLLlPJE+Uj6+x99hPjZX8
         MuhJ7CRensD4ifeeFCSY2wgRvzikfqRYjVwzgY6lyEeTfx2MMLcRhJ9ASYUA9vfvSNf0
         Yx/IhkpLeFfjSXFaqSC0Lw8MOFfh3l6ulbGH4gvG0MFK2MSK0rglsH49jWWJXuijuC3n
         qavEGqe1pktmbVa8SQfA6B+LAWHuk6bs4o4DXZmPS93YoglbnQHuLDR+LCg4BFBH6nk6
         EioA==
X-Forwarded-Encrypted: i=1; AJvYcCXb8fP5xssji1c5gtdSJlYYqZML9xhASrTas4Lc3ZaXJHfOK0V9bgLogGoXJmkC/B3/1OPyG6mRTWO0Gm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYTUmBaYyuExZGa8vvTAOo9Wb7fMq7ivSiNJJ47oaATvHWMo+G
	ttlB5LyWYy7gvGSfpKKIwB1onUmJ9X4xyyEPGx8nDnuV9UbePFvq
X-Google-Smtp-Source: AGHT+IHdtK4eYtnmHmLxW/z0qkevWcipo3F4LfK611EvaMbZJea3I5V4XWBz27XMAZ+Qt+QiI0wJcg==
X-Received: by 2002:a5d:4811:0:b0:374:c6ad:a7c6 with SMTP id ffacd0b85a97d-378c2d065c0mr7874708f8f.20.1726503959418;
        Mon, 16 Sep 2024 09:25:59 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780defdsm7485344f8f.115.2024.09.16.09.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 09:25:58 -0700 (PDT)
Message-ID: <63ca91a9-f2f4-483e-b7bf-11febcd49f1d@gmail.com>
Date: Mon, 16 Sep 2024 19:25:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mediatek: ovl: Add fmt_support_man for MT8192 and
 MT8195
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Singo Chang
 <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240915161245.30296-1-jason-jh.lin@mediatek.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <20240915161245.30296-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2024-09-15 19:12 +03:00, Jason-JH.Lin wrote:
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
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 43 ++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 8 deletions(-)

Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Thanks!

