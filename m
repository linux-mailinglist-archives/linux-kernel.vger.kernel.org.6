Return-Path: <linux-kernel+bounces-328701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3B8978788
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8211F266AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA612E1E0;
	Fri, 13 Sep 2024 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Czqfh0FE"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958612C46D;
	Fri, 13 Sep 2024 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250888; cv=none; b=h5xU+QIRV1fgGSXy1+v4OuNZarNN8DGXoMZHEUlOvbtNLQL8/J6QzRb5Ya35D6UlgD9Fg/mRvIj7zH0q0KMZUprYiBB2K/DNZPxZ7MDP2n8Ie/joDpCKwWxWaBK9HTbMT38Vn34GTZQ9NmtaxpJl7mjrVJukixudHYpfRcU8PiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250888; c=relaxed/simple;
	bh=ojb72Ffjk93VhLheb1CEWgkxx0+qtLxx5Y/YZD7V794=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkS6q3JQWqZRjY+BQNS0BEzODeel5xFmqI2n8AY17NIEiHd3dFeTYydlxfI+QAKDT5UG1Pwi71t0ssWxXtZxHu+B8f5ABBYJTlGFOfApLsQuPxYZSJPBsJhaV9ejvN+pvmq1Jm3srwzisMovkQK1A1BK4f3cOyA9I0hDiE3k7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Czqfh0FE; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48DI7gWn089800;
	Fri, 13 Sep 2024 13:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726250862;
	bh=Fg4nfT5Q2rXpOjg2NjjXyFPmQDkUbxQkY0WYprwTWag=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Czqfh0FEOJdf7BoXAPDEGInkGvyxCjXAExHzwzZNeXcPyMuAxBBU/6/BFi+LsBYXf
	 yWrkO+3JUGK5rEwJ891rCO2UdRvjTNsSmh4naBnDh4tZfpVZjrglvyjpVBjRqTGcfr
	 bBALTJ45H8zed2+kEBYfcwL7UnSd3sJA6UoACrMk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48DI7gZ1037131
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Sep 2024 13:07:42 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Sep 2024 13:07:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Sep 2024 13:07:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48DI7fJe085800;
	Fri, 13 Sep 2024 13:07:41 -0500
Date: Fri, 13 Sep 2024 13:07:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Garrett Giordano <ggiordano@phytec.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <w.egorov@phytec.de>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH 2/2] arm64: dts: ti: Remove
 k3-am625-phyboard-lyra-1-4-ghz-opp overlay
Message-ID: <20240913180741.4ntyw4c4f66o5hgk@lifter>
References: <20240913175625.3190757-1-ggiordano@phytec.com>
 <20240913175625.3190757-3-ggiordano@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240913175625.3190757-3-ggiordano@phytec.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:56-20240913, Garrett Giordano wrote:
> Remove the k3-am625-phyboard-lyra-1-4-ghz-opp overlay. We now
> configure the a53_opp_table to include a 1.4 GHz node and set our
> VDD_CORE to 0.85v in the k3-am62-phycore-som.dtsi. This change is to
> match our PMIC which is now set to output 0.85v by default.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> ---
>  .../k3-am625-phyboard-lyra-1-4-ghz-opp.dtso   | 20 -------------------
>  1 file changed, 20 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
> deleted file mode 100644
> index 6ec6d57ec49c..000000000000
> --- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only OR MIT
> -/*
> - * Copyright (C) 2024 PHYTEC America LLC
> - * Author: Nathan Morrisson <nmorrisson@phytec.com>
> - */
> -
> -/dts-v1/;
> -/plugin/;
> -
> -&vdd_core {
> -	regulator-min-microvolt = <850000>;
> -	regulator-max-microvolt = <850000>;
> -};
> -
> -&a53_opp_table {
> -	opp-1400000000 {
> -		opp-hz = /bits/ 64 <1400000000>;
> -		opp-supported-hw = <0x01 0x0004>;
> -	};
> -};
> -- 
> 2.25.1
> 

Did you build test this? Reason I ask is because you might have missed
the Makefile edits needed?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

