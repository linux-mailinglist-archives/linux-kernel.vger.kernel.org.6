Return-Path: <linux-kernel+bounces-546251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494D5A4F868
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1CC7A5B6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C49170A13;
	Wed,  5 Mar 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EC7+0PnX"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD71624CF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161860; cv=none; b=Ku4VbYBMT+6q4ly7Bp2VtdL6CnnmG+VVAkXQsXYrJt0IqZhh19mAEyMckoIudTQLTd+sURNbq5wemwK0qPRWLJMvkTTjWTXNSxUoIo61qTwT5QlzIpaAvoWI08TX8piH5sPrtjyMpfzCebT8BVT6oO/UOazu3P1x5SE8MMoSLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161860; c=relaxed/simple;
	bh=nwxBqhBj63GsgjlQZRz1t/wShEjjjKEbXH9bVs9ZDNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMKasEsGeVjOfvDXk/d8mRTIsMFoI3RnGbs5QqW+snj8Q7zenjDTmxGNCmhuwIyRLdhFPxBi/4J8PwIJleJPphf4noO4bfxJ3yoNicZWqWef+Df5TftWVvvwNWcxwFTX9EQUxwHO3dGq62QhImVAg6dacO/eLmZQyPTjW422NPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EC7+0PnX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30613802a6bso68524281fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741161857; x=1741766657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9335U4BYdb3Rpl+HkVOVk0Hdu7mYIBHGPUHbDc6Yk8=;
        b=EC7+0PnXzkUJzFFo8rHdkcegXuMIif5C8ccumaI/ZsukbDiEyvIIBJ4UHFSlVm0JfV
         914bxKFr8/WHM/Q44vyKeoQqhOGD+phFsRAdytc7GI7M8P7iinJSmlwTvrBiN3+ysYX0
         8xEKaGl7ngsjZJ08HdLXRa2Ik1c+d+aRNiFZ6eNb2dY3xswhSZiHlSbj1+x4p3osPxZl
         AiD1Mb6YCnXAWO8VRebbnH0o5IzuJr5HzHI6kXIiAIRrKzunYt9FlZk7WwtCG50gTR8g
         ymb9MMTPgBLNWIk0fj8OU44a+LnPrGKLGACVtfZBmXqif+THOCQp2jO+wA2u5m4ANmgh
         9b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741161857; x=1741766657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9335U4BYdb3Rpl+HkVOVk0Hdu7mYIBHGPUHbDc6Yk8=;
        b=xE2g/ZJhnKzswyqJm8ErQ7IZIlrEkspSOszjGzkIllxO5iAoCjxx/9Sq9EoOdWDLdm
         aKKhD0Y1/HLnQ9JRQHcUfp9WAgySIjTzl8+k4Xwos3uWodfEluV0xwbd5WI092fQ13rj
         dzpviPu7LwlKhwlwc9k9HjHPe1gZXT0N/uS1U9WxFb1jpi2AoLgN1LclhCIRAeYNKpX2
         pCQnXzQIZqgwI+nkW/VxHn6kBU+YEJI/inWRY9nqHUKo0O8UIm006wuz7JfJsLm9a+3C
         h0s+dZHWj/cIcFWZF/1LNY1uDbksG4HUL+2JktYGkScbVJ+1KD/N9u3b0xXd1dSKxl2X
         0Zjg==
X-Forwarded-Encrypted: i=1; AJvYcCWPme01WhUHy/OudOzGl5cbZhHdk9HZjO6LJen4401fLQxYMy3U+RcH7x30XYDpFKZxwPfHkm2PsXH30eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUEE6ukClW1YJGb//ggOUuLl9k5EHJQIZxzy9CtNIMXqZ8gL+
	bHEogB+33ZL9LDhuLjpaVgiapZf5EKHO81BFxfht1EiI71LSMKg5320GZdLtweh1Lyaq+EYnd6B
	w9l4o5biI2hlnKasTfzB9v+BF+OnNTrC5PhMwBQ==
X-Gm-Gg: ASbGncvA8EZfoyhv2Ouz6nDE7+T3sel9N5tWsfNPU8i8eSt0LXf0sTFlCI8kLAxr2ti
	niHn9HLCTZVgVnE3Fpnzpxnxy917Ee5q0u4NhoXxtfP1dBinSqD3TcJ0rX+ubstVMjhbWERjRyt
	i33DE9NoqQQTJ36OHW3I6OCbUCUw==
X-Google-Smtp-Source: AGHT+IHxONNXRxXY/9SA/ScuPloLBavDa3lTwDH5EUDUvtRMl6Gewl1QIgssFE88vQwX5zwh5iaHK2NYlKSskUdQiJc=
X-Received: by 2002:a05:651c:2128:b0:30b:bba5:abfc with SMTP id
 38308e7fff4ca-30bd7a427d0mr8296691fa.9.1741161856549; Wed, 05 Mar 2025
 00:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-bcm21664-pinctrl-v3-0-5f8b80e4ab51@gmail.com>
In-Reply-To: <20250303-bcm21664-pinctrl-v3-0-5f8b80e4ab51@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Mar 2025 09:04:05 +0100
X-Gm-Features: AQ5f1Jr_36wy4P6iO_K8_dKn2UUlLFsUGnWdDx_V_chS6C1Pbzndlez70ok7ggU
Message-ID: <CACRpkdYTsym-YqV8CQh7up57q_R2ZGSnsCD8FiYSpQnS5CaFig@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] pinctrl: bcm281xx: Add support for BCM21664 pinmux
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Stanislav Jakubek <stano.jakubek@gmail.com>, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:54=E2=80=AFPM Artur Weber <aweber.kernel@gmail.com=
> wrote:

> BCM21664 is another chip from the Kona line of Broadcom SoCs, and
> its pinmux shares a lot of similarities with the BCM281xx pinmux.
>
> Add support for the BCM21664 pinmux controller to the BCM281xx driver.
>
> This also enables pinmux support for the BCM23550, which has an
> identical pinmux config to the BCM21664 (hence they can share a
> single compatible, brcm,bcm21664-pinctrl).
>
> While we're at it - fix a bug that affected higher registers in the
> BCM281XX driver and replace bare "unsigned" with "unsigned int" to
> comply with checkpatch requirements.
>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
(...)
> Artur Weber (6):
>       dt-bindings: pinctrl: Add bindings for BCM21664 pin controller
>       pinctrl: bcm281xx: Use "unsigned int" instead of bare "unsigned"
>       pinctrl: bcm281xx: Provide pinctrl device info as OF platform data
>       pinctrl: bcm281xx: Add support for BCM21664 pinmux

Bindings are ACKed and not much other feedback so:

I applied these 4 patches, I had to rebase the one dependent on the
fix a bit and then Torvalds can fix that up in the merge window.

>       ARM: dts: bcm2166x-common: Add pinctrl node
>       ARM: dts: bcm2166x: Add bcm2166x-pinctrl DTSI

Please funnel these two through the SoC tree!

Yours,
Linus Walleij

