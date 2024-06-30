Return-Path: <linux-kernel+bounces-235107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6BC91D03A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AC11C20ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C953B7AC;
	Sun, 30 Jun 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LacBPdzE"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6A2A8FE;
	Sun, 30 Jun 2024 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719730820; cv=none; b=JA57LXf/y3/xnZ9GO7IdGFlCp88LJKGnlfESstMrz5yuDAzrB9RforLQiMDaClvZGa3AlvBD9GpAdFCwF8qVffmgnf+TIm3YMti2wYl+RbCy6tEJ/3T9crrGfvejyigrYp3W1UUD1AB1FX1T0bU2EWHGWZaUqMMfsoi9OYDhQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719730820; c=relaxed/simple;
	bh=O1HR4kHR/XCGKG4h+DwtnIPA7DGTVS7E3KxzwKw3um0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EObMNJrljN4l83ujNNJgngqAseyTyhV7BcH2tZzDh55UgebhtJP+YWOJLnG2gv8HOq8kv7Y51FRUnYh/nCUYj6ChNmXZKnVa6QAxI5mDrtC1nOf8W0hh6HrenXRVt2xRhLmHZ8gKEyu+VzShPniceAAIb5tof04gaBp4ALsidO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LacBPdzE; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45U6xs4P082744;
	Sun, 30 Jun 2024 01:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719730794;
	bh=ntcPWOA37EUEY0RyxU96QTxE6TwwDzV08Y5dI/7aLHo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LacBPdzEMaCqzUtyn695b65Hwdsv6bm4xRabWixiEppZkJYExkN/W99hJz9qTIsi5
	 9t9BXY0kBHYpdv5JOLPAakRrZwZ1EoeeY+uuQ0sCIZNReF74ipXKKe3V70D0LgPQhr
	 /BupM7GTVNnyDMpw/KshF/ABNlr6iZbvcXizezds=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45U6xsnx048361
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 30 Jun 2024 01:59:54 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Jun 2024 01:59:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Jun 2024 01:59:53 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45U6xnDA113333;
	Sun, 30 Jun 2024 01:59:50 -0500
Message-ID: <8c32591a-ada0-4183-b4d1-68ac51c65d57@ti.com>
Date: Sun, 30 Jun 2024 12:29:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] ti: fix dtbs_check for some syscon bindings and
 DTS node
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Roger
 Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, "Andrew F. Davis" <afd@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley
	<conor.dooley@microchip.com>
References: <20240626-dt-bindings-ti-soc-mfd-v2-0-ee4d69017326@linaro.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240626-dt-bindings-ti-soc-mfd-v2-0-ee4d69017326@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

+ Andrew and Bryan

Hi Krzysztof

On 26/06/24 16:53, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes in v2:
> - Add acks/tags
> - Correct Kishon Vijay Abraham email
> - Drop R/W from title of bindings
> - Link to v1: https://lore.kernel.org/r/20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org
> 
> I am in the process of fixing syscon/simple-mfd bindings (to be posted
> separately) and found set of issues in TI looking independent of my
> series.  Please apply via TI SoC.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (5):
>       dt-bindings: soc: ti: am62-system-controller: add AM62 syscon
>       dt-bindings: soc: ti: am645-system-controller: add AM654 syscon
>       arm64: dts: ti: k3-am62: add dedicated wakeup controller compatible
>       arm64: dts: ti: k3-am65-mcu: add dedicated wakeup controller compatible
>       arm64: dts: ti: k3-am62a: use a specific MCU controller compatible


Thanks for the patches!

Andrew's patches [0] remove "syscon", "simple-mfd" from all the below
files except for k3-am62-wakeup.dtsi. But I think k3-am62-wakeup.dtsi
can be fixed up in the similar way and not really need a custom
system-controller binding. Last user is "ti-cpufreq" driver which is
being adapted over to use granular syscon nodes [1].

I believe add new compatible for system-controllers nodes is unneeded?

AM62 may need one more merge window to be resolved owing to dependencies
but I am queuing [0] to get rid of the warning for rest of the dts.

Bryan,

Could you repsin [1] with cleanups to am62-wakeup.dtsi as well?

[0] lore.kernel.org/r/20240628151518.40100-1-afd@ti.com
[1] lore.kernel.org/r/20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com


> 
>  .../bindings/soc/ti/ti,am62-system-controller.yaml | 77 ++++++++++++++++++++++
>  .../soc/ti/ti,am654-system-controller.yaml         | 60 +++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |  2 +-
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |  2 +-
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  2 +-
>  5 files changed, 140 insertions(+), 3 deletions(-)
> ---
> base-commit: e032bb82c315d2317a80506195d16ce4308d8cf7
> change-id: 20240518-dt-bindings-ti-soc-mfd-ac211578d7a5
> 
> Best regards,

-- 
Regards
Vignesh

