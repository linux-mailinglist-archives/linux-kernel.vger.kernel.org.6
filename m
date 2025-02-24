Return-Path: <linux-kernel+bounces-528960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502E9A41E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B97E17CC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967FE2192E8;
	Mon, 24 Feb 2025 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s8B48YN6"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C62571A0;
	Mon, 24 Feb 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398608; cv=none; b=hewNhkotvEol4+i38H7Qv9mU5izbBVp6ISHMldi3p2ewryXzxCJHMHChw68i7VPWk2Abl0jltB9uPe4HLiOZ58OC2eYWyT3OsPhM+bR9fhbE5HloikXC2dmEBc3zklGIqB++0SewliimR1t/OJ2hRxNvaPNAMnPNav5KmjUyUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398608; c=relaxed/simple;
	bh=7h5ryNxk757OKWlLFcNWOYukboylFtUCaUa59b6WtpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bK7V41rqxKChzKP5F/rfaoycvpZSw8XY9R+GaKA3OsQKX67wNSdw7ZvHHLXhJqv8k9n7svVk4EOZ5Kk9mGTZ6DYxVR8ja4DR8VRve0n3Yp9yRZogBbmHZZnNQzGPdvLe8WAR9x72c3iHWcZguf/mj0LMkDei1nDKxief9GBff68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s8B48YN6; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51OC3HQw884652
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 06:03:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740398597;
	bh=5raQfcZhDMhumdfr8jxuCUsBCb/cAX6lrocettlzYYo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=s8B48YN6RXbPyYcRP3wjIDrfdeyLzL/aICw32+tMLtDI7d+3xRXAMeeM0d0NcdXRl
	 YhaRDfeDpYzbsne2U1IOxxWSW3qxm0IEu7HeayWBnEcNA0cPkQ6T41QKBbO2Dp8LOC
	 U5+BDYi+wNCITyJankazxTQ5wpe0W9Yyqv85X46w=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51OC3HNE006194
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Feb 2025 06:03:17 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 06:03:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 06:03:16 -0600
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OC3BEA070806;
	Mon, 24 Feb 2025 06:03:12 -0600
Message-ID: <0d871153-e4dd-42d1-aafa-b6ed1e4e5a10@ti.com>
Date: Mon, 24 Feb 2025 17:33:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add k3-am62-pocketbeagle2
To: Robert Nelson <robertcnelson@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Andrew Davis
	<afd@ti.com>, Roger Quadros <rogerq@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, Judith Mendez <jm@ti.com>,
        Andrei Aldea
	<a-aldea@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Deepak Khatri
	<lorforlinux@beagleboard.org>,
        Ayush Singh <ayush@beagleboard.org>
References: <20250211181839.1575497-1-robertcnelson@gmail.com>
 <20250211181839.1575497-2-robertcnelson@gmail.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250211181839.1575497-2-robertcnelson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi

On 11/02/25 23:48, Robert Nelson wrote:
> BeagleBoard.org PocketBeagle 2 is an upgraded version of the popular
> PocketBeagle.  It is based on Texas Instruments AM6232 SoC. Its dual
> A53 cores can provide higher performance than classic PocketBeagle.
> The new design comes with pre-soldered headers, a 3-pin JST-SH 1.00mm
> UART debug port, a USB-C port, Texas Instruments MSPM0L1105 Cortex-M0+
> MCU for ADC, 512MB RAM, and a LiPo Battery charger.
> 
> https://www.beagleboard.org/boards/pocketbeagle-2
> https://openbeagle.org/pocketbeagle/pocketbeagle-
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Andrew Davis <afd@ti.com>
> CC: Roger Quadros <rogerq@kernel.org>
> CC: Siddharth Vadapalli <s-vadapalli@ti.com>
> CC: Judith Mendez <jm@ti.com>
> CC: Andrei Aldea <a-aldea@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> CC: Ayush Singh <ayush@beagleboard.org>


Please run make dtbs_check and fix the reported issues. Eg.:


+arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts: /bus@f0000/pinctrl@f4000/main_i2c2-default-pins: Character '_' not recommended in node name

[...]

> ----- 
Regards
Vignesh
https://ti.com/opensource


