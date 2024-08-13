Return-Path: <linux-kernel+bounces-285048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDE9508AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101DF284EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E01119FA9F;
	Tue, 13 Aug 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FUgvOE3p"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABAC125AC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562125; cv=fail; b=TN4wev6TjURekUguWQlZ1wh7VJaTgSBzadxCLbP8JhonbjRClpscB85LmakX1dyrRYwB3m/D3z4dQP0KjS/7TCBphM0NLHg4x6muFJjcZsOSNVpxuxa+N6aAfLuHEDjVr0dRniAe/m1eT4PUBNBScr/DPuDGUxTLBhyMxSsyOY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562125; c=relaxed/simple;
	bh=qULKNECKl29j0mMuFirqULF4KYmewWg63Q4mY6fvZL4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=GpFV/rBDyZuBscFQfJnBJerMszS99PtVnkakbxaqJLaKUkK1QnUDCYMyJmEKNxAPRFRFXVqX030cHkW1yghKFFweC3icHtM7QIrGgBgKJJZ0H3ir+sUexiSmLX+K+LOjQ6GibqAfCSsRZ92TMRc+JNMSCfpmjTXOy66Swlv5TDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FUgvOE3p; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7yjp0bM57yxsEo28pN8pN304sRQv9ixfgV89mew/Wdd6kAHVEYTB9gx2MYGlKrFHWTNBsB01wUxvL5qFMmktodD/r6jjKiSaThD2UV6DtqXhX0CDL1gz73rJ6BUJU8CRO9r535ZK4EtlTJwW1SfWr41KeoHKBRqGEQIaFRBj8x2WtyESu8rt6632GKz6gW8GYj7ie7XHabfA6hgiRptnvOraSW/fA5EgXdjk5n84Wm0eDQXfGSyAq/90w2xeQTZaqmes9Sl2xTPwYTL8M4FkiNPnBZPv/rIYTKUSu4jROwn9VtYfb8vNQBi4mfrvz1xZrUnnipKwaCZxFT/JR1CIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik505uxrcoOAZoq0M5fToVBuqg+6ZfC2DDgaDAx2Kd0=;
 b=KHrFccrmcNxOn6AzkqgGP/phm01bkqBS+pSjmW5LoNKlNw2omwI1Vl99Z+mfTtqs6JK80SQD3X6hfXKYtAw7Qd8T2BMTayTKlcKmTvg03w/ctXzSs1k5c8REji4MTXDiRRriIzPIQ+Igf+r3HwH7CJDnKzhiyiiUtm074uOapx8XPksCvNvoGMjMTy/h/8hnOOLBAwu3prKLEZWOYp+PqOpVu80rOh20s9tmKZfEkR3iYO4igKaNFMgW94lVIK3nAaowVPLBmnMaSrXdB8Yz7r1PskU1udXVH29M9PAnqxTxsJgL3TiO9UqEHu+g7odmnCbVgrbTWvGDyy67BU05KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik505uxrcoOAZoq0M5fToVBuqg+6ZfC2DDgaDAx2Kd0=;
 b=FUgvOE3p0u3Dq53Vw0IywaeGlfIKi9NY7ppMMl1uVXyUiKiwT/A1cuVlm8dSeaN5KO994ipFP7zrg0p6sw2Rdy4Nfoe+jGOxxLSSUIEBvzR/Y1CVneJC5lfdFvfBSTVr7aCjpIrsSdGCpMMQLSGktctcN40TEe4fStOxAgfxh5WPk6dRfA+YeWc59PKMucM6WIJimDaGpBdS7Dywsnfgza1tZdcFhXBb9y5xlAsffrx4TdRz180R4d9ITe0Qt+gqgDgeOio/dIp4xL5mmeErALvFMaTIm1dD46NHSlBTf5AQEKIL34O8wjohEf6fnHYALnTj/5kqtRAZTywmZ3dpRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:15:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 00/11] i3c: master: some fix and improvemnt for hotjoin
Date: Tue, 13 Aug 2024 11:14:58 -0400
Message-Id: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJ4u2YC/2WMQQ7CIBAAv9LsWcxCq9We/IdpDNDF7kFowJCah
 r+LvXqcyWQ2SBSZEgzNBpEyJw6+gjo0YGftnyR4qgwKVYe96gS39uF4FW0vjbs4fSVEqPUSqer
 9dB8rz5zeIX72cZY/+//IUqAwTp8QDap2Ot/8uhxteMFYSvkCoZjLX5wAAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=1779;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qULKNECKl29j0mMuFirqULF4KYmewWg63Q4mY6fvZL4=;
 b=PJ3YpGvyfQCWEUiDBw1ivFyqRde6qzLyYi0wxPRyRgySIv2YAWHCty+5wi6p4PicqeDV1Z6pX
 hWYVBRBvHMcAy+Mwa5P7j+Kec1qjINWdN8hmu2icgfr42TuPPWvBWz9
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
X-MS-Office365-Filtering-Correlation-Id: 6d8b6841-2b5d-46ff-c946-08dcbbaabe86
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Tmg1bG1YdklhU0FPZ294TFphYXVDc3VZL3NSQlI1NXIwK3FkRVZSNHNRcGE2?=
 =?utf-8?B?N1ViT09NVEpNQkJ5eHlRL2tHdzdURWVod3RaTlhGN0RtcWJ4VTZzbFA1UXhP?=
 =?utf-8?B?ZXlQTjh5SXJkYXRkaFNmc0sra2pmL3dRcllkeDFJZVN5M3k0YTVwS2k3Wkd1?=
 =?utf-8?B?TGwyQm9WU1pmTTF3Mkx6dVJEcng1R2NOVzY3V2tuWUh4VExhUWJxT1RkMDd5?=
 =?utf-8?B?OVFnd3dGNzBvUXR1Z3Y0RjU1endqMjJXS3BMN3ByeFVVM3FmL2lvVWV3ckpJ?=
 =?utf-8?B?VTF3MHZDZ0pGUzhqdW5OdzdTOEhTWTRWZ0grODlMRUplamdJYytFa3piR0Vi?=
 =?utf-8?B?dUwvUHNJc0RXQ1FZeVJGaE1ZclN4OGV6ZzhjZkZMbGtEMHRGNFJxMXJwVHBR?=
 =?utf-8?B?ODFxanlPNm5NaFF0U0J3eENNbEdtTWZ6UktDVHU3bUU0UlV4YUV3bGtJNHBP?=
 =?utf-8?B?bXZteHlLZ1pqNjErMFVzck5aMmdMbFRqLyttdFVjMVNMNGYrZUZVRWVvdCtP?=
 =?utf-8?B?eDRkVUppQjJjelhBdDh1QWxDUWZxakJFczVmaHIxYjIyMEthSUlzY1UrSDli?=
 =?utf-8?B?VmtoVVU4V2lpM21xcFRRNzRreWxpN1RIOEoxamNRbXFjek9ibU02WEZGSGZI?=
 =?utf-8?B?dlBQOGxhNEdXcytseDdoOW9uMm01eEZzeUNVaXpWSC9Ob2dTMkEyNUJZak9z?=
 =?utf-8?B?dVl2ZEZ5VGZ0TFJ1WVVITEJQZzEzYXRBUXdsY3hlazdFSWNQb0p6TmVOT055?=
 =?utf-8?B?TVYxS2lzdWJaOFhVUU84Z1F4RTdKZm1RTWlkVE4wOGpLbSszRGlES2tRL1N1?=
 =?utf-8?B?RE1GYnFlUWJ3bkI4Qk5GeHAyZXVOL3NwVDROWDZkR2d3eHRLTU9hcHRmYzZF?=
 =?utf-8?B?SnFQTmRMSGVMam00R0owQ05lMlFkU0owUmpmYmdJOTR4b25QaTBnZTNFRGMy?=
 =?utf-8?B?cWp1bXh4MlltaG9OTVN5d1FsVFdkM2VQQUNCYm1QOEVONWZueGlYelYyS0xv?=
 =?utf-8?B?MjhaYXdiOEgybUVYQWh6UjMxeU5sdVhBaHBOU3FmN2Q3d0V1SXlSS1NOOTVh?=
 =?utf-8?B?YktQdTJ2RXNmTUpITXlWQmVZVU1oalJPR1lZSTJtcGVYNGJDakVaMjNKSkow?=
 =?utf-8?B?QzExN0NmMmtPRTRRRFovUHRMYlBVOUFGMnNQTmtPaG9LL1R6SWZjdXM5V1dP?=
 =?utf-8?B?ZzBxUERnbXBqMnZ0OUg4M3JPQmtxdW93ckNqd05yNXlOSm9jZi84RmZtTGY3?=
 =?utf-8?B?MlE5S1R5YW84ZDBWRHJnTC9WelY5L3AyeWNqbUpwRTBNelA2VW1OR1NDc0ZS?=
 =?utf-8?B?eFFKdjB1M2IzcTQ0QUxSbHNIZk1UaXBLd0V1R3ZHYS9reW02b2Z4OUsvUWRL?=
 =?utf-8?B?WDN2bjVZazdNT1QzWG1ObFVLSTVGenJhWmxlZFVYQ1EwZHM5cjFxa1FKVDBC?=
 =?utf-8?B?QWVxU1ZuOUo4OWNHUUR0VDRySkdpV2pmVmUzZDhhemlod1RsNEVuTU9tb3Zm?=
 =?utf-8?B?T091YlVkZmRFaUtHQU9sckVkbmp6a2ZYaS9US0ZvYnZCVThjS28vUXg0dko3?=
 =?utf-8?B?Q3g0MUxDT2UvY3pidTQrbWpYMm5jaGlJd3JkczU5NzNrd21iNGlZbnR4eVg1?=
 =?utf-8?B?SzBwNjdJcFJSdmlyWEJyTG4za3BDSXh5MkhoMUNDYnVrZmJPMjltZFRKTVpq?=
 =?utf-8?B?allXcmlOMEhQQVRLSGNuMUtocW9lUlcwMUJYNExIc2tvL1R0T0tHMDBJVk1Y?=
 =?utf-8?B?aDJCalZFNGZ3aU9QNnVYd2NlN2xzY2dKWUFUL0p1WnBRTWtEN2VaRFNhTGRP?=
 =?utf-8?Q?oCbDK35ll57urB5q5Rssbcv4X5mIi77mAR7+w=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L0d6bjh0MnRLN3ZscHQyTW5KbEJmL1N6UCtzNmhsU29BeDMzb3NucUdURzF1?=
 =?utf-8?B?Q2VWcm5VL1N5OElNbDNtUUM1MDJub1E4c2hKK0pSV0o0TkxhMkJ5RjVlcFI1?=
 =?utf-8?B?KzFTamlrNkcyMy9kWjJDQ1JZdlRmcjl4MEk1M1BFSEI3bEc4ZFRMc1VFWFJF?=
 =?utf-8?B?SG8zUkNBQk1pMlNoQzNuamRPN2V6bDZYazA1bnQ4Q2JBOFBQWmdWZlR3WXJ6?=
 =?utf-8?B?S3crU1NaQllCVmxqZTluY1dsWkVzamxTdytEVGpza0NHVUFiTnZkZlhTRWtr?=
 =?utf-8?B?WXBLalVudVphRDN0bmNXNjBNd3JadXhPeEszZjdkOVdyV2FzQjBwQ1FpUUxM?=
 =?utf-8?B?RDhlVzdyQ0p1elp4eisrcW4rWGM2cC95UG9QYlVWRGExQTVXTklUaDcxcXE5?=
 =?utf-8?B?Sjg2akxNTHMvTUNLcktHcmo0Zm5TTHhUUTlEOWhKQnZlenpLMXpWM2QwTUZ1?=
 =?utf-8?B?a01JWEJnVEdLVk5BaUZKNlIzeEVXUm15SEw1eVNlb01OeVcyR1JWZFU4aGlG?=
 =?utf-8?B?OWFqdEk1L2t3VzBJZytUL05BV2svTk9icVlZMVRiVDhsL2hWSlJ1WWJmVFg3?=
 =?utf-8?B?aldIUVIwTC9FK3FjL0xkRzFCeWZQU3cxY2hxRUxKR2p1Tmh4VHZxU3VxbWgy?=
 =?utf-8?B?QU9vcnpZbFlmNW04dHVyUHR1UkhZS1N4WWY0ODJhbzJ1d3FCYnRabGRTZWlB?=
 =?utf-8?B?OXBYaWVRWVZrSVpLbGpKQ2pMTWZqWlhlYXdmWnlCR1pEaUNudklDVmhJK1Uv?=
 =?utf-8?B?NlpWUEVOVG5vYklQNW5iQkhzeFhGSmpnTjYzcnlCODYxYVFCSExiNEI5SkxX?=
 =?utf-8?B?eHJGOG1SRFA4V0dVVjFlbjJFeG1rVW1uZitNUThuVVZBWEVsT2hBd2lRT3kx?=
 =?utf-8?B?dzFOcVlDcUpZeFl4ajlWcEJGV3FmMFRoZVEvMlFsc0lieUxIaEhOYUFlVHJp?=
 =?utf-8?B?eGQzSnF0Wk9VbUt0S2Qzck5sbHQ4OG1oOXREM3B6ZDZYdktaVi95RjRmK1p4?=
 =?utf-8?B?eHQxR25zUFFmZStoVm9MK0VINXJUaUNFMDNWYk0zVjhrV0JObzZiRGNFalJD?=
 =?utf-8?B?SWxMR3BKRjBabjZCZ0FsajQ0YXZxZlhQNCtYQ2RPYmhCL2NqbHBuZ01hOVE4?=
 =?utf-8?B?ajlPbzRFZlBBRDVySG9peG52NUFwM3JnNmRPTzhVYWM2a2h2N29mUHUrNVJa?=
 =?utf-8?B?MndpOUNvT1JEU3NKNVl1RHJScUhyNllsV0hUZUEycW96RCt3SVpKL2tONnVW?=
 =?utf-8?B?T3pqU3BWY1kya0d1cGM2Z202c0RPQm5ndTNHVG56cDRwNUNDM05ONGUwSXpJ?=
 =?utf-8?B?VTNGYjZWZ25JMy80VmtMamZSZ2xnd3RVaWhlZUFUZmd1KzUvWDFoTlZHR3RP?=
 =?utf-8?B?ZHVlQ1J0V1F4RDVmSEN0TkJ0TFlZcm1ZSTEzendCMDhkeWZQZjB4Q3NNMExz?=
 =?utf-8?B?c01yQlhLQ2NwaEtEZVlhRXU5S254enMzZDJnQUlCYWJKUFVzMEszMnd5a1Yw?=
 =?utf-8?B?NWh2Yk5PVG80bzNPcDMwVzVsak5pUWtMa3pHeTRDUmZRekUwMXBKcXhOL1gr?=
 =?utf-8?B?VS9xc1JQci9aT0ZUQXNQZi8vSmV0dmh4c2loV1RFYXdjODQ0Qi93Z3VPY0gr?=
 =?utf-8?B?ZWZtblh4VVZLdmxSK29DUWtOR1BOUktrdzlOcFNhOTFYaHpWVlhlOWNOSkU4?=
 =?utf-8?B?UFRvNEYzbkoyUjBDKzNVTEM1emhwdkExTldqTms4NHRIeEpySnZlVytETVM3?=
 =?utf-8?B?Wml5WFEvY0hKWlFPY3dpQjZJTGtmc0xkOEhmYUYzcThZU3RXWktYNW43bjEv?=
 =?utf-8?B?cHp3Mm5lS2Fjb2Z3aElqMk12OFlHWHdnT244VGU0SjZwRm94Mk9xajljK2p4?=
 =?utf-8?B?SXF6M1hKMTRqVnNRdGYreWJTWGhqU3pTK01qOGxKNG1YdTFXSzJoWmZJRnFx?=
 =?utf-8?B?SjhOazdtNGc5VlZVOTRrT1pIVk1MV1ZHU0s0bVNYZzZKeWNJbmViZGsvemZ4?=
 =?utf-8?B?bElYRTJTbWlLK2xFREoxU3BPN2cwa0l6SWpKbjB4UVliZW4reWU2TituSS9V?=
 =?utf-8?B?ZFg0UE11RFFKd0d5T1ZpREZudVBmVm1NUnVtMmV2WnhOaFFhZ1o5d0hMN1N1?=
 =?utf-8?Q?IL4A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8b6841-2b5d-46ff-c946-08dcbbaabe86
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:19.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQRtX296zzx8NXo+dmZcqDyngoGRb+IbyujtQwyNUBNpYNZ7VfvUbPqTkfhZTLSAZ0YZXbJsOc4OqRii74ClMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- add help function at i3c: master: svc: manually emit NACK/ACK for hotjoin F
Add below new fix patch
i3c: master: svc: fix possible assignment of the same address to two devices
i3c: master: svc: wait for Manual ACK/NACK Done before next step
i3c: master: svc: use spinlock_saveirq at svc_i3c_master_ibi_work()
i3c: master: svc: need check IBIWON for dynamtica address assign

- Link to v1: https://lore.kernel.org/r/20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com

---
Frank Li (11):
      i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on device hotjoin
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_INIT
      i3c: master: Fix dynamic address leak when 'assigned-address' is present
      i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
      i3c: master: svc: use repeat start when IBI WIN happens
      i3c: master: svc: manually emit NACK/ACK for hotjoin
      i3c: master: svc: need check IBIWON for dynamtica address assign
      i3c: master: svc: use spinlock_saveirq at svc_i3c_master_ibi_work()
      i3c: master: svc: wait for Manual ACK/NACK Done before next step
      i3c: master: svc: fix possible assignment of the same address to two devices

 drivers/i3c/master.c                |  66 ++++++++++++++---------
 drivers/i3c/master/svc-i3c-master.c | 102 ++++++++++++++++++++++++++----------
 include/linux/i3c/master.h          |   8 ++-
 3 files changed, 123 insertions(+), 53 deletions(-)
---
base-commit: 41c196e567fb1ea97f68a2ffb7faab451cd90854
change-id: 20240724-i3c_fix-371bf8fa9e00

Best regards,
---
Frank Li <Frank.Li@nxp.com>


