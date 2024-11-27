Return-Path: <linux-kernel+bounces-423497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49AF9DA868
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D939282577
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281B1FCF66;
	Wed, 27 Nov 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uV11KJFX"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B51FCF5B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713834; cv=none; b=bfip9vJZgTNpZ/aBHeT6bpKRBqO30EMk68W4IZpjodGO2fKEMruo+r3TZoNfTRqw10mV+iXwop397i709Up+aATq4bey2RHOlpbhd3PZxlmxh4lzfmyz3ZITtDXp7Lvifx8qge9NpaSJtcc68gPHyiNecl3zUuFSwUaYNP1zyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713834; c=relaxed/simple;
	bh=qtxiBUJrSqg0i3oZn3/EBpNkSvaRXXxPaeCDhN9LRp4=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epQl+01/F1SbGYqSLgASIpLTxqWo6Sl/EQ4I/TATrrykAMXEVYl9/Rw0QXMKDeLZOHQKksDQgHRw5E091grBwKstryxb3GkfVta8u3N/7hyo/0NRQ4ZTW9H/KiGqo9KhDu2xWfk80p/gTNw/tgOmlV7zzp00q+rlQPs/B+mbt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uV11KJFX; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1B88140CE4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732713831;
	bh=cL5M32W3R5eUX/4zpFKVLV/R7h3YjIcs++U+D/L5AM8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uV11KJFXIJImjDMDw8BMGy3m7VamyxYActgJPcQ1jnyPzYJWn/xuCkYJWmHmbzowB
	 LHJUNwe4OvZeddJ/H+5ASUNlMHYLJ+wBoAvyWeal6HB/dUebyDHaKFflowTgvwSwt3
	 zUEKvYKTw25yCvH6HbKNzVurZVBGseVf/BgudBTC2Kvw4L4Kf+1yeVO6vBdqr5wsvP
	 t0nYJoDMkDKmuDh1Mb7qjdFLbz9+Mxl3qo4pe+QhsqMk+4tQeMyFH7RjDxbMT9t62C
	 DfC3IgOpLERfGlb1wF6N1RDckJzIC9xNOvJhMTPuwC06phHuB7ULg3tXFsZpOgUdV0
	 M4AprDlqxZzdw==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3ea4b711b0aso1862875b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732713828; x=1733318628;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cL5M32W3R5eUX/4zpFKVLV/R7h3YjIcs++U+D/L5AM8=;
        b=iT8OY+Ae6jAy7jZLp8BqVb1/7jhTgCw5eDgIk7f6IZNY8X0qzMgHMPhZEWI5APxf7V
         umBV9vjGf5HbHpVELwp/8kDpiqno1uQWcfjra0zuz0Jb5ORRpviMJguG1flU8/Qq/Fcg
         qEJ0IhtesGNndXykDV//8GCIObnHW4wEk6tBJO/jzOe1FQEBY+q7ugV78dsjl4NqZfpP
         9T5WAk7/LU75OZFK5lfXdCuISjCo5oT1n+SaKMrQYGv06yr1zbOlHPAXprropSc/ERsQ
         +1vYluOqHJ+YnGgjH4RdhkyVxDyX6DWoxPO00pEJqMQTRWFqg5515n3Qbd71eIJNM8JQ
         F6sg==
X-Forwarded-Encrypted: i=1; AJvYcCUmsvjTGdvI88eMLrBK0Ue9qI/uR6p0Fvr6WsyxhXmsi593G7ZIXAfcbcYiZYbZ6WyT0fvtW6HcCPin89Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1ZQIx70cFQ+n0hRWGfzNDBIb5iqAW0IIL+cpuHvhOxPj0KGE
	gSUTy04gNJcL2+TN5mzsBuzt75fxMeKh4S5RIi+kUSCapotjonYVB7HsD6W+Xk7k9a7EEx5rxB9
	kinSt0ic4GbTJINMm3mQT4e2GIcLFfqjZq/WQgIANyfZWFxnBND11Hx2e5NECqr12kpTd4oNMlB
	Csfb0G3IhQZXII/5ww4yNszdX3p7jSQGVQ997JVpQxdN7AzC9xz+SS
X-Gm-Gg: ASbGncsHv6x4aGmYZywM8bYT+gBmCTHL70NG9+Gitb5YzcQP4YbIjjNkSYNDwomu9zm
	6knHgscHjFC03FPEUFTkhW3XwTKrOcepIa+ziIipwwmlpbAO1yJAVdPcDurUn
X-Received: by 2002:a05:6808:f0a:b0:3e0:4f6c:abcb with SMTP id 5614622812f47-3ea6dd47acbmr3886372b6e.28.1732713828048;
        Wed, 27 Nov 2024 05:23:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGufrHOyrMhM1rehaDhI1q2R5G+xXwoSxzeI2W2FAdnLZZRRJ6/ihK0V7J0ERO8UeSUM8vMDAVAOcN6kRcdi7Q=
X-Received: by 2002:a05:6808:f0a:b0:3e0:4f6c:abcb with SMTP id
 5614622812f47-3ea6dd47acbmr3886347b6e.28.1732713827792; Wed, 27 Nov 2024
 05:23:47 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Nov 2024 05:23:47 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241126073836.17208-2-e@freeshell.de>
References: <20241126073836.17208-1-e@freeshell.de> <20241126073836.17208-2-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 27 Nov 2024 05:23:47 -0800
Message-ID: <CAJM55Z8---o6_ZxeyUu_M74LA_zKfeksBmRGFkm2C66hRJbPug@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] riscv: dts: starfive: jh7110-pine64-star64: enable
 usb0 host function
To: E Shattow <e@freeshell.de>, Henry Bell <dmoo_dv@protonmail.com>
Cc: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

E Shattow wrote:
> Pine64 Star64 set JH7110 on-chip USB host mode and vbus pin assignment

Here I'd like it explained that the Star64 board routes 1 of the 4 USB-A ports
to USB0 on the SoC rather than to the USB 3.0 <-> PCIe chip.

(Confusing for users that 1 of the 4 similar ports only does USB 2.0, but
that's too late to change and not relevant here)

With that fixed:
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

>
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  .../boot/dts/starfive/jh7110-pine64-star64.dts | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> index fe4a490ecc61..b764d4d92fd9 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> @@ -80,7 +80,23 @@ &spi0 {
>  	status = "okay";
>  };
>
> +&sysgpio {
> +	usb0_pins: usb0-0 {
> +		vbus-pins {
> +			pinmux = <GPIOMUX(25,  GPOUT_SYS_USB_DRIVE_VBUS,
> +					       GPOEN_ENABLE,
> +					       GPI_NONE)>;
> +			bias-disable;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +};
> +
>  &usb0 {
> -	dr_mode = "peripheral";
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_pins>;
>  	status = "okay";
>  };
> --
> 2.45.2
>

