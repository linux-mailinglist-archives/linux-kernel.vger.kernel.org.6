Return-Path: <linux-kernel+bounces-374691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2259A6E94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C3A1F2181F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B41C7B85;
	Mon, 21 Oct 2024 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hTbxce0J"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2E1C579B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525536; cv=fail; b=iHVxKPbLCesH6Zg8KNqh5Fru3zM2DrXeaWyu2cLqWDw9y81GO0uA+huBMI6X0yqu9i/9+1Rl87EguFFFP0soqRWJN2zW9tNEKDQg0koeBocZh/MjnBcqi3b5X7OLQzAHqnZdx+eMOak0HW5wCR0omkw/STNGyqPc1rx6nSLtkws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525536; c=relaxed/simple;
	bh=pNrKcPmJml2hm0zxuno1cWhcRRjjWd0ga8g1A/LEMgk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rHKMJ2AUa6JV6i2WNH81HgwKtoevDMH+E+ftHIvj/QdpW8oOLmAMcpfHfcq+6wFoflsgWVnWpVfopcVjCNOfTMRL7eta7K21Wz5/XR9AEtsfpr2KSru606OGdOSM3TTMVd5u4FGJastiWTnn3+r2avxMTnPUk9+ybdHEnwuV0kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hTbxce0J; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVPBvWnN4f03pjM/Vpwg+GA6o7NvcyTKDHOmPuW1P0rhmMzkxkV9Ahspfo7C10OPd729dU/u/6g1pXu+XFzfEk9vYI2u66Lpo81dSwg17nHQywwHXBpx4KLA1fFkxIR0EC+uh70RZmq9NtAjNxAS0I4VO3nN1weGQFHQOagdhI3IF5+NRnn3NsRiPCifqMXQrgoVje/M1SFRYOXemFvDSBGXy7GU2wJdGiTUIFrrlXZZxbje8mdfxOcIsFU/fqsTR/9ZVOb1K8rZL+C/SXBjfYdPY/cxIlMLPGZNEpHQziqJPPyFCK9xYRYTtoSfGKXNbO/hhS5JTNj53t5sYwZRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMTfyhaF+NaVodvwbB990saGjE+IF+XIqt/Z40FU9rI=;
 b=b0hmdhjS8auuTJQuCOJqHMaczV98uckbYvAUs0muGdd0CZL964auy3xz4/vkqx7sQpdU9S377zG9OH/AGL/aCYDH1orIopKrirdFvSSNn3FTcYDvkCi+sNxiQQgs0Do2HaUF4v7Thf05BXori4PiNhqQlVGWuRc3Y0lJwbjJ/NmookXgO3N3bKQBgtcYRq5aIcfomtVNC1ZANugEseZwF3MNUSzQp4SjFuWe6XLwgWwGZJHMHbaFP7r3prtpd7gyKqPSJ1/bTgpj8oksN+WlwrGU0dr1zdkwPcWr/sc/8zjmHCsGQ2wUBvZb5FU1SKS9YmIoztwBA8CF7Dsi57Ex4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMTfyhaF+NaVodvwbB990saGjE+IF+XIqt/Z40FU9rI=;
 b=hTbxce0JKViYNIpjBAiQKnYk4O9npDjewlGjBSfdD0Wz+pQFs3MFYT5nMZVH6Y/fFEHq7WpErumgOLR7yqGlihEZBHBPHKtAqGXiKFr2w58CheHpja0XSP6nMAvYGmZMKD+zElvi8v0hqBRJE+RFZRWGExCs8bVHns9zhjPcaoW1NwfHOhM1gnx+i2PcoEWbeZKztThwEyRCN3wq0dVX0zhxBFIfaaoL+x1DKl/biaZjQc/HbYGLkWMEBTimeWFnRXP3Ctn2E65ZG6om+TtjB1K6h3/VlChgQWn7ZKpNtle+jj0QADtaH4FswB1UxUgwXcRvxtZcd9cLoeHZsXEM2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8417.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 15:45:29 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8069.018; Mon, 21 Oct 2024
 15:45:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 21 Oct 2024 11:45:07 -0400
Subject: [PATCH v8 2/3] i3c: master: Extend address status bit to 4 and add
 I3C_ADDR_SLOT_EXT_DESIRED
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241021-i3c_dts_assign-v8-2-4098b8bde01e@nxp.com>
References: <20241021-i3c_dts_assign-v8-0-4098b8bde01e@nxp.com>
In-Reply-To: <20241021-i3c_dts_assign-v8-0-4098b8bde01e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729525518; l=9603;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pNrKcPmJml2hm0zxuno1cWhcRRjjWd0ga8g1A/LEMgk=;
 b=4aVbOiWH+etVflChU66wmDLzYDpbmx2Ut2aqRNwQpQWs0BkSomMuwHjfeBagw/r1xJlcA8d7b
 bkV8ucFB1MPA8069Ggb1PTpiPFWbY0qtoAaYJ+HC3eCXnG3VqGgn/Rg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:a03:100::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: a838772f-7571-4255-6de2-08dcf1e763f4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aHZRT0ZZU1ArRHFxbW1DOTNyY1dzbVpKUjNaZmVld0ZWZmhnOURxazkraE1q?=
 =?utf-8?B?QUNtSkJ4RjRHeG92dW56WTZkT3NWL2hFc2Jtam5ySjdna0x4a01iR29qNkdY?=
 =?utf-8?B?MXBCaVVyZm54Smc3M1hZY0swZ1R0QU5xYWhBQzZrcXhxS3JLanY0dTljOStS?=
 =?utf-8?B?NFFjZWltWFZtdGwvcUFsMDAxL1RwUWJHQVBKTktRSG5VUGZReDM5UlVFL0RG?=
 =?utf-8?B?SXJjNW9ZVGRwbExlOHlDZGVsd1J1aFBNWjlPWTJuTEMrRklJRnphZ3BGSEQ4?=
 =?utf-8?B?TkpaRFlQejRSVXZhVmJxekJpdkU4VmgzT3FhejVaQTNzbDFhN1JpMklBejEw?=
 =?utf-8?B?WHNQaUhzTUNUVElpeHI4VFR2MW5sNEpYdG1TdEtzODRTaVYvRWhRUDNGR3dR?=
 =?utf-8?B?VVZ4L0pmNDNyVHpwdWthVTFqeDdWU1lPR0RKWWNOdXZWcHdpUThBcllaSFky?=
 =?utf-8?B?eVh0ZTlzQTdhQmVEcEpXOTFNUlA1Z0wwUDcvczhyNDV6eXRqVW1IRlN1bGVS?=
 =?utf-8?B?a1lwcXVJbTVLWlJ4YkV1K1VjZU92WUk4WVVoMEtrUEFkOW84clV3aTFpRy93?=
 =?utf-8?B?UkNRUUhwQnFHSDByWGRybEhNdWRoclAvVHlhU3hEMU9mZFpUZXJRQ0ZCdm9E?=
 =?utf-8?B?KzdTRm5PaWIrL0tSQmNaUDREVzZCc2Y4N01UOEdwek51dEJRaWo3OTkrM3Na?=
 =?utf-8?B?NnFoZC9sRXp1d2ZZRmNSYWFab2UxSGxxY3N1WHo0dzZxTisrV2xyK2g0TGow?=
 =?utf-8?B?UXlGdm9vdjdZUnNxU0VuSzBONlNDUFg0UFJJanNzSDZNQ2RpMHFVRDk4YVdl?=
 =?utf-8?B?amo2a29HM280YkE2Szh4NnJ3SlZNcERmSDZYY2RmUEdGMFRxc0FTdXVaZjJt?=
 =?utf-8?B?dXo0bHI5OVhPYnYvY2djWUVNNnRTeG1NZ2lUbEtkSHNDQXZtNXVhQTlDb053?=
 =?utf-8?B?WTlaanlOVmZGU05hS1N3RVMzSmJOckU1amhyWHQ2c21nblZ0RjV1ZVhkbk5Z?=
 =?utf-8?B?cXNJT2MxNjdtS1lKeEl5TWFMZFluZ1JncWZNbGVUbzlCVytFMnpPeURicmp4?=
 =?utf-8?B?SG9pK3NWc2loNU5Cb2ZWMDRBOU9Md3U0M28vNFl3YWxxMWh3Mms2SlRWcTZ6?=
 =?utf-8?B?LzIybVpMc29nVnBHWDZTcHUzS0dNYS9JUXZDajYxWTRlQjNCeDdPZ0tIYXQ3?=
 =?utf-8?B?UnpTQ3ZoL0NhcnVueVBTb0tRWE9KdndYbmR4RVlEVXVEMkpiSUY2ZGEwUm9z?=
 =?utf-8?B?L2YzVW81UXJQcXlMZjhjQmtNeWJBSG5ZRjJRZ1g4OEQzOENGd3JTZHNJQkpa?=
 =?utf-8?B?VE41QzNmWHBRS1MrSUYrb2x6eTRWSHVrL1k1OWZBQzZUWmErbnkxWE1NWTdw?=
 =?utf-8?B?blBBQ214bGFKUWZEanJkRWE3SXpSSGVKMmNPR3k5a3Fpd3lnUksrcFVWcmk0?=
 =?utf-8?B?MmNBMXhiVDdRbTM3OWJTSWRPcHM5bm80ZHpyVjg5b2pKOUNlMGlqMU9TY0Vn?=
 =?utf-8?B?R0hmTENjQzE3ZGZiU1Q0QzFpbmdMUDg3RS9SYmZiMWRsQVFpdWRHTlVrRW5y?=
 =?utf-8?B?YjBid3hLZ3FkQmYyRnBYaFJlVUhndUZDanZqMnNnQjd5UlNTdFovWnZvcFlM?=
 =?utf-8?B?b1FRbjgyLzZ1Tll3bnRKUEFhVnp3MExsUkRRSkpSUVNWak1mbXlINU80ZVZp?=
 =?utf-8?B?RndiNFBHbTNZSE5VbGpvZ2NvYUI3WkdjN2JrdTRCUkgzd2ppVkUrU3hIUmNT?=
 =?utf-8?B?WTlnWE4yQ1FEMm0xQTcwenNzQ0ZnbStkZml6NjAwZWMvVXlNSEFmZ1hMTklX?=
 =?utf-8?Q?3W8N7qiji1owyM+Mc27CxQTlCMQle5X6uzTXY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MGZQZmlRcDRieU5PVmxpeldEZ2xiVmdLZVV0R1l5cVhXUng0bmZRRUNJVmo4?=
 =?utf-8?B?NVFyNllTRGJCanpFeHBOT2hYRWY4bTZJWTY2Q0VVang5aWFidzdyOUhVK1gv?=
 =?utf-8?B?MStQbHpJRkU3OVNkOWs2WjlBNUovMDlqVVhIQzk2aDYyYlZQdWx5bTk1RHcr?=
 =?utf-8?B?WGM4WWdxbDk3VndGMjZLcnhiKzhDNDlkYmJabUtPM2pmSjFZdnNFSlVvbklp?=
 =?utf-8?B?Y3lDMDNrKzZTeTVzSHZrUW8yUXNkRFYwQjROeHBOd2NJa084cU9rNXlPRGQ5?=
 =?utf-8?B?U1IzM2Qxcnk4ZktMQmRhOVhndEtnM2tZeS9xWHBvckwwNU5USFBOVG5GeTJl?=
 =?utf-8?B?cjRpZkZxWVU3SGcrYzYrYUErRS9wR01LdzFGb01uVEVRV3FTeXZ3Q1hEam9U?=
 =?utf-8?B?aWpxRHdkcjR0TThrY2hFUEEzeHJkK2xBRGRYM1pCQStFNHdDbVNoRnczaVVT?=
 =?utf-8?B?SjNaL0V5QVl1cjNGZGZxeXdJU2JLS1JnVjZJZ2p3SFFORmFQcGRmdUFEaDhK?=
 =?utf-8?B?eWxvRzNKOCswT1NkRU9McXZxQnZLbzcrb2Qzd3JYN2Z5N0hpTlFXb0J5Snhn?=
 =?utf-8?B?N1lEWWZacm5FYVl4aGlESTdkK3I4aVh3dXl5b25FRll4RjYxOFJSbWRRR0xq?=
 =?utf-8?B?M1gyWFhIaGVRRjZhYkhrb0d6S0J2bllQYXV3bDRlblVSY0p5MXdSUU9nMzZq?=
 =?utf-8?B?ZzIrZCtXVTFweHRDUXVHTGZGSnc5M1dnalVsYzJtcXV5OFhSTDJVL3kzSVh1?=
 =?utf-8?B?TWNseTZ4YzA2ZWRheTZTM2tKdDNiOTNOd3lEeitxWFV6VjVGS2hMaFBIcEdO?=
 =?utf-8?B?Z3M4TU5NRXhpeWdPNUFMa2EvWGFhbHdlRUNrci8zTlJnV1gvYUxzTkd6VkJv?=
 =?utf-8?B?Ym5BNTcyMmVKWm9qdlZ0T0pNTzIxZzNXY1B6MEFrU2dUd3MzWHdyM3ZJUkMz?=
 =?utf-8?B?b3BQd0tnZWFQMUlGbUFsY1dkb1ZTSTRZa2hCc25aR1dmNmMrM1pkdWZUODNw?=
 =?utf-8?B?QW55Nnd0ZkIyNGdSSERCS3dVK3JPdlpHa3pXT1Q3UXNvZlNpUklNK3B4T2ZF?=
 =?utf-8?B?Z1Z4VEJzOTBrdmFsdzViMkE5SjE0akp1VTQrUXlKNmJ0ckNmNG5MYklaRmJs?=
 =?utf-8?B?d0ZJblg3TzQ5KzJEL1VybmR0VDlQNXRGUVdHMktZeXNRcTlqdHlRNGxJTnJQ?=
 =?utf-8?B?T25QUnp0dHY1NTBwRHl3cE9ZUXlkdEswaGFLTVpyQVJBUVFSK3lnd3FwM21K?=
 =?utf-8?B?a0VhTGg2ZTgwcmx3NFppRVg3VlowcjBReS9lWE51bC8wWHpnVlduSWVEakhP?=
 =?utf-8?B?dVJCR1JzMlFEZm9Nc0wzVUZRdVpETkhPWW55YlFOTm9HS05yaVVxd2t1UEMr?=
 =?utf-8?B?cFNtczYyNlBJMWUyRU5GVkRCZEhKV2ptODlEc2VnbzJKUENMbVdUR0ZTTTNP?=
 =?utf-8?B?Nk0yMEZrN2IxSVlHWlhnOHVYMnEzQ2ZwN3BiRWVCMGtRTXdMV1c3cndwcC9u?=
 =?utf-8?B?TDRNRGJ0elEreHBRWnRGQk5QUlFpaUZ2c05hR1lUbittOGUwL1hlblduamNU?=
 =?utf-8?B?Zkw3QnI4NXZrNG1yK081bko5OUVMemJWcW5NWW42Ty9hTGR2UEJ1U0gyZHpV?=
 =?utf-8?B?Z000YUNyV2ZlU2YzU2lpY1JvMno4TDI3SGNDT3hSNUZ4ckNKcHRoTzROWTFY?=
 =?utf-8?B?cGcwbW02LzFjdFdCbFJ3U3VwQ3UveFBPbnY4TENraGJXSlZVM1RhYThzWVhr?=
 =?utf-8?B?dWlCSGw1ci9IdjBwbnBxbmNkcnpOSFZHNGx4T2dTc0w2c1VUWUQ4SXNwOTJz?=
 =?utf-8?B?TDdwcExWMlZuZFpmMnkzbVd5VG5HdzNCTllBejRWWExyRTFONkRNOE1HMUNu?=
 =?utf-8?B?VmdGRmFIRXZnUndmSXFUWE53SUZWdk9YTEM2NXY2dUpRQmpFWDhTQkhSZEJK?=
 =?utf-8?B?UWJSWWtzdldmN2h3QlZ4TkxxeklTRlUvZWxrUWVSKysxZ09MVit0ZTlIUjRI?=
 =?utf-8?B?WVM1bVBrOURWS0Y5RTUzUVZqZFRtUTJDM1MxbCtaNFNqb3FGU201K1lFeGpD?=
 =?utf-8?B?VHkxbVFSdmpoTS9mMERHNFJadVZ6ZUxCa29TdWtDL2lKdTliaGlYZmJsRVgw?=
 =?utf-8?Q?/F4v+uEKmyk1WwQC7wI0BpmxR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a838772f-7571-4255-6de2-08dcf1e763f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:45:29.9071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1r52cCXSSLarksp1LgaqTPX57g493gwhR0AsQV8FscRKkPBU3fOXaDJxEvJ+3iUgAMFyD3gqqk0FQrLp7gvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8417

Extend the address status bit to 4 and introduce the
I3C_ADDR_SLOT_EXT_DESIRED macro to indicate that a device prefers a
specific address. This is generally set by the 'assigned-address' in the
device tree source (dts) file.

 ┌────┬─────────────┬───┬─────────┬───┐
 │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
 └────┴─────────────┴───┴─────────┴───┘    │
 ┌─────────────────────────────────────────┘
 │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
 └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘

Some master controllers (such as HCI) need to prepare the entire above
transaction before sending it out to the I3C bus. This means that a 7-bit
dynamic address needs to be allocated before knowing the target device's
UID information.

However, some I3C targets may request specific addresses (called as
"init_dyn_addr"), which is typically specified by the DT-'s
assigned-address property. Lower addresses having higher IBI priority. If
it is available, i3c_bus_get_free_addr() preferably return a free address
that is not in the list of desired addresses (called as "init_dyn_addr").
This allows the device with the "init_dyn_addr" to switch to its
"init_dyn_addr" when it hot-joins the I3C bus. Otherwise, if the
"init_dyn_addr" is already in use by another I3C device, the target device
will not be able to switch to its desired address.

If the previous step fails, fallback returning one of the remaining
unassigned address, regardless of its state in the desired list.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v7 to v8
- Add Miquel's review tag
- align to (, fixed a checkpatch.pl --strict warning

Change from v6 to v7
- always use i3c_bus_get_addr_slot_status_mask() in i3c_bus_get_free_addr
- ((unsigned long)status & mask) in i3c_bus_set_addr_slot_status_mask()
incase status bigger than mask;

Change from v5 to v6
- fix version number, should start v5
- change to I3C_ADDR_SLOT_EXT_DESIRED
- remove _ext function and direct use _mask function
- rework commit message and comments according to Miquèl's feedback.
- change mask type to u32
change from v3 to v4
- rewrite commit message and comment for i3c_bus_get_free_addr()
---
 drivers/i3c/master.c       | 65 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/i3c/master.h |  7 +++--
 2 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index dcf8d23c5941a..1bf9cb138f77f 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
 EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
-i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+i3c_bus_get_addr_slot_status_mask(struct i3c_bus *bus, u16 addr, u32 mask)
 {
 	unsigned long status;
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
@@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 	status = bus->addrslots[bitpos / BITS_PER_LONG];
 	status >>= bitpos % BITS_PER_LONG;
 
-	return status & I3C_ADDR_SLOT_STATUS_MASK;
+	return status & mask;
 }
 
-static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
-					 enum i3c_addr_slot_status status)
+static enum i3c_addr_slot_status
+i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+{
+	return i3c_bus_get_addr_slot_status_mask(bus, addr, I3C_ADDR_SLOT_STATUS_MASK);
+}
+
+static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
+					      enum i3c_addr_slot_status status, u32 mask)
 {
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
@@ -369,9 +375,14 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
-						(bitpos % BITS_PER_LONG));
-	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
+	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
+	*ptr |= ((unsigned long)status & mask) << (bitpos % BITS_PER_LONG);
+}
+
+static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+					 enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
 }
 
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
@@ -383,13 +394,44 @@ static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 	return status == I3C_ADDR_SLOT_FREE;
 }
 
+/*
+ * ┌────┬─────────────┬───┬─────────┬───┐
+ * │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
+ * └────┴─────────────┴───┴─────────┴───┘    │
+ * ┌─────────────────────────────────────────┘
+ * │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
+ * └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
+ *    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘
+ * Some master controllers (such as HCI) need to prepare the entire above transaction before
+ * sending it out to the I3C bus. This means that a 7-bit dynamic address needs to be allocated
+ * before knowing the target device's UID information.
+ *
+ * However, some I3C targets may request specific addresses (called as "init_dyn_addr"), which is
+ * typically specified by the DT-'s assigned-address property. Lower addresses having higher IBI
+ * priority. If it is available, i3c_bus_get_free_addr() preferably return a free address that is
+ * not in the list of desired addresses (called as "init_dyn_addr"). This allows the device with
+ * the "init_dyn_addr" to switch to its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise,
+ * if the "init_dyn_addr" is already in use by another I3C device, the target device will not be
+ * able to switch to its desired address.
+ *
+ * If the previous step fails, fallback returning one of the remaining unassigned address,
+ * regardless of its state in the desired list.
+ */
 static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
 {
 	enum i3c_addr_slot_status status;
 	u8 addr;
 
 	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
-		status = i3c_bus_get_addr_slot_status(bus, addr);
+		status = i3c_bus_get_addr_slot_status_mask(bus, addr,
+							   I3C_ADDR_SLOT_EXT_STATUS_MASK);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status_mask(bus, addr,
+							   I3C_ADDR_SLOT_STATUS_MASK);
 		if (status == I3C_ADDR_SLOT_FREE)
 			return addr;
 	}
@@ -1918,9 +1960,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
-		i3c_bus_set_addr_slot_status(&master->bus,
-					     i3cboardinfo->init_dyn_addr,
-					     I3C_ADDR_SLOT_I3C_DEV);
+		i3c_bus_set_addr_slot_status_mask(&master->bus,
+						  i3cboardinfo->init_dyn_addr,
+						  I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
+						  I3C_ADDR_SLOT_EXT_STATUS_MASK);
 
 		/*
 		 * Only try to create/attach devices that have a static
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2100547b2d8d2..6e5328c6c6afd 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -298,7 +298,8 @@ enum i3c_open_drain_speed {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
- *
+ * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are preferred by some devices,
+ *			       such as the "assigned-address" property in a device tree source.
  * On an I3C bus, addresses are assigned dynamically, and we need to know which
  * addresses are free to use and which ones are already assigned.
  *
@@ -311,9 +312,11 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_I2C_DEV,
 	I3C_ADDR_SLOT_I3C_DEV,
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
+	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
+	I3C_ADDR_SLOT_EXT_DESIRED = BIT(2),
 };
 
-#define I3C_ADDR_SLOT_STATUS_BITS 2
+#define I3C_ADDR_SLOT_STATUS_BITS 4
 
 /**
  * struct i3c_bus - I3C bus object

-- 
2.34.1


