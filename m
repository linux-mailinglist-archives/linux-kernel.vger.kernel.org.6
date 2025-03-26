Return-Path: <linux-kernel+bounces-577005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC01A71734
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE8A1759DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FA11F1303;
	Wed, 26 Mar 2025 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cgfDDwPH"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012037.outbound.protection.outlook.com [52.101.71.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6911EEA38;
	Wed, 26 Mar 2025 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994908; cv=fail; b=alP5ZlT872JIEBqC4KA1bltZgqjImPEgZscpzKP5KeyJpuVFv8vsIeCk8sd4W6cLiVPdx4HXf/cHE6jjC9iKju4D2tD1YoxZ4TSAKH2I4XaWixS20cq8HznK9ZhyrH0uY4qdXGenh+iJqR54wTZjxu7HlzWAaA9hQunEuOQzjH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994908; c=relaxed/simple;
	bh=Am+Ylr90BSOOvZ1CM+nme3ejG4e4Q1vXzuDz2ouprmY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l4t4IMhPHLBlMy119agTMzAk90JpVCM4y6dCOUvO8pQvfzLpYSqREyVVlY5Z4G60Kg4wADQRJibnoM6vNzobT/QD5v71e94W+/USJ55g67/mAi0zl+4ZhioALHko6gICTkhxxCkD74SCmuoDIVIZ3buqx7iVLO2A7zIT7GSJ7ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cgfDDwPH; arc=fail smtp.client-ip=52.101.71.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3NTY8qSYiFUvh1s4q0M0jwLo26XXUx7MpaTjx8KIKUvQEhknS00vr6mpCM4jUk1ygzOAXin8sL7yo0BJ8Q4991sbdzxE+NHZNju4ZujVnMXwfNJEGKJd7RFm7UJ/Ay89M3T4e3ddqIlZHYfvkQL79XsdiEnOZMwrKpJWhNnqLiJHOiKid38+LKPNokjNZkffaxBTNvaQ3b0qfWlN+9CI9PL3/Rk4CTV/R6nZBaUgWXqf71Bko0/gsFJen38kQaTfIxjfVI6bP1NDRwEugb/7WfgABgaKL4v5TBiO9xmJJ105B/PrrGVljCd5tfZIzksJrftW4PiRBXkx6GBzt017g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0+jNm/oCY+edyAlRxCrL+v61cacOZ4p83gSZFxDEZY=;
 b=DRMY2/l0LA5ghXtir+1gVpQQ5mBPo9Fs2HOj6qDfypdefPmR2tvn3snWDv4e3bFSyq8XGem0MM30gkdw+0ZYlqCHxJ+qhav4SDaOgRq0YmH7vXP8H69B8f5ZoT5m+DuX7bvfUG87BITBKpSXUDeTYFe6VKGdyFr9FhqU8CIHYgD6yOz01dHzBjkRqD3/bLqqPsjh6m090hn4FvmNALA9/kQ581yyl7eTW2Vs7bsWen7El5XdQ8pRoFUKyzKQHAeSNJWHxWh1r4/cNkIvswVZAe9moVmWZQaedgIBjXkVktI2Vetjl5ywTrgE98uFGoB9nRb0DgRw21ZIoX5Nj3ACvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0+jNm/oCY+edyAlRxCrL+v61cacOZ4p83gSZFxDEZY=;
 b=cgfDDwPHrLe2zmnq8cOSAP0JBqEs7xIeYa7fNnV8nyzfT0uGA3q4HH3fj6gbGjt6mUXTNcQD689iF1jz6mEX5I5UAxhBz6RtLl28Na8FtDdrJ+mf9B64xcC29EDHUVizi4/erYiprN7rHkkGTbGjSSZ1e2Wj1SueVOh7Gdc/qF3c+kp/Jenhx3UJSuWR6OU83ZUupGb2H5UHjZqioCVrrGZ07FReRL4Sk6kk97qoQhc3VlMBybWAgPtD/8xrtPbSm1UdrX/omRJnjxOSfeigBnL1M34lVeXKg4wEuXvhIAEguB0gpkpPO2T3dm7ChVOtk+Lc1qgwI8mo0DlYTku14Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8855.eurprd04.prod.outlook.com (2603:10a6:10:2e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:15:04 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:15:04 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Thu, 27 Mar 2025 00:07:59 +0530
Subject: [PATCH v14 3/6] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-imx-se-if-v14-3-2219448932e4@nxp.com>
References: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
In-Reply-To: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743014302; l=2596;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=Am+Ylr90BSOOvZ1CM+nme3ejG4e4Q1vXzuDz2ouprmY=;
 b=mhTBBAWW+rcsm0GQ8siiE2PEL5o+JkMowLCMveSaacIGfSZ79f1wr2jCR8E94MztDHooViTXk
 UwyFSBeXcaBA72fDQWcHP3OEyctbALxCWiKUMiG6SJ85y7hgtv/PVe0
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac4fffa-61d4-4411-794a-08dd6c6838de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHhyMWlPZDZOSzNLQ2pyenIwRm1kVis4OXlNRERKUExtdzlQUVBabzhUNDdI?=
 =?utf-8?B?MDNTMGZnQmgrbXA0NXdhOVl5NnRwMUxsYVdjU04yeXRDSzk1OGJZYjI2Njln?=
 =?utf-8?B?b3ZaeEs1bGNjZUlJM25RZWJRK016WktUUUdUZi9aMXBXU3lkcE5ObXZSeHYr?=
 =?utf-8?B?ZHZKdExWY1RIK1VEOWl3SmpjMHRqN1R3OStpbHl2S05SRS9QVTFzR3hxWitQ?=
 =?utf-8?B?aFBjc2ttaHBSZkZBNlowUVhqZ2oyaHNpSDRsT1JhMzJuUVVyczdkMnpnaDZt?=
 =?utf-8?B?K1UyVUw4SmVSMEVLZWhMME9CeEFnNnJ0TVRNVGM5WmJkbmljcjV2VHhaY3R1?=
 =?utf-8?B?QWowMHNmeFViajgyUU1SalpKK3VucE1vL1dkMm5EWWtDZGhOYW9kOFBTNGN0?=
 =?utf-8?B?Zy82c3BaZXpWcW43OXpyUW1TM1JJeDNaRXMzV2c0dEdFUTBocGhJaWU5d05h?=
 =?utf-8?B?cGpnaFVtNHMvQVloNzh5V0x2QnJINlg5VWVTaHJQMTMrK2ZPZW5YZWlpWkpS?=
 =?utf-8?B?dnk2QVhhbldVWHp5RUpySzZOVy8yVlJBYU5uNVI2L05nbm9pZEc0NUJWb0lv?=
 =?utf-8?B?dmFUN3owRTlSNlladmQ0aXdPWmNUMmZHQndFUSs5NUN2UzIxbFV4M3NKY2Fs?=
 =?utf-8?B?eHFLNllQbmtHYU1TelpPaXZEVnNtT1Q5aGQwc2Zxcld1ODR4Q1hKZGxnWlVH?=
 =?utf-8?B?K2J0OWpHbnY4WFF6RUk5TXNsTEJOWnlUVjRJSkZYVFhseDhLcCswem5BWnVU?=
 =?utf-8?B?Smt0NTZjV2EzTytTR0hpTUk5bjQxd1AzS3h6UVNVZEhxeEZjekVOblRwa09X?=
 =?utf-8?B?WUlaeFZJem5DZ21nUC82YWNmTCtNNGNQUExET21RRWRZSEhPUU8wTDNsTVRu?=
 =?utf-8?B?bWdYZ3d3N1oyWWNWV3BTOFBzbmxDN1Izc0t2ZmZCRFNjN3ZubFlUK1lpT1lX?=
 =?utf-8?B?M3MyOXVETjdWdEdGZDA0YzJPTXptWU4wZW5sN1F4RlEvdTlCRXhNRVgxSnZB?=
 =?utf-8?B?ZWM3cGFYY1Fab1FUc2tsait0aE1HQ1NDQ1VTMVBiamkyWS84M0dMV0VWeWNY?=
 =?utf-8?B?ZCtmR2x2WjNhVkVub1FMQ29lZ0ZFWHZEMm5rRExFY3E1Qld6TnJTSDFkNVFm?=
 =?utf-8?B?QmxrZytrdGhMY0ZBdGwxU0NMbjFlb21DT0FqV2tMNG5PbzhhazN5NzhiSFl5?=
 =?utf-8?B?Z0dLMlFTaDYxMXoxVC9xV1h3Ymo0ZXlsaWl2V0gxTk9aYlJkbG9qM1JsWTlO?=
 =?utf-8?B?bFR5OGFNSkFOcFYyN0pRL0tKc1FVZWNBbGN1alN5TXRPcHdPUVFWS3VvS1Jx?=
 =?utf-8?B?YmQ0ZWFmUXhwbHJVMU9QNjdRWXdRMjhGczFGaUd1MS82bEVxRkFaT3RnVU5F?=
 =?utf-8?B?TVJUemkyakh3K0JpRGZYZ01sY3JtaU4wV2hjRHRUN2VvbTR0T0JONVNaSnVv?=
 =?utf-8?B?RitXZjRsUDBUd0VUZ0FwODc1Y25TdWUzNSswWUI0aXZjaHpMM0tNTnd3WjAv?=
 =?utf-8?B?UTViVlZoVVBBVm1KU0c1d2hMdkJVaWhmOFFROGZaZHFGZGc0QkxkQ3ZCMVMr?=
 =?utf-8?B?clBManpxVjV1ZzNxd3lwelJqeUUxbWVoVVVUNkdjTk5xMUREWlZtbnZoUVFY?=
 =?utf-8?B?Rndyd0lFWFRLVHhkMnBIa2NtNjYvOUR2Q085WElGeDlkL2dFSGxXUUdUV0Q4?=
 =?utf-8?B?dzF3azdqcGxROFBZMlRDdHRmNk8xUGZKZzROQlI1Z29rcllyRzFvOU9JWmd4?=
 =?utf-8?B?TE4xSURCZkhyaTBVcUlocXlWaW8xT29CbEhOejV6VzRBd0lwSzhIT0J4eERk?=
 =?utf-8?B?YXlLYmlCdFMyR1dPbXNBdk83aXRHOXdnazlJeU1FMFhQb0VreHB1eUM4OFh3?=
 =?utf-8?B?ZkJZbll4STBEODFwSzJIRzd5QUJ4U0pGMWN5T1VBOWFsYjRmYlhTN212NEtw?=
 =?utf-8?B?VGlNU1ZKM1VEYVM5T3F0UWFscS9nRjRLQ1NkbE5aTkp3anQ5d0pmWUs0UHVl?=
 =?utf-8?B?MldDQWxZTk5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWx6Z3VlQTd0SUNqaWdNaWJvU3ozVyt3dFQ5cFNCVmNObk9DTDNJb1A1MERT?=
 =?utf-8?B?YVJ2RjBaWldqdW9yVjAybVd3RFFHcWJVcE1mVTh2a2xKWkVZMDFIU3NLTXhQ?=
 =?utf-8?B?c3hEM3FSeU1uMHE3RmlxMGlHd0s5Z0JqTStjZ0d0M2dta2RUUXVadlFBNWpt?=
 =?utf-8?B?U0N6WDhYNXM2OVF5UFpZYjlmeHcvdWV1YUFtUzQ4VXgrbzhQbGZSeWpZazcv?=
 =?utf-8?B?ek85UXFTTmo1bERSdHA1QVJDOTZrMjJlYTNkQmpoeGQ5UTJES01kL1BoNDNj?=
 =?utf-8?B?TEpBbTVMdGJlQjNKUzJYWWtFZFl3U2xjdXl3VkUwOWJFUmFpUHIrdUMyZlkr?=
 =?utf-8?B?azhaZXVZN1RTTE56ZS9HMVNXa2JQU1Vabmp2VkNCK3ZPUmVPa3o2UitrdFFN?=
 =?utf-8?B?RW9ZVkFoNGR2YVFFYmRZa2lJZ1dVR1JXU094QXNFWldKM2hSeUNqSEZGRkVj?=
 =?utf-8?B?eXhwbXRwTW9zQmxsd3lqTkVUSTFXS1VmMElYdk9qWU0vSFBFQjllY2x6eEYr?=
 =?utf-8?B?MWJ2eFRQWnNRdWhPbkhEUkNselN3K2ltdEFrQUpjbUtrRXV5c3ZYUlQ1K1BO?=
 =?utf-8?B?dUlCKzBJK1hGVFkyeEt2K29YZVIrM2x2bkJ5RTNWdlB6THYzRjAvb2djUGlE?=
 =?utf-8?B?elh6L2NObjdQUWE4TnNNV0gzZlpZTlBjT3JwekdIaW9OUjJTRkZPYm5XbXlU?=
 =?utf-8?B?d3dkNTVnQldRd21UVnppMW1rNCtPcXdoVzRTSWhhdVdrVEd2Wm13MkovNnJT?=
 =?utf-8?B?SWhqZXVFYVErZnpsR0FqeTJMazErazNvT0sva09NQzExY2luTU5zZ2JULzc0?=
 =?utf-8?B?ak5zZWFORDQ4S05lbTltbTczRHorOVBLeTA0VlNTV2FSQXREdldaMFQ1N20v?=
 =?utf-8?B?UVMzRVkreXJVR1JZWTZrd2lmeWo0VlFWUDBKNTJEMzlIeWtScWU0cktuSndN?=
 =?utf-8?B?V005WHNyeVp4Ymw2SUpqaDdjSlFlb2VNdER3dFFPcDhpTVlmR1lzck9LdGZD?=
 =?utf-8?B?K2d3Tno4emgwVTNPM2NnczRmUnRBVVpsK1lQS1JXeld1akcrK09wdlB6N2g4?=
 =?utf-8?B?K3RKR2ViK0kzQlExWkViRHlQb1Z5aFphaXZNTG51ZHJUOGlpVXRTUGhMVEkz?=
 =?utf-8?B?akY5cHRNSmNXWkhJV21iV2NzVTFhS1N6WUQ1S3pqb0pRYXRmUUdvY205MGo2?=
 =?utf-8?B?S09pMDR2K01HMVFUcTJ5R216Yk1qYkRJOFBYdjlOTTcvK25aN2hScHJId0U1?=
 =?utf-8?B?cWV3dWFkVlR0SHNLcDVDRWVFYUJpbERaZDJMS09KcDVsTGkxd25QTm41cHVF?=
 =?utf-8?B?akZvdHEyU2JBekREQU5LNTFYUEhuQXdTbzRxUWN3TUp6M0lWMmxaZ1Z0SVZy?=
 =?utf-8?B?TzVpY3A1dGJrVlVoTFdYZm05cXdWK2xQaDY3ZDZLNW9nVHp6Q1U0MDloZnlp?=
 =?utf-8?B?L3V6QlhMdmtuNTZIajhtZHVTWkpGZWkvc3RkQkRzZVE4Y3NqbDV5UUlVSmlC?=
 =?utf-8?B?dno0RmlmL0ozcVIwcEVSVUlTSDRRQkFWU1JyckE1UXpGTjZ0OU43QmR6OW1m?=
 =?utf-8?B?bmhQYVdpTSsvM1ZmdmFuNnNTZ0ZsK3pYckdLeVFqSGxCd3p5b1JHL214Szkv?=
 =?utf-8?B?WE1yTm5pVGphVzdaTzFDUlBOL0U4bGlKcWROdjZqS3drSE83RGJNMi9jZTha?=
 =?utf-8?B?ckh6MUxLdGM5bC90WktpZWh4dG9QVysyUlF2NE9iWU15Tm0zQjl4SllPa3pC?=
 =?utf-8?B?TnMxakZnSFhVN21ZNXVjdUZtQ00yaVEyZWtQUmhMWHpUelNIVndiZno1bGRZ?=
 =?utf-8?B?cWgyc3RjdnRxT0tFY1YwbTB4KzFaeUpRbkFpdjRTc3FWWXdaZUFoUXcwdmVi?=
 =?utf-8?B?bXhKV29ib2RCVnExUlFia2JWeGZ2dXRNZmJtdEtmcC9KaW5KTUJnMmsxTWtC?=
 =?utf-8?B?Sk1GNXpWSmVaWncweGpKQUs1RHYvOVg3U3dzQVNLQlkvV3ZYSlFPYlZjUkZ5?=
 =?utf-8?B?cjhPK0hvWnJRcnZxQ1FyTmdieE5Gc0N1MFU0OVNWa2g5WFlXKzQ2ZG4waHRj?=
 =?utf-8?B?TUluR2U3ZGQxYUVXRjAyWWVnS1FlOHZIZHVTcHIxOSszU2t5ZkRxRm9xbll6?=
 =?utf-8?Q?/eC9igKmUrUJ7n6wfG9gXai+g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac4fffa-61d4-4411-794a-08dd6c6838de
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:15:04.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/QfZ+//o1pDE4pc2Rp2U9VFNOykg9/F0Ir8nTNyFYq3ViWLa5znJ5SKAuh2Zjmd9bECeTGPd4/JgukvEliJiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8855

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xafffffff, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
changes from v13 to v14
- added the blank line.
- removed the lines: #address-cells = <1>; , #size-cells = <0>;
- moved the ele-reserved under the parent node "reserved-memory".
- rename the node name "ele-reserved" to general name "memory".
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 12 +++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 11 +++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 290a49bea2f7..10aaf02f8ea7 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2025 NXP
  */
 
 /dts-v1/;
@@ -37,6 +37,12 @@ linux,cma {
 			linux,cma-default;
 		};
 
+		ele_reserved: memory@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+
 		m33_reserved: noncacheable-section@a8600000 {
 			reg = <0 0xa8600000 0 0x1000000>;
 			no-map;
@@ -259,6 +265,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&hsm0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 2562a35286c2..05db47668b7e 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2025 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -154,7 +154,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -186,6 +186,13 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		hsm0: secure-enclave {
+			 compatible = "fsl,imx8ulp-se-ele-hsm";
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.43.0


