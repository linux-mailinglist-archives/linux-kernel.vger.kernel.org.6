Return-Path: <linux-kernel+bounces-543224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13361A4D2F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D1F3ADDF5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0AE18D;
	Tue,  4 Mar 2025 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oOURtejD"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C001EEA34;
	Tue,  4 Mar 2025 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065889; cv=none; b=lvbaHMldpAVVq2b/EP0OJZijqLE9A45jtHkkKmGbSVADonP/xn5iIV9UJDv0Bx2GWs/YqhaoMPfyZu82FXUKAM9cINCOYyVvGnNArQuqNsy+73ucI+lyLf6yK74kVRpKIYe5sF4JHMaESgHSO29j04j1kLSOaCBAxT/5Eo194EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065889; c=relaxed/simple;
	bh=tAUaTNTvtI8fsyzSbHQ9v8ssaOdJoHdBeaJMCAXuFdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bm6/2nDa8iRWdg/50GISAG3Ld4AAFfuNaYclSMkfJTKWuj2q9YycjQS+jNbswODMcuVpfWCgOnz1Qrz8UAM20qsqs7cxAXeqoI+RsCxPLeATDLVl1J/7yqspaSeuG49r/nWejxdAUf1+qDg7Ba2/G/NBe2XP/QKNuV8DoYXTN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oOURtejD; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5245OORw3546015
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 23:24:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741065864;
	bh=tYxtgv8gS6hl5AADrQ7TWMvqyjIg876+xo08kj/pVYI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oOURtejDCG/0LjzIexNsHfj+4iZ3G/wMSmKYwXccmeK4UB748Go8qSk1Na9K3Nc55
	 9MldjxHdCZvIIo1DOo7Pc/5NzW/ZqdMBiRln9PB5GDzrP07Sc8GLI2kKbIAYMMOHW9
	 ZcRLrI2pULKlLfxGv+C6kJzlH0r3mUkk20w8dpTA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5245OOs3027128
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 23:24:24 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 23:24:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 23:24:23 -0600
Received: from [172.24.227.115] (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5245OJj3042162;
	Mon, 3 Mar 2025 23:24:20 -0600
Message-ID: <ed8ce158-89dd-4a81-aa70-679559d6f5b3@ti.com>
Date: Tue, 4 Mar 2025 10:54:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add J722S CSI support
To: Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <jai.luthra@linux.dev>
References: <20250218185452.600797-1-vaishnav.a@ti.com>
Content-Language: en-US
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
In-Reply-To: <20250218185452.600797-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 19/02/25 00:24, Vaishnav Achath wrote:
> This series adds support for CSI2RX capture on J722S EVM
> and enables IMX219 and OV5640 overlays to enables
> 4 sensors on EVM, this provides a reference for a user to
> enable a different sensor on any of the ports.
> 
> Test logs:
> IMX219: https://gist.github.com/vaishnavachath/60cc2ef257601f27f28a315f8cf669c4
> OV5640: https://gist.github.com/vaishnavachath/648202286d4d34d4d25f7c8c9db8b8bd
> 
> Vaishnav Achath (5):
>    arm64: dts: ti: k3-j722s-main: Add BCDMA CSI overrides
>    arm64: dts: ti: k3-j722s-main: Add CSI2RX nodes
>    arm64: dts: ti: k3-j722s-evm: Add camera peripherals
>    arm64: dts: ti: k3-j722s-evm: Add overlay for quad IMX219
>    arm64: dts: ti: k3-j722s-evm: Add overlay for TEVI OV5640
> 

For the series:
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>

>   arch/arm64/boot/dts/ti/Makefile               |   9 +
>   ...k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtso | 304 +++++++++++++++++
>   .../k3-j722s-evm-csi2-quad-tevi-ov5640.dtso   | 319 ++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts       |  28 ++
>   arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 193 +++++++++++
>   5 files changed, 853 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtso
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov5640.dtso
> 

