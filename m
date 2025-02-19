Return-Path: <linux-kernel+bounces-521630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE84A3C02A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DC53A79FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFAB1E51EE;
	Wed, 19 Feb 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="I4znsC4k"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13381DDA36
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972216; cv=none; b=gH6zybpiGPZTGJmkVJP6Yi7qL2ATMNID3+kafEPmdBqgi2ZkcK8u8+aaf4DBVQmTB5XS84qPslBEIv7t+xYELzHYW2bFMsqAVj9S89ouw2AGyXc1ojjK/xSCY9RTi1wDBFUo/wtIWjejfHiSJ2Z0+GovM9V2FrJh0l9xetzAw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972216; c=relaxed/simple;
	bh=a5amTpCIxi1oHRkT9I7QqR+ljS6+mKJGpRiYNSmKfLo=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8sPhq6rYPYgfSDQ9yafefenp8UiM5xrkjCm6eHfUPipGrpk48DnoqNl7WQ83bp4Ymcqf3vCV+TnUpdxRaVEGxevHIlNHmu+jrf6wYBdQzh9I71jX6jknt+k/hjTeIxJPwbH0KT0DyXGfzM7LdbwvEK2KdZfiEsdBV6CruTGquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=I4znsC4k; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B027F3F2F0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739972210;
	bh=oxEPsf6BXD6TadgvNAnbgKVAmCgtOTjj+4mMTP9U1dQ=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=I4znsC4k9jemo5zvo5E8Xgu9kjstO3YqvdC9bXhboLtiubU1tC+th/bncec2Onqg+
	 Bxht7qbFe0F32lSl3/TwLNcVOuloIyvfhpInZFusfJpHkr/SsxL2ACng+4hBnMCMGb
	 r+jQDi+F1K02rBdKK0nWCVRryj0Nwj2PyRDRhP4FJfZHJIaPDxM+AUGC3Z1BUyKe6a
	 eRk6TVNiGbiC3oQ5kCfmR74P1WI5QzoTENbrEQr6zDd+cjthpewySyMCiL/zCRPC1b
	 APKEJgRxRhxamNM505JCnTSyXmRZ4znqXe7c8cZ8qQ+UbQ5tw1G9gp02EUQVUguGhP
	 KbFSZ9NitsC7w==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3f40c241372so525841b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972209; x=1740577009;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxEPsf6BXD6TadgvNAnbgKVAmCgtOTjj+4mMTP9U1dQ=;
        b=tpGTANgHOSRUCVw++wrV5MmXT89dPkQgoeqd2LN99G0sEMuLa5gykMipGYsxHE3NNl
         1SkM5ThcJ+OQ81pc3WtGXPiV2Q8Y2xjQwo+W9ke3hbZr101WQhKYF8rHByWdr5RAKifb
         UJP58+AhBjTPux882Kync8E2CkvbhrdKC073XbvfKw/bokf66aMw0bU7J3yFYwis58MZ
         gtIbnJnhCFxbVK/WS5Y20jJRZ9uaXtWpMq7OXP/id/dQygQDEMb9r13aV7DzGVlz+3UD
         IQNyH82/usH3en2TpsX35Aub+P6o0aE7at2WeSZ+u1BdG5EBSiRTPMSeatwHMKXZIXAw
         FERQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRsFOAuwbD4HpyQTrNhSUAPuMHJmVzwHHn/5hNbZoa968zeFcLRcz5yVw2BmOGsjagjYdII9sYsxopizs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIoajQUf3lfMmsHQbupdSRZwHTVk52Ae7G3NUxEaaR/47riURe
	uo8YtsObg9SUsaTJDHdMcGmeq0d3n848Ci6LMpyQKT8j1rP+96dUL+lI6nCYK7oGHUF/aaT5FGB
	68O2r3z+qK5HTvNffE0cTyziX8sABTsJtP6h3R/iE6f7Dz1WxgE8pfgIlbypbvpkS+DurLIiS2+
	UO7UPyEeALFzzD01/ukdgQnCNZV5P1ldANLBA52Omcw2sXUFHkD5Zp
X-Gm-Gg: ASbGnctvW8ZPzhFKy3nLVXv/+ahTjtS8x+epIBH8b84RuhkhOHfvJmqrbOH7TtZgJUQ
	cv8Ife6HRPNjUEzRqMpW8GnKFwqgSmq8L8W83Ay7st2d5H1UZxTtq/UkCHnC2oG3+KsRSx+A1TE
	JhvrEN5ihusZkAHPA=
X-Received: by 2002:a05:6808:13d3:b0:3f4:b14:8d8e with SMTP id 5614622812f47-3f40b148f5emr4687278b6e.39.1739972209583;
        Wed, 19 Feb 2025 05:36:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9hEEslwxSC5v+wHCnRCJJyBAh2kUK73RjgIFEWwcww6qhYK/ZqyM+mXPwcQZQKmE7ZuGDceV0yV4YigAzOhA=
X-Received: by 2002:a05:6808:13d3:b0:3f4:b14:8d8e with SMTP id
 5614622812f47-3f40b148f5emr4687243b6e.39.1739972209253; Wed, 19 Feb 2025
 05:36:49 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 05:36:47 -0800
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 05:36:47 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250213-tidy-dollop-cbfc8fc7dc91@spud>
References: <20250213-tidy-dollop-cbfc8fc7dc91@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 19 Feb 2025 05:36:47 -0800
X-Gm-Features: AWEUYZnRpiBceaWxcRC-Lan6TxlbntvEwYvjC2A02PkLG-UmOt5pf0O2VECu_Eg
Message-ID: <CAJM55Z9VDCymHezg8WGuJUnySzNFKBJO8g5ARJegb2zAmxeuOA@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: starfive: remove non-existent dac from jh7110
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, Emil Renner Berthing <kernel@esmil.dk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The jh7110 boards do not have a Rohm DAC on them as far as I
> can tell, and they certainly do not have a dh2228fv, as this device does
> not actually exist! Remove the dac nodes from the devicetrees as it is
> not acceptable to pretend to have a device on a board in order to bind
> the spidev driver in Linux.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Hmm.. I thought we already did this, but it must have been another board.
In any case

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Thanks!
/Emil

> ---
> CC: Emil Renner Berthing <kernel@esmil.dk>
> CC: Conor Dooley <conor@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index dd2eefc295e5..c2f70f5e2918 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -350,12 +350,6 @@ &pwm {
>  &spi0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spi0_pins>;
> -
> -	spi_dev0: spi@0 {
> -		compatible = "rohm,dh2228fv";
> -		reg = <0>;
> -		spi-max-frequency = <10000000>;
> -	};
>  };
>
>  &syscrg {
> --
> 2.45.2
>

