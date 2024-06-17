Return-Path: <linux-kernel+bounces-217208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9FE90ACDC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF67F1F22790
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18379194A7D;
	Mon, 17 Jun 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QDplKBFv"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7571946BF;
	Mon, 17 Jun 2024 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623479; cv=none; b=GsbzVLHCaRgRQwWF+q6rYZN9c83RCyPF6FHUmWGHjaAbllYXAAP+edi174Hqix9wxyDN8jgtVYHpubZiXG1QiMtK+7VLL5CPi7g/DH3Eg16Q1UdMu1rDKc3ndQL50nsnPMwc3Hyb92JB9b7zpVfWvihJvr5bJHDTHGbO6XpS6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623479; c=relaxed/simple;
	bh=bR581glQjXHkPYec71s/eVw3phdSHCmCBAwg1sk/pgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHHs5dva6dvx+3dxhR/fgrKT4qOB3QfjrmVRs07dUq6JmazTu4VQsery8TciGLtgTdctScZL3OvB0CYoclodS22CFE7oraAqxyLWQrfxDB2COTucprV0Z9al8iTlNSY2jf+2lHfnu3BydZ7m3fLI6n3KDp5vvxTUIb9wqmyfP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QDplKBFv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72119C0006;
	Mon, 17 Jun 2024 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718623469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gZT0G+O5PtiEYzBiPzB63SOi74GXoYY4dJqIHMC1dc=;
	b=QDplKBFvkY9iblnw1quq8clsRo6aVhuUGZCvK2NwbhoGK7kJTmpNG233YDv2ZjkpjB7oQP
	RVXdFCg9oUfIgHWDvUNVPVBfV3Pk0m16WHdOxMxcEEj3CLRG+LuX762tDNiXx/+1JynIUs
	9ml8zTprshRig2qz20BGPR1z1EANG9lxk+0rWiW0Rg073svZTmqZRB4QdikeiRukfyV5Hz
	hz/o+adT2SNVWZ+fVDCC02kHRX8EhDYKBW9iRV33X1mCvOP++FSkqoSUJt89rtTXkqVNVU
	P0weiIw0T0ojzfMM7LOVLw911w2Tt2MBQNZD9mD5ERiCroniMsoiAClzdws/iA==
Date: Mon, 17 Jun 2024 13:24:27 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Support
 Opensource <support.opensource@diasemi.com>, Shenghao Ding
 <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu
 <baojun.xu@ti.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: soc-dai.h: Constify DAI ops
 auto_selectable_formats
Message-ID: <20240617132427.6b4a1cb0@bootlin.com>
In-Reply-To: <20240617092152.244981-1-krzysztof.kozlowski@linaro.org>
References: <20240617092152.244981-1-krzysztof.kozlowski@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Krzysztof,

On Mon, 17 Jun 2024 11:21:51 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The core ASoC code does not modify contents of the
> 'auto_selectable_formats' array passed in 'struct snd_soc_dai_ops', so
> make it const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

