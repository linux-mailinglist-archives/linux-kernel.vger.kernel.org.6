Return-Path: <linux-kernel+bounces-529419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A25A425E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD113BE5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440BC1624F8;
	Mon, 24 Feb 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ui3379+2"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380C2837B;
	Mon, 24 Feb 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409628; cv=none; b=I9Tf0vpKRh4HnvdztG4kZuu0C4KrHIiKFd8RIOsA0S1wmrKoJxX/8qmzdDGWQdjUst8MlQso1rf2bEZX/DKpwzMcvpoSNWepABdkHXkA9B2cxh8FXOWhlz9SzcHwTXLCF8ChFT5gAVKzBGzctrY2kxiClzP+J9aIoMMa6q/9BXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409628; c=relaxed/simple;
	bh=79u++Ro2i6LsCvpnKocIionTyY9d5q90cEs8QPtzl4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=khgqixHq/HHs+EQ0EbluPO3pPrElrhIxZ+WKjOHpf5rF8hUvRBTv60BQv8RGt8Kndtn0iWB/1ql0qV2AXz47PGtWkSK4FY/CPR8FVsJWlt4Mo2pGnxX1GCTIwb6bwb5c1y+gio7AIk+Y1J0oyp2ljucdmfvE1H2AZODhh+yjKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ui3379+2; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51OF6u61921099
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 24 Feb 2025 09:06:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740409616;
	bh=64gjq9YtekxWTCppAv9Geq8upJcZj2N/k3LuAvBLUdI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ui3379+2jVld0ccSTVkxmTwn9H7pVz2STTMIbb8EKb3uPBnAFo5t+FRVwpnWI80+W
	 Y1kYWF+C+gLo6RZgxYvGrvu3CfP9p2pPDeOPGyftb9Zl9nVcDMkKbSET3aS+vV6b0i
	 2pTKU53ZePsXKc01GwMQDegWnG50z9oAN/pmQD+Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OF6ulo020354;
	Mon, 24 Feb 2025 09:06:56 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 09:06:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 09:06:56 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OF6uRC081701;
	Mon, 24 Feb 2025 09:06:56 -0600
Message-ID: <c81ccd05-4fb7-4ec0-8cc0-c59ac4dff91e@ti.com>
Date: Mon, 24 Feb 2025 09:06:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am62a/p: Add r5fss nodes
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
References: <20250122-topic-dt-updates-am62-wkup-v6-13-v1-0-f74835b91da9@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250122-topic-dt-updates-am62-wkup-v6-13-v1-0-f74835b91da9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Markus,

On 1/22/25 3:54 AM, Markus Schneider-Pargmann wrote:
> Hi,
> 
> am62p-wakeup already has the r5fss node defined, but it is currently
> missing from the am62a-wakeup domain in the devicetree. This is added as
> part of the series.
> 
> For am62a and am62p starter kit boards the r5fss memory region is added
> and referenced for the r5fss core 0 node.


This has already been sent here: 
https://lore.kernel.org/linux-devicetree/20250210221530.1234009-1-jm@ti.com/

Thanks

~ Judith



> 
> Best
> Markus
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> Markus Schneider-Pargmann (3):
>        arm64: dts: ti: k3-am62a-wakeup: Add r5fss
>        arm64: dts: ti: k3-am62a7-sk: Add r5fss memory region
>        arm64: dts: ti: k3-am62p5-sk: Add r5fss memory region
> 
>   arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 25 +++++++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     | 11 +++++++++++
>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts     | 11 +++++++++++
>   3 files changed, 47 insertions(+)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20250121-topic-dt-updates-am62-wkup-v6-13-4d15b4e9e996
> 
> Best regards,


