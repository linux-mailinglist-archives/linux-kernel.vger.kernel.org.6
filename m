Return-Path: <linux-kernel+bounces-430730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC39E353A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F16EB2FBFB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AC5197521;
	Wed,  4 Dec 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JfPDQira"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF618E368;
	Wed,  4 Dec 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298734; cv=none; b=MqY1K/Kzv/QHsP/u3HXz6mkHXBN36U1URRN9MQ8ZIgGTGu+eMJTyZ4ltPgs8SgLpfAlB31Bua+zLiv/SY1usw7XL6ntfhd8UPGiyNT23/QzwA554k+yjZs/6wX0BAFxd53VWRQ6PTway3bXOsPHmsKU08J3q88ORJwUh+Ekd+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298734; c=relaxed/simple;
	bh=O/unXNLcf1eONeSIFuIlI3mgX9zgjQWIx/EDoMBp9mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hz37ksNGrECkQvqwD7OxAPWN6T7bzgsx4fmr4wMh/9qX3HyhIBEfCsWsT8viBsqu5IkhhyiqB+EkGnmXnBRASYIoM89r9lqrEP9RSyER3ING1XBECVADNMV6ZEu4Ys7pvdnKrKtp8cjx08Vm8iuxkOh3CgIhSjUskI4TtZ3qfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JfPDQira; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B47q32M1757814
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 01:52:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733298723;
	bh=qvLdxoCg2whNqusOckWdCk+BimF7TYRi9/jur9YYrOk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JfPDQiraJHbcleiFqbXaEJfok7m5INVrjh5UfBgZ3uhz5Dw/Yo5U953pAlOcNf5Uy
	 QgTQ0lWT4j3IdaKEn+8t0TXiqgpLY1YDFR2wJTWwKZAVEWWvaME2ADQuIPVFPwR73/
	 kNP6U8NrWaBg59gXw9AC2MrSqzKMzHdb3loJnO/Q=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B47q3b9012229
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Dec 2024 01:52:03 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Dec 2024 01:52:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Dec 2024 01:52:03 -0600
Received: from [10.24.69.37] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B47q0QJ114667;
	Wed, 4 Dec 2024 01:52:00 -0600
Message-ID: <e280d338-d05d-4910-8017-bc121eb2b94b@ti.com>
Date: Wed, 4 Dec 2024 13:21:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] arm64: dts: ti: k3-j7*: Add missing ESM and
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>
References: <20240425211233.2006233-1-n-francis@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240425211233.2006233-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vignesh,

Pinging on the below old patch series, applies cleanly with 3-way merge on the 
latest tip as well, so should be okay to pick up if all looks fine.

On 26/04/24 02:42, Neha Malcom Francis wrote:
> Add missing ESM and watchdog nodes for the sake of devicetree completion
> of hardware description w.r.t Linux and ESM and WDT enablement on
> U-Boot. This patch series adds the missing nodes for J721E and J7200.
> 
> Boot logs (updated for v3):
> https://gist.github.com/nehamalcom/5dc94ab60f57df5d515d0a6d0da6e0d1
> 
> Changes since v3:
> - added patch (6/6) for adding bootph-pre-ram in main_esm nodes (Udit)
> - no change to boot logs
> 
> Changes since v2:
> https://lore.kernel.org/all/20240412042537.666137-1-n-francis@ti.com/
> - corrected register size for MCU watchdog instance in J7200 (Udit)
> - added Reviewed-by tag (Udit)
> 
> Changes since v1:
> https://lore.kernel.org/all/20240326122723.2329402-1-n-francis@ti.com/
> - modified node name numbering to be in sync with TRM (Udit)
> - disabled wkup_esm node in J721E (Udit)
> - added patch (5/5) for MCU domain watchdog instances in J7200 (Udit)
> Neha Malcom Francis (6):
> 
> arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM instance
>    arm64: dts: ti: k3-j721e-mcu: Add the MCU domain watchdog instances
>    arm64: dts: ti: k3-j721e-main: Add the MAIN domain watchdog instances
>    arm64: dts: ti: k3-j7200-main: Add the MAIN domain watchdog instances
>    arm64: dts: ti: k3-j7200-mcu: Add the MCU domain watchdog instances
>    arm64: dts: ti: k3-j7*-main: Add bootph-pre-ram to main_esm
> 
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 28 ++++++
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 26 +++++
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 94 +++++++++++++++++++
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 32 +++++++
>   4 files changed, 180 insertions(+)
> 

-- 
Thanking You
Neha Malcom Francis

