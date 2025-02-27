Return-Path: <linux-kernel+bounces-536955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0850EA4863A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7873AFE81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA61DE3A4;
	Thu, 27 Feb 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3O0spDc"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACFA1BD000;
	Thu, 27 Feb 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676071; cv=none; b=BhnZ+H8cmGgXPo8X3WOVwtLEB1tCiPStFs1CR8lK9WY6q33vypY93lpCclDJDwuUkYrNAdpzR9JGsNk01lW7kdXCg0ORPeGraoGrXRIECAYpvjIrEqH66SpYICm5/3wJHN+bV8DMfUBP47/rINCDr3hzsu+3pYF4LcSFb+fYCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676071; c=relaxed/simple;
	bh=7R74lr5594kAGxToaxvz8tq6hjGiWqrgb978VHTWwxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmakwwgqzyKaFBySloAK1nfm7bLENN9YuBzoTbAXC/LLVFAWo6EDxmaczMxjOVfvLY4GG/YT+tVy6byrvnam/0uIKQ2Ds2UphUf/UoMSxPVki0iOpeEIVRq7f7oJcqEYLnYWfe0k7ONijIRUGKNrBLod//Xp89vqzIZlg8TQRik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3O0spDc; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30a69c1a8d3so13594511fa.3;
        Thu, 27 Feb 2025 09:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740676067; x=1741280867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oxit/fbFATP5S0oI9jk02pT67RxLAecxX72TBSPrJ4=;
        b=I3O0spDcuG5jYOEDLH+hgxhYYjVot0ZYNtyeNpFXH0AfOZvtOFxecwdCThLChyPKN9
         Vl/yzEw7YqEdYVt9wEyjS6K40YppBS2yu0j7Ri6Mf0qK/INtj7dp9GedtXNfR7kmn04T
         rrU/f3uyAxVPEMivtipT9zSdv0S8NFvzaIojFgp3EhEBUFbnF8ZJCSWvUOM6JlO3ddx3
         tomPyO9Awhvq2XHYFkTqcpanpSXvzngLy1krtDp8bJalrzWl5jGMI3aGuOI+bPhqRxLu
         6CN1AYRfb2aZxdixhSWnkS62NLtQwHjTnaxO+G5hV3qie4/9xPMeLsCKKCAMqN+hjgJT
         8OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740676067; x=1741280867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oxit/fbFATP5S0oI9jk02pT67RxLAecxX72TBSPrJ4=;
        b=AcFY3xMK1SRBlaszJ0ZJDE/r3nPQM7ca4uaMcW9XjZjHQgdomDd/ZbxK4NQqcDVhA9
         gWm5AM6X0jca4TJB0m5XGPJl361jdRWc1Q1ttmkRzbzTqCNL09LYtT+d2Ksbw+TXP7do
         qiSBHFSp5IXJd6S+WqlYws1wOLImIgvzjrl+vC1YVNw2GHC45FdVB97ieYK8zXuM6QGg
         qaIHiVfgBT5UdGef+xGdsc4e/aFntrW5oVTRiygfP0gfb4rDtBSIEHQq9mKZbe2WwmDh
         zgtReWHLqAXQsCQaca5LhzFVKdc8yZCd5HTPzL4oJRS0VFwh2IVNBp1Gm5MPjau2twQP
         RzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Hw20j1HXYRM9pnGe5fuRMtXLV8jfmtAh5UNeNWxPDYI47rN/etmPRefv2LTyUNtqfxyCFHVgbTqH@vger.kernel.org, AJvYcCWUJSWceahPpuZL4KoU6XcbjSswk+COUha2CVTtmKxJ51wo1tavYZWNP2mIDe1OxX2X8JKpv7u32Xnz8wkb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx24nIrk8RZfD+veT236dEgPsY2lhSiXOYvqkIxBYkpChE9qBy
	ufwzmxrpvxiCrH7j1HD+FrcMplNxm0S/e3iWWIKjfaA+eLhkJ2kI1XV4f/iUzul49+E2LlnelzL
	TT+o53+PRgpYb7JpFVZ3burdx35g=
X-Gm-Gg: ASbGncuRGBzjpq4r/qlKdIVKvWz2CLyDaddguqo2lQeanAmWIUCNaBM5tMlR4UZiTki
	n4nOwMPQFXecWAKZ+xga/q75RFQ8g0PDEGpswurtcq+GskmSOiyFYdNufCE0qjLsJBK9N8UInvP
	IeP2J8KD+2Ds/+lZTnaTuFIAFxfuOskwd9ft+Dxxw=
X-Google-Smtp-Source: AGHT+IGbHwFw3Ei173z0Un2b6hE6mBlb5qScKRe0aoWLTdNiy0wIyLsDV/TjbMoZKWKVOebKb7C9sd0SzZzc+u29lkw=
X-Received: by 2002:a05:6512:3b11:b0:549:490e:240d with SMTP id
 2adb3069b0e04-5494c320d47mr80269e87.28.1740676066843; Thu, 27 Feb 2025
 09:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227170556.589668-1-ernest.vanhoecke@toradex.com>
In-Reply-To: <20250227170556.589668-1-ernest.vanhoecke@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 14:07:35 -0300
X-Gm-Features: AQ5f1JoOSEVimzZP3To5R1UEdgKOEY0K6S3WLSXvUvHm17C771vmwEyHDgADBUM
Message-ID: <CAOMZO5C0uS3jes=tbnM1D75n-OoAVDXQrfyn0cPZKwdNPViFxA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ARM: dts: apalis/colibri-imx6: Add support for v1.2
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Francesco to help review.

On Thu, Feb 27, 2025 at 2:06=E2=80=AFPM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> Apalis/Colibri iMX6 V1.2 replaced the STMPE811 ADC/touch controller,
> which is EOL, with the TLA2024 ADC and AD7879 touch controller.
>
> Accurately describe the new hardware.
>
> v1.1 of these SoMs is still described by the following DTSI files:
> imx6qdl-apalis.dtsi
> imx6qdl-colibri.dtsi
>
> The STMPE811 touchscreen controller is no longer disabled by default.
> The STMPE811 is self contained within the SoM, therefore, disabling it
> is not the correct default behavior.
>
> v1.2 is now supported by a DTSI that modifies v1.1:
> imx6qdl-apalis-v1.2.dtsi
> imx6qdl-colibri-v1.2.dtsi
>
> For each carrier board using these modules, a new DTS file was added
> that includes the v1.1 DTS and modifies it with this v1.2 DTSI.
>
> The original DTS can be used for modules up to and including v1.1.
>
> Ernest Van Hoecke (2):
>   ARM: dts: apalis/colibri-imx6: Enable STMPE811 TS
>   ARM: dts: apalis/colibri-imx6: Add support for v1.2
>
>  arch/arm/boot/dts/nxp/imx/Makefile            |  9 +++
>  .../dts/nxp/imx/imx6dl-colibri-v1.2-aster.dts | 11 ++++
>  .../nxp/imx/imx6dl-colibri-v1.2-eval-v3.dts   | 11 ++++
>  .../nxp/imx/imx6dl-colibri-v1.2-iris-v2.dts   | 11 ++++
>  .../dts/nxp/imx/imx6dl-colibri-v1.2-iris.dts  | 11 ++++
>  .../nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dts   | 11 ++++
>  .../dts/nxp/imx/imx6q-apalis-v1.2-eval.dts    | 11 ++++
>  .../nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dts  | 11 ++++
>  .../nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dts  | 11 ++++
>  .../dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts   | 11 ++++
>  .../boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi | 57 +++++++++++++++++++
>  arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi |  1 -
>  .../dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi     | 57 +++++++++++++++++++
>  .../arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi |  1 -
>  14 files changed, 222 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.d=
ts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3=
.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2=
.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dt=
s
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2=
.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.=
1.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.=
2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi
>
> --
> 2.43.0
>

