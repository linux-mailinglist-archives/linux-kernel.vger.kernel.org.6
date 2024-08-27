Return-Path: <linux-kernel+bounces-303644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C08939612E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F33B2BE30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3CA1C5792;
	Tue, 27 Aug 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXF9iqYM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6A1C68A6;
	Tue, 27 Aug 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772829; cv=none; b=WfenvT4Wb2YW2ZfWtUN00C6alhz3VfCDgNx+mZVdaMpeUAXd2nTL/1XCzXkU9ZPLaIRGoRz8CewttdW4uFsLBbvZsLoOYN+t2nCc164/7kVqhsltYUdj0Xr7hC1e1Ib/ufawvdvzm74SAUFoVpqs8cprqIaoh3XFHih6aEJYvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772829; c=relaxed/simple;
	bh=tqwwuQLxLu65R7hMO4ggXIpGa/v/feGOdzPghQiP2ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTJshQJfr6TwmULAYkcUV2JLS/wtLhn5R4Ixk9ebiTVVYQpXA/GE+Q/g4XcJy25zuNrnHtzKmdzgP1RilEgwvUMwA4/vp/Cko2bx58SQvhcTvRFptYJKU2yqg4s0QNcLG4OTU0jWYrRv+UO5rKCS2b3gaQosRAbF0idoZc1MjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXF9iqYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DA8C6105C;
	Tue, 27 Aug 2024 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724772829;
	bh=tqwwuQLxLu65R7hMO4ggXIpGa/v/feGOdzPghQiP2ss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qXF9iqYM0IZF+fj2TGYsGIcZ0mzS/oprfqLCd5oBvjv42CtYJIwrpbOJhILjZidOn
	 pwUIvIsnwO5A8wv930hPLC2SzDGWWRvcZS6OAfCx51O0y88u2oDs1HHr8/OTURBOUE
	 7IbethpI2xSq5nmgDEQ+5zEA3yg26J/boR0Y/C/fxIb14BQI7/ByuJ89W3s6e7I5Ka
	 HpWZH8PnF180qD5lZcFyvhaYMP8XnoZcV84wpB2fLd+IgykGCMagRzMMp7gdAEIGeZ
	 e0xQ6IjUFu9pFcdzRN2VX0928IYb949BymdqCnxnoaqbPzp7bcV2lgKkW0MMM+jlw3
	 LX3sfYm/VpKgA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53438aa64a4so5596785e87.3;
        Tue, 27 Aug 2024 08:33:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUqH9b6ZmIZTM34WmhyZh/NAtpPQNnnma7MCYUdP/6dzKzgHwWOKJOBeoqyIghacvIyQyFMO2Ag41h@vger.kernel.org, AJvYcCVcYcOnjfnQGM2tgiXfpDnrfBt7ymUzbGOVKaWQ/nG2WIOwwDaMlq5TK53LW3BDSXcbsh7OWXkU85M78YIU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdz3nekY/yOnBabZxaE8kTdnND8EZ3OxYY5qxr6NjLRe14cEBv
	YtQeSKJgK/GJotkHeml6Y4JCVPgylgeW9TMXO+tbRsiyabxAODSOmc1f7EDeu25drZF/UX66t3W
	b/umzhyDl2FQMQIc7rQEPCQY5kA==
X-Google-Smtp-Source: AGHT+IGPSqybKNiMvVQKgXZTAevFJTqkzUUFlz68S4B5I+liROoTC4SfTPGnNIlnHt/Jxu/nnJUoQ4TDwc/tyfOPKJc=
X-Received: by 2002:a05:6512:1393:b0:52c:caa6:13b4 with SMTP id
 2adb3069b0e04-5343882d1c1mr8829662e87.3.1724772827623; Tue, 27 Aug 2024
 08:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724682539.git.jan.kiszka@siemens.com> <7062ec915ecd161f6c62952eb7c1cd5036785dba.1724682539.git.jan.kiszka@siemens.com>
In-Reply-To: <7062ec915ecd161f6c62952eb7c1cd5036785dba.1724682539.git.jan.kiszka@siemens.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 27 Aug 2024 10:33:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+czuiiBUEaPBn0E+=5intMsxr6D8c33BapAD2=n7jOg@mail.gmail.com>
Message-ID: <CAL_JsqJ+czuiiBUEaPBn0E+=5intMsxr6D8c33BapAD2=n7jOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: iot2050: Add overlays for M.2 used by firmware
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>, 
	Hua Qian Li <huaqian.li@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 9:29=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> To allow firmware to pick up all DTs from here, move the overlays that
> are normally applied during DT fixup to the kernel source as well. Hook
> then into the build nevertheless to ensure that regular checks are
> performed.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>  ...48-iot2050-advanced-m2-bkey-ekey-pcie.dtso | 27 +++++++++++
>  ...-am6548-iot2050-advanced-m2-bkey-usb3.dtso | 47 +++++++++++++++++++
>  3 files changed, 76 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-=
bkey-ekey-pcie.dtso
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-=
bkey-usb3.dtso
>
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Mak=
efile
> index e20b27ddf901..f459af7fac0d 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -77,6 +77,8 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-am6528-iot2050-basic.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am6528-iot2050-basic-pg2.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am6548-iot2050-advanced.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am6548-iot2050-advanced-m2.dtb
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.=
dtbo
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am6548-iot2050-advanced-m2-bkey-usb3.dtbo

You are missing applying these overlays to anything. That is a
requirement for any overlay in the tree.

Rob

