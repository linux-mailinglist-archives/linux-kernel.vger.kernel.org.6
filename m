Return-Path: <linux-kernel+bounces-385277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82A9B34F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40C1280FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805D1DE2D8;
	Mon, 28 Oct 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m+Z7inx1"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E351DB92A;
	Mon, 28 Oct 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129501; cv=none; b=UvYFZ8CNDZzmiid5Qz9Dg/+AhjWOA/Ixkn5h0yybeVJLVu/1pTnUm6HN/KgWkqJ2aKhRuqYNGoRaNeRFV7LNdvBzqSEGNR8tDW2haEVjFU81Cd/TztPbT4fpGZNcSWhWa5vrhoheo3imQ1+0uosb7QHO6hVgRNkGRdDg+qVviNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129501; c=relaxed/simple;
	bh=GlCl4suOZi31bbHo/epOIkCtwpVuotPZe5F4SCoPlFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T703sOSfp50bhAf3Qqn5vRDxIN0zdQJSLhQpTn/pa+W0CQmK1pp6qNmpzVHUbuAWqDzITKwe9IovY3a+wLgYHtybp0hzcKbh1PTnpVRqfrfxGXsf0b7GyRT//8DOO+NP+1tUERJkMn8Ry0//IniE5U/BtZ+kms5nZpwS1cht2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m+Z7inx1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SFVO3v106856;
	Mon, 28 Oct 2024 10:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730129484;
	bh=odVGvLxAl1AqjQa5uRzsIceJRPumkwebyiUsBzFhSws=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=m+Z7inx1xYlR2uujDEcD4QYPvats6tsStuVo1G0Z27T5TkZWsND+1qU6dJ/pHBVXJ
	 O59oB6iU4xYXMtPqZpTj3QrKi3jqJGdHtfr2k6kLMS1Avtu+NudT529ycwbz1Qo+PS
	 95iYz1SE/tk+qQI0LXoQR8YByVbAaPpwzZfUwOjM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SFVOC5073202;
	Mon, 28 Oct 2024 10:31:24 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:31:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:31:24 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SFVKSq031040;
	Mon, 28 Oct 2024 10:31:21 -0500
Message-ID: <a65e17e9-0055-4e5a-902f-8ee2807a86df@ti.com>
Date: Mon, 28 Oct 2024 21:01:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Josua Mayer
	<josua@solid-run.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Yazan Shhady <yazan.shhady@solid-run.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
 <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com>
 <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 25/10/24 19:27, Geert Uytterhoeven wrote:
> Hi Josua,
> 
> On Mon, Feb 19, 2024 at 4:05 PM Josua Mayer <josua@solid-run.com> wrote:
>> HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
>> The single SerDes lane of the SoC can be routed to either M1 pci-e
>> signals, or M2 usb-3 signals by a gpio-controlled mux.
>>
>> Add overlays for each configuration.
>>
>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> 
> Thanks for your patch, which is now commit bbef42084cc170cb ("arm64:
> dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3") in v6.9.
> 
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
>> + *
>> + * Overlay for SolidRun AM642 HummingBoard-T to enable USB-3.1.
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/phy/phy.h>
>> +
>> +#include "k3-serdes.h"
>> +
>> +&serdes0 {
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +
>> +       serdes0_link: phy@0 {
>> +               reg = <0>;
>> +               cdns,num-lanes = <1>;
>> +               cdns,phy-type = <PHY_TYPE_USB3>;
>> +               #phy-cells = <0>;
>> +               resets = <&serdes_wiz0 1>;
>> +       };
>> +};
>> +
>> +&serdes_ln_ctrl {
>> +       idle-states = <AM64_SERDES0_LANE0_USB>;
>> +};
>> +
>> +&serdes_mux {
>> +       idle-state = <0>;
>> +};
>> +
>> +&usbss0 {
>> +       /delete-property/ ti,usb2-only;
> 
> /delete-property/ (and /delete-node/) to delete something in the base DTS
> does not work.

Geert,

Thanks for the catching

Joshua,

This overlay is pretty useless in light of above issue.  I intend to
just drop this file unless you convince me otherwise?


-- 
Regards
Vignesh

