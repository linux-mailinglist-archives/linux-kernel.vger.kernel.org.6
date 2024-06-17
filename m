Return-Path: <linux-kernel+bounces-217360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1B90AEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB811C232BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CF3197A60;
	Mon, 17 Jun 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LFyV4ApY"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7C186294;
	Mon, 17 Jun 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629629; cv=none; b=X+aTcyu25a6Dd6Z+BFD+O9gCkKWThVA/UvRerap9u+BEfux755pX0wP0nTfSZCxAcHwbTaayxUkx+VbYeeX7yLlt6YuilO09BUJOnEHYb6qtN4LMr7x4DlQaT0XUK3SAU3qCxxJi+ccDwLrJxLAVt0luIllMN7+UBp94pIMUdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629629; c=relaxed/simple;
	bh=qqY4nxzUS6e4uPcN05SP0cbe/4Tnnmkr2yZGSTHAFYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3jqXUlKNSQM1MU5M+KT5uEddDk/sYoxXOedk8coz/nXdQ2U3QcGh6YFy1N4bD+PocTiWlL7SMHfQGvKMPV/YqAFUyJ2SarSKd4K9WJWvlBoRxTIPBIvHzey2IFBuRIjgoAJSAlDeyZTla5+wnpD9N9KKBBKtzqIeU414wxjFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LFyV4ApY; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5323240005;
	Mon, 17 Jun 2024 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718629623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0JF6HKOXKhTNZVeUo1apz0svwkul+XXTywSXfd492g=;
	b=LFyV4ApYSGB5+3UrEmUE11z7TJ7jWs5zZa2DyPvPZB2kzs++6WZtO44pk3SPZr8NkqzyA7
	15L5SThBZ2dTviknM79/IXX5qn0x2weG2TvBlCXbT0fGj+lI9L2tKUtCgx0j+kwZ1Vu1Dk
	S9zBPRyHlTriafXYX7P+FG49rLnzVn8zq6ZV9QA3HMs393aXyGoUXVtF6vV62+QG0+qhTr
	UBFM58+EV5kyyanpm46pDwC5OH/XpwVYlFcaqclz/lEzw9S28rOdyL8lLc1jf8+MuEUu6q
	F46dy76m+DPLQ959REHWiAKbi+0Zamf/j2N64c1zThXnbK6fmm6GpRRrVt0rFQ==
Date: Mon, 17 Jun 2024 15:07:01 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Support
 Opensource <support.opensource@diasemi.com>, Shenghao Ding
 <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu
 <baojun.xu@ti.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 2/2] ASoC: Constify DAI ops auto_selectable_formats
Message-ID: <20240617150701.49a3248c@bootlin.com>
In-Reply-To: <20240617125735.582963-2-krzysztof.kozlowski@linaro.org>
References: <20240617125735.582963-1-krzysztof.kozlowski@linaro.org>
	<20240617125735.582963-2-krzysztof.kozlowski@linaro.org>
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

On Mon, 17 Jun 2024 14:57:35 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The static arrays passed as 'auto_selectable_formats' are not modified
> by the drivers nor by the core code, so make it const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Add missing change to sound/soc/codecs/framer-codec.c (Herve)
> ---
>  sound/soc/codecs/ak4613.c          | 2 +-
>  sound/soc/codecs/da7213.c          | 2 +-
>  sound/soc/codecs/framer-codec.c    | 2 +-
>  sound/soc/codecs/hdmi-codec.c      | 2 +-
>  sound/soc/codecs/idt821034.c       | 2 +-
>  sound/soc/codecs/pcm3168a.c        | 2 +-
>  sound/soc/codecs/peb2466.c         | 2 +-
>  sound/soc/generic/test-component.c | 2 +-
>  sound/soc/sh/fsi.c                 | 2 +-
>  sound/soc/sh/rcar/core.c           | 2 +-
>  sound/soc/soc-utils.c              | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 

At least for framer-codec, idt821034 and peb2466:

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

