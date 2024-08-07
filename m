Return-Path: <linux-kernel+bounces-277567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D285D94A318
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6945EB2E4A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2C01C9DCF;
	Wed,  7 Aug 2024 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SWLl9mL2"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4692868D;
	Wed,  7 Aug 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019733; cv=none; b=b8Ib4R/wUabAFmt2hpGLuqHAeXwEeVSsZrQ6MWK1NM1dJfrta6TGn8WvuUGXbgyvWK1PrEpm7zMzH0kZiUAHE6qvnB+wUrVzVT0tkaf7LSo6oU6GUXGjLUrY+xn0D+01K31vRGpuQZW9/GHIIfZ1xovTQ8M/9Zc1AX2OMdXjaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019733; c=relaxed/simple;
	bh=hiDgDVwokVQeOjkS2BQGTUYHONZ7ZMc30SoWK70Sq4g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+9+mzxMUe6RW14ySBEr003c+tKp3scb8XRsEK6/UwR0eaPR7dyxfguJ91DS1qDR9dQdv7ZzbuuHlGxk0WUld0lnPGoRsCj+pLsrvr2zSGdEHqrznuVoU6vMLMV76xg4wp01r5LkR18jVocZFWWZZGwgo1XK84jTT2gf3jMPEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SWLl9mL2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4778ZPdi077138;
	Wed, 7 Aug 2024 03:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723019725;
	bh=fAOaZ4xLnSP5PmMNCdPVZTx2+2zABh1UiuzK+zbMX3o=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=SWLl9mL27HqUtB29m/w3IrTL/80Aun6O4w8ZZiCXi7spdi9hLkEOT/tsnKY87exT/
	 hSvtZFOK8hfY4LT7d3O09xxIOLK1M+Ui6h0MiL3RbJWOXm7p1TBvtBWWLHYPtB4vtX
	 PtwKDNaijQxZJjxZfSlWPXQW5Tpy6GMUzga2JKZE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4778ZPI4104735
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 03:35:25 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 03:35:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 03:35:25 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4778ZOP9073056;
	Wed, 7 Aug 2024 03:35:25 -0500
Date: Wed, 7 Aug 2024 14:05:24 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 4/5] arm64: dts: ti: k3-j721e*: Add bootph-* properties
Message-ID: <20240807083524.4ybzvvwch7e5jwck@uda0497581>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-4-9bc2eccb6952@ti.com>
 <f042927d-b502-4124-aaee-4bddd94b8bf2@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f042927d-b502-4124-aaee-4bddd94b8bf2@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit,

On 13:07-20240807, Kumar, Udit wrote:
> 
> >   	};
> >   	vdd_mmc1_en_pins_default: vdd-mmc1-en-default-pins {
> > @@ -622,6 +627,7 @@ J721E_WKUP_IOPAD(0xf4, PIN_OUTPUT, 2)/* (D25) MCU_I3C0_SDA.MCU_UART0_RTSn */
> >   			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
> >   			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0)/* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
> >   		>;
> > +		bootph-pre-ram;
> 
> 
> Please make consistency between pin mux and node.
> 
> Here I see pin mux is bootph-pre-ram and mcu_uart is bootph-all

Do we want it to be bootph-pre-ram or bootph-all?

Regards,
Manorit

