Return-Path: <linux-kernel+bounces-217211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E250C90ACE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26A01C20DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF05195392;
	Mon, 17 Jun 2024 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uw3wi0Rn"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B5194AFF;
	Mon, 17 Jun 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623487; cv=none; b=NeZmvRmES199oqPh3d6wcHjOP1i7krw7XvxNWuPz7vjxvhBzy9yBITzdZtZ1yJ7CVRtTBmlu6i+2dWKAV7nUjnf3YL/l/4jxJ+OD3bWYnZEmU8QqcUZyAzOezBKYWWtP7h8U2gFyqlprj8QFmeUzJlSkkZ1G/sc5jgtUD2SgxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623487; c=relaxed/simple;
	bh=BiAFqDWMtUBYYL7WNeERH/7QvGS6RZjA1rc5xTNrENo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2reVpGVn/f7hYd9ehLwnrNQnXjuEsfJe5Qw+T95C+IAep6FJXsDwb0QoR3R7wEoTPBKBVvskPBZySmZOqL+LHlOsycHXTFpMvetbMbkbIoNyFGcW2IBRjkEtaGXkgometf0QtKYMGtdHEh25KXXHI63v6i5nKL1kYG0nF6kR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uw3wi0Rn; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 476B41BF20D;
	Mon, 17 Jun 2024 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718623478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oaI/YIoihSCT/XzoUgtEbkFRWQb1Z6Coz8KZYx9wWA=;
	b=Uw3wi0Rn2iuwOBAUNNl7q565rusBIKloO/isU7hf7GlumFPLVfvF9Ad5RJmMjReXQE+Qk8
	xtbVKBZ0CDs3NYUGZ3etKgYSMc3ZAsrVX4nFNIobduo5VTXG9DCNGC3HMatpeeuz+gFlZw
	+bhnzYtw5mqQhC0En3/ETef1yiF72bnwpL2v9AV+0V4pfbx53cWWRUyvxiInKLsULFbpLs
	56GQCMYp6In95Kb5S9X41mvcJkjW835YlYuOf9W/lr5ic7OkQCOF64K6FLDdWiX+wDop8w
	1YdPZOIGnPJcT4Sv/mtVz8sBKFI0d5mKwzmppAeDlfnd+Sr7dyoztMLqEVU6Ig==
Date: Mon, 17 Jun 2024 13:24:36 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Support
 Opensource <support.opensource@diasemi.com>, Shenghao Ding
 <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu
 <baojun.xu@ti.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ASoC: Constify DAI ops auto_selectable_formats
Message-ID: <20240617132436.640e5310@bootlin.com>
In-Reply-To: <20240617092152.244981-2-krzysztof.kozlowski@linaro.org>
References: <20240617092152.244981-1-krzysztof.kozlowski@linaro.org>
	<20240617092152.244981-2-krzysztof.kozlowski@linaro.org>
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

On Mon, 17 Jun 2024 11:21:52 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The static arrays passed as 'auto_selectable_formats' are not modified
> by the drivers nor by the core code, so make it const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/ak4613.c          | 2 +-
>  sound/soc/codecs/da7213.c          | 2 +-
>  sound/soc/codecs/hdmi-codec.c      | 2 +-
>  sound/soc/codecs/idt821034.c       | 2 +-
>  sound/soc/codecs/pcm3168a.c        | 2 +-
>  sound/soc/codecs/peb2466.c         | 2 +-
>  sound/soc/generic/test-component.c | 2 +-
>  sound/soc/sh/fsi.c                 | 2 +-
>  sound/soc/sh/rcar/core.c           | 2 +-
>  sound/soc/soc-utils.c              | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
> 

I think you miss sound/soc/codecs/framer-codec.c

Best regards,
Hervé


