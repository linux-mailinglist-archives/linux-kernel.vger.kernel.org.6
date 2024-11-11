Return-Path: <linux-kernel+bounces-403526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA589C36DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238461C208DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EE1145B0B;
	Mon, 11 Nov 2024 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NrxxXzXc"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9213D62B;
	Mon, 11 Nov 2024 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294588; cv=fail; b=KEzhi+wQCslJw2ZX+8lWbAD7WaUO3MwQeqH+WvxO6ZUFKUJsm9l1Tj2uIwbU9U5PBnliF459J+Q+6E5MXv1d9tI3tT3TQKSbs8JrHcyi0+JRQrr5FSRZ0rUcr8c95gM9XzdjBc+zj1SmwUAR3rKksZS8TzbC9/2galfIJW+0mnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294588; c=relaxed/simple;
	bh=N6Zgl+Nh3KmwR2vhiAj8oSVPnHomBDB9k4GumUIfsvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QyVOJ3s73zw+Q3QyvuFSuye3CaIHPO1uP2SvHxwv7+4vxH2+S+cMja9DRFLhKhWzTdESGVsCd68llsZ7C0MqhfxkwwnGlgLkYgObbV204TitK0CVpkDc14iCt3+qeScAcl/pwy1MBsgp4QSTh62O2dkQ2/8JsXswMzM1YROuxMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NrxxXzXc; arc=fail smtp.client-ip=40.107.103.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnP6shNxz4krOvSR0Em3toRZBoL3x2P/dJ1583VYIvZC6jU1UUdLCo8LonYlziUPH/jZLqHQQVJEwJ/N3fM8kJbwaTu9aPvxRBM80u4YzLaDKjD5l1RkvzxD6etGYgkWsGFN/g97HSkLhHlAy718j8rUK+trvZ2y5LnY3d7LKbXKLOmQYdI6Bc7whrASSzZ50bSHQZDzxHoPQUV3IQT430rRrctlop3NrIV2tvJP0uOXdmXULUy9kjge7ZU0S2Bp4YBs/7nKpmvGHJ/tpiImTRt5BhbKgoEz9c0nkRWx5dLPSLjNJWkIiUCUJfd/kJVxjC+TXCnsrcQ8aieD+JXCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSusIyfejDoIgwMBlbsTSJjjzijqZ8x74z4Awmqm+hY=;
 b=E7QwkesIkJku01sJna+e+lKZvPpqRYo0Mn6wu9f+L5TTfUHtNM6cYHGrCtHvE4P05PPYVv3oHB+NPVgIikCZxk0ic3y3zSQ5HgjsnTsC/6h3tKnXB9v5susckNi9hEwDTOJJ0M3pxD0TIzdGDVNUDVO2KvWSQ1IYXQIt7k5vXhpTMEYQuNrVg9m9C/DqVTSvCDIVbqlXoJXv4SWZ0rPKz/Isea5RirM1RHDM8ENj9zYdLvzqVhpvwO2eRU/Z4DtP64PboBBukNYCZ71yNLBAwnafgH+72AjaOiaVfInmOfgTO5IPPaF9zDJ0NjIPlaswqQTFheul/clBNf5dVoy4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSusIyfejDoIgwMBlbsTSJjjzijqZ8x74z4Awmqm+hY=;
 b=NrxxXzXc55YVWdiZwpKEQL+/4D5MI/04vBe8AeGVlgBkC9gzVA8h/dwcmHLVpka+4CRYWpasz/vAejcNjmzIgaz8jz7eWFh5lv8dsvgSkKc4IdQdTX1J7A5rxycendSeaTy04crXk3Z1bIbV2Q7BpZqVTkN4tSBU6EbBhUvcQSRuwYK3kz+w8cj84yi8dcCKwBvSEm9EBXuKCZV52s6kWbE6YuHNdLw7Nu0wn3oQrrwHMNMjVXwjFkuygonyPo/ok18gfYwz6Ark9U0h7fcwgU86Rnfg6eHniP5V2LfczdNfPoTrAxGsDj/j2Fus2Id0utf/aSdiq4WJ34c/PvegnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by AM7PR04MB7173.eurprd04.prod.outlook.com (2603:10a6:20b:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 03:09:42 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 03:09:40 +0000
Date: Mon, 11 Nov 2024 11:08:47 +0800
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de,
	marex@denx.de, hvilleneuve@dimonoff.com, peng.fan@nxp.com,
	m.othacehe@gmail.com, mwalle@kernel.org,
	Max.Merchel@ew.tq-group.com, hiago.franco@toradex.com,
	tharvey@gateworks.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, ping.bai@nxp.com,
	ye.li@nxp.com, aisheng.dong@nxp.com, frank.li@nxp.com
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Message-ID: <ZzF1P25JrvW+3n/J@pengfei-OptiPlex-Tower-Plus-7010>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
 <1907807.tdWV9SEqCh@steina-w>
 <Zy3iogT7jOLEvf1S@pengfei-OptiPlex-Tower-Plus-7010>
 <22489205.EfDdHjke4D@steina-w>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22489205.EfDdHjke4D@steina-w>
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|AM7PR04MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7add0a-a05d-4603-c8a6-08dd01fe4843
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?/fKNXwnQvPh897ZiUdvM8SIlJV/TWsA9fowZ0D1kqX90hunxIi4AWcbKb4R6?=
 =?us-ascii?Q?PuPs6xEQGp3c9+1zEXx0JZkvJNFIg+7ZB1dezj59nQ/kd/YxGO6r2KM2jhuj?=
 =?us-ascii?Q?SftEkhhbLY6X0O32Cn1DwyeovKXooZPlcF+mW3wLMyex0+Vtowcf7cWGTMpm?=
 =?us-ascii?Q?r2srN1C1vDuPQjJKLXTDpbwboxKTVA/VsvsICrRhxV4Ey5PLwtYZpPFy/K76?=
 =?us-ascii?Q?1GOuFAXPKx5iRC+Lldx0fSs0+HcqND31mmR0VBf1ysxvSAvupfcNr+NZ5XQD?=
 =?us-ascii?Q?xghfGRajvcgroVCEseiXA6AqXmO4zqwNTtl6oVEYdDNNaMvk4mJEwgCfBRY/?=
 =?us-ascii?Q?Uk5K/U23sUNS3oDRhvQsDNJEh6+8so79S/8oCD7GFp2mJCboVaqbs4B101nw?=
 =?us-ascii?Q?+D1ypN7C3Y/XqWu6wb2qqrTdZtfOsQ8+YP0n5xCwxZuB7Af//heT6NQ6l2d9?=
 =?us-ascii?Q?8DwCq3fCpC8rBTb2J2pkRt/ZjD3cPgPXktrbfjH1Ysuf4z2ywULieLLkIawN?=
 =?us-ascii?Q?A0Q1+bmpCalea6T3u81g5PMIfYtAdlZzcBz09y9WMDjxMQxPuqh1sl0Utwxv?=
 =?us-ascii?Q?MkLolMizOPyXKZz1RnZFYShkI+duNmt48KdzF1l9bCQrWdWWCQzsKpp3/Bmv?=
 =?us-ascii?Q?I1YjnErp1xYFZT7kl3uh5Wwrtl0z28bDp9nYK1UnCmTu0j217vj5WdjTXoW6?=
 =?us-ascii?Q?4b4dhwXsBwLiTPlX9/S54jE87BS6ZHwCHB24WDmWIeBCBUe7xkzpU++X8U24?=
 =?us-ascii?Q?Y3sDd7F9xk1LpD+IS2SQ7SNOGrpC5DU3VHtRE6Dgn7XgPSem/N5fKKi8sIhE?=
 =?us-ascii?Q?9ySi/BTUsbQJmA1stxYdqkBL0z6hUYUzEdyYmPxrVqmMC4sw8cGjYchnZibq?=
 =?us-ascii?Q?WpirFfPRrxpFPDY8j9X83yRBzvVtzma0kd13q2isFt59ZKjq9AHQ7VB2qVFO?=
 =?us-ascii?Q?sXdEisSdj7YvxSPJ6JutMTkpMK1hYnkjqNCu2VB4UERvPBloe5aoDpsLuv66?=
 =?us-ascii?Q?MhxwnPxhD3AF3eCvlZDBAqW0A7J0rN3B+TE0OrokAXk78yTj4DENeWRWaFB2?=
 =?us-ascii?Q?3Y0lU7f/obrkM+HaVplp5IbW6lqFXsDzqQNZctkGRsbIRF1sdwAYcHOcz+MJ?=
 =?us-ascii?Q?q4zOjhgo2M8ySHovEtzz6cfCKU3lUYct+d1xxayTcsmM2rq7HskR6LV0l9pU?=
 =?us-ascii?Q?wjXhH3xoTBCZKmBva6qBXPoRN6BnGIiXNY/6T3PST6BQkT9sVFtJeb9XXxdH?=
 =?us-ascii?Q?ikbgv51MA4QA2nBbn/8V43XEWvlreaKYcYzes9qvUQyw/TnM65gqPLY0bUs1?=
 =?us-ascii?Q?v0iPN9nA7/tFsiazvXdknxZ24Bsg2ICxoDwKATOcYvwYpH4lFZYtcZS/6MgP?=
 =?us-ascii?Q?OjC4U8Y=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?aB/iWGOTrva32oGscn1ig/eebdc/QsqkHU93+gsqpNT0ciPQR8pWVXpvAUHj?=
 =?us-ascii?Q?qqNtrA2Ehwar94gjw0MPVDoV81tf37Qu+9iB4/mp5bO2hk6sbprsFqNzuud1?=
 =?us-ascii?Q?G0wE6ccGmrsZ50V04eEWw9e099B824m2PrCJiRs5Er3BkMlnNzIp1a224mdb?=
 =?us-ascii?Q?xW/f52SgAmujhMqSvyAHbWhX0AHGN5E1lX/ulB95vGNQUoPOXhEijdMTVddb?=
 =?us-ascii?Q?N2PSMQZz1aANcl0M88D2HWPcMn3Si2nIvhDCqeTlhZwZPTIDnHmx6tZUZhDi?=
 =?us-ascii?Q?c4d8yo17Em1n2Cp4/Li1UVwm0XsFXSQl62r5MSEJf5OlsXX6FAb+pNustOS+?=
 =?us-ascii?Q?sEuzImNrLoqq8lcQwksKBQP9ArvfIY657UPwva0qJSPmUQWSO5PhW/AVBo6o?=
 =?us-ascii?Q?/M357w+Aglvp0l1tjvUt50rf+kSCuZvs8I8ZDyRMvXfB/b93/EDAxNSmohJQ?=
 =?us-ascii?Q?yKZtIgfMLUbtzmAKHcyXNw5SWJ3JAWcB9M+rFYju9OO/4heXg/JV+Jalltah?=
 =?us-ascii?Q?YgOk1TSI66jMCauejDLDlzkUj3jZ/UfhOO2UyIO+aFzn7vRWL3StTSmmn9OJ?=
 =?us-ascii?Q?tx5i2Eq5tNpXfke0bkhSOo9olV0ngsgTkLEbsk9tmSG5s8NIGV1Bhid2BG28?=
 =?us-ascii?Q?S5lac9iAytQxp7pzRJ5WbXko1+nTGOdlPKUaPoJuGVOcXn+SKJYtdvkcsyql?=
 =?us-ascii?Q?VZx6vdggUAQJODfNmVarv1A5GxDZpZFUqYFLpPhn+n4OL4oz09rV8BlchTj+?=
 =?us-ascii?Q?d6/I3zGMIGZPdFhs0Ca82Ve8yv3drMi5QTx4Ebwwem5JBYE89Za8vNPVQurv?=
 =?us-ascii?Q?N4EQYSB+Jlc3aOreLNbRHIOEN1OCzPf2QIDeYE/9cIspuF9SMSovcFzA4vVD?=
 =?us-ascii?Q?JPGN4eqZeBo+1IP0VOSsCb0dyI7AdzyRSEb98c+3vNxQLt78FBtSwzi0Ykn8?=
 =?us-ascii?Q?WGl1rl0CC9ykzpMxcrmE/PeHVRlmKpZ2OsSulxD9cVDpuyMsP8DKCLo/ydyE?=
 =?us-ascii?Q?neYo+eVeoaHakbwJb67Y1xF+ty67Kzjn17M/MKCHrRUP+lS6JNCT4mmMN0kO?=
 =?us-ascii?Q?23UMZ9DUNKHMZnVqZBM7GTVK0hWvR2+ErbsCvKeLowNRr0qqcJ2/BuOGk1qX?=
 =?us-ascii?Q?lGRrobL41lY+qWDzHwK6lk3nNqUeHkYNzqXlTdDubdAft88xgHs5aqS1wF4M?=
 =?us-ascii?Q?pZFKsX5SWSdQDomrLHtQq0kquC1rl/b/hvS/rPz9+iqT0sKl5V5v+vIsPXjH?=
 =?us-ascii?Q?EMNCr/H1tuK7dBD8268dAii73tkYx2TIR0nssMQWMHAlzDpb3TVe7X0j2orN?=
 =?us-ascii?Q?4m58O3BnJiwZOmYagsyDV+HcegR5KwA1M71j7KFh3tja2rHAlRfDQfnDt9fM?=
 =?us-ascii?Q?j7eJK2NyR3pjDFnfX+w/I0Yv6LQW1wx443BKDv0jNk8M72WI97Cik0uXq3ez?=
 =?us-ascii?Q?NPTF/ZKXdIn+fog35UiZHVHvI7C5ErNed8QTQRErOyZ/7Akpkp5RaP0Gpz3e?=
 =?us-ascii?Q?nOBPdfD/DuoSu3Cak4TgvpqGbKXpIgoV+gsOjPJqcR3C3fHOwkZ+ivNzBq14?=
 =?us-ascii?Q?KwoMkSN4LhMUpTIEooclxW4ZhMsYkejKE1ARiqYU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7add0a-a05d-4603-c8a6-08dd01fe4843
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 03:09:40.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtrMG+zcTDNcmikTPrFgbs2KJEkeFZLyaH70Pjvw7CepH8PIzxAfuZZXbBSxukk5SeA/FqYfRRrJDh5ZYB162Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7173

On Fri, Nov 08, 2024 at 03:07:50PM +0100, Alexander Stein wrote:
> Hi,
> 
> Am Freitag, 8. November 2024, 11:06:26 CET schrieb Pengfei Li:
> > On Thu, Nov 07, 2024 at 02:06:27PM +0100, Alexander Stein wrote:
> > > Am Donnerstag, 7. November 2024, 13:49:50 CET schrieb Alexander Stein:
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > > > > new file mode 100644
> > > > > index 000000000000..a9f4c1fe61cc
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > > > > @@ -0,0 +1,66 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > +/*
> > > > > + * Copyright 2024 NXP
> > > > > + */
> > > > > +
> > > > > +#include "imx91-pinfunc.h"
> > > > > +#include "imx93.dtsi"
> > > > > +
> > > > > +&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
> > > > > +	cooling-device =
> > > > > +		<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > > > +};
> > > > > +
> > > > > +&clk {
> > > > > +	compatible = "fsl,imx91-ccm";
> > > > > +};
> > > > > +
> > > > > +&eqos {
> > > > > +	clocks = <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > > > +			<&clk IMX91_CLK_ENET1_QOS_TSN>,
> > > > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> > > > > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > > > > +				<&clk IMX91_CLK_ENET1_QOS_TSN>;
> > > > > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > > > 
> > > > Is it just me or is the alignment of new lines not matching?
> > > > 
> > > > 
> > > > > +};
> > > > > +
> > > > > +&fec {
> > > > > +	clocks = <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > > > +			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > > > +			<&clk IMX91_CLK_ENET2_REGULAR>,
> > > > > +			<&clk IMX93_CLK_DUMMY>;
> > > > > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > > > > +				<&clk IMX91_CLK_ENET2_REGULAR>;
> > > > > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > > > 
> > > > Here as well: Is it just me or is the alignment of new lines not matching?
> > > > 
> > > > > +	assigned-clock-rates = <100000000>, <250000000>;
> > > > > +};
> > > > > +
> > > > > +&i3c1 {
> > > > > +	clocks = <&clk IMX93_CLK_BUS_AON>,
> > > > > +			<&clk IMX93_CLK_I3C1_GATE>,
> > > > > +			<&clk IMX93_CLK_DUMMY>;
> > > > > +};
> > > > > +
> > > > > +&i3c2 {
> > > > > +	clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
> > > > > +			<&clk IMX93_CLK_I3C2_GATE>,
> > > > > +			<&clk IMX93_CLK_DUMMY>;
> > > > > +};
> > > > > +
> > > > > +&tmu {
> > > > > +	status = "disabled";
> > > > 
> > > > Why does the TMU needs to be disabled instead of deleted?
> > > > 
> > > > > +};
> > > > > +
> > > > > +/* i.MX91 only has one A core */
> > > > > +/delete-node/ &A55_1;
> > > > > +
> > > > > +/* i.MX91 not has cm33 */
> > > > > +/delete-node/ &cm33;
> > > > > +
> > > > > +/* i.MX91 not has power-domain@44461800 */
> > > > > +/delete-node/ &mlmix;
> > > > > 
> > > > 
> > > > Shouldn't the following node also be removed?
> > > > * mipi_csi
> > > > * dsi
> > > > * lvds_bridge
> > > > * lcdif_to_dsi
> > > > * lcdif_to_ldb
> > > 
> > > Add mu1 and mu2 to that list.
> > 
> > Hi, i.MX91 also has mu1 and mu2. so there is no need to remove them here.
> 
> Maybe you have more recent information. The RM available to me doesn't
> say anything about messaging unit, neither in memory map nor as a separate
> section describing the hardware. Memory area is marked as reserved.
> 
> If there are actually mu1 and mu2 available, what is on the B-side? There
> is no Cortex-M33 after all.
> 

Hi Alexander,

I rechecked the RM and found that it did remove MU1 and MU2, I will remove these two nodes in the next version.
Thanks for your comments!

BR,
Pengfei Li


