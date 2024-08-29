Return-Path: <linux-kernel+bounces-307694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E49B4965199
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1A51C21F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AFD1BA877;
	Thu, 29 Aug 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SN41fT1v"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE52148FF0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966103; cv=fail; b=YFWeYxCNz4kDdn/uL6Vt0qzvIQIIL68LwypoZm+fz7yWUpfTKeM+g/7TQXoAABWpcvWHJwjK5Y+ygcz9jNHjGYgIfUVyVkD2Aus2z/bwnmpGPVXthBk8JL2YWyy4a9wmuAv0z7C//LU+ngoCsVm0/Yf3gdh7Lg1CfsVdm69SXEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966103; c=relaxed/simple;
	bh=ZFRph0b9X+/CcyKerJ3YnFLz9ZtABnOTIX6HgBcQtls=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dvfm0E+ymThLYcihJ/BMOlPDFmg2HXlCniPuzCPawCO0BB12t3UoqUB8e3tovDgtLV7fi37B7n2Bf0oeFYR7JHY5rFKnK7U5CeOEU+2KcrToY2Eef7JqfGnyLtFIYmDh3nm08PRfc7vvY/oT7v5rjt0GZGA+s5uoYmHbvxEhEx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SN41fT1v; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEHkyLbY/3nU3aDDyL5/obOg3c9XcoFzyIKR8YiFsLVGxqsQ2PVCOz4wcHTvCtDad7uqWuSCoS4/lrBjed9oergCtTxzl5ZgoDD7iNBa4D0RnUEhfgO2JoQkFaQmKEQ+qmQ7YEjE9R8D3xoY+2BoXvZhJQ+B6zP/pn5es7Nr5eCFdDbar5nqSFR7Z9NY4qsTJqI9fBveh9WHSb7S0uvOYlCzpCOFIywRq1tRQIFKvuG+KwIONaG3c2iZ9PJk+jb/LAyCL3VQ1H+vRNyrb0dKJUpnbfhSUKgjnMdd8Wsyu3RsHQqlZT7HUbw1qWJh/GS0wqOUpHPgr3k0S/RRYkm5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Zw+7Tpjz7a4IHNLJ2t5tmfYoXfsEZBhOfeYqgtMXJE=;
 b=Gl3BOi84aq8S6WpmTUdLl6UYNYu3fBcy9ujRfzqnSFpzz1YK7TUcOqD49fJre/ZGa0pO7nwWEv+qzC6xNejfn3pbvsmSykYfg950nCwZEfnAK3nDYpMyp9WDF/qKuj+P9FSupiCUQ/sbpIF57rIqnSju0QQFiOJBeNU//S3MpUReyBScWdNH2VfNFzpg8IsvUNqzS3jhTTJBMfg8yFw2F6ee3mAgFGAyHwe5VjuOc2yEU/nbZJPuO/tfhm8WUIUvvV1bYwLVjzlAftIMbY5tX0G/GjsTpNxuPhkW7/9ny4qY9Cd9f/43mqKmwM8ELV5t1DGJUFZfZ17GYWJafvF9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zw+7Tpjz7a4IHNLJ2t5tmfYoXfsEZBhOfeYqgtMXJE=;
 b=SN41fT1vny71FylgoVJLMnQC9NrYL/MK4hwwhIiIBTAQrB58vJ3iriuTBvhAKgNiMIXWMaCEMCejLl13NsYzC2wemPz97oa39E693bcFEnmGIWVCB5P3Jub3bocn3DYJWoyLqe4wZxTUoFeXLUZJ3rHSAyFeGNiGQQZq7HsdvCHXR3kic6B01CbISzbehe2MKP2ezsV8CGjCFc/YvHWxFbTyRGc1AmNh0ifDcAj1GwNGx3MxCIoYHEGeGtkLPDUCgeqd+tp+v0+ee9S5f39NBdMCCI7i1nz2QsK1LwlCFbCs3/3rLEi6vjgMoldGiQySHfIl5ZcxEMKIQ2+EdvC1LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 21:14:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:14:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:13:59 -0400
Subject: [PATCH v4 02/11] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_STATUS_BITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-2-ebcbd5efceba@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966082; l=2002;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZFRph0b9X+/CcyKerJ3YnFLz9ZtABnOTIX6HgBcQtls=;
 b=JJwat71EjT2Efb5wn7NQ5FjXv7ISFVknI5FLH3pYCOP8kFCQbd9CHHn9qBGDeb3q9VlV1tvex
 fy9BLeYfXPVARU389gVJolvkRZkVnoI7Nle08lVPAhIbJmbDSHftc0D
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 1420fe84-6d9e-40e4-330f-08dcc86f9fc9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZkxySE5zUURVenh1Q1g3ZXFIQ29FQnVXbkEwSWhiKzE4OHl2WXphdE16bURW?=
 =?utf-8?B?a1drM1E0Q1lGYWVnM0lZc3FISUlid2pzRWdUeFJxVm0zanNIY1FHMFdnWUdL?=
 =?utf-8?B?VWhsbTlQR0ErNDFQUk04ZlFFVlZTZ2hlZEo2NTFoWnk1elA0VnZmQjdheVVs?=
 =?utf-8?B?dTFaeXpxYndXZC9LK0p6SWJ1a3pJcDFMejFTbDZYcU5xOWdSZ1RVRXpwbWRN?=
 =?utf-8?B?WXMvTUowSWpQd2g3R1pTa0IzZlhKR0pWMGZDYWl1Zm5KSlVwblh6emlEcTJH?=
 =?utf-8?B?eEE1eFdBWFNQaHk2WmdOZnJFVjlaK0RUVDB3ejQ1dmtGMEErVEtLU1FwRmhG?=
 =?utf-8?B?TXcyVmtsbzhVVkk3WksvSm5XczNoNFQ0Tkc5VjNaV2xZWDlwYmxRY0orekpq?=
 =?utf-8?B?RThpZkk5WUI4WlZGcm9WbjFxd3BMbGdLcU13dlNYUEYra2l5T1UzZ1pIOFBH?=
 =?utf-8?B?SXlZb0VGaGhmUEhWWHZOQVJ2RklEZ1JoMWpHNUs3czBWaVFGZk5hUEFUMzc0?=
 =?utf-8?B?UVBzSmd4ZjBDazVWM2NacHdabWMwckVETE5hL3RZSU9Sc0xiK3UzcnNQdDQr?=
 =?utf-8?B?TTR3c0FHa09oU1dQYVYya0lBc3BMTHY5RDhFQnAyalJCY0JmL0hjb3ExclJs?=
 =?utf-8?B?YUR0MzZVa0JJMTdGdUNIVmJwM1RVRTkvTXVIeFlTRlY2NEJjNGVFZHVtK0pM?=
 =?utf-8?B?eGd4TjFLMnpPampiM2sxeHUydkdZaUdXTHM5RWQzNVVoR1dmd0JNM3huTjBK?=
 =?utf-8?B?azdOUy9wZ0lWeUlXY2pxTXVsRzQrbDcrN0FRVExWKzZabTNtK3NLazhkRjJR?=
 =?utf-8?B?VE1waFMyV044T1cybjR0Q3RJUkVUWHFEcmQ4RWJTeDFCRk5ET0hsaFpRUmdL?=
 =?utf-8?B?bUdpNDNtTmFJU0IyMWpOMFg3cU5ubERrWXlmUmZDU3hVMFFCK0ExT05KK25M?=
 =?utf-8?B?SEYxVHVlMEhxRFgzdHFzdnowRStqYXp2SitVdEovRUFhSUJ6SlE2SUtnWDk4?=
 =?utf-8?B?dExDcktyKzhCZ1JkNHk4T1hCTUpyeVlKVWhobmhKN2xacmwzdDN1U2VSeFhL?=
 =?utf-8?B?SEdZZTRBcHU3dWZVaW9pOFhoV3pPUGcxNFBtcHFwUHdWYnhOSUtYeDMwY1Bs?=
 =?utf-8?B?ZW92MXphc1poOEZPeVhDbysweG53YXJoV0FWQmswZVVvOC9MZEhOdUFBS1Vk?=
 =?utf-8?B?WFcrdjVYbmZ0c2lRdVM5MFhIbTVJY1VZcFhxU1VvL0RsRlNYSVNMVjZRb2hY?=
 =?utf-8?B?U2Y4ZjJTdWNoUlJMTkprMUlQSktTZFZqb04vTVl2WmFoYUk2SGZYRDViZkti?=
 =?utf-8?B?SlAxdjg5Z1lHL0pzSWhrVnJCcTRXeHBWVG1Jd0V2ZzdCUnJqNW9hVWtuUi8z?=
 =?utf-8?B?UXZodW0rNTlGa3lmZHh4NElwQXdxK0ZUK3Fhdlc1RGZBcWs3QWVtZzhhVXlx?=
 =?utf-8?B?Q2tZaTN1VnRBOG9yMFhubHdDdlZMS3JRaFpEUTd2Q2J2L3NQcE9mM05sQnJD?=
 =?utf-8?B?d094ZXgyRW1xaW45S0R3d0JOVW4vM3JzdG9KMHBMbUVDME9HTmt4RnBXejlP?=
 =?utf-8?B?WEhiUUJUS0hnRCs2bHFQTUxGYmRVK2VWVHAybEw4c3lFV3ZSTjlYRHdoWEtD?=
 =?utf-8?B?V2pzbGpmYTFNMkNnRGo3b2pCM0JPdHZvNkJOUStqQ1NNUm1LNTRWbUt5RWpN?=
 =?utf-8?B?WmdxQTN2ajJEa3hmTEVWYWJ5OUtEMk1NMUx5aUx2aXhWbjNjYXE2WndYeXVT?=
 =?utf-8?B?MkJJRWdhVmFWOFVtdXNwc2RnR1dGbU93R0tZVE9RTFlTdlo3VHczT1UwTUtw?=
 =?utf-8?B?YmJVSkNrcWJlVW9sMmFqSmxWaXhFbmUxcGVJMWEvd3c0ZGF5TDZFbXdac1pF?=
 =?utf-8?B?azJZbk01VnNVSTlpWUpaalkrZ0lhOFM0elZCNHhSRzFReXc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RWpJOWNIY1o5WTFnNTZIVU10Z2FzTmptM25XbWE5RmdacmF4ZmdvZkF6bU1T?=
 =?utf-8?B?SnhyN1RmTmxrYVpuWEZvY3ZDSS92YjFCN0YxOGRxZkIvOTlwREk3NFFvSnJY?=
 =?utf-8?B?R01JSFVMSGIrVXhRTWZ3QUM2cmtrRVpLK0FnZ1NraHdkem1oK2tBNkcweFBL?=
 =?utf-8?B?K2FtcnRYYWk0L1BwWG14UG1HUS9MVS8waWN5NWFvWWU2Nm80N0RvZXF0ZUQ2?=
 =?utf-8?B?dVIrQUsxdFduWWtBTDFGTTA3L0VUTkFlWnFSTlBJSzU3Y0w2a1hLZ0pidGVa?=
 =?utf-8?B?ZHJuN1laQ3FqTWphUmQxTnIxYzFncnlIRGkvYVFpdUEwUmVxM2V3RXV4SC9M?=
 =?utf-8?B?RVlRYTBrbDNPeGd6UUlYSVFlcG9yZ3RYd1JETWQ3cHg0OXdmQzZOSmM2U3ho?=
 =?utf-8?B?aEpBODRpMndTcVlQSCtBN2x4em5GTjk2MThxQ2kvWVBIRFgvazFldm9DM3Vj?=
 =?utf-8?B?SnZaOEJoZVd3RmY2MTBRME9ld2ZtdXFWNS9LRVlaWEVTcFFpWTd4V01GNE1w?=
 =?utf-8?B?alZlOE9ONlN4L29JVlJFUjZ2VEN4YjQ2QzVtcUdVeU5UQnFPcDZFY1FpVFZM?=
 =?utf-8?B?WFNBNXR0U0ZSWis5czNldVJOdFU1bVdlbHh6bXBLZm8zVzNXZFMra1dtRHR0?=
 =?utf-8?B?bjJkWFhVSGU5azNVOE93R09HanBLcncvRUFGSGhCSktZSTZHQmNCZURkWWxZ?=
 =?utf-8?B?NDkvbmM1ZnBOYjJDRXFxYlN2RzFJU254M0hhd2NBWENsR2VZZDVkc0h0SzQ2?=
 =?utf-8?B?cCsyKzhpOE14aDdhc2hIZHg1L2NuVXk1eUhINTZiZmZjdStMV09ybGFlNFJQ?=
 =?utf-8?B?SGYzYVFOYTNNeWNoSnlkZDdlTnhJTGFTalZINlk5WkFNSjB1ZU1EQm1NdXJs?=
 =?utf-8?B?bFN0T0M2aitXcHNKYXFiazZ4VlFzaXFkQlE2NGg2K3NhbG41aDJ5N1BraWJz?=
 =?utf-8?B?VGlFT1NaMDcwU2xFdnFaeG10TGFOaExTYTh1WXIydlM5SGFLR2xkVjREWlpD?=
 =?utf-8?B?YU1Ibng3Z25rU2FOMGhycGVDa3pnNEFqTXAzdG80NnlpVjEzSTF0aUFOYU5r?=
 =?utf-8?B?TDN4VXBmalVHN2M5aWFseWVtRGl1T3V4alBaTFVCTWJGZm80bXZ4WVFFcnRP?=
 =?utf-8?B?Q3pidXAvNEpqcGY2MnVwZUYxL1RwWlZUbm5uM0lMbm5CaUh5RWIwVzRaenNj?=
 =?utf-8?B?R0k1ZEp5OVJ4WHFrcUVHbUl6VEVKMjJodGFxRFlsWVpZdDJic0VzS1pvM2s1?=
 =?utf-8?B?REhPN2c2WkI2ZUo3WVRVK1VXQWg0V0llL3JvTjFWUkFPUm5DbXVmTFBPdGNm?=
 =?utf-8?B?VVNvK292SUJFMnNQb1B3eDN5THR2bFhDejBxK3haYjhuL1QrQUJhZUtYWnNZ?=
 =?utf-8?B?YU1weXZ6QWgwTC9ucDBVV21jU1kzZ21ucmJXL2E3WjZqZzZVdHhMZWZUeDRH?=
 =?utf-8?B?YWNpMm9QOUkybTJzNGdGOGo5SlVPdHEraTNSdjZKajFBTXBjTzhQOUNrbCtJ?=
 =?utf-8?B?T2ozaEJXWDRmeWw2M1VkR1VGQ3Ayemw4Y1VSNUs2QWlJalhFRWFHaEdvdVRP?=
 =?utf-8?B?bTZteFd1YVd0Umwwd0V2S1NYUzRac1VBdkVaZ2ErWS8wZGVSN2dhR2dkNHFW?=
 =?utf-8?B?RExSeE1EQktlTE45bUdmNXdtMm8zSnVoR0JHQnJtQ0FodFU3dWU1clJwV21r?=
 =?utf-8?B?d3dpRVFPS1V5NzUzR2xQK0F0Sldrd29Lbi8wdjVSeDJDUnZjSi8ydVFsTUpP?=
 =?utf-8?B?UUVEeTdHbzI2MWQ1REI3N3ZBcThFbXNQMHF5ZzF0a3M2MzNVUzlHSDRFSWRk?=
 =?utf-8?B?V1luY2JiSG5GV0NMbGw4NnREb0t4YXF3R0ZZQVhFdW5nUTBJRmNsM1RyRXVG?=
 =?utf-8?B?T0MzaUdmdzBveENxZmZHdm1qVmFoWk9zZEZlOUJLUlJxNUs5NTlEbVF5cFhU?=
 =?utf-8?B?b0lRQjByTjJwSUVHOEEvT0llY1BaRnMzMUFGcG41WVVLQlFuK1FoaUhJY2J6?=
 =?utf-8?B?RjAyTzN3WUJpTmhJK3hwWmcxZUpyd0pWcm13UVRwY3RRaTcrWkJLRlZFRElQ?=
 =?utf-8?B?cnE2SmMwS3llTW9hVjlWMXkwU28xTVYxcVcwRTVDN1ZRWkJYd3h4THd1c01Z?=
 =?utf-8?Q?PX8a4/6DCCNfHV6nG8JfqN3xG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1420fe84-6d9e-40e4-330f-08dcc86f9fc9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:14:52.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUhNNkO4u6hgs6jcyKx++fFnWvmDg7RU60dqIDg2GRlIoBPrPmtF/EyqcISpJwp/NAwZ3/iBI/hYr6Saq9bjsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560

Replace the hardcoded value 2, which indicates 2 bits for I3C address
status, with the predefined macro I3C_ADDR_SLOT_STATUS_BITS.

Improve maintainability and extensibility of the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- rename to I3C_ADDR_SLOT_STATUS_BITS
---
 drivers/i3c/master.c       | 4 ++--
 include/linux/i3c/master.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 82f031928e413..2c9d45486ed8b 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -348,7 +348,7 @@ static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 
 	if (addr > I2C_MAX_ADDR)
 		return I3C_ADDR_SLOT_RSVD;
@@ -362,7 +362,7 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 					 enum i3c_addr_slot_status status)
 {
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
 
 	if (addr > I2C_MAX_ADDR)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 074f632868d98..2fac4a45ec600 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -299,6 +299,8 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
 };
 
+#define I3C_ADDR_SLOT_STATUS_BITS 2
+
 /**
  * struct i3c_bus - I3C bus object
  * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
@@ -340,7 +342,7 @@ enum i3c_addr_slot_status {
 struct i3c_bus {
 	struct i3c_dev_desc *cur_master;
 	int id;
-	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * I3C_ADDR_SLOT_STATUS_BITS) / BITS_PER_LONG];
 	enum i3c_bus_mode mode;
 	struct {
 		unsigned long i3c;

-- 
2.34.1


