Return-Path: <linux-kernel+bounces-383699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC8B9B1F3B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A61C208F1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C406A1531F8;
	Sun, 27 Oct 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GznL15aT"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDDA1E535
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730047098; cv=none; b=n0S+ijLzvhhVJjrBZfDr6HUs71ZlSEZF3CnqfIqSnWD8cOSHC6GfAqHFj/v74kjm2l0SXipSWV5My151j523WPez/j2o14d5Ov0MF1VSHLKqUlH7Yeud3zZpz9fxNpeElPr6VTOUOY51Q+zVChAz7ma3EAc/G2yt+EatVUYz/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730047098; c=relaxed/simple;
	bh=1+lho3OJqfXBcRJa6OsnQPtc6OQNI6CwPGAYPwnS7w0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3WEzjFRg03goqGfKdURqZNdWeRuHipu0CuCvVWJH8zrWpiILGhuxac+gndRfElKVNkjkQn6YZS89twlwaXQkeTmk5Ac9+XCugh4NNbDoT9+d8oQNkqD/Flf4r9wcdfb/+VTRssXmTAOitHOREztU5LkqKm/bu5/RIfpdcmWgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GznL15aT; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D3E43F2A9
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730047092;
	bh=L6fX0ga/wJJ+KuonzpY47wlRqLMP80SVChx+E93Tonc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=GznL15aTSs/O1yyKIk9QU7tg6raun2zG2rQPPeCkWZ9RRsac2949hf4MJeXAbji70
	 irDgaZ1QBmAPPMQyBOQ+htiWwVFVV8lVNfqn3lDREb2nfEcYfM/OzT096e7rGCfXhd
	 QiRCoIh4hlop03U3msgSoATQTh9auFkSCU/RoSQlUxG5V41z9nTvdGjofBXpCMIvwm
	 oKmHnUn46z+iTMifJI/GvNrGT+iO//7xoUVvZprrKcqbNEYPd8MkSctZXduOf205Lw
	 zx4VKW237rMitPJafxck02EfuaJcSQo3fPanU7inxapOhPss6MaJ1cDoR8sp0R4HuX
	 G9xs1Dc33qsoA==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5eb5bfc32ccso3114352eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 09:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730047091; x=1730651891;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6fX0ga/wJJ+KuonzpY47wlRqLMP80SVChx+E93Tonc=;
        b=XtDd/WbywuKpmdmUClt5bJWeN1ocSkSib/Bjx2r0El7bnGLmVRKoh+OOzvNOxqBzdX
         zFznmHlX/43WpF7U3Zc2tqOLu2ITESdKPUbi6DYIOmOk6XMMLHCbFiyFvtzeJCe3S0A5
         kHGgtDoU4pNyua5nlV110Ij003w6L9X42xPlhtDBcImL2eKynZOHS9woCQyR1m+No8Rx
         o/I8x3taqIunX+BujJglDP9rnQAIlpxdM7tswvQfg/STe6TSihD4xnNdCzr1GLsS9C5F
         ZZ86RmTnIe/tyD5XzPfOeq7j/Hruh94PuVGN2Ef5GACDvEE9zz+K8aZIxYDcIhEuXWXt
         rBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUN+GUz+D5bp096Bd4mxMlAA2r0+LAlTPgvnAyq/eZf0X8J7Lzte8OzaPzKgaUDErqbdE8tbdrovEJFy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ujYbXA0fk/0zjOdsPDEqfwk60RlrAdyJAgLnalrkEoRjVGDo
	dDY2O/49kPmOM6BWDUalfa3g+2FwzHr4Jw3zVpBLQeGvpkf5LZg7xR6D634DFaBDu849PWe/+MB
	tXSLCOTwoUPivAzHJi+pQYxSTD10tcvNSjmqjh3YXul9A7zgPHZhhCdprwV65Jp7dpk2jqpTXMd
	o1JVvxv+Nzzld5NRALggObApzOk8fRGjMxGDDK+Uth2hRjow7ylNTg
X-Received: by 2002:a05:6871:207:b0:277:dc01:75d6 with SMTP id 586e51a60fabf-29051db63f1mr3277950fac.38.1730047089915;
        Sun, 27 Oct 2024 09:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk2PnZTePh4hB8asBsbIbJjk9A8StPDXdojH/EWhG9gZdGzL1o2gl0MrExOQ+Mk6kwusrvyZUu5zJLp8ah8xg=
X-Received: by 2002:a05:6871:207:b0:277:dc01:75d6 with SMTP id
 586e51a60fabf-29051db63f1mr3277891fac.38.1730047088150; Sun, 27 Oct 2024
 09:38:08 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 09:38:07 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241027144448.1813611-3-guodong@riscstar.com>
References: <20241027144448.1813611-1-guodong@riscstar.com> <20241027144448.1813611-3-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 27 Oct 2024 09:38:07 -0700
Message-ID: <CAJM55Z8wzAKEHJjrG5i18hCRRi5rh8y7Fx+SQ4qsTy1g0oWbQg@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] riscv: dts: starfive: jh7110-common: move usb0
 config to board dts
To: Guodong Xu <guodong@riscstar.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Michael Zhu <michael.zhu@starfivetech.com>, 
	Drew Fustini <drew@beagleboard.org>, Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>, 
	Sandie Cao <sandie.cao@deepcomputing.io>, Yuning Liang <yuning.liang@deepcomputing.io>, 
	Huiming Qiu <huiming.qiu@deepcomputing.io>, Alex Elder <elder@riscstar.com>, linux@frame.work, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Guodong Xu wrote:
> The JH7110 USB0 can operate as a dual-role USB device.  Different
> boards can have different configuration.
>
> For all current boards this device operates in peripheral mode, but
> on a new board this operates in host mode.  This property will no
> longer be common, so define the "dr_mode" property in the board files
> rather than in the common DTSI file.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
> v6: New patch
>
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi              | 5 -----
>  arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts           | 5 +++++
>  arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts        | 5 +++++
>  .../boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi      | 5 +++++
>  4 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index 9e77f79ec162..87ea81e9fed4 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -637,11 +637,6 @@ &uart0 {
>  	status = "okay";
>  };
>
> -&usb0 {
> -	dr_mode = "peripheral";
> -	status = "okay";
> -};
> -
>  &U74_1 {
>  	cpu-supply = <&vdd_cpu>;
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> index 66ad3eb2fd66..0d248b671d4b 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> @@ -52,3 +52,8 @@ &pwmdac {
>  &spi0 {
>  	status = "okay";
>  };
> +
> +&usb0 {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> index dbc8612b8464..d5180c67ac55 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> @@ -80,3 +80,8 @@ &pwmdac {
>  &spi0 {
>  	status = "okay";
>  };
> +
> +&usb0 {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index ef93a394bb2f..5f14afb2c24d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -60,3 +60,8 @@ &pwmdac {
>  &spi0 {
>  	status = "okay";
>  };
> +
> +&usb0 {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> --
> 2.34.1
>

