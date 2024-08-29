Return-Path: <linux-kernel+bounces-307446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD64964DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64E71F224B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242A1B86F4;
	Thu, 29 Aug 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y5+/oOah"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569A1AE87D;
	Thu, 29 Aug 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956323; cv=none; b=EIQqmB52sDm34+mFV/AluqC+3bpZlcaDtZZ0RpMTPLNIhNleEJDbl36k+/V3/gEcNogY3XXUc3Y1LqEY780+8EQY882iIh107gySzip+zTSsuGIGnXBJj9j9St4C+/5JfG5JUB2/QExvgsQLOVTNvV7h8Q1VHzQ77EK4qDrSIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956323; c=relaxed/simple;
	bh=E1dL+m4Y3pjB3l/ly+oFrHp9rLfn/fMWKjGupxbtgHg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIbtWgTymxFNi7zsVcqR+7Wa14hriPcYPWG9G3mtWDRRe9DGBK12HK0ux719vB/Vj90DAJud/RwsYLRWyTJo/orS/xP7ZkP6n2pP1ZO3DXw1Re24qtm22HT/VH5uxzAgkE+QsM2Ws+6kAb6WoqAk0ivwlsTRbG1w+ItazlFQHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y5+/oOah; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TIVtoq123187;
	Thu, 29 Aug 2024 13:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724956315;
	bh=AfF050ET3/as3Io6OIzxN03aKX5m/WZW22J++N4SfmI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=y5+/oOahHmAEv/Kov3eThYXrUDRNt3+lyFkA72A9lCC0LsdUBxEG/rHCMzoyf26MK
	 3a5O9giX1BeNaf/I+rwwhatdASfJeT1lWHupAZn4YvOZt7KgsEkpbtVTwxv4gGoTVX
	 IJ3QyjmE2pcfFT/ISeT6mJOlm7PiyDHzXAWXvV60=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TIVtju086955
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 13:31:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 13:31:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 13:31:55 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TIVtmZ107221;
	Thu, 29 Aug 2024 13:31:55 -0500
Date: Thu, 29 Aug 2024 13:31:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Aniket Limaye <a-limaye@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mranostay@ti.com>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
        Jared McArthur
	<j-mcarthur@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix register map for main
 domain pmx
Message-ID: <20240829183155.dpaia4koseebgmdm@sudoku>
References: <20240829071208.2172825-1-a-limaye@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829071208.2172825-1-a-limaye@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:42-20240829, Aniket Limaye wrote:
> From: Jared McArthur <j-mcarthur@ti.com>
> 
> Commit 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux
> range") split the main_pmx0 into two nodes: main_pmx0 and main_pmx1
> due to a non-addressable region, but incorrectly represented the
> ranges. As a result, the memory map for the pinctrl is incorrect. Fix
> this by introducing the correct ranges.
> 
> The ranges are taken from the J7200 TRM (Table 5-695. CTRL_MMR0
> Registers). Padconfig registers stretch from 0x11c000 to 0x11c168
> with non-addressable portions from 0x11c10c to 0x11c10f, 0x11x114 to
> 0x11c11b, and 0x11c128 to 0x11c163.
> 
> Link: https://www.ti.com/lit/ug/spruiu1c/spruiu1c.pdf (TRM)

Use the canonical link that redirects to the latest document such as https://www.ti.com/lit/pdf/spruiu1

older versions of the TRM may not be retained in ti.com

> Fixes: 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux range")
> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>  .../dts/ti/k3-j7200-common-proc-board.dts     |  2 +-
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 22 +++++++++++++++++--
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 6593c5da82c0..df39f2b1ff6b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -254,7 +254,7 @@ J721E_IOPAD(0x38, PIN_OUTPUT, 0) /* (Y21) MCAN3_TX */
>  	};
>  };
>  
> -&main_pmx1 {
> +&main_pmx2 {
>  	main_usbss0_pins_default: main-usbss0-default-pins {
>  		pinctrl-single,pins = <
>  			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */

How is this change correct if you are changing the base from 0x1c to
0x10 (previously it was pointing to 0x20, now to 0x14? what is the
correct offset of USB0_DRVBUS pin?)

Did you do an audit of all offsets of main_pmx2 and 3 and resultant
address split up (including overlays if applicable)?

Explain that in commit message / diffstat as appropriate

> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 9386bf3ef9f6..41adfa64418d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

