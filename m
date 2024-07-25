Return-Path: <linux-kernel+bounces-262049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A1C93BFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68B528389F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45025198E80;
	Thu, 25 Jul 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mk5Em2UD"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD17197A7E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903703; cv=none; b=ZdF7HYt/jxozhzqZhmELWZQeFLoz9FquK/dWkVhGe/f5OuE/qPfuBrY0zkfedPaGOUuKTdhkoKntO+wf2hpWxXqizuhBvaA4Bju3mMoM27CHUvuEC0vNd5oKay+ZzqsiFK9ItDScOCq2gx4f0kIiFzNagVGBGH0TsEKqsczTikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903703; c=relaxed/simple;
	bh=W/Lg3Vl1pypqyGMJ/rAGZU1DOjSt7qzAj1AORn7I2y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLGMeJQUkus9RU9WyCvXobDNsK655c2I2Q5PfIjJ5c0PXa+y6saEEZSJsWlUCogSWP0fzn5QNSoVhH5bSCOdbNhr6LXu0yhPWxATfh/6JyQFUog21UT2e6vavBVLPbijrsbCzCvgAzYp3bd3yJw3ohS283UAOya0L3PQb/CBs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mk5Em2UD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so1020092e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721903700; x=1722508500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGl5c3HNmBBbaK/O1r5iTiZ1Nkq9wz0Q4rHARmEMwjs=;
        b=Mk5Em2UD5iWB0AFYlbX55FVgaDlyjiYCQrrxDOKjyYUrQPy/wjqpM2+A2JBDI0bf5f
         k/9vo5FsI7Kh7y5qs9Kxi/vFkiuZTSMcfZb+dUpez9HLlyX1o33lvMvfj37SvpGtd9MQ
         Vzdo5x4uV/aUrvdNbDOV1jcuhWYRYNxK2ECyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903700; x=1722508500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGl5c3HNmBBbaK/O1r5iTiZ1Nkq9wz0Q4rHARmEMwjs=;
        b=XxAFZ9D9c7PvF+iwSoIC9UnwXeCE76FSbgjRiLv9OSRYWYHcHVNZQKQsURIu1HS3k4
         gjWr8f9Tf4IGMtUHvwap23gHB5i8XO9I4/X+nSf1nWqYRoPoQTryttr5znKXM4opYjhf
         azcZFS3qum5aFew0qsX1h4izTHZid6g9MmzaqBknhndzHbdvrjpFa1Dpys422eMFNc9a
         QBCA/NZWw+XVFzck/e1Z8YkKdFqF/RrO9NgDZAIIDh0qJdBtLlAKX2e9SIgFypbl62P8
         cdaG34i6gE8/m7Sl5eBTkpkuljdjpNf/binIfXxGWZDjemGFLV47OC7yB1AXYdD4IsAK
         uQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4+duJL/u0sYIJ3LN7G6/VCWpXqCyJCrlU910W5dQMdg4Y+Mre7qNUkb2+s2ERJnKLlE/uvtYpXHJfYwkxpf8MzGZ+XPvy66IYz7fs
X-Gm-Message-State: AOJu0YwAAw1LPEO5SarJWQqmU8rIsW5AnepAA8oHfOGr8GbAmCtt3IeT
	6ELCZkPi27ewgFShFmQyuI2sro+uD/FHv0gEoYOLrzSZzqPyGxIKXpAkNnKKWC6YiJspNKX6MNG
	R06ROmatBnxCVzzZKfu6256L8A2t0INJTysmu
X-Google-Smtp-Source: AGHT+IHkE66wc/ZgxWkQgDaikOYMpwK+iI3oiC+hn7N1tRYSraZ86sG3P9nD/p1ufKpAexRHxLjoxCDlxy5nnXtmG6M=
X-Received: by 2002:a05:6512:2035:b0:52e:9ab9:da14 with SMTP id
 2adb3069b0e04-52fd60b6b10mr855792e87.31.1721903699732; Thu, 25 Jul 2024
 03:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-usb-1129-probe-pci-clk-fix-v1-1-99ea804228b6@collabora.com>
In-Reply-To: <20240722-usb-1129-probe-pci-clk-fix-v1-1-99ea804228b6@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 25 Jul 2024 18:34:48 +0800
Message-ID: <CAGXv+5H_pxR18sHeqdWPy9_FARrnLwyyOHV4VXCn9p5OExseiQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add missing clock for xhci1 controller
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 22, 2024 at 11:27=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Currently if the xhci1 controller happens to probe before the pcie1
> controller then it fails with the following errors:
>
> xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
> xhci-mtk 11290000.usb: can't setup: -110
> xhci-mtk: probe of 11290000.usb failed with error -110
>
> The issue has been tracked down to the CLK_INFRA_AO_PCIE_P1_TL_96M
> clock, although exactly why this pcie clock is needed for the usb
> controller is still unknown. Add the clock to the xhci1 controller so it
> always probes successfully and use a placeholder clock name for it.
>
> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> #Kerne=
lCI
> Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@=
notapiano/
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

So I asked MediaTek about this, and it seems the correct thing to do is
disable USB 3 on this host controller using the following snippet. The
snippet is copy-pasted from our issue tracker and won't apply directly.

This is also seen in mt8395-kontron-3-5-sbc-i1200.dts, on which xhci1
is used only for USB 2.0 on an M.2 slot.


ChenYu

index 8b7307cdefc6..2dac9f706a58
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1447,6 +1447,7 @@
                                      "xhci_ck";
                        mediatek,syscon-wakeup =3D <&pericfg 0x400 104>;
                        wakeup-source;
+                       mediatek,u3p-dis-msk =3D <0x1>;
                        status =3D "disabled";
                };

> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index 2ee45752583c..cc5169871f1c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1453,9 +1453,15 @@ xhci1: usb@11290000 {
>                                  <&topckgen CLK_TOP_SSUSB_P1_REF>,
>                                  <&apmixedsys CLK_APMIXED_USB1PLL>,
>                                  <&clk26m>,
> -                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>;
> +                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
> +                                /*
> +                                 * This clock is required due to a hardw=
are
> +                                 * bug. The 'frmcnt_ck' clock name is us=
ed as a
> +                                 * placeholder.
> +                                 */
> +                                <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96=
M>;
>                         clock-names =3D "sys_ck", "ref_ck", "mcu_ck", "dm=
a_ck",
> -                                     "xhci_ck";
> +                                     "xhci_ck", "frmcnt_ck";
>                         mediatek,syscon-wakeup =3D <&pericfg 0x400 104>;
>                         wakeup-source;
>                         status =3D "disabled";
>
> ---
> base-commit: dee7f101b64219f512bb2f842227bd04c14efe30
> change-id: 20240722-usb-1129-probe-pci-clk-fix-ef8646f46aac
>
> Best regards,
> --
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
>

