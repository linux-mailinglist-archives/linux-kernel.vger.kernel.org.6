Return-Path: <linux-kernel+bounces-413981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350559D2163
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39A11F2278B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1565A19C553;
	Tue, 19 Nov 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="XTO6Sc5U"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2095.outbound.protection.outlook.com [40.107.249.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECC1531DB;
	Tue, 19 Nov 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004015; cv=fail; b=rK+rC0SUZ09N09JLgBpVV/tZGuPTg6x+5Q+LRgveGG6J8Glk6iu5fs1yfISh+XEo/OGO7WwrF4LB+pzL4V4/8EaXqasGSoLQpUvdgxfBAc5as13kSx1lC0tT6aYuhzVdYCD7dNybMv4GujhvZ5yjJeKhlo2MNIm99S18Es8uhlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004015; c=relaxed/simple;
	bh=Nv7Akk64G2eSnoxUYkBTfgw/+5wzdC4fx8uo2VnePN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jY0sODjtScB317zNAAXCUIZM8nDx6QHr+twjlrmayoUmup/44l8Z4QJQWq920ydmjOmX1O2qJMBB4IaY50FhAb0vi6eJ/pWMIn1bOa0J3AosCPj6snwh4eqlAqUpl5dhTSfgYZcEb7dj8+nSKsX+NubOany5oOhYjB2U++4d8rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=XTO6Sc5U; arc=fail smtp.client-ip=40.107.249.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0Ow0HK/YvgGJVS8q1T+88qEvE5YztzRvIaeb61CZkTqWERWCbE3ZCUAN9TmcBl6r7tGFCi4/JQ56V8Lfwx42yUS20Zq6OAd5I+kfZwq6hUefmSduJZg+N39Ssbzx3Md8y3ErynB5SudOtyb1Rp8Tzql0ORsOOCZaxfdLZuVIWda8+ywsPHKospQD8O9OLL5Ml58cM7yJ1k3WMQ81QiK6HgI0T7nuEriAcFg2zEno7wjzCfOY24fyspnlwH/AXJhBta06U0LvGooLkbNvD0Dp2wVPUOOg85Wazkxpub+Nz60uaohaaaLzLGCPYcUohBSOlLGSU45oZKOXtyah8mDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVUB60XFddnYN3L5f0XTOfq6Ns7NToESsUR1H7IprGc=;
 b=ARoZEEkna2lVyaHbZxA39dJHAjGbCaayXxTo5YW9KsWPKk8nhI8bofNPG20prkqBqa5YT4okyCgBumspGq16f/XxUt0BNML+V237ePjdaxrR6fo/MTF0AqblZLZHLmjWkF26xXP9dL3+epfXxJxqSY8eCmRK2vYbjfAug6L2wkf3fQUiYS2+xPgPf2V2MzTb+YIoThmx9px/iN6/f9u4THYJ4etYOzLIes7rU6pt8xsI0g1E597fXSZfAiL/O+cvPNCLiR5Bu4yR5+a126KvT+kQ2yUCxUuTA4evwO5UXslFkvwGtK6NRek7j97XJGMLASn7aaZGeHatOppVjOafTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=none
 action=none header.from=phytec.de; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVUB60XFddnYN3L5f0XTOfq6Ns7NToESsUR1H7IprGc=;
 b=XTO6Sc5UJSrNnQnN6PuEQQpINYikY5vvBtEpLkFJV2s2Mec+L/xkuMxvsgt+7qK/oGKWTCDYZOKFC3WK7ODEy1ivSeI0WBCge0kWS+nS034XAYpRTlyDEZagjfWpbVIvCW2mmKYqIqBwEC6kq7Y22Gpjp2yMkCdzO2uWHBB0J08=
Received: from DUZPR01CA0288.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::21) by GVXP195MB2647.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:1fd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 08:13:24 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::18) by DUZPR01CA0288.outlook.office365.com
 (2603:10a6:10:4b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 08:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 08:13:22 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 09:13:21 +0100
Received: from [192.168.10.3] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 09:13:20 +0100
Message-ID: <097c4aad-2c1b-4aae-a0c3-e7693210eddb@phytec.de>
Date: Tue, 19 Nov 2024 09:13:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62l: add initial reference board
 file
To: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
 <20241117-am62lx-v1-2-4e71e42d781d@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241117-am62lx-v1-2-4e71e42d781d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|GVXP195MB2647:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d74c7f-73d0-47f6-55fc-08dd087208ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVU3THh0QXN5dnpucnRzQmNyZ0JLcGlhOFNRU21HQlF5RUNZYS9YTFpOVUpM?=
 =?utf-8?B?VzY1NVFjTlVEOXVUT2RGNi9rOGc1cERySmVQWm5yYThNZTdwQ0t5OWdWRU9D?=
 =?utf-8?B?dkhlWCsraGQySEtQQk4reWlFSHNTWWczVHR6M2NBYjZjbzV2SWpGL0hyT1Yx?=
 =?utf-8?B?Mlg4OVpCTTg2anUyQm5tV0VxWm40TmFjT3pCNmt0aVVFM2VMdDZrVEVFNDBX?=
 =?utf-8?B?eDFtNWhiYzBtZEI0M2VnaGQveTlMcjZyT0srZHFCeTZUa2RNakNrbUhrdCs1?=
 =?utf-8?B?MkVSTXE2TzBXU20ybXNuZXU1VVgxTitiZHliZml5YWZLMEw5KzFCT3lxU0kz?=
 =?utf-8?B?QlVWM1N1MURBa05FY3owSmIyTnphRmZCTWNoTGRMcXBtazZOSzZIQUZXQklV?=
 =?utf-8?B?aUpNMzJXdkJwT2dYd2I2UWxKYTdsbGVBTE9POGxJUlkyS1B1Y0xEQ1BUQjlB?=
 =?utf-8?B?cGIyczVVbU0xU3c3UXFyaUJWNG5BVXIzYTNPWjA4STZwM0QvNURPQXFvSHhF?=
 =?utf-8?B?NGcxd05PakpVcGZ6YWN1cWVUOVV0Wi9uMTJEK2ROc3h2NVZUZHlqalVDcEVQ?=
 =?utf-8?B?V0U0U250TFh5MTAyUDZITXJuZDZyUDQzYUpDMWZ0dUNTSytKem50cFJ6Qkg0?=
 =?utf-8?B?d3gyY3J4d0g5QXpJT2RIMHZENGdJbGRBMnpwN0syMjRIMEorRnNUMHpHM3JZ?=
 =?utf-8?B?ejUvTWluOFRPQS9UMFkweHMxMjNpNXYzSVdBcXhvNUNwa21BRm5PTjRJbDlv?=
 =?utf-8?B?MHo5RVdrZEdBbHdRZVVUWlNuSG9Yc1FhclNVbWNQaXJrb1FaSng1Ujh3V2pW?=
 =?utf-8?B?R21FVTlENFd3OUZJcmVmV2Jnc21CNTdGYi9ZUCtseXNUU3lQZndZUEdqQytS?=
 =?utf-8?B?YmN4K29iOURFQ3FzTWdRL3pmdHFZM0NRVzM1L0QvUjdmdDcvRDdtejVZUkd0?=
 =?utf-8?B?TFdjWGE0MEh3OHpSVVU2cUdsZEhxRjBxbHFDZUQyQmNFbTdYVkI3bzhaMm1p?=
 =?utf-8?B?d3FkNFhjdG9RdkRJMGdPVFUzWTB3VEsybDF3a25IOGlmejJpL1dhN0dvMWhF?=
 =?utf-8?B?RWp5azRaUWJqUHhzdEdNcnhjRjFxc3Y0THBSamxZQ3czVi9LRm44clFSYm8z?=
 =?utf-8?B?RTdaS2w1SE9xNXR1RVRTOWNycURNSFgxSm0vcE1HaS90ZXFTWEM3WURBWGFk?=
 =?utf-8?B?Wi9QS0tCcGlMRm11RnQwdStGV2h3Z3Z5TXRmbFR0VGlyN2Y0Vm9GY3F6RHdN?=
 =?utf-8?B?V2F6WlVlbDhzWG5hVW9tNW9SdHJDTzgyTlVXUUhMUklZc21PdHR2L0lHa3BB?=
 =?utf-8?B?NWJtZ0xjbEViT21hdTg1RzdBa3hVV2ZFVlRWZ1YvQlBvRWExTUhpVWIyaTND?=
 =?utf-8?B?SWNIdGI5TjVRZG9iSTZyd0dBdWZ4dG1MNWZyZzVIc25rZFZzUFYvbjJ2WUll?=
 =?utf-8?B?cGgvNjVBVi8xcE9JZ09CZFRkTzFMSmZBNE4wYmdMbFBDd1prNTF2a3JrWHJ3?=
 =?utf-8?B?dVl0SmgyWHA5bk1STkF4TlgyM0hQLzR6NE1CcnNOUWRaazljT1FNVzlnNFdw?=
 =?utf-8?B?bjJlQW1XM256WTZhL3VvOVByQXp0azBLK1BiakM2NFlNVGVDR3A5cXkzck1k?=
 =?utf-8?B?TndDVkJSQUIwa2FkTEw2U2VHZzhiQ1BTZDV3dFJkcWVQcVhiVzJQdGRaVlBM?=
 =?utf-8?B?MDNsR0IrYU5uS295anY3cXBBUlI1Z01qQWNRdVoxTGUzb3N5aGRnVS9JU2xy?=
 =?utf-8?B?NzBBd2xvZ1kzZS9CbGY0ejlXM2VWV0piRmhmNDBFYUdOQVBVYWloSHY3SFdD?=
 =?utf-8?Q?1IVym49HV0ssj9ldArNOBcUVcX7/ZsDG9+ljQ=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:13:22.0593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d74c7f-73d0-47f6-55fc-08dd087208ab
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2647



Am 18.11.24 um 06:34 schrieb Bryan Brattlof:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Add the initial board file for the AM62L3's Evaluation Module.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62l3-evm.dts | 54 ++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts b/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts
> new file mode 100644
> index 0000000000000..2d59389765cab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-only or MIT
> +/*
> + * Device Tree file for the AM62L3 Evaluation Module
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * Technical Reference Manual: https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am62l3.dtsi"
> +
> +/ {
> +	compatible = "ti,am62l3-evm", "ti,am62l3";
> +	model = "Texas Instruments AM62L3 Evaluation Module";
> +
> +	aliases {
> +		serial2 = &main_uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = &main_uart0;
> +	};
> +
> +	memory@80000000 {
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +		device_type = "memory";
> +		bootph-all;
> +	};
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +	};
> +};
> +
> +&pmx0 {
> +	main_uart0_pins_default: main_uart0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62LX_IOPAD(0x01d4, PIN_INPUT, 1)	  /* (D7)  UART0_RXD */
> +			AM62LX_IOPAD(0x01d8, PIN_OUTPUT, 1)	  /* (A6)  UART0_TXD */

Looking at other IOPAD definitions it seems that for any mux mode which 
is not 0, the comment typically includes the ball name.


> +		>;
> +		bootph-all;
> +	};
> +};
> +
> +&main_uart0 {
> +	current-speed = <115200>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +	status = "okay";
> +	bootph-all;
> +};
> 


