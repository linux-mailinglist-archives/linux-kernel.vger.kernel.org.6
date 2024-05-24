Return-Path: <linux-kernel+bounces-188341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D069E8CE0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AB71F22362
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E962127E12;
	Fri, 24 May 2024 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hkzkAajU"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620679C2;
	Fri, 24 May 2024 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530012; cv=none; b=AudmKdpfbth9SYdkrkUVnySnT+C3LHrF841OA1VqDwKdj0jG3EoFnmvlw0jWLRXTW6fvFLL1UBBKOWUd9hbKDhzM4Xhwy2OAnqiAIONv8O2mPpvXDw+XEZJBk4zFJ8wlQzHsoO67G7aZmGDIO7gUeAH7bdiPigAL5kFeH+4aVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530012; c=relaxed/simple;
	bh=H8npqMwID4pfmdaJLNhSHP8/yv54+1xtyOq3CfT0xfg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnvposnvWg6FoZ1U1HxvJB07j621HHU73/y+jrNeZXlrPWOAwUfrMKH1LUdGjCf8W79eqv9M/4YJLZFGjj2MX4hVeNoRWcWmydDjwxZTY2JFzC71quPuW4uojY7w5iy4yiqJi5BCuZNbnayVYXCpon4P/qP7NLaMELfUCdCE9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hkzkAajU; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O5rILX124606;
	Fri, 24 May 2024 00:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716529998;
	bh=lGxYBCLxmX2ZWX3mJfP+oA7+obI5xWS4wKTh6CJnmEo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hkzkAajUgp5qsdAGRw24YFxfz5cdXHzPPi9/6yQij/Q7U2tLqwBrlPLeEJYOncPpv
	 1mMAw+UM7dhE6M7aFm3iCBPYed8MiPrjIHFKM5cORru6foHT/dds8w6RNKTwnPTsNw
	 R20uoGcq/mVO+sbo3cTPdWYI5EhtvB3ygXkD8YJ0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O5rIu9016822
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 00:53:18 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 00:53:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 00:53:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O5rH1M083772;
	Fri, 24 May 2024 00:53:17 -0500
Date: Fri, 24 May 2024 00:53:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] firmware: ti_sci: Partial-IO support
Message-ID: <20240524055317.cnaodgiksxmvjnr2@sullen>
References: <20240523080225.1288617-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523080225.1288617-1-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:02-20240523, Markus Schneider-Pargmann wrote:
> Hi,
> 
> Partial-IO is a poweroff SoC state with a few pingroups active for
> wakeup. This state can be entered by sending a TI_SCI PREPARE_SLEEP
> message.
> 
> The message is sent on poweroff if one of the potential wakeup sources
> for this power state are wakeup enabled. A list of potential wakeup
> sources for the specific SoC is described in the devicetree. The wakeup
> sources can be individually enabled/disabled by the user in the running
> system.
> 
> The series is based on Andrew Davis accepted patches:
>   [PATCH 0/4] Unconditionally register TI-SCI reset handler
>   https://lore.kernel.org/lkml/20240326223730.54639-1-afd@ti.com/
> 
> This series is part of a bigger topic to support Partial-IO on am62,
> am62a and am62p. Partial-IO is a poweroff state in which some pins are
> able to wakeup the SoC. In detail MCU m_can and two serial port pins can
> trigger the wakeup.
> 
> These two other series are relevant for the support of Partial-IO:
> 
>  - serial: 8250: omap: Add am62 wakeup support
>  - can: m_can: Add am62 wakeup support

In future, please provide the lore url to the dependency patches (I
understand you were probably posting them back to back, but if you wait some
10-15 mins after the dependent series are posted, they will appear in
the lore.kernel.org and you could provide those links). That would save
us maintainers having to lookup based off subject line.

> 
> A test branch is available here that includes all patches required to test
> Partial-IO:
> 
> https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-lp-sk-partialio/v6.9?ref_type=heads
> 
> After enabling Wake-on-LAN the system can be powered off and will enter
> the Partial-IO state in which it can be woken up by activity on the
> specific pins:
>     ethtool -s can0 wol p
>     ethtool -s can1 wol p
>     poweroff
> 
> I tested these patches on am62-lp-sk.
> 
> Best,
> Markus
> 
> Markus Schneider-Pargmann (5):
>   dt-bindings: ti, sci: Add property for partial-io-wakeup-sources
>   firmware: ti_sci: Partial-IO support
>   arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
>   arm64: dts: ti: k3-am62: Add partial-io wakeup sources
>   arm64: dts: ti: k3-am62a: Add partial-io wakeup sources
> 
> Vibhore Vardhan (1):
>   arm64: dts: ti: k3-am62p: Add partial-io wakeup sources
> 
>  .../bindings/arm/keystone/ti,sci.yaml         |   6 +
>  arch/arm64/boot/dts/ti/k3-am62.dtsi           |   4 +
>  arch/arm64/boot/dts/ti/k3-am62a.dtsi          |   4 +
>  arch/arm64/boot/dts/ti/k3-am62p.dtsi          |   4 +
>  arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +
>  drivers/firmware/ti_sci.c                     | 135 +++++++++++++++++-
>  drivers/firmware/ti_sci.h                     |  31 ++++
>  7 files changed, 186 insertions(+), 1 deletion(-)
> 
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

