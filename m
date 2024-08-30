Return-Path: <linux-kernel+bounces-308872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E997B9662F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6C21F24435
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B31ACDF9;
	Fri, 30 Aug 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RcKRJj/3"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076C19992E;
	Fri, 30 Aug 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024627; cv=none; b=qxq2bfJMOH4Y4hKiLNbhfU92uCezpVMCdLDJaZf3YTulo70/D/Thy5doz2tgZaQ5TB1fOWnJdFoyZLADiDYAp7GiyDXKDdd8chRFd+DDElq88uFbq6ms4x+NuhinZYLoVWOTZKByFLFKa0ZcXGTztVUUmbrgv1BN5j2sEntB5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024627; c=relaxed/simple;
	bh=akX9i3Y6YtjIaJLO68HWJOg04kx/lPLhkR4q/41kdMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pc2RNjgBEnOTMGKoBAy8BNDm0gkiOdBY3cyNv5rS35u6vLbuEM7FXnqy6mGCB4uE/tk4IBfG4nezm4yPsV3PadEpb/ufu1ey87Q4LEA8qjTlJnaljqZljy4jAaALUueg6I/Lz35wc8XBPQeIilhh+jGIgLWcbNJHTXdietVkYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RcKRJj/3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UDUFb0012666;
	Fri, 30 Aug 2024 08:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725024615;
	bh=zijsqgcnQrWmj900qtVdBFJMu40Rzgd2539slK46iqE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RcKRJj/3Sd6OAmSgok2Gmaf/EAnG3FkCrw8csYr7ks31yVr89emOhI7w3Io1Wdimq
	 aDkudWWMokhFkKv8rwfihUAzOUE9aO5Ruy0tnMe7bn6gLNmdjz+YQYclVGrqCPW+wX
	 D3cMx9J5qgko4ilvyqSZOSHqxzWRU7BTcmNXx9MI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UDUFwc054299
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 08:30:15 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 08:30:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 08:30:15 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UDUAN4057042;
	Fri, 30 Aug 2024 08:30:11 -0500
Message-ID: <c2568770-c80c-44d6-b3d5-a1a18f213d42@ti.com>
Date: Fri, 30 Aug 2024 19:00:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] arm64: dts: ti: Refactor J784s4 SoC files to a
 common file
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        <u-kumar1@ti.com>
References: <20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com>
 <20240828-b4-upstream-j742s2-v5-1-9aaa02a0faee@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240828-b4-upstream-j742s2-v5-1-9aaa02a0faee@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Manorit

Overall series looks ok but few comments below

On 8/28/2024 4:44 PM, Manorit Chawdhry wrote:
> Refactor J784s4 SoC files to a common file which uses the
> superset device to allow reuse in j742s2-evm which uses the subset part.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  150 ++
>   .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2667 ++++++++++++++++++
>   ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
>   ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2847 +-------------------
>   arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  135 +-
>   6 files changed, 2914 insertions(+), 2887 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
> new file mode 100644
> index 000000000000..43fee57f0926
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Device Tree Source for J784S4 and J742S2 SoC Family
> + *
> + * TRM (j784s4) (SPRUJ43 JULY 2022): https://www.ti.com/lit/zip/spruj52
> + * TRM (j742s2): https://www.ti.com/lit/pdf/spruje3
> + *
> [..]		 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
> +			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
> +			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
> +			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIe0 Core*/
> +			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe1 Core*/
> +			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x00800000>, /* PCIe2 Core*/
> +			 <0x00 0x0e800000 0x00 0x0e800000 0x00 0x00800000>, /* PCIe3 Core*/


PCie2 and PCIe3 ranges are not common across these devices,

Do you want to move this into J784s4 specific file

Same comment for PCIe region DAT below

> [..]

> 			 <0x42 0x00000000 0x42 0x00000000 0x01 0x00000000>, /* PCIe2 DAT1 */
> +			 <0x43 0x00000000 0x43 0x00000000 0x01 0x00000000>, /* PCIe3 DAT1 */

[..]

+#include "k3-j784s4-j742s2-main-common.dtsi"
> +#include "k3-j784s4-j742s2-mcu-wakeup-common.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> [...]
> +
> +&cbass_main {
> +	msmc_ram: sram@70000000 {
> +		compatible = "mmio-sram";
> +		reg = <0x00 0x70000000 0x00 0x800000>;

Table 2-1 of J742S2 TRM says msmc RAM is 4MB and on J784S4 this is 8MB

Please see, if you can address that


> [...]
>

