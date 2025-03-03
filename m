Return-Path: <linux-kernel+bounces-544960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B716CA4E6DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBEC7AA5C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD4F298CC1;
	Tue,  4 Mar 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RBX5fAtO"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B8294EE6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105693; cv=pass; b=QElYrQ9bY/Owimf1LD25iZ24xsBrBhc6JOGBfpzyePxN1aFEGjMG2PH46km3ffliR7GMeYSnqjeEsRfDlS/1Cs30Pz+xTFu7vDTu4G1bEL2IZfFQT/Tz03qGqihyXy+ed0Yh9sY+u38Wn8bqnQ81fwNrgLM728KhNq8Gv54X1dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105693; c=relaxed/simple;
	bh=5+c/8dUp26rrw26JKWP2mXjUnDArpi3YPn5xzRkRfF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=od2WPsudY0bSlKhAvhyARoCy8KhtmOPfFj7dRQ1LmMbCRAO0JAW4PvUvwWkWFkfiZRi5xxTeHDOzulfBj9NQJG6wog6n7YLrFKOW1Iq0tgvl2in8B19uTgl8Ro+XuI3QdTK+w6G37r1Bq7YMZccxIHJ8g8cbcyV/hFcU1ZEAnrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RBX5fAtO; arc=none smtp.client-ip=198.47.19.245; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id ABD4B408B659
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:28:09 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=ti-com-17Q1 header.b=RBX5fAtO
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fry558lzG0j7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:35:30 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 081F34275C; Tue,  4 Mar 2025 18:35:27 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RBX5fAtO
X-Envelope-From: <linux-kernel+bounces-541099-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RBX5fAtO
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 8049A41BB1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:41:00 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 39B663064C07
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:41:00 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0776A16AB13
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F405CDF1;
	Mon,  3 Mar 2025 07:40:44 +0000 (UTC)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BA1EB192;
	Mon,  3 Mar 2025 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740987641; cv=none; b=ahiNVTFV0lgSaeLc6HPoWTd8YuQYjjHahfmULAXdmV6Uz/dVeXi5G+Lpc86cQT8AULYcFeXIhR5RgOnurPq1GEFIaHdyLL969PWiPe8zzqdR7jkXmrgRtv+OTIkhBKjRxmFPFXGmsCfRyIb7H+qfIUuIkh8Jw4BleG/czX6vcTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740987641; c=relaxed/simple;
	bh=5+c/8dUp26rrw26JKWP2mXjUnDArpi3YPn5xzRkRfF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QNIFSoiAq9D4wYdPSg7ZFAncTZhlxRn+o5injlLbalEsyeCMkkko9OFpCsiW1VhvwyO7Hg68BIUgUvZXOscmNgOGODJ8SWFahSrjEHbOmam1gqZmE5McT4F01fB7Jd6NJ2G75PP4jmzmqLvOIWWXyKjFUcztVL3BwwtOhglLtYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RBX5fAtO; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5237eP7M2626084
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 01:40:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740987625;
	bh=GQ1xW2NPwpJqRZbwpFeIMuaFkeaa4B6mXxYKzB9+m6E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RBX5fAtOXtag7wzZX1/8h/+h6f5p88bKSHwRSH+/JDboHIdH52smlDBb44yPjGvQf
	 1d8O++uq5j1eIMqsrVsrs2kgANSnAcU1hM3JNvZsyXCZVW6t+sGve7Alw1IBHuf6jF
	 QezRUPyF0XU8eYWWRBscDC72kUm80xvHor/CPlS8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5237ePv9099697
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 01:40:25 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 01:40:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 01:40:24 -0600
Received: from [10.24.69.250] (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5237eLjR131041;
	Mon, 3 Mar 2025 01:40:22 -0600
Message-ID: <3d01a502-47a6-467e-8743-392fde26e66e@ti.com>
Date: Mon, 3 Mar 2025 13:10:21 +0530
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: ti: k3-am62a-phycore-som: Add boot phase
 tags
To: Wadim Egorov <w.egorov@phytec.de>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20250228101817.865811-1-w.egorov@phytec.de>
 <20250228101817.865811-2-w.egorov@phytec.de>
Content-Language: en-US
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20250228101817.865811-2-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fry558lzG0j7
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710371.71837@K6hYQwaxUaj0aLH755aHuw
X-ITU-MailScanner-SpamCheck: not spam

Hi Wadim

[...]

On 28/02/25 15:48, Wadim Egorov wrote:
> @@ -168,6 +174,7 @@ &cpsw3g {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_rgmii1_pins_default>;
> +	bootph-all;

One of the child nodes have bootph-all, so drop this from the parent.

BTW don't you need main_pktdma to have bootph-all to go along this for
ETH boot support?

>  };
>  
>  &cpsw_port1 {
> @@ -182,6 +189,7 @@ &cpsw3g_mdio {
>  	cpsw3g_phy1: ethernet-phy@1 {
>  		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
>  		reg = <1>;
> +		bootph-all;
>  		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
>  		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>  		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> @@ -196,6 +204,7 @@ &main_i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_i2c0_pins_default>;
>  	clock-frequency = <400000>;
> +	bootph-all;
>  	status = "okay";
>  
>  	pmic@30 {
> @@ -318,6 +327,7 @@ serial_flash: flash@0 {
>  		cdns,tchsh-ns = <60>;
>  		cdns,tslch-ns = <60>;
>  		cdns,read-delay = <0>;
> +		bootph-all;
>  	};
>  };
>  
> @@ -326,5 +336,6 @@ &sdhci0 {
>  	pinctrl-0 = <&main_mmc0_pins_default>;
>  	disable-wp;
>  	non-removable;
> +	bootph-all;
>  	status = "okay";
>  };
> -- 2.34.1

-- 
Regards
Vignesh
https://ti.com/opensource



