Return-Path: <linux-kernel+bounces-362496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E54D399B59F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E228B21A6E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B81990D2;
	Sat, 12 Oct 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YJCBOV1F"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD212186E2E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744076; cv=none; b=HjlRd8Ow+0w+6FiXEFC6IuNf5aVQVFYRusmQyLg54ssorIeUjenscbVujhqZVjCg5HBkFpeeSwb2f91sv0iQPALtXi2eOfRqC3oJ4vDAHUziunyGmkhkvDTMPDi9bMpWo0Y/hexVDf3W2bB6KsQAxUQARlkvEkiIYNGPB8COfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744076; c=relaxed/simple;
	bh=Vxeb0uTE3RuyRK8PqHtAQnI2FGYg0a4hdjYOoPxRhKk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbKY/GxHWuMsrUE0qKDuVBSb9ZI6tiGwxPeMJgLqFsa/5kp0PgyMjYjzVTLsuNBb6SSLHGm/yEPlSIFTLUR7ap/dbN6HlGIcjrMinteXkICRU0n9JNneGaVP2PciNhr+vSUUxd6Q27mqib3UqJ+JzRD4zNSb+n9eheRqi5NH7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YJCBOV1F; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 668854027C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728744072;
	bh=u14OejdbWcG0velVojMwkvgHAoWWwEN6ANeyU44dL4U=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=YJCBOV1FxLgxMQxpF8Y1iSsfyYfccXfjAHyotS01tv0QxuWTTmaTWivkL+zwZ05EB
	 EA4z6Oy7YA6MlcJQhRivWBZFYKuaoVkKEYAp9ETB8cwIxMj7oNMkRoSN5hXM/91MLC
	 uNxwWqahK2iaSzny33oWWXT959jAKsISqK62MqL7vzvFP9xBiUWccM0YMKDeUFtpu/
	 9ymJX349XKG4ThIObs7e6lfPazv+uc49nP7QoTwpZJpnZD74DxgzuSYnbVoF1n0MRG
	 UJwFV5U7NRICI0zZU1Pe7v4aF8psQa0mecV2fBixEh/RPvo8yZN3cVytGLD6jJo65Q
	 hFhjOt9T8i2FQ==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-28778791da6so2790275fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728744071; x=1729348871;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u14OejdbWcG0velVojMwkvgHAoWWwEN6ANeyU44dL4U=;
        b=BYwT37uXW7vtjZn9uH5cOaaRjZS8s+UWeuZ/yDnmBYF8j7eS0rrIjrXeQ7UNOs7yvl
         KDw8Tqmu0HY+ZXR0x+tuIEJf81ZZVV+z30wJCQh6OdexqUJv1UqbBy1E7W2oxZ5MMpng
         FVHAUG15s73d6Zvr/IVEHwaF3bSnwFBTsMBY/HZyM8xAdGviBvwzh16tdHqs5Lju4eIW
         CH3l3RuC/0TIIbOceLuOB64BUQ8ZxiI6IDjNJjaUWzip0eJT2lly+X5vuhgrOmCjjeql
         QSPNs169E8WmMxATQvP76qKbPuTViWduqzf7teSKosLl28/M0OhIbnGnI9f3zeGUWIAv
         9dpA==
X-Forwarded-Encrypted: i=1; AJvYcCWzV3dnnkEKGB+HQebubSNR4MxPPv3AzLJwqoQI/zUb6XR2oYtOgGQxsBsAVB++ibUNBUgnSMl6OSgwXi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3AGDiFovweSdA4hnUCihscn7G2BSsi94eHVxu/j8fe9snvtFq
	DD9xoaJ3KgKNstXcQC588lVr4xZ8+PgT/xlxbouJlANcCRP+tPV09CNwvYjG0zejb5HssMySP2f
	dvFPa+KCRn9qnF4G8iKJ4KLQUxsMJQ/wke/XPhq9AaJpizF8xDI/e9g7L2VHuVTHb2MZThHX99Y
	W0W0RyLdUesMwdIdrJYYKz0bmf1ZkRosG3gW8qHwUd96layZm8oFdU
X-Received: by 2002:a05:6870:b514:b0:261:1046:66fc with SMTP id 586e51a60fabf-2886dd3fac0mr3280048fac.4.1728744070948;
        Sat, 12 Oct 2024 07:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXUlMb3PnnEigp7yJsQv44SPpz2ujpyO0GZEe1m7y1otwwP5hPxCneu5J0+02C3ypjxxd7ArzHX3GpPmZvsRE=
X-Received: by 2002:a05:6870:b514:b0:261:1046:66fc with SMTP id
 586e51a60fabf-2886dd3fac0mr3280035fac.4.1728744070551; Sat, 12 Oct 2024
 07:41:10 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 12 Oct 2024 10:41:09 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240930-th1520-pinctrl-v3-8-32cea2bdbecb@tenstorrent.com>
References: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com> <20240930-th1520-pinctrl-v3-8-32cea2bdbecb@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 12 Oct 2024 10:41:09 -0400
Message-ID: <CAJM55Z8rv587qAtiMoc5i4+ZkQk6DwQJQVmDP=3gG+wVe7h0EA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] riscv: dtb: thead: Add BeagleV Ahead LEDs
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
> Add nodes for the 5 user controllable LEDs on the BeagleV Ahead board.
>
> Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> index 6c0b768e8d17..5a5888f4eda6 100644
> --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -7,6 +7,8 @@
>  /dts-v1/;
>
>  #include "th1520.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>
>  / {
>  	model = "BeagleV Ahead";
> @@ -35,7 +37,42 @@ chosen {
>  	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0  0x00000000  0x1 0x00000000>;
> +	};
> +
> +	leds {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins>;
> +		compatible = "gpio-leds";
> +
> +		led-1 {
> +			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;

Here you're also missing important changes from the tree I told you to use.
These should be GPIO_ACTIVE_HIGH otherwise the LEDs will be on when they should
be off.

> +			color = <LED_COLOR_ID_BLUE>;
> +			label = "led1";
> +		};
> +
> +		led-2 {
> +			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +			color = <LED_COLOR_ID_BLUE>;
> +			label = "led2";
> +		};
> +
> +		led-3 {
> +			gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
> +			color = <LED_COLOR_ID_BLUE>;
> +			label = "led3";
> +		};
> +
> +		led-4 {
> +			gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
> +			color = <LED_COLOR_ID_BLUE>;
> +			label = "led4";
> +		};
>
> +		led-5 {
> +			gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
> +			color = <LED_COLOR_ID_BLUE>;
> +			label = "led5";
> +		};
>  	};
>  };
>
> @@ -71,6 +108,24 @@ &sdio0 {
>  	status = "okay";
>  };
>
> +&padctrl_aosys {
> +	led_pins: led-0 {
> +		led-pins {
> +			pins = "AUDIO_PA8",  /* GPIO4_8 */
> +			       "AUDIO_PA9",  /* GPIO4_9 */
> +			       "AUDIO_PA10", /* GPIO4_10 */
> +			       "AUDIO_PA11", /* GPIO4_11 */
> +			       "AUDIO_PA12"; /* GPIO4_12 */
> +			function = "gpio";

You've also added this line which results in an error like this:

  pinctrl-th1520 fffff4a000.pinctrl: pin AUDIO_PA8 already requested
by leds; cannot claim for fffff52000.gpio:536

Did you run this on your BeagleV Ahead?

/Emil

> +			bias-disable;
> +			drive-strength = <3>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +};
> +
>  &padctrl0_apsys {
>  	uart0_pins: uart0-0 {
>  		tx-pins {
>
> --
> 2.34.1
>

