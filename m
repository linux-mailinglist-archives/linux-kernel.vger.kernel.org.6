Return-Path: <linux-kernel+bounces-257975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA49381A5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 16:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61ED21F21FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CABB1474DA;
	Sat, 20 Jul 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NdVPzBNY"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022113.outbound.protection.outlook.com [52.101.66.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEED143881;
	Sat, 20 Jul 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721485180; cv=fail; b=riqzpdpsGRa7tFX3WU1/2y07NeAM07aA7REYAjakawvTqmPU8h0YGFWfoLfkODtXfUJh0IsNdlJ2UMwTz0Heryg73Aizipc67/Q0/DznjMjKiEpZRfhDf1EjCI7Wqh9vKGZ2ctLY5ENsh9+mJoMLXcSsRepqvfKz5lFP2a7N9b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721485180; c=relaxed/simple;
	bh=CCH3BIUdpki/GJE0FruzZIybWJW8f6SeAvR2dRDpEP4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Fs1E7Li/+H/JmVnp4hbJYTdSB3cpsB4enzlAXgLsw6shR9iBtqM01rZHje59P5OVkQchTCI65DsuUfkQBVD0S/7Co0OeIBPcebgT2MGfUpndJoW5MzFiot59JuPK85MOZcKDmfnxurGvdWuJ4BXXU8vY8dPgVoFt2L3BJJZkxr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NdVPzBNY; arc=fail smtp.client-ip=52.101.66.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAZmbpe5kBmZ4QaMLCSfmeSO9dyzh7+cynauOpx1R6O3FjPE1mjBibjm1YGd+oUDi9Uw3hpK763i5HQla2pchtQW3HiQ2WDTRJ+tx9+67L65GFVlfCxBPBxLc0ArXvT+UcBeOOhNSr1nyciCLolArz/EqambeyAp7NSK6BlUaPawH3mBjCFNI1olXsx9LBzQbUM0d7ArUyOKOaFAM7mIhmCfgFjqhGy7/gBnEL2iaJEgLjlI3QYXdyPOJyO0niVeY9Q4heu/yW10h2ZlDuF/XIau3f2/9gMVzMNxH+l8kUYYW8tm7xEu91lZeCStg1ZBa2ijCKo3p9g3WJwQcXVoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU70cVt5TQ5Mtl02MOOY79Kao47DIajLN32OmrL/LLQ=;
 b=rvv+RE/3kKmfSs6xXFdVkJzGdi4HE1lhrDD++c3IsTwBC4jKAkKPHuwPzRRHeqH2v1iMMEsodEOkm3UA8ukdnc4N4VH/RXYN/xY2J0kF28AbP/ZSoWus1bGCF+EE/hFnoIOZu4R5wD4EwUNFG0Ew+fwakk6Bxhk52yaec7lPet877X2QBEuKUQ37g7/nd5wJWNUKfll04WwbdsAjsIoZ2io/G0cdghdX+wDhRjM7MTYlGGYYmFhbXy4vfybKgv84sbkEW2cbBn1ohWCORNnhoN/IGs1GronhP6MoiTxSZIt0xNDM2rgjf9Sg0rbLs2wF0JGbhszxKvTiS+2Hnm6Whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU70cVt5TQ5Mtl02MOOY79Kao47DIajLN32OmrL/LLQ=;
 b=NdVPzBNYQG9Lpvenv3NfMP8U7Qyf6a7hmUmuqiCD4OA4mBnewaCrNBWUIJT1cM935gVu6fUrJiWbZdNf44kAjnE5kCdwcqOUCtkXkQgbXYbQETBAEBxs0Jx5zilv7/5bLYNCk+mShKnRWZvKCXk/L1FoeCpG60HzV/wwFXmfAcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI0PR04MB10299.eurprd04.prod.outlook.com (2603:10a6:800:238::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 14:19:29 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Sat, 20 Jul 2024
 14:19:29 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 20 Jul 2024 16:19:21 +0200
Subject: [PATCH RFC v3 4/6] arm: dts: marvell: armada-38x: add description
 for usb phys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-a38x-utmi-phy-v3-4-4c16f9abdbdc@solid-run.com>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
In-Reply-To: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Konstantin Porotchkin <kostap@marvell.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI0PR04MB10299:EE_
X-MS-Office365-Filtering-Correlation-Id: 47450bd4-fb80-4c79-271a-08dca8c6f7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW16ZFU0ZHVlQUhXTmN1UWQraTNRRGwwaGVqZGFsbklERmp4SUNhNGxNS1o5?=
 =?utf-8?B?U0dHSzRxMkpsR2F0bS9nWHozU0V3YkdLdUxmQnEvVFBTVXFOY2tET0VUaTVV?=
 =?utf-8?B?WVVXVWc5MTQ3UXkxR2hrTGZldlFNTHVVdER2b3g4VFM1VU9zdWVtcDUrYWtM?=
 =?utf-8?B?WnJtZDYwOWdWc1dpOGV1cmJLZWx5Q25HMThGVGFTRXZXN0FTZ1JwcVNBRVJJ?=
 =?utf-8?B?bit4N0t1bEF0SVFubnV2cTlESzVpU1BRL0sxbWJOc0xsaG1VUTNFaUd5d1p4?=
 =?utf-8?B?cGN4QjM4ellXaCtIRkhCTFhmdjF4QVMxcUJlRitnU2dEWlZnMXVsU2dYMWNo?=
 =?utf-8?B?S0VKNi94TGQyRkNiWHd2Y3M2bGYyWmJ1aGZCbWFqVVppRDJMK0I1ekVlelF1?=
 =?utf-8?B?RnN6cnQyakxTd2phNnN3dUpZcmNUOHVoWTVtZHUxenFuTDk4QzlUOEF1bUs1?=
 =?utf-8?B?RnRINVN3NlJSQVIybHJJSTk3OVN5SmJUSExHUmhXNWFIbGY4bnJvWU5MM096?=
 =?utf-8?B?YTBia05lWUJzRHl4R2FCTDRaN29lSGJ4dmI5aWwxUkdOMzN5UzV5aUNCeHpP?=
 =?utf-8?B?TXN3SXhvaE1rWlNzV0plK0xlRGQ5bkZWa0FUWXlzeXhyK0ROV0hnRGVHK1BS?=
 =?utf-8?B?ZkVjWlh2R1I5bFlWdVhEcXRnbExoSHFrc3lIcDBUN3R4MFdKSjNJUVBRRVY3?=
 =?utf-8?B?UVR6OGZXWGo0N1drSFU0dGV4MnpVVDRxZTF4WWxCMWVBYUYrUzVmYmprc1NI?=
 =?utf-8?B?c1ZnU1ZTUEpqdzE3TWp4QU5VZ29DaDltTlVxSXBsd0Z5MkhzMUg4YlRUd0ww?=
 =?utf-8?B?VVpyUXBjZUI4cEVGQ0c1UndoLzZ6WnZ6cyszaEk0bGpPd3VpN1N4d2RuSC9p?=
 =?utf-8?B?Z21UbEx4YWJwdG1TVnhmTy83U2NIWE1MNG8yZlBEbUV0TG1xNEorK21XenJS?=
 =?utf-8?B?QnFTTFMrcjJLV2pBYXpQeURpNEl2TVpmZ1pCajVIT2xWd1pyYTE1TUpLNnVQ?=
 =?utf-8?B?TmhXVGFPUjAxY2tOVGZQZXV1Z3p1b2hkcmlCVWdUNHRUN1IrTU0zRXhnVW5w?=
 =?utf-8?B?Qm9JVmR4eVB0OUFDL2dpdFJXSmltQkZ1SU92d3hzeDNscWczQ3EvMHdGYnZ3?=
 =?utf-8?B?ckgzZWlweDhCa3JsMVdGZCtxU2xTQjV5clJTRloyVlRscS9Cd2dORTZ6NEJQ?=
 =?utf-8?B?SFRXV21KM3IxZXZmRU41U2FtU2krL1NKSEpXL3ErcEptUG5VMUpMZ2xTVDJW?=
 =?utf-8?B?YnNPajBUTmI0VzExeHVXR3VMTmxYM1JmNXlVK05oTVNxQnp4cUR1NG4xcUQ3?=
 =?utf-8?B?bUJoY1dSNm1QWGxkYzVtemR5YjVDTGh4TzA5bnM4VHF2NVpySEdMbU1qdWZ4?=
 =?utf-8?B?S25iYjhpTHNCajVtU2R1OXVncnI2NnUweitHOUNFQkU2eEVmWEdwWjBuelhS?=
 =?utf-8?B?ZXdRd0FNdnFDOC8rSnZPNXljMFRzRzhoTjZ3ODl3RXM0SnhhVUpsTmNJZVRk?=
 =?utf-8?B?c0NScDBoZ1BiZTYveFVxWFhqQ0JldHVlS1ZTUGZ0ODI3eVdTY3drQ3JIN25O?=
 =?utf-8?B?WDBkanQvRUcrNjNwUUdpdVhJbk5VbE1IekQ4VHlJaVAzQ0c0SU1RRFRjR0ZK?=
 =?utf-8?B?azc2SE4yRWQ3eHN6THNOM0hWZnZVZ2ZNbEpUaHdLcWp6Y3lVd3IzcFhuU0x5?=
 =?utf-8?B?QU5lNFloV0lwczFaYXZPb1hHaml4VldWVlpsQWpKU2lTZGh4ay9JRUtSdnFl?=
 =?utf-8?B?TEE1ZEJ1Y2JsYkxrcVk1TGNPa1RBdWkxcXFJSUZQbVQ2eEpDWkNJUUQvZW51?=
 =?utf-8?B?ZFAwZG00YVBHRjBySjAxdGt2dlE3bXFBem5FLzFPZ2lsQ0xaSDNJNFFLNEJm?=
 =?utf-8?B?MTV6SGQwYU05WFM3U0pWb1cxeldNQU5BazBDNlNwQm9Tb0dqNGFTR0RVU1VQ?=
 =?utf-8?Q?/MTACoWLjyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXk2YlhvV2lHNkdyQTZTUTZzczBSZlh5Qzd2TVpPa0IydjVoaDNNenlCMkJW?=
 =?utf-8?B?aVRSRkZqWm5URHEzZXJlZ2xUeDMyVUdzb0I2OHZHeFh5eG1JeGtIU3NQcjQx?=
 =?utf-8?B?V3BLNDZqV3EzN0ZndHRDaXJyZ0VjYkxFc1h1cmNoTjJGYVA1bE9GNGlXOGw0?=
 =?utf-8?B?d1gxM3hzaDNJcGVySTN1M1Z4RG1lbjZyVUxYZXVINUlvWitZYTdLWHZXM1Rn?=
 =?utf-8?B?K2dsNmtXM1BBQVk4L3l2aEFyT0xiVmZGYklEaG0rbHh2dXdsNlZlNGNTMHBT?=
 =?utf-8?B?eE1HaXRaWVB2QVBvUnhBRmhleVI5UFBmc09US1lVcityUnlCcU1Rbm9OYnJq?=
 =?utf-8?B?anpLZ3QwUnJWNDhQSko1Z3JlU3pPUkFaaWlzYU9tazg1QTd4dmFOalNMcEYx?=
 =?utf-8?B?YUN2WlphRUF5VUdqdExjaEgrZmw1bHZIL3RSL25ZWStSaGNnS2RZY2ExTmt4?=
 =?utf-8?B?U00yRUIvUXF2UE5mZkRHODFGUzdCN251bi9icHB0NXpzandlWHZqalk1ak1a?=
 =?utf-8?B?bmVvSDNEUWVVK3RibnNRY1pta1Zpa2RPSndiNG0vWjl4elFXa0VCNkdzeTl5?=
 =?utf-8?B?dklUNXc4Y1NpaE5nZmVsbTdrWnpua3dFaTE3OE5UbE1paExSYU5QVURrNHFt?=
 =?utf-8?B?Mi81SlZMTlI4UVZUMkhiT0N0Nk05VlV5ZG0xWCtRWDJ2WHpRc0J1RXI4Ykx2?=
 =?utf-8?B?Qy9WTkpRdUgyd2tVeU9WNWtQWFZZZHVrSlllcjhyTU5wanU1VzF5T2ZQVXUw?=
 =?utf-8?B?NEJOd3lzVHZ6eDhOMjVOTm93ZHU3NVhGbmE5WGpkVWlwZC9YOXhsSUJBaDlN?=
 =?utf-8?B?TlAxYk9VckhRbVBIUjV4ZElHSHdQNk9PY2NQcWNSWGUwbTV3UUVDSlUvK1RJ?=
 =?utf-8?B?blMyazYwR29ma0t6c1FDMkJteWIrSktmTFNtWllCZE1KV3hSeVQ0WWhuNXU3?=
 =?utf-8?B?bGR3c05nUTNqNzc1dldyS3hYZytSMy81WUFBWERJcnNEK3BJUU4vaVJjUm1v?=
 =?utf-8?B?Ym11bSs4aGlSZytVRmF5VkpoRXR4THNsTllVQ3IvUXI1Y0tVdmhtMkdsdHpL?=
 =?utf-8?B?blk5RUNIKzBwaUZBNDc5RTBmM29EV0dWU0t2TEpZa2NmL21LemhzOHUzODVk?=
 =?utf-8?B?ZEtRUHJJTWVVcTdhYlBDZ0JIMFhJMmNGVnhqU1hKTldzd0tJamwwaDNsZTdK?=
 =?utf-8?B?L0hZMys3RXU2L0NoSTRWdXVDVW1BYzkybDQ4V3JqMkdwdnBBbUMwaWYxYjZm?=
 =?utf-8?B?V0NMWWdmR1RiZUJWcUlJOGdrdFBCRUkvcGVWalo5SVZJUEV4cGtjQ2M5YkpN?=
 =?utf-8?B?aU1HYTJWMDYvSUpBQzU1K2REb3NPVURXK1lZM1dtWm8wRzd0eHl4aVcvQ3M2?=
 =?utf-8?B?MXdxd3g4R3ZGOTlMWHVqSEFSY0E3c2hZUURhYWFiV25kWG1EN2ZldGpVTEw4?=
 =?utf-8?B?NEtsQkx0U0FHb1pUdFNiTmlHSXRoS0cyMjVXSWZES3RnOU04ZEZ1a0QxQU9K?=
 =?utf-8?B?bGdFYUtpQVUzZ1hEeHltU1F1ekZOOGFqVzRCaUo1OVZDKzJNQ1E3KzVDVlJS?=
 =?utf-8?B?VXdqVzViUUdVY2lEaEhVblp1NG9zMnRVV3B5YXRFWCtqQ1ByN1RObWZEZ2Zq?=
 =?utf-8?B?UkliODNoU2R1UWh6NE1kWk5tSGtsTExydUdCSTdhajF0YWRjMVg5VmFwczFi?=
 =?utf-8?B?c0tEZ3J1TUpNUmlmR0ZlUFZZNUVGZVJFbHB3azNnWjEycytEWjlxRkpOSUx2?=
 =?utf-8?B?K0pPK0NKMjRsMzNrMkpUQXRDZVlDdkNpeHZwYzgrUTVvZ1hmU3ZYUjZjMmx2?=
 =?utf-8?B?aTVhdGpWR2FwRWNUWWxWUXVleUFjVzhGNU1GRlBXZ0JOaEdDNmVoR3FUVXhY?=
 =?utf-8?B?L0JiUmZwTVEzaHBHOWc4MnJUN25wREMvVVpWWWJYVDRLVHo4VE9wRlBvOUg2?=
 =?utf-8?B?eEJOOWlzTlBKbVl0bG5ZeThZV1RUNlZPZEpyZTkrcE1GYXY2b3hiaFZCN0Y5?=
 =?utf-8?B?UEUwaVFxMnFoejg3cnk5b0M1K1lTa08rYmUvakgrdUxPazNCMUJLTENDUGE5?=
 =?utf-8?B?VWpxVFdkQ1BETXRhSVVaeDdxWFVUVW5yRW5aaVhNZzE4SDJkMExyUkttQi9F?=
 =?utf-8?Q?9TNfFGy5h8HUP6bb4h5EhIUJq?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47450bd4-fb80-4c79-271a-08dca8c6f7a5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 14:19:29.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2X9iE+zeB84/EX4NI1795kxmnMXLp0eFDvIZ5E5CQ7ATfNbkt351m+Yo9R5g5hlTZzoSlMmF9vvhUNo1KUR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10299

Armada 38x has 3x USB-2.0 utmi phys. They are almost identical to the 2x
utmi phys on armada 8k.

Add descriptions for all 3 phy ports.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/boot/dts/marvell/armada-38x.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-38x.dtsi b/arch/arm/boot/dts/marvell/armada-38x.dtsi
index 446861b6b17b..9c4b5a9817f4 100644
--- a/arch/arm/boot/dts/marvell/armada-38x.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-38x.dtsi
@@ -580,6 +580,30 @@ ahci0: sata@a8000 {
 				status = "disabled";
 			};
 
+			utmi: utmi@c0000 {
+				compatible = "marvell,a38x-utmi-phy";
+				reg = <0xc0000 0x6000>, <0x18420 4>, <0x18440 12>;
+				reg-names = "utmi", "usb-cfg", "utmi-cfg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+
+				utmi0: usb-phy@0 {
+					reg = <0>;
+					#phy-cells = <0>;
+				};
+
+				utmi1: usb-phy@1 {
+					reg = <1>;
+					#phy-cells = <0>;
+				};
+
+				utmi2: usb-phy@2 {
+					reg = <2>;
+					#phy-cells = <0>;
+				};
+			};
+
 			bm: bm@c8000 {
 				compatible = "marvell,armada-380-neta-bm";
 				reg = <0xc8000 0xac>;

-- 
2.43.0


