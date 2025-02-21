Return-Path: <linux-kernel+bounces-526527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54678A3FFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB207AEB77
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70EE253339;
	Fri, 21 Feb 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPAEuwEu"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539F25290F;
	Fri, 21 Feb 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166647; cv=none; b=cv0tb6/U0odQ4V/DMqOED2CztG7uQfy1EOB2Ev+roP1okp5j9s9Wvmc64qe88XuDx6dT/B816wetz8ippMGVwrUMvdL/0GbcyuyobVMtw8UAML73e4l9x7nAWBFkmnRPlt5ikLXl7PUOPYaYXr2ro04BreEnbqTd9WKBt4SNo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166647; c=relaxed/simple;
	bh=HbTWCcViPPsmoLTr3+5YzQtPxy9tXO0RObpIhkFecVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+OhivQLpAl33uymAjTp0m4AdDIz11Z0XCEnzWoMEjfqj3ITKtK4r6CpsP9N2M4+X/Tg+9Sa8Wrx8og+6AXPEWt4n7f3wsHtJ/lEMurvWmMbPTIxnNgta3Jh/rV8A21PKZAjfAN9xIhkaiyXILkoCh+N34+++dtCAi7yWWFfCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPAEuwEu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so5029662a91.2;
        Fri, 21 Feb 2025 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740166645; x=1740771445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5/TJQCPhOXtoCrPiCi87e6OcHCUr8SBAEgJYV6f4qI=;
        b=IPAEuwEukYwc/X1YcABH98WLUJba1A7z2CNz5AFQpvocZy87uIfL/g3fkrVLAY1kxC
         iNd+qaemUzyk3rhHurFNVupFbKt2HAPoH0d/MeqipX/BFvZoGY+3U+pwHoa96vVSZils
         FqWrfz7vMKluxj02uzzczoZ+2PFFyuY6Xs/HAbb83o9NkJeabSHjUSPRZ4zTpYI5PzyT
         oqJRzpB3pMMDF4UsJd7q2STtiG7kxM+zfHGMZ8pkr6GIyHns9btdM/JEDUco/5G46MeQ
         h34v1ETJR+fpGhd9lcHijb5FWcdRsbdxt6Pd+Yd2VWphFKsl+IDkcEbpqrvI9H0WYqWF
         kheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740166645; x=1740771445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5/TJQCPhOXtoCrPiCi87e6OcHCUr8SBAEgJYV6f4qI=;
        b=SLhLQpsdvRDU5MTk3iqTXTqet2wyTvW5ipeTlA6tKmcbx5L2RbzaI0DNLJF6dcDjta
         A4YAvsxbr/0x8OPSXhbJJs4Vpx5WtSivytCrTwSOS5tYkSa2FGHswoaIwYpP+RG/+fOi
         e+HAscHaGPRsA9TGoTuRwZz8s/0mcuyvaQwp1ZM3oMofMKGukByFlZT0fvZ7Sggg/tr5
         zrcXUZ5cWMgtab8SXBNNFKnX9ex9LGTt5RsG82Vx2T97irAJaRxwZotlIadrXNthnvhi
         uwHEm9CSn91VQXnoY8HkfGQlwCv3YETGhSQ8Vq/BAthPy8dA5Ramm47bpz6sJpvdglpx
         nWvg==
X-Forwarded-Encrypted: i=1; AJvYcCU4hPDiI58af51GEhBLeEEOhTqnPRgeeFtznsKDRtqanhQAmW3yHJfG8Xxok1/1AbhlftUviJuhvcfi@vger.kernel.org, AJvYcCUHe2Z0fX/F+aX/X+w+7r8MQjNtewjeiUZ0D3qn4fTWRm8i8m532vZoga9IgcI3zrZ1CwS+lWM58vG7@vger.kernel.org, AJvYcCWluazbK2ewV2P3tnxonlgbNBVOmatGRYzhSW162StHvXZVYnn8xmjzQG0hRQLgmcCOjEPxaMitxWRVx7ZJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Hj3BwnVRKWU0ioahjZKPgU7tqi/vfj7j9QhaiUT1sD4S6B2J
	1ikiEw/jh1XMpZ9xvbJCHQ/rcE6OddHUgTbAzQLEaHrORMIFvTBh+ACMxzo//CrXkJnYAzdwDve
	U7GHRXLDMvVnSW6IkWmjYfITSTc+ROGnrt00=
X-Gm-Gg: ASbGncsu6TTZNF+LieLQeoV4iGi5I/NtcbD3NV9GI8lLSarkVfTWrfnPRRovSk8TmVe
	4fS7eMr+fwd6Q9ojPLiYMC9V3omTUPPK3Zr0IOLKfqtq0+08cwspswagLJgO0Q7mB115qErVj+n
	bea0KgXUM=
X-Google-Smtp-Source: AGHT+IGO5kmKNshQe2c5M4D/K0SzQbhuXNJ0QO3tdj2iHLQJhE4x02XTjnINnRUvMgd1/kya6uNiVNBOQ3RUUR6+yt8=
X-Received: by 2002:a17:90b:4d0d:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2fce8724453mr5847905a91.26.1740166644954; Fri, 21 Feb 2025
 11:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221190929.31469-1-laurentiumihalcea111@gmail.com> <20250221190929.31469-5-laurentiumihalcea111@gmail.com>
In-Reply-To: <20250221190929.31469-5-laurentiumihalcea111@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 21 Feb 2025 13:37:13 -0600
X-Gm-Features: AWEUYZlpZEzoF4sSIcwIUtnabf9TrVj8-PJAh3_pn5QwRKlyCWUIXfCyiFWMcs0
Message-ID: <CAHCN7xL=QZHs5sD7Ja7pBOcXM8cWVQYe270EizDFN--CH_5+zQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT
 freq. to 800MHz
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>, 
	Stephen Boyd <sboyd@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 1:11=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> AUDIO_AXI_CLK_ROOT can't run at currently requested 600MHz w/ its parent
> SYS_PLL1 configured at 800MHz. Configure it to run at 800MHz as some
> applications running on the DSP expect the core to run at this frequency
> anyways. This change also affects the AUDIOMIX NoC.

Unless I am missing something, the i.MX 8M Plus Applications Processor
Datasheet (rev 2.1)  has a table of frequencies, and
AUDIO_AXI_CLK_ROOT is shown to be 600MHz nominal and 800MHz for
overdrive.  I agree that it's likely not running at 600MHz now, but
800MHz may be out of spec for people who are using the nominal voltage
instead of the overdrive, since overdrive requires higher voltages
than the nominal.

adam
>
> Fixes: b739681b3f8b ("arm64: dts: imx8mp: Fix SDMA2/3 clocks")
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index 86c3055789ba..54147bce3b83 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -834,7 +834,7 @@ pgc_audio: power-domain@5 {
>                                                 assigned-clock-parents =
=3D <&clk IMX8MP_SYS_PLL1_800M>,
>                                                                          =
<&clk IMX8MP_SYS_PLL1_800M>;
>                                                 assigned-clock-rates =3D =
<400000000>,
> -                                                                      <6=
00000000>;
> +                                                                      <8=
00000000>;
>                                         };
>
>                                         pgc_gpu2d: power-domain@6 {
> --
> 2.34.1
>
>

