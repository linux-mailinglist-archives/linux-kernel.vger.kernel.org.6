Return-Path: <linux-kernel+bounces-406546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4069C609F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F5D1F219CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEA021790E;
	Tue, 12 Nov 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNauDYvu"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9E21764C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437050; cv=none; b=RjOp6cv8BLdl1ZTsUJnVXVnvBgrRvAD3mHl54LojEvNuMgwDL5xDpLqt3VXrhgg6kDuHai5DICVnxzGzKMFzWWZWJOLzlkr0j122nVwUyu2jJz4u6tPI+DkoqKsqs2iuAAnQ+8etIsSi4++gm0do7aTe238XVEaktseG2FNZMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437050; c=relaxed/simple;
	bh=0t8sOmwlSOH1o1/6C/3qT6TANEqdqVcQQAurabnYBIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYoGWV5yfxP9QBngSsAgTq19Mo1PNODdtsE7wRk/xWIIwehMLsgXzyGS+bGRh6iu3iRkpGKsPQ3EzwblmiJoFBJC4zubDzRnBrLxCl6HCVVni0i8CIkVdUx14f46ufb+8LVQwpsr9VDuRpaehQDFB4C6mwBX1YatI+T6kE27F00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNauDYvu; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6eb0e90b729so25980857b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437047; x=1732041847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmlE3ocaQwI744iyoEKb0Mlm8+PfDOrWjfONTieFefw=;
        b=lNauDYvua2CJ0TotVd6/rHjgkprqjGgJDyWlfthLZpZDRxPNSfMuA15TFxeSVhYBk3
         VLTx9qs+otuM9ZN0gRGrOKfxTqzqFkN7dL/1zuJ7ID1IYoUm7isx4xYVxhOpN0Hi/3Qn
         w1yq1Wg8hiqM5l8/ubMHLa4Th8NL7FTcfI8lAwF4sF2GZ5Y9JpNTPmSzNhbaswcbYukq
         Wg3kR1k9QQcNqkZ74Qd+V/f5hjbFDMnJrMepS94liYs2spuDhGJSx0FaSuO5pNFCg2b1
         Kfua03yYL/Vwxt3rAl2pP42XLZOA9itxKXA2dFEz7ax2/XeD4mZXSmDu7hoBxQeSHCUC
         9BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437047; x=1732041847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmlE3ocaQwI744iyoEKb0Mlm8+PfDOrWjfONTieFefw=;
        b=HeEKpw1gjjtXjgpNHar0J1m3Bx06SbLkXp3MSYbcGhDfn7OiFWo6ipEJ/ZOcnw5h1Q
         ojSpTBvBP+hyj7NWFrdKa0x3yJka5j6GKM+z3HSi6BI2kGCBxbwexrfx22TD8lC03XKg
         OkW7eWZBfCLR+wA91a23zEFzhe6oit+FcrrJXn5qjXdwGDmUOv2Ik0AzKTmEIwuiB+TE
         KZ6+9153Drh7Ml/nvAr1TGHj8Ut+fpFz5Y7+f2pI7K0vgSG6wpaE8ka7l0+4UhEKMR+t
         qIUxCkUq/jzbRmhzK9Mz20AqrHOYmPaX2KH64D0Dob/eVaB2K0YXfGkZIHupjmPHS+jg
         +QlA==
X-Forwarded-Encrypted: i=1; AJvYcCURdqyihkA4WP47ZZ1EkF0cspp80RqRnxEwCl4WLKPZcCJve+XeVRO+g3DImS0sRQS1TijYcZZsGIXgOdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQ9PpshwspC/eWNiLspRJxKvpEpeVSya45jRm4rL3Wdd5iv6k
	DK3R4TGV+GpfhuJ3CjCiU3tbmFKs409++9cnzQ8GhHHnIwJYxjbcy3jgVoH63w7RTEOswYg/EKC
	ToCBRnkhT61wzPJ5VuApYQvwBvKmcmfPCR/vnTg==
X-Google-Smtp-Source: AGHT+IFh1YSNqJrUyWFeYrySj4puHrtEywEG7OT7qiq8/ABi/USrmbl/pgQBx5lmlFIuZUP2a34Q11eyh0jgarstWi0=
X-Received: by 2002:a05:690c:998b:b0:6e3:3508:e32e with SMTP id
 00721157ae682-6eaddfb97a5mr155863057b3.41.1731437047401; Tue, 12 Nov 2024
 10:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
In-Reply-To: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:31 +0100
Message-ID: <CAPDyKFq9uQcDsMpYXKe=8f7AGybZaUsvMVU9RDxv2SZpYwbdgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: host: sdhci-esdhc-imx: implement emmc
 hardware reset
To: Josua Mayer <josua@solid-run.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>, imx@lists.linux.dev, 
	linux-mmc@vger.kernel.org, s32@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 12:42, Josua Mayer <josua@solid-run.com> wrote:
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v3:
> - reused existing control register definition from sdhci-esdhc.h
>   (Reported-by: Bough Chen <haibo.chen@nxp.com>)
> - placed both control register mask definitions next to each other
> - fixed timeout write register name
> - Link to v2: https://lore.kernel.org/r/20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com
>
> Changes in v2:
> - replaced udelay with usleep_range
>   (Reported-by: Adrian Hunter <adrian.hunter@intel.com>)
> - added comments for delay values
>   (Reported-by: Peng Fan <peng.fan@nxp.com>)
> - delay values based on JEDEC Standard No. 84-B51, 6.15.10 H/W Reset Operation,
>   on page 159
>   (Thanks to Bough Chen <haibo.chen@nxp.com>)
> - added a second patch demonstrating a cosmetic issue revealed by first
>   patch - it bothered me during development but is not important
> - Link to v1: https://lore.kernel.org/r/20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com
>
> ---
> Josua Mayer (2):
>       mmc: host: sdhci-esdhc-imx: implement emmc hardware reset
>       mmc: host: sdhci-esdhc-imx: update esdhc sysctl dtocv bitmask
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)


The series applied for next, thanks!

Kind regards
Uffe

