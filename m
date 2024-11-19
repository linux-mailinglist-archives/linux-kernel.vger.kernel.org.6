Return-Path: <linux-kernel+bounces-414391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B969D274F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F7D2814E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB631CEACB;
	Tue, 19 Nov 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="h9jh3nnV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="h9jh3nnV"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2059.outbound.protection.outlook.com [40.107.103.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91F1CCEF7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.59
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024277; cv=fail; b=VTsEdHDj9gCuq8JTN58XsK0WjrtLluf3fPVxB28wwdbTvW99u6x48OMWD2qrFmxleYuNPgVU6xa8W857mIj/gYKNtbYBlqpH2m7j+7bMv+vOaHoJiVDM+D5LfDq0h26TsRtqQkQBVmFKrtw7flZAPy+KFV9CRHnDmVFFI/sBWH4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024277; c=relaxed/simple;
	bh=ozo9BbKpD+419hQsv2PP6faeLLn/UynH9aJTtjPYLKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fJx3nidSzSYV7PekMTMBdnIn8fhXoRoWwrNIZlHhZWxNF/hOGfySVx3uJoQlQVeCbHxpCIk9cYEfoPU2sBG68Nxi456jHOmGASuU+Pzix3STnulrBeYSQ2AwEwNlsEIGNOCPKx24v8S28R7t8AcfCW19JYnT+tIuFd/HA3Al7Y0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=h9jh3nnV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=h9jh3nnV; arc=fail smtp.client-ip=40.107.103.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Wh4UYJfn14p9Cz28We8nd0RMfD3dM+GADmbu3i15NubMXrHslGocR4t7V1hssYCDweTJaKi58Il+vao+tniSLjBFBIr5WkbXrDyxRI9dFcZwMtK1vVqOOH4s1+O1Z9lFVnCXtdIbrvbqBAnLhff2tj4644N+tpkUNX3OD4SJoKdum77goSti+zB8INa+ivfO7Ct8FM70jPrCpVzXNxkTCYrpPQO+Sc135SMaj0q07SXIhDgeCz40nhNch0F4HJCfOleuwHenvpV1tkymr2kvG8mQRVRRM0XlqnsjCsvED4JANoxnIpA1ooq9HuRXTWjjRZ0SwpmCv2FNDZ0GHjiW0g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn5KAgwtKcmOlztbSoqTLPPKMHkZ3ybIsTAHVKRHq/w=;
 b=g8fzw0am61mldVPXwLkJAEOC5XKqIaQ6IXsZovptUYH5YmNVPSUDbbxctFBrbu9F3Z86oTIIcN/jg/yegAdOIQt85cuTG0vnjartR3h68AGrBDXWuyDTbBv5YqjnjodD9VEjGESUflkX+dgSyhN1ja/V6g6l9i+ogI49qUnUc81SMRjguvTSYBNaFnWclh2E1Ekc8mPowLjbcWZ3SqitwIQpWj1v/XXYGddb4/eITSCka/dLbnbaUys0SpzcvAc/+TvTvCYXJNZ6x5lpuykinNgXH/4UwSmoveHjZpUMojUmYXDH8cLStfxq2LKCYDEzCDF9/5odWKJiruVtfnruug==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn5KAgwtKcmOlztbSoqTLPPKMHkZ3ybIsTAHVKRHq/w=;
 b=h9jh3nnV6uQw5mdZgIbgnncSFXJrIdsfqLbmhXig3e30wLTWrJLop6qqhIgSVm42cTCI2edgn16pvK9NV16dERUXVQHVybakOaj1daFalThQOgjlbxjffVlAnqvAL+jiPxuJbaWQp7T+R1qvm97dTAm2311jtGd4dNYA01TXYhk=
Received: from AS4PR09CA0016.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::8)
 by AS8PR08MB8993.eurprd08.prod.outlook.com (2603:10a6:20b:5b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 13:51:04 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::c0) by AS4PR09CA0016.outlook.office365.com
 (2603:10a6:20b:5d4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend Transport; Tue,
 19 Nov 2024 13:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.0
 via Frontend Transport; Tue, 19 Nov 2024 13:51:04 +0000
Received: ("Tessian outbound 23e15691b630:v490"); Tue, 19 Nov 2024 13:51:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f77834ae871ff103
X-TessianGatewayMetadata: uH/16ZPFuhByq1r9y+oiiJXe256UDXSLXevqTtLJlHBHuwKC/m6mKsL6QB3qg/fxg4aRZIyMOUhbCdp3eul+/DKj1MSXOSg8WTehqVjuF/KBCeDQJzQdJhOxGGpyRC5iX061i2iohqam/GAO+jIjM/qDW+J1T046I+LybocpKOk=
X-CR-MTA-TID: 64aa7808
Received: from L075853caa71f.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 02FA6DEA-E014-469B-9DF1-3F3C157F1463.1;
	Tue, 19 Nov 2024 13:50:52 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L075853caa71f.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 19 Nov 2024 13:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4wk0OE2sq5i6o2s8CTWEcOrqbD9hWXnfY0ITPx1XjfRL9qALWVyTaBzj4/yCnows1JnaTDfMt/PGJkAwOuvy4u9p1u16tuokYhQhQNWddBOrhu+4x1c2FOe17P/nzKGKQPLLAw+6qzhTV5M03p10DJFuLDMelQNsJ44jQaDXfArrbksuOJMNf6wB7XwalkPHlMYST6Em6kWruamfRjgv0KAOI1GBNoQm3CKuvITCWYH3KbiL4agH71Yf8whsEtCdme5T/jV7vhQ/4ozIQqv80/rt2wwdHlCgTHqwrhOa6sSYF4RxQqDKvMROIGASYvPCPwtETKz4dwNjUdzMbinrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn5KAgwtKcmOlztbSoqTLPPKMHkZ3ybIsTAHVKRHq/w=;
 b=EczfkY7Ry6M2ieUSOzBXcC8xUZ4ypmqXAeBNjJurp/sj5O8CVi3Yg4aly09BIU9JoB4WcAs/GfyjfG7TzoFG1jhj2WVNwg2r+EWGkllCJYTt4ALKgg7wft75P5G5L4YCpwn92aRRtYUp2jWHRIu8eRy9umPKHRKX/wHuGqdAgpMFAwZ/35wQUR8b0ZAE2cFkKgGStolYxZTGMSzv1VDNkyifud4OoZqapAxudcCt32kiwx9gxbocXwqIoJhG7Mgz0BdEhoyPgRAbXrYerJguu/cZg5btTS16cHX2KO+p6srlddTG4sFhJ23kpp+CSn4ToquIURBQ4vP7FPZF220I4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn5KAgwtKcmOlztbSoqTLPPKMHkZ3ybIsTAHVKRHq/w=;
 b=h9jh3nnV6uQw5mdZgIbgnncSFXJrIdsfqLbmhXig3e30wLTWrJLop6qqhIgSVm42cTCI2edgn16pvK9NV16dERUXVQHVybakOaj1daFalThQOgjlbxjffVlAnqvAL+jiPxuJbaWQp7T+R1qvm97dTAm2311jtGd4dNYA01TXYhk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11183.eurprd08.prod.outlook.com
 (2603:10a6:150:1fc::16) by AS8PR08MB9313.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 13:50:49 +0000
Received: from GVXPR08MB11183.eurprd08.prod.outlook.com
 ([fe80::3bae:b721:e01e:9c90]) by GVXPR08MB11183.eurprd08.prod.outlook.com
 ([fe80::3bae:b721:e01e:9c90%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 13:50:48 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: boris.brezillon@collabora.com
Cc: nd@arm.com,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panthor: Simplify FW fast reset path
Date: Tue, 19 Nov 2024 13:50:29 +0000
Message-Id: <20241119135030.3352939-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0304.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::28) To GVXPR08MB11183.eurprd08.prod.outlook.com
 (2603:10a6:150:1fc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB11183:EE_|AS8PR08MB9313:EE_|AM4PEPF00025F9C:EE_|AS8PR08MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: e0aa95f5-c37d-4b65-2ae8-08dd08a135f6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?zVOvw831ZHGwivLdN4HD2VZG1lWyYZkM5syPjrEq4u3XegRG2B8FDlH5EKXM?=
 =?us-ascii?Q?Yqvuh48BCtPpyq6NPOM7d8WYxB2E63dnG43dO/5aEvOImRsEALo85Cdu5KT+?=
 =?us-ascii?Q?dPvDK/GVn1fvBG4lme/Ljsj2A9j3LRwgsX2/OTYZJKhHdDvKiBOp9ca0wl9j?=
 =?us-ascii?Q?GlAjxvq4QiE70QGqT87Lnj+GLGZhMogN0pjiyM3GoJcakFuaLFiAiHJKOljO?=
 =?us-ascii?Q?pdfohs2WtHE/HQR/aUIuLhQ32TrSZ0fbe3rutwlM4SIH3LHx9I20NsgXw0oJ?=
 =?us-ascii?Q?EjclU84iwtRfIN+1ATVJCcjbG6P2mnVWiWs2OYlzsolyURvlYu9HLMoS360s?=
 =?us-ascii?Q?KHPkybQHfw70tiZmhw0IDqWXxSQZY5WrfSMSbMfhbAU/aLfxotxjUDrVvUzm?=
 =?us-ascii?Q?lRZaj/qokAk5LT16crX1kFmu0qcPPcrRhhmjmajSPqVY0U/FDcDZXEWiZ3gv?=
 =?us-ascii?Q?GFcGZeZJPhGu76KBacSFuvFH12DNNqrPEfzA9SvaWjvklbdQtia0lMhvtqfV?=
 =?us-ascii?Q?bXISd1ow2utegy5gEfNUKXZsreVvNmpmhopHtgFVYVioSM8lN6JqGVYdKOhu?=
 =?us-ascii?Q?sVe1gtWYB4KzfbgmQN56TqhfDRNVIhWM7cEuLvLzvVct1VqJJOEycdzC3dP3?=
 =?us-ascii?Q?lfOekmpihQM/AcnM9UVIB71WencmN/6g+bMZoREMO2KZAORr7kXprZU2Zrzc?=
 =?us-ascii?Q?SWaRP9xM3XNGn+DDEng7N8TXHHB5AgZGdgZAkKL3HF6RlyjOTNVamheoN3T/?=
 =?us-ascii?Q?62O7k0EyUjfBM8zfNu0A651T0GLQfgAOOM2445squB0wuMGwlyFGuA3p9q3/?=
 =?us-ascii?Q?hpetTSBo41Eg680bz10yunMLLTsOnXhTglmYvd4XljzBp+OJwuYs4WLGVfdq?=
 =?us-ascii?Q?LFNIX+BN/3Hz4OCUQhm9s5SE5OLyUEvfWSwybP5ZJBiIlxEgP5RTitBatHtl?=
 =?us-ascii?Q?3dKQSmobZHUWWWuIOFDIfDGXbobkpWbRX1TiY8di5sHMUoCTD6pVWtYsl6Nx?=
 =?us-ascii?Q?XKvjPbBVxXLMKtRtcNy4EyWe863vBOMkItrMInVWB7L/Sl3Ztg4tlL5+lvbS?=
 =?us-ascii?Q?Z4CSCyseay0WaMtHiGWkZDdw7FNn6mKuofFDnauJat6KOYp0wQBxjrlG4xuC?=
 =?us-ascii?Q?u6Ug+bJFOImLvobWuhubBqxTQ7MNb9n5r2CjpzQK6KZuWXQ9KxnNYPeFylSL?=
 =?us-ascii?Q?FN3dhRtTI/6jhfV2nGS8JGPrxuEFlH0UfLLj3Knrvwx+iCzApEWrNbJVRKDt?=
 =?us-ascii?Q?KWgrasN8Xrglup+zexbzB5JKhQE+c8N36eIY6t+/jInjkExhGlYm6V6xQxkl?=
 =?us-ascii?Q?Dd3SIGQ48+NuVc6YeTdXDZ/c?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB11183.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9313
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:1fc::16];domain=GVXPR08MB11183.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	79d51251-3248-4a99-4d38-08dd08a12c60
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/NZ9u3A9aGIf2sp3ymt6qlV9zjQcdZ0O4kwwynoAZcrhVlx+ynk8uMHd3RQP?=
 =?us-ascii?Q?1mjaq5NQ5kiXGeP/WsTYpfhPOKnWdz6K8Iie+wfg0v+BtqA051Gs4t0eftqd?=
 =?us-ascii?Q?TsCUZ+ETR3EkMWyDEuB+DWIRm9QcXi9w0H1mUL3YwyfvpYM41R1pToKxaCQp?=
 =?us-ascii?Q?zAj1VMqlL9Aotp22I6mATnlMC3mm7vUOyPR+goigX2dKlcDJZ0VvBzcr9RDw?=
 =?us-ascii?Q?QaWKmJC/R4AcTJvJrXka5V0E799hVA/tZDtYqLCRj2jf6gYMR0qzgn012NPE?=
 =?us-ascii?Q?+dYvqR0jRIx94ARm8KTHe6qI4o7RLMbqkaw1X7dBxAfIT9dyQ25a7iYlTbmY?=
 =?us-ascii?Q?v+XHpw8vIXAts7wMj/ohBRpU5vxINSWxGLD2l2y+DK9SmVk4AKAoAf9qw4s1?=
 =?us-ascii?Q?sETYW+dTKiqHybPtQUpHDKFvWX814GQVZ1806kIl7kMqel5s96x9iRMnWaD8?=
 =?us-ascii?Q?ZDsR8v3MEZx7Q1BSet3zHjrLUeIQE647tP8ajfJFAhvt1V11OZAloOF/cVa8?=
 =?us-ascii?Q?1VWXQv3//2NnMWwQv4LUydzfkyQ4SEh157Q2fLHyASiLLi50r2oJx0CUh6b1?=
 =?us-ascii?Q?s3KqwlcGAt3TzxVVXwFkwkvpJpX9Fufre8SDD3hAVZmp1QsY2l1WfpOIXgur?=
 =?us-ascii?Q?khL6ION+BnhXNDq1L7UdcgwtVUQjbDA0fJB1IadKXY4Ywj2BY10Xv2cRxZ7k?=
 =?us-ascii?Q?aXE3cH+IGdPwx6oqFJ06zySWyqRQ76bJG0JDbPLDeeLMZMxym42lvwJNF8YS?=
 =?us-ascii?Q?x1j6RubCTjEzWBBL2x1U1uNJY9Sr3dyh+ShviRhWHEct/MZ6MM/V7qzs9mmC?=
 =?us-ascii?Q?7lJIX53Cr9PLmKbk9lmw+3aIbnZqODJHfMWmgSWmOEHnBTdzJ1ndpHNd/2qu?=
 =?us-ascii?Q?OTANoPhJ7M2VGxLOKnjU5Rw2HSBXU20sjyaoelk8ii6U6k3a1IVhfqReHLmf?=
 =?us-ascii?Q?e18QqUqladfwlaOsvmxZ5jdZHQk9cBgcyZkksczFE+DOZPpGK7+YK+FQbRi4?=
 =?us-ascii?Q?fAaJnrxW2BBJc2IBAUkhscRyTWJhRoVlQ9YSi+3SA6jhf9h/Fs12WAkYL03x?=
 =?us-ascii?Q?8p0CGOsOV12e+ETmD/PBXh0U2kll+B9y+m51F7NaW6OFismkTzKaiutRXT8l?=
 =?us-ascii?Q?UBi8ZsXcS6LLAv2scZ4uKtXyLtZad9h31Kvofm8jty4R50i+mJgWNoEcZGbg?=
 =?us-ascii?Q?SmjwXpUHD7uwY6/ocM/nN56djKp/R74kZKRq0oFG5n4sIVIAmHZL5/VmjbBN?=
 =?us-ascii?Q?aFjheJE2b3nFqJksUQaI10SpfBvCGWichvlRRrKaRwufht6y1B7uhjb4ZMXh?=
 =?us-ascii?Q?/5RwczDEb3aOII1sPKgNK87nFfVaRUbnnEZK/nqtCgymWjwMiLaS5p8yMEy8?=
 =?us-ascii?Q?q930bkYxbHdj4I8cd8v5j8DBBliR/oO+J/Y2O0vKp/qOuUW9eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:51:04.4091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0aa95f5-c37d-4b65-2ae8-08dd08a135f6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8993

Stop checking the FW halt_status as MCU_STATUS should be sufficient.
This should make the check for successful FW halt and subsequently
setting fast_reset to true more robust.

We should also clear GLB_REQ.GLB_HALT bit only on post-reset prior
to starting the FW and only if we're doing a fast reset, because
the slow reset will re-initialize all FW sections, including the
global interface.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- clarify comments and commit message with regards to when to clear the
  GLB_HALT flag.

 drivers/gpu/drm/panthor/panthor_fw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index ecca5565ce41..4bc52b1b1a28 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1098,17 +1098,11 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
 		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
 		gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
 		if (!readl_poll_timeout(ptdev->iomem + MCU_STATUS, status,
-					status == MCU_STATUS_HALT, 10, 100000) &&
-		    glb_iface->output->halt_status == PANTHOR_FW_HALT_OK) {
+					status == MCU_STATUS_HALT, 10, 100000)) {
 			ptdev->fw->fast_reset = true;
 		} else {
 			drm_warn(&ptdev->base, "Failed to cleanly suspend MCU");
 		}
-
-		/* The FW detects 0 -> 1 transitions. Make sure we reset
-		 * the HALT bit before the FW is rebooted.
-		 */
-		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
 	}
 
 	panthor_job_irq_suspend(&ptdev->fw->irq);
@@ -1134,6 +1128,13 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
 	 * the FW sections. If it fails, go for a full reset.
 	 */
 	if (ptdev->fw->fast_reset) {
+		/* The FW detects 0 -> 1 transitions. Make sure we reset
+		 * the HALT bit before the FW is rebooted.
+		 * This is not needed on a slow reset because FW sections are
+		 * re-initialized.
+		 */
+		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
+
 		ret = panthor_fw_start(ptdev);
 		if (!ret)
 			goto out;
-- 
2.25.1


