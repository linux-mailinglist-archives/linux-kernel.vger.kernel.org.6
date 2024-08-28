Return-Path: <linux-kernel+bounces-304883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3DE962637
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABC22821E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C74A171E49;
	Wed, 28 Aug 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YbinkGXp"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DF3FEC;
	Wed, 28 Aug 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845214; cv=none; b=uWf7Rfmc4G2tFXt7pHa6g2utjh/Xq2Rn8hSFnv2jrKR1k63YeOJNwNCFOZu8PpNeeQ2B3IFC2Ip2biArM9qMh9qF5hoTlWbbs32vXKnfHHhuw2XNMHiAJ/gG2eiue9AAcbqkwCoRS1VblFNVBFKuG90oOnQ+UWHfEg10BOMgoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845214; c=relaxed/simple;
	bh=ELemZZZnsZftM63/e6cG2c7KGh59IznG1HU0lk6baMg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqA1WuvowkSqhlxgYa2SvS+lvJwYEiLop+TxAl3bsaiU4x7kSpNsj1MNla2iulhKUElgOFLt3TnXRnH8LNn292EN/56vd5k2QaT84N9VCCWOU33EliEDt4+Myu0tq6ytfuqZLjrWED+BqFmHffhMpXhUl31ANM47scm/TUuY8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YbinkGXp; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SBe6tq114076;
	Wed, 28 Aug 2024 06:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724845206;
	bh=WHidzx9hkGROCHhuKZARBqdGMwVAMnyTXFGOZlH9G7s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YbinkGXp+/+nmsePGQErzntJu+R2quk+x5Y6rR+BevTMw4jyOktgC+aefgsFnBe9r
	 wsrRx8euiiUq/79aimwv3zHL1LMUFbEqnelfP/EnyP9hguyawhqKjbeVYn9QR9J6yA
	 Yqljja/3jyM5L4V2OHugTMoKClOqH9KZZGrwDtXI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SBe62x062141
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 06:40:06 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 06:40:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 06:40:06 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SBe6iV025132;
	Wed, 28 Aug 2024 06:40:06 -0500
Date: Wed, 28 Aug 2024 06:40:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <u-kumar1@ti.com>,
        <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-j722s-main: Add R5F and C7x
 remote processor nodes
Message-ID: <20240828114006.c6jasbkvdmrgvfrb@uniquely>
References: <20240828112713.2668526-1-b-padhi@ti.com>
 <20240828112713.2668526-2-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240828112713.2668526-2-b-padhi@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:57-20240828, Beleswar Padhi wrote:
[...]

> +		main_r5fss0_core0: r5f@78400000 {
> +			compatible = "ti,am62-r5f";
> +			reg = <0x78400000 0x00008000>,
> +			      <0x78500000 0x00008000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <262>;
> +			ti,sci-proc-ids = <0x04 0xff>;
> +			resets = <&k3_reset 262 1>;
> +			firmware-name = "j722s-main-r5f0_0-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

Please keep the dts coding style for vendor prefix and generic
properties in mind. resets and firmware-name are generic
properties.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

