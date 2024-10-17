Return-Path: <linux-kernel+bounces-369654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7919A206D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8492876C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4C1DA116;
	Thu, 17 Oct 2024 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uPWXaMm3"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7391D63F5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162899; cv=none; b=VoRaNu5VqpLugRqh19/B2HnhpgF1Veuw6fqMKT2niLqS5m3LHAob1EES7/a2YvR7lvl5PTDSkJ9oGW2FGbnRIBF5t4CUDU0frlxbs53GuCkij6oPtx7cow+SeespUnnJcqK6Js5qxSIumuOaMZSUVcXyV87VblfeypdggZ1AM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162899; c=relaxed/simple;
	bh=+MrT++Scx29PaRgKv58oxzVZcqzx7TYELWD2t6Fb0D0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+xCh+ajrSmbptIqGSrXQvwDEqst9pCjtXTeASnXAPf8SoaHHOMEWM0ne34IHi3q7gZaG9HOy1h16FzXj5AAVmo6dsaWKp62YS79y9PU4fcIWaGEKGtBRAFGRW5Nd9Juf/vsQBN7R8V71FbvKm7alVNUXhpnLa7COZ+rWDs9LjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uPWXaMm3; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C7343F28B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729162893;
	bh=rBZFdT3MLsNU1ABGIaObRFXCBfywuT/8DVsj8czEnD0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uPWXaMm3Tin3JL+SPrLU5hNvx0oNzxbN/3vcOvcg/uTSDj5qmS9LuPiK/xjbdwCS8
	 Yg7R1PaWMishErWtJwRgJme1GPC80BQqTPOkRgGcdff7pkkY0XRd5xcHH3pdJdwSvS
	 UINzDzSyzbhUNAKpANht83uKt0+2Rcx+b99yasIvNVQPLhzJ04Vs416yEUUMm2mg6s
	 y/MFcb5mBhTUg+2aCOaJkCBL+mjD9DrhknRa50paSWkhYou+zg61mBq68TIrZ0UEvv
	 nf3XGuE2XTs4UrmuzIUFq+E8UcClVVbxhBCSP07uvNqYuAqPGuNjWPUr93BLsmUZK7
	 i/0xf+zGGeWOQ==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-288ae5eabaaso644184fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729162892; x=1729767692;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBZFdT3MLsNU1ABGIaObRFXCBfywuT/8DVsj8czEnD0=;
        b=n1N2y99Qd0E1URA7L6ibl0rmBDvEkczhNs0NwAiKkzNqfbtrHZ0iz3LpuolafvqPKX
         GDFNR2/GEaseHBegdKGchiCTDZYHDQgfTq2+9Wz75f5yzu+HTiPXB0R7i6vnD1DTUj0j
         7Vx6bViPI54+fF6+GncPOerU8zKZTIBNuolpYcNsGR8IiIGr+oACN/YOLANdcTgRSvc+
         VOwLNN67ZO0LglqbXvf3zXYP59fkZ9TEkTUPiK9csuV6GoVcS1lQpDYFoueYOt0ilJEY
         RQwVrsj8GwcbLw61NDUP5KA1wPSVfVDYAk6GQrnhaJEJWzmTJNR98XKgiZcVjQspiZft
         xBvg==
X-Forwarded-Encrypted: i=1; AJvYcCXjmrDBGeW5VBAZBeixixVJq1tNv5quZ2zfHpJydff8DDLl9RCA+fyUCsJze9wq6niIbksYW0Nr74h8WlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03jxadn95JNmzQvTun0JubQ1MY+QuWgrxlUfM7Jv33ozbzML3
	o6u7VNRSNGa1SGqxZ69iTSwovUJ3wl/q5x+YrSsNVNhYRvRFSUdYBvHZ3bRcWtJ8G/j1nkTtZxe
	Cw/zWDwkjQqQMkxQuCGBAhSa9M5qI/Z2UNfMmSMaloyb25cL16w5+I5Ta7tYoczJdPv32R7m0hI
	ow/TklGywpLin/2BdIar5XufrUuV2SNew/eX0XNy3ykOGPnMc85QZx
X-Received: by 2002:a05:6870:6b8b:b0:288:6220:fe18 with SMTP id 586e51a60fabf-288ede29989mr5858216fac.15.1729162892274;
        Thu, 17 Oct 2024 04:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHMQG+kH208gfIiCgVMibniBpJ9STBwlor/4oG77CWFuIW/8xPcr2jPuy853NfEotH6tqZk6Hzqg2xW/WrByQ=
X-Received: by 2002:a05:6870:6b8b:b0:288:6220:fe18 with SMTP id
 586e51a60fabf-288ede29989mr5858187fac.15.1729162891890; Thu, 17 Oct 2024
 04:01:31 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 04:01:31 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241016-moonscape-tremor-8d41e6f741ff@spud>
References: <20241016-moonscape-tremor-8d41e6f741ff@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 17 Oct 2024 04:01:31 -0700
Message-ID: <CAJM55Z-3R5tbvpQB7mLF6b=FD9Wg-78_KPww2nqOLr566WPOFg@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: starfive: disable unused csi/camss nodes
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	Aurelien Jarno <aurelien@aurel32.net>, Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Changhuang Liang <changhuang.liang@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Aurelien reported probe failures due to the csi node being enabled
> without having a camera attached to it. A camera was in the initial
> submissions, but was removed from the dts, as it had not actually been
> present on the board, but was from an addon board used by the
> developer of the relevant drivers. The non-camera pipeline nodes were
> not disabled when this happened and the probe failures are problematic
> for Debian. Disable them.
>
> CC: stable@vger.kernel.org
> Fixes: 28ecaaa5af192 ("riscv: dts: starfive: jh7110: Add camera subsystem nodes")
> Closes: https://lore.kernel.org/all/Zw1-vcN4CoVkfLjU@aurel32.net/
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Thanks!

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
> CC: Emil Renner Berthing <kernel@esmil.dk>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Changhuang Liang <changhuang.liang@starfivetech.com>
> CC: devicetree@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index c7771b3b64758..d6c55f1cc96a9 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -128,7 +128,6 @@ &camss {
>  	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
>  			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
>  	assigned-clock-rates = <49500000>, <198000000>;
> -	status = "okay";
>
>  	ports {
>  		#address-cells = <1>;
> @@ -151,7 +150,6 @@ camss_from_csi2rx: endpoint {
>  &csi2rx {
>  	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
>  	assigned-clock-rates = <297000000>;
> -	status = "okay";
>
>  	ports {
>  		#address-cells = <1>;
> --
> 2.45.2
>

