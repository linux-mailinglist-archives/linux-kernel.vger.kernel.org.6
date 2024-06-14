Return-Path: <linux-kernel+bounces-215111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA18908E43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249041F262BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A510419ADB8;
	Fri, 14 Jun 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eR28Xkwf"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5A19AD81;
	Fri, 14 Jun 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377619; cv=fail; b=UNoGn1xDp0+0T+weduU0ZPk6NNDt9ByZND9SxHK0MAWnE4hVR1gupLC5eQOvGpKS45GI4ZnUew7Yci3Tg3wVWAa5FVdpT8gSV5ASqdzyCGea7G3D1msnw+4HO6c5Qz7zGRk2rbfLKiT3yqmJRJ0eDfPTFfp3dteLCVY0J+BEdH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377619; c=relaxed/simple;
	bh=XCUDXz6P6qoQoUmf7K0bLTg1SJKxzmluB5QhvEptooE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tS380iFqdirzOt5u6i1HBgeaZtPsOf0n5PlHekAV4hsizvCywY4flsuhiLzWkxGn23iKoLzGQeXNdBxocUtPOJILZq/tsAZWZ8nWtMRGwfdqd3cpbemqOKWCJJ8CezhzDS0GmimPsXmN/Mwr/ks2uxSx+iHpq/jhkP6Gi06N0as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eR28Xkwf; arc=fail smtp.client-ip=40.107.6.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxRb3SRu02zRkM1RQpvNMUUyDBbCGUX2yv+/xl+J7ujikwegkiGZBiA2rffWu5AS+xd7lPn/qsGouEcPrmjkohmj6vTeG9W4BEKTBRTqSJTZ9KgO9q+pG8kOxODbWX6/lsQJBGmLo97/jNv4c6meAJnJZzV9gTm+U1OIvEQnfV9Vjpy/gZRDf0m7dnaKE3lSuz6x/8QL3/iVUe7HK+6XYgNRnb3TZtvEyVf5gVJZw+ZSSp43C/3IGnLD40YU21CkzH9HdGnmsdVWyLI1b0hfm0DR3LXdBv6tZSoX6bYQJpGp+32YtjTIM1Kr/rHZLxzSJCNhAWK7SnxUNMVLSdGKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ/gvaWHQBm6sY2AeA8959U2nGfe75xQ7uoNYRMEoK4=;
 b=JaZDSUvI+KLzoY79GtqcpV3xjW+SUELoFTZPnTzJ01NmMrVTebe5B9dMsl6SH7rBIAo9IXX90FP0Y999GZTfejes8uhmXzrbPWAMt06Lln7gY8iqAzLmnIvENN6tRk2U1Ke2pf/dupJpT02YeRces74Hjmu4+pzxSia1kNgMidyj7VHgS39qZ6VSOCLv5/h/s4pEj1/b2APwsvdfmBwesAGrxC9Wi0tcZjgcaQZQfSGlE/UVc1udXK+OPtoImlDb0HsOrg/xrBWQ4VfGOb85Mfd6OEyI+PsIPcuUYPAbDUODtIrFETaYnWeuJS9k5ieqGSW1hgXIMlzMjpJ1qlX8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ/gvaWHQBm6sY2AeA8959U2nGfe75xQ7uoNYRMEoK4=;
 b=eR28XkwfBpRdjimgUmnP5s/MT+52QYy1ytFWGkwzFlQ06fmOrmzdwZdPL4DYoqpVz8XOAk+4b3X/yUt8DN7sIuXs61JGvgBasIWw2ztmehQpX2k/QrHJfrIyLE2rxeZjEMqZ+THuOgLUPZT2DbioXyfzS2Pb7uwCLKiUJQOY/jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:06:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:06:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 11:06:26 -0400
Subject: [PATCH v3 2/9] arm64: dts: imx8qm: add lvds subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-imx8qm-dts-usb-v3-2-8ecc30678e1c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=3746;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XCUDXz6P6qoQoUmf7K0bLTg1SJKxzmluB5QhvEptooE=;
 b=KdqyUc3FA3gBGIUP7QULTsnMghUNjbkxvZlOh6VACDO9qaH6dgdqPhDvoeu5VfVaMxZuMBh23
 1toqjCe/QmzDFCFtHrDZ7/Opbcw+oI9694o2vW6VusMPROTiataws0z
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
X-MS-Office365-Filtering-Correlation-Id: 4ce8d393-72a4-4c9c-4e74-08dc8c83a0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1ZjcG5Ob3IxK2ZuRTM4WkdBdERYeEhNRXJHSHZXZncyZnBJUFRzSEZtVGdT?=
 =?utf-8?B?aytKSnhwVDlEbTVYL09qREhmTUsxMnJnR2ZtczFMeUt4Smk4M1h2QnRkVUNt?=
 =?utf-8?B?dmV0dzM1d3l4TllMeW9jRXNZbkhMWkJadk5SZmp5Wk9XejZ6ZlM1R2tWTWgz?=
 =?utf-8?B?eE9oYUF1enVlNk43bnBuL0FIZ29lUXBMNFVBTlo5N2preFhkcmJOaXNMMERV?=
 =?utf-8?B?MFhueU8xSndXMHVjUHlnSjRXMXhZaWtZSkZuSUhjaEJEb1diZU40VEwrc0dT?=
 =?utf-8?B?VHRZcytKUVFOOVV0MlJVcGpWVW9EOEVUeGh2czBzUitJOWVwMExTTndFY3hO?=
 =?utf-8?B?REhuakY3RjJZM3p3MFJaSDFTYzVnVUQ1Q0JEVW83UjBtbnc3TmtuMmFvTmhD?=
 =?utf-8?B?VHhpd1A3YzYyWWdMYzk3bVZhTUlYY3gvTzNEWWJCK1BxczYrcXlIQWErOTBh?=
 =?utf-8?B?ZkpBeUcwaVRPSnhuQkQxM1NBT20wa0N6bGw0Zlp4MHZzMXdYbk5VUG1rejgr?=
 =?utf-8?B?OHgyK3Q1TUR2UWRHaHJDYXNDZUVCK0Z4YTlCTExiZWpzdkRtcjhYdXNkbTZm?=
 =?utf-8?B?bmw2SHdPcXpKNmgvMG00ZXJ5VzkxVEVZOGZXamVNckdOS3dWZXh3V09LQ0V5?=
 =?utf-8?B?SkdJM1dUMW1xbjVCNEVVMVR3U1NHanB3aUdxTGMzSlhFSExwWGgrVzIvSWdj?=
 =?utf-8?B?STRja0RaSm9aZ0VlSlZjVHQ3L1h4RHhwODFERU1ISUFjeU9BdWxWQ29XRjZH?=
 =?utf-8?B?TksyZEhyWTFBTklWZlNkOVRKek5XTkg4WnJ4azI3OWF2ZGdzdkNITGEvS1Bw?=
 =?utf-8?B?RGQrWHVidmtpcjFIUzB6dzRNbit1MSt3R3kxTmhMQlljNUZOMFZITXRyTVNV?=
 =?utf-8?B?cVgyaEx6cTdySlpTMFZLKzJoZkFWR09URHlsZ3JoUGxFUm9ZVEdjZEZuOC9W?=
 =?utf-8?B?WCtIVW1wYkxUVFYrMG5HZS9qdEhHY2hFckN0d2RIVHRTSTFpdkl0eCsxUDBs?=
 =?utf-8?B?cWo4dmFoTWUxLzFpS1ZGVVFtUElMNjdqQ3VDcU1oOUY3SkZsR21qZ1FOQUts?=
 =?utf-8?B?aFRiN0pQL3ltRjJ5Q1lkSUtkZjJ5eVlnT2N3anUxZkRMSU40bVNla2FNRWF2?=
 =?utf-8?B?ZHBYNlBGOEtvSHc5YlZ1S3FaYi9yVWxBRGcvcURreEVOcDZpUm9EMDYxWDRQ?=
 =?utf-8?B?NS85TnFhbGpNU3pUcWlOVDJyczQvSldOT09TU0NNd2c5NUtxRDhOWG94dWF4?=
 =?utf-8?B?Rjk5KzljTElYYWYzaSt4RTU5TzFteml5bUNtTFFNR2xWQjZVRWkyY016bGp5?=
 =?utf-8?B?bFIwWEkxdG5Fdks0UGIvUGY0dU5xenJLajdKcS9KeWpGa3JOK1BaaHVjTEJC?=
 =?utf-8?B?NUJ4STFjMEhuLzNhTE96UVlpNDFqaFFoK1RLdkd4WkdheWg0aGtVR2FzU1Fr?=
 =?utf-8?B?U1RiNi80dTA5RHVISGlkWnBxTGUrTFJ6RWtGYVFvQ3VJcWJwdE9LVkpIaHIz?=
 =?utf-8?B?RmhLWnRFaVlrSEJlZ3ZkQy93SUxxTkxocENWTG9mYmZMeDRrMkxOdk0zcHBM?=
 =?utf-8?B?R0ZkNERsVnFUOWt3T0NpbjczNFQwKzNtTG1CUEcwdUJLSnY0Z2k4UWNWN1NT?=
 =?utf-8?B?cmtkVVNaZ3Fndzl2cVNGSUQ4MmFYQ3BMVFJYT0N5UCt2SWNzTWJuQTJaODA0?=
 =?utf-8?B?WVJDQ1k1aGpEcXQzM29jVEJtZ3NuN0ttaElPZG9zbWU0Y1pWTFl2c0ZuMUpY?=
 =?utf-8?B?QzU3b3dwODJ0MjdUZW16bUtBbmZYdk9TWmRrNE00bGNSS25zVGVJRjVOZlBO?=
 =?utf-8?Q?omIIm4o3LJ9hJY87D0FJBZB10MdM2EU+HUg/M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWo4a1BHaXlxdzdKS1FNNGNGcjNzZkVKYUkrc0pxdFpKdkxzdjdBdlRrNWd4?=
 =?utf-8?B?OGdIVkNkUHZkTnRURUdKL2k1NFo3QkQ4YmVoR1RGZzR5TmpBazJ1YXF1WWs0?=
 =?utf-8?B?bnA3ZE0zWGZaWXR4NDEySXcrNWRmU3NSUXZBaGwwaUxDdkxxWWhyL2h3OGJk?=
 =?utf-8?B?S3FvNENzWmVCb2ZhWFpuVlYzL1ZPYk0rVkUrMnRBa0ZucG9wS25zMUZnbkJQ?=
 =?utf-8?B?NndNeFc2WDRjS1d3cXZhbTBnOHA5d2xyRXdmOG40UDArM1VKVjdOYUFjRGdU?=
 =?utf-8?B?anREcDdGQW1UbGJPWnphOWhhSHg5RHc4VkJSNHB1TzA0aUJaNElFUEpqQkpr?=
 =?utf-8?B?L1lKOGF1SVNzTnFhN09ycnFtQjlKTkFkb1o3M0wvWTczNnhnWlpqY1ZCcmdx?=
 =?utf-8?B?bDFmSW1XTHZDYjB0QWdqemtQRzNybGpZZjJrY1c3NXlXRkI2TUpLYStvRHdO?=
 =?utf-8?B?NXdocDZacXFMQ0VOa3NkQm9IY3Q1RGFrNThwL21xNDBTQ3RDZ1g0eTFtbFdX?=
 =?utf-8?B?RGNFUzlmQmZMUWx1Q2E0cTA3b3RHMnB2THZoeXJEM1hqLzdXZUpjU1JBeVRl?=
 =?utf-8?B?aUo5NiszYTJFWng0UTNrZlJvcks0QlpLeGlWT0svbWMwU0ZGZTRaWUV1cjJr?=
 =?utf-8?B?UUJVUVhueTJCZjhkbU9XZ1RjNHUwbTJGc0RORldNUldGeG4zRUpYSVBXQ2c2?=
 =?utf-8?B?Wkc1R05VSUQwMFB5SS8xUk1BQmlFMEZJM3R0UDdFS0s2clpmVFVTRlVCa0hq?=
 =?utf-8?B?Tk1DL0w3U2pURmJycGpEd2JMb3lnTzBCZFV3dFVNVllJYlVVVDJZQ3dNNUxG?=
 =?utf-8?B?R0VrU1J2MktoZzJjT1g4YmFrdFRWbDhON2MrWVorRmM3SzBySk1SeUwxSTh2?=
 =?utf-8?B?UmF6M1p0VlEyNTVwMXhBbWtubUh0K3IwRkU1RlhUZTNnamV3OEJjL3ZXaXBk?=
 =?utf-8?B?OXB2NFdqMGdMdk8ybS96NElGbjl3akthQnFINHhFQlN6VVRzMGlEYVBabFNI?=
 =?utf-8?B?eHp6S29KbkFtZ3BtQVIvMjh4QjNJdVRITnRwb1JZQjcvT3JGTkFpVWFzQmdp?=
 =?utf-8?B?L201a0VYK1JnYUNwd1I4VXdBZHZObGY0bXJ0WW9RSkVrblhUYzRaQzBUUHdM?=
 =?utf-8?B?Q3NmV1RpbmtDOTlTMERCUk15YXlBVVBrK04ydVVWWDlwQmJZL1gzdFI5Q3VU?=
 =?utf-8?B?V2kyS3F6a0N1cGxFc2I2UmZCYjZxbGg2aUhGek1jcUlFbk5YQ2wzS2ZZNlRs?=
 =?utf-8?B?UGlQbm96bnZGSXVUNDlURlM4WVh6dytka2szMWhSWWgxM3RjKzVWeHUwSGFh?=
 =?utf-8?B?RElSdmszMFF2S05lbnNaNGFqcGRXMERSKzIxOFdaQWFRK2lOTklscnhzV3RP?=
 =?utf-8?B?NXZucG45WWkxZmpldm1JQTl4Q1VVVnhNT1JDcjZUTTBYS25zbjVSNDZCYStJ?=
 =?utf-8?B?L2FDRlVVWXNOOTFsSTB4SEFtcDI2cDBpTlNTNVlMWXJiOWNNUTdTeit6QUNQ?=
 =?utf-8?B?dkc4V1FmenZBMnFMUS9kWkNmNkh1cHY4cmpkR05KZDJnRExDaEpPaTJTNWZm?=
 =?utf-8?B?VUhBZ2w4aUs5bXNBem9nc21lVU4reFNCdFJjVWRxL2VkdHlGREJLSmk3OEZX?=
 =?utf-8?B?N2VLd1kwc3pZVnh1N1BzZjNQQTlkNkJiY1JUQnE4UHVINWMrYnA1K1Jsam1a?=
 =?utf-8?B?UW1LTlRXcXlZVkxQZzZ2K0tVb2xtbFY5VmlxSi82YmROM1hqY09QQ3BrL3RH?=
 =?utf-8?B?WVhBNG1rNlhsOFV5RENIdXhpUDlTSWhULytUQU1tZ2ZjVlZkRGFFemRCY29F?=
 =?utf-8?B?UkRuK3pEVEhtR0ptZ044bVE5V0VYd3F2WVBlNXBTbWp4ME9iYjZyNXFCOFRC?=
 =?utf-8?B?ekhRL0ZleDBmK3JMUEsvTFFpdDZkSlA1SzZKcmZYU1ZkcXRpbTYrZm0vc1E3?=
 =?utf-8?B?Mmg0SWxPQ3R3OGE5K1oxZVlXcmdyamxlR3ZlWXN2dTU3NDY0eWl1cjJFR05n?=
 =?utf-8?B?S2x1ekVoUlFDZG9uVVJGbnJidW1oUU9JcDZqSUVwYzJObHFzUUhtSURVM1lP?=
 =?utf-8?B?L05rd2pBZUxJV3dQNWp6ZE1RdHUvSGJsdTdwMjJmaHpGWVA1eU9JSmtEVmJY?=
 =?utf-8?Q?KmwUowSYEbdX/lRmw5H+WVmB5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce8d393-72a4-4c9c-4e74-08dc8c83a0aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:06:54.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rF7Wl/FN6qV7yCHWyojGA4Bqp8bgl/yzn+3IoyMLG5rAxNmrf9HEaVF+n1oXAV1c5hJ2diBlD55RZyGlCwTyAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

Add irqsteer, pwm and i2c in lvds subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi | 77 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         | 10 +++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
new file mode 100644
index 0000000000000..1da3934847057
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2024 NXP
+ */
+
+&qm_lvds0_lis_lpcg {
+	clocks = <&lvds_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_4>;
+};
+
+&qm_lvds0_pwm_lpcg {
+	clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>,
+		 <&lvds_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+};
+
+&qm_lvds0_i2c0_lpcg {
+	clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
+		 <&lvds_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+};
+
+&qm_pwm_lvds0 {
+	clocks = <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_4>,
+		 <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_0>;
+};
+
+&qm_i2c0_lvds0 {
+	clocks = <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_0>,
+		 <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_4>;
+};
+
+&lvds0_subsys {
+	interrupt-parent = <&irqsteer_lvds0>;
+
+	irqsteer_lvds0: interrupt-controller@56240000 {
+		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x56240000 0x1000>;
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&qm_lvds0_lis_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_LVDS_0>;
+
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	lvds0_i2c1_lpcg: clock-controller@56243014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56243014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds0_i2c1_lpcg_clk",
+				     "lvds0_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+	};
+
+	i2c1_lvds0: i2c@56247000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x56247000 0x1000>;
+		interrupts = <9>;
+		clocks = <&lvds0_i2c1_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds0_i2c1_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+		status = "disabled";
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 61986e0639e53..1e8511e8d8577 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -560,11 +560,20 @@ clk_spdif1_rx: clock-spdif1-rx {
 		clock-output-names = "spdif1_rx";
 	};
 
+	lvds_ipg_clk: clock-controller-lvds-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "lvds0_ipg_clk";
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-gpu0.dtsi"
+	#include "imx8-ss-lvds0.dtsi"
+	#include "imx8-ss-lvds1.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
@@ -576,3 +585,4 @@ clk_spdif1_rx: clock-spdif1-rx {
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
 #include "imx8qm-ss-audio.dtsi"
+#include "imx8qm-ss-lvds.dtsi"

-- 
2.34.1


