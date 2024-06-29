Return-Path: <linux-kernel+bounces-235029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893291CE96
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E3C282A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5378136657;
	Sat, 29 Jun 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cYyxZgdL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3D5660;
	Sat, 29 Jun 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719686430; cv=none; b=qbS8cRpc/TZIwotPNwnJXe67StvmCn5gdgDJ1LuSjgopH6e1pMJzxvoBEu7WJ5JIjOIddKiK2QNjz5D+7GcIfhRjchhG43xsDzV0aaSbB/Bd2IoHR1fFzGoSLr52ajggLrWZaQBDHkltdBm7fb35yY+ceHtNphWVbDAap7BIjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719686430; c=relaxed/simple;
	bh=YOMshYfVX3JgDBPVISxi9XYTzmfXR4P4xJtJPKISiuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qt4MGt0OkSgYMJgOCCP/WGZ2PtK/2tepV8zVlBgiu/X2v6U+iPFdHgomitCV7O8nlSs+ycfCZ4ZPFP/0jWrRGEoMXNL482FgS/wpAyfHudnSRxNZgkdxkAVhe+oVxy9Z1ffXYMGer4RQ3JHqdb3dx4A6HZC+uGlpfS1S9MlWXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cYyxZgdL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45TIe7in029076;
	Sat, 29 Jun 2024 13:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719686407;
	bh=ZSK7rQ4eUCg7g5a2dHPPID0qKPfa7S2DfO23/dAVjrc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cYyxZgdLD1TOXhB//4HXL5qkwgwK0breV2a0Z9SjqokPL/daMOkuJqG02/r0kopK8
	 x3gc05xNiUppNw4x5UAb9wvswWTMQ77vGVmhpzx+BSXZLJuw4+EE8s8R1qAczpSGe3
	 hlrM+0/sfINrmEsa0aX1omesFhvqTc8Valhqr+F8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45TIe71E091196
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Jun 2024 13:40:07 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 29
 Jun 2024 13:40:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 29 Jun 2024 13:40:07 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45TIe3W4072481;
	Sat, 29 Jun 2024 13:40:04 -0500
Message-ID: <69cd28cc-60d3-4ca6-b31b-af940a937d9a@ti.com>
Date: Sun, 30 Jun 2024 00:10:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j721e-mcu-wakeup: Add bootph-all to chipid
To: Neha Malcom Francis <n-francis@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240627101003.3608397-1-n-francis@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240627101003.3608397-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 27/06/24 15:40, Neha Malcom Francis wrote:
> Add bootph-all property to the chipid node so that it is available at
> bootloader stage for obtaining the SoC ID and revision.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---

$subject prefix should match existing convention for the file

arm64: dts: ti: ...


>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 9349ae07c046..c2417ef614cf 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -57,6 +57,7 @@ wkup_conf: bus@43000000 {
>  		chipid: chipid@14 {
>  			compatible = "ti,am654-chipid";
>  			reg = <0x14 0x4>;
> +			bootph-all;
>  		};
>  	};
>  

-- 
Regards
Vignesh

