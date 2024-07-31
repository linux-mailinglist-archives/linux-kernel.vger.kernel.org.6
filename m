Return-Path: <linux-kernel+bounces-269471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BEF943324
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE9A1F27F36
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3D1BC06F;
	Wed, 31 Jul 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="do5Z5tqJ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB44156CF;
	Wed, 31 Jul 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439406; cv=none; b=XgN/s0HG7sw54vEty2M+IABXWfHNv+YqGuOc4eLxMbvmfFo9XTl7PysjlCzNEaUeKHcnljVUc5NhnsSZ9/3olPFA/Dl+iVWuCEdk+0YL086EJKNMFx/QhaKfJ8BCDjgMDG+lXXRUifHdMiUmdVDBrEkBaGtOjky+hbBKdyz0h6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439406; c=relaxed/simple;
	bh=qIp6I6CpAqbz+w+CRsjA5oqG64vaK3fyMQBl1G4M4ug=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1T3NeYghxHrWEwlbN5lMT19+hR845nhXeKvb8M4MMXx5x/4QIWM/XZlqsa7WsabbVTW78C0DA6O2Dt3JSxDYNnLNWUz8dELgHVdJUKSIFW5vQnZ9O6a9/FEnBduh7sH832UXlj8SWIr0G2lWZUQ58/hXPZ7dPj5lO5MrTcK2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=do5Z5tqJ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VFNIvR083835;
	Wed, 31 Jul 2024 10:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722439398;
	bh=Lgz2SLGxblgG5CcNz/x/+H9wxPBuWgS7I3mQes6hsjI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=do5Z5tqJJxtjwn2EEfha9RRjP2mvqnDDzD6NI50X8pI9lCzMb3q269xydboqC0AeN
	 C/dHpcY/xDIXYPFr4qXeKU+fpQMmg3GDoSTO7VnAOq65bzMgpt7sV51X8FBMOfs6mV
	 n0A5qmS3w2AhHNbXePXt8mz/PWpgU4Y//4K5p85w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VFNIqK049998
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 10:23:18 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 10:23:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 10:23:18 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VFNHlY084652;
	Wed, 31 Jul 2024 10:23:18 -0500
Date: Wed, 31 Jul 2024 20:53:17 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: Add support for J742S2 EVM board
Message-ID: <20240731152317.yuiqvznm524rpmjb@uda0497581>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-3-6aedf892156c@ti.com>
 <973c244e-77e6-4c60-ac17-b7a4ffe85488@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <973c244e-77e6-4c60-ac17-b7a4ffe85488@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 09:46-20240731, Andrew Davis wrote:
> On 7/30/24 2:13 AM, Manorit Chawdhry wrote:
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
> > ---
> >   arch/arm64/boot/dts/ti/Makefile                  |    3 +
> >   arch/arm64/boot/dts/ti/k3-j742s2-evm.dts         |   26 +
> >   arch/arm64/boot/dts/ti/k3-j784s4-evm-common.dtsi | 1436 +++++++++++++++++++++
> 
> Seems git is not seeing that this is a copy.
> When you do format-patch try using "-C".

Am using b4 for sending patches.. though I think there are some delta
changes as well so maybe that's why it ain't picking up. I think will
try to do it similary to j722s and am62p split up to make it clear for
the changes happening as well.

Regards,
Manorit

> 
> Andrew

