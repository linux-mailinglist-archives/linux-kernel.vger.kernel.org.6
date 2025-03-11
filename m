Return-Path: <linux-kernel+bounces-555859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77066A5BD80
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAEA47A8CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A46232368;
	Tue, 11 Mar 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FDry9rSY"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070222DFB4;
	Tue, 11 Mar 2025 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688197; cv=fail; b=I5NhKfqnoX/pxUbvTWzpQfaqjnvKKUme1hfiYS1HKbxkr3s+FHg/N5LrdOide25Ou5ZqXXdnVWUysBz++Sb0NBx/6FXxyW/Eudd1m9DkH0UTt1PAgClhhleSpElAy0MhZ9iKBgTCwrs5jI+Z8x80XPJDmnMkatm/UgfrTR9dZqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688197; c=relaxed/simple;
	bh=8QvSWd4rmn+G1ZEKi8f+TGc8yN5T+yIQA/mdWdtzwO0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=afPffed34i1cPyMpD9UD6EHzQZ8N7cvPxloJzpCL1KSvbAm9qWxVTAhE2z/CxPGDzN4/ZRGugYFpDQCfghIykeypREalHx0zI0nTh4IAxpkgivSku7nCgapZjUxaPZkFt2xNrBoWj0RE9HQQ/wcRn/Z4AIj/u0b/7LGoaCqg9mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FDry9rSY; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajpTjIuBy1BBtoldbQvd4sv02XPO96m0+8tIfMrunbywohZtHHz8+tvsYo56C3UafL7ggrsLuFegqn6WUoo7H70BG+purQaqn2HZ1foSHbTSpLQDdlyqNNFvvRqaSDLs8nSXiaVlziiRAEzXcoVs+KliN+JYeUdzRBy1wvXAJ2X2bsITLQTUTn6ukAbA3KuuyVu1Wmgc40m8DKGofD4er1UnHbOwy0FXBRTdF7yO/RKQdzYSam6HJMiNwAi8fFLKlYRj33PNVqKm8nNowTdFAh0Qd46bFV6fONdR0aKdpSybOs3Ak26dSlkNmGypVpMzWUGUYq/GBUdXYggPrztdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+o55FPMa7m6VVea9dp3slj5OALcBnoJzyUth39j3Gk=;
 b=NNWl28XPxF1tdY+btaZK6P+0KGYvCm4YXqNnFRImLy3jTZLuly/bZVvvBnzlqk+7iB//sFccGlvKEFjITJHR8WJNz00JuYrB9QZ/u8UFKLO+2fAX+Bns+HhzWpCRmKfVHo1mAKkCYsGOQ8/K/DyRHUfdJ2GMVzVVeN4KVJbCJFRWmycQeNovHDMIhmQU5/T5EIrK/GDZfFZYPOuyB2fg2xkKlzpb5ZY1B2+IE6zCWWD2FfEL9mDVvpZlIFz2xxvlmwtqtbptNwYMrmLToP49QhrWc33f8Ltpswi2FXNDuvJ+IN2mm4SMNvTrACg7Yc3iOEQ3f4uYymulYBqcT5vVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+o55FPMa7m6VVea9dp3slj5OALcBnoJzyUth39j3Gk=;
 b=FDry9rSYVUSq+lIwwUaAQbg2UkOegJw/YMFU5SYiW6mP6gicKFvpKBntb4V2lzuXiLeW90byWNNZ9CkhIPwiN5SjWKLWdZnpGm8SSYoojO0xva5yqbC+ukNql1w+QGNpP3WQjtnINeAYm/sbuM1c1sMDLf/AEl/OWRWcZPQBiJHdNzpLOg0vMPCaP1YT2dZ1eA46KqflK4CiwxVDMPECHel5QCy8CxyyTxd5AbOAqeJz5kmC5nVWxxrhmnfL+KspcHVHPDsr3yULwh02kKp/FSji6DvVYtBx4DANxw43s2USAilJtyvDXgJgMg7Kzarhm5Yp/kfDrEQRZFuEgRP62Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:16:32 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 10:16:32 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Tue, 11 Mar 2025 21:09:32 +0530
Subject: [PATCH v13 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-imx-se-if-v13-1-9cc6d8fd6d1c@nxp.com>
References: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
In-Reply-To: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741707617; l=6679;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=8QvSWd4rmn+G1ZEKi8f+TGc8yN5T+yIQA/mdWdtzwO0=;
 b=QrKxODkUusya9z2rvOnASNmwvr4BfNWPB25HUY1IJp4IAd7gjm2iOgx0IL/YfBO4pMvCa/4DP
 PeCofX0cN77BiKtfkMEwD51vx8cqcrwiLlOMpCaiaPphca3JkBMllVw
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS8PR04MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: a312d4cf-7f28-485a-47c7-08dd6085cbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkN6SUFMdW9Ua0NwbVRsU0pqYXdlbk1SdkQ5cXg1aGpkbFMzalo4UTZ2OTJH?=
 =?utf-8?B?SjZ5MlE0ZlcvRm82MVo3OE53UWxKaTdNWEN5dTRGTTU5ay9zQk1kN2YzN0sr?=
 =?utf-8?B?aGJRNnp0UHk1cFhHNVIvMDZPUG8vN3RHSytTdG5PbHczMnVsbHJpOGFyemcr?=
 =?utf-8?B?a0syWmIwcVZrNlBTZ1ZjZ0xscWpodUQ2aHVDNU41eFFtTHNmaEkrVmVYUGJY?=
 =?utf-8?B?VzZlcWFtbHNGeHpOUXJ4OEI1VzNEWUt3TFZHZmhjQ3VYOE5WTFlWMThFZXhx?=
 =?utf-8?B?TFpaM2d6MDJEcTBVZzhvbWxQek9tWmRTak50MXk3aEJhdjBOTnc2UFBlVGlB?=
 =?utf-8?B?ZmdqSkZ3OGxINzNsMXJpTXlEcDUyN24vRG45bjFxM1lFMEIxUEtmTEdKWXlK?=
 =?utf-8?B?aStkdVF6YWs1azRMM2p6OWduc28va0ZDTUovUWFkb3hWOENZcWFHWDd0RkU3?=
 =?utf-8?B?R3pycmtaUVI5dXVqNkgzdVpiWGVWT2F2Y2dXK0JkUmRLUnJmUFZnOXRndExw?=
 =?utf-8?B?R2dJRzBreWhZeWFrMUZzUjVreTBOMTlWOGpmWlNaNkxWbEdPNFZyR3dUUWFq?=
 =?utf-8?B?RjY4ckVDVm1CYmZqOUFPVE9WYUFFMUdiN2VzaVR2NXlhOFhPTm5UTTdsMHB1?=
 =?utf-8?B?TWpvZHdESCs1Z3ZvMlBwbzVKaEhmQ0lIR2xtRVh5TG1ndXovcmdzZHpBUVZx?=
 =?utf-8?B?aHNCSWFkd0xTRVVyMWpqM0dqZ3c2bzluZytGWlJGU0pIOWV3WUZMRGMra0p5?=
 =?utf-8?B?K1l1VDR2ODd5clFCM2VhRWcxMnpoTGo2TlNGbC9OcTR3TGpKS01Gc0ZiTmg0?=
 =?utf-8?B?eEhZZFdvYWtmY01oTFczL2RkYmh3Zmcxb01jMjFLcjNSR1NGWk9PQWRNeFlV?=
 =?utf-8?B?NSsxQ0RMQXdnaDVrZlRpMVYzejhOcmYrMHFwQk14RWdRSmpLTGpvbnVtZWcx?=
 =?utf-8?B?MzFkNHIwUkNmbThoSy8wYXJZOVNldHo2dzh2eGVoN041Q2N5TjlKYzBVaWpV?=
 =?utf-8?B?aEIzV29CbG9qUXRZNVdsL2p0Q3RYam5xUmREYlBWQ2FId0Fub1JDdUk2ODRW?=
 =?utf-8?B?ZFdZb2x1ZVUwUER3OXF1YnptM3hNNUU4NlZSZ2J4U1NjNGlnUEtrNG5JYUxm?=
 =?utf-8?B?UGxoNURBclUwYzhjVFhSSmZ4Y3Q0WXMrT0V0bmJuOVYraUg4eXZ3emFjcHM2?=
 =?utf-8?B?RVcyZlp2UnMrSHR5R1gxczlWbmdybEYvQjNNdnlkc0doOW5aZ2R0dDJQMDFu?=
 =?utf-8?B?TG5BaUtPNmdyVG1vdHNVUk4wSE9IK2xPeGhWYWt1VW5leUdtRkZTbVI0NzIx?=
 =?utf-8?B?bTNabDlhWHNtV05sUFcrTUhtdlp2Lyt1UWlUemNkcG9QYURZWXVXMnZmZGVp?=
 =?utf-8?B?ejh2LzUrZVZycUdOcGFVb2ZLekI2d2dDN0d1ODNTZHkvd3JJVXQzeEw0djdE?=
 =?utf-8?B?UWVFMkJRU2VORlBDUHZsVnd4aVVyYXlvZG1Ddy93OHpiWmRZOU9ZdkRXRndF?=
 =?utf-8?B?eFNEV2hzTklINUJ1SFNnRmhWcTZyTC95TkR3WjV2cURicHpDclBwa1QrZzdE?=
 =?utf-8?B?ZkF4R0g0dG1nKzByWWtJME1BMkR0QXNCRHhIT2E2UFh6Z2tBMFlPRzhscERJ?=
 =?utf-8?B?YzVoV2NrZkZuSHdIUWJCUUJqSHYxZ2paRUJyaVdlL3RIYzY4cTBYU0FJdDZW?=
 =?utf-8?B?VlZ6WDIzMlgzMzNEM0U2amIzRFcxY0s4SDJZYUNyNWd6K0toSUZVenpiU1Nz?=
 =?utf-8?B?cUZtS1o2aWNtQklnMU1ublg2RGpFaU5tYzByNitYWnd1YndYcDBOdkVNelM0?=
 =?utf-8?B?RXU1bEdpMm8yQ0tEOFRvR21sUGkvN0RzR0hUTjFFMEluVG92T3hOc1E3dVps?=
 =?utf-8?B?djhRVEljY2tGQXE4TmlQSkdKN1FDVHdhVFYrbG9SYTdHL0haWTlPS1JnUFRN?=
 =?utf-8?Q?s70I4wMJ0+g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjRYR3QrOWVZY3pCWXlwNXJrNUV3VEtXaFR5ekU0c1pvQmpPVm5yLzFLenNU?=
 =?utf-8?B?Y2NMazNEU0Rya0lkRUdzelFDOUlQWWlraGhTNWUxZEQwNFBxa09CeGhZcllo?=
 =?utf-8?B?NWE4SXBJRWZnZWp4WUhxT21TcVFpVzRHSlNvWGpKaGVwNDB1SFlpMFZWT0dV?=
 =?utf-8?B?N0NWVmZYTXVwR1pvQVk3NmMyZXpOVUdLczRBZzk2UFl3TG52eFVNaGNpcDhm?=
 =?utf-8?B?YjJqa3dEZXZaV05hWitNMUF1cjFDRE1yMEJtUmRWcVY4MGk5d1JpK3R3YVFB?=
 =?utf-8?B?NWo3dXpKSzR0ams4TklZbW0ycjhnM3pJTDAyS3FYQjV0bVJKSDN5YXJ5T0hs?=
 =?utf-8?B?djRqZDA1SzdWOVFOaUh5dmE1SVhjYjZ0V3Y0Z1lLZlUzWWZHS2FDMklCTkhY?=
 =?utf-8?B?SzRUd0VrYTBJTklSZUtrYW5ib3ZodDZQWWFVRXl2VFg1c3Y2N25wcXRpd2tH?=
 =?utf-8?B?R0ZmN2sxYUhZWGVScXM4NnlibXV3OGc0aWRpaS9SdkxGMklQdG43VjRHUGNs?=
 =?utf-8?B?RjlvazBmZW92ZHV3RS8wUXI4dWJIWnlDeEJpWGdTL3poelJSSFJFQVprMGJv?=
 =?utf-8?B?bGUyWmtTckhpSlJXdDc1V3dzVDVaVitaRHYrOStiMVdTTVA5RkxGRW1vWnhn?=
 =?utf-8?B?cVVTNjN3V3FsYzZ2dG41Y3lCcjJDREVrNVEwWXlscENQc1h6bDBxWjBLSHFT?=
 =?utf-8?B?L05kZStzZVFiM3dmeVRQQVFGWVlUajg1TFNBZWZRbmNxanBPVzhtMXRzVnZD?=
 =?utf-8?B?VkFTMmg5bE5SOGNVb0hMb0xoMFB0NG9hU1pGYlJ1c2trdzhaa2R0dDU0eXMy?=
 =?utf-8?B?OTliWG1OMlQwMEFYaWVzMWE4by8rcHhhbjJsc1pRcWt2QWhjYkl0Q0pTUUVj?=
 =?utf-8?B?U2EvRmEyS1J5Znh1Q3lUbkVneG1xTnd1b1BSU0hibmdnK0kzTjlyWjRNYWYv?=
 =?utf-8?B?RlBsbTNqSEt3STRQd1pCUEZtT1AwQk9QNy9BRGVoaE9rNWo3N1JMZGFIcEg4?=
 =?utf-8?B?c2EyaWpSa0w0L1pULzB4WmZIR05mdXZRWDdRVUgyT2FyMnQrSlgxTHlhSGx5?=
 =?utf-8?B?c1BFdVJGUXZBY2RvWEtvczR0OW9jamhWUkRjUmtBeFhwZk9DaC9EbGhhNW1n?=
 =?utf-8?B?SS9NTWdzY21JSkJreHBoczh5aGpoTkt4SWZvdGhZNVpZUVRWZS9YY3ZRbmMx?=
 =?utf-8?B?TE9uR2FGMGhRRUw4TW9wRjJUeE04ZHNxWXZLL1dJVzEzS1RjOW1XNEY2ajZI?=
 =?utf-8?B?SG96dVRIMUphdjM0dEN2S2dvYzQyVUJyeThrWVJDUFZkWW9GWkhKTVQ1MHF2?=
 =?utf-8?B?Uk9USFIvcjhwUVovRHNnenBBSTVxSWxkWXk0TUMvYU5laHZ1RytrM3prZUJQ?=
 =?utf-8?B?K3o5ZC8yOXpzVFZqT2FSSlo3QUR2VTNnK0NVNVlnWTIxWExBb0JZejY4NUxI?=
 =?utf-8?B?NTVkVDJKNk96VEVWYmhIZlQ4UmJhS0N3VGM0bHVXcXVLeWVNNWNSbDJicXV1?=
 =?utf-8?B?ZGtyRlFSUkxIbmNSQnN4VXRDSGVWbGRuMzk4azE3Qm41a0NFSEVOd1VCdUtj?=
 =?utf-8?B?T2dnSXFNQlphUnBPc1JMRWFhd1N4amtBbzF1L1hNU0FVK1I0dzdYajZyWjd1?=
 =?utf-8?B?c3lkbGNtMmRCN0J4cTVRYnlBaXB5Tk5hN0dEZm1qNXY4YVFlc0xjc25TRW9q?=
 =?utf-8?B?dnFDb3ozcktoY21NL2xRSFptdm8xODAyRXk1K2piRWJveHRZWXh6czF6dUU5?=
 =?utf-8?B?cGVPQ0xCZXV4dmZnQVRUNGJiTi81WUtMQnlXNGJjTVF0dkt5RmpWc3NpeElS?=
 =?utf-8?B?Zk40cUFHRHNEbWtkRzVVU0lveWZ0dmlqcjlYd2lGeis3KysvV2VpYXdCYk0r?=
 =?utf-8?B?VGhna1NPYzBxV1lyKzZwOHo1ZXI5RWxJUjYyWThiQ21BSERsdEhUTGNJZGpa?=
 =?utf-8?B?clcvOVVwN3VOVDdCVEppc2E2TEJ4cWpXYkxRcFZWcFZlV2trVm95OGFBcXpU?=
 =?utf-8?B?d1dpUHNjYW41SFNHeDlQZ3BpcUtRdzVVc1BNc0w4M2pNTjllWFRNeTYycG9O?=
 =?utf-8?B?OVVZb1RZMXM3TjYzMitkdFlBVktpNHZvRW9HOFVTQ1lzeDI1UTBXWVdKeU9o?=
 =?utf-8?Q?aWI3gi7JVt8d93Cq+hTD/YUYw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a312d4cf-7f28-485a-47c7-08dd6085cbbc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 10:16:32.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4px//th9KvHIfwdK67wF/ABN8170GzMHMtCIr9gVCukpf9wGkDs0kncFzLuKsz4rgWmTf52jTt3ljWEt8/GNqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for Secure Enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..a3a95b54a174 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,124 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exist.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
+
+Each 'se-if' comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over Linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.43.0


