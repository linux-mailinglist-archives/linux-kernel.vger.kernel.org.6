Return-Path: <linux-kernel+bounces-381912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A79B0635
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CE7283913
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED3212198;
	Fri, 25 Oct 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUVLJP/Z"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDE7083B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867916; cv=none; b=YGUjKCq1RxRbcDr2/XtdIUDWsU41uedCqslYOC6ZdgusHvp2bWA8NDCoWiGZk4NOaV60ZDFwmrltSAlBddVWHMcQztFLMSjZsHZfkAlanzo3BlJxHd2SwT5NZbRriZs3FifLno3eVIoJNurjiLM2WPFYw6SSdGCwY4D8P9kS5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867916; c=relaxed/simple;
	bh=v2So7uP5Tsr6CX6ubTUEEtYcoMRLvlU2scu8vjwx6BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oe/GMw7Q4C38GIrnd+16omjoyxp5XXXgpJwlrojoV/nfw5fBILozXjb5iHnP6sGttf3rEHIWD8V1++KymQxdEhRodKCG5eGuRI+g9alIZBTy/BZeC40LprTAzdysC8ZiYcGRrNZh3JxGl1HrgC/Z9tiWPGDcS7SFNl34AU99cJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PUVLJP/Z; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99fa009adcso141502066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729867912; x=1730472712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zgU53FZ8la9axnoKCOcvjKd+4k0u7BILSfDtxg0QRPI=;
        b=PUVLJP/Z1dIAngXxdZtkY7Bv2ydv8eZJiA44dXMVCXxJ/pOiF6sO9NyvOCo46FbuFv
         k9mNZn0EJRtPS4LrMimkNneBHzixtFTjzyqNXIFcTzlMjxq+hVAn6XRTxFXQWdzfmddd
         pi8O0oPsyAwJXdk+UoUQ28e2mZTICHY0Ym1WXKcw1IJAkt8D+eKYqSCJW/JyYCVFO93g
         5YC/Ll67cejzixN3f88BzHBmzZqZIzsTmg/EGKrMDCq/skxaEub80j5jPoO9j/n6SirI
         HOnNCTEcyeju2gY503+oc6tX8oC3ty45I/bmPY572UYc4we/oX8sFp/Sf1H3f/5gRoIk
         YZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867912; x=1730472712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgU53FZ8la9axnoKCOcvjKd+4k0u7BILSfDtxg0QRPI=;
        b=rtUDEA1ZKQBbuvMiM75lJ0LHh+sQHWRqZZCW44wLMlLhKzatxYYYPhaFw8WIrQwm2O
         y7IGia0osoOUB6c/dnWOEImKZbezSZL2VjVWas1N1HPivgKzbzCuwYN6gsucRXeyJodS
         flSLamOQekLSh1Zn/KIxLjI4vU9AbKbWJ5ptTGxZoqc8qdIU5TzdUnW0Aq5ePDNGWTGz
         iBW1lsKD/u/o0G2Y8hVcVEHR5G5kcwMHVaSI1N412IMPFEzWMYCfdoQUYwvSV27uifs0
         6nDagqtiRGpP4ek0ld8K4ks5/v1c4LBCWHgo84cTJcGWkhyR6OQgFcMevcE0+QxY2LjC
         NP3g==
X-Forwarded-Encrypted: i=1; AJvYcCWLLvPyy01mtfXQreoWFsF1QNf+0v9tt+YRqqxL+650ujOWfxsTCsQb0SiE2g7+fR3tiZqm+fG08F87lVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwxlCVWDXQ5sF62z7Ae8eS2+nC+Dsiq3UHahIrXslGfi+LOJw
	ZH2X/CmsxLQfk2QbmVtfZH0I5nYjb1W/h8uHE9JpzMe4Z9CnxI28xcnjde+Zg8v49pmaGMxPXNA
	vN1QHG5Fsp0Y6J19gX90M90jFlAKNxBZfuaHDqw==
X-Google-Smtp-Source: AGHT+IHnFb0iOpZ/0Hp5TvXS/ZuM2bGwLzFWSn0pQnl2sSkvF8LyDfB90uSqrDGmm+JEY5ML+QSfDQ6nhEYL9j8MdQM=
X-Received: by 2002:a05:6402:254b:b0:5c9:34b4:69a8 with SMTP id
 4fb4d7f45d1cf-5cb8af7eb66mr11748618a12.6.1729867912198; Fri, 25 Oct 2024
 07:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011024906.8173-1-andy-ld.lu@mediatek.com>
In-Reply-To: <20241011024906.8173-1-andy-ld.lu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 16:51:13 +0200
Message-ID: <CAPDyKFrtKgqY_7MkZ6R51NhdD3s=rcp6RN41pQJr6JJZv6ugNw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add mtk-sd support for MT8196
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, wenbin.mei@mediatek.com, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 04:49, Andy-ld Lu <andy-ld.lu@mediatek.com> wrote:
>
> There are some new features for Mediatek SoC MT8196, which include new
> command/data transmitting and receiving path (abbreviated as tx/rx), and
> two modified register settings.
>
> The driver code has to be adapted to implement the above changes, and the
> compatible string 'mediatek,mt8196-mmc' is added to driver and devicetree
> bindings.
>
> ---
> Changes in v4:
> - Reorder the first two commits, and update the commit message to explain
>   why the settings of stop_dly_sel and pop_en_cnt are variant.

The series applied for next, thanks!

Note that, I have put patch3 as the first one. Updates of the DT
bindings should come prior to the driver updates that make use of the
them.

Kind regards
Uffe


>
> Changes in v3:
> - Separate the settings for stop_dly_sel and pop_en_cnt to a different
>   commit;
> - Add the original value of stop_dly_sel to the platdata of legacy SoCs,
>   for unified code setting;
> - Change to return if host->top_base is NULL in msdc_new_tx_setting function,
>   to simplify coding;
> - Optimize the location of assignment for 'timing_changed' in msdc_set_mclk
>   function.
>
> Changes in v2:
> - Use compatible string 'mediatek,mt8196-mmc' to replace 'mediatek,msdc-v2';
> - Remove the 'mediatek,stop-dly-sel', 'mediatek,pop-en-cnt' and 'mediatek,
>   prohibit-gate-cg' in devicetree bindings, due to SoC dependent;
> - Add 'stop_dly_sel' and 'pop_en_cnt' to the compatiblity structure for
>   different register settings;
> - The SoC's upgraded version would discard the bus design that detect source
>   clock CG when the CPU access the IP registers, so drop the related control
>   flow with 'prohibit_gate_cg' flag.
>
> Link to v1:
> https://patchwork.kernel.org/patch/13812924
>
> ---
> Andy-ld Lu (3):
>   mmc: mtk-sd: Add stop_dly_sel and pop_en_cnt to platform data
>   mmc: mtk-sd: Add support for MT8196
>   dt-bindings: mmc: mtk-sd: Add support for MT8196
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       |   2 +
>  drivers/mmc/host/mtk-sd.c                     | 166 +++++++++++++++---
>  2 files changed, 147 insertions(+), 21 deletions(-)
>
> --
> 2.46.0
>

