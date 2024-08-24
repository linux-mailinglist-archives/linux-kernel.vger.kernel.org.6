Return-Path: <linux-kernel+bounces-300137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505AC95DF41
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC991F21D47
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6771D4F8A0;
	Sat, 24 Aug 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kB9Kqcrb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B652F70;
	Sat, 24 Aug 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724521429; cv=none; b=rtvQBSEavhf0ikPw7xXQNSV5DscqZUBzsDk0KDwVU6oYAAqUQJ9GshxwBjGlss236DTqDpBCqzOncDt0qEq9gw9Fa3FuvBX/K27IRdNbOwO/eYHG8BgGTOdDCO56TRjnu3CEyTLNn+8Yz3Sa9PzsXVeWN7BLFmNUx2+Djpu5Qj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724521429; c=relaxed/simple;
	bh=bMZKFkv+aFda24g4rrkG8sDs67ykIpVj05RBn/gBGSc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+dS0Ko5OaFs0PPAaJVsd2zduA5YY4D1/VeEnR1HYBJu0V9Emnhjlg6KwOS4LIhyO7L1o2LF6luDbyiKNiN01uzcLEjHuxExpmATWSdsdwpvm3KI1HIH7uMz6Ll12Qju6BCzo/5qm/aSnAokYFYRhoFofBLqQqFXeYNrKqZCZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kB9Kqcrb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OHhbUd103967;
	Sat, 24 Aug 2024 12:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724521417;
	bh=Gp/NUbYXSsoQpGp1zfrN2LKF0Gk+QIV6vZXm7AxRW/k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=kB9KqcrbvFyNVxsdRp9Wq6VoARY2i6nUYfsi/GsNfZd/H2gdvkPMwQLQFb53+S/gk
	 jRwm6kCqXynEzA7bvBeUmttnBH2p21MRKoDF032iLbTM1aAnFDJB3mCEQ0MpxEDFA9
	 cjhCondd/fgFgBhyoTk2ni1x8XDgiscB2slnkkbI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OHhbEH040417
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 12:43:37 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 12:43:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 12:43:37 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OHhbnA029666;
	Sat, 24 Aug 2024 12:43:37 -0500
Date: Sat, 24 Aug 2024 12:43:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <jm@ti.com>, <vigneshr@ti.com>
Subject: Re: [RESEND PATCH] arm64: dts: ti: k3-j722s-evm: Add support for
 multiple CAN instances
Message-ID: <20240824174337.lixnpedg24qaroxs@headed>
References: <20240808082030.2812216-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240808082030.2812216-1-b-kapoor@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13:50-20240808, Bhavya Kapoor wrote:
> CAN instances 0 and 1 in the mcu domain and 0 in the main domain are
> brought on the evm through headers J5, J8 and J10 respectively. Thus,
> add their respective transceiver's 0, 1 and 2 dt nodes as well as
> add the required pinmux to add support for these CAN instances.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> Reviewed-by: Judith Mendez <jm@ti.com>
[...]

> +&main_mcan0 {
> +	status = "okay";

NAK: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	phys = <&transceiver2>;
> +};
> +
> +&mcu_gpio0 {
> +	status = "okay";
> +};
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

