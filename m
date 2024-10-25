Return-Path: <linux-kernel+bounces-381816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F395D9B04D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CF61C2229B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DB1FB89D;
	Fri, 25 Oct 2024 13:57:55 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02370817;
	Fri, 25 Oct 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864675; cv=none; b=L2FwWmpfwvQeqDV83LNKILZG3jmR74mVzvLMZNot1dPnFoEBmT3t6IwZ1xWrRUug70aY4j1Hl5JqozOXWN4DJd6vN4r2RaBSwL2aJOZfhPu3hCl6NbeGI/NZRLIY2KX1IETHs2J8ucDLnHu8pK0pX8iludtTVxZMyyqfyQ9Vcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864675; c=relaxed/simple;
	bh=4bj2osbLKKawTTfWoZ1EPTAYQ0XvOXYe3se963/1blM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q12+wDK2Jspuz/JYvEnvIVIxt0MwwrSKYcgf3pZDwZsrPwYzTEK1KPBRaIjwr0V0ktMaPj8yjaJwIHbgN8D5sQEKDyoN6dvRCOVOIdqMkNSZGKfTrajPwc9CnF6J2qgJZ9nTss1DHS5yitUQ+0dHx1VXTJ1zS4FLwpwZRNFlvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e59a9496f9so24983257b3.0;
        Fri, 25 Oct 2024 06:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729864671; x=1730469471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUx9mkzB7z8iaJH1DYALuYKXnCWuAd2L3YOKskqAexM=;
        b=VCZNh25ZwFf+IjgphuV0oJWqKq85dsRkrZlfAj7qlZt0PwpAfeJuZ6oVrs8y9Q65ge
         +4Q8o9COwipQAtuU9IgLh3DJavMJaKAlOBZLYntgKxlr575nDElYYMabesg2CldauEbF
         8IA3+Zkwo+6LXSCpUgzLGIV06jwAroz7AnoHQ15pQvc3UTzVaPXsW7TeChdUvbJBbz1A
         F3K3ivdH/YUZWptWQTFQbn+hNPcJagVyvrINrBJI7SUPefvvAY4c7KrnERPMAH9tYw8x
         wpeNDicvN5bkvhFqxDV/TaMxMv38kka+zF7+CMyXzCp9RmG6Ikbyv7H+LPCdTuGWj4Pg
         hnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6eUWUKD9JcLUwlrhVlSCJDxmwAL1fQfiiJCxOqS1F40UnwSm/MakvjYi+amqGsBk0f1eFnqGh0YXLKVfV@vger.kernel.org, AJvYcCX4SM9UMCYQAr9Xv6jCOitd6xq54mK+AF4QhrdpQkZli7qc2FfzIq1yhr7x1CWjRfbED2v/lXY1ncQ0@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDAcJ14nvaB5NBtEF5FQkVuuVnE4DQe7+/d233wN65OUnPYhZ
	xIrLRu5DwUeNxLiv4X5xyhdYOAm3SKnzOaOFsemSaJdE61QZ+6jLSWj/pPY4
X-Google-Smtp-Source: AGHT+IG/U4NbN+xhKjoFzmrBI5MaI5/TttQLZAhRQ8kU/GEv9CTwSfSlztjevPP+NFT+Frzfis4MhQ==
X-Received: by 2002:a05:690c:4d46:b0:6dd:bcce:7cd7 with SMTP id 00721157ae682-6e7f0fd20e7mr119707597b3.42.1729864671405;
        Fri, 25 Oct 2024 06:57:51 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c19d42sm2864007b3.71.2024.10.25.06.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 06:57:51 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e390d9ad1dso18265397b3.3;
        Fri, 25 Oct 2024 06:57:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzWYmpfH2Zk4ClJCiHI32+lfhMmhWDt7/zAS41pOFgnj90SHnZSypcWmBAtinVx+2f3IEo4INRTTLFG+6O@vger.kernel.org, AJvYcCXCrBWb8nZdzI5WkFT6BNFH6NNY9HaH3aToH6fi7DrqpXVId7gNO4y59r6noHHyQINa1U1HDi91VpOO@vger.kernel.org
X-Received: by 2002:a05:690c:4249:b0:6e3:2be1:a2dc with SMTP id
 00721157ae682-6e7f0dee4fcmr84030847b3.11.1729864671059; Fri, 25 Oct 2024
 06:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com> <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com>
In-Reply-To: <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Oct 2024 15:57:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
Message-ID: <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
To: Josua Mayer <josua@solid-run.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Mon, Feb 19, 2024 at 4:05=E2=80=AFPM Josua Mayer <josua@solid-run.com> w=
rote:
> HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
> The single SerDes lane of the SoC can be routed to either M1 pci-e
> signals, or M2 usb-3 signals by a gpio-controlled mux.
>
> Add overlays for each configuration.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch, which is now commit bbef42084cc170cb ("arm64:
dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3") in v6.9.

> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
> + *
> + * Overlay for SolidRun AM642 HummingBoard-T to enable USB-3.1.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +#include "k3-serdes.h"
> +
> +&serdes0 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +
> +       serdes0_link: phy@0 {
> +               reg =3D <0>;
> +               cdns,num-lanes =3D <1>;
> +               cdns,phy-type =3D <PHY_TYPE_USB3>;
> +               #phy-cells =3D <0>;
> +               resets =3D <&serdes_wiz0 1>;
> +       };
> +};
> +
> +&serdes_ln_ctrl {
> +       idle-states =3D <AM64_SERDES0_LANE0_USB>;
> +};
> +
> +&serdes_mux {
> +       idle-state =3D <0>;
> +};
> +
> +&usbss0 {
> +       /delete-property/ ti,usb2-only;

/delete-property/ (and /delete-node/) to delete something in the base DTS
does not work.

> +};
> +
> +&usb0 {
> +       maximum-speed =3D "super-speed";
> +       phys =3D <&serdes0_link>;
> +       phy-names =3D "cdns3,usb3-phy";
> +};

You can run

    dtx_diff --color arch/arm64/boot/dts/ti/k3-am642-hummingboard-t{,-usb3}=
.dtb

to verify.

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

