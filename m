Return-Path: <linux-kernel+bounces-311043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6F968440
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842BC1F23A00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100AC13DDC3;
	Mon,  2 Sep 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D5Qu+SWM"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345C187335;
	Mon,  2 Sep 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271862; cv=fail; b=BNNHJ2PUQn/DMKG7hQ4WnqiDL/pvamjhZDENceczWH6e8IQczKgUOzauxc4TNdRlQWoN//9ahXsIor6rtbScWPduzn8t8T8LTRum4weXEdXNl2Zjd7PbV2KABJnL/dEum++vbNM3Nryj91mRdNFUmklR6lS1uqn6ubRlKvNLsRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271862; c=relaxed/simple;
	bh=AOW3qJIK3PnIJkBgDHPLbX9ja3EsSAXc3rFMnTlymAg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XUQ9f1GTJvTF8qEp6tMyNIYIGU4UDSwWtLfVQhJn720FdIbaQxhDVzDgj7mEKZSkfa5x1ag/htWWPc/SwRm9WVsncfKEypMrh6QkazplzD8BO675itZtmmAuEoznq/QJFbKq6yZZbT8RbQY5eybuK1hbg9TawLUNBbSqSXcuWdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=D5Qu+SWM; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgF6H1Dec/rOmE6ghxq90iHAnfbAmyfv34DeBVVEHrpaffgjZaL1oalWiOdigYdFC0s94Fy0uoZynQG8miV8NkxjFCreJiBuUDJDbRWFhGwrl3KL3+PQTlkbZ+QrWng/grB70K15zsMqczMnreUu4GzwoI/S1jeDwjbO/SNaN1C64z5LfE8RUcf8IAJQ/TM7xtkppJXnqwRWurMt4kb93O2WLmEyX8pgCJceGFdMWnEiqP+XYkUrtInqcQ59ebN8aPJHEaRQ3OPoA+X9DuD3ZVHEXw1UBYKCZELKXlk9dr9K+6kaO+IdlisE0eu9gcztIHLD31i+qpFlGocmmL0oMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Q3gOMGagIDtU+Gq4rLz3OCK4s4M2hs8o7OQMkyeF8=;
 b=uzAEKeNWFjT9BZ+lhEyNwNH7n3sTUl0mMRrDSRbDsgcpevfcsVT2gZymAkdaW3v4CgejVatuUKGU4pX+ZftT9pM8aYobhbsm2OXpUVIPrj0KZOI/xLQ+1twAv01aV5bBTT5J4bTcu2XBD4Y+HIsLJXrWWoAexZ1we5Iw1D72eAZHV9ssgd3e4xSunTEmvKx2JaenOOHPij77vmmdK3mcY/yS5q6MBwk7CPSxeEY+2bbAV1fonbA/mFUR1YVD4mP2mUdMpflbR+VGKSo7FYaUdhvyzviL3iEPEH2Qv1EpQwGqV/fmiafGKFBufDqFJD4hxZBI6VYHM5p8sFHmMSN1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24Q3gOMGagIDtU+Gq4rLz3OCK4s4M2hs8o7OQMkyeF8=;
 b=D5Qu+SWMIRfnBEFBTDfjn/qtt5ktyiaI6uY3d+NzaJhkj3RFOmv2GqGlwJepr4LKMJ07b3AeT+HKfpNyR+4uMCKb9YKCUIljRU1uG7xs5tN+uMTurO9vjTAdRYTXSu643w2cN+oRUtDsdQoFetBcdsUmMxiDOBUk3l8dzia1xUstVUWiCFDLU8IEt8ZRFmprUOcB7pESpQ55CMwDh4JUuqnyA40BD0pDOZjGX5NwRN+QwoSZLacOevbfljk9BaABAC60KVUf/bqa41qD1R6WF7Toikgt1fC1WduSWNv7ulmVS77mZ3WR1evSrz/otntvsPNMXVxBOhPYHMUfRw1ROQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 10:10:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:10:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Sep 2024 18:19:28 +0800
Subject: [PATCH 6/7] arm64: dts: freescale: imx95-19x19-evk: add
 nxp,ctrl-ids property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-imx95-dts-new-v1-6-a1f798f4f746@nxp.com>
References: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
In-Reply-To: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725272374; l=1405;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pJSS4nFlbHegGKzBbz85OQWg077AQK46lC4okdt27kA=;
 b=pOTHpYlNMqUUSmFT7ivvKahkkAb/a2lNnSQaJY4+6rShwkrpGXwaTahoobl2XA/SSsqGChuyc
 k5DV14LyJvNB3yyubd8k7hPjAhh9PPpphgqmupfMV8YChJ4zvHbo34C
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f98f76-5513-4041-7fd0-08dccb378983
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUpDRXFlRFR2d0VSVm45emhCNUZzZi9wRzFnam4rbUtvK3ZzajJBK2gvRkh3?=
 =?utf-8?B?S09yaVhQRXZNOHh1RW9vcmEvZTZENE5mOVpPZDFIMGhnU1VjZTgrTGZBb2pC?=
 =?utf-8?B?Ulg0amJyQ21TUXFUSWcvNzR6VXVZTHpydlIxVXJ5WDd5enFEYjh2NHd3TXNu?=
 =?utf-8?B?WXprdjZSYmVkbS9LTDBOWkFkRkVZenE2bWJlRWJua3p5QjVqK28rUm5ZamtJ?=
 =?utf-8?B?bU9iMlZqT2owVHp5YkxCNjNrLzVHalFDTHREVEdGRm9HMXhLakJCN1pHdkt3?=
 =?utf-8?B?dkFObWE5S1R0VGlHaXRvVDVMemNoQWhEOVM5MHZ2VXowOVFZZTNYcG5wdE4z?=
 =?utf-8?B?S2lqV0d6SmhrZkRZbjdWNzNEMDUwcENYY0xmcU9nTU9CZzQvZlhpTkxlZGw5?=
 =?utf-8?B?WW1iM1RDNVV6WWpRT0xJUmRudmdWSXE3RG5wNVNuYzM3Mk9leFdTWmZoV3VO?=
 =?utf-8?B?aTNQZDhxSEVRdUhnOHR1M2pQRjNCcDhpeEZmY0JzVll1Z2MvRzRaa21uZXM1?=
 =?utf-8?B?ZlRYVmJEVmdEYnNhczRnaFA2UXJ6VWFwdk1RRGNJazdrU3BIdDBubEJPZms2?=
 =?utf-8?B?Y1ZqeHFxYXc0cERMMHUwSFMrTTdUaDkzcHdvRE94SlBVS3lsVnlzR0p1Z21s?=
 =?utf-8?B?TGpoNmE2cjBUT3oyZVR5dTkzMjhOdWFHYVptWGN2MlBYbXhteE53eGR4d00v?=
 =?utf-8?B?cENPcDRSRU9iYWNrUDgrYW5INGM5aDR5RXEybVV2QVpnYmxKNXREbzE5STV6?=
 =?utf-8?B?SEhkYmd5RGhRTTRLV2xZdXVEdHl4bmtLZ1VOMTdzZXFSOGV5aTV5QmpoRWtl?=
 =?utf-8?B?cjcwQ3hNblRmalJmVXdINWMrRW5FR3N6SlhDam5UL01YYWF1L2pqQStxN0tq?=
 =?utf-8?B?cmFmUzdONDdMR21mZ1ZXSW5PYkFXQkpGNjF4T1VLZUdwV1E5eUg4aFRIei9v?=
 =?utf-8?B?bTgvZzVnck9qN0cvYjZla3ZlU3BGZmYycDFCekJGVFVQV003YTdyK2k1SUo1?=
 =?utf-8?B?YnJEYmpvMGx1UTh4bmZSM2krRjVzVEtjQ0VUV1N1RXA0SllaSTJIS2YrK0NS?=
 =?utf-8?B?YXlLaWI3ZDBVVmR3RW9EZ2ZvbXNaNEgrZVNPSERlMksxNkQwamEyOXdsSExC?=
 =?utf-8?B?S2VEMUxYb3FqK2p0UlBxaERrQTBxekdGRXZrNzBtWTIzWklCcFFlSHZvSEMv?=
 =?utf-8?B?L1NnWkJpWGRCS0JNMjI2UlBlR1pSa29BbnZGZnJVV0VnNy9nZVRweGVRSDZD?=
 =?utf-8?B?ZzRzdGRsUnBpczBoK0NITm9kSUpuL3oyKzVwU1NOeWRIYVlvNVNvTnZCbDZ5?=
 =?utf-8?B?aGNxQkpydGtzc3FlV2JQWm1jOXBYNWZsVmFxWG9QK08wUVJtcHF2ZzV0bVhW?=
 =?utf-8?B?alpWYkgrNDk5VHY5OWNmOEJGVng2NW9qYkZtSUlRMHUyZVEyMjN5OWFxazRR?=
 =?utf-8?B?b1BVQmE1T2JoaVAyUnM1R1MxSTJIYURHazZNRXNOMnZ6bjlOOUNLM0JXK3I3?=
 =?utf-8?B?ckxLQllQdk1KRFNocDdzQStoZG5SU0QvSWtTanQxZWFyaHNtaE1uQVZuTDRk?=
 =?utf-8?B?SEhsN1FBTEJJbnlVa3FYbjNTbDgrakEwVWhnOEJsTEZ3NG5XanFHaVFrdWJh?=
 =?utf-8?B?Z2ZlQnJ5UDdXMTlVdEZJQjQ3TStQSFRRZFNrNDRSbjFVQlhxSFBPaUJTN0Q2?=
 =?utf-8?B?dENpRzIrQkRxb0RMdDdLWVFseXh1YzVmZTM1d0JJUlYvUGJ2WFJDaFhOUXpt?=
 =?utf-8?B?dmtjaVI0N2s5QXcvOTRwZUJiNWViTlg1SGt6WHYwRkIrcEJZOVN0YnR2OXVI?=
 =?utf-8?B?NkRjbGdrRklSYjRYOVhzTElhSTN4c2xPQ3BGdlJnQkN1cGp3c3NORmlhMDR0?=
 =?utf-8?B?WS9NWlFqSXA0R2RkL3RyT2dFeG9JTGk5czd1OG5QRFA4amc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlU0NDd6K3lXdlI2bUdLVk1yRTJWNGlydDJVaHRYaVhISGJjMllGOEdBdVB0?=
 =?utf-8?B?a054RFBtSGRSa0NweHdHcWEzb1JHWXBzaDZhRlV3MElLY3Q5Y0htZVQyYjVH?=
 =?utf-8?B?S1c2ZjU2V0VQMzBza0h3MXRKZkNEMCtCNFYrMFVQRlU5Wk1BQmtoSEVaUDkx?=
 =?utf-8?B?Y1MzR0U1bnM4am5Mcm82REVwczNCTk9zU2NIb0E2em1ZSy84RnFiS2lsQ1Nr?=
 =?utf-8?B?REhhamozYjZPKzg4OE9pRDV2T1RoTXd3MmM1anRWUDlJN2tud0pGVkNJN3Nj?=
 =?utf-8?B?bklRSEZrSXZPSXE4RWdkU0wwbVczbVRTaUQrSXA4R3RXUmxJcW1meGJIVUFP?=
 =?utf-8?B?VGQ4QjErNFE1UXZvYmF1cnBYWDllTlgvM1dEcjRrSW9icWltalpWVFhrc0l1?=
 =?utf-8?B?eXZGTDhVL3F4SXRtc2x0NjI2dktHc0kvTSsxS0twSW1MRU9rRHFoK1dHWS9V?=
 =?utf-8?B?MkZlM0trVTZtM0ZBaFVic24xWXFzT3B2RTRGcllvMUYrUld3L2kyVWJNNXdo?=
 =?utf-8?B?S2o5OTJKME9ndExLZk10UFdYeXRRMFBaaFBLbUh5SVEwRUkzRi8vN28ra2FN?=
 =?utf-8?B?Zm1jZUxXbWZZM245Tk1kNGZWYVp2eVNOcVc0VFlpMmJsUWJab1dFR1h1MXBS?=
 =?utf-8?B?SVJrYVE1S1c4eExmcmd3V3VVc3lXOFBrbHhoZjF4U2VLUGJoSkpJUkxTc2JW?=
 =?utf-8?B?YkI4RmFXbnNoSEhUREpsUVdwS0oyZW5LaGNRZVNCR1dmeUFKb3RNdGtlZ0xU?=
 =?utf-8?B?eTZWRnBGT2JhYUlHWHRmZkFJUWY0bjdqYzdKS21taTYrT1FyempVak5GZVgw?=
 =?utf-8?B?bzdWTU96SXFqaXVVOXRDZVBoekpZeXozd3FCeXBLL3NJK3pPUDNBeTNJTU9l?=
 =?utf-8?B?alBkbjdRYU9TQ1lsaTZpb01sNzk3c2lPT21FK2RvU3BJSmdDRUsxVjVxYnFl?=
 =?utf-8?B?aWxVNFhLVFA4bTNhbVBVeldnblc2LzdYaWlVanV2Q0ZJcGt5U2JkMWJ4aUJ3?=
 =?utf-8?B?djNkL1VienFZOGZJVlpSdk1PL0VNUzcxR21HNlY3cFEwZm0zZ28vY3c4Nk15?=
 =?utf-8?B?bkdSSTVpUDIvbmJWUUxZVy9RR2tMTjAvdmRzM1U3UVpFWFRDYnlBaUQ5ckpr?=
 =?utf-8?B?SFJHdXpKOWN3TWM2N0VIcGs5QUI3ZXRYQWZqQVVHOWt5REdGSDZSVk5aUnBr?=
 =?utf-8?B?V21DSDVyb1J1RU5tWGZ6ejA1b2dRdlRVdHljcS9XYmtlR0k3UFVBdi9BNHlh?=
 =?utf-8?B?WUlOUXMwMnFFNWt0amNWZCs2VzFQUlZaOUdJb3YyUFZuOE5yVkw2T0l6Q1NP?=
 =?utf-8?B?eTlpWEF6dWtMdGFuem9takZSZC9hZDY4OTMwWGppVUtrNkhJK0h3b0JCTldO?=
 =?utf-8?B?d2YyYllvSS8vNTBZOHo4eTRBZEtMd2t4cWpEcUZ0azMrNnUwTWgwWUZsNjA4?=
 =?utf-8?B?TnFRZVBaU2lIK2NkUUNKcmRXV21ManVYS28rODdCRVhaSGVzT2VTVlFiZVhk?=
 =?utf-8?B?aVp0dlpEdHNsV09oOWU5NU1XVDF1cFdDR3BMOXRhMTE3di91NjBkVFVzMDV1?=
 =?utf-8?B?UkN6dHBicHFQUjRSdzJaWmw3NFcyc28wV3p6Z29ZbHZYbk9OaDBLQm9SOUtO?=
 =?utf-8?B?TitqWTRQNGEzbktOeXMrb1NWMFl0Rms3R3FpdUtmNmRtUHhVWDdpRVZNSTJx?=
 =?utf-8?B?R2IvNlNkNHpPM2U2TTJTVkZKZUZCWURRaTEzc1NHakVHcWlNQUx5KzIwU29t?=
 =?utf-8?B?S3ZBa3RTVHRNK1JjT2cybkVsNVF6RnI0N3UvelZTMXhCMmpKYmVJS3YwdmlQ?=
 =?utf-8?B?ZlMrak9QRW1NRUNIWHk5aWVBOGx1U3JZM1BJWGRRRU9HVE42NDVrYiswY1Ax?=
 =?utf-8?B?bDdSSnAwYXpXQkVKRWN3dFgxNGMzc3NCYklpNVBqRlRDNFo0VWtyTGpNTlhx?=
 =?utf-8?B?VkZLUmpwMkUwWEZCNGdJZmNuTmJuNDhpWTJRZUd3TVVZaEVvYkdGS01tQVN0?=
 =?utf-8?B?UGFzM0FXVTl6N05uYVhzZHd6MGxHVWlhcnRSQ0F2MmcwTFY4SnVBN1dWYk1M?=
 =?utf-8?B?TG43OVJSbSt5ckNmV25KV2NkdEJoczNJQUkrZWpJcmZ4MjIrYlg4MVVMSTdl?=
 =?utf-8?Q?xyNbyIot2fs/4sbAOE0uGA29A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f98f76-5513-4041-7fd0-08dccb378983
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:10:57.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuHwt+3DalebnWJXsA6A/39L0R3nSIHLTJ2Abt7oQoCouCVSJmyQ00rI5twd8rWoFlBgZUiaUdXtVCUkitH6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099

From: Peng Fan <peng.fan@nxp.com>

Add 'nxp,ctrl-ids' for SCMI firmware to confirm the board ctrls as
wakeup sources.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 37a1d4ca1b20..5101cd171e09 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -8,6 +8,15 @@
 #include <dt-bindings/pwm/pwm.h>
 #include "imx95.dtsi"
 
+#define FALLING_EDGE			1
+#define RISING_EDGE			2
+
+#define BRD_SM_CTRL_SD3_WAKE		0x8000	/* PCAL6408A-0 */
+#define BRD_SM_CTRL_PCIE1_WAKE		0x8001	/* PCAL6408A-4 */
+#define BRD_SM_CTRL_BT_WAKE		0x8002	/* PCAL6408A-5 */
+#define BRD_SM_CTRL_PCIE2_WAKE		0x8003	/* PCAL6408A-6 */
+#define BRD_SM_CTRL_BUTTON		0x8004	/* PCAL6408A-7 */
+
 / {
 	model = "NXP i.MX95 19X19 board";
 	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
@@ -357,6 +366,14 @@ &usdhc2 {
 	status = "okay";
 };
 
+&scmi_misc {
+	nxp,ctrl-ids = <BRD_SM_CTRL_SD3_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_PCIE1_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_BT_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_PCIE2_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_BUTTON	FALLING_EDGE>;
+};
+
 &wdog3 {
 	fsl,ext-reset-output;
 	status = "okay";

-- 
2.37.1


