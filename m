Return-Path: <linux-kernel+bounces-215119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F356B908E57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD02284959
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D11A3BB7;
	Fri, 14 Jun 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ntARhlS8"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D851A38C9;
	Fri, 14 Jun 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377645; cv=fail; b=i3HbLV4s+TyANLwIMSuph9o14Y++g7vrnd4JTFMs72R6BS6jNXmVj3yUhl+op7SMf2tB2K+WfwEh8vf9xXwFWT9O4j/ZNtjusUIcsqYmPum0H1hr72WGuKTwj7ySK/k6Y1qXmpDDm5CEAcVuqqy4WQJmJCOFwFOc/bXqaz0/5LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377645; c=relaxed/simple;
	bh=BGdAl9Cw88q5CXYFPKaVtp4lX6FlBfRQpGYgJfGNwyY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=siw4F8s4JWGTfgHItcYLUjDmfVn8KA561095kMLcP2a+Hrw1s2HZIEXfLqheXt+Xc4fuVlgacGtSv6UfUAwiH4FJB0PaqCw+jOaZ49l2RuHFt724GmjGnnhV/Puepa5kvvtcBT1uR0Cv7SlzD7nwVww+DithI5G/3ivTbn0FUFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ntARhlS8; arc=fail smtp.client-ip=40.107.6.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I99rrgUC5SeOsXZnpCQg8H+txSNtngp4ybOau5T8K0oNw81U09HTZBQLDSjF4xQOTZwpM3MV/bT8PFGKVL3CG4OnG0Ia4kDHISKm6V6yWd5bsJHv8zoWGZDz0TF1SnOSzy6TUum5iEByareVe/TYoZwnUkcHB0jwGbsdAZ/i7kZMFPgRMKKon1GEC7B+4N4UIgw3j6UpE12EVblnS3nESVQdSQ/Z0OuYHd6wpDbeTfIK8kaStMSI3rJ1p+EemgN0FqUyOT0iyYmSQBdqedA96+axfYlfk2eVlz8bQE5Ugj9S6cjUx08Z+y9z1tzeGn7dHZ0MNImmo3QfU6AZxaJhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5noNf9OgsZyK0Puh1BxlGX/SHf4fS2HLp0jvD3F09k=;
 b=YJrqfKvzPPYratadmALRJ9qJtn0XfxW4glMZfs2uZtZKJRpgWG9vYxT7xgM6BIh3HTQ/ozFGzYNsQdPB/rgzp7R78Tdq/kutteh1MTfjtd1sInbQ/iwtozR7LdJsTQiElLHAMJ5vsn4uWXxUuziNbMHFdyRowtY5Y7q0WZxdBpjEhEcDTfxIH6f95/cOZQzNrPBajeeW+upLA3bvTP7ywyONbW4iZrg4qp4HIbYhjY5yhbIMoSX2tDoJIvE/jHnNZ81VxlPYDS0ecRipmrynMWpiIHu60Jbe3S7hmXrxtXS4Z7ZPlR5NQW7Eyb3FbVUR2vCse5SMa1pGwzj7X6l3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5noNf9OgsZyK0Puh1BxlGX/SHf4fS2HLp0jvD3F09k=;
 b=ntARhlS89PyAkb7XsVBmWsfxQEsyIcMn8b9IvVQvgJd44FUSZ3zh2vHquNrFYVnBzPbJIGYRAOiDUX8QrG1jpda9cGZDugP9QB5u9wfKYI27mVkwJqDFS2sa0PrUxLNgXku0NyzVA+pUBQ7zRLUcYWEKfdgQ95zImz1FM3Ll/W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:07:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:07:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 11:06:33 -0400
Subject: [PATCH v3 9/9] arm64: dts: imx8qm-mek: add usb 3.0 and related
 type C nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-imx8qm-dts-usb-v3-9-8ecc30678e1c@nxp.com>
References: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
In-Reply-To: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=2977;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BGdAl9Cw88q5CXYFPKaVtp4lX6FlBfRQpGYgJfGNwyY=;
 b=blX31YUXn2UbZF750AeO3/f1ez/VoTJgh6ww7ga4wBxu+I2h4DKgrZ+DX/ILFr/yjvsjNbHdN
 ROKNXC5PY15DD6ubZdMYHKnYb83g4mNW1fmPtrxsqqisJE1sMtyLyRL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 912a6e04-6984-48c2-3d22-08dc8c83afab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFJVUlVmdTdvNTh1b3Y1Zk5hM21KQVg0VVdWbGRXN3FOR3k3Mk04M3U0WmVG?=
 =?utf-8?B?NlBOYUhTSTMvTnVzZlVCamk0b3g1a3ZXdEFmQ2ltTS81WDlxcEtad2lMZXlr?=
 =?utf-8?B?M0crRjkzVW9udUkvclRMaFdzS0czelNmMkFYTW5nemlSNTROZGhSd1hHZkJ6?=
 =?utf-8?B?OFNZdVFQdUpDdGFlb1Y4Y1kvZEsyTnU5SHpzNHh5cmtXNTdIdDlNVldVSkIv?=
 =?utf-8?B?NDhBK2lWVjREYjhVUjU4dnFTWUMyL1hlK0MzSERta0k2c05IcWNjMktaNWlo?=
 =?utf-8?B?bnlpSFh5OTNEcEdxMzlQOEVEN25CbEUwbWc5aFNNc3NuUWlTRXNPS1ZtRytr?=
 =?utf-8?B?aXZYdk81MVRFb3g0a0xiMjdneFlsc0NyNEVOMGt5ZmdCWHh0SG1zeEIyR2dv?=
 =?utf-8?B?SFg4UXEvTDhrZmpaMjR2ajJuZzdKSm9BcHY0ekI1RE5od3pTaVRGZ1czbnFY?=
 =?utf-8?B?eHBLRVdiVlVrblBDT1JsMjNMb3Q2ejFnR05FZitPSk1nYi9RVmhhT3V5NHV3?=
 =?utf-8?B?THg1SkVVTC9BZ3dMMlZCSk40V2pncHp4S091SkZTK2sxcXZlbmUwMVNSZ1lz?=
 =?utf-8?B?cFBiWVd5UHdGaXYvZ1owc21DaHJYZy9GQ2tERmdhc1B2NUJoY281RnlFd3ZS?=
 =?utf-8?B?aHZSSCs5NTVFVGFNWWF0TUU4QmxLL21SWXU1MDdZZ29qdklRdUJEVG15dmZH?=
 =?utf-8?B?Y0N2RVhSU2psSGgzcDJLbUxnQXFVQ0FFVHVzM2JoR3o2OXpaK2o3WGczTVIy?=
 =?utf-8?B?aG1BTjdHRjlGS3FzRExpeGgvUlpGWnlaaTNYZDlYR1pwZ1pSTFprRWcySEUv?=
 =?utf-8?B?eitLZFU2TnlyamplTlZDb0VHL0M3TDRYaDdCR2QvSG9Cd2JaV3VGaWUrbjcz?=
 =?utf-8?B?c1FxMnlNb1lWNjFmYnl1c3U3bjY4WVhySXBtSjJrdTZNUktFUGg0MUYzaGJ1?=
 =?utf-8?B?VVl3dmQ2Q2lpc2ZTYnNlb09qYUd2ZnM3NEwrNittM3drM24xR28vQU5FbU5i?=
 =?utf-8?B?SWl5YVN5TC9SYU5YVFNDaE0wSGtFeWpBSWlXb1JpcS9MR1dqWjJnbU1EYVNU?=
 =?utf-8?B?cWpTdmdmSUpzWWxwcG1CekVTelRrditUNnhWWG5yZHR1a0c0eG81QisxcjY1?=
 =?utf-8?B?a1FycVIyTk9xT0ZXNDNNZ0IxbjJ1YlVRdW1VZ2w0OGtkblRxNzd4NGFiSkcw?=
 =?utf-8?B?NzN4Y3FUMkFDZk05M0hYRnpaWVJYQlRJVmF3MDB5K3NFNFBGS1d2NG9lUGF2?=
 =?utf-8?B?NW9WM1FnVWRweGQrd2FqM21FZjJpOEw4ZU5yaE1GMTVXRFVENFg2UlpwVDlM?=
 =?utf-8?B?ZEticWJZMXQ5MWZMalhiVng0WVNCVmpsL05wakdMVXJWejRDSlU3REYyQjVB?=
 =?utf-8?B?dmRnR3lzVlQzMFZpbHNaWkxHUkk0d3NETi9vQ1JPUEFvKzZiZlFKczZ0VXda?=
 =?utf-8?B?N1p2TFpCQVZvSjNyMEREYkVUaXZ5OG9nclZ6WTJDL0tKb3lOZ05qeUtuZ2p6?=
 =?utf-8?B?ZTdOVGVOc1g1YlRuMnJJOEcxbWsvaSs5eVlIaVNzdU1TMkUyZzJZRkQzdFJD?=
 =?utf-8?B?MHVTaE1OVlJNTVVjY1dVcnVBTmsvOXJSK1F0Smo5L0M4ZktsTHNnN3ZNd2xI?=
 =?utf-8?B?UTFmaGc2dkttS3prdmxTNldER25hMk5HaFRjSGVoNUNkMUxrRXRRNDRXZk1n?=
 =?utf-8?B?ZWY0b0dQeTJLSWlaenh2SktYL2VNTDFlemJxcWJmU1pZUUx5Y0xMQ2FYL24w?=
 =?utf-8?B?NlNRVTIyVnB6bHdxY3VBaVFMZ3I2L1NTZnY5YVhJN2tSakpmL0U5QUhFRU5j?=
 =?utf-8?Q?bne/cKR0zz0JkDduq76MAGBVGKcXhcVxWfNZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHA4dDZmTVpvekVEU2QrVENUQnlxcmFrMWg2ZWFPa01DYmx3MlhjSHBlYlZo?=
 =?utf-8?B?SGtsaUNJN1JMUjFiNTZHRHNCQXl4RnNROFJCYVBhTUdSTWxFMVFENWFMRUtj?=
 =?utf-8?B?QUMwRmsrUXg5Kys0L2VzRjJNc0RTRVBTL2JTZ1pqRkgxQ2JsVVNENTVZMzZX?=
 =?utf-8?B?TXpOV2YraWR1aHFHNnlqbGU0YVBlK3Z6aHJKZWc5bmlDVlNFMEdJYjBoUHE0?=
 =?utf-8?B?Z2hnK2tqbnJaWDRCTlVZazV0NjdWMk1IVVdzeGlSc3FlN1ZoMi9YVTRhTldl?=
 =?utf-8?B?WmRRVUdlWFNDTWdtSjJXZHN5NWtoOGtlR2N2UnZ6MFd0eVlnRlpnVFo2U1Nn?=
 =?utf-8?B?ODJqMWRYdHRicCtZSHF5cEd3aWN1UmV0RzAyTUFWRnQ1SDBib2lxdjZ2eFlq?=
 =?utf-8?B?L1Q4Rzlxc01vZHdYdFNxTlVLYkVTQWJaMTBPeWtpVXRzcXM2OUFvVU0xSzhR?=
 =?utf-8?B?dDYrOW52SFc2Wm5KQ3NXbC9oalVDWEFVZEZSMFVJUnU3SVc0K0FTZ291b3NS?=
 =?utf-8?B?b0ZtSUVQdzZheVJQdy9Wb0FPSm9lUUdWVDZyZEgwbGxqb2hnN0FmSERFZ1Rv?=
 =?utf-8?B?ZjZWbzJjMXEwRXcyM3l1dmhqSUVVaFlDZDdTMUwzaG1TL1ZWVVg2aVJ6NjQ4?=
 =?utf-8?B?RC8vWmt6bUJCdHFWbGMzbktaN3I3ajBFdHNnbHRwMlg3Mk9qYzREcFM4R0FT?=
 =?utf-8?B?VS92dTFPc1lVWm1FdXg2clY4OXpmYjRnanlPK0Z5dS81WHRNZ2V0MHdGNmxr?=
 =?utf-8?B?RmdpNE9aUHBCQnpHcUVwempCQWY2MmNlSkRLem8wYWR0ZjhqVVRYUmptcGFu?=
 =?utf-8?B?MGxHUHBUbkVTbHN1RHMxcmVHci9LUjc1RzllYVhCd2dIWmZXbFFudGUzY1ZT?=
 =?utf-8?B?czNudFNDcHU3Z2cyUTk4dTF0WGtJUkhUTTBpYUR6UW5laW8vMjExYllhS1lX?=
 =?utf-8?B?dGlsd0JCSDV6UllzcDBTUXNwcE5EYkJTVEhPSEgzcHhnZTBDUkZremVOMXgw?=
 =?utf-8?B?bUo4NStnSUZTQWlSN1NyUGYyQTZWZ3h0ckdDZHlqQTRsZnZybHEzbjVlOGsv?=
 =?utf-8?B?T2VObisrTmJoQlppRDVSVTNmSldwLzYxQmhXUktXYS95REJVaUFLOW1CRE9k?=
 =?utf-8?B?dmo0SGp4VVVhV1JTUFlhRCtGZjRYc0dBbzU2NGl1UFFYaXFMU21xWTVhTCs1?=
 =?utf-8?B?Q21uSnU1alI1ak9JajVBZ3lySGVUV2VVMUFueVFFVXJmYitpM3UvRytpMzRW?=
 =?utf-8?B?bllVbVgrNWFWV0EwRVFOeU9kd0hUT1o1d1RHZnNuc0lHQ2t4WW1aRTI4ejQ0?=
 =?utf-8?B?YTJOWXA3ZmV3RHY1Q010QzZRZ3pHZERWYUV6bGJRbUFwS3Awa3lKdjdNOFpl?=
 =?utf-8?B?Y0ZuZ3ovLzE4ZXN4MkRoeFVHSlJTOGVJUjFEWEdkL0lveG0zR1V2MWhHZThU?=
 =?utf-8?B?dlBOcldmcEl0ZUhWdHRpOE00SS9JZnR3UnF2NVJ3MHNKaWhBNFVRK0p1aEFa?=
 =?utf-8?B?SWZLSGdCUnIyWUZaeXdKamxoc0NkcEhuY1EzSUFySTdUYWRiUEhSWWlpTFFF?=
 =?utf-8?B?YVY2V1g1RVhjaWJ6RWtGUEtpSStteStKdlNRZ3FFaEpHZkJ2NHlDc1JLZUE1?=
 =?utf-8?B?aVR4a0lGTzh5dXRmQUN3aENGelNtVVVISjlaOTUrWTI4bXR4R1M0VElhWTIw?=
 =?utf-8?B?ZDlhMk4rNzZoSEsreHdTKzNVMmptdXhmcEh5Y3BMeUd5ZHVpNXczSzRnbERY?=
 =?utf-8?B?Snc5Y09hbk9TVFNhL3R1N0crd1k2VVlieWhUTG83RDY2L3M0WTFwbnJSS3o0?=
 =?utf-8?B?aHlKQ0Jab3dQNVQraEZBQ01OeWhMR3JHYmZuRW1CMzdsMXdtMHNVbWpKYTN6?=
 =?utf-8?B?VXJ5QlowaGtIRGpBUkYxOUJ4cHpLSS96bUVnaXpkWlZQWUo2Q2ZsSHlZVWo0?=
 =?utf-8?B?cUJtaFdKUXBZTVdnTGU4NVBvZUprTFBSSTYwQnhMZzlWdXEwb0R1RHlldlJi?=
 =?utf-8?B?RUdSb2lHcFlGcklxc1UydDE4VFVRbER4V0Rxc3o1NXl6bUUyT2JRaHRQcWpT?=
 =?utf-8?B?cWNsZDJuWkovNnVLUXhtck5oSTFKNWYwSlhmNFFJVFU2RkJZdmh6RmZrSnFT?=
 =?utf-8?Q?TrgA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912a6e04-6984-48c2-3d22-08dc8c83afab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:07:19.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msoIiTgGQIX2LNAWutrzO6yBa2GVhgATyELuRtj+Y3CzofTxEU92do8slBW2XIDHZ8cVoBD4JIST/vOQdh6A6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

Enable usb3.0 and related usb type C nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 87 ++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 8ab75cc5b9aff..0f4132f342d89 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/usb/pd.h>
 #include "imx8qm.dtsi"
 
 / {
@@ -109,6 +110,21 @@ lvds_backlight1: backlight-lvds1 {
 		default-brightness-level = <80>;
 	};
 
+	mux-controller {
+		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec_mux>;
+		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		orientation-switch;
+
+		port {
+			usb3_data_ss: endpoint {
+				remote-endpoint = <&typec_con_ss>;
+			};
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -321,6 +337,44 @@ gyrometer@69 {
 		compatible = "st,l3g4200d-gyro";
 		reg = <0x69>;
 	};
+
+	ptn5110: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		reg = <0x51>;
+		interrupt-parent = <&lsio_gpio4>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		usb_con1: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "source";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec_dr_sw: endpoint {
+						remote-endpoint = <&usb3_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					typec_con_ss: endpoint {
+						remote-endpoint = <&usb3_data_ss>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &i2c1 {
@@ -525,6 +579,26 @@ &usdhc2 {
 	status = "okay";
 };
 
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb3_drd_sw: endpoint {
+			remote-endpoint = <&typec_dr_sw>;
+		};
+	};
+};
+
 &sai0 {
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
@@ -791,6 +865,19 @@ IMX8QM_SAI1_TXC_AUD_SAI1_TXC				0x06000040
 		>;
 	};
 
+	pinctrl_typec: typecgrp {
+		fsl,pins = <
+			IMX8QM_QSPI1A_DATA0_LSIO_GPIO4_IO26		0x00000021
+		>;
+	};
+
+	pinctrl_typec_mux: typecmuxgrp {
+		fsl,pins = <
+			IMX8QM_QSPI1A_SS0_B_LSIO_GPIO4_IO19		0x60
+			IMX8QM_USB_SS3_TC3_LSIO_GPIO4_IO06		0x60
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041

-- 
2.34.1


