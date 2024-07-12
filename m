Return-Path: <linux-kernel+bounces-250377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D803792F720
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC9D282718
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D551422D2;
	Fri, 12 Jul 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2hPc1UN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FAA27702
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773695; cv=none; b=XZt+hasGWUNE7Kq0mDpBmuLK2RwEzAHHqqIkCVAnsB/3PSotoHydnsW1W3LLpL/ojhAA7MXSd99ggfPjb944NIvCbUGQhjhqT4ZgjHIGHELV76bpzr3EHog1U2T54a+KBSE9vNq2LawoFfSLHXeFzrdAoJl4yJyyhiMSGz3fLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773695; c=relaxed/simple;
	bh=tZo066m0FJy5SUDIiOa0RWh9vniTTzGSzxhPvoOWvuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=LHbvJILwRaT2OvTAP8Guf0R5AbZy2waMDSpIM5k12pUC0b5IfFwcGWqXqI7p7UvSWM9eFJ4oo5B0AwZPRpL5i3jTvlJZUkonJE7H2z5SEUnjB4YpzTz49p2QLEQAFcWSsXsSxAEbIzehaNCfDXRZGlEDQF6IMxIf/JHn3jtH0NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2hPc1UN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so2409080a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720773692; x=1721378492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlAJm+hon9MJjqPdpWZb17dSrrSb4gCZfoNF5yzi3oQ=;
        b=j2hPc1UNsddETWuhUlMvn7agodsmxVSZKKvGOxM2P/+TXbkbW+abC3+oI9Y1BnOzF4
         qccEPiqImqSHvq8dzegRuLrLscc2EChwB6RNJTkHbOlIFhefPIM7nbU2NI8iuhA7jLya
         YGJYg5SvFgN/lhu6eI9jt2EahOxJgTw/G120kjxtmZYAN8Ifme5joz7HfKcRQYgkdJYi
         4Vhmt6a07REU9DmlFBNUkBZbfnfpH0ISL1Y+Wsxm22BDnHHMImIezNMuart63IqnSA8r
         6KKySWaFozkiyKKDq7zZWm4GDgwmagxByBLMX/5u11B01PTklExESMdZuPk9Ml50a7QY
         oc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720773692; x=1721378492;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlAJm+hon9MJjqPdpWZb17dSrrSb4gCZfoNF5yzi3oQ=;
        b=ToiOdZy7F5mUF6KSkoti20jG7INyalaCFMLWBsSHFtePlwQyYXmRNHlZC1ymNVrkMn
         FgY7gmeEo9FccmgeUTFitterNTaylA6BeWw9HjafCaeb4zsnuzmSsAy+AxD915OvgwSG
         BNQbU5juHZ4eKTJK7vXva4fcKEgz19D7TbsLUv8hMioOA6NUdG003acyEx15Uc1jpvJD
         x3RHwu9WFrLdYcu/AvT31iD2ydxi6tV/z8XPlnKhapLQ/q/P0LqP2ZsqqOp6P00aQ1Yc
         zBSet78BYCoUY08Se5Z4eaTd95H2i9MKpCG1IxP6a4jv3o5E0C9Xc8/HyNVr3m04qUqD
         HJkw==
X-Forwarded-Encrypted: i=1; AJvYcCUU29uimuJ4ln8VDN9AJzFIqYfsu80cRnHenRf/SwZyMoun/phaAFxqBXz7cYPs8RGqZNuhD+MIWvl2TO0es9VmtmRdeJpnUr2+lJld
X-Gm-Message-State: AOJu0Yzj49TXK29utgZBA/p9Tc03ZZ3A4XY167PmYdnS5yC8p0KDr3NL
	Hw87bMizQ5OVlh1vtBrutiT7bLZt+Mnp9VTJpuqYdspJLEKKfAYVGYknv8R7EVCtZn1jeesdxvF
	iuAIcfoQOGQNaPNoTdJ/+nCr0iMw=
X-Received: by 2002:a05:6402:308e:b0:58e:3501:5c0a with SMTP id
 4fb4d7f45d1cf-594baf8d6cfmt5938344a12.11.1720773691396; Fri, 12 Jul 2024
 01:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705093503.215787-1-kanakshilledar@gmail.com> <20240705093503.215787-2-kanakshilledar@gmail.com>
In-Reply-To: <20240705093503.215787-2-kanakshilledar@gmail.com>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Fri, 12 Jul 2024 14:11:18 +0530
Message-ID: <CAGLn_=tT08KUX0J+WURq=EXKDPj=--Wg3qmCjnzGxNeMcz3NOg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] riscv: dts: thead: add basic spi node
Cc: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Drew Fustini <drew@pdp7.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Any updates on this patch?

Thanks and Regards,
Kanak Shilledar

On Fri, Jul 5, 2024 at 3:05=E2=80=AFPM Kanak Shilledar <kanakshilledar@gmai=
l.com> wrote:
>
> created spi0 node with fixed clock. the spi0 node
> uses synopsis designware driver and has the following
> compatible "snps,dw-apb-ssi". the spi0 node is connected
> to a SPI NOR flash pad which is left unpopulated on the back
> side of the board.
>
> Acked-by: Drew Fustini <drew@pdp7.com>
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
> Changes in v3:
> - Changed the position of "spi" to come after "serial" in
> aliases for both the boards.
> - Added Acked-by tag.
> Changes in v2:
> - Separated from a single patch file.
> ---
>  .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
>  .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
>  .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts |  5 +++++
>  arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
>  4 files changed, 34 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/ri=
scv/boot/dts/thead/th1520-beaglev-ahead.dts
> index d9b4de9e4757..b4d2e1d69bdb 100644
> --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -23,6 +23,7 @@ aliases {
>                 serial3 =3D &uart3;
>                 serial4 =3D &uart4;
>                 serial5 =3D &uart5;
> +               spi0 =3D &spi0;
>         };
>
>         chosen {
> @@ -52,6 +53,10 @@ &sdhci_clk {
>         clock-frequency =3D <198000000>;
>  };
>
> +&spi_clk {
> +       clock-frequency =3D <396000000>;
> +};
> +
>  &uart_sclk {
>         clock-frequency =3D <100000000>;
>  };
> @@ -79,3 +84,7 @@ &sdio0 {
>  &uart0 {
>         status =3D "okay";
>  };
> +
> +&spi0 {
> +       status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arc=
h/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> index 1365d3a512a3..6939bd36560c 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -33,6 +33,10 @@ &sdhci_clk {
>         clock-frequency =3D <198000000>;
>  };
>
> +&spi_clk {
> +       clock-frequency =3D <396000000>;
> +};
> +
>  &uart_sclk {
>         clock-frequency =3D <100000000>;
>  };
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/ris=
cv/boot/dts/thead/th1520-lichee-pi-4a.dts
> index 9a3884a73e13..7738d2895c5a 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> @@ -20,6 +20,7 @@ aliases {
>                 serial3 =3D &uart3;
>                 serial4 =3D &uart4;
>                 serial5 =3D &uart5;
> +               spi0 =3D &spi0;
>         };
>
>         chosen {
> @@ -30,3 +31,7 @@ chosen {
>  &uart0 {
>         status =3D "okay";
>  };
> +
> +&spi0 {
> +       status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index d2fa25839012..f962de663e7e 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -140,6 +140,12 @@ apb_clk: apb-clk-clock {
>                 #clock-cells =3D <0>;
>         };
>
> +       spi_clk: spi-clock {
> +               compatible =3D "fixed-clock";
> +               clock-output-names =3D "spi_clk";
> +               #clock-cells =3D <0>;
> +       };
> +
>         uart_sclk: uart-sclk-clock {
>                 compatible =3D "fixed-clock";
>                 clock-output-names =3D "uart_sclk";
> @@ -183,6 +189,16 @@ clint: timer@ffdc000000 {
>                                               <&cpu3_intc 3>, <&cpu3_intc=
 7>;
>                 };
>
> +               spi0: spi@ffe700c000 {
> +                       compatible =3D "thead,th1520-spi", "snps,dw-apb-s=
si";
> +                       reg =3D <0xff 0xe700c000 0x0 0x1000>;
> +                       interrupts =3D <54 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&spi_clk>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       status =3D "disabled";
> +               };
> +
>                 uart0: serial@ffe7014000 {
>                         compatible =3D "snps,dw-apb-uart";
>                         reg =3D <0xff 0xe7014000 0x0 0x100>;
> --
> 2.45.2
>

