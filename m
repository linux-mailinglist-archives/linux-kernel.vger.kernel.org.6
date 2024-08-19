Return-Path: <linux-kernel+bounces-292104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55677956B25
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013211F22BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F4B166F0C;
	Mon, 19 Aug 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwEC0i8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4F171AA;
	Mon, 19 Aug 2024 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071720; cv=none; b=cug2B6O5Mf3mW8SAowzwHdgwaYGHNkJpCSnFMsCnarfXzFcQ+ct2dCE/pMXQW9bgEZAQvh7rvq7+hHdJigmQL4k5BYauta2dGxpRZy/xufj6d00fTb/YdDmCPsOT0Q/8kgNZfkb9pDSA3fHlCXMha3yldzflD2v9g7fjdoiotQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071720; c=relaxed/simple;
	bh=VeC6qinsgdSJFUHZy7TXTLOd71KCTHGWUrsHusbBpIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hr5UNqDuj7RFEGevH5kNLFUHB0o3fcUiZyx+viAiSqupJB7jw2GyhX9a0W7fYVRksV9F5daukgxtQYPOgYyfMgx6hoePs7jpnSuJ5teKUQMS8P1xWipaS1TEUnX61GTgG+5sa9gvXBhKwFJ8mrGaMLDe+J2B3L0YI+QFB1TefH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwEC0i8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F02C4AF0F;
	Mon, 19 Aug 2024 12:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724071720;
	bh=VeC6qinsgdSJFUHZy7TXTLOd71KCTHGWUrsHusbBpIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cwEC0i8IRulT7qVZqhY8X2U1LZyq5l5535fPl/Ay8Q3IgVvlq1M9qwPIM8YkrDSr5
	 oYXCRrhG/F/VgIQ9R5fgXXV3v39nZNrFQkqQJMDb8g2QIK/lb2eqOoKDPajlvGagee
	 +YcfoCjEOGX7y6/wJMxwUGGsaPNj0RlW04SCHxPt9IwrOVz0MbJHml0k9Lf+DPW0uz
	 5LOvQdUMS392dsjSj1+XOOJIuSq/DGZh7HvZ30Rl/8Cj5gKjbnw++6Mraw7cXRULhv
	 7uwY3hJyl5wyvpSwXLTp2ge5nrtFHDgE7jJOkLGcq5vOAhV5zKjO+Bj9H6YgyJAPiH
	 a1CKdxZjQJqlQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04c29588so5808190e87.3;
        Mon, 19 Aug 2024 05:48:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtqO8RYnPAhczzf9kvbErGO73/8pYrWD0/tJBozzyDl6mfdSoRynd/ckJnC+5UNcBB9tToBhW6wuRWT613al3AZz8q9dCQH0jIBXvMf0tY9QPOyExyHX02iWBcxkLCn0pF1crKuo6W/g==
X-Gm-Message-State: AOJu0Yy1D1EJGEHuEhVqvEQRByEe7pjSzCTAMKYWEmr9VitVMm1M5fOJ
	qWq2AG1rNkcahLDdCetppqFKrkOwy6W/xemQ1zfFuX+EXLAigh8v4OWCyExb5Wo28v6Zmc3CKYg
	xVATBG199552dnM54CUGYd3C9jw==
X-Google-Smtp-Source: AGHT+IGUv2VCrgwia5FSI9wYqGvyyDKGFE3Ln0Q1xp1SarderZlIjiNvyFM5dBH1efWo1ZM3O5R0ZKaqxMqABBy+TZU=
X-Received: by 2002:a05:6512:2824:b0:52e:fa6b:e54a with SMTP id
 2adb3069b0e04-5331c6b1d1bmr7926481e87.30.1724071718624; Mon, 19 Aug 2024
 05:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com> <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
In-Reply-To: <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Aug 2024 06:48:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKtuuOyRu+fQ6Yu=7QHMWN+qPwwUYmuuEufYNtyyTw81Q@mail.gmail.com>
Message-ID: <CAL_JsqKtuuOyRu+fQ6Yu=7QHMWN+qPwwUYmuuEufYNtyyTw81Q@mail.gmail.com>
Subject: Re: [PATCH v12 28/28] ARM: dts: aspeed: yosemite4: fix GPIO linename typo
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: patrick@stwcx.xyz, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 3:26=E2=80=AFAM Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
>
> Fix GPIO linename typo and add missing GPIO pin initial state.
>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 554 ++++++++++++++----
>  1 file changed, 455 insertions(+), 99 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index abd4a9173de4..4090725160f9 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -285,6 +285,8 @@ &mac2 {
>         pinctrl-0 =3D <&pinctrl_rmii3_default>;
>         use-ncsi;
>         mellanox,multi-host;
> +       ncsi-ctrl,start-redo-probe;
> +       ncsi-ctrl,no-channel-monitor;

Not a vendor prefix nor a documented property name.

Rob

