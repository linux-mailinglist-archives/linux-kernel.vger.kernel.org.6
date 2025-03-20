Return-Path: <linux-kernel+bounces-569567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BAAA6A4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B599D3B8243
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E183121D3DD;
	Thu, 20 Mar 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jL+tGOyg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jL+tGOyg"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185D21CC5C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469496; cv=fail; b=o1n9qgXIL6cZttJJUU2JRVT1vcyvaw+KfqnQAURR8enYxuPaCOR19343Xefnj1ZvXPsIeDUfg/x+t4SWBkAPeqsdoAyQZsb+nGVKoiOPDGxVguEMKbMQ8Ovy6VUp92NI6cjeFZL/+VjYZReyDHNP7aGrANACl8oAwQWvM0ai5DQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469496; c=relaxed/simple;
	bh=YDZLeEH6BRszqA2U8n7YV7WwNmiiiPRXiPaLgxWEh+0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GleGGMdHJEAqiODosKQKUY3ptR7D1B2OASKuXrakbUF2ACEjYHM0Y1yUBott0wED3HZ7R4l2P+zuVOOPfoxmuFGNPsBQdLtIM5fRuzsK9JhWgv/49NtzlsN7kQntdwj6YeUJP1NMO9n4qo2NeEdX2YFue7qB6EAUpqaRqAPkFYI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jL+tGOyg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jL+tGOyg; arc=fail smtp.client-ip=40.107.241.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=W0R2j7uJAE8SBVXhY3yJfFxaNWu8XH6hfgSv2yg56jtt85MaFMvk0ZQLhRxfpHk+e91jTpwBR0jBxRsZvSisl8Pht29kkMF6YnrpyUAg5netZxiRpcq55/jx9aJ55BQ0XWfQli8RyicwWfMSWK4aI8yfHBnnDTGNpQqtG1bvT9hhk3deNWBf30QFEKvVGTa+6oPyPgp1o3DW/fJnFYXfTokqoyvrSpDTuMa3Z2KwNUFDhLpnds6MdTuHDm9FLrz7y/4yZ3+OAqw7WWVDg2RonuB0nXbuQ3qcIlxLR2vW7Yz44vsw9q6SQXoE9lHDhvkDfjptuiAet3g8Nbda0z0+ew==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10bX34gem5db3oxym6zErrelI5uO1/At+8Me55n7X3U=;
 b=sHojHQpRg8M+NfkAIvkMhlT7WxRqrslkSLJaTHjUj2zR4BQT1e0E5I3p4mkZeWbirVaSFz7JIZlH8F5YzcNETwuYOxv8un4EK5+/wxDQ2AIqlM+RU81uq20alXyMvREUVEbbjBIEmTxNOVfzHGYUA8tlCmkpYQ6TqEpLfkAYh/gTh9L48n7qDrL0ZAh/a4yC+RII7euPhqyZiEAaca3zuGM+NgZTKa1AqbnMT5MnnRuj0+NlB7Pb1Zb9fgyxNNI3J+/zKMoWnq1JayZGNJhXQwj85Hx3PvEphjmwQvvC2ni8oJDAG2zZo3khRfjbJlep69UZDvOxoxTQDGzUMy4mjg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10bX34gem5db3oxym6zErrelI5uO1/At+8Me55n7X3U=;
 b=jL+tGOygtLnvW0tm3na8UGyqT4VYj6hTsGzL/XldcljVc91ihvk/p7xNHRGNjX5NA+1YF6fZSNsU68GEgCxOiZK0AW4G5kVL4R6N/Kt+GBnAqtb292koLSXIbs6JMFhJvgr8jzL39YVxjo/+9Pa87Er9qxTRklbXgA2hIfTqNCY=
Received: from DUZP191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::16)
 by PAWPR08MB11086.eurprd08.prod.outlook.com (2603:10a6:102:46e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 11:18:11 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::af) by DUZP191CA0027.outlook.office365.com
 (2603:10a6:10:4f8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 11:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 11:18:10 +0000
Received: ("Tessian outbound bf3b9ac19d92:v597"); Thu, 20 Mar 2025 11:18:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ebaf5e1d595e2a89
X-TessianGatewayMetadata: DglCTIocmImtVX3Vu7BXAXKitJ1LNpPTnKsYUM9oA89C4ZHaTliKocskqbXM7LzXE1o21KOWUw/5Fry93ZFmC562zVN16rD3spPiLp9zWsr9QP/2qoC0gbPfbwp8dWsUSVsr3BvN0AOO2/QFspodD1PcjnSyUp3HBEfyoKMtGGo=
X-CR-MTA-TID: 64aa7808
Received: from L975582a22657.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 95F7D3FA-A07F-4F84-9450-1FF2A3A88C14.1;
	Thu, 20 Mar 2025 11:17:57 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L975582a22657.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 11:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jogx1Ui15MRqdnIEWJfMc3JR9HNF2zn9OpIBvZpFYefLmwDbvLRqM+NXlcNcjvfB4fmCPM4wZcr3MMcgSEzNIVjwNRTkSuIaLTUyvb2HBqrpw/wELT2L9R4dbFtMCJ5t5iCDqrJmC0hRfcgmQ7KKFxxbutLkzSsw4eoT66Nz76vA6XNGaTtrMNRWkTMs21iB161lpkw3sqKnlQkO5gYJFgGk58skN27CDTqwZGwGW6dQT3xh6pBjOCJ/JEgzLRAbs9Mm4+UwglKDl45UMfbqyjhZZcxeZ5Eb9n0wcz8x8MlUbGkeA0jheoNJq6tGaalwYdEMBQSZFrBWaI5Tgmu3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10bX34gem5db3oxym6zErrelI5uO1/At+8Me55n7X3U=;
 b=ScOblR6uRPZ8E76Bap58TuRNuuSUMKUh5QppAZfDZVj9tW/M1pdBfP0RVPzCP03im1ITUGwVfm8ydK/rfvuajlwq/xdVYM3uMzcmityAAQopNw0q5g3zVGjcyJqOyU48eZeE7xoRPmryggNCWjxGst2//Ft9reW4369v/SJhxplApGxKrfDftGBKsPF+7r4MTmlvsFFk9M0YHpuU7j1zhRR/4YIgx/Fa82xTuIA/apY2hsO0mt3o+0e0AEwN3ccTS7ZDN5j1vhctwXQWzPghjfXpI/V8+cz9LUslnrSnVQqOWyBgDiwB+OJsAu8uLctvBQ+IJ2ytcHGpSrojskE3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10bX34gem5db3oxym6zErrelI5uO1/At+8Me55n7X3U=;
 b=jL+tGOygtLnvW0tm3na8UGyqT4VYj6hTsGzL/XldcljVc91ihvk/p7xNHRGNjX5NA+1YF6fZSNsU68GEgCxOiZK0AW4G5kVL4R6N/Kt+GBnAqtb292koLSXIbs6JMFhJvgr8jzL39YVxjo/+9Pa87Er9qxTRklbXgA2hIfTqNCY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS2PR08MB9074.eurprd08.prod.outlook.com
 (2603:10a6:20b:5fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 11:17:52 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:17:52 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] drm/panthor: Add GPU specific initialization framework to support new Mali GPUs
Date: Thu, 20 Mar 2025 11:17:32 +0000
Message-ID: <20250320111741.1937892-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0556.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::6) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|AS2PR08MB9074:EE_|DB5PEPF00014B92:EE_|PAWPR08MB11086:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a89993-4d2f-40d0-1336-08dd67a0e5a5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?rHW0eXN77vq9q1NHI/PduCsxuXYzWNlkGqQn3/mqzB+28NEOqw5kqo5liBjC?=
 =?us-ascii?Q?FsLyew23S0jPvDlJDOIGPhMz6goJi98k8WC696F8tVHsN2IcJYoQatZka7m9?=
 =?us-ascii?Q?VoBqckAS0M2hkydLLNPilxFic1VMgPWAqQEA5UTrPcZhbZCNAOujyTjn9jHt?=
 =?us-ascii?Q?Jivua5BGet5M0UJKN61NJivSMuzFYUJH338TQ5grJy0lzC7jdFluMUU4pXA2?=
 =?us-ascii?Q?/KzNt/9nPbqUkAin7KiI3lQkxSF+BqqZ5RLxaJ3oRyMU4MwXWr3O0yeaXrv3?=
 =?us-ascii?Q?X39dvCb5ZxBO9iqolHUAfInNWb0vupKKStnATPIPEd4wpWLXPkh1aq/GmySO?=
 =?us-ascii?Q?dC/gq13YCMqezzksBRlXVY4WFPpnBeecEUSlNZd5T6eTROzN2C5BepQIgkG7?=
 =?us-ascii?Q?r6Jh2XsKaGqhnDQGGweaNJ5unR+c+/yRjWT/16VQsu5na0j4WoxyDF5biC//?=
 =?us-ascii?Q?sMUbe1sxq5ZIXWpUwxg8hbO4f92kdnG1GOxoCftitU+WuPo9DDZXIZODNReE?=
 =?us-ascii?Q?H6wqr+OLZu7vUBnnTqtU+4vQw0kX1lSwUsGxYpwpgUGZkHmt89Dr9Lpga3S4?=
 =?us-ascii?Q?vDDfj7C+EvgBAIWoij6OlOT5gbVCSKScMXZTvIolnToKiMfG9QYUhFjfRVyd?=
 =?us-ascii?Q?Zl+PcIQhbagJlbqUNKEjriJX/hKZGPhao8M4lgXVZYUDCHBaTCq9BfwZpR83?=
 =?us-ascii?Q?sTdln2pK4qOlLJEEp/kriNcnmoSbeeqTLiwKowJrkTHv4duaFx6sD6/Iknwb?=
 =?us-ascii?Q?KXi+tlo74Wm4kURuh4lHbd2fyJFsap6OxF+m9Jn8i5eKcdzOYOwMVn3nYSw3?=
 =?us-ascii?Q?Mq5N+A5IL2yXwyFKFBaZ3CAK5IRoz22jbmtFKQybIyfCs3OfxtkTChoQ+5uo?=
 =?us-ascii?Q?EiouK9qzehOII7fAt2Bgb3IHlvSVZD8+jMYU40B7pMIH/taRL024m1oZ9r7z?=
 =?us-ascii?Q?3yzhgPhWoxzLbluh4Nz1DtOyj/oKqhnlPSsBlr0hZ4mzZeDN6wupVL1wnmWI?=
 =?us-ascii?Q?MPuOcKmKJq6EABIqX/0xq09eDGUD6Pn4pWpkHFdPRbSyrAcen7FJjLctx+iB?=
 =?us-ascii?Q?6t0aZkgrEPxteeLowNvc0VKY89VzaN6EpEClNX+pcgQoh4806JAejJJzZyKF?=
 =?us-ascii?Q?P5N0Oayz90vG4TztpFpRu67U+qKuBkbLte+XC/LwR95N5a6bBJmaS2my5hby?=
 =?us-ascii?Q?iZ5Eo2J3Pis9kDby9STKYLZvKuumjvoIqwGpC4qDTMqBeWFdoIXWfkPuH0Mq?=
 =?us-ascii?Q?ZzfyZFJFL/1It0vDr44iGBRXAm/xdyLwIGwXao+G+CQQa+FA87C7yF4HNWHl?=
 =?us-ascii?Q?3C1RmtyKf5Nef/d6ileImudpi/4blOlOXDOs/gLrERtmIe2ySYNn5oBwxOhc?=
 =?us-ascii?Q?zaIGpYTiZrvpSp0aniWtpPB5eRuU?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9074
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:800:257::18];domain=VI0PR08MB11200.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	09db6160-5031-4781-9206-08dd67a0dafa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|36860700013|14060799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQI0V1Zeag9jLwPvNZWYcWq0GLNQkQBkBF6b+FdlvqpUonLvFUN8QKMQddT3?=
 =?us-ascii?Q?/j6Z/BuvKMnXK1N97mWOllnAzq8zZQywqde3np01p3cnI6jKj+3It9Opb3nm?=
 =?us-ascii?Q?2nYRqZKO+I1ytJGnIhePDWtZIetOWTGeKy3A1tpMOyBpvyzWNIi/Oj4DAB+O?=
 =?us-ascii?Q?YTyNlfRGi+V/vxX2tShYz9JlU90UChUZDp285JSzQrZJWCTGq77yyeMVu3+V?=
 =?us-ascii?Q?yvvIpVsYJXMZ0g702al7B0qWgSLcf0h2paVuzR74Sj9FOSM5X52h6ASyH/Do?=
 =?us-ascii?Q?p0SqKT59byZ5eDRjfqklP0qwiLs1XBnqduNpEBfaeKrGvZvQQINL6bxk5Ats?=
 =?us-ascii?Q?YyDAX/ewqTGG362if5rO0XnyaNvvgkwrl3K34B/X+7ZfSg53TWKCj3S7VK2I?=
 =?us-ascii?Q?cwu9pb3BrutFml2EeBZEJX+x0yRXLl63JzKO+OPTdeYU3Y6/kKTFCWb271D2?=
 =?us-ascii?Q?QrEDsq42b4TKdhP8y9azAdawox2A2vSS4jLuZXzQL/4kkJCbrBFnGAP7xPLw?=
 =?us-ascii?Q?jtQJZWF9DErO/iVlCCN9cYLhs5NL3wgf8c5RkEd2iJb6pEKCMRf/qLiHwK7O?=
 =?us-ascii?Q?4i4u9yOJUJkNitVw+8cyD85EBWEZWIYerDAcoO9T7XJ8Ja6ve3LaIhCOXdx2?=
 =?us-ascii?Q?BPCkweDrE8inq36+f0CWpX3Rfe2IBDH3GipTGnD4bVPPIFBXKuzrhavep2ZX?=
 =?us-ascii?Q?x6xqz6rUk+Op12dKTK2SiDPyxg2luDcDC8fRjPPBwb1D4jsG9r1ANxRAv95J?=
 =?us-ascii?Q?mKwkZm84e+zRMmd7drFt5wQzeBjhI7U5oAyDBKZOfj1x/lr69szBnzAob7A5?=
 =?us-ascii?Q?z4V+PfguSqr0mByTHelue/WwClgJAXhOgM7wE1YjdSu8hed2W2WCFSvqyokU?=
 =?us-ascii?Q?l8ZIlzu+k66dQn6n9ddwA7lpp2rBdYnk7A6CNXpcwmKMkLki+K5dErFMBXdZ?=
 =?us-ascii?Q?VtVKTqbo5nQcLROT0NF9qENE6+HiMxJaAXo+LhNDeg4sHO9t48iIju5rz8nU?=
 =?us-ascii?Q?fzbPo9ZMjzu7XoKoa1QoMzseeBH8b7WbHtf7tjo09fRQPVkUckKGtT7j2xHB?=
 =?us-ascii?Q?K8IPiE6cPPqp82rX4vn+sgFPqRwtZXpSgiEalJ0Wxf/QH2z+xiSBcoXVSX5e?=
 =?us-ascii?Q?P4iiBeRH5Rt7MP+YbLlthOtadSp5I7Gvu2QfnbmK5XyvTfjZK95one5FIcUr?=
 =?us-ascii?Q?GM5zFlgO5G6sEDEgGPeLCYbQQFUqAc425seX8fBXmYhKexzfwsLUJK4A9lOs?=
 =?us-ascii?Q?VQKWk1d7U7YMLpBNdmjXPGNPg5nU5y3dmXTm4D5QRHUdeF2OBMDcpYlw6QlV?=
 =?us-ascii?Q?fe59KyjKbAknJeodzj3GEBRzeJAgfg1VtnhYsJqVTVKXDfR46TQO/d26Q0fi?=
 =?us-ascii?Q?q8b8j/eRzZh0vzHVtgUSdVmmKZwmBhlRHFmjFnfaFWCXDvD1+QUjxrHSqUo3?=
 =?us-ascii?Q?UeiCtVBYuRgORISmGbfS958h3z8jsZCTeveem83FHvxy20AdsGvaWmHSe+zz?=
 =?us-ascii?Q?/ESMKF6j9+81uGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(36860700013)(14060799003)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:18:10.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a89993-4d2f-40d0-1336-08dd67a0e5a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11086

This patch series introduces improvements and new features to the drm/panthor
driver, primarily focusing on extending support for additional Mali GPU
families.

Key changes:
- Implementation of 64-bit and polling register accessors
- Addition of GPU-specific initialization framework to standardize and
  streamline support new GPUs.
- Support for cache maintenance via the GPU_CONTROL.GPU_COMMAND register.
- Support for Mali-G710, Mali-G715, Mali-G720, and Mali-G725 series of GPUs.

Patch Breakdown:
[PATCH 1-2]: Introduces 64-bit and poll register accessors, and updates
             existing register accesses to use the new accessors.
[PATCH 3]:   Implements the GPU-specific initialization framework to handle
             differences between GPU architectures by enabling definition of
             architecture-specific initialization routines.
[PATCH 4-5]: Refactors gpu_info initialization to use the initialization
             framework to support differences in GPU registers for subsequent
             GPUs, and at the same time simplifies and makes extensible the
             process of determining the GPU model name.
[PATCH 6]:   Adds support for the Mali-G715 Family of GPUs
[PATCH 7-8]: Adds support for the Mali-G720 and Mali-G725 series. It also
             supports cache maintenance via the FLUSH_CACHES GPU command due
             to deprecation of the FLUSH_MEM and FLUSH_PT MMU_AS commands.
[PATCH 9]:   Adds support for Mali-G710, Mali-G510 and Mali-G310.

v2:
- Removed handling for register base addresses as they are not yet needed.
- Merged gpu_info handling into panthor_hw.c as they depend on the same arch_id
  matching mechanism.
- Made gpu_info initialization a GPU-specific function.
- Removed unnecessary changes for cache maintenance via GPU_CONTROL.
- Removed unnecessary pre-parsing of register fields from v1. Retaining current
  implementation as much as possible.
- Added support for G710, G715, G720, and G725 series of Mali GPUs.
- Link to v1: https://lore.kernel.org/all/20241219170521.64879-1-karunika.choo@arm.com/

Thanks,
Karunika Choo

Karunika Choo (9):
  drm/panthor: Add 64-bit and poll register accessors
  drm/panthor: Use 64-bit and poll register accessors
  drm/panthor: Add GPU specific initialization framework
  drm/panthor: Move GPU info initialization into panthor_hw.c
  drm/panthor: Make getting GPU model name simple and extensible
  drm/panthor: Add support for Mali-G715 family of GPUs
  drm/panthor: Support GPU_CONTROL cache flush based on feature bit
  drm/panthor: Add support for Mali-G720 and Mali-G725 GPUs
  drm/panthor: Add support for Mali-G710, Mali-G510, and Mali-G310

 drivers/gpu/drm/panthor/Makefile         |   1 +
 drivers/gpu/drm/panthor/panthor_device.c |   5 +
 drivers/gpu/drm/panthor/panthor_device.h |   3 +
 drivers/gpu/drm/panthor/panthor_fw.c     |  14 +-
 drivers/gpu/drm/panthor/panthor_gpu.c    | 231 ++++-------------------
 drivers/gpu/drm/panthor/panthor_hw.c     | 216 +++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_hw.h     |  70 +++++++
 drivers/gpu/drm/panthor/panthor_mmu.c    |  69 ++++---
 drivers/gpu/drm/panthor/panthor_regs.h   |  83 ++++++++
 include/uapi/drm/panthor_drm.h           |   3 +
 10 files changed, 471 insertions(+), 224 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_hw.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_hw.h

-- 
2.47.1


