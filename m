Return-Path: <linux-kernel+bounces-392249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D51D9B917A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319CD28278C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C93119F41B;
	Fri,  1 Nov 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaqLVQgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1490487A7;
	Fri,  1 Nov 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466274; cv=none; b=EKR8coJ+WvO8x/xqIUvx82lKLCKU+LNGvzBHkKkWghHhS8zBHBoOrBoVZzp/3GAVcE+z9ezEPggMfBKtFtU2p4PHSk7L30+NcEYziE4Rwg+M8xqWRIwkIUwFsRN02yKcT0ryhqETDq8DF9MxzIn39du1n/TzCTEd45R+LDdKwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466274; c=relaxed/simple;
	bh=e0kHCPimWbLEYH5RJfV7zJ1ttlwCl6aBvjWS0mMg2pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVwJ9zz+D8Y8PdYR5Bwo5pDEQ8P57BxW+sQeSD9bMhzuRVrvQhrRvgGRD2sMDr8PI1q4grFy46CKJQT3RhregNlfFKuoCecKD39YkjOPLbGI0qL2CKFDOOwQ3ToPTJ8I8b/TwBczKZx9O9tiXsMqkV8olUJ/KucSFrIFIXVnEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaqLVQgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451D6C4CECE;
	Fri,  1 Nov 2024 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466274;
	bh=e0kHCPimWbLEYH5RJfV7zJ1ttlwCl6aBvjWS0mMg2pE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iaqLVQgIKFnydSYtSuH1xCyFuYz4Lr0NJ982QFQrpvd0Nn3GVgSDsQCW4Va1tbaBO
	 D1ojD6E+8adT1EiLpI02hmV7L4cRCH53EjsVYXDmnq8B48KwMx27jAKPaTj9X1Pu6o
	 +FjffQECHGnEn9oiIYkzSkah2k/xRrapIhAOWXd470vkxQoutqKkszWzekjUAt9sFK
	 5WXUM0v9lk0Yf0GKra3TZ2vyWL86q8EjMiW5lfA0GQe71Di4Js0WfcXWWC6wJi+X3U
	 3i3+vzQBESUi69ZV3zmnS26lXfJ3ZABM7jk4I2urhfuALuPB2ab0CXOIgyLbgchmwd
	 70ivUVr3FvKFA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e5cec98cceso16429287b3.2;
        Fri, 01 Nov 2024 06:04:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU16U4QBplNCLcnXXsmyO7FD2u4H6Oz2snB+U2E0e7v4rDv9gnn8Aq4IQ/5YJoqgqPCg6P7VkDst7U1B0qP@vger.kernel.org, AJvYcCWg07mXpc3+Va8GM45Sm+4i8LbVFfIlnyZn3yVRJN3Oe5lUYb0GvQPZmfAtgtC1hkpDw+U6CUN2ZcwM@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkGtplq15nPCDmqBlg82y5U6S80MrredZXff49rGxrvpqqn2C
	gFO9FDD0kNzTrI4fqK6LicRVW6Y2wHJf9hmNvMkOeg4gENPHwcqcSI2q1eLHkB+mD4dRMqn5Ct0
	9xe7tumGuHt+Nict96BE/CT3hjA==
X-Google-Smtp-Source: AGHT+IHi9R9ZLKkNAlVKBE9uzRV4fcr3IA5fIkPC/OSO61Je9UZvHcfz23a/szZZMYXQXDoWvoY3JpYQe505hvFu1F0=
X-Received: by 2002:a05:690c:7445:b0:6e2:4c7b:e379 with SMTP id
 00721157ae682-6ea523d1ae7mr78626697b3.19.1730466273460; Fri, 01 Nov 2024
 06:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029010526.42052-1-towinchenmi@gmail.com> <20241029010526.42052-5-towinchenmi@gmail.com>
In-Reply-To: <20241029010526.42052-5-towinchenmi@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 1 Nov 2024 08:04:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLv2DJOsL=3bxf229ZdArL1TqArw+9cLtmjYMkm5yfZ7Q@mail.gmail.com>
Message-ID: <CAL_JsqLv2DJOsL=3bxf229ZdArL1TqArw+9cLtmjYMkm5yfZ7Q@mail.gmail.com>
Subject: Re: [PATCH asahi-soc/dt 04/10] arm64: dts: apple: t7000: Add PMGR node
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:06=E2=80=AFPM Nick Chan <towinchenmi@gmail.com> w=
rote:
>
> This adds the PMGR node and all known power state subnodes. Since there
> are a large number of them, let's put them in a separate file to include.
>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  arch/arm64/boot/dts/apple/t7000-6.dtsi        |   4 +
>  arch/arm64/boot/dts/apple/t7000-handheld.dtsi |   4 +
>  arch/arm64/boot/dts/apple/t7000-j42d.dts      |   1 +
>  arch/arm64/boot/dts/apple/t7000-mini4.dtsi    |   4 +
>  arch/arm64/boot/dts/apple/t7000-n102.dts      |   4 +
>  arch/arm64/boot/dts/apple/t7000-pmgr.dtsi     | 641 ++++++++++++++++++
>  arch/arm64/boot/dts/apple/t7000.dtsi          |  14 +
>  7 files changed, 672 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
>
> diff --git a/arch/arm64/boot/dts/apple/t7000-6.dtsi b/arch/arm64/boot/dts=
/apple/t7000-6.dtsi
> index f60ea4a4a387..77d74d6af1c4 100644
> --- a/arch/arm64/boot/dts/apple/t7000-6.dtsi
> +++ b/arch/arm64/boot/dts/apple/t7000-6.dtsi
> @@ -48,3 +48,7 @@ switch-mute {
>                 };
>         };
>  };
> +
> +&framebuffer0 {
> +       power-domains =3D <&ps_disp0 &ps_mipi_dsi>;
> +};
> diff --git a/arch/arm64/boot/dts/apple/t7000-handheld.dtsi b/arch/arm64/b=
oot/dts/apple/t7000-handheld.dtsi
> index 8984c9ec6cc8..566346be5b53 100644
> --- a/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
> +++ b/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
> @@ -10,6 +10,10 @@
>   */
>
>  / {
> +       aliases {
> +               framebuffer0 =3D &framebuffer0;

Looks like an unrelated change. Also, not a standard alias name. So please =
drop.

Rob

