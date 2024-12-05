Return-Path: <linux-kernel+bounces-433725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6289E5C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12241882327
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9906417E473;
	Thu,  5 Dec 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JFXqK96s"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5712227B9F;
	Thu,  5 Dec 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417509; cv=fail; b=lUE/dhh3GPZzH5LUrb2adLS5uQVRfKdTb7DxbzhboyC5fuvjg+AL6Oo6YI0HQiTVR/1mJKW1/Innuf0mbtPK4zkZQw2UdnrPj2rOhg66wKnGnfW7gONBbmu7JibYRRjFTBtBxNBIZPNchkF6DOxugGojILNixdsN/MpMv3qgKxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417509; c=relaxed/simple;
	bh=A6EGTfjYKIlj3aLC4u90rwGEbg95UGx6KHV3w/eCA1U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D/B0OLAx+pp6wCsHDvgI8jyC6LS5GHQnLK2CnWTS8BkHAPA365dfMjsL5/DtKgEqieYN0hor4cHST82BKXvRtW+DF131YFcFFUu+WP7ONcjAfjuIg8Ub990VqcEMppl0WZM/gK79uKiu42uIM0myS+xtyQBoVk/hOb8nX6eo4fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JFXqK96s; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pey/FepVroH0o30gxNagJ4BMrh2slsCQKoaNPOrfcgwi6kBPXlPTFVwv/j7zTPS/+y57xQyhAYrIPyVB2KEzfEdZC/98acf67gSKuZAjT21Ilawi3ymI1QgUIOodqfkzcxtcl1WvYBXC1xGQAFmBHhCqi7tAKaYuE2RG9VPaVsn+k1377/Fr+ilSxymr1idB4rkZGiRWGeUNu/c/mlTldwCsBYwtovLpvySRB6fam8Ci0pClO4KZYyxH0z9O532g5sGVM4LMHvgwSBu+IiLS/nP16b+8WRDBTZruscfHImAWuLBZtkBopi/MjVo6Q9PdKgTxSW9WD3Zm6cObH9KJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iOsC7M6f/+sDyrSnuCZDi4tzufpgAqP+k9gXU0kg3g=;
 b=mojQsTgLttfRqBELrpXGUWDl4hIIhDx1lZ40SY4GtvYiQ7lB1vnLwCNXnNM6sUNRMYfoaqs/9FNObYScEoBtGNDsZJPDhODSS807a8yWGruVMus/PBPnLCSPhtgzQJDos655lN/qxrw3raN7Xhd/fBr1UKv1KpKnntxQ+fiukm7nohJz+nzwscPmXYG4LhA5I9TM5FZVTZsvRL3oVfeRLcitdg8PLvlZHh6MDV1U05H6W5eBdxQTlEjEoW/Xi+Hsb6odGaE1TaF97jx7zsB8FtbmyzjdjiO4y7eA3IXtgP41qGK51nKQ+gdW0WUs3+7L9u3B6XPSh92Cc/tmvoSuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iOsC7M6f/+sDyrSnuCZDi4tzufpgAqP+k9gXU0kg3g=;
 b=JFXqK96sDADyltipA4j/g70ZWHrI1/gM59Tv7wbdwbvNN4PAPth3QuScfiu/vffe/dyaGTaQ7bbkBXv2m7tGGzn3hmKYGcRL3O9x/w91VnhBDxcOVEASnKpzMMguYOBbUD6DOdVF02zluXcMGxBlhEtDVkzulyb+rKqAU9tcVAkhwfm189I1YYcxt8s/1Zcy1FrrkIrZ3GZ9d3diy7tepaviWNHUHbrEHXamJ1N7KFuoSjs7aQuD6+2SlP+5qH3pu/Vm+blSp6cfGRrPrm+DmrZ3TGtCrjzWgzzhw8mmyKMQbFfjdzL5iZMPrTnsho5uEmrgwoLJBmnGV17lPoo5kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBAPR04MB7446.eurprd04.prod.outlook.com (2603:10a6:10:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 16:51:44 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 16:51:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 05 Dec 2024 11:51:12 -0500
Subject: [PATCH 4/5] regulator: pca9450: Add PMIC pca9452 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pca9450-v1-4-aab448b74e78@nxp.com>
References: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
In-Reply-To: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733417480; l=3178;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YhFm3p5cBgT6Des25s41MlZZ8qNGl5iYh7kvogdCttY=;
 b=8oYM0LYk8ORGCJI5h+oKgyIGzWgqX6Eu41kI3ln2PepM11O9RPorP2B6SmZb8CuqDvA/bunzO
 z+qlisrKLDoCUS5ZROrR55fvI7F8KdX8vBE7ahrC1IBYrcCFLFyShpd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBAPR04MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d9e0d1-b387-4c24-5fb8-08dd154d18cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDRLRXRmODdDRHFCZjBNdnZ1Sy9vczFqOUducENoZFdwWnRvWC9zbzJuMG9E?=
 =?utf-8?B?SG5sckl1eUNDb0JoWGVUMDArZXRRU21tVFptc1dkMitIdW9DKzNPdENHQ25P?=
 =?utf-8?B?b0JmTTI5OFVxYXh3alBId3NtMys0OXp2MXluV3gyQ2RQd05waFZqU2V5TUp3?=
 =?utf-8?B?TmVVcXVLYSsvTFBXeURYTDVMa285WmtzVjBlWGhRZXJJOXo1dXpIam04b3Ir?=
 =?utf-8?B?WkcrY3dHak5hSkdGMHhBUWtURVovQjVnenNCdnY3aTFadkF2WXRjbWtOSXl4?=
 =?utf-8?B?cnJsemUxSzlsUFY1RHhkWEdtRi8wdG5NUHVwQnpua09OQ3R5S0xWdU1wTzU2?=
 =?utf-8?B?NUd6em9EYzJUYlFOUUVKL0Q5RUduQlJRNFUzWmRDOW8xeHJVNEVBT2lsSDFp?=
 =?utf-8?B?NjVnRFVSeEJRQmlHZ2x1bnpZWkxBVTR3ZUxRTTRXcWJ5bnFNTmMzYzQ3eFNS?=
 =?utf-8?B?VkJhQm0yNXJsT1FYdkxUdXByQ3hGM0FiekNYaDdUTEhIb2tzcjVBYVF0K1BR?=
 =?utf-8?B?aXZoTkswVU5hY0xxTnpKMzJlSTRJVFkyNVFiWkZ0US9vTm5wMFlxZzZPQ2R6?=
 =?utf-8?B?NDRzMTVmNXBEV3RMTUkrVHlnVmlUUkRES2huS0JFcVRhWWxVdXA0RmVUWS84?=
 =?utf-8?B?eDJRYkprRW1JdjNCbWdEcTVGVnhqUVlUV25SdXJtMGhZSUQwWkxQN0tSRHJm?=
 =?utf-8?B?Z2NleVl3cFlJQ1pZSzJMNUVvNnc5NVZSNytoWjBJaWNMeVNsZjNWbXd1MGxy?=
 =?utf-8?B?cXBuOU9YWjRGNGRxSFNUc3M0RXhlZm81VFNuWjVXNVY4d0FveDZvd2JhWjdC?=
 =?utf-8?B?OTNlL05pL1hRQ1ZWVlpUa1ZrbUczL2o1Z296KzdvTC9NNVZTQ0JuZjEwcG04?=
 =?utf-8?B?R0NqakhZdFkyTDNwWDJCODdNNjBTbkYyWUdILzJ5a0g4eG0xMTM4ZWRBSXBm?=
 =?utf-8?B?TXYxeFhtVXR4bVNQMFVNUFN6dWE5SStNdUJGaWx0MXlsdVlhNnRMaVNseDMz?=
 =?utf-8?B?RnZhUTJrSXh5YzRRRGFKOCtDWDc2MUdnZ1dBT1FvcGV4bXExa2ZLam1DRU1D?=
 =?utf-8?B?OVR5aG11c2tSRUZMSnNsa2xqbjc2QXQ3UGcweDZUdWd0R0hzVjl5QzRyS05m?=
 =?utf-8?B?ODlmdnhUeWIvWlRDQXJXbnN2NXY5RjU2NUYwem43anVJdFB2TTFqUGhUTEZQ?=
 =?utf-8?B?NzhxSzhCVkRxTldwc25NV0wzWEZsZys5RUQ3U21FLzZqMU1YRGRzYmwxZ0pr?=
 =?utf-8?B?NGh0Z05vQ01ERkxrY1hJZWIxd09uRWN4Z0dTdS81eTUxczI1ZE9PbXRCaWpK?=
 =?utf-8?B?TWhiRjZ0UFBqYTAxdEgyQ25EczhKbC9nZE1kNFltS0ZiNDZtVzNERW1KSjJP?=
 =?utf-8?B?L0VyTjlWUy9WSkpWWnpaYVJNS2RoNmxaaU01MFFDQmdma0lYRlc4TU5kbi9h?=
 =?utf-8?B?TlZPM0FsY3U5N1g4TXpsanJIZkFacmhkdmU0SnFRa2VmNWVrL21HUVJ5VkxL?=
 =?utf-8?B?bUNGeVhrU2VPU0R2QzNUQ1daUUlwM28zS0ovM0pRMzhyanRhdzBFYVdURjV5?=
 =?utf-8?B?c2JrZ1Zva0FrT3JRSCtRWUtXRzl6SHlSek8zem5YamVocklzNE9xbUFBcWZ3?=
 =?utf-8?B?V0kvUXYrZDFMS2JWUEUzTmh5anBUT2E0VjhRQUVpOVhZRVhmUE9iaFNzeEFk?=
 =?utf-8?B?eHZqcWtoM0tKYlQra2VhMEVwZzNEc2RzUDMrakE3U3p2Yzh2ZzJOOHdTRkVq?=
 =?utf-8?B?WXpCL1BLbkNIM0xyZm1Fajh4NDRYTTlwRldRWTFtRVpnamk5OS83c1ZUWGpQ?=
 =?utf-8?B?OTJiREI5Nm5RMFVhSkNobC9McFdicVlnd0Z6aWQySElhNnEvOWxDT0hSRHJN?=
 =?utf-8?B?ZlhoT1FJTnFHeG1LOG9kWVBwbnlxZHhGajcxU0dmcWRvVXZCb1RJdXFUQkNM?=
 =?utf-8?Q?MM68OQqhEk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUtYNk1sakNaV0ZQTkN0YWJVQU9DM0NHZ2lMZUVMREkrdklUcXFNazNTVVNk?=
 =?utf-8?B?U1g4eU90RWo4d1NmcC8zWDgwdzVOVjRXN3dPK3R6cnMveGZtcWw1Rlh4YzEr?=
 =?utf-8?B?UWgwSVFPTGlOUFNrSXRtTDVGL1BMRXc5N0pmYkZhVFBQZnFsZDczSE9PWXA1?=
 =?utf-8?B?bno2SHA0RXkzbk5mcnloNEVZMFpob2pjQ2l0ZTUxa3B3bVMxcnVLSFZaZ05S?=
 =?utf-8?B?VzdNWkR6UzhKVU8yWkdDZ1FlU2dxNWdYWmhLYktGNGVKUTlPTnVYRklxYjJn?=
 =?utf-8?B?YTdnUFJOcElpeUNxSXBHWTVJOVpLZkd2dTMwRjEwNkhJWkl1bWgvYXBoanVJ?=
 =?utf-8?B?bVlnZFdsMTg4N0pJbTY2U2U1VjV1d1VvY21URGxHR0RsOW1qL2N4aEpCcktB?=
 =?utf-8?B?NUpDSU9NYWZ3L1ZGR00vNEVrQ3dTYWF2cGxnTEd3L1BRRGVhb2x5NDRFaS9l?=
 =?utf-8?B?a20remVzaDk1cDh3c3RRUkExZDR0M09aS3dsZzhvRmUzU2o0YmtEWFU2aU9Y?=
 =?utf-8?B?eGdudDlNNWowbGU1ZUtpaUd3b2FiNkt5OFc3ckNZdExta0ZWdjRvcUQxYWhI?=
 =?utf-8?B?RDRzUi9LenJvaXJsVnFxOS9XUjhMUndQWGwxVmJvRG9zV0JPZ2NBNGM4MFhR?=
 =?utf-8?B?UVBRbjZ5SjNFRUxnWVdTdGYwMXRCbURoZGM0cEY5SDc1M1pDanJBOTUxWWhI?=
 =?utf-8?B?dE9uQ0s4cUNhM0pyTHVZbWh2Tm9lUnVRdnpCMEc2dElmS2hvVi9qMUNnSy9Z?=
 =?utf-8?B?V01GaWQ3SWR3SlQ0NjVFdis0QVFoakFWM1JKV0FxR1VwYkRHVTJsRnVjZTIv?=
 =?utf-8?B?TFZxZUNaSmRoTndFT1ZCQ0lpM2ZjTW93ay9vN0lHYWpLR0RINmdZUENuejNi?=
 =?utf-8?B?Sm0vcGZoS0NyYkt4MEZGckNzYWx2dnNPUmVYb1hDQ3RMdTlGVEkycHl2QXlw?=
 =?utf-8?B?TzZVRjN5SWowMjJidE9OaVBkeFhtUm5XNnl6eFI4UlZoRnB2MnJEdDJzSE10?=
 =?utf-8?B?STRIZDhBMHFBdjZ6ckE3RE45YWkyaHRlcXBVU3dqT3M1V3lyRWRzcW92UnlJ?=
 =?utf-8?B?ZnJCTjB1c1dLaGxnbWFnMThEL1lFTW5EOFBScnNBUVdYVk1UNm55MUNRUmIz?=
 =?utf-8?B?dXhhWGJSa3BvNklJK0t0S1puTmFCRkV0Wks0YXRpa1NMVFZ1WmwrTGk2R3VV?=
 =?utf-8?B?RWhQbXVJenZoaFRneGhYaWd6T1pxSGROMnhRQXRxa2RKZ096K3JQV0JXZzRp?=
 =?utf-8?B?R1NMU29ReWRiZkV1VXArbnFKSC9majZ2dFlyUlp2Wm9VUGZ0SlBjbEpHY3lr?=
 =?utf-8?B?WUNNWVdLZkttWDB1Qmt4ZitPa1hlVml3aHpSWmpKU2dWeTNzYzRpS2l0QUVZ?=
 =?utf-8?B?SFQ2RGk3Y3JyLzExWlg5RmIxSnNyMUlLMHVKdndYYVVwOWNYdFltSXBackJ2?=
 =?utf-8?B?ZkYzR2traXpKcU1Ic3NrNFY5aWVOZXRIU2szN0U1dUdWYXlocStLSVRuRXJh?=
 =?utf-8?B?WUdyLytDK2tDMng3eE5XVS9iNVk2YjdyN0YwS21IY1d6ZDIrRjdyVUVTRHNk?=
 =?utf-8?B?azFGaDY4R2ZScXc3bFN0NXdZeThGbWp1czk3NHNQNnJ3eG9hOFBLM0hUVEQy?=
 =?utf-8?B?Sk5MMjdwa1AwblNEbUNRWUZMVC9Td1EzZW52eEo1MU9laWozT1hKb3RSQzdS?=
 =?utf-8?B?RVdXVHhjUkdtMmtkaWFVVGlHdWpadi82SFNBQWo2VUR5LytobUFxdnZTeWpR?=
 =?utf-8?B?bThwRWxHZElVV2pWM3FKc21jQjJQV2NSOXl2eEgySS9OY0VjWWZINmJpVDZZ?=
 =?utf-8?B?Wi8xUVdzQzBCT0lRZjY0NTJ0MXpMSnBvdkxjV29Cam51d0h3NlVQUHdYeVZO?=
 =?utf-8?B?T3FuUmhvcEV2d0c4QzNSZjhTY3J2S0lJSGhjcmowVERWZmZLNVdMTnQ5ejNY?=
 =?utf-8?B?ZGNMNFYyNXBhNi9rMTExUk5ETVpiZkR1Rmg5OTYyRFZ6cW9rTjJXV2p1c216?=
 =?utf-8?B?TXlWVWRTVjZtSkc3UWRLS1NMMno3UVZRSVZZaUVMQU5iTmxHejFEUmNkRDhu?=
 =?utf-8?B?OFA2cnFEWENBY0NGQ0hLbVdFM084Uk14SHVoWFVuZTVBZjVaSVMzSEdXRTE5?=
 =?utf-8?Q?lfIYMc7+mEboi4O42atOBqdso?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d9e0d1-b387-4c24-5fb8-08dd154d18cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:51:43.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcwiqlSE7AZLSb5hvFX2wVcq4/aTbxeGPt0Knbqp1Exl/YIp7BPMhZlaJe5p4iP2QDqvjY2Egj3+XsdF8wvtqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7446

From: Joy Zou <joy.zou@nxp.com>

Add the PMIC pca9452 support, which add ldo3 compared with pca9451a.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/regulator/pca9450-regulator.c | 29 ++++++++++++++++++++++++++++-
 include/linux/regulator/pca9450.h     |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 0b1f099fdd5ee..faa6b79c27d75 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -815,6 +815,24 @@ static const struct pca9450_regulator_desc pca9451a_regulators[] = {
 			.owner = THIS_MODULE,
 		},
 	},
+	{
+		.desc = {
+			.name = "ldo3",
+			.of_match = of_match_ptr("LDO3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO3,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO3_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo34_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
+			.vsel_reg = PCA9450_REG_LDO3CTRL,
+			.vsel_mask = LDO3OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO3CTRL,
+			.enable_mask = LDO3_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
 	{
 		.desc = {
 			.name = "ldo4",
@@ -916,6 +934,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		pca9450->rcnt = ARRAY_SIZE(pca9450bc_regulators);
 		break;
 	case PCA9450_TYPE_PCA9451A:
+	case PCA9450_TYPE_PCA9452:
 		regulator_desc = pca9451a_regulators;
 		pca9450->rcnt = ARRAY_SIZE(pca9451a_regulators);
 		break;
@@ -943,7 +962,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	/* Check your board and dts for match the right pmic */
 	if (((device_id >> 4) != 0x1 && type == PCA9450_TYPE_PCA9450A) ||
 	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC) ||
-	    ((device_id >> 4) != 0x9 && type == PCA9450_TYPE_PCA9451A))
+	    ((device_id >> 4) != 0x9 && type == PCA9450_TYPE_PCA9451A) ||
+	    ((device_id >> 4) != 0x9 && type == PCA9450_TYPE_PCA9452))
 		return dev_err_probe(&i2c->dev, -EINVAL,
 				     "Device id(%x) mismatched\n", device_id >> 4);
 
@@ -955,6 +975,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		r = &regulator_desc[i];
 		desc = &r->desc;
 
+		if (type == PCA9450_TYPE_PCA9451A && !strcmp(desc->name, "ldo3"))
+			continue;
+
 		config.regmap = pca9450->regmap;
 		config.dev = pca9450->dev;
 
@@ -1043,6 +1066,10 @@ static const struct of_device_id pca9450_of_match[] = {
 		.compatible = "nxp,pca9451a",
 		.data = (void *)PCA9450_TYPE_PCA9451A,
 	},
+	{
+		.compatible = "nxp,pca9452",
+		.data = (void *)PCA9450_TYPE_PCA9452,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pca9450_of_match);
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 243633c8dceb3..b427b5873de1a 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -10,6 +10,7 @@ enum pca9450_chip_type {
 	PCA9450_TYPE_PCA9450A = 0,
 	PCA9450_TYPE_PCA9450BC,
 	PCA9450_TYPE_PCA9451A,
+	PCA9450_TYPE_PCA9452,
 	PCA9450_TYPE_AMOUNT,
 };
 

-- 
2.34.1


