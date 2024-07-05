Return-Path: <linux-kernel+bounces-242596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAB4928A45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D61282507
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849E2161904;
	Fri,  5 Jul 2024 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o5DN74tk"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9E1607A4;
	Fri,  5 Jul 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187772; cv=fail; b=jDamMfEhh98wWGuocCFVCQddLlwmvVUpFAxwN+UXWyBCL8qHYfyHo9D/Udnc62KpRcXJWPHE9IlgQFsXBPLgdPTuAjZM6fGwZhzLM5y6vw241gILw7r8+9+V8iOsN5uArgZbG1bxN7xpou0gU9Klj/ajL6P7jap3dhRSmlRZqig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187772; c=relaxed/simple;
	bh=/nxstPxF3o1S44yVoWukS18LDGly5k3bs7qlPg/JwaQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Scnf84K0qM3uyGSjlLwPumDiDtF1FYUFWcdxmsw83JUs7J7M+zQh/mymmUxIKfPld0fwMP1qA+OqKyBMx+zEtJGRqlQTJXztFXpjifaCVnCXH4kgMwdBfAWAwXKau9dJ3SZmc6odU+2PxJMgnkDdzJ6cg3ZfBgT+JaopiP0kkx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o5DN74tk; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ67YtoaXovsrQjUvisKattQ5A5lFTenFHT2o1l0CoKk/R21EjUbeIuKTVsleQs2b/h5yrDDzm1fRXlUyHgN55A8t7ojULX2VYWgpIREUkUb+7Nu+EKG/QwBpSS2wkwxjZjcabod4Jq9X+KithcFQRxFAtlW5cGZxZrr8zntyLYuREa2F/BM48UFudbifuHGt8YExaS67gs8OWH1R9ERHtt0YEUY5pItCM2fMoMRlPtxmQl8GBIbiDgXu4QV/ZVQhcmCmWBD+jZ0R+LD8s4XWgmdxVaYkgsOEjW4Foq6/QDF2DQtpCATkWtt/Ji/3Rrs3o0mqOGCyhNmWneO636mSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCUmpo2s1rxaQvZph1haymn+Lxzniat2JXypac0pinY=;
 b=E/SFC8yFWBXnjxVSD2rVSrTlhArY7piM0CP25ny/O15ZwWWBoyPBttooIPvt26LCX91PtUoGGgU/8/yGqhHdsQjIlp/xdr9F++++UsOVDFKetpJW50sZB81o3jacbvt0KQ8dsz9d/8tOkXdRNjHSShOyN+B+wbpRserOB4bljLmH0R2gfEuhDrmjISAApb0nOnN4BEEDsKXBM/VE2qy+PW6wmTyU6sY7uvZROwB3/OApBJqfomapqBrhQMcm6dSPCL7n4CLN9laiqx+9Ht+w0EQMaS+Dab6AXTRmhM0kFmtiuakdpkf9skPKBORJHIb1txoL++Ud8DzAhKKFJYcyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCUmpo2s1rxaQvZph1haymn+Lxzniat2JXypac0pinY=;
 b=o5DN74tkEeRBRh9eVUpmJbiqAcaU/GA8K+QjOCD1vUhWO29OwM6XuZLFWoQNHhPUUQ2LFA3BdDlaI9RloBEmWeyNPsx9W0V/lkCOfNs3VQp9Twd77Balk0yq/Zk4sjRsnQNDoYgHHNipYl7WCHuvUebOVt0Je1nrFuYR1mAfE5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9260.eurprd04.prod.outlook.com (2603:10a6:10:370::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 13:56:06 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.030; Fri, 5 Jul 2024
 13:56:06 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 05 Jul 2024 19:22:42 +0530
Subject: [PATCH v4 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-imx-se-if-v4-3-52d000e18a1d@nxp.com>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
In-Reply-To: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720187574; l=2656;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=/nxstPxF3o1S44yVoWukS18LDGly5k3bs7qlPg/JwaQ=;
 b=xQDVTFJadFwPlv3COL/lM+FmHHvHdjciJcWONJKYb5CvU9gIulPfsF4xZJf0pg/7Y1Rp/rGBp
 +S6huPcFxZWDL/jwngtYFS7g+wfwJ6fdyMDzXHPAaRePuLQN5UiKf54
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5b6069-a4bb-431b-9f38-08dc9cfa3779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TE43L3o5enlac2tIUUdpaUE4NFgvZVExd21Bc2FiZS9EbTZmNVY2eUhRb1NN?=
 =?utf-8?B?eEtCelpWQStOenBYWmJxNXFtUUZqM1pYSXlpNCsrMjc3dFU0TmVFYjN1dWF0?=
 =?utf-8?B?MU5WcEREUFFhQUJRUmpnbmlhRyt5R3VqekI4ZXJCS2dQSDh1WU80aGhKL2Qw?=
 =?utf-8?B?STIrZ3dwanI2K21taGdRY21mOEhuZnczNG1VdFFXOG02aTdjTWdzK0FyNVA4?=
 =?utf-8?B?Rm96ZmJsU3ltNjh1OEZYRE9LN0V4UUFoL05VeFFVUG5LWWNpeDdCemozR3Jk?=
 =?utf-8?B?ZUMyRitEcHhiM0hEaGFvT1JIKzRPK0pNc3l3Qk5kQTEzc25tZnZncjZ6T3pm?=
 =?utf-8?B?d28yTVlyZml5d2tQdVRvZFlRR3dFcWJWaFAyWFZlMjNVdGZ5RkFicUpCQjlI?=
 =?utf-8?B?RkJDMnBrbHl4bjAvTlJQeG0xM3d0T1o2OHZ3alBjOGg1OTZBTVlmQlBxWVF5?=
 =?utf-8?B?ciszQWN0Uy8zd3FsWHBoSFJFbDdQYVFoem5PKzV3RG0xTjZ0UkhDbFkxbi9Z?=
 =?utf-8?B?d3duMXAxSWpGNlhYMnZva2FkMmNja20xSkFTOFNPekl0M2MzeWNia0sreU0w?=
 =?utf-8?B?ZHh0YWo3anhmZTBkWFRsc2ZUU0RtOUhmb1lSVzdjQkxUVFlNNmpCU2xnQURr?=
 =?utf-8?B?RkRkZXgxN2xFSC9BQ3U3Tzc2aytQL2p2cjZGa1VML0E1bitOSkovTyt6THVT?=
 =?utf-8?B?anlialVRa0x0L2VWUHNOdlpGanFuellLRXpMUVpNaXZGa243a2xaRDdqVHhQ?=
 =?utf-8?B?ZVQrbnJxeXlzd2tyV1huUU9Ca1R0OEdtNXU4UDlRVlQ1ajBDSEdGV2N1cnBM?=
 =?utf-8?B?bUNqT3VLcU5hK3k3bXRpcXpaeURVU1h1OUJXNXJlTVZINk0xd0xuVUtRSnl5?=
 =?utf-8?B?MVlNRkxUNmlXZi9DbTBWWDlzenV5L243RWV6Z1NWdGMyazkwb20zckpQdzht?=
 =?utf-8?B?bFVFdDVlMngvODFPb3NHMGlGc01mR3VsQjRZQStnbmpSR0Q5MXMrNjI1UGhY?=
 =?utf-8?B?dlpiWWt4Yi9nMThMSm8za3NhTURIV0pJTTZ2Z0VpOXJqWUxpSDNXclRWNWx4?=
 =?utf-8?B?cnpwNEpjTHpVMWtUM3I4SFNGVTJiRU5pWFYvM2NTcVFZbDBZV2NJaDVOaFdN?=
 =?utf-8?B?UWZ2REQ1aUxkcWw1WUYxOGpOMC8ra3k0cDNsMGhUYjRQZGFzRHpoMWRVR0hI?=
 =?utf-8?B?SEVFaWFmeWpuWitqbU16REkyejQxK1BMd005Nmx1YStPQ3FtZUtzSXJOcHlB?=
 =?utf-8?B?MW9YYVFxY2tleGgyZmRhSnMxeGJtTkR2UlUwbGtIdXp6aDliUGRRUFdMc3Bp?=
 =?utf-8?B?V2ZNcXloQ0xkN2JtckRBZkFaQncvc0hGYjk3Q25GY1V4SmJSanRQNXVNYU9p?=
 =?utf-8?B?ZklIa1Q4cXZKSnpUT1N3YlErWDIyR3VGUHJSUHQ5djMrRThIT0l0VWk5R0dN?=
 =?utf-8?B?VUtFcTFwei9tVUllaHl5dVVUd1pRbDYwdjdtenFUcTJ2dyt0YU5WLzZpY0JW?=
 =?utf-8?B?cWRTdklhaFkzVXZybGJEQ3UwbzZjME1uK1IxY2VEbG9MMWRFS3ZYeXFlK05q?=
 =?utf-8?B?RmZ3d0x6Q0hwSTFMc3ROQWlGMHVFcDM0NEwwY2h1eTRCN1VjSnBDZUV6WkxW?=
 =?utf-8?B?OVFvRG9od1lmMEc1SkNFeXRHaEt1UEpRRlBvdnFRK05KbHJCNVFyQ2NMTGda?=
 =?utf-8?B?N1Y2cnpwZWxoYmRmNnloU2gxWU9JcVRZQzFCYVVIamFnVlpxVXF6eVFQb0VL?=
 =?utf-8?B?SzJKTCtSSDZPNGdkdzB4UWZPa0NSazMwbjIwN1FzcnNVWW5pZXBvVnNBZnUv?=
 =?utf-8?B?OExBZ3RzQXYvMVREYmhhUUR2T3NSeGpESzFKeGJpQ3VXK2ZJZlplSmZiV1Y1?=
 =?utf-8?B?YkI5VmJxbTlPZzNUSGZlQXdUWi8rL0orVGowbWNWbGNnNTB0a2lDOWVrQVhn?=
 =?utf-8?Q?s7UWRjFkV2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW1vbTRwNUNDekZMdFZLTXpQMEt5SGdHc3pTQTluYmJ2RkUvZERJZ24rNDlB?=
 =?utf-8?B?L3pKWVFZVi9xU0JpYndMeGlodVJjZ2czYTV4YmZCdUM5eXdGT2E2YmRHaVls?=
 =?utf-8?B?OHhWeHNOVjNTS1Z3MTIybExuZ1JBNFNUV0JyTms0cDFuWFBFbTk4d20rendQ?=
 =?utf-8?B?eEEyTUhMZFA4YnRoNzl2M2lJT1htSDJuTWR5bXBCRTNJM3VpMWxyYlllZHR2?=
 =?utf-8?B?KzZqaUdzSU5JV0lhc296cVFoMEtVRmtZSVdSTEhhMmg5T0doaVdaYVBjUUsr?=
 =?utf-8?B?dm1YTHlxWU03RndzQ3Z3ckxKWEc1K1o1b2ViMTQzNXFUVld2NERkVlA4REVi?=
 =?utf-8?B?TUo2UVp1OVpVa3VCM0YzcmFtbFJ0NnE5aWhINDZpQ29Lc0FCak5hMkJ6WDJs?=
 =?utf-8?B?QlFIenlOR2R6MkRRSTBPV2NRNS9ybHRReEVYbjFWcisrZm10bjlobm1rQ2U3?=
 =?utf-8?B?UWdwM2R5NjcwOTIrL0FGTFpaQ01RTWhTTmVEYWsweUliejFMZVNyYU1OZHc3?=
 =?utf-8?B?TlhFb1FPU242b2xvbUpicFZSWU1lTFdMME95ZVBRRHZRem10NXpmc2dtbjU0?=
 =?utf-8?B?Q0NHTC9QM0krRTZuQ29yU21SUCs5VTZZQUR0QUZMZHJiZ3Mwc1hHbHpsM1l5?=
 =?utf-8?B?OWxKSU1xL3paaGNaWnBadVg0SkJabUxVekZ6WHovMGJ0dHZMVFlNRDBRakVD?=
 =?utf-8?B?aDlkTUFXdzdEZ0QwR095U1l0VWR2Rld5TmZ2eWtCSjJxSGQzR2dPUkgzL21j?=
 =?utf-8?B?RXE1OElaR1lvYWgwaUwzWHRSYnN5SUJxLzA5R2lQai9RMG5MTGJhMTVmcGR2?=
 =?utf-8?B?SnpnNlpydTdmNm5HeHhkcUJJYlVXVFAwVmY3UFhqK3hqdEN2aVE4dmVqeUdQ?=
 =?utf-8?B?a015WmFlSFhWR2pINm9TUTc5cytvN2lMcDB5SThOYnRmSmlDczRkeitTUmtY?=
 =?utf-8?B?aW5xeVoweGdZT3NSUTJaL3VQa2FMWlZ2MGJHVmNReW81eVpuSzlVekdVT1Rp?=
 =?utf-8?B?NUVLemY3NlhrMDJDVUJXdG16bVJWek02ZW9NS0dRWlFVUitxZHdlWHU3UWtZ?=
 =?utf-8?B?ZnZtL2Q3YXcxUHdxdGJ5cHhseVVmMFVtRlBIYktuZ056MG0zQjFWOUdTd2x0?=
 =?utf-8?B?QnFmMnpadXl6ZkxsN0RBaEFWamxNRFlNV1YyQ1JCRXhUVU05MG9UaS9veHpJ?=
 =?utf-8?B?aVFXeWtxQzIxa2JjanFKT2tzdUZIQnl6UGNHUmQvZUdlZisvbDRYU0ZWNW9Y?=
 =?utf-8?B?SzZ4YmR5RUhTRThaLytxZFNKUGpSdTVDOG8wMEs0djg3Z0F0NHlzSFBnVU5U?=
 =?utf-8?B?S2lEY3A3Z0Z3dkNuN2hxTU9BbTB3bzBHZU01UnMzbkJiQmJkZ2Zrd0gwejhX?=
 =?utf-8?B?Wm9oYkRUL0ZsVlhjb2J2UXZVQWozS2RhTUlWVmpsVUgyc0xjNXdGODdWeWZK?=
 =?utf-8?B?RHA2M0pJL1Y3bTFDU0Jybng5SUV0bTNtZTlBbkRSVmpKNVZjQWo0YzFRcFA2?=
 =?utf-8?B?MXRYSVRoSnZubThac1Y3VnQxbERuRTBHeDAyMXdmOGJjY0lGRDl4VVg3ajc5?=
 =?utf-8?B?SENTMXQ2TmgyUEErT3Znd3hMbzNTSlljMlRiNlpzRGlPeWNhWGl6VXgreFVX?=
 =?utf-8?B?MmxkVVVqZ01KVFp3MW5CSGtLTlhKbXl0ODFFcDY3ZlFheFNjb1QrRHYvN3FJ?=
 =?utf-8?B?NU0rZVhxWlkzWGt1UUxkaEJQZG9KZjA5cGt4TWJBMXI5VEFCSjFRMG5LR2tq?=
 =?utf-8?B?UTh3cFBBR3J5OWU1NVZkNnZEbDZPdnpMeU5SNlN0ZlVhQ0tkZDdidjhWME51?=
 =?utf-8?B?NmtJSmN3ZUNxb0gva2JNWU1WT2FHMDBrckl6cVpudU5vNVlZNGlKaHJ2M0xG?=
 =?utf-8?B?QTEyTFJIZkFkdCtQTVVRZXUzQUloMG1aN1ByUTdtSFNDZHBSZTRSOFFSc3BH?=
 =?utf-8?B?Zk1rZVlvb0J5bXFWdDdkVEs4YU83dGtCb0YySTFHVVp2bUpaK2hpNEdMb0NR?=
 =?utf-8?B?cGNqb1J4TlJNSlc5QjgwYmZLTGVLd3lneFRORWVEa2g1bEllMzhOMkRVbDY0?=
 =?utf-8?B?N2t4eDdvV3lXS0RERHFNK2tSV2U3MmlzYUFSM1R1YVVmZjd4TWZXNVRlVDJo?=
 =?utf-8?Q?aN1QRrN/j1pq4OePrwvALnBXa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5b6069-a4bb-431b-9f38-08dc9cfa3779
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:56:06.7130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4uj6nY+Na1kPiLuyGRFSq1Ee0QCe+vJ9shlzg2vS/YhnCGRahjC5uvDGudshoAOT6hzDkbm+D6s6k7w0UBzIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9260

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 14 ++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 24bb253b938d..ca8958f28a83 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -146,6 +157,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_if0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c460afaa76f5..cfa6d30a890e 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -167,6 +167,8 @@ scmi_buf: scmi-sram-section@0 {
 	};
 
 	firmware {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		scmi {
 			compatible = "arm,scmi-smc";
 			arm,smc-id = <0xc20000fe>;
@@ -184,6 +186,14 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele_if0: firmware@0 {
+			 compatible = "fsl,imx8ulp-se";
+			 reg = <0x0>;
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


