Return-Path: <linux-kernel+bounces-232735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB991ADC7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5871C25E67
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408BD1C6A1;
	Thu, 27 Jun 2024 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jprvKUkw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D113AA4C;
	Thu, 27 Jun 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508611; cv=none; b=drjV6m136fzRW+M7llUm6s25GEdJY4uYHGLoKfs4vxOnUd7aovcUhi8vjibaZWcnibOepssXksm7lpVLNCGmvT+hu8AVXe8K172ck/7Q3w5l2xY+mMJV3RL4RdRPs7c/GxqCguYXpdihDzpOO2uc7KMn0kgFBqUrwNI4xyQE5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508611; c=relaxed/simple;
	bh=HJiKA9T0vKSkwoZpE9NHOFCtPUaoW2KbvCxQ/GHdnUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyjNno6I68MNHdcBpQ3bD2gKuSgZaqkYkt0V4s9ZHWXvSLrLpHpZ23kLy6FJoUjswTTL/YMIZ0ThAdj+hr2jhwzDQrlCO18GL9GQ4MKtGL+YqkSE+8cu7hbUROYDfSUm+rBKLJqHfVSIJpFojKyeWdQ3IcNQHe2R8Y3hVu/rpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jprvKUkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EF3C2BBFC;
	Thu, 27 Jun 2024 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508611;
	bh=HJiKA9T0vKSkwoZpE9NHOFCtPUaoW2KbvCxQ/GHdnUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jprvKUkw2xeUQL1mvat8Ygnv5RL7oatwc3ND0BBD/KgI4JAncT8lkYZUWH1OFuEUA
	 9Ia7N8x0ys15cqQpEiwD3qAzGdX9WvmxyXc/Tg3fLWopfSoA/2/KIRO4d6NjnimvC5
	 SGK5OOdb0tp9MIV15cLIXPZfDtZezM5Qx0BiGkJenkuYfEpnxS3wyubgqn7iZ7RrBg
	 Sljp+pG+bG9WJXnNu6ypJwHhqgGQdZ7QPTYJ3KqCcB4VSyBARefEdFXvkWHjhga9qO
	 YqwoqdbMq1uIkMS+dJjx3KMlrNme+TmN3QPztIlVWp3bfIzCn38Ya0YsTeulfZR46l
	 q3XcOdpYCcTkw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e764bb3fbso728012e87.3;
        Thu, 27 Jun 2024 10:16:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOZq4UC1gn2LWrXhhW/J7SJ5k3aVgGx1LiZega/EgXuxzFuo5be5BjzIGHNSo1tf1DK3/M8DwYO9A4oJFuRGb7pK+AFGl3g++XWpJmc9ueaQirpgrF/Dv7OzR0CuE/iL3r3lLoRfx/AA==
X-Gm-Message-State: AOJu0YxZEqycqe4Wwno6oLA2iT0HbJZa8DGTb4ioTIMozBrCnHOCWbuZ
	N3AMo54Tggu0x8QOYYv+fhK1eT/7Y8OomMg4W6WY2L6mcGCi5FMBu1MH0dLxNd55ltpnD1vVMdY
	n2O0w3hGJCxzKGVlXZQjqDFCp2w==
X-Google-Smtp-Source: AGHT+IEdXnJ7gLySP871VYYqE62ieoINTcLj0Oixg2Gc/eyvRuSgaiilGKeFzNdeiLnrQ9jY+eYUasTRpkFYB1Nk73U=
X-Received: by 2002:ac2:46ee:0:b0:52c:d834:a804 with SMTP id
 2adb3069b0e04-52ce1834254mr8028053e87.16.1719508609532; Thu, 27 Jun 2024
 10:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621165149.2275794-1-Frank.Li@nxp.com> <20240621165149.2275794-3-Frank.Li@nxp.com>
In-Reply-To: <20240621165149.2275794-3-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 27 Jun 2024 11:16:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKo4XwcVKKLYvRNsfmk_BF67nFqwjXs6J-x70jE7LPTYA@mail.gmail.com>
Message-ID: <CAL_JsqKo4XwcVKKLYvRNsfmk_BF67nFqwjXs6J-x70jE7LPTYA@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: layerscape: add '#power-control-cells'
 for rcpm
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:52=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add '#power-control-cells' for rcpm: power-control node to fix below

You mean #power-domain-cells?

> warning.
>
> power-controller@1ee2140: '#power-domain-cells' is a required property
>         from schema $id: http://devicetree.org/schemas/power/power-domain=
.yaml#
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 1 +
>  6 files changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/=
boot/dts/freescale/fsl-ls1012a.dtsi
> index 1331858add942..1b6ab9550cce9 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -560,6 +560,7 @@ pcie1: pcie@3400000 {
>                 rcpm: power-controller@1ee2140 {
>                         compatible =3D "fsl,ls1012a-rcpm", "fsl,qoriq-rcp=
m-2.1+";
>                         reg =3D <0x0 0x1ee2140 0x0 0x4>;
> +                       #power-domain-cells =3D <0>;

The thing is this h/w is not controlling power domains nor using the bindin=
g.

So I think the fix here is either rename the node name or drop this
schema check ($nodename). We really only do the latter if we want to
only reference the power-domain.yaml schema from all specific power
domain controller schemas. That's really only done if there's more
than just #foo-cells defined by the schema which is not the case here.
So we should probably rename the node to 'rcpm' or something. Seems
like a step back, but there's really nothing generic to use here.

Rob

