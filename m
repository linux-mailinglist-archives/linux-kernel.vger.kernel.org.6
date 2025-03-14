Return-Path: <linux-kernel+bounces-561738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B4A61583
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F43F18916EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE2F202F8E;
	Fri, 14 Mar 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="XRBX6Ek6"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2103.outbound.protection.outlook.com [40.107.21.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA828202F68;
	Fri, 14 Mar 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967851; cv=fail; b=QIo4UbWpso6I82Ir7VPeL9Jisph/FdX8e2/7j8c0yz2e8tbkEkSndb33cBl5cgm2sRt4R0xg/VmfzBT4Zkdg/DPuk/XjOffCK2kJfhxG+6rqnFZz1bmQYUQYSh61eNI94VarBozMOKBOF7v8LKZWZjz/DQhE72hm61Coqgd15pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967851; c=relaxed/simple;
	bh=+8aWQHFJKgL0Z9kKWOBIbCOZOBFzWH4n43VHiaLo1pM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=hxSbKqqwEI7MoYSGHlLofsYoMTduuDiZt+OVHOsv0xGo/8OwbOMmKKUt363BBIWL1HmCyaaPvLIXcxuchnIIf63/w5b4DVlov6aXVS3w6qdiOT2smIU4aB54naWuKQf3k6NcSQ/jr5m+te4+2MDeqDjXcO3txOgQeHtIIknPAEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=XRBX6Ek6; arc=fail smtp.client-ip=40.107.21.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyJnlkgWybYLpiJUlyClj5Zs+yZ6Cz8xNceCeJY5WvVp7G9Hdqeandz93kaTac26Del1XVX1n8ajq3Cherun+wZLB2dc60aztf08AX8yQu/5wqiLMSH1NHNiEvrqZ+t4fYH0Nf+8XryUFl8j2YdtrXUiHf1el78HtPg0VjN96tV+4MQeef9+BH4VPAk6Wt3QuCInyYkTkTB54q38kMqu0jHLatMBr6rbjtIJiVD0CB3ZiPRawJzlVO1t1m+wcv5sXcGZhvl4jjAxbExV4iZ2QHetdTNo1+IhU6CoEnBQPnSP6Q//Q1Qr2pVowWlytmjmflJkWr0jxkRL4rMDh7eKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u6ACJguM2fg/xmdyUZx816u8Ic265oJlGMWZi5CQZk=;
 b=junsWRtZ4pQF3AiGOfuE4kKVj4brgKGHrEkVLJRiMUuFD6ta5GJa7sWMUsqPSvHZnVdcNHhDoZbYRp5fD0RAvGbiyEJdvV7CnDYrhtJsKBho6r2rbcrTCWGlRs1Qdb1KCrdjyzzrsqHCc8dkeB6nIGU5TLhWOj755QpV8cp5HpE1KhSomDexMwGgMMQ1mJfI++MYvZ7Hc0aD5dKlnHcIorocawccMmI3lcoMoJhlM5rWvi4RGiBVXKoAC3jlGHWKftD6I4T6XEwns5MtZPPlMRAfQW4UcxsDvfT5Gj4fesgxfws8grlI1DTTQcT8vqOfYcxpMwndzvzPAY2IEoGwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u6ACJguM2fg/xmdyUZx816u8Ic265oJlGMWZi5CQZk=;
 b=XRBX6Ek6ZS7MENwK/ZvSQtDhFq+AEfnC2sexde90CIvv3QowmBYViyhUQKBg+x41U9Pl1K7t5hy6NxALonhlPSz+aeQq89UlKB1qb8AN1v1OUcVE756dEXdl8ff57CGvc/Rt1BPZv3DPp0xdqzIZHugrw2bTvxp0NysfwFSFNwoaqxGox/+6SEValMvhyKZtQKcgaG5GSpLA30H/qCDL60cTROFu6xTOU8abcKLxD7F2msZ+93EnSKmfKKXHYwOpOQyb/ta3eUuJuWsr02Exgeyd7uXHH+cs9pR/NNI2TXMi3TNymrqpy1tuj1+ZaHJ2AF5WjV4Zr5jf9yJxauwYIQ==
Received: from DB8PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:10:100::37)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 15:57:23 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:100:cafe::b5) by DB8PR06CA0024.outlook.office365.com
 (2603:10a6:10:100::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Fri,
 14 Mar 2025 15:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 15:57:23 +0000
Received: from AS8PR04CU009.outbound.protection.outlook.com (40.93.65.25) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 14 Mar 2025 15:57:22 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DU4PR04MB10551.eurprd04.prod.outlook.com (2603:10a6:10:588::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 15:57:20 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:57:20 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-usb@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
Date: Fri, 14 Mar 2025 16:56:07 +0100
Message-ID: <20250314155706.31058-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:71::20)
 To AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DU4PR04MB10551:EE_|DB3PEPF0000885A:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 69978eb3-3b50-4b82-8fd4-08dd6310e8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?hDje5x80LsaYEiqNbcBfKm0LIgbuiFK6SDUA/AOVpt1j58ssF2hx5Ig98QFx?=
 =?us-ascii?Q?mNUui6oYzqBZczlRzmIsDD/omQ7wSOHvwz61s935oQ53gjQUIhVvjg3saMHF?=
 =?us-ascii?Q?OQlccqXfXBLeBqFP6HvoDTtFcFD3rGQGSWyBYV7uNqcKY8sUvVYQFZvyDsD4?=
 =?us-ascii?Q?MF7V9UIgjPYBoSIrKZHqv5H/4XjP5KOcmkMawkNad/dtzY+KVrd3ork/lw49?=
 =?us-ascii?Q?vRd4huQ4n55ztVVnYxyeuSjMIs3AzB3XcMQdK5s3idl8YOxPjw8gcMKlpVlc?=
 =?us-ascii?Q?7RqXJe3ndhKITx8giuY4MEg1T3xfMClFj6cFbjEmaBXTLD/iykBzsJCCPBk+?=
 =?us-ascii?Q?pMc49cT/7fzG/yzBoH0b3J38dtEW9XpQ4gE5jeLNUHW0SUBXORlxmw3cASIJ?=
 =?us-ascii?Q?ed9LCSZz5JSAjI2cHOB2sz9Kw5K0XclqAdlabCxl7iJHaHGt20QpskcXs5i8?=
 =?us-ascii?Q?Pa/H4tpbIoUJbdjz5K4Rtkz3iCSPtEFQM/7wGOcRj3WOv1JFpp00KywjXvkV?=
 =?us-ascii?Q?3FOuv45RBrh/bOwWVI11wb7ypo4KpNvH+gvdjAB8++RS6XfOjrunUrpqtCOB?=
 =?us-ascii?Q?zhK+Lt60mWC9xuKIcc2H37DAIhdL1UC2vuppnRBpHTbAZpm9/3Fjn2qUfrR/?=
 =?us-ascii?Q?PWYApC/XwRejVZUWXoxJ6xpUs75f9PSIfYTCAbNjILaPtiRU2qnLY8HacKX/?=
 =?us-ascii?Q?JarLmSU0AqlUEodAszMJou2Sm63dIYuxgTW3RCK94EeJhTZStG0vQAbZX4pb?=
 =?us-ascii?Q?yCG8JOl/rn7QKniHgW9RuyiLb5OqHkvzFNvYbRpxvZ208QA11FOpfMi8hnR+?=
 =?us-ascii?Q?sdAT99HWJH0bby07oOuBKv6SH+464cDPQd1JrQsS34H/kmUdfF5gwFw9FX3A?=
 =?us-ascii?Q?H8TYUeutQnyI8OCmATVx1deK/4urtwf2xGHxkXQglzdq0Y3yN6nx/L/yUf46?=
 =?us-ascii?Q?5wRWwaNZPhFbMejE+5EzdW6/jQoJjE6vYR75gdEAHCeP0/nlmhEtR9qxcSbz?=
 =?us-ascii?Q?T0bBbzjBaCkVJZp28Di7X0+gQyfVPUgIFH6ME6Dakk4Wg6iTzDIzHVIXGev/?=
 =?us-ascii?Q?kXbPbzFGgmwx5NPH9It9MghtC3mne8JntwMAY+NREn+0BatZ2Rw/8ankNm+d?=
 =?us-ascii?Q?I7DUd4reodeTtlTNm1SeHYChed3ViBTZi/2hF2cGA+CGylrew6HmVmjLON9t?=
 =?us-ascii?Q?pvft/d5Fl23hWDLS2GadSpP9VdWI56q79+LD8NflSPDfL6k/NejPl2VTV0Nx?=
 =?us-ascii?Q?/XzHhbN1VzUkUpY8rE4qN4vj/Oe06fKxDxos+A0TkMF/Bzqcf8Znt/4geGKT?=
 =?us-ascii?Q?86tZoQilQSVwGl9R5j7e1dKOAu4ACzvEbp+gh9r1nhZ8AaftABj9bOB3Liuy?=
 =?us-ascii?Q?RZmA4xKGAytUHvkguDRlazQeZP73LtsmYF4t+2iTVKLrZ2Ly4gBlNDtCVozM?=
 =?us-ascii?Q?0/6/WlW/YJUpPFWBmQ3Z7fapGHtkfaHx?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10551
X-CodeTwo-MessageID: b632717b-cb95-43d2-8db4-82a892c667a6.20250314155722@westeu12-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.323aeebd-1577-4c21-85a6-ff9262fb6cb7@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5f99a40f-66a9-41a2-84cf-08dd6310e70e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|35042699022|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1CaY9GQKFb+27SQ7GvIZR+nEL8ShKA+9JyW5F30bmQ1f2LIerxVzjQ9N8YQD?=
 =?us-ascii?Q?EE2Wp9GgAGmFlC+VUXXDAgd1lfbqbWNdckzTZvdmZrs3U0SfAA+LLJIl9dvd?=
 =?us-ascii?Q?7UPofnwC95sAOGBG8yaGkhGPW+DMGWoTyb52y6VXz3QANgpY3x11V6D8W6xH?=
 =?us-ascii?Q?ePiCskoMdly2UV9GL3GcoEEl/uHI+N9tYEbldZvZiW6NFkQMfqSN+vRMBCfH?=
 =?us-ascii?Q?WqbKQ5boAWc2qaDph9ydibctz7clu2X7IMxnC1/mIx1eO7Sj1Di2GPyFtABX?=
 =?us-ascii?Q?rocyC2JQq2Zm7W7piE9FMrV+XlZStEQC44zrZpdAUXs/mFl9qLJoqAA7c2uz?=
 =?us-ascii?Q?ni68FJzd9PEhMIMCGM9tFdoAp3TklfoXESboNlvXyzR8hyVCCJd/JgbfmlGa?=
 =?us-ascii?Q?uGSLuwmEibnVpRaNZxw+STwm1Iv+qeLn1U47wA+SDRL43fPVyK8TENmyQK6h?=
 =?us-ascii?Q?uxSSFWWdthRfiqncatH28zTG/Ucy3+o37st8TMKYviHzSi2YBPb/V3rsB1i7?=
 =?us-ascii?Q?EMuKbfb1IiLg502iFlSNzQorS7pHR7UYTmrz31JMHTmGkYIB1njdb7PExQhn?=
 =?us-ascii?Q?GgmxrJDyX5HWhvG+6wcmJU3ErkXdTxQCpkRzpcO9fI332I0YCFsIdfAS1nJP?=
 =?us-ascii?Q?rXOvTxvghiSHT9BqXhtmda+4XbTdh6ZnVaQYAQvmxIqHQEaG//yP4OWI46g2?=
 =?us-ascii?Q?VuUdRi5L8WXizbMt8kyUbZWeqkiSPzmhVWGvHr6NuHkiZDalLjjvYK6lAgmk?=
 =?us-ascii?Q?bxWG4x0V27RP5FMYthQCtS4jES8PzoFaW+i1wlVdJvrZz2a5Pna1wbDkSweY?=
 =?us-ascii?Q?K4MEFcXEkDcTyAqim3txvtwNW8XEkF9sDgG2W5DR7eUFdiICg7B7a8M4CxUS?=
 =?us-ascii?Q?9OZ0FiB2txTJ1+mgVMyurJ8sdjuoLH56RVR2rPa/5U1tZbH12eCed3m20QIj?=
 =?us-ascii?Q?CM4wakVd4quzuGpgNgcsk04zMtsWokzMvTxXwvN+h0Fsjjo48/vRxh3S84Nr?=
 =?us-ascii?Q?/bDIIVdoFQdfJlpCO4B5j8a7wYCyu+Xz6nno/M3Cm7yVhPw7spC1HADpNEWv?=
 =?us-ascii?Q?43ngEQmXUUjIOnUgV38ARmihlp36tgnIyaYOiC5a7MsG2/1LgAH64xD2aoWA?=
 =?us-ascii?Q?+9SPZbZdP8k7KGLdVPSh8r/SPGnMYkGG0EMqflidhJb+ttCvXu7UFGWklUnd?=
 =?us-ascii?Q?qwaO0YKqphCaMUeVn5waRRo+f9CeIG9ZMIRGeBRXn3S29sLc33JCYM7Ofq40?=
 =?us-ascii?Q?ahXvrcTDLbSpuLV5N9szd6biadO6y7RSF3eSxaVSRNr8ye37ZaIPL3AEmxLd?=
 =?us-ascii?Q?bFbEK95zslxU+bd1IzFG7C9NTdsWetSCn3cd3a0R4PSLuHeVoz0B0W9uDMr+?=
 =?us-ascii?Q?oEwtpldxQvakJEGEBvFBymQ2kncF7xUfXMlZNmTVyGU9yg1GkoHCY9nRQ0qG?=
 =?us-ascii?Q?Jid6OCq2kZw=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(14060799003)(35042699022)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:57:23.0879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69978eb3-3b50-4b82-8fd4-08dd6310e8bf
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238

Set the gpio to "high" on acquisition, instead of acquiring it in low
state and then immediately setting it high again. This prevents a
short "spike" on the reset signal.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 drivers/usb/dwc3/dwc3-xilinx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.=
c
index a33a42ba0249..a159a511483b 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -207,7 +207,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv=
_data)
=20
 skip_usb3_phy:
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
-	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
 		return dev_err_probe(dev, PTR_ERR(reset_gpio),
 				     "Failed to request reset GPIO\n");
@@ -215,7 +215,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv=
_data)
=20
 	if (reset_gpio) {
 		/* Toggle ulpi to reset the phy. */
-		gpiod_set_value_cansleep(reset_gpio, 1);
 		usleep_range(5000, 10000);
 		gpiod_set_value_cansleep(reset_gpio, 0);
 		usleep_range(5000, 10000);
--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

