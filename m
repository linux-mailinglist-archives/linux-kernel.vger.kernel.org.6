Return-Path: <linux-kernel+bounces-561142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955A0A60E09
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABB617C5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB91F153C;
	Fri, 14 Mar 2025 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCz/9UVU"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0B13D8B2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946325; cv=none; b=VTYN4yxNdgUHzgXWG6jQB/MO476GLYqWJ8MvUGUxUg5879UIhyfyb5N2onD00CDA57GYheuO20EnaZxjIGgHgH9B6egdvQjSaLRqQOUikjaMM6Lrfkb9GfNiu9+qdTXtn2MjnA03EOXUFDceEBtN3WcQ1B+phj6lqTd8DnjZWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946325; c=relaxed/simple;
	bh=3R/xMW1KRHZ8whxH1MaliizhE8y6irqdOv62B/5CbE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6KbmmlZuWSk9Z7/x3Ppmlk7+SO14BTlnXX8Cn2w3su+/HxNAi+AMmdqEQQCgXPfV/kMvxnctoUO1EN0hTHEvzzWiBLg9zG8IMCJqztGP+rH6OXJ5zh6xU2sTn++8k1LM7t4s3Mr226Zs7Sp2zOMsdodP+TiYOM5GaL0IFpWaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VCz/9UVU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30762598511so19862411fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946321; x=1742551121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R/xMW1KRHZ8whxH1MaliizhE8y6irqdOv62B/5CbE0=;
        b=VCz/9UVU8euvRsY4USKad1OhraYKdrg7ZCH96O1CN8US0gsvQ5SFy75d5yyeM2JypN
         BvFl4yq3gAdgVCOrWPyd2YHBCkdGamHFl4+fq8l3MjQSjyQYjn7nmiBtJvpba4Kq3OHY
         DMCEG7Vm/cbYmlV31Cszs239PvK/cuk8d+hV0WbJX36YWQroAoL2k7GeJc7R3smHSD3B
         6mVR3TJBWMPB0F5tbciCwnxuhKggb8vY/Kp9nO4d57X5MmuQUblcJvevnSP88Ukj1BaA
         EKbBH7+GirkZYXIXHu7RYz3t0uW1fX1IuRpkaW1Dx3XZ8wt5Jl/dvSH9XYgrZPL7Lj3p
         fdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946321; x=1742551121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3R/xMW1KRHZ8whxH1MaliizhE8y6irqdOv62B/5CbE0=;
        b=FNIFh7eaOxE0KUN5P/OcxGeyrMSWYzuIP9+UrIn6pR2/OanKhts41cZx+hr4QRWtp3
         qBcJ0ou0DkjmMm/hnVtZYYH3vSDHf8yII5FfscinwAIvkoC5h2k49E5uMS8BHRd0qpoq
         J1jLO1OUcoHuuI9zsXiQDgHBn47ZbafvNvQyKPzAazAgKpuWg7eYF/xlXjkaY2eiFltc
         djMBPEQqI/dXCLcGAI38bnlJmsKaSI3KO4I7+x/YaVxmDK4vQJoONJYyZ/6GQmNYsu7b
         sM2YtsDUdsnFPrXoMfItLyE/wy361D4LnFHaZC3L/9FvTdODhfnuElQ2GB41IAFpUupd
         zkHA==
X-Forwarded-Encrypted: i=1; AJvYcCXPXmhdsgA+AE5A5K3NmLeHVoBIHe/JSKRjNd13sWSYPdlyZfDA7YJZdv6veG8XrmOT51wKnvxxL4opH0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUhrebBASvEhnSvGIOI5O1Uc5a7b4loklW26mRkqEAH2Vku61
	+0qlk0dzFeLjAsocsL5NKQAxjVclDPGA4nhCnLWH4S+miBCZUxWY8B0Q6+TZh4139Qe0QGdMZJx
	naxVrIb6D0IDKPI9b+9tPfj91rAf6hBpWiWd1+A==
X-Gm-Gg: ASbGncszU/PY9v23O0O9lex39Dblm84gNmbL1riibdJRfaHXS87z2GWkclzTjZ8hpSN
	aci5lspu9bWalyRZp1XuVSt4al4cTgTs9U3QSPE6UhmAioX6tWM/ixUORZnaFDtlraPY8fgCogi
	pU4nK47Fv3RIA9E44CplMMrM8=
X-Google-Smtp-Source: AGHT+IGc3omYZ/PigNb3EELyzJBtPU76XiDZ8/lpHySnqIua+3ffxwK9HjrgiuZD5ypFcw6v7zL4wYHXWwqXE5nGVqQ=
X-Received: by 2002:a05:6512:158a:b0:549:8f21:bc07 with SMTP id
 2adb3069b0e04-549c38f1fbemr588651e87.26.1741946321224; Fri, 14 Mar 2025
 02:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225140732.21557-1-ot_chhao.chang@mediatek.com>
In-Reply-To: <20250225140732.21557-1-ot_chhao.chang@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 10:58:29 +0100
X-Gm-Features: AQ5f1JoobXwU1DJzGtfpxiI6KI8sg3dxeI7nlvijJlOYjKzE2Ra7o1u5ZIyffXY
Message-ID: <CACRpkdYSNMV2jymbHaxRp-PmzbbkEJ_eUcT20whYw3gdhEGOGg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add EINT support for multiple addresses
To: Hao Chang <ot_chhao.chang@mediatek.com>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, Axe Yang <axe.yang@mediatek.com>, 
	Qingliang Li <qingliang.li@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>, 
	Chunhui Li <chunhui.li@mediatek.com>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hao,

thanks for your patches!

On Tue, Feb 25, 2025 at 3:07=E2=80=AFPM Hao Chang <ot_chhao.chang@mediatek.=
com> wrote:

> This patch depends on
> [v3,2/2] pinctrl: mediatek: add mt8196 driver
> [v3,1/2] dt-bindings: pinctrl: mediatek: add support for mt8196
>
> Please also accept this patch together with [1]
> to avoid build and dt binding check error.
> [1]https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D&su=
bmitter=3D215008&state=3D&q=3Dv3&archive=3D&delegate=3D

Since the dependence series is not finished I can't apply these
patches either, do you want to send an independent version of these
patches so we merge them *first* since they seem finished?

Then the mt8196 series can rebase on your patches in v6.15-rc1
instead.

Just send a version based on v6.14-rc1 and I will apply it.

Yours,
Linus Walleij

