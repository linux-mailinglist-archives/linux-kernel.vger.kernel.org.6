Return-Path: <linux-kernel+bounces-323226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E15D9739BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907951C24896
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F39194151;
	Tue, 10 Sep 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNtgNXN2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01B18FDBD;
	Tue, 10 Sep 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978032; cv=none; b=VT/AOjdajHTMHMePw76ldfzgFXDM+wDmy/e+QAQjP5NUO8LCHF4vJLE8bMKcMNb5T5aWZLo0O19fz4U2dEFc/c8IYhXlTzFHDREXZbzuExJrXMbNive63BMY7fHFRPb5puamBj76rCbRtjbwuYWHcIOAF7PLIXXiM+lPmdTwClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978032; c=relaxed/simple;
	bh=4KDF1e8TVKxPgvhlss3fyOwBw5vqSdkC+rz2EjSllDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjVnD96TMyXaCoFTFdhItLL7YY5q4h9+9hECO7c20bVzirHmBoDWkemjG1PV9/rnLYAb5RwQndgZucNyoXeqkA3xDMoWjRgxyBMQg9fq5vr0w1EfVj9Zu80v5ilWjBDEM0+jY+MabWP+TCUTp3ltiD+KGhtR8N2BPS06mg2L/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNtgNXN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAB7C4CED7;
	Tue, 10 Sep 2024 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725978032;
	bh=4KDF1e8TVKxPgvhlss3fyOwBw5vqSdkC+rz2EjSllDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aNtgNXN2M0+bC9YBAM4MoB3fsY0CFKsVYezVrX1QptCfBsjHU4Txb1bR7p7eIY8wj
	 JrxjCsu93ObAPCngSiJOEDp9fTaV8GvcFIxtvOm/A6X6vK85U1UtyIvcC5soVAZLIX
	 VQ6gKYIAwUCprXwzY7hFPSn8VUtQKzLl9FBfe6Hf8k3Xba9aHWNyOXl0wdSDkJK3S6
	 xRNpDG6H5h6933g7rUEjs86uMWqfuH33vvg5Tq/fN6crdX+IJZSSwNjcaiXBDgVA72
	 rBTiHV+4yXdG2BJhAQlnm4qWXgpuRwUe7VcFoi4SNZUKIAt/hmsRxe5CKjjIMLGHYj
	 HVVH3DmOsl2FQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so973655e87.0;
        Tue, 10 Sep 2024 07:20:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWr0ZlHy9V3EaduKU+2hCZKgv1z4Gf8zZGgvN5G5qeTOqDxTREkP2Wd9jXuQklpi7S3SxQLFvqXvhYu@vger.kernel.org, AJvYcCWxUqq0OVmOUr6uzu5djUDX3UthAVH+Mee1gqVrsPF4e1J2vuqlCuSX4TtxtrHV3f2wWNGuMnCPDTQN/eRc@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPBWdv6SSJ/7l+tHLny2UXOmKTd2Qfx3PCrEuv9WY0+RR70bm
	qsBYm2YErwi7EnacEzPE5VLcNHM0D6hRmgRzsdt2GwGitZLcpvFXDYYcYof4WXt63q3LnEBZqz3
	l/PNXZoX2Z6Cs8cQy99UUK8X+vQ==
X-Google-Smtp-Source: AGHT+IFRvPc0UNJ2YwfVBz4VuqnSdznayKEw+oCjGom392hIonmpBTgsOkxTdF2NiiPAiOAo97MJcTXUNCSpMShrVB4=
X-Received: by 2002:a05:6512:ac8:b0:52e:f9f1:c13a with SMTP id
 2adb3069b0e04-536587a5831mr9910684e87.12.1725978030716; Tue, 10 Sep 2024
 07:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910102326.927544-1-lukma@denx.de>
In-Reply-To: <20240910102326.927544-1-lukma@denx.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 10 Sep 2024 09:20:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKDo662kF2QDFOQZoGg+ox3=N1vWZOAiB=R+FBY2gTFKg@mail.gmail.com>
Message-ID: <CAL_JsqKDo662kF2QDFOQZoGg+ox3=N1vWZOAiB=R+FBY2gTFKg@mail.gmail.com>
Subject: Re: [PATCH v5] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:23=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> some extend similar to already upstreamed XEA devices, hence are
> using common imx28-lwe.dtsi file.
>
> New, imx28-btt3.dtsi file has been added to embrace common DTS
> properties for different HW revisions for this device.
>
> As a result - changes introduced in imx28-btt3-[012].dts are
> minimal.
>
> This patch also adds entry to fsl.yaml for btt3 board.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>
> ---
> Changes for v2:
> - Rename dts file from btt3-[012] to imx28-btt3-[012] to match current
>   linux kernel naming convention
> - Remove 'wlf,wm8974' from compatible for codec@1a
>
> Changes for v3:
> - Keep alphabethical order for Makefile entries
>
> Changes for v4:
> - Change compatible for btt3 board (to 'lwn,imx28-btt3')
>
> Changes for v5:
> - Combine patch, which adds btt3-[012] with one adding board entry to
>   fsl.yaml
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +

I said 1 series, not 1 patch. checkpatch.pl will also tell you
bindings should be a separate patch.

>  arch/arm/boot/dts/nxp/mxs/Makefile            |   3 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts    |  12 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts    |   8 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts    |  12 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi     | 320 ++++++++++++++++++
>  6 files changed, 356 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi

