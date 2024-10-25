Return-Path: <linux-kernel+bounces-381801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD13A9B04A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15E21C21FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CAE1F708E;
	Fri, 25 Oct 2024 13:53:18 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00670815;
	Fri, 25 Oct 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864398; cv=none; b=RsWN0W63CBUa/xAElWG/hIOyVdbJ9MKTsHHy9z6pRijlttV4qVZS10e33Iwx/nE9E+K+ZCbGfFCvmobL3UFxxG4t+0vZLKp/NhhPgk9zeYdxMLSHyOY4JSiipFbToYbfsEz1Ddb/eeehPSsr7oaRuw/gh7CtPNXkdJijoUZaVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864398; c=relaxed/simple;
	bh=dLnhZv36ldJad16CK8s2AbD04/f19Oaqvlhu+fewXbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0mTxw0+UxJ3fKUdkV7OjJfjZ2sxAqCPdnrmNyuQu6Eqyf+cOs5+qfEn+jIAYqqiSbpaNChwQQ9M569/rZYE6hvCBcJ4NxKCoXWvyJW/mIabkqYnmZhaR0qcjoNI2Dae3S4G5KDJ1xI9SVAmgkYbTUZC1OZl/A6Qx8Dq5pHxCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso2143925276.1;
        Fri, 25 Oct 2024 06:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729864392; x=1730469192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djva4KOP4v9Rg26S81bBmAQ/5dEE1/x6R+NZGGRbJmc=;
        b=PGzu3cle5ntG7V7wl65VwNGsQ/aUbMAFz8cH4yA87vmwu9aZ2mOSU/rezrLOCZJNph
         9tIHcBDbniNbIAAJ/2/DnICVGTto8n7p9mQl7S/ZEM1AYmpGc3sKbL1/ieBl0U93UqUw
         YByVPqufu8grgkYeqVwkJ9Zlrt/dJgsd814yyLPRisEMbsgvNL4AqEAuv40v5SJOKuW7
         pCwuPlkqfcaEigbG5LPDnecUYhLjg0BjZim5KLaqp36LLaqcdBKnIq/pYUb+Z9AIykDY
         dylIm4n9zkXHZud+99xLaliftVbYAf4YC4SH25qhAwnwIYArIQ9rGrGiOmaKL1tKUFx9
         KT7A==
X-Forwarded-Encrypted: i=1; AJvYcCVUBJxNWWKV0A2QUoVO1k398yo5blOp9DkSgsutRuL16bnwI7VN9gnMDTk+2lBfF48nP61T2YKqpXDrvTQZ@vger.kernel.org, AJvYcCXLcPNidqZlKBDiKIO67kEJa2pPkbf1zDh/sUavL02vpglDQYIKUJBhOpOtWzfiinRBhJw7D7ST+bFh@vger.kernel.org
X-Gm-Message-State: AOJu0Yybj+JXkdb/YHRaZq5DOl8Lttht41qb9rfPdJXHiz1ZlKsO4irj
	1gsMQkDMBe0FTXC35/cCY0ud6zGyaOuXi4E5pCBEjlOeetAn5WqS+XIlkr6S
X-Google-Smtp-Source: AGHT+IFIQyZl+sDK9YNYRLYp5T8sT/b3XEOFcK1WUFIUsGl1AgB06yjV8bGt+0pERZsH7cbkkVhikw==
X-Received: by 2002:a05:6902:2688:b0:e2e:3701:7824 with SMTP id 3f1490d57ef6-e2f22f1c60bmr6192502276.2.1729864392448;
        Fri, 25 Oct 2024 06:53:12 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a01d70esm242380276.41.2024.10.25.06.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 06:53:11 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6db20e22c85so18242687b3.0;
        Fri, 25 Oct 2024 06:53:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPceWkseiQ4uGg/YbmCPW4Erv2HCJ0OyrGj2j9AYaj4EVJfmwPdIOG1c60C9Fz1byPdkQph0xH/SD/@vger.kernel.org, AJvYcCUVUAg2eWV8CMdMiCB5Z4k7oexHVJWRhxCi3S5/i5TWyG/VDJF1EHxaOeMv3zjk3U86QufctbG6cMPcL9zn@vger.kernel.org
X-Received: by 2002:a05:690c:6610:b0:6e2:1527:446b with SMTP id
 00721157ae682-6e85814e730mr59897987b3.3.1729864390657; Fri, 25 Oct 2024
 06:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023210313.1390767-1-Frank.Li@nxp.com>
In-Reply-To: <20241023210313.1390767-1-Frank.Li@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Oct 2024 15:52:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-tXFYSfTerb-eYmmbJHYN9xNyiGMPoeGArmDnAajUmg@mail.gmail.com>
Message-ID: <CAMuHMdW-tXFYSfTerb-eYmmbJHYN9xNyiGMPoeGArmDnAajUmg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mn-tqma8mqnl-mba8mx-usbot: fix
 coexistence of output-low and output-high in GPIO
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	"open list:TQ SYSTEMS BOARD & DRIVER SUPPORT" <linux@ew.tq-group.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

On Wed, Oct 23, 2024 at 11:07=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
> Fix the issue where both 'output-low' and 'output-high' exist under GPIO
> hog nodes  (rst_usb_hub_hog and sel_usb_hub_hog) when applying device
> tree overlays. Since /delete-property/ is not supported in the overlays,
> setting 'output-low' results in both properties being present. The
> workaround is to disable these hogs and create new ones with 'output-low'
> as needed.
>
> Fix below CHECK_DTBS warning:
> arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtb: sel-usb=
-hub-hog:
>    {'output-low': True, 'gpio-hog': True, 'gpios': [[1, 0]], 'output-high=
': True, 'phandle': 108, '$nodename': ['sel-usb-hub-hog']}
>        is valid under each of {'required': ['output-low']}, {'required': =
['output-high']
>
> Fixes: 3f6fc30abebc ("arm64: dts: imx8mn: tqma8mqnl-mba8mx: Add USB DR ov=
erlay")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Alex:
>         I have not hardware to run it. I check dtb output is correct.
> ---
>  .../imx8mn-tqma8mqnl-mba8mx-usbotg.dtso       | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg=
.dtso b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
> index 96db07fc9bece..1f2a0fe70a0a2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
> @@ -29,12 +29,37 @@ usb_dr_connector: endpoint {
>         };
>  };
>
> +/*
> + * rst_usb_hub_hog and sel_usb_hub_hog have property 'output-high',
> + * dt overlay don't support /delete-property/. Both 'output-low' and
> + * 'output-high' will be exist under hog nodes if overlay file set
> + * 'output-low'. Workaround is disable these hog and create new hog with
> + * 'output-low'.
> + */
> +
>  &rst_usb_hub_hog {
> -       output-low;
> +       status =3D "disabled";
> +};
> +
> +&expander0 {
> +       rst-usb-low-hub-hog {
> +               gpio-hog;
> +               gpios =3D <13 0>;
> +               output-low;
> +               line-name =3D "RST_USB_HUB#";
> +       };
>  };
>
>  &sel_usb_hub_hog {
> -       output-low;
> +       status =3D "disabled";
> +};
> +
> +&gpio2 {
> +       sel-usb-low-hub-hog {
> +               gpio-hog;
> +               gpios =3D <1 GPIO_ACTIVE_HIGH>;
> +               output-low;
> +       };
>  };
>
>  &usbotg1 {

Note that after this, there is still

    /delete-property/ disable-over-current;

left, which does not actually remove the property.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

