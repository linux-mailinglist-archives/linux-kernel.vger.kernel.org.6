Return-Path: <linux-kernel+bounces-528048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE1A412D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D3173E37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26DD19AA56;
	Mon, 24 Feb 2025 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R8A9bBUp"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA67BE40;
	Mon, 24 Feb 2025 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362091; cv=fail; b=Bb5+EuPFbZjMtw6J6tlvetnpqSDluqM/83IFO/lD49qZSFCTIZiWdV+391CGP2b/Mrf7ciqDtkf1CS9EzXx57IN9ZBDfKBW4nVtNQjwa4wjxutbPnl4XtAQ5W4+WtK5JGt2dn0sQsWbySLti5cm/wdUuLn+iR9ezJU+TiSQTZjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362091; c=relaxed/simple;
	bh=ZyNUxM0W3iChzM4xuqUhfA3zxF1pOzdNKOc5h3WeD9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Eyf4o45C6ba+HlrTy3cPH5SwZBvqTw1k5WUn27aPmVXi48xgiF30ROXi5t1OQ30U8eZuUqjfRsLE9kzJkm/MDqeWNFQCeZZeoBiIoXt0zxdSujFx4e2WRYPvMW4noGLFP40noiwOlTxFLNdc8euHuUhumYbYhyWmTmgWembeOe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R8A9bBUp; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYUbUbuVbAqaWe9mDQLXfl2yw26VZaNH5n7SAVT9GfwwJyVYKREDP6xlF/IwqEK39AafAu55h9YgT4xgXbktDosCsjQflLzDtblNLaFiYTl0tA7WWst34dJlhXTd1HZ44wWN9t1xjq99x7fD4de9JwxcRTWRgVrbKCCPTkVO5XJfp/XKuTvJ/IAYSnaLS2xGE8ZOkaOZdcXaSyrZxpHOA5mRFavu+aev1FqpLbjUSAogoxd/Oq3cJ89Qso9cCBfBa9VoANhcI7FRHc4UmIt4tLLc6tvLt9bxqP9dNdJLWTmPpsJz5UKKPAapRCEnRkwSL9t+UzEasxvJhR98fvfgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlauggdtkMzrET7/0LlZ2ex9yBi6l1NKSKah8NYr/MI=;
 b=hcBNF4Hfsxe7KyV1MEG4hrEjV0tv1nkC4VoaO0d5hYh8dj/YwZFcF9iDE7HWUMlatMCWrZ4kN8hZhs+4vVdvpy1Qs3TDYRqnyxpcAMp4acDwBinVK9+mRj31cIzgSs/jhzem1PkJls7cGxwT0VIsjG/R5Z1aFAQUEWBs2hIgpb/9AxS9kWrmBG/2LbhPAf1MuE6yuLJXUMSd5gH9MjYk+fXnpDNfKiL+svvjeJnBvrwjS94qwQpnAtY8PeX2aWctnelhnRGSiEtbn2ErnxpcNaEmAQVB9F1q7lHTMV1qfzR6kgmt1UjpKc+QzG1N+6RNbpWVsp2cESPhuNq3xIPLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlauggdtkMzrET7/0LlZ2ex9yBi6l1NKSKah8NYr/MI=;
 b=R8A9bBUpZN4fl+bht8tgIkllsRxI9bwuP/8Q/7y7qshz6Ka8F4j7m28FpNaC9KdqbJoszmRt4/u0qXlgcAmD2VRQj3KEWTe1tEuubRGNgmwkxI8ru85k6vHQP9OPGM+1lSNs5Bf8RUzO8sFrKW3poMeiF+zMKERvCbvJqH9VLUj4jUDQz61FTzzcjk74wvN0UvqlYQJYcKo9r/zHlvdBwbyYh/8fvm9sX7fvYLPjYcb0BJw3PX/4/FNvLT6winSAAAxLNm2/KT7ObO9d3lGS5wJcB42H1u7oEWe/kG4ztwMPQwq/JVnkXyySb1zlYyoNEJ3I60iuE+Lx48w3DAKE0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7622.eurprd04.prod.outlook.com (2603:10a6:20b:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 01:54:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Mon, 24 Feb 2025
 01:54:46 +0000
Date: Mon, 24 Feb 2025 11:01:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: firmware: Add i.MX95 SCMI LMM and
 CPU protocol
Message-ID: <20250224030157.GB9876@nxa18884-linux>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-2-3aee005968c1@nxp.com>
 <20250219214608.GA3003788-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219214608.GA3003788-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: d23df37d-5e0f-4369-1b0e-08dd547636d6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gG/RDgAOvXF7oOjyduvu3oZYKCE++R2NHXNmdqaFlpKKzKtAA5Oa1Odepxl6?=
 =?us-ascii?Q?INxRPVdT/14grNM7p3x2DUNNxxLm6PMOuZCjfXCGt2xmhsp0Sp6LzZm9MzUf?=
 =?us-ascii?Q?4XL8jluPLmH+J6Q338Rqe6rE88hnGq8VVG4hjtmILL0SViVN2Crrq+UtukV1?=
 =?us-ascii?Q?L3yTHBpiztwUBZRm+Y9ub7a9RP2VPE2rEQiuaD1gsUH8J6rqxTJNihwcgjtR?=
 =?us-ascii?Q?BTq5AcnX7BfFTGr8f+w126o8OWy/j0X4T1gihzNwyjznj9iquWWqV+2TgloW?=
 =?us-ascii?Q?TEGbaEzQqTG4ztztSK/PnFlM42ZFUKrTt7oJpfBKQeP3VK++u41R1ncW2VIS?=
 =?us-ascii?Q?vMmArVFPWMWwxtRe7XUEmmjNmWeo4Ncwxibgn94H6TrJOf2jwNmlOgrWjuHW?=
 =?us-ascii?Q?RfvoJbQckik9cC4ykpPOIQmT+0f65GthOpJ465He3jmUmb+BB1ip3mfeIjYw?=
 =?us-ascii?Q?toEnwQK+A0QVed/fGBJZrLB9Fe03771EB6hUK7lgT5J/lGwtgluecf6x6IPI?=
 =?us-ascii?Q?JTNgbvoYzVsUV/nfy0vjdjODNG5nMK6uPMhN6LTGGZX1Z4CrQysPJ2TExFJU?=
 =?us-ascii?Q?juuXPRNQw5ljmxYo6VCrvDv9wYLu7vMN6+pKD5QDtLXR7DP+N7R6AA57prwI?=
 =?us-ascii?Q?MfG8hGfCjdQ2yc8fYnEmN6YOL197HIKnl1jDdOoMlPan21gDOcgKt+mBmDlU?=
 =?us-ascii?Q?e3Php5Fsn0IzEW6ttCw2mMvr9AXCG3Xs8zgK14j/MHuY6yHJ9CHdsdzvqHqr?=
 =?us-ascii?Q?sOpQxN6Rxeo5FheTQ7+p0isAvObEK4x86i/XrafogMxpd3n7uSK4F5t9f5lS?=
 =?us-ascii?Q?PgbYCAZALmK9fD+FzI2SfZumbTVahX51M9gqnXru3IZ0vPMxr8zjThnWLD3T?=
 =?us-ascii?Q?3JpG2AKMwDcaCKTc8c0dgIBMtlDhA/Q5X/hZ+FZ9RVTyHKCn/IpxH/OYRoaK?=
 =?us-ascii?Q?thRtMS1dBZ0LKDv1EuOsHdD2cc1UA3u5Tyst1wSQSx0bbyvEU+8/D2M+G6+n?=
 =?us-ascii?Q?YwsAx2SVw1PHEmYdNg1n9AlMOstnUTK9GYFEc5FVwW+BNYxQ6ZC2e9iLY/py?=
 =?us-ascii?Q?rSC9d2zuS8dOMLB9uw3Hr+5li3ZXyT/9bQg0cCIz9lpb+vTuB0CSYpuw6pLx?=
 =?us-ascii?Q?txxBPgQC2PNW2JEaZY3rz/0OdANDGKMlZLvjPKCzdTbvaesJXB96wz89AGm4?=
 =?us-ascii?Q?g8Z2FufiBXZDCGbgu0W3ucfY8xtRYBGqcOT3wsR4E3GvrvOhdIPP/wqJLFqP?=
 =?us-ascii?Q?GDGwPZkOKIxzVpsz6RKOok3QEHQXdC8TWercId8T16ab/NwOmnuOh5CQSxqX?=
 =?us-ascii?Q?HATHGihT1WrRmfhI1dFDTIpQsEHUsMS53l4ehZAwxdxSmNMSjgR27DT2RRP8?=
 =?us-ascii?Q?+VuxJUwiSFDhYNQSu7/eapc/U/Et4Tpzwauv+nCY/qO5WaORWssq1JpSDPsX?=
 =?us-ascii?Q?KyL+Dyes1o/sR3vZ9n9VKKximvCpC2UV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHCjMihLgIFBY8UpE6bMCN3gbpwtGlt37bbVUjqJbUlXDM82m4Y2iyShULKU?=
 =?us-ascii?Q?U0pUJyUsReizrxuSnBscAvvNDcToUG8PTAchkqZ7LEhLXtL/brl193VumJhq?=
 =?us-ascii?Q?rbybC+ux6U0E/Zpl5UMiUrAC7zkfVqMnTkaelms9fcrg/0DEg+zhinpl7vBN?=
 =?us-ascii?Q?Q2vi8QyszEb2O/g9jxyIwU84YLQwtHl81wmZDrtji/QiQOMOLAHo4DCuO6qs?=
 =?us-ascii?Q?hsC12N0jW/ecCs44vvFkmxsX6skNrYUACR+pvAb70ZkBAsGgLgvFN4h93Kf2?=
 =?us-ascii?Q?MIY0BYJhv86C47xHW857T1cmju3YHEWKbzc0hydyeLvc7o1hoPXpinHafZJY?=
 =?us-ascii?Q?mS5/ImYZmwAZhIYMQZ1SA3YI9rFomjyDWGbmqqiiWWXyziasQMAwuJzZ3+6o?=
 =?us-ascii?Q?2DnCfdSMI3KpiiPcL5U62XWhafhsQrNEUSf3iLF9eVNsmzKYJW6D+dCtsVv4?=
 =?us-ascii?Q?1pJSAelDcsj3u9EfRAZprhhaSf75t8wKvGFkwwqXJnLReMwKtGx9XJtASmvA?=
 =?us-ascii?Q?YZH7SP3+RVTKSlCqo/DWEQLrqteyVtdqNAJluT1sxTXHqXDFe8GIxcY9kas0?=
 =?us-ascii?Q?KC7fDTkRv69xhko0FxF9Vag5MfTd4RTy8kS0QEawF7iaLxjOOs13Fxf0CYAM?=
 =?us-ascii?Q?8Z7c1IOTAWzUwAS9KNqwqOyygc3PyoxRC9t5qXjij6md86zcQSJvASG3MAi4?=
 =?us-ascii?Q?158WC373w3uQwO8so+MMe3UJSMRY+7AlDRT9vcT8CSnoRj/K6XrxWk3wXaPj?=
 =?us-ascii?Q?z3GX30z0eQLgnESyeWJzfROD/nZVAIrqTRT1rBh/aJnSlYHnmIX0uIIGqzlF?=
 =?us-ascii?Q?SrdvhrfFMJLzyXU7SIAcqb3i2a2A9zex/PHSLjrdSriHrDkqhcPwHJ+vPBtd?=
 =?us-ascii?Q?4ryq/R0zsLaP6Yx4pLXVZIJwVMvlkZnraMNyUZ1vVuR74lBwYCd5tOK3Jvi0?=
 =?us-ascii?Q?0wEyYe4CaUZhmn24XLPk7Ty5ZEjYBihBaUBRszHh3sI2s1d9M98/DljkF2oS?=
 =?us-ascii?Q?mmeXq61p5r9MuxgyWxZeP/XJ+C6uQNuCAAe1Qp1EJ74eBLQhnLf1vD3CaIyP?=
 =?us-ascii?Q?1G+7M5hTdijUXFSXG2lVp6zX+K7tvFEVQTaSM1UzmvQL5VtR8n093br6/Cty?=
 =?us-ascii?Q?NzjoO2ZLrDYA7jhhELOUeHSOfbiwigeE0GpgnRZJHIbPOqn7GRptjl5PPits?=
 =?us-ascii?Q?kONMO+mz6J7A+IhjElOc0ls5eXFsqF/0oK5qQEfHdsdv1YLXDFrywuUGfsqY?=
 =?us-ascii?Q?O8LMOxhE7H1/c53ao58RBwuvXqQq0caDyR6pHmXPDSKL1oJaskX09NtPtouM?=
 =?us-ascii?Q?VSafgCMpDm48MyxMFfrv4WNpmAfMjfSFlOWY60D5piRRuu2cMKTKrhVY9QCp?=
 =?us-ascii?Q?ZgFOVmlVMsTWQEo8sj3Uiv8GyQNJ+OYKaKoQSNcNtQeQ3cfXAYQ+/80WMWS1?=
 =?us-ascii?Q?CU7OGGOb6qzG/YTdXC2uG4Ac4M0r2Ovleu8DzV14ViXm1T3Wmj83DRwiX+CC?=
 =?us-ascii?Q?hzf97zlJVvAOrGbK802mAmYQt7/eNnq959Y/XCtj8k1+SguTFzUkuM8FgoIQ?=
 =?us-ascii?Q?mJNBD+ydITnDsRqQY4JEmrFBkuEk7rwEApm7MFBP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23df37d-5e0f-4369-1b0e-08dd547636d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 01:54:46.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmZ1wQ5zlSWIwpWwaznu0nAeS9Qh689Vt0LKpuquhv0lQX55F97SdYjNq9RzhOHR7HTEKCN1L4jjrl8x26Xl/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7622

Hi Rob,
On Wed, Feb 19, 2025 at 03:46:08PM -0600, Rob Herring wrote:
>On Wed, Feb 12, 2025 at 03:40:24PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Add i.MX SCMI Extension protocols bindings for:
>> - Logic Machine Management(LMM) Protocol
>>   intended for boot, shutdown, and reset of other logical machines (LM).
>>   It is usually used to allow one LM to manager another used as an offload
>>   or accelerator engine..
>> - CPU Protocol.
>>   allows an agent to start or stop a CPU. It is used to manage auxiliary
>>   CPUs in an LM (e.g. additional cores in an AP cluster).
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  .../devicetree/bindings/firmware/nxp,imx95-scmi.yaml     | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
>> index 1a95010a546b14b1d3d97aa990c0305a551f2620..75f63819285b191a815dc4287e34d299983b1c40 100644
>> --- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
>> @@ -11,6 +11,14 @@ maintainers:
>>    - Peng Fan <peng.fan@nxp.com>
>>  
>>  properties:
>> +  protocol@80:
>> +    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
>> +    unevaluatedProperties: false
>
>Please add 'description' to these to say what the protocol is.

Waiting for comments on driver changes, then I will fix together in next
version for protocol 80,82 both.

Thanks,
Peng

>
>> +
>> +    properties:
>> +      reg:
>> +        const: 0x80
>> +
>>    protocol@81:
>>      $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
>>      unevaluatedProperties: false
>> @@ -19,6 +27,14 @@ properties:
>>        reg:
>>          const: 0x81
>>  
>> +  protocol@82:
>> +    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        const: 0x82
>> +
>>    protocol@84:
>>      $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
>>      unevaluatedProperties: false
>> 
>> -- 
>> 2.37.1
>> 

