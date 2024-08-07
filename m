Return-Path: <linux-kernel+bounces-277841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FB794A73C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D1D1F23DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DB21E4EE6;
	Wed,  7 Aug 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HuUiNN7Q"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1C1DE853;
	Wed,  7 Aug 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031510; cv=none; b=jAAE/2jSrJg8TNsErP1QPEb24r7g11etV0QhuP+jRpfQMbY3RCnoZoPJwNVYxc8QD0nitgJt6mEgvAuDrp3kR0QEiJ5Hl5GbiDeTXyyGbz3iJ3Dvp7CnklmmLfpzBjQ1RzPBlaJBkMdRLARu/3fN765fPkBu2SA0fyp1EsoGSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031510; c=relaxed/simple;
	bh=ricqmvVyhjO3LrUm4YWc9eB5UM1yCNXLm82v95Y8TWQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqVNEGEEX0gLvyJPJn+oC+HEWXSZ0Lnnq8qmzVA3RPj7vXWyOngu8FfLJS0+tq9UBtAWXG9fO2XwQML5Hl9qIoTaHekn0WOIJRYjOCyy7wDe4Tmbj36QPL7NeNlIXZXtMe+NV2wFdQsXbKudsAgIL/lD3JowSGlh3JsGe1UZAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HuUiNN7Q; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477Bphei072483;
	Wed, 7 Aug 2024 06:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723031503;
	bh=dS084kMqwvg+JoJcqXzOFrKeTJVNdjILpBFWHjo0oZ0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HuUiNN7Qr0k8B7yw6OoLUldTg4GBwuR1hkCFEUee3heLX679ZacCoooBJKjm48KcG
	 t4JK74hxEldMcdXl0+U5+1XBipQXvrWvbZtx6td3+yFMQ+ajsKPtcmUs88KttdE76B
	 EyAAIU3+JoVMSNhQTMZNnMcA3vEaw1RkhS+KqXqM=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477Bph5x079221
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 06:51:43 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 06:51:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 06:51:43 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477Bpg2r112069;
	Wed, 7 Aug 2024 06:51:42 -0500
Date: Wed, 7 Aug 2024 06:51:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: Re: [PATCH v3 9/9] arm64: dts: ti: Add support for J742S2 EVM board
Message-ID: <20240807115142.gzts7kprtdhrpcy5@overdrawn>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
 <20240731-b4-upstream-j742s2-v3-9-da7fe3aa9e90@ti.com>
 <489a9116-0e13-456f-992f-3e265acd9253@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <489a9116-0e13-456f-992f-3e265acd9253@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:11-20240807, Beleswar Prasad Padhi wrote:
> Hi Manorit,
> 
> On 31/07/24 22:40, Manorit Chawdhry wrote:
> > J742S2 EVM board is designed for TI J742S2 SoC. It supports the following
> > interfaces:
> > * 16 GB DDR4 RAM
> > * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
> > * x1 Input Audio Jack, x1 Output Audio Jack
> > * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> > * x1 4L PCIe connector
> > * x1 UHS-1 capable micro-SD card slot
> > * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
> >    UFS flash.
> > * x6 UART through UART-USB bridge
> > * XDS110 for onboard JTAG debug using USB
> > * Temperature sensors, user push buttons and LEDs
> > * x1 GESI expander, x2 Display connector
> > * x1 15-pin CSI header
> > * x6 MCAN instances
> > 
> > Link: https://www.ti.com/lit/ug/sprujd8/sprujd8.pdf (EVM user guide)
> > Link: https://www.ti.com/lit/zip/SPAC001 (Schematics)
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> 
> 
> For series,
> Reviewed-By: Beleswar Padhi <b-padhi@ti.com>

Please follow the convention - if you are acking the series, reply to
the cover-letter such that tools like b4 can pick it up, else this ack
belongs to the current patch.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

