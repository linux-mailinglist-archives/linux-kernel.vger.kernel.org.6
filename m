Return-Path: <linux-kernel+bounces-292454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C51956FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD17C28540D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA516D4EA;
	Mon, 19 Aug 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPhj33h7"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164D186E4C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083350; cv=fail; b=Mz9N+ihs8upD23V19mHfjTg0N9EEbmXUuDFz+rt2/LKVwZpHhnJZQoMndv1i5SHakzTbPgmHITm1bPsDk3kx05eYj7wPHi18lwQP9ygrECxlJLAyhThDwbwwztvwneNEoZlA+DZvus4Nz7aCgvY5+vG1sS1KPsz/f/wzG3Z+eao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083350; c=relaxed/simple;
	bh=wdMOaxvdED4nYxZmlnJu7BdBDpzKEEzpzk8ZMhb0ahU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dbOXNQFayz39poTb/UjSlh4G/XZv2t+kMf0QD7wfNTE3s9V3TNFQjfctBNWCOLxi4cyfjst4OJ9mHi1meHgkA9RDpD8C6WrKMSp7rIXmgizWKQh5ggkH4R1kai+416JrWyM4frqgFI3bHRrD24TnnYUfY1sxlyqweLUHuM+6WjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XPhj33h7; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoCDReAd2Uy3ICMrqJbZIgBqA3aDaSqjypTGXqZakchjHnu7XE7HUsQ1Prf9SyrFYnrJ9W1XCGVODaSOTjZeKpVE0qC+oYIoF7+muuNwXknmH7tYZth2n3JGPowuooA4cR5/SeZJiFYtjVe19BjCBwOMNN6gbpw3ltDeMeyeUgKgq/D6+3sB4dQNg9aap95UMjchpnXsow68UlB1EnjSBgaewGqotZjNFAWEiJbAV2M1MNq7lz7MVWAE6Fde+Ddde6dwG9m+2VgusGH+DIn7Rq17p4q5KjC5Dl2qtNpNqQIqcbm7suJIr4WzLJohVLlWfkI504ads97B1ZloUXkwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cmOmx2TRWp/2Uy3nWsX2Ky5UGNNorgOPghwcI1aG9c=;
 b=Yqmy4WDgDHLRSKYGFneRE9dgO8lc9ERl/ymSafzYvv4UbNs47BUqJvRvEyYiFCUu9cJumqnP15p4jThtvRrViLZE+pCMmzhGbEEwFzJLLfjhMH+RbltPKTJGCJYI3xfdrls3g8MAX5HMEcYzxrGaLOW2HPi0n6CfSx2BXVt2ckb9TonvqDXMg1rm47dAARbYMXs1ohvPKwxGbnpcmg/bsVsdBrmG1XQlev5NIXB8ruYe90oqRCUlPRE8OyjqBSRdAmoXSyb3tkDoBb6bprOqOr7YL850Pi4ZHqX7/1tPTiLooeIcbGjXnCYqjbl2/z5ttLCxXr2tWyyFe+oFUmadMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cmOmx2TRWp/2Uy3nWsX2Ky5UGNNorgOPghwcI1aG9c=;
 b=XPhj33h7SXSOZ1aJTfq7O7nDlUaqVDfPcOP5sgySnTZbsNBMuGMVde4KoAWXucN/hrimW7RECAqDuQKkvV+wjP2ue3tfTGKqiTgT/2IZjI8bMlbBJo0ZCgfh+0FR6kcOzTeuiVdxx0qMdr42GEshml7RmjCIMZCitnsQjTairJyhadYg34AsRB3LYSv5ZcjIjvOAtnqKBM2GRML2bE1B8kMpn7q4ma2ozVZoE64WBHdQpFWplqrxB7HwryyzU7l9EYqH9sFzN4XZ4wjCan15diqqdzpr5q8yXEzfLc+xcqUSWaKE4Nxf4oBG8mMVNvpURlGbpfVnlcHNBefKgU29Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:02:01 -0400
Subject: [PATCH v3 07/11] i3c: master: svc: manually emit NACK/ACK for
 hotjoin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-7-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
In-Reply-To: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=1762;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wdMOaxvdED4nYxZmlnJu7BdBDpzKEEzpzk8ZMhb0ahU=;
 b=A56sFgcvX9sbc0McVV+FF39qyIvzaJ3q29C7EXlzuFph00h+KCPaKoJcZwn6zRH+9VG0+5nr5
 RzmTz/NrbVcBljgxIY2ch94IWForttrCfjQq4dh+QrJZ28MBSHMtFWJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: b14d999a-0810-4ff4-5b24-08dcc06850bb
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YTZsTURsOW1hR3kxTkN0VjJpQzJydHdBL3R0ZHRUZHZTTWpCbzVvK29ycVRl?=
 =?utf-8?B?S3NWdWNKdDVUM2N3RmJjY054dWlPenh0SEM4Y3hrWHNxbjdMdHBJUVppQW15?=
 =?utf-8?B?clFoa2grakNTUERCUm1YSFBsY0hVMjB1WnlxN1A3eHZ4aDJENC9nK1ptLy9J?=
 =?utf-8?B?bXgyUHVWNXE4OStnSnpWMVdiUVcyb3hmeWU3amlMV1BZWldad2t6VkJVNjN0?=
 =?utf-8?B?YlVmT3lBa3JtdTM5YUhSUzVOU3J2K2x5a1dGbFprR2QwdmFWbkE5TlM3a0x3?=
 =?utf-8?B?d05NSkNWektPK0RyYlJ4b0NIWjE5by9qelpDaGJnMFVwNDFrU3RpQkdCbmY3?=
 =?utf-8?B?dFJBTjNGTm9iaVlzeit0UTJMNllxMHpYWmlKTjFYMGxJRitQd3BNaEQydnBn?=
 =?utf-8?B?VDFQTTBRS2sxVXBhUTVud2tWWWJROGFET0Q2OU8yaExJV0pQYlB5ZDB0Qk41?=
 =?utf-8?B?RUhMOUVNUTQwWVZXanhOMzYyeXBldGdaZ3orQkRJcXVRZk82UE9LMWRXejNi?=
 =?utf-8?B?ZURYcHFlUVdwdG1DenY2YmlXa21wb2s4dktUTFdQU1pIVlN4KzI1ejZJdTEz?=
 =?utf-8?B?TDRFaTR2VWJzak9NUnpRZkdUODZ3K3c0WFBnTFlIakdZOGxtWXBJY0hXNER6?=
 =?utf-8?B?Q1VZakRXeDdSdm9VSENJWW1YYmZpUE1IdjFHcy9iZVp5b2txNEx4Z2RCTXQw?=
 =?utf-8?B?b3lLRUZOOWhLVlAzZmpOdjZxSGpYUzZ1cHdTQndLanFzalNaZEdUOW0yMDRy?=
 =?utf-8?B?ZkJObkJQMzlJZkdMV3d4VVhZeVZhUWttbGJvVE5GdjZNSnl2dmVRR2pZbkp5?=
 =?utf-8?B?eUsxcnpKem43bHRBQkZrUDVqY1pDVkJNNUlIbjh3SG8rUjg5Q2lGSDVMMVlr?=
 =?utf-8?B?dTE4TmQ1RlAzMEQvWDdRWUNrNWpYZUVtNldvUUtoaC8zYjRHUmhDYVYyNG92?=
 =?utf-8?B?UjBIRGd2dWRVMjdCeHNqZS9rZnVkTm9TTjFNRkNwYy90bzVrYytlb1BNaDAr?=
 =?utf-8?B?TzBDNXRkNUJaNWJ1Q1h6ZHdWNGlud3dHb3pXQmZIamlyVXlTYTNveWlNeXIr?=
 =?utf-8?B?cW5ZbkZQZDRsbmE1eVZJejcrV3NhYWJEZFE4WFB0bDY2UCtDMWZvRTJ3a0k4?=
 =?utf-8?B?cS8xRmVoM2pGSitOVnB3SVBWMEloWDI0WFJYbkM2UXlyZURra2JuN3lQendY?=
 =?utf-8?B?Uzk1NC9ScnB1Mmo3cWhXREN6RXF3Z3VyMGdtaTBKYUFsU2dEbDNkWHVRMGw0?=
 =?utf-8?B?MTA3S2huekdNcDkrU0svWFdRblR3TWFxT3l6S0pYbWp4UEFWSE5IVnhhUGhp?=
 =?utf-8?B?Ni9VMHlHS01JK2Z2TUVNRkxZcWY0b0duV24wVnQ4NmxCWmpHd3k3WFIrSjBE?=
 =?utf-8?B?RGNMRGQ3UWZsYjNhdjI0VnMxRkx2dEM4eS9WUEM0ejJxdVRlbjhnYjU1WHFw?=
 =?utf-8?B?Tlo0cFVRZjZaYU9kMU4wRmsyZDFEdXQzMnV1Y0hYVHNpcmNtWlk5OStMbzI2?=
 =?utf-8?B?c0k1eWFPSnJXdzJ5dCtkUEVPOHV3cDFra1FVaUhYUTBtVXFxTDlXdUF1WG1Q?=
 =?utf-8?B?RUVkSjY5L1Z3QndLR3pxdTJMS1BBTEFVNXVveW1zQ1dZTlVhK3BOM3lSWFpI?=
 =?utf-8?B?Z0JtZjhNYS9VZ2hVWjRhRE96VXNNTU84TW9WTU5EWUUyN3ZkZDlybWF0dkVB?=
 =?utf-8?B?UWkzR05qMXREQlAvMHRCRmsvYXJ6MkRSdEttbHdmUTZINndLWjR3Z2NxNkVk?=
 =?utf-8?B?VGxzcGdsV0xwRVlacXJXZVR4QkFrMllML3N3UVhWTGkrd2s1UmFraFk4OUNS?=
 =?utf-8?B?d3lBRGtEYTFaWXlvN1dRcHpveTFxdHNMKzNKb0J3anNXcUFYa1BzaW9VL1o3?=
 =?utf-8?B?YSsxSjlTY2swelZqeWtiNDRaakVDV2dmRk8yYzh4d2oreXc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?elN0cFh3NHdtWkw1VGpicHdZKzY1UkpCb2xTSTcvV3FYa3J5eDJrTUtwVjJH?=
 =?utf-8?B?emtoc296all5VU9kMHJmMjZaQ2dheVIza0c2dEdTNTZrS0oxTU9mTS9WNkti?=
 =?utf-8?B?S0FuZGNQVklqU0thbForSUZ6bUVQV2dxTGZWWS9TRWNFUlkwUklXclFkTDlu?=
 =?utf-8?B?WnZ5NTE1K3ROZTIzckpTVVRRNW5IbU1HdFNodjNENnp0MkRCY1NmdHp1T0Fl?=
 =?utf-8?B?SmJmdnNCa0N4U1FPcjhrYmN4WkpmdUkyMjZnL1pYaS9VUzRiTDg0MVlGME94?=
 =?utf-8?B?czE5MnBQQlpJK0h0Tlk0bC9TZHJFVWFyR3dlYVRsYjhQNXRaMWdqMklNNi80?=
 =?utf-8?B?NEtLejhTK1MxSDhNWElxYThkOEF5K3hSZmJoVGpnTzk1anI0WnBNWkJJYUo2?=
 =?utf-8?B?YmQra21wSU5FdE5FUWI5dDhMZFdLRHRwN3NOWWdZQjFlNW5sOVY3eWlYVFRl?=
 =?utf-8?B?anAxV0N4NkxRWThJUks0ekpaNlBEYWtvU2NJR3BwajduemFTTXFVdGx0aG9M?=
 =?utf-8?B?SEpsUUQvM3I0YlBBamNtdXk0NlhOVkJHMHROdEplWnZhL2w2aDQ3TFR4RTRS?=
 =?utf-8?B?RkdIVmpFSlRhQTcwWEgvQ1dMWk5CVkZaUVhIbVZHSk9iM3FpcWR2bm5pV3Rj?=
 =?utf-8?B?WDVyZHpnd0dRZUVlUmhORFVUWHJBeWQzSWtPWTZ3OVRacFA0VHRlc0lkQ0g5?=
 =?utf-8?B?a0JtOHg4dXk4a1FObHExckRuZ3UrcDRrelZUM3dSYjVLbUhYVXdRQlpRZEtV?=
 =?utf-8?B?WlVhOGprdS9zUHR3MHVZM2JOMnVBL1JZS1hvc0xYdk1xQ2p2TUFNZzIxZnVO?=
 =?utf-8?B?QmtXQXdrbGh6QXJCM25LME4zQjgxNWRNYytMaEt2STBlUkNNYnVVV3AybHp4?=
 =?utf-8?B?NFFhM3ptU2s0MStIUHZ5MVhOdFlUWjM1MDY1dlNLL2lQNzVGZ0lwQ0hsWTFn?=
 =?utf-8?B?VFlHWkV0VXZlMU5NbEh5cnhRcXZ2QXd4aXFnM2NKeE1BeThTdG45V01KWkVq?=
 =?utf-8?B?SmJtRzc0bUx6bWpSTHo0STlMOUdtZGhMYVgxdW85ZnlJMGZwMm9nWDZrNXFk?=
 =?utf-8?B?eSt4T3BLMjFCa1h4dzRoN2l4S2NrMitwNldMYmFjSzd5TGtXMEFKVHJ4NVdv?=
 =?utf-8?B?YUFheVZxWDltSFgyWWNnc21Eb3hURVV2SnV3alpkZDZxNnY5YTFZMVpYdGhr?=
 =?utf-8?B?a3dkNTI5V29ha3BYalhYZk5OVWFFc2g4aDNvR3pBZXJDNFFITmVRQ0Q4aHFl?=
 =?utf-8?B?Q3FjRlRhbEpGSFlaS0FqOXB5ZDFEYUQzRUpzMmpyZnBQQVphd2VIT3RnTXR0?=
 =?utf-8?B?dUQ5d080QnZhd21MbHg2enBXYXNmeXFVUjluRkZYWk1NanBDSDQxc3l4ZVZ3?=
 =?utf-8?B?NGk0dFZVSmdhNFRkTFdCM0xQMlorTUFoMHBYWHRsb1lEUFlQd05OcXJGS2Ji?=
 =?utf-8?B?Z1cxQ3VObisyWFYrRTY2em9aRS9kS1BFK2h2dDN0RHZWN2t1b1FpQXRQa3Ar?=
 =?utf-8?B?SjRmclowUXkzYnZCR3B2dTkvU3VpbjE5MUJMaUNFRkVxUjhqYVFkOXNRdEEr?=
 =?utf-8?B?STlxK3ZJS1pySFVhcjVJZzk0VGx2QWRyS2Q2ZHRrZjlHRDFob2d6cHlJblNj?=
 =?utf-8?B?N21mdlJXMm5yWkp6c09xTms0T0x2UXArUEdMNnRWOTNaUmhEQTRSK0dGTzlD?=
 =?utf-8?B?d2kzdW83WWQ0NWR6Mk51YjhhTDBYU1ZIOEdtU1lORWJZdnlMWm03U3N6WlRK?=
 =?utf-8?B?QjJFT1pacXlKd1g2RDdqaWp6WUpkMVJSYTcvTTQ1aHRrRmNUcWtjL0NFNC9I?=
 =?utf-8?B?bHFPelIvcVFGdFVlWjN4Rk4rVGNrelh0WXcxenk2cmFpWFA1cDI1QzZMK1Vx?=
 =?utf-8?B?aU5oMVhHOTE2cTVwYUI3UzJ4VUxMRExQaG5qa3VtZUVTRkdXcTVjRU1VcEVC?=
 =?utf-8?B?azBjWHVldjgvT1hlVnJXTUhNOUJOVDVjemhlRy9tZnpiSVNVWHh2a3pzVSs4?=
 =?utf-8?B?Q2MrVDhKUi9zby9WbitZN015TWFnbUpyN3VqcnkrZWdLeUxoQzdKbXFFVCt0?=
 =?utf-8?B?VUpMdkFYUXY4ZVlDN3JzQVo0bmpadUN1M2FhUTJLTnV5aDd4cWFFdjZwQ2VQ?=
 =?utf-8?Q?TK7FX0qrrzqPo5DNGmz7lv8ir?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14d999a-0810-4ff4-5b24-08dcc06850bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:24.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYU9coy+HAgHcXCC+F4uEFkCtNxVidEk6kKlvkuQYtNtGg+iS2ACdMGCg1GC46hlTXvk3YtdxnQ8Dk2nc8pmvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

When the address is arbitrated at send address, the hardware can auto-send
NACK if it is an IBI. However, manual emission of NACK/ACK is needed for
hot join or controller request events.

Add help function svc_i3c_master_handle_ibi_won() to check event type and
send out NACK if the event is not an IBI.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5d19251238ff8..d665639523e3c 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -405,6 +405,24 @@ static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
 	       master->regs + SVC_I3C_MCTRL);
 }
 
+static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 mstatus)
+{
+	u32 ibitype;
+
+	ibitype = SVC_I3C_MSTATUS_IBITYPE(mstatus);
+
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
+	/* Hardware can't auto emit NACK for hot join and master request */
+	switch (ibitype) {
+	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
+	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_nack_ibi(master);
+	}
+
+	return 0;
+}
+
 static void svc_i3c_master_ibi_work(struct work_struct *work)
 {
 	struct svc_i3c_master *master = container_of(work, struct svc_i3c_master, ibi_work);
@@ -1113,7 +1131,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+			svc_i3c_master_handle_ibi_won(master, reg);
 			continue;
 		}
 

-- 
2.34.1


