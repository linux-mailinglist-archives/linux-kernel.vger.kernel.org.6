Return-Path: <linux-kernel+bounces-269397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37C943265
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDCE287553
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869801B3746;
	Wed, 31 Jul 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TBsn/Eul"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C9186E4F;
	Wed, 31 Jul 2024 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437206; cv=none; b=f2hiKw5IzEnw+LMP4dxzyrbbNoWGccl9oCoK9uMPLQM+mzJIjh4dqGGRnzeGFrrlGHy/jF1ufVomF72EC167YmpLzOkHcuFh3ZmUPybdnUAFHwsp6p1TT9UEvPFtbW+X7WKJqyjOHgiplHPpLyx3aQ7Z9VSi2Nb+6ZzJnqhohBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437206; c=relaxed/simple;
	bh=XYTGwxefE7IJiw1vgYl48iiTnE2rbcE4C6iZxp4paSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LnSTWjn93Invkm4QW0+/oYDZysl039BpUKuBdR4mVMszoJ6ZAlQMfrAAbobTuPj+4zD0BqZY8zyHjkU48PR5++Wk+em02Efcs+Urhg9mcM2tV8EeC8PVd/AZxmO9j5PTqbirY71QDZpBQzhji/TbXco2G+CJGJ5T+8xkFHHsogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TBsn/Eul; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VEkau0069781;
	Wed, 31 Jul 2024 09:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722437196;
	bh=4l40MDd6rjvVR6vMWH2LvbD2nRR9R+2ADS7N2/1ea7U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TBsn/EulsatUUAU3LV8R/lurWekHmBh+VAMkH4rlGtcgzVmgCv1IP416kLfGFRWZ+
	 AFcmYHwLGm/jbmK+7Yy4Jbgey/AiP536er/NfW29lMk/YvBq7r5eMULRMR4nUhW7/E
	 SLabdsraj0sX6Ja1PGvqgK0Zy9zeGz82FxBkCn9w=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VEkaeq029048
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 09:46:36 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 09:46:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 09:46:35 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VEkZnH079606;
	Wed, 31 Jul 2024 09:46:35 -0500
Message-ID: <973c244e-77e6-4c60-ac17-b7a4ffe85488@ti.com>
Date: Wed, 31 Jul 2024 09:46:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: Add support for J742S2 EVM board
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-3-6aedf892156c@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240730-b4-upstream-j742s2-v2-3-6aedf892156c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 7/30/24 2:13 AM, Manorit Chawdhry wrote:
> J742S2 EVM board is designed for TI J742S2 SoC. It supports the following
> interfaces:
> * 16 GB DDR4 RAM
> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
> * x1 Input Audio Jack, x1 Output Audio Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> * x1 4L PCIe connector
> * x1 UHS-1 capable micro-SD card slot
> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>    UFS flash.
> * x6 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * x1 GESI expander, x2 Display connector
> * x1 15-pin CSI header
> * x6 MCAN instances
> 
> Link: https://www.ti.com/lit/ug/sprujd8/sprujd8.pdf (EVM user guide)
> Link: https://www.ti.com/lit/zip/SPAC001 (Schematics)
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile                  |    3 +
>   arch/arm64/boot/dts/ti/k3-j742s2-evm.dts         |   26 +
>   arch/arm64/boot/dts/ti/k3-j784s4-evm-common.dtsi | 1436 +++++++++++++++++++++

Seems git is not seeing that this is a copy.
When you do format-patch try using "-C".

Andrew

