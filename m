Return-Path: <linux-kernel+bounces-307700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E628A96519F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA4B1C2083A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1F1BBBF3;
	Thu, 29 Aug 2024 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fj34TkAu"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6681BBBD5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966117; cv=fail; b=CLyD5B/pnWntoTKiX9KzyZqyqbNUAeHzLMrTJPKRcBhn2s/qISKINDv3znT+HpCHnDjy/jMWLCgQ8pxZ9f3viNQ5RgUcsmqehaoSzLeKyfyhh3Iq4V0USDpER1AlKwD+SRJUUaao1VEEVPdnDgZH78asV3bAT8chj/2KVDUPa2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966117; c=relaxed/simple;
	bh=/DYmw0y95BWfjnH0G+TXGaKcqfu2vSxvTBSnYz26UNQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y5nKcsxtVZQN7jfiv/JjSQgmuCx6sSK6yL8tTB1kG9RIMukSubKAGBmhlw40qRdvdZyYPgG9eY0z+mH2uDACD4AjO1IWqB0SQGvA2s1YsQuVTqflDnURMhzDiDFX+YF+L9Jbbw7MXVSAxqtpYFHExFk+YTkmDYrwdDEzSHDC6LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fj34TkAu; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsX2kW48RS5AAJY71YG94c/dcZIHX/GM4kUys+iSE3tmXiHrVeV7TgNql0eSVVUziRAB/Zcf+B6nWWUnTwH4oGNISMVlJXacLlymDXWLTDuRzj4MNLbkB8vVjsK/sQxrAZSBCGM5WQoP3nfev8HjunuCg0yVwIpeHLnp2RinCgN209+kbQNgx49xZ8xpSOm1LfC+e/3YCmNdvjxa+U8/VNKNgOuFrvvFCDqhfJDK9SDMxKk4cBLpN95NibBgIm5ZPsa8H0rB9AXU2fe1iYtNpMaRRR1xd0/W6SqBDSjxn2cnd5r7zNLOLr4oNin2l+1nY+8RRrGGGL9Fo1AT0Js22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtHOgUkiY+OlaDnc5CH8FSP37gdSlVXFHj8VUptrrcA=;
 b=KaRByRs+lwaCQsVAm5QGw92/PfZr9dxZp16iEfzF+9BRwP9oXMRUGDWhESSaFo/P8lO5C5C4yYFxZWoQPmYniowYDXmoYesSgVTydi0bv7l8qmGksEIihjSUFdZISwP4SKwrsx2877JZtGxQ1TZ9hP8AKd365Bccx/I/UgB3uRxCBw1cFbD6Tx/tPw8FLVFYhn2nNuOJiXsWDCzWLtLqbVy/9fBMU70LxdxbGqhGGWtu0GkyIm+J9B/dUoavknZqYsThg/7meIpvgvKtfDzESd/8+tdGmbKPpGlrBNq6saZLO7K8YM8cfWDurWKsfnJQzdAQiy7Z1VrlbE+pOkbcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtHOgUkiY+OlaDnc5CH8FSP37gdSlVXFHj8VUptrrcA=;
 b=Fj34TkAuMiEy+/1H9E/3wjvGcTx+YaOm2TTqzx0bzoPLlWrZB4emM47NQ90LkZASua001Dt7DVcg7J5nftOalCxoEMtSE7yTTYlhKiWDCuXPkXCQ7Two40JiLH1zUpTY8ajmdOe5Z5vGB2BxBqci2BIRFQxIeIH8+L7XJ+jfs6poIg2yZbdguBAWiPeEC4aOKUgpnuQoP2SMKiNsFcELhuJvoVvL6lubn5QW4ISmex2LQD45gHeGLHKokqv/fBxQYFCtNhy+3GdXyjfTyXni/4yluwaPYVfd+wrRBP7nhJr3E6ZZtMbqQdcFvZqQHLqwhoKEXC7dPsGKbxbwvxnpZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8971.eurprd04.prod.outlook.com (2603:10a6:20b:40a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 21:15:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:15:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:14:05 -0400
Subject: [PATCH v4 08/11] i3c: master: svc: need check IBIWON for dynamtica
 address assign
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-8-ebcbd5efceba@nxp.com>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966083; l=1475;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/DYmw0y95BWfjnH0G+TXGaKcqfu2vSxvTBSnYz26UNQ=;
 b=5Vj82rVaWs+0HccR5NC8hXRF9i00KOg3u/zGyBPBYlnxkU8IRVYGeT9bO3Hio0KImW7VoY9Hc
 rWE7ZOzWSnBB+M2njS4l7EHbfy2C7dSeRzFfb34Lfk3f+oVDwlDdJWm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: a5af9033-94a6-4a7e-7ca7-08dcc86fab38
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K0t5K3NvcmczczlycytaQmNWQjJDTktuYnFuMWNMOUR0Nkc2RFp6VUU5Yjh5?=
 =?utf-8?B?UjZtZVkwaXFKNWNLNk9uNjNWbEh0ZjVZSWJEQ0xmR1hlenRnclJ4RU45OHJU?=
 =?utf-8?B?eU9ienRLRnowTDFIY1oyVXFoZFhvWkFKYmVMSDFzOGV1cm5jQ09KZHB4SGZk?=
 =?utf-8?B?Zlh0OEg3d3BNY0dyN2dqK212Y09zLyt3U0s1Vkt1a2FsaEwyQ0s5NFh4Q1k3?=
 =?utf-8?B?MmMvQUU4Ni8rcnhuQi83SmU5a2xrTWNYS0hPVmpIOWZWekxOb1VSMy9XSWpw?=
 =?utf-8?B?eWhxMDNrNlRFMWt2QyttZXcwblRQc3V6T1IxNTdHd1RFQ2k2dytZSTNDNDFW?=
 =?utf-8?B?aUVTTEJNaWVWMnBSaGlPLytnU1p2eVpGOHlnNGhmOHFoeW93MDBkdGJlcnJC?=
 =?utf-8?B?MVVCOVFDU21iZ0ozQlJBcGUxM0hVQVFOS0dXRkxxbDBET1pOMDRkYWZNa1Zo?=
 =?utf-8?B?TkRJb3p2UFNhQ2ZSMHBIUlJ5bVFHYmlmcy9qTkkvTlIrT1lWRGc4WWsxNTFK?=
 =?utf-8?B?ZHVpNjhZTk5idlRtVHMvY0RoQ2p2RmsxcTlObTd2d2hmanNlNmVZWVVrcExG?=
 =?utf-8?B?d09oWlBZb2hFUXFER2JmSEk5aDErQURMeDQrS2JNeHFZN1EranVhVllEbVFa?=
 =?utf-8?B?bm9OYmtRTEJQQksxV1lZRW5BYjliQnlWTFpjdVFTd3BpQ3ZFM1pnMzhNR1pl?=
 =?utf-8?B?S3JOMC9lWFZLRW1BbVpRbG5aNEYxVCtTbkdJWGZzUUFjazJwL2lkeGhaK2Jl?=
 =?utf-8?B?c1B2cDlBNDZXdGhVNkxkODVOK21yUzBtOGI4YlJRWGJPL1IrSW02ZEUwRU81?=
 =?utf-8?B?UzZxZEh5endQOElUOW9DRFZoY1MraXV2bSszZndBNXYwUS91YXZ4dlh1d3I2?=
 =?utf-8?B?SDhPZ0NhUVZWYVZsUE1uZ0EwRmd6RFMvSEZFUXpqZnd0ZEZOc2ZDNEVmM0hy?=
 =?utf-8?B?dGhpdGJ2bWR4RTJnZ2s5RHZWWUFsbnhqZ211UHN2TzkvbDhPckI0T0JsWk10?=
 =?utf-8?B?U2VaYXJPcFhSLzF3Y2J2aWJlWGxjUm9hS081UkxOczNndnd3T3lVeU1laXRQ?=
 =?utf-8?B?czF3WmhmenkzaDloUjhHd2JBelE1OUZ5SW1OT294QU1DM1pHZTdKZHdvcE1w?=
 =?utf-8?B?NnpuOE5jb0NuREplK2c5dXNzaExwaEhwd2pIcmlnczdLdEp2MGJ5eEw1ZnVi?=
 =?utf-8?B?R3hsWFZTb1loSjhybkhEN1hrNVdGVzcvZGVPdVlGbWlDTTZCTWFoNGJ6R2lp?=
 =?utf-8?B?MUxraCtFdTM4QXNVWS9vbThKYmpnKzM4UExiMWNiNGt0aWR1WkQ5bFJNWUVR?=
 =?utf-8?B?N1NtSWFnL1kxSlMveE56cys5VkwwbWdVbGNzYUdxWjEwQWF1YU1LVTFLa2kr?=
 =?utf-8?B?NkRHaEMzVHVkRUpGRTRoOFl0R0laRmUzeVFRNHJKSXhPZTV4NGJaeE4zMXRT?=
 =?utf-8?B?RGp4Ti9mK1VrTTJLbHlkWER2NmI1cEwrYXBINEFlYXFvS0c1UXJoeFFuU0h0?=
 =?utf-8?B?YU5ZRkRQWmVZZ2ZUbjJrakNvVXRXYUwrZnoxTEhlK3RYRDdIU1ZVbWpidkcy?=
 =?utf-8?B?R1N5OHk5RWJDYjdTYUx4MUZFUGhsRC9lQVVaUmNzL1kzeXhZSmpBWmk2TVA2?=
 =?utf-8?B?bHVEa1E3TEttcXJ2NzNSZ3JhV3FaY1FGZzdCRGk5RWNUTkFrU2lBRHpxbHMv?=
 =?utf-8?B?eW1FeHBMMk5XMWVCWTk3YXVSWmZ1MG9kQm1rUXdubjNrY2dOL1orNHJWNE9Y?=
 =?utf-8?B?eE5lemx3eVRLM3dPS0p5dlpSblpDbkl0djlCS3FiM0ZFL3Y4d2lGb25YbHdx?=
 =?utf-8?B?aTVVTDQ2VURlVythUitZazVhWk51UUx3ZXh3OGExZDlEK1dacGY3cHo4OVJZ?=
 =?utf-8?B?NVhtMHk4VFAzWXdVZE1iSVdPWFNqc1NhUFZUYVhWYWVUT3c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QlZ4eFIyQ0kyS0kwTTNKM2IzbktIZTJWenBTdm1ld1dYcTltMGd2a2lZOWxj?=
 =?utf-8?B?S3I3a3BBdTh0MzgvMFMwWkpjdWxrbzdoL2NEWEU3VWRiTHdzc1NIVEh4bjNM?=
 =?utf-8?B?N1hucmJPaFg1TnNvYVBjYzZlY2dHUmF3RFlldUhDYUFRMmhJREhaL3NBbjR0?=
 =?utf-8?B?SU16eG55TXJHWHJ0VEVmZnNVMWJQc2p2Y0xIRDBYMWhkM2tpeGhDVjY1K1hC?=
 =?utf-8?B?QWVWUWtBN0FDZ2YxQVRnZy9NM3NJNkE0c3N3ZFY4TTFEMlNpM1R5Z1lWSFJ1?=
 =?utf-8?B?d2t4V25mSGZZUzhnS1dQSk5Rb05nWW43dlpzeGdkQVA3VUN3Z0piL2tORVF3?=
 =?utf-8?B?cHVJcFlEZWxrcTFsdWUyYU13UjY0d20rcUg4TzhCd3NWZTVGM2p2cVFGbndH?=
 =?utf-8?B?MlNWWEFTbEtYTm1lam9ESGRHVFBhY1M2U1k5c0t2cGNRbnNhUDdwSUU2Zkpi?=
 =?utf-8?B?dklnT2xDS3U0a0U2RHB0aDZOaFNhR1pQS0xMd0NkdFl3SWtxM0FIanZVamhp?=
 =?utf-8?B?bW93cEg5WkFFYmFyNm5qVThHTWFYcEVaUGdYTGtPeWZweVhGQktZMmtzYnZl?=
 =?utf-8?B?QnpzRHgzTi9qMUJPbDV0SkdUcjJJVmJxK1hRK0VYY2h5OGNjTS9vVzlUV0oz?=
 =?utf-8?B?TXcxRFBqeHZqcWdUaU9MOTg0UlVkODVqa3lLRDZTbDhiNTBCeitSQzcwd0RU?=
 =?utf-8?B?WkJ6TEtvNk9STXBXQUZacTBxMjJJNlJIemF6RzF5U3FLSHBwN3V4MFp1dDNF?=
 =?utf-8?B?dUxLK0d2SWs0STBoZHljME5NVFRPWGV5QjRCRVRxOGpGYkR3YTZjS1hEckpX?=
 =?utf-8?B?RUJVd0hCa1lPS29XSUp1bThuWk5zWmJGRzJZZzQ4VXlQM3RqUHRpdCswOTVy?=
 =?utf-8?B?dG5BamlTSGZhYUREQ2VSa2pTekpTd3ZGTzhaSXNCeFAzbTd6bWk0Zk0rTFlo?=
 =?utf-8?B?U3BESzZ0cm1uaUF4aTUwVEhNcGpjZUY5WEFydkdIaDJ4WVg2TStudGY2MEZm?=
 =?utf-8?B?YlpPd3ZpNWxDLzBzSVhoQlExWTBBL0ZtMWtkc3IzdWxwempEUkcwSkVMRHJh?=
 =?utf-8?B?aU5nbkFzM0lGZ21tWGRWR1JTYnlJOTAveS9tMElKZE41L3VuVTlPeElSVGpN?=
 =?utf-8?B?VW80OEZoU00yREo0K0Zxb3owQ1NpWjMwWSt0c1NjcXA3Y2FFWHhHb1JvaDV1?=
 =?utf-8?B?VG5BVWZOOHBsZWNZcVN1Wld1NXNES2cvd2pEK3VzSStYeGJBK2hnb2N1ejNC?=
 =?utf-8?B?dDdtYzAvRFYxNlJxNFU3eDdRSHMvUENmQStrTnp4K2hrdloyZ2ZZeVFHVTRF?=
 =?utf-8?B?dFNOYklLS1ZSTHFUWFk4M3IwMDljS3luWlE3ZGxaWWJLYTJpQlp5ditSRW9y?=
 =?utf-8?B?Mlh5TkxrOWs5VGR5WVBMVDJPK0J1UVlQc1NRTkpUSlBGWTJFRnE1N1VTSjJF?=
 =?utf-8?B?TGZiRUhnZjFkTEJGVjIzYzZ1YVQyc1ZEMGhzN1BLdlZTOENWeGFnaldHeUJS?=
 =?utf-8?B?d1FpZ3FMcXpSMVBmSGdlcFF0RzNuUThBSXJhNmUzZG9CNW1tWm0zMXJ0UU1H?=
 =?utf-8?B?T3pDMlRrL0t6a2NsbWdxV0h6QjZGRy8vK2R5bE1HNGV0VjJ1TWg4TldlQ0hB?=
 =?utf-8?B?OFd5UnZ1MEhJT0hEejF4cVhZTnpaRHpneTNQUDBoWER1TldtVlpEUVBubCtx?=
 =?utf-8?B?NHppbXNGU24zSjVpNHVUL2E4SmNXYS9OZm84OVloRUw3Y2FiY2hmWmNTWjli?=
 =?utf-8?B?Wk5aZ3o4NmtNcW1lOWxmK05sUjc5VzNrYXRBa2V6Tk5JclFxZnpzb2J0ODdz?=
 =?utf-8?B?cDhUbVdSSStKNXp5ZnVKMW8rengzbU83emU5cnRCRkJqdFkwT05ObHpTMTN6?=
 =?utf-8?B?MGlrZTIzbWUxcDhvczRPdzVwOFBOS3dUYkJ3Rm1aem5pOUZLNWVFa003MERr?=
 =?utf-8?B?TzBSRnVsUkp6REFobi9WZGlMTm5WcEhBQ3U2MTRLd3NrdFU0UnZOUjliSWhl?=
 =?utf-8?B?NktvK0w0ek9nSzF6ekFjOGYvNlg5WnJ5L3BpVk5naWt0My9DK016c3JNTDMz?=
 =?utf-8?B?RUk5blFscy9PSEFGRUlKREt2K2Z1M2w3ZVBIZkE3NTRnWk00eWxzcEtYL1Ra?=
 =?utf-8?Q?m3VXYYcB2SveIrbjIxdMKfkXE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5af9033-94a6-4a7e-7ca7-08dcc86fab38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:15:12.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaNbW2YBOo3bWdwZKQF59/4BtGMaFHbox81GAr/2TGZ5buDaBV8pKeN45KNshDDkPMNQlKH8PibRskVAsBNIlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8971

When sending REQUEST_PROC_DAA, emit START and address 7E. Address
arbitration may occur at this time if other devices trigger HJ, IBI, or
CR events.

When IBIWON happen during a REQUEST_PROC_DAA, NACK the IBI request then
send a repeated start to continue current dynamtica address assign.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- rework commit message
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 122778b51c720..9f456639d1aad 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -808,6 +808,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	int ret, i;
 
 	while (true) {
+		/* clean SVC_I3C_MINT_IBIWON w1c bits */
+		writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 		/* SVC_I3C_MCTRL_REQUEST_PROC_DAA have two mode, ENTER DAA or PROCESS DAA.
 		 *
 		 * ENTER DAA:
@@ -859,6 +862,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			ret = svc_i3c_master_readb(master, data, 2);
 			if (ret)
 				break;
+		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+			svc_i3c_master_handle_ibi_won(master, reg);
+			continue;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
 			    SVC_I3C_MSTATUS_COMPLETE(reg)) {

-- 
2.34.1


