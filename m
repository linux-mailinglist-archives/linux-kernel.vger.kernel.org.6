Return-Path: <linux-kernel+bounces-435604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2DC9E7A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6EB283E71
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB371DB956;
	Fri,  6 Dec 2024 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NllWARIi"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326F1C549F;
	Fri,  6 Dec 2024 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517187; cv=fail; b=p8kQ2FCtXrdM9qzIRoX6NqvCkda8LW6bcxscuH6us4tQyLpK0heqvIPSJyfNuMJ15b91LHS2s3zDrUyaStSoYgdsQrXqIXI+sDP/mq+vXXwPb9lXg6K/7tBCskirSmMVaL66U7IL22/nZD//KhcBwxpY88gbxk8aMPbhyBUF5cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517187; c=relaxed/simple;
	bh=mNWI3uNd3E/gzjXbU3ODa1UHHptRjyW9uj3Np+PKIB4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Mb/3c3MlOft4D8mUas1XFUjMkP+h5Z/TkjZleuw8b8getv2uZQGddWcGkkl1DdYLWF9IbNIf7zhc4U/BkUzOIBJrWOF+QlAR9+5iVoLGoqQz5wfDRIyzak5frkXThP97bzMMyUswPi4V1hG1XzMiH7zQk3LLbnL35habIWMkOso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NllWARIi; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feR381Jj101tspT/g5yIQVbfCHaLhS1v7HyGMstp1P4M1khGkqO5x7vfkbCSASL30ZCdl6B3DBwoaW5gG3yArKlSlvzpqeSTusJaSN98yXtKWy9xreehFmEzAZNZ/nuwEaIbpoXix6I/GAv1NHUzRaXlt3PZEdr5b5Wg8EBmPNp9yjoPIEGWaa2CYZYtbdEXnVz7QCIQ/7abxDfB/ordbXN8KSkdQaoZaROEGSkUwPuBez4X6OeGJiXJR7Na7Ic3hhxqtsckjPe1nTGvHeX2gnACUe6Ihk0k1mY8pTxgzMo6oDPN7Xrnil/NAblbLC0pBL+qlE5u6exP5g5ULWWlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoNsi50Z/yS2FAs5ubTwkUj3uBvX2ul8Eb1IK0ciazY=;
 b=e4lM7YV1mWarwdqsKfg+TSi+vnPx6GxJjoBhPeuQFXDqjnA8nTE/R0xm8u8F3X+1u5DR5n0X3AQtkGehgVal8ulh0UG8Ct6iGiD9f/yLcQCxSc78iMegp9pr4XWoYADFzSuL4g96KIRjNm5iMvNcMHKql7+OM8BA40wxx+OfVjQkvaN25uq6r9D/VuPcYuaxXfXekpCJsLTJLw/BNHy3h4oxx47o3wZu4mdvlf8yRi/jID7+BQEoQMbk8wShcXM4hTQmPfQ6yBMPyJofLq+YaGOxUQqonLRoFs5MGrnJD/Iyx+r4E46st/vCFIquAL5Vhc0MSXlAM7+f9CwioTpNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoNsi50Z/yS2FAs5ubTwkUj3uBvX2ul8Eb1IK0ciazY=;
 b=NllWARIi+fN/j0tC506uIg/OK87yQnrhk4DkQEUgYZjclAKkYxYxJ5pxgwqnytfHFSRB0Jsvhxn3aVPgQS1KA4ZJdmJXwNzCrzO4cewXO4NCHBaNnIJPCueEjjKq2xcNCwYG5LTfYHyRuPYjUJma6s0zBOVNniTThxkULprXYexEkPiDXCt/ZjZFOo5IoBup0rbYsTyWVZaFg/mwQ9rzj19j+ez0w3VkWn4YEvETA+7B+mUCxfeSzEki/vL/YiLUWP4jk+9VuPfwculdkoNZYYReYpIAr1fGZxKFXMR87nPBAk7JUNylPtfZYN22VoxwiOB1KWkhSJ1MVPpGWwqoWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10297.eurprd04.prod.outlook.com (2603:10a6:800:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 20:33:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 20:33:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] regulator: add new PMIC PF9453 support
Date: Fri, 06 Dec 2024 15:32:39 -0500
Message-Id: <20241206-pf9453-v1-0-1e4685114271@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdfU2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNT3YI0SxNTY11Lg1SLlKSURFMzo0QloOKCotS0zAqwQdGxtbUAUkC
 Id1gAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733517178; l=831;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mNWI3uNd3E/gzjXbU3ODa1UHHptRjyW9uj3Np+PKIB4=;
 b=1NdSrYe2SQP+hXGVhmlDgF0ApXAdiQ8SmByugLuutQe8fIsKvcHoa6ScNdhle4V/yt83b6P4F
 pT131VW1rd7BSzyBA6/4CgAhTokfLqKWOLDMSZWZmpJ0PHAV8QQ37DH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10297:EE_
X-MS-Office365-Filtering-Correlation-Id: 1263ca99-be55-4734-0d37-08dd16352da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ri94bFhlanQ3clZoemV3dDlVT2RUMThIdzRYdGl0SS81NWJxUTNXckpIUWIx?=
 =?utf-8?B?Z1ZxRTk0NTBLN0V1ZzFpeXlTS2dwTWRKWW9Xd3ZqSHEzejhVQ1dycDRqbk55?=
 =?utf-8?B?aTVCdW9SeVcwR1crZXdrOFZlcEt4cU9TWmM3S1V1Uk1uOXJzSjhsd09iRHNI?=
 =?utf-8?B?NXlhdXZmS3lKajUrYmJ3VzZxM0Fwc285elhaVlMwWHVCMlVBcUpiMElLbWtM?=
 =?utf-8?B?bjNMOW13dXRGeTdxVS9hYUladzY5cnNPWVE5a3kxaEpMeFhFTVptbFpHWFdD?=
 =?utf-8?B?WHE1ZVpvOUFTb21Yd0Y5SjBPZDhWTTE2ZzZrN2VUVG45eS9ucE14SWxQRDJr?=
 =?utf-8?B?dFFEVmJwaDBaSTJGTE51WU1zZjJnT1hXODRsN2ZFUmpxeGhXN3hjM2l0S1dU?=
 =?utf-8?B?dTZBZDlIR0VHSG5LS0J5LzZpSGZNbnlHVmJZaHhuSitKSFhYZjAxaDRtcUJR?=
 =?utf-8?B?YS8wOXp1bVlUSlZHRmVWNU1zb1JBWXdLV2ZwU3pyS0lRbzBFbHZPa2dlVXh0?=
 =?utf-8?B?VmFadmw3Wm1OazlJS25RajBaMDRkSFVvWmpWRXRLTmk2S2d0OFBDdVhGUFNM?=
 =?utf-8?B?U2tLcXpzbGlBejdxeUZySXNVV1h4OFFxei9NeWxzdkN4U0dZN1VSb3dYbGxz?=
 =?utf-8?B?WEJ6RG1RYXRyVmgyRkJudS90Wkt6cFI0ODlPUkVyR1lMRWFibit1WDE4WTY1?=
 =?utf-8?B?b1hMdjl1bXZkOFp2QnljWjBybE9UQTRWZ3hZeC9ObG5JOWhJb3FSN0ZpZU5a?=
 =?utf-8?B?eFNwTmgvb0N3U1JwZHJrMW5pODFFQjBZaEhLdWE3V045L2lkbE5NeDFyM1J5?=
 =?utf-8?B?bGxnN3psdkdJbHVKelROa0wxVTBQaVF6eU5jUHFEUFd3NG5FNUJMcTJVMmZT?=
 =?utf-8?B?azZXK2N2UjZWOTBHTU5STnFnbWVWdXArNC9EelhiZSt2bS8zOEpqQ0I0ZlJW?=
 =?utf-8?B?ZjV2dkhYMm5iTW5nUHZXeE5qWW9oU0dGdjJJdmc3QWpNc0lnUEVMdFR1MHE2?=
 =?utf-8?B?aGh1TmZkd0E2WUlvamptZ0JzNHNOWnNrMFM5ZEVnUWxvVnFjVHhCN3RZOEFs?=
 =?utf-8?B?em4wMS8za1ZENERkVjZXRFhoSnlMNmVXMTh2cHV6ZDVMUXdsMy9ucEZGcGVo?=
 =?utf-8?B?ejZtT2diR2xVN1lTYlQ2VnNlcDdOaTJuYUNLUkZVdUphVGNTQmFwYmxObUNE?=
 =?utf-8?B?emlvSEhLYmZVK21PYStHRXgwdU5HMlcwUHZ4MlBOVUFCUE5VRWdUaXVsNnVv?=
 =?utf-8?B?QzZHeFh3UUxkM2NHMlYyMkQ0OTRHUUhyMWRubE9XSWQzb1greERCbSt0QzZR?=
 =?utf-8?B?OXgwS1BPWjFJbUtQZjlOd3JVS1ZGZDRxY3JZR2xZTityUXUvNEpkVkdGTHlO?=
 =?utf-8?B?eXUzaVlQSFpnak93VUl6VXUzNGdtM1lJNXYxN1Y5bEhtUkZVd2Z3NG1vc3BG?=
 =?utf-8?B?YWdFMkpMTTZFWUlmVG5GK2lKWWoyczlLVUQwU2xxc0VIVS9vZ3FGMW1VcUJq?=
 =?utf-8?B?eFhKcDVKeExsdFc0RCt1V0dIRW96TlVNOVhFellFblRGMWtoSDJOTzBMZUlz?=
 =?utf-8?B?cGx0ZnAzaWZhbktjOENYeTRTazhsdDRoWVBnbFpGTkpBM0wxYWVndUZSS1ZH?=
 =?utf-8?B?R3o2Tkl2c1phZ2V3VWpDd3ZaOW1wYVJ2Tk1uQWRsd1lNVFpuV0h2cDQxbG54?=
 =?utf-8?B?K2hLTFZ2eE1HaGFQNHBBazVKQkxucktkMHd0QXRaUlJBUTYxT2JEajNXWEls?=
 =?utf-8?B?UVRMZ0Rha05sQXJpMVQvdXJ3QUpwT3ROeHN1bzdVS01ZdFREZ2J0MFA4R3Bl?=
 =?utf-8?B?RTVYVW9sa0xJdWkrOEJVVSttRGNJYStmZkw0NUVxMlNOSEIrUzhBQkxkcHlu?=
 =?utf-8?B?NnRFa2czdmI5WmVxeGYzYnh1eU1ZU2FHOFY1RUdBMnIzeGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWcvRXYwQmhldlhpQUd3QW9raEFtRTFPVDUwQ1RIOU9aV1ZUN2UzN0l0dEx0?=
 =?utf-8?B?eitVSG9XSjYzaDFPbURibEhXamZiREg4NFpuMDFBRC8xcE9UNU5TWkNVY1Vt?=
 =?utf-8?B?TXBWY3c4VWRsb1NBYWVDZG1rM1lDaTdRanBDQnB1SWsvRXBhOW1JWC94VHRS?=
 =?utf-8?B?bThucitkRzBoUDk3RkM5cXY1dUs4WTBLWE9CcVVaVnNiU0VMb1ZXbURBa3FW?=
 =?utf-8?B?RmhMd3JDS3NXKzR1N09sWkxIRFlCUkxEbFJHK2cyVkNtMGx0bWw0UW5Vcjdi?=
 =?utf-8?B?bGdVQVp0bFZwN3RxdUV1a2pPeTAwUG5ScWtGRDRCUi9FQ25YRS90QUlYanNS?=
 =?utf-8?B?N0ZDbTJPN25nUWR4ckhobzZaVW9sT1hOeFlEdGpoMDZ4UERmbHR6Ym5kdjRN?=
 =?utf-8?B?ZGpJdG5GY1Z3em81QnZTYmVmWVRwTHUwcVFVVCt4Z2ZSQURyclJ3M0EzanZq?=
 =?utf-8?B?eUsydEpWeXZXZ2hUYXlvSUF2ZG85eC9BVUhlVHZqMmN4LzFlaStXd3Jhc3cy?=
 =?utf-8?B?blhFRmpEZTJvLzFZV1psMTVzRnJpNTE3dlVMQ3VaeUc1MHhxT0xzb1NORmVm?=
 =?utf-8?B?cUptSzEvemtmak9FMFQ1RlV2YUlhT3NGLytiMTk5NldPYzZkTmt2QzJ0SlRo?=
 =?utf-8?B?bWd5N3AwRGJoSVdEbXNHK3ZNN3c3NVdsOGJ3TXgwcFJWdFkzb0xUTy96cjZy?=
 =?utf-8?B?QjV2TzlTd3IyNE9qbm12ZmZ4WWNTTFVZVWZqUHI2dXZ0YmF5azV1RDdkNkh5?=
 =?utf-8?B?ZWVMaXpDYVVZaG4xWmttK2s3SkVRY2s4UmFVSEwzZ0t4Y1hhWnluUEtVSXFn?=
 =?utf-8?B?eTJESzZlUC8rMDdPc0M0NWN1L0FOUHVUalk4NG9NRERYaWFOL1Q0T0IwMEE0?=
 =?utf-8?B?Q1lpUFdjMDFCSXViRlZYdFAvN2J6UFMvSzhTMmk3blhXaUVHZnlBNExabzVp?=
 =?utf-8?B?akpDckhxTVBwY3ZzclZiQkFpZ2FMUmxZVWVibWlISGQxYkNqWjJ0VDRrOEpG?=
 =?utf-8?B?SFlDQnJRS3Y3WDRlVDlUTndScmVrUWRnbmJobmhKTStjY09tYTM1MGUreERz?=
 =?utf-8?B?c2ZVZ3RqeHZmYVJsalh0WUVlUSt2MHF0Zy9HTVR6a0dnV3o3YmNoVW8yNjVC?=
 =?utf-8?B?ejRsckxQU0lzWVdsNHdWTGVURTVNZXhTNUdoNVFzek9aVVFJcGMzN0xwbEE2?=
 =?utf-8?B?OGp6a0RNNU5zSHhRY3FHT2ltcUU1YXkzV2RueEJjbktGd2UyR2VUOCtrRUl1?=
 =?utf-8?B?YTNqVnFIekpKWmV0Q3U1bUJ0WnZSQ0hCSXc1NDc2QkJ0czloeWFvakNETExv?=
 =?utf-8?B?bElNdG9aNFZGc1BWbERsa3ZKN2IrV0JRUXRUMTI5anh6Q29xb0tKTG9NdmE1?=
 =?utf-8?B?RVhvbUQwMXpuckJNVkFPSTFyamxjZkUrQnA1Z1dxTTNHSS9DZ1BSb0tVWk5y?=
 =?utf-8?B?c0dKTHBDMHpMRHAzbGFSRjJKV3A2RGYza1pYclNPUDMzYkVpb0ptbW1HcVN2?=
 =?utf-8?B?UVJuVFB0dHlOeTJ3dHB5djJaRitwTWNDWG5IVkZEdzB1MU05dFp5UnZnRDhx?=
 =?utf-8?B?VDBzNlpqWVpSbkVjZjJFUE54c1o3OExPRXdZcERxNlhzTEpkV0o4MlBCdkVU?=
 =?utf-8?B?ekViUEo5b0VCdWRsZURUQzdrMFZCY3R1NkhIbkQ0V1JqYlpmN3JBdVJRTGpW?=
 =?utf-8?B?N3JZdkQ0U3FvYW5BbE8rdlFCbGZsd21NNkwrbmlZNmc3NWV3Z0IvbjNBc0ha?=
 =?utf-8?B?RGFaeXlKZDNsN09hT1RZMWdVK0tJaXBaa1Z6Rmkxd2s2WmIwaVI4dk9DeFgz?=
 =?utf-8?B?bGVjcTFPYVlON2h5Zjh6U0F4ZGdYQWhGZW8vWWI4NXUxaWJITDhsYThNRTFp?=
 =?utf-8?B?VC9vU0VLOGRUazJwdUJQbXBMMUFmNEZVck1BVk1uUDkzMmh2dHBidlByU241?=
 =?utf-8?B?UklDQkFMWU1PVkpNOCsyNXpHUzF5SkZhck5ld3NHNHhBSDJ0R2QrSEdWWHlw?=
 =?utf-8?B?SnlmSVIxQnhXUWVESHNHWGN6Mjg0UEYzUjJEUklua2F4NHJ2dmtMUTVBNHJM?=
 =?utf-8?B?LzY2Y2dFWUxHbE1JM3NQZzV1NDJrbnVMa29pNlc3M25tVlZrR3pQVkVvRTJC?=
 =?utf-8?Q?a+uxPE/dSNOTSUivNG00cXfM6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1263ca99-be55-4734-0d37-08dd16352da5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 20:33:01.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uxz/3yVIVavHOT0BNFD4iHeLvUR/reD3HCzP9Wqt8KWcc0mwVnDYJarnaup40MVpSe6xCjO2WMcrrsek30lPww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10297

Add binding doc and driver.

DTS part wait for
https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Joy Zou (2):
      regulator: dt-bindings: pf9453: add new PMIC PF9453 support
      regulator: pf9453: add PMIC PF9453 support

 .../bindings/regulator/nxp,pf9453-regulator.yaml   | 158 +++++
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf9453-regulator.c               | 723 +++++++++++++++++++++
 drivers/regulator/pf9453.h                         | 171 +++++
 5 files changed, 1060 insertions(+)
---
base-commit: 0410a58d54385475b67ae7fd2d705072569f0299
change-id: 20241205-pf9453-90e8dbda562a

Best regards,
---
Frank Li <Frank.Li@nxp.com>


