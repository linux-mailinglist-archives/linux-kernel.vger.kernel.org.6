Return-Path: <linux-kernel+bounces-219057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B484490C963
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6160E1F20ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F9213F003;
	Tue, 18 Jun 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNWbZ04Q"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3713D887
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706372; cv=none; b=bEyLD/TDjPCza8iYI0Mus8+FnJoNQEZnIvMKNg/Jr2cvQIv9qL2swA+Ym7HgAbY0NWbj/n3D9NucDsQXIc5+sZPUwempvsmLzBSSOZONSVdg57fB23Xj9eqK6NcuawxYo3ruvKwK1d7SqrFvk8AC84INETKsTM4Hc2wEioXp0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706372; c=relaxed/simple;
	bh=klk6lMXdngCdVEKP7J2KBH6LljlLq0Hco77UGKsQj4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hs1nR7d81FiguPoykeblEQ1ijWRpJMS/io66s28WEgQtjih5SrzlGgB69pqmYmCIEiGaECOStif5q3+u2CoVmzYKAOo6ot9xNbVVlej1a9XONzcF3SaAcTu31p/NJi+d/o6LToii3dYiAyUrjoQlOK8RHnnjVpTD1ExfCFVtxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rNWbZ04Q; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso65859551fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718706369; x=1719311169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klk6lMXdngCdVEKP7J2KBH6LljlLq0Hco77UGKsQj4g=;
        b=rNWbZ04QzIw/BPmf5uhqo7VVRgW18RFuLxGJrgOO1VqWug30VlkJBlh9aD8PJokYQJ
         6ivZt7V27/N+3zko7Wd9jNUiN+5tn+oQQum3Izt3KLTh9uAFjzQHhHDqCiHVssTUIb4e
         y1YF5UvysUt/MZxrfDcYlz/X91mFSsin26WupPpYvjUoLx/FedpiERlOy8ERToaYesBa
         HW9Z3xOYIWA8X4wFLNmcrNCAKi/z1G9NqajCN72exvOh/79zQ1VKPbHMddvEG/YrWHot
         ZvdN+mA92onP6HvBa/Ba327QLjfdJoCaZ2hauLRBa964Xzd37rydeeZLpAf3Q0HWZgC+
         qGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718706369; x=1719311169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klk6lMXdngCdVEKP7J2KBH6LljlLq0Hco77UGKsQj4g=;
        b=kqspc7Uxlwb0fCE/CT71dHvSieqEYaJSx8awnLeXTokl+3BG+SOxJXbgSNzis9uI3D
         pLE3K5Cad5PJadJdHC0t1gvU7GMfe6q1723p0Eg3IkvfAL942M3FtbcmzuoyjtFkblC5
         4xKjaa7Vb1DUcrDudhBajbQdZcbUzyiCh7LE0nm8XjD1T8SYo7PwlloAqFRKlZOwK9x1
         nVTK6Jxo765ZnMyeL4RzKoXiCd8vGTX0wL9JliMujU5L3uHQPmbHIYNc+Oo8o1N6zAKq
         udVATkaDqYF9kzM8iUG9qxyCmJeVXcrhSzN8+RhDavB9FmIvv0brGkjB8huIBAaK/2A6
         59cA==
X-Forwarded-Encrypted: i=1; AJvYcCV9V+9THJxXZ5HmPXw9tm9+T720qljMeibfzfcwx+xsU9QKkb/g1mX4c4lH6VHC9JNWvjUinPUQ3YygATunCEgEtk6c1m+PhSRau/zZ
X-Gm-Message-State: AOJu0Yw4pktcNaJJmvdRHHjYd50e/T/uPbOGuqWORPimdyW2F6H+iclg
	7yn68CsnNsmaoimXTClfvj2XQIVMnuceqoeJeWMoUxjgVnjblpQkOpV5QAalBk4Ngkgjy9KuHMK
	S65wrWGiSrHgOI2dGbWyryWMHtJt39CxfbX+Ztw==
X-Google-Smtp-Source: AGHT+IFVnhzqBoiu9GboooE5iY1zi/XLlllZteuuassl+ZmbxgbyJsQPD3pk6oFTjF6bKUOXQjAi+8CRlASoDk+Kx6o=
X-Received: by 2002:a19:6912:0:b0:52c:99c9:bef6 with SMTP id
 2adb3069b0e04-52ca6e5639fmr6700866e87.7.1718706369027; Tue, 18 Jun 2024
 03:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611-md-drivers-soc-v1-1-8f0fc9fff234@quicinc.com>
In-Reply-To: <20240611-md-drivers-soc-v1-1-8f0fc9fff234@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2024 12:25:57 +0200
Message-ID: <CACRpkdZdjL7Z7qY5MTtZZRKQBLWHPKoHKKyoy56mKzZfu=WfPA@mail.gmail.com>
Subject: Re: [PATCH] soc: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 7:51=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:

> With ARCH=3Dx86, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/imx/soc-imx=
8m.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4=
xx-qmgr.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4=
xx-npe.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/mediatek/mt=
k-cmdq-helper.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/amlogic/mes=
on-clk-measure.o
>
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

