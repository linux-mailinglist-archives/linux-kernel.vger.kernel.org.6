Return-Path: <linux-kernel+bounces-530685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9616FA436CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5D63BBDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4193A215F7E;
	Tue, 25 Feb 2025 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kv2yrPBk"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935C25B669;
	Tue, 25 Feb 2025 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470414; cv=fail; b=vCwovgi1uuKXdzKIqvFQFOPxDj9D8cbIChGb6UTjK25yGB9qtbywTaVwJGH3qcuu+XB/6MmSuS0+GNtcNCpogirfz5syXp+Gm2Z6YS5M4fzb+bB1IzjzVSu2nMYsU9o5ZNhqC9OWmjGcChzSgfCJvPlGUnMETR8p3CO0PaF5g3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470414; c=relaxed/simple;
	bh=lEwZ2bnLSaWh9BcTdhEWfmp54RS5yPeGdeJCXhQoeJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m4UupAQEAjypWHQ+TAgeyUHp89iD67IpRyI9OEiVeZC493a10gnirAzyvF7GgW2ZU3RotgFE7rJcBWdl7XOoaTU4CGSh9jwylAlg4wSOVtfws4Ta58dE4FZldI0Z0WI/PIOCHbUZHvUfUN69yjU3I0HdlSygFepmik/qx9DVTNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kv2yrPBk; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGVf0spAF8T1I1+hCfXU81kmnw0pYVfwS1p6ajjGJs/LpuyEE7pUfEefSW76kFYWDSAPJAqS1F+7Ztl6OiP6a3E2pxHJB9JUS1tXA/CuS3UkNLOjwGXrnPv8FzbaxUHGFmuIRtPVYS8PhniVj/rIiL9doIxcSy4VTKnqA+qwhs67WJFvi0uWc2aMJAWaJBeNQZV4sG9kGpqjpSUkGBANVLfSrtMmG/p+xDSxUw0UF6JybDX3Q/LOMb9EyuiNojOR0gz64uklMsAv2y8V85FyjBTsq1yzA5FtprWuxwURXtSr6A8PgBg2lYJJQbpBH1tEkIWOEFDRLIJohCxRaT2M/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpZhP94DxOhPV/5bJXAP3DLMnD+ujQBYztA+xWZNLew=;
 b=eQMK+XX7b//ckWRRon2MYCd67m72MZOm8/zQoA38plBvo+7KtJ1pzMdBPjhKGkk4s0ld7Qi/PBdJfyCtBm+0YRnzRBNf+PowAMnsyoXpCXztppVKf8c+xMUWMyk5m7ZHN60Rkt+whMoBPeC4L0BQP2iJIs9FlDcGx+bbyxwIfSENDdhlymDDD1cy6gqhjbad3J7Xr4d+sOZDBcgT/j0Fqz7f9dSMqDzInzE9hiznzFdGC9YFWSDPdK0/V6StHPH2Jqh1jx7Z5jJ4uE6SXgDYvwIkcu2yj25Pqhl3+w2Cci21MLIY/vUAHWBiMWsMvcCiaZAye+P8lJ/8fdQAOnD6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpZhP94DxOhPV/5bJXAP3DLMnD+ujQBYztA+xWZNLew=;
 b=kv2yrPBkkugQPQY/0CDgogafgnVMiIGrpBJIWrcsv90Kv0kx134+YfrbdFsexwM64MIVKP4EM/KaL6ve+gYjYmsgOihaYKFT3xOINad+r5q7fAD2jd7+DZa8WtSIk8zwoShJnW8dFXInfzKUwZ0gb8z6iGNnS2v+2EpIju0rsFdPGpKt6PWz3RQUtzXfzwJZs+V8yy1924L7dSWAVFwlZkeZZIs2km8FLrZsXlXI6iHJmPhwUO6hh4bNDXw4jl6vqUxqEt/jkCMQpOWT6U6xCB2cYGmIqHFaCIW3EeosAnBR1gWbKxvEYqH+Bfkg9j5ANMnO1PU+RRRaGQOKgZ/NeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Tue, 25 Feb
 2025 08:00:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Tue, 25 Feb 2025
 08:00:01 +0000
Date: Tue, 25 Feb 2025 17:07:09 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/7] firmware: arm_scmi: imx: Add LMM and CPU
 documentation
Message-ID: <20250225090709.GA25303@nxa18884-linux>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-1-3aee005968c1@nxp.com>
 <Z7xl8h8Sh_UWYbI3@pluto>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xl8h8Sh_UWYbI3@pluto>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4020be2e-d8a5-483d-02bf-08dd5572679b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zzP95g39JjBfnhI8KxyTb9mnoWVDowjkBDZ24F+0A8oLmFnbwfNmZHzMyXo7?=
 =?us-ascii?Q?McQHAZp2M9Seil3oK6BNY8no2iKo1nG5F1X6nr3f8Rry5ZNkpdbwK1Jkz2XW?=
 =?us-ascii?Q?wipdwX1fTUJYbQglAkpCmNh+KHYtjWjuUZiJzt2VDhHgGOiAqP52m+UczBs5?=
 =?us-ascii?Q?ZtZJ0x2GgCLU/ugsjB6zPGjZutw5ZZ+4Rkfrao8U+kamMA6wgq4Kgc5Jx/oP?=
 =?us-ascii?Q?RGXPNdVZxaN5yykjYSjcb2EDJgHx4VewqstI8AlQhJez5XaWlLWt7hep9LHV?=
 =?us-ascii?Q?ZQj+UTEvomlZLRJsUCnPkfpPpEvJXnvQb6lMcVcr7WQaOSxhsoLHKb1G/AF6?=
 =?us-ascii?Q?qm2yITx2JRNRfFVATS8dINfPFCeDnJiWjhdE+Lnrn6KhOzgzZD0bDtynsRw4?=
 =?us-ascii?Q?+zpgHg52RTTadel8ZDctuybssAQyokIxcLHbUqUM6+FXTOLBnk9BT1sfBKeq?=
 =?us-ascii?Q?XrTcL97y8nnclDdd1/uu3QiY4LqXC/OhvVdxABJjDlhgN2ISeNhsQGjC9jwc?=
 =?us-ascii?Q?kg/HmfoqWAJ2rplCWCnuNsU7Z+mahO0pJiX9gV7iEF9+VeCcyQ7lWI1O1zHY?=
 =?us-ascii?Q?ErlaKU1PKRhRob3BNsM0Drf3yoeupiLEaLFOH1C5UFhaORoTeIYKRRYNyoVg?=
 =?us-ascii?Q?HtCGI1CYOvtMEmRinKLXPJbMm0gcp/5YY2/++1C2yI9dyt4rQ99aaKxKijI3?=
 =?us-ascii?Q?U+10p3x+egzmZNsnfoSm/zI+x/mWv1k6+2rQgpscWGcSNuWgjKXT39DY8hcc?=
 =?us-ascii?Q?G+gP0j9ocJH9DhxhelCmc3ZbIBGShMukEpxQpUTNR357UVUMdN0xYiCHsTTr?=
 =?us-ascii?Q?lEzLTIjn1rpC+ajdjX35FhlQRwqbNGr4K0ZfvNKuFM1C6pzbPSf/Ni8Ysey4?=
 =?us-ascii?Q?nTNQr9q398mcHkpwhQIsylxdg4Rac4Obmrdd3wVjKnCrAZQkcTLKaP31zW7C?=
 =?us-ascii?Q?LsRNDvoopjy7xvylD50LLqFgeEOH8UW7FRKgpjFH+x1e5XxNBJVV5Oi6WNxj?=
 =?us-ascii?Q?I+4OW5tyAUTZ2MrI2FDYXUIBkfCkb6I5/+fkgfyQhQQjCrXsaqeCKN65//5b?=
 =?us-ascii?Q?epSOorJDaVSLSwttP7aDf5G0IiBK7JCnu/e1SjfBK9N4YwEjxGOz9gmMjWG8?=
 =?us-ascii?Q?m6oq3mJMmK/Q/ZrQZlcf7dv1uF0NE0CqKwncEgo7wUBF1IN9Sv1jCneglMxM?=
 =?us-ascii?Q?xWjQi1McM6QdaZahI4TN1zUrrhhlMlvUf5V13wVhjs3ek43ytZpEDqe7ew2W?=
 =?us-ascii?Q?QU0iUhoWsJ9viScrPW5UoNfebMsXh2tw6HXp2mPQ8VORXlwyhjym0gZuaNMJ?=
 =?us-ascii?Q?pKcVfCtoYVkjiqpEsW+CO7HX/cKBCX9oU/WbgtPUjsK6+SG1RKFr/ipNDDP1?=
 =?us-ascii?Q?9sDyE1ZTe+GB9J5SZj1J7/Qyq3/ldm6wEa6uKNE4I6haAnRiXGRlnrBb+Aqa?=
 =?us-ascii?Q?NLB2OJv7EXzGPt+SFWE1Zvdkg6VeH3PN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bzHsWoIFY1ax5j1DGxjHXb6eGbtor/nggELUD/qhSZ3RVBk2xeRxT+3pd0re?=
 =?us-ascii?Q?vdhzic3Hjo+zDhOiBIabVcAWRF3yl9VrVPSyFyBx8Rm0385RIoHW8PqSvWce?=
 =?us-ascii?Q?VCQx9W2Xm9I402KqVoupezXTvqqum+1J/dueC7PkCLsUqV4l6Eq3GqiRLLOr?=
 =?us-ascii?Q?47RFlaP411Y9VwdP8GNjtS13y2Ki/fyNS/P4fGr9f/hkaAgCFxpONU86zuck?=
 =?us-ascii?Q?Zvo9rNXiT9n5gWjWTn+0VA0i4qUs6YMWWqk4aQLo+lIlwCmMjVD4AZ80nHfD?=
 =?us-ascii?Q?j9UFJ0hmbMqHLbpRbBcmkHKokKWksFh5h/ncPiflFdvxE3S0rJNuf/U2d8f4?=
 =?us-ascii?Q?qN1eNtPqypFlbMg7WgaK7XSpMO6eGFe8TXqEJlB3Lg1HI7KWC0xQ+TPXCpOt?=
 =?us-ascii?Q?oE6tkwHVbVokiYZ3p/35EUDwrqJj/3Vyon24F88UxTNOO38h+B/4nMZNBJRh?=
 =?us-ascii?Q?zDMopwOQ5Cfbyq5VhHDFnPMUy6DdhRM9UmefovpYX/wO2xM7cM0UO+upY5PZ?=
 =?us-ascii?Q?BClCQ31bhcwVZZ2NmtyD+aycVnaPshlUnyaDkR5h2vr8/59VVG5UKDRwlO0U?=
 =?us-ascii?Q?vcyGz13+Lp3/Mu46YRHZ1qQDBfri4ryAXZ0QLOHtEtlia+AWLUrdOGXCzqxd?=
 =?us-ascii?Q?McCVv/LvW2TBMpyPLIAeqNF+ITS1yQozFrat2dm24gSORHmDxQIBR+gqv/05?=
 =?us-ascii?Q?kOyvAvBM3TlF7LhC4FaWZo2yEDJSEGJvY0CTWwobpogz9Jbpy/l9efY00VuB?=
 =?us-ascii?Q?itopDdDDZgwnWzaOM5dcWyoH+uLKG84i/Zy8k9D6EHS4yu3dlIb99p+de5o7?=
 =?us-ascii?Q?Jf1TSy6RtAFpbNiYOzquQmhEAUffpbTcX0ubzZeSzEMrS/e1gp0PCf26vAX7?=
 =?us-ascii?Q?QgHT/b2aZVmfHPRfAx6ANP1FX+8zy/7+KWUFkOhY1t3Q6hcO4gZVI/WQCOU8?=
 =?us-ascii?Q?hAwc4RjL8svjYypDsl0X9yf2h2kvkUf2S0nMlkcXSTuS8N3QuOSBSUfo6B5S?=
 =?us-ascii?Q?/rFEILG75z4Lt6V++gvACMITglNqpi6p4wb5QAlSgWlDO7IaB1IG8N/3KRtF?=
 =?us-ascii?Q?pL+0LIYf/UsuZKvpXk45KA6EJxQP6Mb4FC5qdKmx3VI9jwJfXrIcxqcSkCZI?=
 =?us-ascii?Q?pavjYKoeiLOVCfRDVp6h2LiquQhspQ27E+jDzl62XuNZ/uklfgPI2y7ObpkT?=
 =?us-ascii?Q?q6mnfXn/AvQJXhH67wbJlmGRhW9ppoqRUlxekrsAihOYXmymDITpPMnptiEr?=
 =?us-ascii?Q?1rULOKSDbz4rVlOrEoTC2gecUwWPRCQarlUTVdgr/Y2nUrF+tojNLFOOVFFS?=
 =?us-ascii?Q?HBvGCuW7FtEiTKbAjyd0Vt4o6X+kE5owjwXH2IU6RQyiZ+xA0Xd6PDzf2BaG?=
 =?us-ascii?Q?3utmo9d56otRyVY57k8W/Oo2NrsMEgsXLsnDWSpMRPyUL6TLXGlRyWS/bkhi?=
 =?us-ascii?Q?2nn9eA8VCI35LLfc370bkDZ+TAuD3+y5Wsod2YWnnq4j08tk8KSzHJzwfc/d?=
 =?us-ascii?Q?LmUKs4+KLP4RrjFjohroOiqrP8L/UzpKoWoJKYabFAFDVK2m2Sg1u9e5RPtb?=
 =?us-ascii?Q?HxzNNdB3sxomdyvFA3QHa0B/DUYAE93pgmVKkeCZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4020be2e-d8a5-483d-02bf-08dd5572679b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:00:01.5787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KY3qKw2+jzvVH9w5vU8uTB7GNcVhKWK/8FGXmSuKTIknivNb8x52sWN8IvC3WHsh1oncC0R3NFbO8OrGGS9Bqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8849

Hi Cristian,

On Mon, Feb 24, 2025 at 12:28:34PM +0000, Cristian Marussi wrote:
>On Wed, Feb 12, 2025 at 03:40:23PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Add i.MX95 Logical Machine Management and CPU Protocol documentation.
>> 
>
>Hi,
>
>a few comments below.
>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 737 ++++++++++++++++++++++++
>>  1 file changed, 737 insertions(+)
>> 
>> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
>> index b2dfd6c46ca2f5f12f0475c24cb54c060e9fa421..78a09cd8102becd5584d28bdef18df2d77fb7e7c 100644
>> --- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
>> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
>> @@ -32,6 +32,461 @@ port, and deploy the SM on supported processors.
>>  The SM implements an interface compliant with the Arm SCMI Specification
>>  with additional vendor specific extensions.
>>  
>
>In general I noticed that there is NOT specified anywhere if all the
>following commands are mandatory or optional in your protocol: would be
>better to be specified, as it is I will assume that are all mandatory.

The Doc from [1] does not specify optional or mandatory, I need check
with firmware owner to see whether this could be added.

[1]https://github.com/nxp-imx/imx-sm

>
>> +SCMI_LMM: System Control and Management Logical Machine Management Vendor Protocol
>> +==================================================================================
>> +
>> +
[...]
>> +PROTOCOL_ATTRIBUTES
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x1
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      | See ARM SCMI Specification for status code definitions.   |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 attributes |Protocol attributes:                                       |
>> +|                  |Bits[31:8] Reserved, must be zero.                         |
>> +|                  |Bits[7:0] Number of Logical Machines                       |
>
>...so this states how many LMs you have...ok...
>
>> ++------------------+-----------------------------------------------------------+
>> +
>> +PROTOCOL_MESSAGE_ATTRIBUTES
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x2
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: in case the message is implemented and available  |
>> +|                  |to use.                                                    |
>> +|                  |NOT_FOUND: if the message identified by message_id is      |
>> +|                  |invalid or not implemented                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 attributes |Flags that are associated with a specific function in the  |
>> +|                  |protocol. For all functions in this protocol, this         |
>> +|                  |parameter has a value of 0                                 |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +LMM_ATTRIBUTES
>> +~~~~~~~~~~~~~~
>> +
>> +message_id: 0x3
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 lmid       |ID of the Logical Machine                                  |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if valid attributes are returned.                 |
>> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
>> +|                  |DENIED: if the agent does not have permission to get info  |
>> +|                  |for the LM specified by lmid.                              |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 attributes | Bits[31:8] reserved.                                      |
>> +|                  | Bits[7:0] Number of Logical Machines.                     |
>
>...BUT this returns again the number of LMs while asking the attributes
>of a specific LM ? .... is it a typo or what ? ...if it is just as a
>sort of placeholder for when you'll have really LM's attributes to show,
>consider that once this is documented and supported in this version of
>your vendor protocol it will be needed to be kept and maintained...maybe
>better just to declare this as zero in this version of the protocol if
>you dont really have anything for this command in this version...(like
>many times are defined the attributes fields in PROTOCOL_MESSAGE_ATTRIBUTES
>above, if you really know you could want/need this command in the
>future...is it used now ?

My bad. This should be updated with below
+------------------+-----------------------------------------------------------+
|uint32 attributes | Bits[31:0] reserved. must be zero                         |
+------------------+-----------------------------------------------------------+
|uint32 state      | Current state of the LM                                   |
+------------------+-----------------------------------------------------------+
|uint32 errStatus  | Last error status recorded                                |
+------------------+-----------------------------------------------------------+
|char name[16]     | A NULL terminated ASCII string with the LM name, of up    |
|                  | to 16 bytes                                               |
+------------------+-----------------------------------------------------------+

>
>> ++------------------+-----------------------------------------------------------+
>> +
>> +LMM_BOOT
>> +~~~~~~~~
>> +
>> +message_id: 0x4
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 lmid       |ID of the Logical Machine                                  |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if LM successfully booted.                        |
>
>...this and other commands below that cause a transition are a bit
>ambiguos in their description IMHO...does this mean that on reception of
>a SUCCESS the LM identified by lmid has successfully completed the boot ?
>
>...or, as I suppose, this being an immmediate command, SUCCESS means something
>like 'boot succesfully started', NOT that when this SUCCESS reply comes back the
>LM has booted...also becuse I can see a lot of notifications defined down below to
>signal the completion of such operations...
>
>..if this is the case please clarify...

right. This means the LM has been boot successfully started. Not means
LM fully function up.

I will updated this with "SUCCESS: if LM boots successfully started"


>
>...if this is NOT the case and this is intended to return synchronoulsy
>when the required operation has completed, even though such machines are
>maybe (?) minimal/tiny compute systems, can you guarantee that they can boot/shutdown
>etc in a reasonably short time not to hog the channel for too long (I mean
>well before the configured transport timeout)...
>
>> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
>> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
>> +|                  |DENIED: if the agent does not have permission to manage the|
>> +|                  |the LM specified by lmid.                                  |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +LMM_RESET
>> +~~~~~~~~~
>> +
>> +message_id: 0x5
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 lmid       |ID of the Logical Machine                                  |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 flags      |Reset flags:                                               |
>> +|                  |Bits[31:1] Reserved, must be zero.                         |
>> +|                  |Bit[0] Graceful request:                                   |
>> +|                  |Set to 1 if the request is a graceful request.             |
>> +|                  |Set to 0 if the request is a forceful request.             |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if LM successfully resets.                        |
>
>Same ... does this simply mean LM reset issued successfully ?

For graceful reset, platform will issue a notification to agent and just return,
agent will do the reset, as linux reboot.
For forceful reset, platform will do the force reset of agent, this is longer
time.

I will update with "The LMM RESET command finished successfully in graceful reset
or LM successfully resets in forceful reset"

>
>> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
>> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
>> +|                  |DENIED: if the agent does not have permission to manage the|
>> +|                  |the LM specified by lmid.                                  |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +LMM_SHUTDOWN
>> +~~~~~~~~~~~~
>> +
>> +message_id: 0x6
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 lmid       |ID of the Logical Machine                                  |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 flags      |Reset flags:                                               |
>> +|                  |Bits[31:1] Reserved, must be zero.                         |
>> +|                  |Bit[0] Graceful request:                                   |
>> +|                  |Set to 1 if the request is a graceful request.             |
>> +|                  |Set to 0 if the request is a forceful request.             |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if LM successfully shutdowns.                     |
>
>Same...I suppose the shutdown has been sucessfully issued and could be
>still in progress...if this is not the case I fear this immediate
>command will potentially hog the channel for too long....

For graceful shutdown, platform will issue a notification to agent and just return,
agent will do shutdown.
For forceful shutdown, platform will do the force shutdown of agent, this is longer
time.

I will update with "The LMM shutdown command finished successfully in graceful request 
or LM successfully shutdown in forceful request"

>
>> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
>> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
>> +|                  |DENIED: if the agent does not have permission to manage the|
>> +|                  |the LM specified by lmid.                                  |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +LMM_WAKE
>> +~~~~~~~~
>> +
>> +message_id: 0x7
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 lmid       |ID of the Logical Machine                                  |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if LM successfully wakes.                         |
>
>Same...I suppose you can know when an LM is fully woken only from the
>dedicated notification receipt...

I will updated this with "SUCCESS: if LM wake command successfully returns"

>
>> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
>> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
>> +|                  |DENIED: if the agent does not have permission to manage the|
>> +|                  |the LM specified by lmid.                                  |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +LMM_SUSPEND
>> +~~~~~~~~~~~
>> +
>> +message_id: 0x8
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 lmid       |ID of the Logical Machine                                  |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if LM successfully suspends.                      |
>
>Same..I suppose the SCMI server will know when the suspend for this LM is
>effective and will send a notification, so this is again only an indication
>that the suspend process has started...

Right.
I will updated this with "SUCCESS: if LM suspend command successfully returns"

>
>> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
>> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
>> +|                  |DENIED: if the agent does not have permission to manage the|
>> +|                  |the LM specified by lmid.                                  |
>> ++------------------+-----------------------------------------------------------+
>> +
>
>In general, you could also think to make the bahvour of all this
>operation configurable like teh RESET protocol does...so you could ask
>for an LMM op to complete synchronously OR instead let it happen
>asynchnously in the background after the command-request has completed
>and then wait for one of the existing notification...
>
>...again if this is already the expected behaviour please clarifiy the sync/async
>kind of execution that is expected when you issue such commands

Yes, for graceful, it is async; for forceful, it is sync.
If command not has graceful/forceful, such as lm wake/suspend, it is async

>
>> +LMM_NOTIFY
>> +~~~~~~~~~~
>> +
>> +message_id: 0x9
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 lmid       |ID of the Logical Machine                                  |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 flags      |Notification flags:                                        |
>> +|                  |Bits[31:3] Reserved, must be zero.                         |
>> +|                  |Bit[3] Wake (resume) notification:                         |
>> +|                  |Set to 1 to send notification.                             |
>> +|                  |Set to 0 if no notification.                               |
>> +|                  |Bit[2] Suspend (sleep) notification:                       |
>> +|                  |Set to 1 to send notification.                             |
>> +|                  |Set to 0 if no notification.                               |
>> +|                  |Bit[1] Shutdown (off) notification:                        |
>> +|                  |Set to 1 to send notification.                             |
>> +|                  |Set to 0 if no notification.                               |
>> +|                  |Bit[0] Boot (on) notification:                             |
>> +|                  |Set to 1 to send notification.                             |
>> +|                  |Set to 0 if no notification                                |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if the notification state successfully updated.   |
>> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
>> +|                  |INVALID_PARAMETERS: if input attributes flag specifies     |
>> +|                  |unsupported or invalid configurations.                     |
>> +|                  |DENIED: if the agent does not have permission to request   |
>> +|                  |the notification.                                          |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +LMM_RESET_REASON
>> +~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0xA
>> +protocol_id: 0x80
>
>What is this...a bit of explanation would be fine given that this
>command is not straightforward to understand like the previous
>boot/suspend etc...

This function returns the boot/shutdown/reset reason for an LM.

Such as POR, WDOG and etc.

>
>> +
>> ++---------------------+--------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++---------------------+--------------------------------------------------------+
>> +|Name                 |Description                                             |
>> ++---------------------+--------------------------------------------------------+
>> +|uint32 lmid          |ID of the Logical Machine                               |
>> ++---------------------+--------------------------------------------------------+
>> +|Return values                                                                 |
>> ++---------------------+--------------------------------------------------------+
>> +|Name                 |Description                                             |
>> ++---------------------+--------------------------------------------------------+
>> +|int32 status         |SUCCESS: if LM successfully suspends.                   |
>
>? typo ?

Sorry. This should be "the reset reason of the LM successfully updated"

>
>> +|                     |NOT_FOUND: if lmId not points to a valid logical machine|
>> +|                     |DENIED: if the agent does not have permission to request|
>> +|                     |the reset reason.                                       |
>> ++---------------------+--------------------------------------------------------+
>> +|uint32 bootflags     |Boot reason flags. This parameter has the format:       |
>> +|                     |Bits[31] Valid.                                         |
>> +|                     |Set to 1 if the entire reason is valid.                 |
>> +|                     |Set to 0 if the entire reason is not valid.             |
>> +|                     |Bits[30:29] Reserved, must be zero.                     |
>> +|                     |Bit[28] Valid origin:                                   |
>> +|                     |Set to 1 if the origin field is valid.                  |
>> +|                     |Set to 0 if the origin field is not valid.              |
>> +|                     |Bits[27:24] Origin.                                     |
>
>Are this origin values defined anywhere ?

It varies in the current imx-sm implementation, there is no spec
defining this, it could be a LMID or BBM register value or else.

>
>> +|                     |Bit[23] Valid err ID:                                   |
>> +|                     |Set to 1 if the error ID field is valid.                |
>> +|                     |Set to 0 if the error ID field is not valid.            |
>
>And this errors ID ? which value should I expect here...and to what this
>errors refer to...
>
>> +|                     |Bits[22:8] Error ID.                                    |

There is not doc defining this. It just varies,
It could be BBM button, agentID, faultID or a peripheral ID or else.

>> +|                     |Bit[7:0] Reason(WDOG, POR, FCCU and etc)                |
>> ++---------------------+--------------------------------------------------------+
>> +|uint32 shutdownflags |Shutdown reason flags. This parameter has the format:   |
>> +|                     |Bits[31] Valid.                                         |
>> +|                     |Set to 1 if the entire reason is valid.                 |
>> +|                     |Set to 0 if the entire reason is not valid.             |
>> +|                     |Bits[30:29] Number of valid extended info words.        |
>> +|                     |Bit[28] Valid origin:                                   |
>> +|                     |Set to 1 if the origin field is valid.                  |
>> +|                     |Set to 0 if the origin field is not valid.              |
>
>Ditto.
>> +|                     |Bits[27:24] Origin.                                     |
>> +|                     |Bit[23] Valid err ID:                                   |
>> +|                     |Set to 1 if the error ID field is valid.                |
>> +|                     |Set to 0 if the error ID field is not valid.            |
>> +|                     |Bits[22:8] Error ID.                                    |
>Ditto.
>> +|                     |Bit[7:0] Reason                                         |
>Ditto.

I will check imx-sm code and add more info for upper all three,
but there is no documentation and it varies in imx-sm code repo.

>> ++---------------------+--------------------------------------------------------+
>> +|uint32 extinfo[0,20] |Array of extended info words(e.g. fault pc)             |
>> ++---------------------+--------------------------------------------------------+
>
>..so what does this field represent....is this a fixed sized array ? seems more likely
>to be dynamically sized in range [0,20] AFAICU...

This should be updated with "extinfo[3]". The length has been speicified in 
"Bits[30:29] Number of valid extended info words."

>
>...now...if it is dynamically sized:
>
>+ there should be a size field declaring the size of the returned
>answer, if not you should rely on the transport size to know where the
>message ends (unless if hard-coded based on the above flags...in that
>case explain and document)

already specified in shutdownflags BITS[30:29]

>
>+ you cannot assume that such a potentially big reply reply fit into a
>single message due to possible limitations of the transport
>sizes...IOW you should think about a 'multi-part' message like many
>exist in SCMI where the reply reports returned+remaining entries...
>..how can yo be sure to fit in any transport...this message has
>currently a potential max payload reply of 96 bytes ...
>
>> +
>> +LMM_POWER_ON
>> +~~~~~~~~~~~~
>> +
>> +message_id: 0xB
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 lmid       |ID of the Logical Machine                                  |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if LM successfully powers on.                     |
>
>Beside the same consideration as above regarding what this SUCCESS
>mean...what is meant to be the difference between LMM_POWER_ON and LMM_BOOT ?

POWER ON, it is just power up, not means the LMM is kicked out to boot.
BOOT, means LMM is kicked out to boot

For example, CPU has power and reset release function.
power on, means power up the CPU
boot, means reset release to let CPU run.

Especially for Cortex-M core, the TCM is in same power domain
as Cortex-M. before booting the core, need power up the core to loading
images to TCM, then boot the core.

>
>> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
>> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
>> +|                  |DENIED: if the agent does not have permission to manage the|
>> +|                  |the LM specified by lmid.                                  |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +LMM_RESET_VECTOR_SET
>> +~~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0xC
>> +protocol_id: 0x80
>> +
>> ++-----------------------+------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++-----------------------+------------------------------------------------------+
>> +|Name                   |Description                                           |
>> ++-----------------------+------------------------------------------------------+
>> +|uint32 lmid            |ID of the Logical Machine                             |
>> ++-----------------------+------------------------------------------------------+
>> +|uint32 cpuid           |ID of the CPU inside the LM                           |
>> ++-----------------------+------------------------------------------------------+
>> +|uint32 flags           |Reset vector flags                                    |
>> +|                       |Bits[31:1] Reserved, must be zero.                    |
>> +|                       |Bit[0] Table flag.                                    |
>> +|                       |Set to 1 if vector is the vector table base address   |
>
>So what is this when Bit[0] is set to zero instead ?

Per current imx-sm, this flags is not used as of now, just a reserved
flag for future extension. So 0 or 1 does not matter here.
I will update with Bits[31:0] Reserved.

>
>> ++-----------------------+------------------------------------------------------+
>> +|uint32 resetVectorLow  |Lower vector                                          |
>> ++-----------------------+------------------------------------------------------+
>> +|uint32 resetVectorHigh |Higher vector                                         |
>> ++-----------------------+------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if LM successfully powers on.                     |
>
>...typo ?...

"If reset vector is set successfully"

>
>> +|                  |NOT_FOUND: if lmId not points to a valid logical machine,  |
>> +|                  |or cpuId is not valid.
>> +|                  |INVALID_PARAMETERS: if reset vector is invalid.            |
>> +|                  |DENIED: if the agent does not have permission to set the   |
>> +|                  |the reset vector for the CPU in the LM.                    |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +NEGOTIATE_PROTOCOL_VERSION
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x10
>> +protocol_id: 0x80
>> +
>> ++--------------------+---------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++--------------------+---------------------------------------------------------+
>> +|Name                |Description                                              |
>> ++--------------------+---------------------------------------------------------+
>> +|uint32 version      |The negotiated protocol version the agent intends to use |
>> ++--------------------+---------------------------------------------------------+
>> +|Return values                                                                 |
>> ++--------------------+---------------------------------------------------------+
>> +|Name                |Description                                              |
>> ++--------------------+---------------------------------------------------------+
>> +|int32 status        |SUCCESS: if the negotiated protocol version is supported |
>> +|                    |by the platform. All commands, responses, and            |
>> +|                    |notifications post successful return of this command must|
>> +|                    |comply with the negotiated version.                      |
>> +|                    |NOT_SUPPORTED: if the protocol version is not supported. |
>> ++--------------------+---------------------------------------------------------+
>> +
>> +Notifications
>> +_____________
>> +
>> +LMM_EVENT
>> +~~~~~~~~~
>> +
>> +message_id: 0x0
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 lmid       |Identifier for the LM that caused the transition.          |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 eventlm    |Identifier for the LM the event is for.                    |
>
>So this is the LM that the event refer to ? i.e. this LM eventlm is the
>one that is booting/resetting/shutdown ? 
>if this is the case, maybe better as:
>
>	"Identifier of the LM this event refers to."

Thanks, will update as you suggest.

>
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 flags      |LM events:                                                 |
>> +|                  |Bits[31:3] Reserved, must be zero.                         |
>> +|                  |Bit[3] Wake (resume) event:                                |
>> +|                  |1 LM has awakened.                                         |
>> +|                  |0 not a wake event.                                        |
>> +|                  |Bit[2] Suspend (sleep) event:                              |
>> +|                  |1 LM has suspended.                                        |
>> +|                  |0 not a suspend event.                                     |
>> +|                  |Bit[1] Shutdown (off) event:                               |
>> +|                  |1 LM has shutdown.                                         |
>> +|                  |0 not a shutdown event.                                    |
>> +|                  |Bit[0] Boot (on) event:                                    |
>> +|                  |1 LM has booted.                                           |
>> +|                  |0 not a boot event.                                        |
>> ++------------------+-----------------------------------------------------------+
>> +
>>  SCMI_BBM: System Control and Management BBM Vendor Protocol
>>  ==============================================================
>>  
>> @@ -436,6 +891,288 @@ protocol_id: 0x81
>>  |                  |0 no button change detected.                               |
>>  +------------------+-----------------------------------------------------------+
>>  
>> +SCMI_CPU: System Control and Management CPU Vendor Protocol
>> +==============================================================
>> +
>> +This protocol allows an agent to start or stop a CPU. It is used to manage
>> +auxiliary CPUs in an LM (e.g. additional cores in an AP cluster or
>> +Cortex-M cores).
>> +Note: For cores in AP cluster, ATF will use CPU protocol to handle them.
>
>So this is sort of a PSCI-by-proxy in which you ask the server to turn
>on/off some of the LM CPUs ?

Yes. A55 cores are in one LM, so in ATF one A55 use cpu protocol to manage other
A55 cores.

>
>First question would be is not enough to just ask for a specific LM to
>be booted with LMM ? or add to the LMM protocol a way to specifiy the

LMM is a large scope, CPU could be inside LMM.

>'level' of boot that you ask for an LM...I may miss many details but it
>seems to me a bit odd that you are allowd to ask, from the agent that
>could have just requested an LM to boot to have some CPUs ON or OFF...
>...and specify the boot/resume address vectors here to use when turning
>ON...

There is case the M7 and A55 are in the same LM, so in such case, if A55 core
needs to manage M7, need use CPU protocol.

If A55 and M7 are in two separate LMs, A55 needs use LMM protocol to manage
M7 LM.

>
>Maybe a bit more of explanation of the rationale and expectations here
>could help understanding the differet needs from LMM

There are some internal discussion between NXP and ARM if you search
your mail "NXP-ARM SCMI OEM extension".

I could not post them all here.

>
>> +
>> +The CPU protocol provides functions to:
>> +
>> +- Describe the protocol version.
>> +- Discover implementation attributes.
>> +- Discover the CPUs defined in the system.
>> +- Start a CPU.
>> +- Stop a CPU.
>> +- Set the boot and resume addresses for a CPU.
>> +- Set the sleep mode of a CPU.
>> +- Configure wake-up sources for a CPU.
>> +- Configure power domain reactions (LPM mode and retention mask) for a CPU.
>> +- The CPU IDs can be found in the CPU section of the SoC DEVICE: SM Device
>> +  Interface. They can also be found in the SoC RM. See the CPU Mode Control
>> +  (CMC) list in General Power Controller (GPC) section.
>> +
>> +CPU settings are not aggregated and setting their state is normally exclusive
>> +to one client.
>> +
>> +Commands:
>> +_________
>> +
>> +PROTOCOL_VERSION
>> +~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x0
>> +protocol_id: 0x82
>> +
>> ++---------------+--------------------------------------------------------------+
>> +|Return values                                                                 |
>> ++---------------+--------------------------------------------------------------+
>> +|Name           |Description                                                   |
>> ++---------------+--------------------------------------------------------------+
>> +|int32 status   | See ARM SCMI Specification for status code definitions.      |
>> ++---------------+--------------------------------------------------------------+
>> +|uint32 version | For this revision of the specification, this value must be   |
>> +|               | 0x10000.                                                     |
>> ++---------------+--------------------------------------------------------------+
>> +
>> +PROTOCOL_ATTRIBUTES
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x1
>> +protocol_id: 0x82
>> +
>> ++---------------+--------------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      | See ARM SCMI Specification for status code definitions.   |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 attributes |Protocol attributes:                                       |
>> +|                  |Bits[31:16] Reserved, must be zero.                        |
>> +|                  |Bits[15:0] Number of CPUs                                  |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +PROTOCOL_MESSAGE_ATTRIBUTES
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x2
>> +protocol_id: 0x82
>> +
>> ++---------------+--------------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: in case the message is implemented and available  |
>> +|                  |to use.                                                    |
>> +|                  |NOT_FOUND: if the message identified by message_id is      |
>> +|                  |invalid or not implemented                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 attributes |Flags that are associated with a specific function in the  |
>> +|                  |protocol. For all functions in this protocol, this         |
>> +|                  |parameter has a value of 0                                 |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +CPU_ATTRIBUTES
>> +~~~~~~~~~~~~~~
>> +
>> +message_id: 0x4
>> +protocol_id: 0x82
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 cpuid      |Identifier for the CPU                                     |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if valid attributes are returned successfully.    |
>> +|                  |NOT_FOUND: if the cpuid is not valid.                      |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 attributes |Bits[31:0] Reserved, must be zero                          |
>> ++------------------+-----------------------------------------------------------+
>> +|char name[16]     |NULL terminated ASCII string with CPU name up to 16 bytes  |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +CPU_START
>> +~~~~~~~~~
>> +
>> +message_id: 0x4
>> +protocol_id: 0x82
>> +
>
>Any constraint to call this only after having successfully called RESET_VECROR_SET ?

No constraint, if not called RESET_VECROR_SET, it will use default value 0.

>
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 cpuid      |Identifier for the CPU                                     |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if the cpu is started successfully.               |
>> +|                  |NOT_FOUND: if cpuid is not valid.                          |
>> +|                  |DENIED: the calling agent is not allowed to start this CPU.|
>> ++------------------+-----------------------------------------------------------+
>> +
>> +CPU_STOP
>> +~~~~~~~~
>> +
>> +message_id: 0x5
>> +protocol_id: 0x82
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 cpuid      |Identifier for the CPU                                     |
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if the cpu is started successfully.               |
>> +|                  |NOT_FOUND: if cpuid is not valid.                          |
>> +|                  |DENIED: the calling agent is not allowed to stop this CPU. |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +CPU_RESET_VECTOR_SET
>> +~~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x6
>> +protocol_id: 0x82
>> +
>> ++----------------------+-------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++----------------------+-------------------------------------------------------+
>> +|Name                  |Description                                            |
>> ++----------------------+-------------------------------------------------------+
>> +|uint32 cpuid          |Identifier for the CPU                                 |
>> ++----------------------+-------------------------------------------------------+
>> +|uint32 flags          |Reset vector flags:                                    |
>> +|                      |Bit[31] Resume flag.                                   |
>> +|                      |Set to 1 to update the reset vector used on resume.    |
>> +|                      |Bit[30] Boot flag.                                     |
>> +|                      |Set to 1 to update the reset vector used for boot.     |
>> +|                      |Bits[29:1] Reserved, must be zero.                     |
>> +|                      |Bit[0] Table flag.                                     |
>> +|                      |Set to 1 if vector is the vector table base address.   |
>> ++----------------------+-------------------------------------------------------+
>> +|uint32 resetVectorLow |Lower vector:                                          |
>> +|                      |If bit[0] of flags is 0, the lower 32 bits of the      |
>> +|                      |physical address where the CPU should execute from on  |
>> +|                      |reset. If bit[0] of flags is 1, the lower 32 bits of   |
>> +|                      |the vector table base address                          |
>> ++----------------------+-------------------------------------------------------+
>> +|uint32 resetVectorhigh|Upper vector:                                          |
>> +|                      |If bit[0] of flags is 0, the upper 32 bits of the      |
>> +|                      |physical address where the CPU should execute from on  |
>> +|                      |reset. If bit[0] of flags is 1, the upper 32 bits of   |
>> +|                      |the vector table base address                          |
>> ++----------------------+-------------------------------------------------------+
>> +|Return values                                                                 |
>> ++----------------------+-------------------------------------------------------+
>> +|Name                  |Description                                            |
>> ++----------------------+-------------------------------------------------------+
>> +|int32 status          |SUCCESS: if the CPU reset vector is set successfully.  |
>> +|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
>> +|                      |INVALID_PARAMETERS: the requested vector type is not   |
>> +|                      |supported by this CPU.                                 |
>> +|                      |DENIED: the calling agent is not allowed to set the    |
>> +|                      |reset vector of this CPU                               |
>> ++----------------------+-------------------------------------------------------+
>> +
>> +CPU_SLEEP_MODE_SET
>> +~~~~~~~~~~~~~~~~~~
>> +message_id: 0x7
>> +protocol_id: 0x82
>> +
>> ++----------------------+-------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++----------------------+-------------------------------------------------------+
>> +|Name                  |Description                                            |
>> ++----------------------+-------------------------------------------------------+
>> +|uint32 cpuid          |Identifier for the CPU                                 |
>> ++----------------------+-------------------------------------------------------+
>> +|uint32 flags          |Sleep mode flags:                                      |
>> +|                      |Bits[31:1] Reserved, must be zero.                     |
>> +|                      |Bit[0] IRQ mux:                                        |
>> +|                      |If set to 1 the wakeup mux source is the GIC, else if 0|
>> +|                      |then the GPC                                           |
>
>What is the GPC in this context ?

General Power Controller.

>
>> ++----------------------+-------------------------------------------------------+
>> +|uint32 sleepmode      |target sleep mode                                      |
>
>What values can this assume ? Is there any predefined sleep value here ?

From imx-sm, the define is hardware related. I could list in next version.

#define CPU_SLEEP_MODE_RUN      0U
#define CPU_SLEEP_MODE_WAIT     1U
#define CPU_SLEEP_MODE_STOP     2U
#define CPU_SLEEP_MODE_SUSPEND  3U

RUN, WAIT, STOP, SUSPEND is GPC concept. it means when wfi, the GPC will
do what action.

>
>> ++----------------------+-------------------------------------------------------+
>> +|Return values                                                                 |
>> ++----------------------+-------------------------------------------------------+
>> +|Name                  |Description                                            |
>> ++----------------------+-------------------------------------------------------+
>> +|int32 status          |SUCCESS: if the CPU sleep mode is set successfully.    |
>> +|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
>> +|                      |INVALID_PARAMETERS: the sleepmode or flags is invalid. |
>> +|                      |DENIED: the calling agent is not allowed to configure  |
>> +|                      |the CPU                                                |
>> ++----------------------+-------------------------------------------------------+
>> +
>> +CPU_INFO_GET
>> +~~~~~~~~~~~~
>> +message_id: 0xC
>> +protocol_id: 0x82
>> +
>> ++----------------------+-------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++----------------------+-------------------------------------------------------+
>> +|Name                  |Description                                            |
>> ++----------------------+-------------------------------------------------------+
>> +|uint32 cpuid          |Identifier for the CPU                                 |
>> ++----------------------+-------------------------------------------------------+
>> +|Return values                                                                 |
>> ++----------------------+-------------------------------------------------------+
>> +|Name                  |Description                                            |
>> ++----------------------+-------------------------------------------------------+
>> +|int32 status          |SUCCESS: if valid attributes are returned successfully.|
>> +|                      |NOT_FOUND: if the cpuid is not valid.                  |
>> ++----------------------+-------------------------------------------------------+
>> +|uint32 runmode        |Run mode for the CPU                                   |
>
>What are the possible runmode values ?

#define CPU_RUN_MODE_START      0U // start cpu
#define CPU_RUN_MODE_HOLD       1U // power up and hold cpu
#define CPU_RUN_MODE_STOP       2U // reset and hold cpu
#define CPU_RUN_MODE_SLEEP      3U // in cpuidle

Appreciate for detailed reviewing on the documentation.

Thanks,
Peng

