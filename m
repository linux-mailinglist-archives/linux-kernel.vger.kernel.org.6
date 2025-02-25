Return-Path: <linux-kernel+bounces-530731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C2A4379A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5923119C1F05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BAC26562A;
	Tue, 25 Feb 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JImtCaMr"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE03260A3D;
	Tue, 25 Feb 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471743; cv=fail; b=LVHef6Gpvtp1EDSuBQJ9PJNXoOQPfH/Dk2JqsutodIqNsyavmcPBKCoktAj+rtgSnoc6rG8nJfAdeVtZEC+gJKASYhkjv5rOZwECLuFaYfyqYrpaunMtFIy2Kk9/wWPP9rZDo51RG56bt0D0KQJ0GSocK6xvHQx5eoQNU+WOnyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471743; c=relaxed/simple;
	bh=7GfpQLfdFytUCbgy5H8NOQRxWP67mKPLILHIy9Bt6FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lLUycGkKZbXsg5GTIeQNPqV/vNh229Lz8vLfD+DXjhEidbJp3qJWsw4KJiKHSXLvn6AWn/IGWULfEe6dpoLxwAjj4TVZoGyCljxT5T72TbrwMTZtIgJYGHCduRrPwKr8DPEGwIVEiM7f5+J2lmwwQHxqZwsW4YzAJF8bwMhxG7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JImtCaMr; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr/CsW7XnuBJz1GNcfE2LxcM4ueWO90ibbAFwYcSwmkq4H3uOAER1jAyB/UO89DVt5gKuf6CnIw0MoPrCVhAyHsF58fWUbC3sDM9z2qBEsKSJKCrMfyR5XOZorKBo/S5L9hAA2HeA+orAdn1tiKxZwUfnRJ4/TXKi3fghWI3Bl0rWE/TDLn9A2b28pX+VDE7pbxXOKeLqfAMVBtZhhLn21SmY6kDNPdxmzorAYNfylp08stlUBcH7q7AIjJV9GQT4j8heF86SEsAevmEPI+8Ct58YDvh98YvoJjRcWd+IXz6soBcpgv3vrYpgqiwhrfK2x6NRMTGktGcwG0Ci7Wwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kFTwDZywxNwl16E/jTVTOIz/6Og9/wrf7SLe5AFPcQ=;
 b=kdb5Lep6+yimzRYx4NEv2spxPR3SCMSxD60oUk+LwtsImGPm815f8mpkzn1EU5eo97Xfai49SfaIhuvsFPx2YeKsT0m6UpwqJcOubviLjRydv/yfOASb90MATbx95j3Gg7B6pGMBgHjwo7hORWnJ7TnEiEXiWpopRBzjX1mkOpEm18uKELLEkdNI/UJ9bj80Jnv+r3+E6xRBukElspFDP0i4yRXfOyAVcUeKibbBfeCF5ZBEqFqqdHda6CeOj1PO/me2HMFYHUby4GbRuCI+XxuB8/jyQ8E5yI/saTyLjyuU30aG80UREP64gJUv7l9ro4cjKOIVDx46qrgCzd70sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kFTwDZywxNwl16E/jTVTOIz/6Og9/wrf7SLe5AFPcQ=;
 b=JImtCaMrjEUrgGnvp7syKKUm84KsF1mbpzobKmi/5jS97t0428CQJRPZyXbR2YZ7K1queVosiLFUoTCsWCS22rRhtuGQWSFR3chmxlLsITQMzFqEjA3m/jyxyxbgZk8ZlI+eLYqUYsyww6/KWIotfwOfwrSO2IeHi/mFx5sf1yiwJkvrbp8P4Y4N9lJ1RatHfa850dPvkHSaTiPejUYuiHpo9aNGowyIchQN+g669Mz3apaCB6nZ2iMC/U/opto1pFI6nUto8ZQLWd9IR9rjV2p+9nzfqYr+XbWeARqA3wY6HXGQxq38lJr5uhf9jtDfVqeCUemELIBUy1JoiWOiaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9206.eurprd04.prod.outlook.com (2603:10a6:20b:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 08:22:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Tue, 25 Feb 2025
 08:22:17 +0000
Date: Tue, 25 Feb 2025 17:29:31 +0800
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
Subject: Re: [PATCH v2 4/7] firmware: arm_scmi: imx: Add i.MX95 CPU Protocol
Message-ID: <20250225092930.GC25303@nxa18884-linux>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-4-3aee005968c1@nxp.com>
 <Z7y2KFYt5gIY19Qz@pluto>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7y2KFYt5gIY19Qz@pluto>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: ace7f5b9-dd93-4843-fcfd-08dd55758405
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fkNo4AN5ebPIDZukItohqT38+dExrLuYM19WyWVWdUFfBCdqK2oCxNBV7sCp?=
 =?us-ascii?Q?U13UN6tG4rJdhPHCbtOqoK0x2FuwxztG75cDnBIoBuCWrHAYRml6g6Qa6ocH?=
 =?us-ascii?Q?USfF6bxrnbE0DCQE4Sr6pf0LEyVQwh/msLg5i1FB+B75QOJ3MBuMXccMoRfC?=
 =?us-ascii?Q?kBNqpT9wgLPCrjPptGGjPK8GiVviHf+m9H7BZ+BGwmvOtUViDys2K8ZHyURQ?=
 =?us-ascii?Q?hlmBkI7ldl4Wvn1Wio2P7Mu/aXRFWB1cqDENP0+b7OQgUJ1N8ayYef90YVE0?=
 =?us-ascii?Q?kVnEku/Hjyw7IQXthKxSqm1VtfrAQKEBK6VogvIgscNnoUChZnwE++Jny0DC?=
 =?us-ascii?Q?ohHk8SRMHIY81WlGbZUoZ2O7rHgE50dntFaMEV+IK2gcSyaKAZ9lBp6nYyA2?=
 =?us-ascii?Q?ZrBUlhFYYl0Y/eMVwKeLPGa9wFbvXWILt7h5E2O6STRoiOsRYnbUcvU58lsh?=
 =?us-ascii?Q?SNfKS7f4GMfP50S09MOZhJBEmp4//Y5+W/zImA5EnnaQ5C0Jhkve5KFspsOe?=
 =?us-ascii?Q?rm54f65psa6TMDUFYmNa7CFPHcNo9bIed7p3DTfohUG0vYhFP25PX2BR+Tko?=
 =?us-ascii?Q?WMuvB4w7nJnTPpInUjPngGRGAYCkerrlDuXRWA5i6qFO38wbylfaQMHvDi98?=
 =?us-ascii?Q?DHkvgSbEkj++zGBuFwe5DAo9PpeJSNVeGTcV8986RATp1UVDRKVERmZiiNM7?=
 =?us-ascii?Q?XT4yz1/TUKoKDtTbCZjM7d2Sfj7jcGbZZ5LV1yxqTv3v3dmebN2tkzJY/heA?=
 =?us-ascii?Q?9lKm9M4maTrfySdOdOLPIk2iQX+u9nclL91ePpLYmt+MPn2tODqHmVeaOLd1?=
 =?us-ascii?Q?col1asg0fG/vS/9e20NlRYwaprp5tYpymnSJNn8wGHZ1KGD6qa1oFns90tSh?=
 =?us-ascii?Q?75eDQ5lapAKAVqIeA6fWhqMSjXE/SLuPyY1w9P//Lz072J8kspxwXCgnYCQR?=
 =?us-ascii?Q?UfYnM8fT3GQqRWROpHnvg8xbl+FOIrO2th5JLSY1BvF3CDlU1GpMCr4+PnMT?=
 =?us-ascii?Q?+ew39EFMvq6dBTZAEI1uf2kYQnvT96pwZmjMKbOWf/RhVgm+2wRgRWooiPZd?=
 =?us-ascii?Q?/yNtZfJ+EG1roOvwIe/KsG6az7a7zn6HUsFbKIQKPXts0Fy8pTx/GHwj2XXP?=
 =?us-ascii?Q?SXi2r80agfjBNd9DHCoRlnlAxmVvAtKWxmrlHLBAtfISX7B+KxdNi7aeKkON?=
 =?us-ascii?Q?t3J0i2PYsZTaCRM7rYI/2VhN9ZPXOUqTmoZOOOhG7lXHMyqbAa4LclDPiF1M?=
 =?us-ascii?Q?M7j54eyJGW8A4B2Z6c/yUY2GoWRazMmOTmm+LgRUTNcBHNiejK/z2q9CVdDs?=
 =?us-ascii?Q?PcSLN+D5yUXYPbEbyxPxJ+u9exY9/g0LbvqrjS+VocuF6sB+BHvimJIlxbzf?=
 =?us-ascii?Q?Q2VV9fsD0OZux1S2JO7fbmYb5/u7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iby9KsdqT+LY/jrb87+q9WYtpOGbKKGbNSZPg8p55wvQqlA9hq906VEav2gK?=
 =?us-ascii?Q?GuFLXALzVMhNOkWD/SxElyMy8bMMpocjkZSRrlNtwrP0iyzRRccdIjCDNoYg?=
 =?us-ascii?Q?vgHzgpvJSh3H3VMXMZc9FTeE7u+4Wt8FSaq9ycJnUon6aH0jxvVmUhd5iZt3?=
 =?us-ascii?Q?xjRurCnnIOc623tPMyq8jS8M3TfIS74sYaucGENe/spZ4fUDw7NdYjx4ytPu?=
 =?us-ascii?Q?+RB882sktr0B5/mCm2OQr//YZbJZfsBM1XqocBHwxBAQks39bO4yVHPFAkXb?=
 =?us-ascii?Q?e/comUphkzCii+d2SFeFh7DK88BjCB2b5hg4s1Vj1OZZLI8KzbNbnnpji2vc?=
 =?us-ascii?Q?mGmVpHOLDCBqcDADQO6rqBAjCzGK4pT/o/Zp2Djq98Ro0HjT63tONCcokR9s?=
 =?us-ascii?Q?9aHZrBytHWnEcWYWWdqAk9sAb8IZjLI0m+b+uc873r0en5HbOsULk4r/IyS0?=
 =?us-ascii?Q?wq1shXdm6EVVOdx4hyMCqBrQb+s90nPypP89e1UuaHETixtMZBhCx8vdaDvE?=
 =?us-ascii?Q?kxMyCNojxkNFoHVz6JiowJCUwZ2K3oFY7fYfAkshF5ZTiEGO1RTaKr1VPVhG?=
 =?us-ascii?Q?2vmS36GJh5N8KCesqQVA5NH9RFRkHprM72Rwcc7IYtiB+6R60rW+gzchJwyn?=
 =?us-ascii?Q?SggRT1hOtW9toJeEXuBHLPG2o4euLBLPgEii9yzwq1Ja+G1zsqSepqL5xJh1?=
 =?us-ascii?Q?ZGv9WOwk8+a/OuoJIpY9R4pQLRCYsczJ2hvGoMsj5utqtXYIeQJi1BEQQ2JS?=
 =?us-ascii?Q?GuqJZXLE/CHtVMqsDnVH22YXnBr3ExGM+K4hfSp03Sf+T+WAgi5ju36Q2FZY?=
 =?us-ascii?Q?bRdoaDu7t2F48VnlLBxJsH8YgqqZproM1vi0p0/dd8TPBo/LE1hVMSRysf8g?=
 =?us-ascii?Q?UkpFmhyTLSNoOOtEb7RBlkSSJmYOOoutG6U9ST6m5VHd1XqewkG1QjqiY87Y?=
 =?us-ascii?Q?cEliVu6OfSrayuk700z5bSvvsAr8b+BDKio1cU2fwLM5kAaDDyOkjSaqbzyt?=
 =?us-ascii?Q?aP9BhP+y2Dz54wP3Rz7jHF6MnkXdA9QvbGO9hEAoTPuv+zULeQQgVxCRmXq5?=
 =?us-ascii?Q?6N3VjV/ZFPJqDZaIChDv1HtTxpArXfgOvTkpOvBJfwwc98u1QFA67TdjDmMa?=
 =?us-ascii?Q?eXeuZL/VlO/WxzNHVYRq5ws+/LTjtVlfqPN5gmDPS1plsbpkUXhoF5dRX1Ar?=
 =?us-ascii?Q?1l9kA8ft8vDDUm/1PYSO/OO6IYQVxPKXBmjgi7224WU3fjuBVPR/GMhuJSi1?=
 =?us-ascii?Q?4r5fCox7wJf0Io50iG6l8GBkRYdGR4TY0Ogxu1wSVK5jf3Ou1qUvbr6CBnQf?=
 =?us-ascii?Q?smLoq6pVsa6u1epXoZ6ugbflYAOJbhp4rrJxbzp10EA6jd43xRAeaZdD3IEa?=
 =?us-ascii?Q?8IdkbGV7AgMKQUgd+q2v0iOAVvgBrfK75kk/UNdBTixt09PmUwHx0tQy5pVw?=
 =?us-ascii?Q?A+ReOwTM8EyEtytTYZVpzPCTo1/ToO+t0/iGdTVlhiNU/Vi7PhmHAQ0+vFKf?=
 =?us-ascii?Q?Ux/bpnj+Nq8kTg7W2OXjTT32sjOujFqsdFzlznb7Xope0MHxdyBe6o49COe1?=
 =?us-ascii?Q?2iSYay0oYrhiQGCLR8xSV8eBSlvlvpMYnIxqi4R9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace7f5b9-dd93-4843-fcfd-08dd55758405
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:22:17.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I47usjxpVzcuDNRZAmpAgnYe84K1U4TzAkzgPyv4NKz9gsYB3bmbS1jEldySMYyY+kGBN80ic+9cafyGM3IPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9206

On Mon, Feb 24, 2025 at 06:10:48PM +0000, Cristian Marussi wrote:
>On Wed, Feb 12, 2025 at 03:40:26PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> This protocol allows an agent to start, stop a CPU or set reset vector. It
>> is used to manage auxiliary CPUs in an LM (e.g. additional cores in an AP
>> cluster).
>> 
>
>Hi,
>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  11 +
>>  drivers/firmware/arm_scmi/vendors/imx/Makefile     |   1 +
>>  drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c | 287 +++++++++++++++++++++
>>  include/linux/scmi_imx_protocol.h                  |  10 +
>>  4 files changed, 309 insertions(+)
>> 
>
>[snip]
>
>> +
>> +struct scmi_imx_cpu_info_get_out {
>> +#define	CPU_RUN_MODE_START	0
>> +#define	CPU_RUN_MODE_HOLD	1
>> +#define	CPU_RUN_MODE_STOP	2
>> +#define	CPU_RUN_MODE_SLEEP	3
>> +	__le32 runmode;
>> +	__le32 sleepmode;
>> +	__le32 resetvectorlow;
>> +	__le32 resetvectorhigh;
>> +};
>> +
>> +static int scmi_imx_cpu_validate_cpuid(const struct scmi_protocol_handle *ph,
>> +				       u32 cpuid)
>> +{
>> +	struct scmi_imx_cpu_info *info = ph->get_priv(ph);
>> +
>> +	if (cpuid >= info->nr_cpu)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int scmi_imx_cpu_start(const struct scmi_protocol_handle *ph, u32 cpuid)
>> +{
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_START, sizeof(u32),
>> +				      0, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	put_unaligned_le32(cpuid, t->tx.buf);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_imx_cpu_stop(const struct scmi_protocol_handle *ph, u32 cpuid)
>> +{
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_STOP, sizeof(u32),
>> +				      0, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	put_unaligned_le32(cpuid, t->tx.buf);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>
>Please refactor and unify this 2 seemingly identical start/stop funcs by
>defining a common helper...

ok. fix in next version.

>
>> +static int scmi_imx_cpu_reset_vector_set(const struct scmi_protocol_handle *ph,
>> +					 u32 cpuid, u64 vector, bool start,
>> +					 bool boot, bool resume)
>> +{
>> +	struct scmi_imx_cpu_reset_vector_set_in *in;
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +	u32 flags;
>> +
>> +	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_RESET_VECTOR_SET, sizeof(*in),
>> +				      0, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	in = t->tx.buf;
>> +	in->cpuid = cpu_to_le32(cpuid);
>> +	flags = start ? CPU_VEC_FLAGS_START : 0;
>> +	flags |= boot ? CPU_VEC_FLAGS_BOOT : 0;
>> +	flags |= resume ? CPU_VEC_FLAGS_RESUME : 0;
>> +	in->flags = cpu_to_le32(flags);
>
>...you should just avoid the endianess helper given that is a bitfield (I cannot
>exclude that there are other places where we wrongly endianIZE bitfields...) and
>I think that the best way to do it without cause smatch to cry would be
>to use le32_encode_bits() which should just produce the desired flags
>into an __le32
>
>le32_encode_bits and friends are used throughout the code base and added
>
>https://patchwork.ozlabs.org/project/ubuntu-kernel/patch/20190606034255.2192-2-aaron.ma@canonical.com/
>
>which seems to be the best (and only) documentation :P

Thanks for the pointer, I will fix in next version as you suggest.

>
>> +	in->resetvectorlow = cpu_to_le32(lower_32_bits(vector));
>> +	in->resetvectorhigh = cpu_to_le32(upper_32_bits(vector));
>> +	ret = ph->xops->do_xfer(ph, t);
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_imx_cpu_started(const struct scmi_protocol_handle *ph, u32 cpuid,
>> +				bool *started)
>> +{
>> +	struct scmi_imx_cpu_info_get_out *out;
>> +	struct scmi_xfer *t;
>> +	u32 mode;
>> +	int ret;
>> +
>
>maybe overlay paranoid...but
>
>	if (!started)
>		return -EINVAL;
>
>...up to you, if you feel paranoid too
>
>> +	*started = false;
>> +	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_INFO_GET, sizeof(u32),
>> +				      0, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	put_unaligned_le32(cpuid, t->tx.buf);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	if (!ret) {
>> +		out = t->rx.buf;
>> +		mode = le32_to_cpu(out->runmode);
>> +		if ((mode == CPU_RUN_MODE_START) || (mode == CPU_RUN_MODE_SLEEP))
>> +			*started = true;
>> +	}
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct scmi_imx_cpu_proto_ops scmi_imx_cpu_proto_ops = {
>> +	.cpu_reset_vector_set = scmi_imx_cpu_reset_vector_set,
>> +	.cpu_start = scmi_imx_cpu_start,
>> +	.cpu_started = scmi_imx_cpu_started,
>> +	.cpu_stop = scmi_imx_cpu_stop,
>> +};
>> +
>> +static int scmi_imx_cpu_protocol_attributes_get(const struct scmi_protocol_handle *ph,
>> +						struct scmi_imx_cpu_info *info)
>> +{
>> +	struct scmi_msg_imx_cpu_protocol_attributes *attr;
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
>> +				      sizeof(*attr), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	attr = t->rx.buf;
>> +
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	if (!ret) {
>> +		info->nr_cpu = SCMI_IMX_CPU_PROTO_ATTR_NUM_CPUS(attr->attributes);
>
>	
>	le32_get_bits(attr->attributes, GENMASK())

Fix in next version.

>
>> +		dev_info(ph->dev, "i.MX SM CPU: %d cpus\n",
>> +			 info->nr_cpu);
>> +	}
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_imx_cpu_attributes_get(const struct scmi_protocol_handle *ph,
>> +				       u32 cpuid)
>> +{
>> +	struct scmi_msg_imx_cpu_attributes_out *out;
>> +	char name[SCMI_SHORT_NAME_MAX_SIZE] = {'\0'};
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_ATTRIBUTES, sizeof(u32), 0, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	put_unaligned_le32(cpuid, t->tx.buf);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	if (!ret) {
>> +		out = t->rx.buf;
>> +		strscpy(name, out->name, SCMI_SHORT_NAME_MAX_SIZE);
>> +		dev_info(ph->dev, "i.MX CPU: name: %s\n", name);
>> +	} else {
>> +		dev_err(ph->dev, "i.MX cpu: Failed to get info of cpu(%u)\n", cpuid);
>> +	}
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_imx_cpu_protocol_init(const struct scmi_protocol_handle *ph)
>> +{
>> +	struct scmi_imx_cpu_info *info;
>> +	u32 version;
>> +	int ret, i;
>> +
>> +	ret = ph->xops->version_get(ph, &version);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_info(ph->dev, "NXP SM CPU Protocol Version %d.%d\n",
>> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
>> +
>> +	info = devm_kzalloc(ph->dev, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	ret = scmi_imx_cpu_protocol_attributes_get(ph, info);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < info->nr_cpu; i++) {
>> +		ret = scmi_imx_cpu_attributes_get(ph, i);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return ph->set_priv(ph, info, version);
>> +}
>> +
>> +static const struct scmi_protocol scmi_imx_cpu = {
>> +	.id = SCMI_PROTOCOL_IMX_CPU,
>> +	.owner = THIS_MODULE,
>> +	.instance_init = &scmi_imx_cpu_protocol_init,
>> +	.ops = &scmi_imx_cpu_proto_ops,
>> +	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
>> +	.vendor_id = SCMI_IMX_VENDOR,
>> +	.sub_vendor_id = SCMI_IMX_SUBVENDOR,
>> +};
>> +module_scmi_protocol(scmi_imx_cpu);
>
>similarly as LMM...
>
>MODULE_ALIAS("scmi-protocol-" __stringify(SCMI_PROTOCOL_IMX_CPU) "-" SCMI_IMX_VENDOR);

Fix in next version
Appreciate again for reviewing the large patchset.

Thanks,
Peng

>
>Thanks
>Cristian
>

