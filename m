Return-Path: <linux-kernel+bounces-171062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549008BDF52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4281C21464
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D114EC48;
	Tue,  7 May 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClqbICPf"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A0E14D443
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076243; cv=none; b=Az9Zj/DYDqMQyVQXnuSurrYVkxzBsMjsCboRMJ248eaG/r73aKQJ6hD2v67GlwA69UIwdwqSDdmHEKapaIb8tKaPyrvSYwGhQsIsyZzb/w1RkWlaPNQDA8AGtjHKTNwl3bbvF0qSsUQ8d/IxUGFCj0wLBP1WC9JBdjKIMJjSb0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076243; c=relaxed/simple;
	bh=jnbmoIfEkquEEjiJBAjqdCDBxOD1+Yzt7A7OKiFlJfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCxuI2g47OS37rHBSUJnGSBTHNBY7/K3wtGmT8M1K5IBaU2Zn8u3eGJY50Mswbsofd575z5hzpeSRDfGlPkNuriTCxR3M6cB89apbN8sn1L9Ufqbjd0fyTdkTA1ewwCCDeLxInyIc5ZlQpAnWb2/e/TFhsqz2nJ3kMRwEreNMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ClqbICPf; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de45dba15feso3080585276.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715076241; x=1715681041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENlfgQ3ADPUMWuBuiOLhnFoQNEtfud/j+QDtLaNAUG0=;
        b=ClqbICPfGWs4b3Kil8wr9qUk9sNcSadQx7MKrglRxSUZNtKHMoGjJUbwrtS+2iOZJY
         eadxodiGOSOVLNQMyvANf317P6IFUtwTyUHhLOt7M7tvuVa/fwz9wN/+erbwFLXG2g2y
         1oH8B115XICgrEKBcpZvfl1GSSwX37sXhcPF1RBF2im4pDZLcSScd1kn3Gou6n+G+CNJ
         MDSKhUcbfeueiOci2vFZoYnyvQC5mgekuBzf5piN9ZJrWOwhVArEPla0MNH3XSuSPEQN
         u87VP4F0SjIDS3IEoI6MmIpP0Ep7GIo0z+K7dW7iDrf4EWBDrubFEtAe81yZDOMJhAG1
         LZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715076241; x=1715681041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENlfgQ3ADPUMWuBuiOLhnFoQNEtfud/j+QDtLaNAUG0=;
        b=NWZNcufY+XNuczcniQ1d9hSK/yuy+Jo6isE5/vDsbK7vWQr8RMoCYu7UjWBEvwUDTg
         BsjDLh0vgsDOljiuJ0TJF8pjhOKzxSFe9Los9v9jjeGMFPa7yJwgtVeUQf4x9/hkqfG+
         wifMyzFAzgHb95jav7IFyeuEDGDUphGCpO7s5Qp9Mp2enmpur84JBW4ggqs1Xdzg66KO
         8yDep+6EiWM7r7AhjCF0DOrlU9nZjsWIWyrtVFdFmLUvumr4v3sWhra+//0sSX2ZINTE
         D0veUndV10N8bPLuyxswtqm8rZH9zhFNZDgIMkKtgUcmg8cDjyJVOddWdf8BYz21ie7y
         re2g==
X-Forwarded-Encrypted: i=1; AJvYcCX2LKCc3Ue+fl7ommJgjRpYg3hG/ybT/hwKKghZv0exnvDv9fx696F1OltBdUv9nZuu5jM6PjOLCLkmvjf7SruXOz8x8lsXRxzXzkaU
X-Gm-Message-State: AOJu0YxevLjh5oRgtS1AMGwt0pW8Pn3OmjqMUJ0slqgAeumk44L4Ewhz
	kS4S5s1WE/w/XHWKM990L3f5RHwFNNW59WjYBNjvbtJShS3mP1aRLc95ro/RJAfflAFhwpf65Bk
	f4R2SXriX2OMS7ZeOHafJkHAgzcUtIV0ox8dW/w==
X-Google-Smtp-Source: AGHT+IE6RbboWA6zivUgxElWhiInYBOoZKZxCooBjJtVLVKzpcY065ewr27Om73FjNB7+c1CsbFfoFINBaR1I1fIna4=
X-Received: by 2002:a5b:912:0:b0:de6:3c4:c3a with SMTP id a18-20020a5b0912000000b00de603c40c3amr12223334ybq.10.1715076241415;
 Tue, 07 May 2024 03:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 7 May 2024 12:03:50 +0200
Message-ID: <CACRpkda=a3X=jyZKQoOFrfgzpE2C+rZ9UC1VDnCvGL7QP4x4BA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] PCI: controller: Move to agnostic GPIO API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Yue Wang <yue.wang@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang <wangbinghui@hisilicon.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In v4:
> - added tag (Mani)
> - fixed a polarity bug in iMX.6 driver (Linus)

Looks good now. The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Perhaps the use of  _raw accessors could be avoided in 5/5 by some
elaborart polarity quirk but I'm no perfectionist and it can be fixed later=
.

Yours,
Linus Walleij

