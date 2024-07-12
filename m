Return-Path: <linux-kernel+bounces-250416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1292F79F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801E21C22261
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E5C145326;
	Fri, 12 Jul 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDRxxwMq"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA9143758
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775407; cv=none; b=JOehpy9mE02iCAgASl86NgdBo3Pp3Ar64i9JEB4qqUjGS2ChLb/BpBwPUdVpHBMYofyYRr907Jgl2oI4FUhOLdHC8hzbdeCvr2dNyIj0S/Vka68bT7nSy+gxP5lqoioesntyZOuA2FiwpTgOtdthxiz3Z/MIz90PunB8l9Qo6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775407; c=relaxed/simple;
	bh=92ARlhMrFxnltJoEG/KO+vFy4IkhU7sCILYUeEcc59U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMMI2nDRDS8RI6olXjXO+k9SAjvBVnnSppFPvug573wcpH9TfjRMV/QyKZJSQOMpVrM6Hv5/87OUae6YPDNYqC5qdwu/z/YcmKtQs5kxC7Y0+/4C8znCPBCTM80RGBgMpxZ/mZWqOZ4tT8TnK64z6h5uDXJBAAx6Uf5T5BBxCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZDRxxwMq; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e03a63ec15eso1728306276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720775405; x=1721380205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp1jgtDDKp2yfm23SCirsWH2DTom7+EqUMqjaOQMl8s=;
        b=ZDRxxwMqJmoRDPLP7dH9E9jpMk71/QoGUf2ECb4jZj+4pF1t2GBGJe3l3SwyhQ67o2
         mAjgDHFokj3v17519JNJfbq25ilBq132jODpr4ugCWjG0kTqYzy1a3Arv0vNXCWwCYfc
         nbZaBXiSi4VoM5TWrwC3xEu17WbHp3MP8kqjT02qE3Unr68NIw9tWW5/bESHB4qpmxyw
         2wc77vtErItuPHKN0SSkFumtBGBk4EA5tj8C6yJ4zWO+7bvWr7vZjCBseydCwHjbrlvW
         u7OI+bm2EoDR/j2n8UJlL43owxfROht9K74qxQ7pOdHdAdKUq7e99w/zlS4RYsdCiGgp
         Hl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720775405; x=1721380205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hp1jgtDDKp2yfm23SCirsWH2DTom7+EqUMqjaOQMl8s=;
        b=O4zIar8efzPCeMXRp0yXeFTZfmmZOGgh+8pQzL7N22O9idvvje+WaLsSEn9ReUHV+u
         Au/nfDTWL51kuNPW6iMJyTFr+HCKsC6hw3ok0VrN1r0+42i6eRbF0PMR0SYZKj1WSFiV
         /ebzodRIJjkxebov/H/eYPgktYVx3vjcwOo5Xzjro+JLLjRjoGqYan4OFe2LzsP0k97Z
         ZFMuQHuLGmmkIu92ncYfgC+Q6+k5Q26xRjaZ9RfS7aATlwKHW0A2SjPkpDsLMYGmVYSL
         RIFQSafdTESMzi0w8Psq2oebhBA37++m7Jj4RQ52AjbqBv6xWmBRtg0nFWq63i3OiOcQ
         o60w==
X-Forwarded-Encrypted: i=1; AJvYcCUwfxSQ74SEipBCkEYpPKw+UjVDDM+zUp8fCqbkkM6Oj74RaeC3WNESqbUA2y00uyX2Eac9fe8LiFC/L5Q2kPv5ZbLyUlmNCZWD7c8z
X-Gm-Message-State: AOJu0Yz5WEuuC4UBoWZUNEUiemz60qCCx204kE6MzII8Rf9K9YF2zLb4
	j3kRTogT9STYs2K0XNgK6kOi5DVNkja0jeEYKMHnyqDCOE8N8h/0o0JMsUqLcoIhVdZq1Oz6ac6
	+puFSCWxuLRrhzhswy20hcpHttkcPwKqufD4Tdg==
X-Google-Smtp-Source: AGHT+IEhhN868PqjoOtPt4/HXGxzNPUJJGslyFKUXQCrTsbztUttPEoG4X/T5cjLdpglfCj2+mvP6vMuVbajMoDBAHo=
X-Received: by 2002:a5b:1cd:0:b0:e03:5895:31b8 with SMTP id
 3f1490d57ef6-e041b059200mr12504526276.26.1720775404920; Fri, 12 Jul 2024
 02:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Jul 2024 11:09:28 +0200
Message-ID: <CAPDyKFoWdRdi-NZbtj4yXeBxiH9o1+J0uux+Aiaw8AQbUGpM5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] address S32G2/S32G3 SoC based boards particularities
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, s32@nxp.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 14:10, Ciprian Costea
<ciprianmarian.costea@oss.nxp.com> wrote:
>
> This patchset addresses S32G2/S32G3 SoC based boards
> uSDHC controller particularities such as:
> - GPIO card detect wake mechanism is not available
>
> It also fixes a clocking usage issue on 'clk_get_rate',
> in case of 'per' clock.
>
> Changes in v2:
>  - Dropped option to not change pinctrl during PM.
> Instead, when S32G2/S32G3 uSDHC pinctrl entries will be
> upstream'ed, 'sleep' pinctrl will not be defined.
>
> Ciprian Costea (3):
>   mmc: sdhci-esdhc-imx: disable card detect wake for S32G based
>     platforms
>   mmc: sdhci-esdhc-imx: obtain the 'per' clock rate after its enablement
>   MAINTAINERS: add 's32@nxp.com' as relevant mailing list for
>     'sdhci-esdhc-imx' driver
>
>  MAINTAINERS                        |  1 +
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 +++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

