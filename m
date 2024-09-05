Return-Path: <linux-kernel+bounces-317777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2496E3AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF64B218F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEEC1A4E91;
	Thu,  5 Sep 2024 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C8HGo+jT"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7721A38C6;
	Thu,  5 Sep 2024 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725566807; cv=fail; b=F5rrkd0NpTbV9Avwqt3nhAJwH8uE/X7IXoAgRj1t2T1ugHDf05udgS2A6WY8vgVFZP61JHA4LeAyzX5xJx3Yv4PLjrpDVVStSEbsDQVvPuk80FfK/i7Op3VNwFggm7W5gzzJsbcSfj8zM/QY9JvSAEu48mzPLp07EMoIKURFpXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725566807; c=relaxed/simple;
	bh=6I2paEON9fWdTpUTAomoPNrvduXxYTmjf5EOsVJ+SvM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=noyP4310WygS/ei9aPbhmfWbd/DJGuM0TvdaHeRmWD8wSEmip6XMlZ9yZNOxgHbFi1SYyA3unQ0HnCK1XOqbtPZOZhBwWOaZAcJYad7P+z+Rn/c2/Z+PcNo+m2byM2wZTIYr10vCXeukiupAtNHSXjtWdWGYmRcxTR6s7JAz2ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C8HGo+jT; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfTCmHu7F6lBUKKZWYTI+26UWRgl1iM2RRpsOIqoh7iJoBX6mBrqjFbkphJJo0GVbhzYrivYkfD+uvqR20vlpoY74LMcUudUD0euPiVW0YodNWK9H+xkQTnhUzNGesMaO1ID1mSTDXkFj0CLEGfOiQtMFH/Cy2FLq9wZ4uNDlMAtDY3zgf2Th00ShoTNSBcXoj+hucdVP44lBp3G4GOxRBlDwcK+QoQhQrJH60W/aYLnO7tf09aZjAAeGFwIQOJhChm1Y9oATq7chkbHHyX/dtQr1ebAFA3SFg744sazpnoAeqB+lhE4O0aGZ4bF/cMWsRuD3UY+Tn1Epy3CWbLz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/PzFrWtGF9hTyrICETmWUx3fh3QeBCjPfvhvO5Lh9g=;
 b=S/RV2z3aM/jgkUyyWbERwEE5BoiT4nY1TLvUZvbqPUl3DdDVPsp9qIJ0cqdMbMBYM56eoZaiOGOqpVvg/acbktoFpCHmDUW8BlE6vTeuqr6ITgvtTxFZRP9vpnJZfhnR0bxy3VOARRdgLfRxPuMT7+c3MJR6nhyU3dReu52u885doSUQL0L7bdl1IDbXUsAt/dRw3ooN/zYXCkc3NvCkWE2Ag0SvPkzgj5mpmZje4LWlWuDiTeDRUrOchQ55DsIW+0Bsc7wtg3BEawu2h3AGOXuDbEabVfJ8SszRREEmai5NTfUNFZdtrm6cZ2N591RsNBdQs+fefHcmBFEIFptSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/PzFrWtGF9hTyrICETmWUx3fh3QeBCjPfvhvO5Lh9g=;
 b=C8HGo+jT5rvyu/yQ7PrnMq00Fe04CSnzUqTGiGrrrbdXI29+64evGtUdk8tZjHv/FG3AjT2nHB6vJ3wOCVoGoy8jmt+e6l/9qDGKBlEcedTMVBZamlIFjUEHVDhPlSaK+bo3apfNaUc3jPLgdJc1x6hUkwvKbdG1NRnVgjEHeVW/CTGM2DO1riODbpKMsD3jsR/WZdZ1xDILYy+uP528EwoSb8XUni2gF0+GSnKh3YL9J8zIhkxZl/Di9XsGBWxMBh1BduW8bWGADEVMrpHPlvHWYHgIYb6gB7PVf5JtgeWxhu/lLMIWf+7V7AvUClf1N7d/O1qI2mxCQJx4vd2OTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 20:06:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:06:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 05 Sep 2024 16:06:21 -0400
Subject: [PATCH v4 3/3] usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for
 system sleep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-dwc-mp-v4-3-aedaeacf0556@nxp.com>
References: <20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com>
In-Reply-To: <20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725566789; l=2128;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Hs4mq3jmjFdySao7yPW+t4juTxFDV5Z8B1pHbqTlbAg=;
 b=3satTEOeuofPWVgLaIqoanfIZ1EW/2VQkW/Fp+in5oHDN3mr2/pwWbMz5apHpIqf/SH/HDbCI
 gBZ5x6HhtkMCf1ABNNFrDk8lDRaDY5tGtM6a1IFPJ7BAkqDBKF7RdAN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd2ac5a-06ce-4654-080a-08dccde64383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzVBUHk5TXFlejhHb2lBZmRrWEx6bTllTFhXcCsvcFVpdldia1RGblhmclNB?=
 =?utf-8?B?cTZ6N0xrYzRKMWYyL0ZNK2ptRzhkNERGbnBUeGlRV3hQb1l5SWNDN3FabGM4?=
 =?utf-8?B?ak5sRWxjeHJoVHZnMGVMQXJQaVZua2hHTE1GNFhxMldKSy9aYW8zV3NJTDVz?=
 =?utf-8?B?NUhDSjh0MzdsSmtPbG44MWVjNTJWdWNld3hZd1lSeCtlc25MQnJXQ2VRR2N0?=
 =?utf-8?B?TU9IZWhvd2VydFhhZEozYUZqdFNvSE1CZXU5bW1KdVRyWFF4SXlobDdBa3Jk?=
 =?utf-8?B?VVpTdXNaZGwrNVVEWUdXQXFGam93anJmSG9NeTk0V3hGa2p4akFkTFBPNzdL?=
 =?utf-8?B?S0cxNjgxR21Za2htSGxqTkQvSzl3WkxNSzN3Q0t1K29laFM0VHNQbVFOZ2Fj?=
 =?utf-8?B?T1Q0cHRVZU9Id0NMRmtVMFN3dUNrcVdtVjczUC96U1BldEVGVS82T3hyZHor?=
 =?utf-8?B?dnp4OUpabnRqeURLRGRuQ2FYMk11ME9DT2wrUk1vSEVYS2RqamhQVDB5eVlM?=
 =?utf-8?B?UnFzWHZaOVV4Z2ppaU9TdE85VDBUSW8xMlRNR0YrZnRKZjhwMWI2ZVUyYytN?=
 =?utf-8?B?UzZVQXplWEJPNzJocklaeW44VENHUU1vd05tbjVMd0lCU3FFc28rOFFVSHZk?=
 =?utf-8?B?bitCdkh2eXFjRFY1eUtUMGJJaktNUkZXek4ycmdVTWJSeEdkZGZlQ0Q4SHB0?=
 =?utf-8?B?Y3M1eURjTEpIcGFYSFlpMVphbjZwazVidURIYTk5OVpYRkhSQTNrNlQrR0Nx?=
 =?utf-8?B?dXpIQUNIVGk3NjNESmdLdGNXcmdoaCsrTXRoalo3TGEyMjBKUjRURkpTZGNO?=
 =?utf-8?B?Mi9KMkREeG5UcmVibWpXa2F2MHdwdEVKMU1uanhOZkMzaFhVcURRdzZLWldj?=
 =?utf-8?B?WVd2VXNkS1pyK241NXp0UHdSczFvdWVwTndUSDVIYmRHY2YydlRGakcrMS9Z?=
 =?utf-8?B?VHE3S1VsSW5qeTRKRFFHeEx5NFJtMElSeE1jU2hyczVpZUxwSUNad1pkbHp0?=
 =?utf-8?B?dHE5SjZVTkdWNm0veHEwNWhic0JvMnNIUkRaNWZ4NlExdVBpVG02RTc1S2pl?=
 =?utf-8?B?cVFPd293ZDZiYVFZUERBRGU4UUFmdHNWQXg1QjBMaFlmbDB3OFNPUWVsVHdL?=
 =?utf-8?B?aytxaFY3MmxKY0ZVT0xoakZiU2Z1cGM4S1ZXc0l4RGI1OFB0Sy9NWEJ0SVRu?=
 =?utf-8?B?QnpkOGJoZXBKUHdTblhpc0pGSG03U3RTbWR1NzN5SFFVeWg3SkpoZnU0ZDBj?=
 =?utf-8?B?eWl5WVRMSU9rS2k0N1c0YWhjWXN6V0ZqK2s4ejVFSU5KSk8vK1R2dVRvWGNJ?=
 =?utf-8?B?eFBpZnNuWkdudTVVMkFuVkxJMkZSaTRUaXY0TDdQNmhlWGRiRm9zVDFLdEZ0?=
 =?utf-8?B?cCs5c2l3MWxrUWNTYUJlalFjcGdZcEI0VXpmaTJaNVVUZlh2ZitqYUd2U0JH?=
 =?utf-8?B?TFJ3eFpsL2FXWXFRZWd5R0lsL1JzY3ZnQWRpaFN6UDVvUkxkV3dSbUJtazU2?=
 =?utf-8?B?Mi9pcS9RcGxqTE13Unp3ZGNOYXZNelptajgvL1JLL1ExWDQ2KzBYZ25jUU4x?=
 =?utf-8?B?eFJwYTc0WExPa1RpdUd5L2x6T0F1UlpHSXRsb3daK1prNWFpdWdSWW5rTDgz?=
 =?utf-8?B?emtWTEttSjREc010bDdHMmc4RWFwZWtLa2xyWFd2amtiME80dkdVY2hXemM5?=
 =?utf-8?B?T3hkdkhrUGdneXJEa293cGxzVW5OOXZxUTNzVU0rcnlGZGdDc2Z3Zi9aL0Y4?=
 =?utf-8?B?aGRQcEZDNUJQV2pIdVR5Zzc3dVB0aGRmbXFlaFFvN1NJbkZhTWFmNTU3VEov?=
 =?utf-8?B?QlVHTXdxNzBkYnJkbDZZaU9KWk8wNVV4K2ZyUkliWHVxdXBTWTlna3lpRzQy?=
 =?utf-8?B?cktDWE1LTlBWcCtnL0ZJNjNaYWNHa1lLaGtwblF0dmpabVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnlTZzBVV0orajhmVHZaRXhDejJMZ2p2NUhQRUhHNHc1eGViWUN6M1V2dGZS?=
 =?utf-8?B?dkxzWk1wKzdhcUo0VXlrWVczWnNSZ05lSWJIdEEzMXNHY09qcllCSlMwVng0?=
 =?utf-8?B?Uk5TdVJPQUsremJrRnZUMVhHR2w0Sml4TXFvSVNPK3U1T1dlSThoY3l1ZVpN?=
 =?utf-8?B?cXBicGU4N1ZCOFRZVzZLMWp1MU9kaXBoZFZ2TE10RmhpZWJ3czFyMFlWQW1G?=
 =?utf-8?B?bHh1bktZK3FXVzRXY0hBVGYyMXd0cUVrUk1GL2FBaGdnUnlVdmY0VlZaYWU4?=
 =?utf-8?B?MENMQ25rMzFMV2E4NWlJLzdYclB0RmVjUlJocHZOY2ZzME5TY3hBTzhGcHUx?=
 =?utf-8?B?dDRydWZwTHB4SVZqM3JYUEpNYUFCRDMxcEZJdWdFbnF1ZmwyZkdWNkt3a3Yw?=
 =?utf-8?B?eW5hMVF0TjBHVGptVElnNVNMRkVlYTVnaGtaY3MvYit0UDhFdHMwazlLQlYw?=
 =?utf-8?B?dHJiS3g3VVNPditlYzREYWU5WjFxVnpWRlhNVGp6c0FSdWlmWVdmY0ZQS3lQ?=
 =?utf-8?B?Vi80TzF6cU9aSU9ob2NwclRTek5LM1JNL2l0TWVrcVZTVURZZVlmNS9ZTTZ3?=
 =?utf-8?B?LzFUWWVEQWFkUFNYQlpOU1ErQWVBTUlIZW1aaDZqcm1Pajl3QVZtYjdrUFpH?=
 =?utf-8?B?S0Zoc3pJMnhEWmZ6WE1xcWRjM216dXhHM0U3dlR6NVhFWjgrYXV1cGJGMWdG?=
 =?utf-8?B?SFFxOVBnelZzbU1zd3hKdXRUM1ZHUnNJWHdXcklqK2tNdnM2NGE3YysrZ3BE?=
 =?utf-8?B?M3FmUWFaSzcrKzNMQkdHN0FMZmhhbjlPTGIzaGN1elI1QXFtTWtkaWF0TmlU?=
 =?utf-8?B?eEdHcGxzcE5hMGVXbXZNSkJTRlg4c1QxZGJSYTlja3FHcHZxL2trT0xyd1di?=
 =?utf-8?B?NEduZnpoU0FhbldkODRQT0g0LzNRcExWcXVmby9DQnVXVW81RjAzMlgvVldw?=
 =?utf-8?B?cVo5RGt2SGNQNm1ERkw2RjdzTGlnV1dYRGhFUlBNSGxFbFV4d0dXaDVWbGZY?=
 =?utf-8?B?bHdLQVBsRzlhdlBBTXgzNTJtUGNyOGQxdGdBN0Ixc3A5dmhocTNaYlBUVmRq?=
 =?utf-8?B?Rk50R3dONzVSL2hzY2VXcXBtL3RBTGl4ejNzZjVGSUJ0TUxjUVpoMHg1SHJv?=
 =?utf-8?B?MlpZWTllSEZZQWJlQUxTeEtBd2k4RDZqUlIxWWJpYWRiWVY3U2VKanpjcEQ5?=
 =?utf-8?B?WFdCdmhUMTUyZWpyM1lGS2pmeTRFU3NjRHdJeDRzdEpzdEFJZWYxZitnc2hj?=
 =?utf-8?B?bTUwMkZkTHVrbjVUNEl2WEhTQzhtTk9tWnc2OHpqUzBpeGJlcVBMVmZtLzFH?=
 =?utf-8?B?aUJZdjlRU0k3Rlk5UkhCbmlmbWQyTE5OSm5PUjNreG96Z2RKVWFmYWVNakNh?=
 =?utf-8?B?MDhkelBIbi8yRE9YSFF0Ujl4ZDI1T3oyclljTkxRL1AzT25zNXlhMmZrZGd1?=
 =?utf-8?B?eE9IMjVCS1Z0RHlYOXk0djlsdVRqNlV0M2FiaVhNOExlaW45ZUxKbmFyaHRl?=
 =?utf-8?B?a2JlNzhDdTRIMUhidURUcVdkZE52bFRKcUtNcjVZT2tuWmsvTlQ4anpkaWY4?=
 =?utf-8?B?QlJ5ZGUxa252UkZTWThwbEpOUzJINGl6TDJFU1VZTzErV0xrUDJnL2JYZDNa?=
 =?utf-8?B?d3paUW1MbFhIVWhDUkdSSDVUYWlOaHdYSzVxSEtOdnB1MkMrV0oyOHR2UXpi?=
 =?utf-8?B?NkErQnpXM3V5ZDRmMzJDSXAxajF2MldwL1Q0MXJSaWJRZTV1blgyRnp0ZERj?=
 =?utf-8?B?ZXZaLzdYUGRFUHFRbG9CQVNOUng2ZUthaisvUzFaVmRKaHdMSUUzeTR0OUpW?=
 =?utf-8?B?Zy9QTUJ0UlowVTRCeENaSS9sbUtCdDhXNndwb1ZMZFN4YitGREVJMURXTjN0?=
 =?utf-8?B?V2FSem5Pbk16NkN5WTIrVVdiRjVCbjdZazZ3NXBZVnM1SzJkY01OTjRiMkN2?=
 =?utf-8?B?d3V0bGdPZDdMVVNVUlJjSFRGTkdxdFk1a1Z0TDZUQjc0aGR1UXdBUDFFY3R5?=
 =?utf-8?B?bjQrMk10VFFWN3VyL0ZDWjE0eHc3eS9URUVPNi93UlNCVWNqWDVzeHUrM25p?=
 =?utf-8?B?cHIvaEk0eE1qYjJNVG9XNDdaNWp5RnhRUkxoTGhJMEdTajNpNUttUlhpMXNZ?=
 =?utf-8?Q?YkLM1Wdnu55MANmObjfpgnpOO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd2ac5a-06ce-4654-080a-08dccde64383
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:06:43.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyW2ljZA47VOGNP2HxE8HAAwYnR8RD0aQ/gBbpjxwcL0wmh9+36AlGBryZNPyvc0n7EvW4VDms9NoNZlbOL1Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423

From: Li Jun <jun.li@nxp.com>

SS_CON and U3 wakeup need 'ref_clk' on. iMX8MP turn off it while system
sleep, So disable these wakeup source and only enable DP/DM wakeup source
for host mode.

Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index f62f6f960e501..4c0aef5792ce2 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -97,7 +97,8 @@ static void imx8mp_configure_glue(struct dwc3_imx8mp *dwc3_imx)
 	writel(value, dwc3_imx->glue_base + USB_CTRL1);
 }
 
-static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
+static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx,
+				      pm_message_t msg)
 {
 	struct dwc3	*dwc3 = platform_get_drvdata(dwc3_imx->dwc3);
 	u32		val;
@@ -107,12 +108,14 @@ static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
 
 	val = readl(dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 
-	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci)
-		val |= USB_WAKEUP_EN | USB_WAKEUP_SS_CONN |
-		       USB_WAKEUP_U3_EN | USB_WAKEUP_DPDM_EN;
-	else if (dwc3->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE)
+	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci) {
+		val |= USB_WAKEUP_EN | USB_WAKEUP_DPDM_EN;
+		if (PMSG_IS_AUTO(msg))
+			val |= USB_WAKEUP_SS_CONN | USB_WAKEUP_U3_EN;
+	} else {
 		val |= USB_WAKEUP_EN | USB_WAKEUP_VBUS_EN |
 		       USB_WAKEUP_VBUS_SRC_SESS_VAL;
+	}
 
 	writel(val, dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 }
@@ -284,7 +287,7 @@ static int dwc3_imx8mp_suspend(struct dwc3_imx8mp *dwc3_imx, pm_message_t msg)
 
 	/* Wakeup enable */
 	if (PMSG_IS_AUTO(msg) || device_may_wakeup(dwc3_imx->dev))
-		dwc3_imx8mp_wakeup_enable(dwc3_imx);
+		dwc3_imx8mp_wakeup_enable(dwc3_imx, msg);
 
 	dwc3_imx->pm_suspended = true;
 

-- 
2.34.1


