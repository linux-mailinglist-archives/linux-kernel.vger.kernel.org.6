Return-Path: <linux-kernel+bounces-362455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE199B52A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4269D1C21B25
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1635A186E46;
	Sat, 12 Oct 2024 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wN2cn9eI"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD712CDB6
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740770; cv=none; b=TYWYfHAx0DCPmJv8k3NvkWOqqzC9qzok0Rd+NnfSzlUf9ZvBuunKC9phuxUSIQO++vZGjxPO3xalwjWMQ6mtNpW6bd+BDk54sxTchjYv4SM16+peEv/VyRL5JaMZAKSENLq4NUu08HV4ewZyTxlSzjrb7UIYtgUR5f0VL1QJHiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740770; c=relaxed/simple;
	bh=ebBei98yWqwECubA0Qj+BklY8AWX98r6XzcnfOG8vKA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWC/YdvXjZJN+ec/G4EfrgjCKoIGl5UOyvYEVT+A+XLEnJKFklzKJnOa1TCrR/eVPQ8KrzMvNiPlKLGsJRFk0WJBBE/07hdDpbg3o2BXXAZXOykEZ5ZmrziErNJh0m4e48Wr4G9gFX9iYVT4qWvgVk5ZkvNcAhpGelC0tBSPo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wN2cn9eI; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E9683F20D
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728740765;
	bh=wX2+LM1EIphUiY8L+Ud8kXahS9GWghUjKo8VomtJpRE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=wN2cn9eIBlvXSCQ3CM2o1b5U5VmvORm16SzpiYdlKKYA5dmZh/r20wNleQKCqG66Q
	 0drzcyEsEI97Z+GyQrX1i4lJs5k/zR1D4z0CH8FmHMMPxHYXdxFZ7f20uzpNKjJ994
	 p0gCZQJHbICf3XLs3Q+rL2/9BZXxctZD1XXLXj9mE2wuigJyxsH4B67X8y+XQeXsSd
	 6CNYWKNyiA7KofEYH2RvCwsw4hSy5T2MCeqiSm0w3+7tNLE71LdkHGOGhKJpe2kzIa
	 hgq7gCXWTIEIRPNvvfwu5o2wpjhLM+TjJeJ/qtl9PZ5+z13cb1WmjSoYUqY1pWg0Am
	 L1sR/zfxYWOlg==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5e830b71879so2325869eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 06:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728740764; x=1729345564;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wX2+LM1EIphUiY8L+Ud8kXahS9GWghUjKo8VomtJpRE=;
        b=k6iNnpapdyjbNROXXB5stEafQyxzvJnc67riHO0rro5QnsCgpUa/3MXA8cWpER+hps
         gATiqqxwo7TK8MSNsXvrHho6Q4NdzS/VPir2xLvL8+KhcO+IvTw3dfHbvCPoRADZvl2B
         uYkAlvnr+uFxNhoIjhi9lIwe63zW9iE6jAp3eDsQpGnNKzutajGfEXvUO6bf2jf8pCdi
         6rN6VPHPNaO58q4w4O4xDjcG853lB+yE0RK29Ju/AzG7S03NeSw5txzvD9iSUx5cArje
         Hdl6X+1Z5mqwcdW1zq5SAfl5r8JnCjYv6CPHJSTEV4GXGxX6QAwan1tchWWm494GPhcQ
         wb1A==
X-Forwarded-Encrypted: i=1; AJvYcCWingO2VLf+6JKa4oiwylFxxXzZNvC59jhKYVSbzEiANNvXkxT1nF1XlkmVU+kctPXgRFTbzgAsn4LFnRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHYqFaCsnsAxHFxDkBvwgUgcv0EMtD7iiYtfam+gZW7DZI/bh
	X95bhNL8X/hWvjF86K0VhGQ7c4ZfODOlqC2eu0KajevGokstNMon2cI/qPbp/+NYwFBVWt+/2M1
	nvNin45OxhClCEoNEDlh8wPRajRmtKn7DgSzsPZd/wHJ0bz53/xXYfElNhzdNjQdXMCuFUUTqj2
	585LspajACIIp4WfBRAiz6kOBGwoiYcdAaxxo/VnZOt+npqBrQJdV7
X-Received: by 2002:a05:6870:9a20:b0:261:17e7:59b3 with SMTP id 586e51a60fabf-2886dd63017mr3691897fac.3.1728740763938;
        Sat, 12 Oct 2024 06:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP4R8o1xTNt9NnlgIKlLHoYXBR+jmFI4otlWWTHp9Xr17E6cIWspGpN8K84jN8jnyBWovayalZRE70svxjXkQ=
X-Received: by 2002:a05:6870:9a20:b0:261:17e7:59b3 with SMTP id
 586e51a60fabf-2886dd63017mr3691884fac.3.1728740763638; Sat, 12 Oct 2024
 06:46:03 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 12 Oct 2024 06:46:03 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240930-th1520-pinctrl-v3-6-32cea2bdbecb@tenstorrent.com>
References: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com> <20240930-th1520-pinctrl-v3-6-32cea2bdbecb@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 12 Oct 2024 06:46:02 -0700
Message-ID: <CAJM55Z_8d10_8g8D_WwYqi_D36JVs+7UdooO9p81Vuwd8odSyw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] riscv: dts: thead: Add Lichee Pi 4M GPIO line names
To: Drew Fustini <dfustini@tenstorrent.com>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> Add names for the GPIO00-GPIO14 lines of the SO-DIMM module.
>
> Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> index bf1c639072b8..ca84bc2039ef 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -29,6 +29,12 @@ &aonsys_clk {
>  	clock-frequency = <73728000>;
>  };
>
> +&aogpio {
> +	gpio-line-names = "", "", "",
> +			  "GPIO00",
> +			  "GPIO04";
> +};
> +
>  &dmac0 {
>  	status = "okay";
>  };
> @@ -48,3 +54,36 @@ &sdio0 {
>  	max-frequency = <198000000>;
>  	status = "okay";
>  };
> +
> +&gpio0 {
> +	gpio-line-names = "", "", "", "", "", "", "", "", "", "",
> +			  "", "", "", "", "", "", "", "", "", "",
> +			  "", "", "", "",
> +			  "GPIO07",
> +			  "GPIO08",
> +			  "",
> +			  "GPIO01",
> +			  "GPIO02";
> +};
> +
> +&gpio1 {
> +	gpio-line-names = "", "", "",
> +			  "GPIO11",
> +			  "GPIO12",
> +			  "GPIO13",
> +			  "GPIO14",
> +			  "", "", "", "", "", "", "", "", "", "",
> +			  "", "", "", "", "",
> +			  "GPIO06";
> +};
> +
> +&gpio2 {
> +	gpio-line-names = "GPIO03",
> +			  "GPIO05";
> +};
> +
> +&gpio3 {
> +	gpio-line-names = "", "",
> +			  "GPIO09",
> +			  "GPIO10";
> +};

Hi Drew,

I just noticed you've moved these entries compared to my original patches, so
they're no longer sorted alphabetically. Why?

Please see https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
under "Order of Nodes".

/Emil

