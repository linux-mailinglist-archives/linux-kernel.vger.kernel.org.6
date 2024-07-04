Return-Path: <linux-kernel+bounces-241091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23969276F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBB3281FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5F1AE86D;
	Thu,  4 Jul 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjJCeZst"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214441A81;
	Thu,  4 Jul 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098821; cv=none; b=Z+VbkwgNmEI/IKnJcfD0eTygGW3neOybWs4Vy421GJ/7gYRd4E0yaPKbL7wa1bXmBm8rkQTT8DKksEPDv+JSXhJXeLh2YNLp/qK561i8l2XJWvuAQ7zXuNTkXW3/bnDJR1VHLZZ/fW35qN9Ugf7rn9mkAqM0MM9hROcYWeQ6QAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098821; c=relaxed/simple;
	bh=m9rR2mQ/wSygZXAZMY/B7NSsL0tnpf12HSm+Z+ZsFD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPaaS6kOZ7Mul/4Tc5knQPlKFw1n6Rh+vbysrrM/84K3wGkpjKR/AKWD1JXyjkTv82d+/7KsqoH0sQxzvnWvfp78Yco4rDzbIuCx38SdM8/QTAQbwhVFZPER2H99j5sMM/bRq5JbLm5eq6INa7QNKtEZiLAGy512bPXINXi7+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjJCeZst; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee8cccf2bbso928701fa.3;
        Thu, 04 Jul 2024 06:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720098818; x=1720703618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJOBBEbKWmJTuqge2NQgqId9OVl2P7+HobXFfEpNUao=;
        b=PjJCeZstAFWz7zxnPaATrflWn1n9gbAaCNshPY1w6zW3oWUH7nvCL8CRTV+Gz0U/wd
         iIQjvyDqq4f5Q2p3cdZIe/9N83DMnpvXDi9Bx7SQCYxBpHKNvCefP3p7mfUoI0TGl0rm
         oHWzg3w4C7314CELsNsHtM5YtvvM9Na79hs7VnYX1ODjuKW6Wa7E6e792aqHcB5467C+
         9PpyKJN7UvKGOh30WRsofC+JQA7lSWIyXerqnEneZAO+7xpMg4Dj/wo1kQKu8Vjk0mun
         BfVM904WmZ5GRv3kFwDo4bzbZnTNj7FHWhH8lg8KNXhXGP7/gvK8EDHKkrowNT6NUrdt
         kI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098818; x=1720703618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJOBBEbKWmJTuqge2NQgqId9OVl2P7+HobXFfEpNUao=;
        b=TunnWjHN8s2cm96cPwiahJioq7YbwNRGUgyti0Pn1L0OrFGfk7td8/2EtZO93ywo4l
         Hy5q2yjeMzMH/kW8kwx8EP3t4DB7Sk2tFPG93hYBliJd2M1OroIyM8fKMR5o9Xogu59Q
         aoyaInmFuO65WNWkcu6MrmwzkXwhDal+uzcbEVXZkkScsycvt1D5kHiW9qAwYg4LNMYm
         4VbYrx5sMwbHqsCl7PaVPV50mxFKk4pjQnNwyzukn5BDjUeU6J7iaxQxyagukeH+jxMg
         6iFNd3CX9c7aSBRBTksqXIx9HIRuYnECRerOmUQUupeNLUSvc7aDaIirJpX3G3UkXGeE
         Enxg==
X-Forwarded-Encrypted: i=1; AJvYcCWEeT1fFVGxF53x/pmeDmqbNJyBGBXjJy3HoWb5pw0w2cTsBRd4l+0a/K0PxcZmgGDdhnyeMHV5xsWXUESnKtPSUdsxLba3eQ1DSuxTiT3bYoZHK1K1+ym086UgcHWil2DI93ws/DfU9A==
X-Gm-Message-State: AOJu0YxruZQCiYGJOktH7lepwJvfKX2oIlq/UFIKk+iC7spOjut6zPgC
	qzNNOBeObvGfHaqIsq4bwOuKveXj+yeMwn5l+7/MIMlZgqRYhNCKaw60qeUgEgiWA8FPsl+guLZ
	nDpzG/x3UW6OBcNzNrM8RGHnLpiI=
X-Google-Smtp-Source: AGHT+IFFj5rrfeuErSdp9ogor+1Ve/j/MRQZsX5zn9HGTR5tBwuQsJibSORbuPOz5HTC2RdE2S2VeDPOERJJ7117MHY=
X-Received: by 2002:a2e:2e08:0:b0:2ec:5258:e89b with SMTP id
 38308e7fff4ca-2ee8eded7d0mr10868431fa.3.1720098817502; Thu, 04 Jul 2024
 06:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704120300.2849264-1-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240704120300.2849264-1-ciprianmarian.costea@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jul 2024 10:13:24 -0300
Message-ID: <CAOMZO5BVS71UWS2u15EvbNLohSqRz8DamvXBQzRxFSNTobJG=Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: s32g: Disable usdhc write-protect
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ciprian,

On Thu, Jul 4, 2024 at 9:03=E2=80=AFAM Ciprian Costea
<ciprianmarian.costea@oss.nxp.com> wrote:

> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -145,6 +145,7 @@ usdhc0: mmc@402f0000 {
>                         clocks =3D <&clks 32>, <&clks 31>, <&clks 33>;
>                         clock-names =3D "ipg", "ahb", "per";
>                         bus-width =3D <8>;
> +                       disable-wp;

This should be better placed on the board dts instead of describing it
in the SoC dtsi.

Some boards may use a GPIO to describe the write protect pin via the
'wp-gpios' property.

