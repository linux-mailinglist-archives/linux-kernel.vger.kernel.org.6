Return-Path: <linux-kernel+bounces-234974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B0491CDB9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C03B2165B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA98287C;
	Sat, 29 Jun 2024 15:10:18 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95244C81;
	Sat, 29 Jun 2024 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673817; cv=none; b=fLwlMgh+fTwUTkiRnkWJRHZC3ssWBganyraGji/G1Of+Kbd5L39LCkvWOxXdmRxEd4AC23Ea23AtLHcCBjW2wb3rjLhuZ8to5hcpIKo/Cpe4JkebuXkstNoszZx3+pq8iwB7bSx7eIuvM0+LMfTzHzqNILTiJW+aFGLiLhd7wSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673817; c=relaxed/simple;
	bh=yBZP3X/4Bz6O6dGxiQFgAgwwOBxnExTkmFJ4MGWbaj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMleJCxzCtiRxF/XfI4hFpT0laa3J5PxV7vKr8O2JhGUePi5XEhLVRxFOJyvuI9pMNkkhgrLXV2d6SyivZWZhtuA558f2Tc8kBAqAt+jp2bSmAvIXjmtyQD/mwewPzKpcU28+ribEBe7sEUNSp1MOV1Np92/dyFBEVI1gJU4afI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sNZiD-0006CI-J5; Sat, 29 Jun 2024 17:10:01 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>,
 Jonas Karlman <jonas@kwiboo.se>
Subject:
 Re: [PATCH] arm64: dts: rockchip: Add optional GPU OPP voltage ranges to
 RK356x SoC dtsi
Date: Sat, 29 Jun 2024 17:10:00 +0200
Message-ID: <7679413.EvYhyI6sBW@diego>
In-Reply-To:
 <446399362bd2dbeeaecd8351f68811165429749a.1719637113.git.dsimic@manjaro.org>
References:
 <446399362bd2dbeeaecd8351f68811165429749a.1719637113.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Dragan,

Am Samstag, 29. Juni 2024, 07:11:24 CEST schrieb Dragan Simic:

> +#ifndef RK356X_GPU_NPU_SHARED_REGULATOR

is there some reason for this duplicating of opps?

The regulator framework should pick the lowest supported voltage
anyway, so it seems you're just extending them upwards a bit.

So I really don't so why we'd need to sets here.

Also the voltage-range thing makes sense for non-gpu-npu-sharing
boards, when the supplying regulator does not fully support the
direct single-value voltage.

(rk3399-puma was such a case if I remember correctly)

So I really see no reason for this duplication.


Heiko

>  		opp-200000000 {
>  			opp-hz = /bits/ 64 <200000000>;
>  			opp-microvolt = <825000>;
> @@ -222,6 +229,37 @@ opp-800000000 {
>  			opp-hz = /bits/ 64 <800000000>;
>  			opp-microvolt = <1000000>;
>  		};
> +#else
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <825000 825000 1000000>;
> +		};
> +
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <825000 825000 1000000>;
> +		};
> +
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <825000 825000 1000000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <825000 825000 1000000>;
> +		};
> +
> +		opp-700000000 {
> +			opp-hz = /bits/ 64 <700000000>;
> +			opp-microvolt = <900000 900000 1000000>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +		};
> +#endif /* RK356X_GPU_NPU_SHARED_REGULATOR */
>  	};
>  
>  	hdmi_sound: hdmi-sound {
> 





