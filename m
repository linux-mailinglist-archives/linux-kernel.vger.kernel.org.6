Return-Path: <linux-kernel+bounces-561198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2187A60EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EE21B60DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278E1F3FD9;
	Fri, 14 Mar 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9zQ3ft0"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A71D5AB5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947719; cv=none; b=HIKKG2Vdx2/d1xWGf/mjeqetXjdGbMCWIRdgDz8juGFakLILtiJcIfcb3fToEr82uLihGxBvLPuRC32lCE8VjZyy4U6xo8wDFpCGPVSXC5CSMnp5Je5jZMQBloWzsw+ZJmd4sV8y10OGDPo90n6l3iWUbmBpq4DmHbG1FbQUPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947719; c=relaxed/simple;
	bh=xTpZTX6AMxu3+qazJFqKIwM9kTorD9hdWCEh54oD/yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TC/ISpkDff1BgtfhoGw0282XuJyC6xCWbQkozBnG1ghH4cujMYjABPfkhaMBwed5OuALXhFc8cNufAiMBFpyV7HJpC3VeVegs4BLa5ULvvoNt/IMtAwNk4LTnwk2O0oHrO79kuekpjrsixamdXNy93rbk/MdBelw7j829DpmqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p9zQ3ft0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5499d2134e8so2314035e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947715; x=1742552515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTpZTX6AMxu3+qazJFqKIwM9kTorD9hdWCEh54oD/yY=;
        b=p9zQ3ft0WTocuto3kxkJdZvK8WPT9p0aKQQAxmKEeEhxOfmQMgVSf0WYouq2RNtnDZ
         nz+yP1Epw6b136sAePYsDMbo7ZfBWCV898YfqtD4tmE3Guhtz0zr6avLivv9OGMGOzch
         nFG7Eo0X3COKdmeFB3I2JCqiPxnx69KlVzg4uCEN8pALQplNC3dfBeLdCE+PAusxtQMD
         v/kMktGMAMG0YKXNuafxPmdDNq0y4kMzgIZ0s9hMg9tWhou/fo12OEHnGVzq9AzbvlYS
         hELu1wvIyxLtFtNgSphQnXx0ozfRY2z2xBKSS0M+yfRlmTT1mtp+Vrz9w48Fd/YNIh15
         Adow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947715; x=1742552515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTpZTX6AMxu3+qazJFqKIwM9kTorD9hdWCEh54oD/yY=;
        b=qMiD1/CbF5pIUZH5/Ye305ErC6gZawdgcQolOyUlonPKVOQFdnyJcpFDhJNLmoki51
         PZtFotAhuO/2g3SvrfOhXM43JkWOXBB4FlxqxFOq8v9TdAKeO4FAEskAbBbcZt5m273e
         cZt6JGmuDkmdkx8sIwDqXmCQk9S/IhD9ep8DKyf7VS9A64vLjxXMBGIHpBQqj75IHgq0
         EGJHsQHzPtrn/x5loGMdhKKnstuQCXy5H5KME6Dk4tgHscdFpJ8f/kUw1lHdK3SMJlnD
         oZ2rNmSMSYlcnoTQRtr0as5Sv+aS114RT4pW60eOrQQYTAo7pnHOBf9kdrMXfbSEbe6G
         SioQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBN/sZhattzTeRf/PPETmozsaE6zZe1c129gLpu3eXnsFDc3bAsdcFRRrR+VMSliuVvwZEG5mdn40nRx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vSkCtOrVqhcYDaeFXf6lPqDrZB62j4GSbLhEbX8jlqRcIKlI
	yN6GsxO0k+mw5GrowUJZWKKSSJCRTJSDYEJVnqaL4CgQmw/mfj+ZKny8h1RX2ZeOINT2ckNuZE8
	5IJE8wQjOcOkxrWozzTvTWEmZ/OocdAWcYqSp7g==
X-Gm-Gg: ASbGncuHyN2oC0EjqUm5gRm5t1OlANHAuDuWbF3igiFuRVBudVoNS8JBObJmUXk/Qn/
	8VGY1QZA+ytnbVG3pWQeU1Aat1tBF5dOcvuLblbxVyCCewppkJtVao5r2vzi82tGFZwkawujH6N
	1pr29JwJwrqACUT0I9bDYUhagodNk0iFGh8w==
X-Google-Smtp-Source: AGHT+IEUDgH4hKI/VlqsNxuCaInPD1IYUYUxnK5o+/fyx5ELv/o0sS9qDolaum2DK5go96TmMf3VW3HeNPG9uPpiEA8=
X-Received: by 2002:a05:6512:b94:b0:545:c1e:65fb with SMTP id
 2adb3069b0e04-549c38fbccdmr686124e87.18.1741947715080; Fri, 14 Mar 2025
 03:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307124841.23777-1-darren.ye@mediatek.com> <20250307124841.23777-7-darren.ye@mediatek.com>
In-Reply-To: <20250307124841.23777-7-darren.ye@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:21:44 +0100
X-Gm-Features: AQ5f1JoRI9uPFODrP-kekoqBVTf1T6TLHgkeo343GHaQMulDksI11fRwjUXLOnA
Message-ID: <CACRpkdZ=a0mbir=D3dCSPns1TC_OVWMMTXJKcTYOJeNy7aQ7NQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] ASoC: mediatek: mt8196: support audio GPIO control
To: "Darren.Ye" <darren.ye@mediatek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Darren,

thanks for your patch!

On Fri, Mar 7, 2025 at 1:49=E2=80=AFPM Darren.Ye <darren.ye@mediatek.com> w=
rote:

> From: Darren Ye <darren.ye@mediatek.com>
>
> Implement mode switching for audio GPIO.
>
> Signed-off-by: Darren Ye <darren.ye@mediatek.com>

> +#include <linux/gpio.h>

Please don't include this legacy header. I don't think you even need it,
you are not using any gpio_ symbols at all.

> +#include <linux/pinctrl/consumer.h>

You don't seem to use anything from this include either.

Find more specific headers if you need the code to compile.

I think you should drop both, the name "GPIO" in this file is a bit confusi=
ng
because it's not very generic but dealing with audio IO routing. But I gues=
s
it is what Mediatek calls it.

Yours,
Linus Walleij

