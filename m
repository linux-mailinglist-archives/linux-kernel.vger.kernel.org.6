Return-Path: <linux-kernel+bounces-301336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAE195EF34
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0981C2031D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241B154C0E;
	Mon, 26 Aug 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KZT0LCIW"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE7147C91;
	Mon, 26 Aug 2024 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669865; cv=none; b=SUplvosUUx+wPnVJxOecNpN68awHQC5hlzcWZN61Ro+hXqVQmR1dAOMAym46V8CzBDdR7bdCIVmE3LcoJJpQuciANrfw0ZU4/Ar2OyvgyC87LjHFbcd6i8VrHpOWCMOy1m3FkPuUftjMpbzo/JiulLmJzm+SRriKI40q9lSryJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669865; c=relaxed/simple;
	bh=24VDlyd6bpR4BXWGgOTemmB/Ry5xtA0pmXUumCi6ARU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Q+XOJ+Nr/XUMX0kqAGTd0QS0NrHnNs/tmyQlEPPzBDZUP2LlnHsXlDowdr8/6A217Z8SaJjIlGBln5ULhsMB2pd/remxycSXrSVkQ7VuERVLcyRFNw3lNJ56LwwsLTDDV0fkgP1m+qlcwxEKD4o5cxdhFW3na4NuwfoJFoE83bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KZT0LCIW; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAvURB068331;
	Mon, 26 Aug 2024 05:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724669850;
	bh=pfUw2ZfS3QFDrve29BxkdEVls8IbhC4bx/0w5dkK0U4=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=KZT0LCIWQCMLt2JPu0ZHygo7LhdJafZmnFHS/suq/7sVBfSXCKlo2KredQmegiEDe
	 r+Mfl3t+vYZIH/797vigmBe7CpGJ/2T+j9DLyNiruJdfjXHiZCrKB5j/KogLwDUr3Z
	 HCjyzscHPpPfttN9fzviK1cyR3IYCRA8b7W1yZ3Q=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAvUY6042117
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 05:57:30 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:57:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:57:30 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAvQUC070783;
	Mon, 26 Aug 2024 05:57:26 -0500
Message-ID: <e6d97ec3-07ad-454f-b804-a39a0397beeb@ti.com>
Date: Mon, 26 Aug 2024 16:27:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Reserve Timer Nodes to avoid clash with Remoteproc
 firmware
From: Beleswar Prasad Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240826104821.1516344-1-b-padhi@ti.com>
Content-Language: en-US
In-Reply-To: <20240826104821.1516344-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 26/08/24 16:18, Beleswar Padhi wrote:
> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
> use timers. At the same time, if Linux probes the timers, some
> instability is observed while booting remote cores. Therefore, change
> the status of the timer nodes to "reserved" to avoid any clash.
>
> NOTE: This series has been rebased on top of a sibling series[0] as both of them
> introduce changes in the same files. Thus, please apply [0] before applying this
> series.
>
> [0]: https://lore.kernel.org/all/20240826093024.1183540-1-b-padhi@ti.com/
>
> v4: Changelog:
> 1) Refactored changes from {}-common-proc-board.dts to {}-som.dtsi to put all
> remoteproc related changes at one place as remotecores were getting enabled at
> {}-som.dtsi file.
> 2) Rebased this series on top of [0].
>
> * Nishanth:
> 1) Fixed $subject line for all patches to include the board level files where
> the changes were applied instead of the SoC level files.
> 2) Applied these timer fixes to J721E-SK, AM68-SK and AM69-SK boards as well.


Adding to the changelog,
* Udit:
1) Dropped patch "arm64: dts: ti: k3-j722s: Change timer nodes status to 
reserved" in v4 revision as remoteproc support (DT) has not been 
upstreamed yet for j722s-evm platform.

Apologies for missing this changelog in the cover-letter itself.

>
> Link to v3:
> https://lore.kernel.org/all/20240816073908.2343650-1-b-padhi@ti.com/
>
> v3: Changelog:
> * Udit
> 1) j7200: Updated commit message description to remove DSPs as the SoC does not
> have one.
> 2) j722s: Updated the correct commit for "Fixes:" tag which introduced the bug.
> 3) For entire series, removed comment about timer usage by R5fs in the MCU
> voltage domain as those are used by Device Manager firmware to get SoC
> functional.
>
> Link to v2:
> https://lore.kernel.org/all/20240814104151.2038457-1-b-padhi@ti.com/
>
> v2: Changelog:
> - Split the changes into individual patches for each SoC to tag the
>    correct offending commit for "Fixes:" tag.
>
> * Udit
> 1) Add the correct clashing timer nodes for J7200 SoC.
> 2) Port these changes to board level dts files instead of SoC level dtsi files.
>
> Link to v1:
> https://lore.kernel.org/all/20240607105559.771080-1-b-padhi@ti.com/
>
> Beleswar Padhi (7):
>    arm64: dts: ti: k3-j7200-som-p0: Change timer nodes status to reserved
>    arm64: dts: ti: k3-j721e-som-p0: Change timer nodes status to reserved
>    arm64: dts: ti: k3-j721e-sk: Change timer nodes status to reserved
>    arm64: dts: ti: k3-j721s2-som-p0: Change timer nodes status to
>      reserved
>    arm64: dts: ti: k3-am68-sk-som: Change timer nodes status to reserved
>    arm64: dts: ti: k3-j784s4-evm: Change timer nodes status to reserved
>    arm64: dts: ti: k3-am69-sk: Change timer nodes status to reserved
>
>   arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi   | 25 ++++++++++++
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts        | 41 ++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi  | 13 +++++++
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts       | 29 ++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi  | 29 ++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 25 ++++++++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts     | 41 ++++++++++++++++++++
>   7 files changed, 203 insertions(+)
>

