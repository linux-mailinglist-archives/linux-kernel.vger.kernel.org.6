Return-Path: <linux-kernel+bounces-285056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D84F9508B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049A2284FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038AE1A2554;
	Tue, 13 Aug 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aQ1Q+oH+"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAEC1A0B12
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562149; cv=fail; b=NS012t2VvTnFbSoVRuEiAzitSN8YKbzetdH4UEixkOsmFkbYieXalsRyaiMIKZFFHUlZl/0tOvvf+SqlNf2vNeYwjGfebmwoF+q2uQ4ZzihH1PkyxzbK4KDmHlp3UdhatnoE8RW8fXAnQG2+CiUtdy5qlXMW7UYX6HxKfF2l6/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562149; c=relaxed/simple;
	bh=L9feF7xb9MUyRMKZRWW6AUoqHkDTiS9UlH84igh2U64=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NHndydIn+RnmaE+xMdu7RDYntNoko13pefMAjNRwY9oQjSAJ6nPI/8BUf6dTAsg1u/LrkerA1CUlatnZgxMAlhkEHF5HYpnQHoJVlgOTH277jy31ZacpWsJIJms5erOA3kSLgFMRsywF3+XN4/3uXCIPzYTrROlm0+kVWV7F9bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aQ1Q+oH+; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMvWkm3aUNNv8nrot85BYUBxgX7Du5m/tTVOMK8Xspqwh232RmSGTJnu3XXaZmTbb8A+RPbTJnB9XCHCGXAdTpI2tlnEsLR1xv0YLbNTXWkVIE+8u/sA6udwoTUPqiPqXAPXT1HSwjTJrfAxFx1S+L42X2TOCoGjg+eClk8wj6GQ7HH78jyVcqSl326Jhtnsj10JINMQGv9yVHP1oiWT5MGxd7BnnwZuU0z0v89/g5dVayJE0/iXmuTG1ifzmntr1Kb++gsSw84/49Ppfjin11ekj0kjIFghH3/LOxWH42IJMPq/iO17Dfnkrww8WiDJFSqsNDosVKitW8z0sV5cGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=360E7KWnJTn4U5WkC5jXkR+B4Fj8KMcaMAGe2L9lXhU=;
 b=O9zQQi/7zWtBxTSoI4eFgfYIx1UamGUvB7maujy1PXy0fKAG6He71p+MOJ1/wKjSrgQ8R2S4bLkFMoBKteke1lsXIeTMKnbeEevr+V1ML1KiCvynQyTrImsVPDn71WLs07Y+DMf8dzmUXLSAgNYwoF91fU6QsDzAqLrUZ8vxSrHrLZnQtxeUcM4T5Kz9TlylPGUtF0Hn4wpGR8rpbL0ENdQyU8ukC1Jp1G0lYJ7LjPmNIUPYboo9ftCkI4l048jOBxyP8DEEGy7EWeyRAujAC5q4uejAUhHxt/QtoSMrYRNvD8EegSGNjs/H6h5uFoIiLjVxIwPamPdygo87eia/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=360E7KWnJTn4U5WkC5jXkR+B4Fj8KMcaMAGe2L9lXhU=;
 b=aQ1Q+oH+BvlTO8VsN2Aj4VVU1LAaIJ5+qEG3W6yiMAvAtwxXHoSombc6ltW216eW8MT7mpm7mdszTTWhl/tbleUcRHr8IbMqPMyKfNgSK8HoX0DX/JLWS1zo6Td9OOKKTGZgC379ZbJ90YzeSW5YQ8/rx3+lygzt+u1eQlzdnqcaUTak4oaSak+BmtjvbOL8R51SxeVALo58AZ/+UCp8VYttG+/wQNwvHy7aVuWa5+gctaVHbKXfbXqRK+izRK5AnNwFh9yIQMnq/l2JCvSIskUmG1/scW4CmQsWJt27s0CNYERTKoTEdC+R0bfq6RE+JY4lJHVnRN0Pa/7yrMPGfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:15:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:15:06 -0400
Subject: [PATCH v2 08/11] i3c: master: svc: need check IBIWON for dynamtica
 address assign
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-8-68fe4a050188@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=1408;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=L9feF7xb9MUyRMKZRWW6AUoqHkDTiS9UlH84igh2U64=;
 b=UDwBfzr23I8HaFqu/tax2yXLxmI1iuaYPNObWFXG9XL/3LwtCqLlOYq9VLnBPaSnNOtXjyV4R
 leLCPzpj2XyAAJBygabreCbe6WCSZZgCMvqZ/NxUuF5cN5rV4uryXia
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
X-MS-Office365-Filtering-Correlation-Id: 4d63bab2-049b-4b89-b42b-08dcbbaace70
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cUIrdjJTRXNCRUN6ZGdxRzErRmVzdjRlU2trNnExUTNMZ3o3emFDY21ZSmJh?=
 =?utf-8?B?NDh0SmU4R2I3TnJQNXdzZGltbWNncmF0TDdCT3J3bk1NbllNMFdFZ25lQTh1?=
 =?utf-8?B?ZTB3ZisxczB6bFkrbWNBRzFNVmtORCtVVGp2bDlFakZUMlpXZVBVODJuTXJK?=
 =?utf-8?B?UzN3QTJ0aGtNYWd6Y2Rka2wxNUFvQzRQYld3U09kM2NMSk1ydHFnbFIrRnJR?=
 =?utf-8?B?djRnbVZwZmk1YXE5dlZrNE15alIvWEZyZEtBMlozdndwejVhKzFoZG95TDZh?=
 =?utf-8?B?MWtCM2FDaHkzMmlhWTBKT29CQkVqejF2TERpZ0NuR05vaml4ZVcvNHRDNFo1?=
 =?utf-8?B?c21TRlB0RUtCVGllajZFSXhlVy94ZnZScjRZWkxXM1FZRmFFdCswNFlSMGls?=
 =?utf-8?B?djkxd2pQNXlOTjZwVlVhWHV3Y2NFOXZnaXlhU0lHT2dHaUJXQTlrOUs4T21o?=
 =?utf-8?B?ZEpIWHRHNmFPazMxUEJaTHRNQWpGRG1RL3RRYUFxdnQ0Q0dreHh5eUdDNFpM?=
 =?utf-8?B?RnFkUnEvbjlBQlNGcDBGaXhRWnRyM1J1NDRiL0RwS1M5YjEyWkRKd0o2am9F?=
 =?utf-8?B?RTVyZTJZcGZFSXYrU1hhMmowRlMzak5RWlhOUXZXU3pkWkVlVzNPQmd3SjRI?=
 =?utf-8?B?NmY1bW5xT1dTdHAvbUY1MmR1OXVYRTRzSm1sWkZGTHFqNk5IaHliaitLVnV0?=
 =?utf-8?B?cisvNjNRaDVPT0pJdTRHRExYSW5sY3JTdzBEckFYemZ2cU5Wc2JZSWxMNXhj?=
 =?utf-8?B?SU9ITWw5cTNvNk1UV0VNSkY2dVA3S2ZESkdhelBHb0dhbEZGbFNxUW93d2Rl?=
 =?utf-8?B?YXVDZW9hVTNtNVlpbDBBN0szeFVnMFB2YllMbW1SOE8zckdSMmxwenQvK005?=
 =?utf-8?B?bFhENU5DVCtHbDB6WWgrUnE5Yk5XNDdNM0VRVXVjLzMxRE5CYWM2SVlyNXk2?=
 =?utf-8?B?aDk4ZHFxV0dSblRZakk3akFzZk9KUTk4bXBGUGFMMTRMcDJtYzFqczJXU0JE?=
 =?utf-8?B?QlhSSFVTb3NrZW5NNXNZaG8vZE91Q0htNlVqdCsrQjlZOFZKdmppc1Y3Zndm?=
 =?utf-8?B?RWVzRm9IaEpnWTBvWmVVWC9TNHNaQ2krRkJEblhxcVhSUi9tUURhVno3RlND?=
 =?utf-8?B?Y3VxaC9XWGoxMFpDcFpOb1d4Z1gzYm1kYXJWMC9oczZ2dlhIa2NFRHFXVisr?=
 =?utf-8?B?QWVrdGdQYjVzWUFXQ2xzSHN5UDgzTUlMMHcvUzAyOEp6ZHpzMXg2WStubHB6?=
 =?utf-8?B?U0RDNHJHbm1DOWZsSEN6ZUF6T0F4dHQ0dk9PcHFBWVdIcVo3Qm5YTTNOTERr?=
 =?utf-8?B?cGVkN3RYR1ZiK2Z3NDVxTS93c1NrZ0xWamVNL1E0SnJkOWJGc2tENnNOSjVD?=
 =?utf-8?B?OFlUanA3ZWMyRDh1U2NVZGVyMmY2dW5rQUVVVHVKUURNNWlwNmttVmZ2ZUdy?=
 =?utf-8?B?ZVFFbVord3U4YXo0cDBsZ3lLYk5IL2RuL0pzRlBpZ0czVVVoQmVOTnBmRHI5?=
 =?utf-8?B?MjlLc1hCNzhKZlBHYng1bGdkZ0d2TThYMGtMUFIrU3ovMlBwR2NuKzF3Rkcx?=
 =?utf-8?B?eWNEZWpXR0NDM2J3elNKeGtkT1NnNU1VMTltdFgwMWgvbXRsYzBPb3VrVnQ5?=
 =?utf-8?B?Z05kSEJqTFlCMWVMeUIwTVMrS3pNOVhJb1R5WFVURjZyUGs2TjgvNXV3T0dk?=
 =?utf-8?B?cjdPNXdLS3NsbzNQWXQrUXhvTG5iYmJzam5RSk5FNXRTNHNoeDkxaEtYeHZK?=
 =?utf-8?B?L1lIRGRDU1MxdjdHM2hFN3Naa1VZbC9QeDh2WHBiRnZtdmxuZVhOQkFGRFlC?=
 =?utf-8?B?cEFTdzc2UlF0Z05Ja1lwOFRhdGpyS0RsMTd1Ykc5TTVvaXJUb2VCR1RkVnFh?=
 =?utf-8?B?VjZobUkyemRRR0NQM0FlTDFuc29Gajg0TDE3SXB3QStWS3c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T25NNkphVE1SVmc5ZVlYU210ZU95Q1ZmZ2FiOEpkcGJhVVAvQk9qY3dzanZN?=
 =?utf-8?B?ZURSNU8ycU5BVnpLcWt0MGhUN056endNOW5vdWRXSWg1YW9IdnlJUkdvQWtC?=
 =?utf-8?B?MU5Xd3FKS1plaE44NStzc2ZVb2UxYmUyYkpUU3pUa0FNNGRqNU5mWGxxS2hX?=
 =?utf-8?B?c3lQNjJvYUU0czYrSXVHR0NqZXhINVRGK05MUXowaXEzbWNPbkJyVGxFdURj?=
 =?utf-8?B?TU9RWFM0OVErYnR3eUkxdElRRFZYVGwvUHBQMEkvMzBpcXpPUG9pWmhJdUly?=
 =?utf-8?B?Q2VmdjJnNitqSkZIcFZPQk1EL0tnM3JHVGlsaXhLaitiK1F2dmxUbGhycUNE?=
 =?utf-8?B?RnBWSlNFS0dudlc2NnZ2a1I4VndPVTM2RzVZUExGOGk4dENDNGU3VDYvdDZj?=
 =?utf-8?B?UjVDZXY3RTZySlpidXF2THZtSjN2bVBNcXI0VytlMEhIQlBuNWhBbE5XWVdz?=
 =?utf-8?B?OEg0dGpobktvZWtHSWRXYjNEWndBTE9pQll0L2s5Ny8xWDlOeVdDcGh5MHha?=
 =?utf-8?B?U2trSXdyVGMyMW5oOVNjc1ZGTXhuRXNyQVhRWEhoR01PNjZHMmQ2aUxaN2FT?=
 =?utf-8?B?MThTMjdQd1VWS1AyMUQycFZpVlMzdUxZREdqUFN4RmNIQVRrTFIxQlpIMml6?=
 =?utf-8?B?V1c0bHc3Q29XbkU5cXNjMGFrKzBDYUoza0NOU2FQWThzcm5YVHBQM2ZZMm5w?=
 =?utf-8?B?N0d2K1hqUDFBcGVSVmxVUUdwc2xCbCswTGVpQ0N0eHQ3cnp3OXBxdmU0RXhU?=
 =?utf-8?B?dTJGRUpsbGVoOHhOSi9XS3FpRnZwYWpjeEN6aUFvdmQ3b1dpQmpzN0pKMzNq?=
 =?utf-8?B?R015WVJMQWl1YjVoQXJ5R2Z0K0VIdnFPbVF6WUlic3NqSUFKS3FqOHZOSWlF?=
 =?utf-8?B?R004eVBaSGtRYjQ0V04zYnRjcmEzbmFkanF1QnhJS0o3MnhhemxIenhQMThN?=
 =?utf-8?B?OUtJT2FSM3o4NlZlVjFCN1BqcHJxaHpmSGMzME5zVEtEM3JFd1VEbG1NSUhz?=
 =?utf-8?B?WjVWancrY2l3cmlkSmJmNUcxK09qVVVsdzJRV0lIMjZZY0hSRU90QUFzU2po?=
 =?utf-8?B?UGtkemVuSmlTNUJsSmdFcjdOeFdQSW1jZ2piWmQ5cUtNNjIwckhxTE9RQ0JL?=
 =?utf-8?B?VndQd1N2Zm50OHhCOWdFQVhWMDJjenJpZnl5SnU2ZTU1T09oK1JubDJBZXB5?=
 =?utf-8?B?TkU1dFd1NUJiRkRobmRXVVN6VUlzNTdvMVhSb0s1SzY1cnJJWXB6NXY5cXBi?=
 =?utf-8?B?UmVMOHMxTnoxQmdkNjNWOCtPT1ljcTUzMEszYjRRcEZRR0FTakpqbnhqUXNI?=
 =?utf-8?B?OXRhbkxlNFBNcnNQTXVOdmFBRGpzTTlQaHhQRnZUcE43N0t3NnRUU21FTlJF?=
 =?utf-8?B?OHlrUndTSlRYMHdjcm92SWh0WDdkZFRWZzlxZWhhSDlqaHQ3UlBoUFdGaHBp?=
 =?utf-8?B?VWd5cjE0Rm9ydHJ0bVNGV2F5cjMxYzk4UXJZek5ub1drcTBNQ3ExUXNJeldI?=
 =?utf-8?B?S0RFUTFlOFo0K01WVkZvYTl5TkJOMVZhRjg3SUtyT2lSaEl0d21mTkxOYXht?=
 =?utf-8?B?Zi9QOCtDQU50ajNNNDhEZ1JRY0tYL0NBUmVzdXJyUXBvaGN0SWJoWWpKTUZI?=
 =?utf-8?B?bFp6eU5lY09DVUZTUkJ6R1dYeW1ZdGZNZHB3Wi85YTBjWkJvUjVucVZ5UTlK?=
 =?utf-8?B?SmZBalFhdmY1UzliRWZmTGh0ajhaOXlRUEZUQ3M3ZVM5RHJEN0JNQjRJZ2xm?=
 =?utf-8?B?Qjk1ZGdUUTczZDljbDhMVGNjaUdtTXlITklyTExIV1VNcUtRdEtra0pLYW50?=
 =?utf-8?B?YzEzSG90a2o1TEltZy9PQUNuaEUwZDUxRnZyd0cwQ245bmVlVkdubExxc0Zt?=
 =?utf-8?B?Q3VKQjllUzJRSFFQclg0OGRNT3hCZkVCOXlYV3JRMTFqaEpnSzBFT244Ym5V?=
 =?utf-8?B?cnVuZnVPd1piUlVxRGdWV3BWb2N3NWVwMHlSQjc1YktYTWZmWGVNS0pQUFVD?=
 =?utf-8?B?YXJacG01b0dsV2xoUHFPMTBmV0VFcHBYaTJaQzJQU2V0MWNYd2UyY3E5NGNk?=
 =?utf-8?B?bm5zWkF2aUpzTTFDVE8zZFh5eWFTaVdQZEM3TS9ENzVxQ2RDOXByWEZTemJn?=
 =?utf-8?Q?x0jM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d63bab2-049b-4b89-b42b-08dcbbaace70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:46.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5ZozFdg8d/khlv1BdZHCu6wWzaHeeR0N/r6T7PFPBfP3dLi5mM1laBWnJDeJ+no7pFY9VHRqEBhpyMgTKwQkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

When sending REQUEST_PROC_DAA, emit START and address 7E. Address
arbitration may occur at this time if other devices trigger HJ, IBI, or
CR events.

When IBIWON happen at REQUEST_PROC_DAA, nack IBI request then use repeat
start to continue current dynamtica address assign.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d665639523e3c..161ccd824443b 100644
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


