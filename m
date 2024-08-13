Return-Path: <linux-kernel+bounces-285050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972C19508B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA2284AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178501A0723;
	Tue, 13 Aug 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iWprLadK"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D6B1A0704
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562133; cv=fail; b=MyZIgH4kYqupqyTge4gKHwsIM/yEGuiph4wCoD5ULXKfncI5nixyajC0G9E1LvAUra5f+HLEorQfjpj9QAxAN9707tH3/iMNCOVxaZ8cGsDORXnPCEbr3T6RAUYxsytOypUL1uyVbxDUWpaQ8QnLrOC0MqK+jAhTYcr+iOTpC6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562133; c=relaxed/simple;
	bh=/8gjfrLEbeqdvh2UWIsUOXSQLlEPInExNiw2wP5o2A0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=I4qF64p25QWY9mFU/9PBmKdZqeUmc2O2xSVdRRboV4eqS70FVNodtT9xXPnRbLBAdQ726pzqWfXUvIbMUFd5dHTRfI8RrkjN/YNYDkOrnvfz+TcC3rwTYue+QFZd68MiAkNjaqb544ZGfa9RqFgLZ843vNJuiViP62O5Yl34okw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iWprLadK; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS1jTjR6UlTF2GBx/6XDFvWUuDVIZmcDG9/V9ZZM7danR+hULrivJ5iWr19DlUnupZvJY2AqAXAxcPfqKzIkQJzb4kOHVlWF7SN9dkLfj8si1FxSXpAs37xgi0+0hT6kf2iXW4QJoUPFuSGdvrmdjgdPb5E8Dp+B1cazPJtXAOoEA0617/EiuSmNz5fKZgiImdMUEiBY00VCP6wWK/Eu8jcCwMrjAcQd6wjlZzViwcroaj4tN6jCVv4S2tH5QTb7Pudj5zJIFS0tdAyL+VDrjCb6yuCmdjzCjbVUXwp5q2cUuGutqf+Jg24Wn546TD/IEnxY7gPMQEjfDv2XFmHOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H5YFp3nwDhvmKVPeBWxGQWI1IbbbTbtrRrxup0oAxQ=;
 b=w15lF//nMWZoaV/9/vEfzJmsKXsSAgv6Y87JOhFLC2Wyg58axFwnvWq7PoPWSXnDvdQYAvRQL7fpLLjG4ya09X2Gj7Do33Emqf3NiqBZAPuTKCC7RWK1JDvu6aq6GNiOBIVEmkOdlU6o1yLv/m5jFybNR5dKunbSumi5d828ddZQpML5M74+8B3BU2ZM8NkPorYQkA1fhysq9UUezGMAZZO6CNh5gsb0dXrrm3ejGIneNZG5cwPvIOhoHzhgsyGE34XxjHLrs45dT4P/w58RyVadFbETC+yAN4NTvPeqkflhlpholLj9CkStWjujcONHpJeKiKizYomWfVUzAOc04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H5YFp3nwDhvmKVPeBWxGQWI1IbbbTbtrRrxup0oAxQ=;
 b=iWprLadKXRs6i29YiCF4/JRDxul5jUi7LSSlcX6NQnbObgk2+eTGWxOJGnzYD31p93QDhuMIW2pD80XnY9a0FgcK76A3H7HqxwnuCqQMKkdaVSjFB8gOP+KsrZE4kbUj7Yy73IrPIPi5f/OsviuVLQojHCdOGZPCkizipDTRxIbQWInB7r3jzmGodxlLQg13VLrLPGVL3aHCZsUUD++BRmJtUgXOTYtOgJfL9FL46XNFexmWfE6KMyku22HgosHDiawopBtmyery3ppy9Sa3dAFB1fiXeTDT9mdTmzq8Rd6kFHoF60hrYeXPcfN4WD72iOW39Z9wTveQBNHRy5tNMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:15:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:15:00 -0400
Subject: [PATCH v2 02/11] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_BITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-2-68fe4a050188@nxp.com>
References: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
In-Reply-To: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=1901;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/8gjfrLEbeqdvh2UWIsUOXSQLlEPInExNiw2wP5o2A0=;
 b=aAI64uSk6gehOExiLMjcxc+d4R6RvosZUcMgzFIqERXuQK4d7uTDbYP+5jo+gh5C8vj9v1Rr8
 7sRCuTPYDXdCyE6jvkHohlLWDLjYiZtkSVYOZcfsA4WjeNQZBxy+nie
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: c8589006-8752-4995-0a0e-08dcbbaac267
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VXV1L2RGOS9rbU1kS0s2VFpTWndSOTdDV3h5WVVJTkxPOVlnbWkzSUZlL25a?=
 =?utf-8?B?d1FOTCttKzhrTk5USHhjMW84ajJ3bUtoa3BKcTFGZDRJd1ZDc08rbjNDVUZD?=
 =?utf-8?B?WHNBZUM4K1JsdFlQSlp5Uk5GWUY2blNUTXBRMUkvY2FGeVZxVlluSklrWmIv?=
 =?utf-8?B?VTd6dWY0NHZhdVJsNkt3cStBblJpOHEvQjhuWS8rNGVzaXBSQXp5by9ONU00?=
 =?utf-8?B?KzQ2cEVDaVZ1QTNTaE1jZWxad1VJcG5lYzNEL1VZS3NWTk9LOFlnQ01UdzV1?=
 =?utf-8?B?SThrbXdnNFA3SE1KaWNTR3lIWGs3bEFLaE41bi84V0dtd2lXelVkMEtrK1pV?=
 =?utf-8?B?YVQ3Y1R6eTAySk9KNlFPYkkvU3d4TkFUelVOTTJZWjhVbW1XU1o1MGNKYThK?=
 =?utf-8?B?RldjdG1MNjg5SURSdForVTU1REthbDd5VkZmcUhhMXJ1Qkc0STFGS1hJUGlV?=
 =?utf-8?B?L1ExR2FKc3prUlE4K0wxRnNRejlmRFJlYTB6STBRdUZKa2JQQk5uUEdSamVY?=
 =?utf-8?B?WWJYS2lVN3BKMVRCaEVwUERnUjMxVGFnNEprMTVCN3pjWSttSmxnUVptVk5o?=
 =?utf-8?B?eWphdWFZRkFNY2V1YnlhMDFNTzlIMjV4cTIyVDNWZVZTUGMyaVJ3TFdDVzJJ?=
 =?utf-8?B?TkRHY2hCVTJMb1FXVmFBenR5Z0pUOUZ6UWVWcVlod2U4a294bHVEempRL3pN?=
 =?utf-8?B?TVoySW80Zml1SFp3SG1ObE4zQkZHNmhocExlY2tEWHF5T1lNOSsrWVdLZzlF?=
 =?utf-8?B?RjhCbzR4WWZ5VjF4aGIvVFJ1UUpJS0U3OWhveWFyMW5sQmlBUis2YjFVaHkw?=
 =?utf-8?B?VzIrWVdmUC9maFZiNWdCRWVjUm0wc0dOVjdDV3hTMHNnK2Nsb2dYQW5HdXRY?=
 =?utf-8?B?dVVmUC80dEF2Q1FvU1VaOVFCVTl3N296UDRLc0cyWFZ5TFlHZmdCVk1nQ0Z1?=
 =?utf-8?B?bkoxZEJ2NDQxb2FTc1pOc2ZaOGVqc1F0NmtaK1I4T2F3U3FxRFl1VG16M3BR?=
 =?utf-8?B?NTZxaXJqQ0xkdzhCMmRWVHdXTWhiczlXbkM1a1l0bFJGdnhHM09EL2ljQlFO?=
 =?utf-8?B?aFhFT0prZDhxVlF5dmVkSjdsSzZjSG1zSmtvS1NjYUp0TSt6WmplMUdOck82?=
 =?utf-8?B?WXNXcVNheUZOUGZtcEhxMEVZMnhzbUlGbEdvNUVadkxVSFE0MnhtTk52WkFq?=
 =?utf-8?B?UzhZN25LUUg2ODE1L1pvTzFIckZ3NTlVVURvbTRxZjA0elgwcUgrbVFXZzlo?=
 =?utf-8?B?R21wZCs3SVV1WStPcHdCVGpiaGJvc0hiNlBwOU8xTVNSKzFNQVFvSzAwY0Vt?=
 =?utf-8?B?RlVlOENiZzJPYXovU0p3NHEwT0t3NGNtVU55Tyt4VDN6eVdrUmtLVFJzeTFX?=
 =?utf-8?B?cU5mK09oalZTL094ZUNHbi9Pa2VzK3dsL3dnM3M2SkhTRGVBRm5QclAzZWlu?=
 =?utf-8?B?aS8xM2d4QjFibGF1QmdCcXFxU3BUSWMzaHRFMHNubXBqWlMwbGsxbDR5K1ZX?=
 =?utf-8?B?dGhKaCtVaDBENGZnN29sVWYzYVhCU0UzSFk4cWZlUlhmdE5nbno3Vk1vYmdK?=
 =?utf-8?B?enNkOEtpcjE1RGROTCtKUUNIVUtJbUxvaWZaaDlnMHA0bnZaZjB0bmZxNXlC?=
 =?utf-8?B?SGpYTlV0Mzd6YmF6MHMrMGIraU1obG1COGVYWGx0UFlJbjE2MFpadUpsQ3pO?=
 =?utf-8?B?V2FLQStvQVBhS2ZTd0M1YkJOZUZZWFlXZ3JsWmFXNUFFTDZhajVQOUpmOE1t?=
 =?utf-8?B?ZWV3TCtBa080ekIvbTJ0WW9DczdQTnJFWWE3ZW9JRlE1N0ZWaVlXS0MzZjdJ?=
 =?utf-8?B?eThQUklWZDlCYkNWemF1VFEydE1neVk1a0Zxb1J1ZWNRSEtPQXF4OGptdFhn?=
 =?utf-8?B?L3grN3VyMUhWcWJPQU4yVFNuZFoyeTdNZjRmSk5TZ3U1K2c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K1IzVFZ3UWVyNldVR05uSUtBZzloSmpmT3NhS005SzFYNGFLWndaNG4wb1J5?=
 =?utf-8?B?ckV5YVdNK0kwa1lKNFYxZG9pTjZCb2didXRHSUlnWjR1Mmxsejgzc2RoQVZU?=
 =?utf-8?B?TnF4RE9HQS9BSWhuVnY4RWs2bW5NUnpOREUrRExhUDJpWU9EWVJkckhVTDlX?=
 =?utf-8?B?eXlOTWxoRVlNTEx0WDlGZk1hcTJZdkVhcGNUQld5T09BVUxCemgrLytPTCto?=
 =?utf-8?B?cFpITU15V0grQkR6QnBDVEl3cW0xR2pDQUNxVU5relVKdHg3S29lUzF6bjVh?=
 =?utf-8?B?K1JQUWJVNkRKMjc4NGdlME1JQzRRc0pnRUwrd2c5cGEyV3NydjJTYXBTRkxw?=
 =?utf-8?B?SjVJaGdHUmNIc2ZRc0lPa0lvMXRpc3FaRVIvV3kxV3NLK2huRWo1L3JHbHdt?=
 =?utf-8?B?NHI4aCt2NHBNVmlYYmQ0MHBZcFhjMGRocDBReFRDeWk2QngrTjA3d0ZENnVE?=
 =?utf-8?B?TlY4aWV2Z01PUGM4WlQ0N0NCTDJzRDM3YzBRUDlhclFCZkZUamRReEV1T21B?=
 =?utf-8?B?dDhVVGFZeEVReERQdWc1YVFLdFdiRVNlQmZMT2lyamVObHdjay9ZRFBGYnB0?=
 =?utf-8?B?UWZyaVNDQzExMUpDb0Q4UWl6WmNWVktoSllDZDg2N2duaktyYWZoTXd3N29Y?=
 =?utf-8?B?YnBvWWJjUmsyVkdUYjRiWDZhMDdvLzZ1OEZhNVRzUzlMV3J5SEhiSmEwSDht?=
 =?utf-8?B?UUhTV2dWNjhlNFA3bFR6WHRXRlZFQXo4aWlpdEE5emRsV05FbjdOOHlJM3Zy?=
 =?utf-8?B?aEQwdHowM1ppRnpsWWo3cDZsWGJDYVNMY2JWOG9NSVAvNTNBdWh1K3A1dzEx?=
 =?utf-8?B?V0I1elZhUTlaSFNobTcyd3VPK2E3OTdTNEhiU3NtQWl2MHJ5Qk4wSGNoejln?=
 =?utf-8?B?L29jTTZYa3dPRkpmYUhYOFU4eGVLRVkyYjR2MEtwL0lLK3owQWh0MnVqYlEr?=
 =?utf-8?B?WUR6Sk1pb2hzUmkzSWxFTkUvWE5NNm1XUS9rRTlSSG5zMkQ1eXBrSTUrYzli?=
 =?utf-8?B?R0F4c3VNaDg4RmNHTWJpeE93RDRvK0NGbFFPNmI0MnpYZ1NUWkx4UEFxQ21V?=
 =?utf-8?B?bUVkb3d5VEF6VVhWbG53bHRHeXRudDdSRlJ2N1FDQzlvYkVPL2pnTXhDSTFO?=
 =?utf-8?B?RnQzQ28rMmljem5ub1NDb0FzeGV2U0xlS0ZLekZ4UVAxaXNjdFFkYjlERUhD?=
 =?utf-8?B?akV4SHBNRStyTE9RN1FJN0NINmJGZ2c5bXZLYStDZjB3UTFONUg4d2ZlTEJx?=
 =?utf-8?B?dTRET1ViTVZCV0VxZzdEMEovWVBCbDVvRTZNaGJXL1hHb2xtNm5teWJUS0l5?=
 =?utf-8?B?NytKMERMdFJHTHZCYXFyVXMrYXdnYU9BS2VjQkR4aWE3QndMSDYzajFOYTJV?=
 =?utf-8?B?T0ZPZ2hqRTBVOUs2elR3T2ZiZmlSSWdrQWROeGlkdXB6Yi83WHdHc05vcHVT?=
 =?utf-8?B?L0lrVVIrV2lPTDhzVEdpRzdjaW90MkFlUHpUdkNjVGlMNTQ4UGRRWFJKYzlX?=
 =?utf-8?B?NWtnWVJaTFZLSmNxT2w3OGpmOVZvdUxhb1daYW1BVUhoTkQzNmI2RDR4c3lX?=
 =?utf-8?B?c2g5dktma2tkTXNCc0lKZzlCeDBLdGVhMzlERTZPUlJPbDhubUx1YkgwdzNp?=
 =?utf-8?B?OXVzQWc4djVKS2tSdFhUSllmeEVZNWxGK3BoMWJ5Mm5qNE5yR05NN2NFaml1?=
 =?utf-8?B?Q3BMaTBOTXlFN0JmeU1tQXQrMUVoa0xwem82WEhIeDB6WWtKUjhtclg1STJm?=
 =?utf-8?B?YXQ2Rms0Uk4xd0ltY3orUFpUT2RlRDZQdG5QbENvSmNmOW1vZ1Y1YVJNb2dO?=
 =?utf-8?B?MEtzcGFKV2JDdmVpYWRNa2t6NXpkMHc2NmJENHV2a2RHazB0aTRQTlR6NzVC?=
 =?utf-8?B?UFlReXRlZlpPc3JtME5pUGkySE5Icy9ONk82T1RDL1lyamVkK3lBOWtHY3o1?=
 =?utf-8?B?N2hDaGJzVGRIWG9RZUFxL0p0U0FOYk94bFpUeWtiZHZJTGdQd1FRL2orQ0lm?=
 =?utf-8?B?RCt3K3B3MXl6VTZFQkF4eXRVYkRScUpuazl2bFlDNm1UOG5kcVhMQXdaL3gv?=
 =?utf-8?B?eElpeXpIRlpNcWFxWUZaRUdQdytpZEo5UjkzdFh1V0JDcVNabitVRjZvUWl0?=
 =?utf-8?Q?lksU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8589006-8752-4995-0a0e-08dcbbaac267
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:26.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtLy2DjpBPWAz4RdHbY2/R1mua+Oy0x+ZRaln3VR//TGGGPUQjzT/nRcEXP+H1sM8HjX076uTxH0Mgvs8HY+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

Replace the hardcoded value 2, which indicates 2 bits for I3C address
status, with the predefined macro I3C_ADDR_SLOT_BITS.

Improve maintainability and extensibility of the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c       | 4 ++--
 include/linux/i3c/master.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 852b32178b722..85c737554c940 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -348,7 +348,7 @@ static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_BITS;
 
 	if (addr > I2C_MAX_ADDR)
 		return I3C_ADDR_SLOT_RSVD;
@@ -362,7 +362,7 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 					 enum i3c_addr_slot_status status)
 {
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_BITS;
 	unsigned long *ptr;
 
 	if (addr > I2C_MAX_ADDR)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 074f632868d98..4601b6957f799 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -299,6 +299,8 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
 };
 
+#define I3C_ADDR_SLOT_BITS 2
+
 /**
  * struct i3c_bus - I3C bus object
  * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
@@ -340,7 +342,7 @@ enum i3c_addr_slot_status {
 struct i3c_bus {
 	struct i3c_dev_desc *cur_master;
 	int id;
-	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * I3C_ADDR_SLOT_BITS) / BITS_PER_LONG];
 	enum i3c_bus_mode mode;
 	struct {
 		unsigned long i3c;

-- 
2.34.1


