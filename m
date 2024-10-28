Return-Path: <linux-kernel+bounces-385613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2661A9B3964
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4791F22C12
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DB71DFD95;
	Mon, 28 Oct 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B/vdsh1S"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF11DF997;
	Mon, 28 Oct 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141105; cv=none; b=nNC0GqP+NEkA7dLky8b7HRDqUfGy6yCF7vLM+63fLTsj2dEPs6Z+CVu+2BFKsuPzx28TsCVOqGg4GWSH+hzSuidULptqfprdE4C9yA7psA2e/xGMvroP7sbRhmFfWHiOM5GFQ7O0GViJaCYlpxebJAPimcU3EASTWdt1FAsHAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141105; c=relaxed/simple;
	bh=dChFts2/7a2fBHU+v3doi2oXmZFDxoByWrmt5KOQZf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bcBr0uDjFCbS9YoWuyt2Vb1hoRi3DQSv+WDgUg3AjI7nFGTXgr8CdSF4OCh9RTDWxt5rPa854Yp3h7XyIzqEitog/VNw7vFs7Yjl6fdbEMDx5Lz2kS7Tw0LCBkugC/2zNUykzz6avvv2KSEuNMUMy3r1jUZwOhyMeZlIEZ10hgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B/vdsh1S; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SIimNl054286;
	Mon, 28 Oct 2024 13:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730141088;
	bh=3xYgYe0OlHKa5EeZMU5xT/sJGAiMZdG0VMyPo/JHxaU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=B/vdsh1ScMPdMTZEbP98n/vyaALNHCox9IvSBd2RsME9FFx2oOuZft9qajQh5Mmtx
	 RuUcokp331qiquhm1H9BDRTkplu24zANK/9aECiML565JEavJ8JhfpfdymZughVso4
	 F4BkUk/1/M2zIogx4IPAbp/h0MM01kRuXL0ugrbE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49SIimaA017613
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 13:44:48 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 13:44:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 13:44:48 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SIiir6044459;
	Mon, 28 Oct 2024 13:44:45 -0500
Message-ID: <cd02e760-54c6-4a92-af4e-e786d80cfbbd@ti.com>
Date: Tue, 29 Oct 2024 00:14:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
To: Josua Mayer <josua@solid-run.com>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Yazan Shhady <yazan.shhady@solid-run.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
 <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com>
 <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
 <a65e17e9-0055-4e5a-902f-8ee2807a86df@ti.com>
 <299b6b75-beef-46aa-9203-b96009226677@solid-run.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <299b6b75-beef-46aa-9203-b96009226677@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 28/10/24 22:49, Josua Mayer wrote:
> Hi Geert, Vignesh,
> 
> Am 28.10.24 um 16:31 schrieb Vignesh Raghavendra:
>>
>> On 25/10/24 19:27, Geert Uytterhoeven wrote:
>>> Hi Josua,
>>>
>>> On Mon, Feb 19, 2024 at 4:05 PM Josua Mayer <josua@solid-run.com> wrote:
>>>> HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
>>>> The single SerDes lane of the SoC can be routed to either M1 pci-e
>>>> signals, or M2 usb-3 signals by a gpio-controlled mux.
>>>>
>>>> Add overlays for each configuration.
>>>>
>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>>> Thanks for your patch, which is now commit bbef42084cc170cb ("arm64:
>>> dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3") in v6.9.
>>>
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
>>>> @@ -0,0 +1,44 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
>>>> + *
>>>> + * Overlay for SolidRun AM642 HummingBoard-T to enable USB-3.1.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +/plugin/;
>>>> +
>>>> +#include <dt-bindings/phy/phy.h>
>>>> +
>>>> +#include "k3-serdes.h"
>>>> +
>>>> +&serdes0 {
>>>> +       #address-cells = <1>;
>>>> +       #size-cells = <0>;
>>>> +
>>>> +       serdes0_link: phy@0 {
>>>> +               reg = <0>;
>>>> +               cdns,num-lanes = <1>;
>>>> +               cdns,phy-type = <PHY_TYPE_USB3>;
>>>> +               #phy-cells = <0>;
>>>> +               resets = <&serdes_wiz0 1>;
>>>> +       };
>>>> +};
>>>> +
>>>> +&serdes_ln_ctrl {
>>>> +       idle-states = <AM64_SERDES0_LANE0_USB>;
>>>> +};
>>>> +
>>>> +&serdes_mux {
>>>> +       idle-state = <0>;
>>>> +};
>>>> +
>>>> +&usbss0 {
>>>> +       /delete-property/ ti,usb2-only;
>>> /delete-property/ (and /delete-node/) to delete something in the base DTS
>>> does not work.
> 
> My understanding is that flags are equivalent to boolean, i.e:
> 
> ti,usb2-only = <true>;
> ti,usb2-only;
> 
> are equivalent.
> 
> If so, can we assign <false> within the overlay?
> 
>> Geert,
>>
>> Thanks for the catching
> Excellent spotting indeed.
> I noticed this in passing about a week ago when I requested
> Debian enable the necessary drivers in their distro kernel
> (without understanding the root cause).
>>
>> Joshua,
>>
>> This overlay is pretty useless in light of above issue.  I intend to
>> just drop this file unless you convince me otherwise?
>>
> I would really prefer to fix it, or somehow replace with equivalent functionality.
> 
> My original proposal was having the board a dtsi, and the pci and usb3
> variants as standalone dts.
> 


Yeah, you would need a separate board dts for this profile. Please
propose a patch

-- 
Regards
Vignesh

