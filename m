Return-Path: <linux-kernel+bounces-267092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C614C940C43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82491C23BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2371940AB;
	Tue, 30 Jul 2024 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dTL5GgJl"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1D194AC2;
	Tue, 30 Jul 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329351; cv=fail; b=raKAn7ZwULYi9RUZnQSSbp56I+zXLXPoUrTw3jD1a5yd3o+5kF+AVUFgbpN4VttSpumq22nsOtEkr4qPolydROhrnCttSB6cGvI+kNGgfe0beWYkOYJDy8YLgjFm5MLlzeDnnMh3bwKm0wGUNFKt+NbBoS6Q2pSL58EffTDU2Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329351; c=relaxed/simple;
	bh=zZoDMM4RB1mTVG24uWbG9/OAI/a5YAR6iRVu/y7zjqE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=GEIbTtus+PVsPr+dEq7/vebNbP2hLpG9C5V69t7Nax8B543f1GWcgqUfIdnWu/SonTd1bJZvnO4qTLPPziZLP8V4nbFlg90rqtFt53QFz0W6NRioMFkSmIWPN1MeMFJ2KK5CCgdnt953U+PxreStxhMG2c7hvKBOPGN/QOfAaLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dTL5GgJl; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9/3uMkTuh9XZvl66BFmQMWc3PM0o1vd3zGuBDHi5p+zP+oMZxDcNOvJ8HTqmWmBzUQwoGAQSRewAIQKHL20/qfNV08A4XP7hKTkIipKq/pVdrPQrPkwGZPU2dSUbJCK5O7pLl/Lvokpqaeh1VLlLAwA/6Zi4gAMHCRWUdpebUSnlImWrx/y4RmAlhj7rjTcMmzwO4U0ZxpSbv4nwT/NTYnFCKzmTNEYvSozaeIglnaoxtwPClgX0ZfGae7bqAhy2aAyD3ljZvYMSKhVQE6zsgs8utjXhzynVuW0gaGOERZEvz/1yr7xmVqmJ6d9zg2b6l9q4DMQ0izCoPqlyZitqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrOZGSDjyHwKdOH0eOyqrdWQ9UHH9qKzDIVdT2cvN+o=;
 b=ACwGpeQfJwXS40W1YrYYcYoFp32O807hlhtBTda5AYqHbCrXbPWxNq5nyaRcq6Z4nKYERuKhanj9wQEZr1HK0HqyN38V7iKmbjMmpSFOCNY9SCOuoO7JAEA3SjwbzTOsHq578jmLdr7Cdnil96m4Xl30OxNubfVmFvOw2iq8FiM01ZEywrd0pQaXloLUT0o7VGpxW7kYK/NB94ovJ6x7L3I5HWam1ubd1oylRr0QCPXlrB5KyrNcMvfRoMF1jRUh1lMVMh006e6VrFQGEYrz2CykjLKjw2t6wLvf9wEMgpmVYUREUNG8aSFnjijPhQ9ypPUwSstTh3uPrMsiPikboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrOZGSDjyHwKdOH0eOyqrdWQ9UHH9qKzDIVdT2cvN+o=;
 b=dTL5GgJlyHwcDSl9OU8hldkOLhxMonNFFE9+glLoZ+oORWkJ3Tx+BLL3xbRaX+RBp+9Q2jT8QaoJAv9iIIvGYAoAka5VQW1kzMmYV88jPoMQjE19Dxi+izl7dXySUM/iIfsCikQJHsNk/tfeW3trk5e7ONIsa2L6m1RLPzGQot2DNPQUJtDeq4YAtBNnAPKJooIU6zIxwFL7dv0IOpoqGEgDUB+soVzvW3E+vAuKXBToOau3KTP9X3G/1kjJr9MyYEAi2qEUEai/HcKSztcoIJgCwhSoyn76nEMBnijFrM9s1RtrSu8FpfMsG6R15VEbv+bSBQXxsTrYdgbQH1xvdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB9021.eurprd04.prod.outlook.com (2603:10a6:102:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 30 Jul
 2024 08:49:03 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Tue, 30 Jul 2024
 08:49:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/2] clk: add assigned-clock-rates-u64
Date: Tue, 30 Jul 2024 16:57:53 +0800
Message-Id: <20240730-clk-u64-v3-0-4d2b19edaa6e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABGrqGYC/2WMQQ7CIBBFr9LMWgwMhFZXvYdxUelgido2oKSm4
 e7Sbli4fDP/vRUCeUcBztUKnqILbhozyEMFZujGOzHXZwbkqLhGwczzwT5asZobJaW03DYc8nr
 2ZN2yly7XzIML78l/93AU2/W/EQXjrMem00LcMH/acZmPZnrBVohYrBpPxcJsWdtpJFKyJl2sl
 NIP1E4NAdIAAAA=
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722329887; l=1450;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zZoDMM4RB1mTVG24uWbG9/OAI/a5YAR6iRVu/y7zjqE=;
 b=FjnW2+CokTUXpQEwfSFL1IM887S1Z/N4icoi48y+I69uU4sCjI5dlc9Z/ty2HDvNtDgYAYInz
 OZ/pXZYIP60DrxFy7kUFm5AQstMZ8YIMn0wX2dUxZe8IngRKxlCKQ8K
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: b31c2550-d406-414e-01a4-08dcb07474ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1BjQ3pNOTVBQ0xrNDhkLzNiM2ZoNFVVZ05idzNvSzFFcy8yaTN5UENUQXB1?=
 =?utf-8?B?M0VUSngraFlGWlllTXNJZk1IL0c1QTFzRGh3T1FMNXgrcEpsU1NKK1BTendn?=
 =?utf-8?B?dDBTLzdVMHpHMWYyUUxJQXl2aWdsTFBDc2dVWElYRnJrTW83dzdKazNJaDVo?=
 =?utf-8?B?blIvZU9MVGtha2NVM0c4WjRmbWFxVHk3MExMV2FJT1lmSEJnT2thbk1YNmVi?=
 =?utf-8?B?Mm4zcEN6Z3poUmM2QVNBQ3lvSWZ0MjdRZDVnS3Jpc2NSemN6NnN1Q0R1RHRw?=
 =?utf-8?B?eEliTGswZ1ZQWjYrVVUwNnN0QUQvOWJIK0xPL3h1LzZPYzMyMDRxUFhiTHRz?=
 =?utf-8?B?ZDdld3lkWjZpazcyRzhLUWlxUVNOU2hwaFA5UWlDTkd3RTcwN3NKRmlTeXZO?=
 =?utf-8?B?OXU2clZRaHlCYlhnLzZzb3hjekdGRElBaFNNald0NUFabldNNlBFcTVHSHBF?=
 =?utf-8?B?cDNXRHNuU3phMmZhUW5FY0ZzbjdrSG9aUVhGODdWdjVhMDUwWjFzMVVCd1dC?=
 =?utf-8?B?dGs0THM2OXIvL2hza2xCNmlHcUtvVitzcEJxdUJZQjI4ZkxseUcwYmlxcnpI?=
 =?utf-8?B?VEdXdUNzOHhMc1BTcXRXV3ZjM3NRQTVKQnV5a2ZjQlcvZG00dVJReFZIUVVy?=
 =?utf-8?B?T1N6eWNXbVFnLzF3VUZUM0hwNTM5eDUwR0t1V2Y0M1h0eXVTd2x1c2xIazl4?=
 =?utf-8?B?SERwWE5OMUVWaXVuUGtuS0hBWUcvdjk4c1F0K1dFbnNlREdkZ2R6T2I0U1gy?=
 =?utf-8?B?SG1jbituM3pIcm5MdW5SNlM1Z1pZc2I2azdTdm01dlpDQVFERm5ZdnByZ0JP?=
 =?utf-8?B?NGs3c3Ezc29yS3NOemtEK05oRE5KT0FLY0FHWmc1bVBqbDd2Sk9wb2tlNE5u?=
 =?utf-8?B?S2Q1YlhkQ05vZGdwS0J5S2Mza1VIWEJ2V2FUb04ycmtrM2MwVXp5M3FqL0dZ?=
 =?utf-8?B?N3pLalNZTmNBR2JwVkFpcktsRnlZZ0dPSlFGTGJwTVJUdXpzdHhuSUUrRGRt?=
 =?utf-8?B?Yk9DQzdsM2t1QnIyRExHbWsyYjlaeW05VTN6UVhMVWxDN0hZcjZ3R3hla2dS?=
 =?utf-8?B?S0ozMXRzZjY5QlBSTE41V25UTnJsV3QybVUwem92dTN1c3FMTlUyNGVXZlkz?=
 =?utf-8?B?eWt4c0V1US82TlhDcWV0WlVNYWFGNWJsR0xUb0VscVpvWEN1Mldtd2d3WDJW?=
 =?utf-8?B?TXd1RnB0Ny91MzJhRlp4MlRiOVVOL3J4dTZ1UU83ekdjUFppS1Vlay9tZFNz?=
 =?utf-8?B?MVpncktibE8vZktJeVR0emhOQk9VNmFLN1FlcjRseUZaaytYSDB1Q1pnTSt1?=
 =?utf-8?B?RVBLMTdVVWVRTXFxYW1pWnRJZ1JRQjIwS0ppa1l5VFcrWVJ6cWNqUWJ1bHlC?=
 =?utf-8?B?SlNCcEVlS1FnZE5KMDVYdEJVNVFSbmNQS3ZuUWhpcWs5K2h1SlBUUUFHVUtD?=
 =?utf-8?B?VUNjUnQyT3pqOGE1aG5jd0ZKNGhoaGsvUFdoU0NxTVJCMUhtOHFJVGNrQmhF?=
 =?utf-8?B?WFdLdlVmcUt1YW9Mek9TZ2ZxRHNMYlUzNXJFWDV5SHFFTWQ2amcvTUZNT1Vy?=
 =?utf-8?B?ZFU3M21wbjNoZHFZODNtWExScjAxOFJ0ODE2M2pRKzBwTkJ6cDdCbnJndFp0?=
 =?utf-8?B?RzNCUERERVVxeWNMdXBSanEvcG9TdmZGZHJJaXptUXNsTlpobGZMQXhqMUZh?=
 =?utf-8?B?M1ZlRDF6bDlEVmVEeXc2RjhGbzFXcFhQTFl2aDd2SmVwdlQ0UVYzUWhwZHRN?=
 =?utf-8?B?T2dhMG1LTC94Q1dOa0dlYTFSNktScjA5cWZjaTRZbm93SklNR3VDYzlGQ1FK?=
 =?utf-8?Q?zYr1I1r4/DBT0KrUzRrGP9kbk46Vif/TjGqEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUdEcU5RdGJvbTZLMFgydnFSRkRpbXJXUW1IK1pjRkRkaUpMVDV3blljS2xU?=
 =?utf-8?B?RTVieGI2OXlKWXVNUHkvb0laMWpLb0lZTlliR3NMdjM2RDNnZTdaSU9xb2hB?=
 =?utf-8?B?eG55M3E1WWtCenc2WEZVY2xUdWpscTlEeVRieTlZZ3lWV3pzazk2Y3VnVGRn?=
 =?utf-8?B?QzcyM05sSGd6RVEvdFh0RWEvKy9tVXVPUC9obWRIaFBwRG1DL2x4SnFFMndM?=
 =?utf-8?B?QWZPMHZlb1I0bmQ3Zmt2QkNSWGJrcVdvWkVSTmVwK29BRG5QSmJKNCtrZ0My?=
 =?utf-8?B?TGhTVkdIRS9Rb3NRNlVONGpzeFlHaDUweHdnd0ttMk9EczFzZzRoeGtTbTJ4?=
 =?utf-8?B?d0VOdW9aRWZ0NmVMQjJ2RXE4QlQ4b0lYbUJ4ZEw4RkJpaXlwby92SVdrQXI2?=
 =?utf-8?B?eXlJaFdwZzVEamRUNmJ0b2tSRFVHNlRZTmxCNlplUC8vL1loSk9yc3Mrbkhm?=
 =?utf-8?B?VkxOaWhURFc2eWUwbU1NeUhZbExYREZKQnFmUGY0RnNjSHh6K29RUGYxTTRw?=
 =?utf-8?B?Qk5OeXVxYWdidmNueHNGTVlTTlNMSWdZeFVTaXYzMTV2cFh4Z3NHU2dYY042?=
 =?utf-8?B?eVZKNHlWc1o4U1hPMnNCWG53dkJqSHNlWE1ORUdjNUhKQkZoUEV3UUtOK09z?=
 =?utf-8?B?SmxaWVBUZXVjNjJuY2dqeGllTmI5ZXcyOTh0LzJkUW9wTzFKR2lmOWtRdWdq?=
 =?utf-8?B?TW9QanZWaFVYWWhUS25ySW1PR1J0dzFQNjZ3ZlJzUDZSb1d1ajZWc25iMExp?=
 =?utf-8?B?dytEaHAxZzk0YTUzaDk0ak1GeFVMQ2FRUmNXVkRZMDRRSjRvVDVSQWo2eU5o?=
 =?utf-8?B?LzJIQjN2N2dRck9OOHVsL1dhUkI2aHBlbHJiZno5QSs5Sm1jaWV2Y0hQT1NH?=
 =?utf-8?B?eHh3VlVtVWwwOXphVzcrSFdtbERqMmY5cDFyOWViWXdEamcybWFXKzFFczhl?=
 =?utf-8?B?T3VPTDNmdmtxYU5GMnBMSE9hTlMrbC9tZi9IcU9CU3Qxd2VTYlRMWWdFUzc3?=
 =?utf-8?B?ODRpbVpnMGlGU2lGS1lKRE9Td1kzcDlrYW4wSXpjNUhRcHRTeFFoVTV2NWs3?=
 =?utf-8?B?enk2c3pOcGVPSEpyQXRydDNVc09yMjJZS0FjVlBXQlJvNUJlRWE1QmtISndZ?=
 =?utf-8?B?YUVQOHFnUTRsa3ozMjRJS2NYKzByalVHdzg3YnBhcmFQQ1RXQzRwbk1vdXBX?=
 =?utf-8?B?aDd6bjRYd3J3M1pTVlNSYU9Sb0ZVOTBWblpsbHk3SG1NVENKTjVMTGZURHYy?=
 =?utf-8?B?eWZCUm1qcUo5blNRb0xUU2hZOE9leW93Kzd6NkF2MCtXRFhSTTNYVU1hM0Ni?=
 =?utf-8?B?ZkdESmxiRDRrcDUzbGhpUU4yRWJlR2VHR09mclZIc3ZMbTRpRnNqRVRyRkZG?=
 =?utf-8?B?U29SVG90aEV2aEg2YUIrZGkybTRZb0VYZ3prMklNcXdYdmUySW8ybEJ1QW14?=
 =?utf-8?B?VG9mZnZzZVc0eWdEc3hORjBqNEVScWpETWQ0SGJUNmNzVkk3d1VNUnp3RUI0?=
 =?utf-8?B?L1B1SUpqQXJWMVhrdkQvT2xHTTJRS1pxWEFnQ2dsZkV4SEhoOXVEQjVvbndm?=
 =?utf-8?B?ZDBHSW1CK1RiLys0REowbkgvL1NWdE9uaDkxZ0k3MWFFdlRGN0lZdGpvYnVE?=
 =?utf-8?B?cHgwOVdEVStjenBVMXBDNUtpQzIxd0lpVndHNjJ5ZzBJYnZKekVHZDRjemUr?=
 =?utf-8?B?a2E0bExRZDdRa3FkMWxMWnVzV1BjL1hXcCtIcVBHdkYzTmV1UkM4QWhPdGhT?=
 =?utf-8?B?RnBiSHg4bFA2V2JtNVo0cXcyZ0pieWlkOHBQaUxVOUtvSjY1UTlVU3ZPWXZG?=
 =?utf-8?B?NklMaDJjc2R2bWdtekZnSzJlWDN5Rms1Yk5uSURjcEoxUEFzdHFJYytwK3I5?=
 =?utf-8?B?VTdMcVdVWEZBcHVFcUtVNmpiRFROT0ZCa1laZS8vWVM1MFdMbldXNjdDZlBQ?=
 =?utf-8?B?QXZNVlJ1UVZOQlBMbkhQZy90b1VYekN4eG45TGtXcjZtSWErYVNLSVZsdFV0?=
 =?utf-8?B?NEM2RVhKbHRKckhKejg4SWFEZFNvYXdSTm9FdjBnNEVMY1QvNkltUE5zTjNh?=
 =?utf-8?B?YXhSWHlzWWErTVczVlBuckVMWEdOUGF6cDY4QTdnSHB1UkNsUmNsZUY4MDJK?=
 =?utf-8?Q?m7ticaZ2WTU1T6KGsN5h3XgLx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31c2550-d406-414e-01a4-08dcb07474ee
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 08:49:03.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpViqgO+cKRRd17qrsXI0V98xjXogMcNxcL8P+shQq/qH9ad5Gut7imL280LCV3h1mxpG3zvsdSFj5ZN0vhN2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9021

i.MX95 PLL VCO supports rates that exceeds UINT32_MAX, and the
i.MX95 System Controller Management Firmware(SCMI) server exports
PLL VCO for SCMI Agents to configure. So introduce
assigned-clock-rates-u64 to support rates that exceeds UINT32_MAX.
And introduce of_property_for_each_u64 to iterate each u64 rate.

The PR to add assigned-clock-rates-u64 to dt-schema has been merged:
https://github.com/devicetree-org/dt-schema/pull/140

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Add R-b for patch 1
- Rewrite patch 2 to avoid duplicated code. Patch 2 not use code from
  patch 1 now, but since patch 1 is a helper, so keep it.
- Link to v2: https://lore.kernel.org/r/20240729-clk-u64-v2-0-ffa62ee437e6@nxp.com

Changes in v2:
- Follow what Luca did to of_property_for_each_u32 to write of_property_for_each_u64
- Link to v1: https://lore.kernel.org/r/20240621-clk-u64-v1-0-d28a611b2621@nxp.com

---
Peng Fan (2):
      of: property: add of_property_for_each_u64
      clk: clk-conf: support assigned-clock-rates-u64

 drivers/clk/clk-conf.c | 42 +++++++++++++++++++++++++++++++++++++-----
 drivers/of/property.c  | 23 +++++++++++++++++++++++
 include/linux/of.h     | 23 +++++++++++++++++++++++
 3 files changed, 83 insertions(+), 5 deletions(-)
---
base-commit: 233a3e45c39db1e52061f3b6bbab9c630845dfad
change-id: 20240621-clk-u64-70c4333f0f80

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


