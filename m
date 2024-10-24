Return-Path: <linux-kernel+bounces-380141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6429AE971
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6E62859E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53291E4110;
	Thu, 24 Oct 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dgXwylta";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dgXwylta"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141AB1E7C33
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781721; cv=fail; b=neQI8uUn0dnQy2E2WkZOB4cGLbO6xz4UEg79wmHx0ytB3tHL3I8Drk/X6i8oVehG+jmvxV5SD5warm6/GG2eU0R/G/RP794ihZ/9EC0gc36kAveOCg65Godf/YAy54T4TY9pCYAfbtNrlMSSa5Vc0PNs6TrSYLjHt1+6OJFYnm0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781721; c=relaxed/simple;
	bh=hw/+J6KQ5d3qOanBmFMiw7ngjLHPUL2wL92qxJu/p+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oK1eSIb2K1a8IVh5PX3pdDgoxLujDWTzmQVXmezi5NuOfseNzRZQlMls75NLgP+n67R9bbGMh3EAfcX/4Q7z41O32pvRdS30nspCOVmInz0BXkxTQX5253n3BuvmFS3eut1uguxpv7yKQjTthsopbAnrOIo5+W8RX3R1zH4RgfI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dgXwylta; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dgXwylta; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uK2VBb6kc2vW7+HkfX9ADMLGbCcuXqQNuPMtaawyVuV/bcp3uXG4v3qaFnefGzkOVjdaYMmxoBfE8jMeivWM5No27glQKMG+VW8ezc9VFFd9vKMJ9CkOvlFCykL/veszqJho8XXHIOPeqx1t36LpXUvQ0QhaK83wdo0jYUPceJ1+IpUHwvGVGzm93HdXkQ0HIJB8AlxRSC90VSmKQtALsWsJwPUqSQNddvwPFW9cqdSpo3Gi3FbNWpH9vCqmqo/4yaYV+uOKCDveZIdNtrrkOoUfzluD7TOTz8UL5qxvuo9+7HKQ4a0FGwn7mFZswgBl5I4RE710vm1iKf/FYmeHGA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWEtEPyiOmxtlOJjv6s9XyE2N03ec/56aFKp9m4srrY=;
 b=MKoCjK7vlofCHNFoMAnKhdOdwG/eKnqVG0Ao62XYioAwUTQCTpkD1zcdCxcAVHCMhGXkUEUYuiWkFtZ12qViaLs4rm3LZ+r9AqGdru/4Sur8KjUwLvE6kIi1VHjc/iZXZ1UFC0ClgRjB/swDOQgcHvRLqe+lpnlC3Rms1BXRC+sQADDhqVRlLlBlNwINNVjwNIELTHPrh4kke2ain8CH1jBD3Jn9h2BzNQMPwOLZ16mOCa1TKyIl63gEAUyFdbb893e2KyyG//VtKMXtxZntkoxU3wrsvFvL0OLQdqlf85UnnVPrJqoai0jG/Trm+wytnkM1mGQb8VdvSiM4xddowQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWEtEPyiOmxtlOJjv6s9XyE2N03ec/56aFKp9m4srrY=;
 b=dgXwyltazcrBualPIvzEFHAq8cBWWjZ5S6UTF3qiIjhCqnyYdx5ZaQcWpg2h8be+4UnRjdOvHpd/aJpwfxWhPRiRO85JTTjfbsUMjK+TeHBeYqNG+psTdSTKR9iEApjABr/wCKf35QFbr5EaYgB3uKP9GQa42havHGiybxqhYCg=
Received: from AM9P192CA0008.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::13)
 by DB4PR08MB8197.eurprd08.prod.outlook.com (2603:10a6:10:383::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 14:55:14 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::c8) by AM9P192CA0008.outlook.office365.com
 (2603:10a6:20b:21d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 14:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8093.14
 via Frontend Transport; Thu, 24 Oct 2024 14:55:14 +0000
Received: ("Tessian outbound 4a86a9c66651:v490"); Thu, 24 Oct 2024 14:55:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 35d0c8f192506e5f
X-TessianGatewayMetadata: 9yoxV4jJXpW60vB3dhXQ1yF25K7+h/mv4p4bpmaTD3YiMIZUJCw95BZpJeRR0/fs0O1vJObZaMr/r02iLed41nLl+oiuN9G6t9aEljnP5icJ67JIAvgwpztXVPwdaUa4XSADMVQBELXGR16fNmQmVoZIOQl1O+AAUpB/8QL5o2g=
X-CR-MTA-TID: 64aa7808
Received: from Lb20fe2b11398.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 749673E5-863D-4275-B6D0-40521E1E5FEE.1;
	Thu, 24 Oct 2024 14:55:02 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb20fe2b11398.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Oct 2024 14:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6lTnsSHNsbFW/SNTfmPJs+5P4zbWGJFzlURuEgBM3oWN1HKt9cIHyGOJIRqQvrkaoyzebeCczW53aDV4sq+LLXC0Vhn7/m7dMtkWdYMKVXv6gVJ1QN2x/qkpMV6ztB65pOmY9On/nDia1RFmiEJw9z17NHuc4opKnsRuXBpEHGjjkRu05eYoDN8HqLqnV8ajII+egUqPTORSftHTSopbt5rao8XnV2gpfeRnDcC8nAy5Y4Pp+t1nFEExB12+E+oBezSc30QfATDX429mzuNeq+0iBxPsVIQqyREw0doxF2ddty9wKIQjmNu/jdX677OEsoWYZHgYgjiTPKMKZ5fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWEtEPyiOmxtlOJjv6s9XyE2N03ec/56aFKp9m4srrY=;
 b=hnt7xjvJlaTfI7VMBIMCZXMhT7sCbOYN0Cuv9kAx07l/Mkhfhvu/jezHe0JFUahUtwrrFL+KSWUex8tpI23XpGI7YeDEDBZtimzWFTBSPDvRFyLH/Pg72XiZcKh7Wkd+EgZFXnoD4IDyEkAIYA9kTxoRQF9aI5OO/xefSImuT2rq+rwy8yVWyT3wx3W8k9+vwOstMs9Sh5BUoWYIKr1ydBTVvrEJH9xQHUoOVB54MnqaAMWfR4MELB71XH5J6Rq1YwxfdKisnRIoGWj+MFxzkV7x2viYi63GNCy3E9odeR8xhH9yh7XwaNl0OLbpfXwfyRErjpwpHfkg+CiVfi3e5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWEtEPyiOmxtlOJjv6s9XyE2N03ec/56aFKp9m4srrY=;
 b=dgXwyltazcrBualPIvzEFHAq8cBWWjZ5S6UTF3qiIjhCqnyYdx5ZaQcWpg2h8be+4UnRjdOvHpd/aJpwfxWhPRiRO85JTTjfbsUMjK+TeHBeYqNG+psTdSTKR9iEApjABr/wCKf35QFbr5EaYgB3uKP9GQa42havHGiybxqhYCg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by PAVPR08MB9650.eurprd08.prod.outlook.com (2603:10a6:102:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 14:55:00 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8069.016; Thu, 24 Oct 2024
 14:55:00 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com,
	liviu.dudau@arm.com,
	steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mihail.atanassov@arm.com,
	ketil.johnsen@arm.com,
	florent.tomasin@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nd@arm.com,
	Akash Goel <akash.goel@arm.com>
Subject: [PATCH 2/3] drm/panthor: Explicitly set the coherency mode
Date: Thu, 24 Oct 2024 15:54:31 +0100
Message-Id: <20241024145432.934086-3-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024145432.934086-1-akash.goel@arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::7) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|PAVPR08MB9650:EE_|AM4PEPF00027A6A:EE_|DB4PR08MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a654a40-045b-4904-8997-08dcf43bddf4
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Or/4ow7xan+uJ/C0poaJc1me6yKt0bdWQxj3vKy5S++55rXy1q4qV1gKOElD?=
 =?us-ascii?Q?Qu2wgCNMSgGSO/0t1lPnVi+F+Afm8lhsdo+3JkA9NymKjpmtVsvWmnsQw+Zk?=
 =?us-ascii?Q?MpCPYNPVlDx2MfTGUFv7DwiI8qh/B7FU+Dno3nEyo4dnoS2o5ENEVn2MNUYp?=
 =?us-ascii?Q?Mf4hsihmMFypZ7oRP6fkjfALv1O5wK8EX1A/c+I8vXUSxJbTnHpbxs6dyVYt?=
 =?us-ascii?Q?y/HVXHcYoYHjLMGltUUN5X8/WfD0/iJAXmthDRIXpS1DeOnGmGbqF0cT46jx?=
 =?us-ascii?Q?MSMYy2ruPHPyVodmqSccc12kFKw5VmMkR05PJF9VVQ6S/gQ1ulxDKhBiOWLB?=
 =?us-ascii?Q?t4nOMAzSb6q2rr8hvoUR0fqwp9Qf27fHpQZowoj/mUxhDemq6rBOzZOZpj6J?=
 =?us-ascii?Q?GySimZ4z78KT/rLjGQLAe26+IQ+V1JCq/SZMOEsP8JscvK9BQyEa5dElWKe5?=
 =?us-ascii?Q?babU4D52CYz+IM/YhYLQFCyd3r4SHFLjtXcaSbsqql/7yRpGk3zWQJkIFglB?=
 =?us-ascii?Q?ETVXoLjOQQmFFq+q2z5//vV//H8JMa3c97GNn6mNPqvLEpGhhlOfxyW6Eo+g?=
 =?us-ascii?Q?bcTw3JHoqVKhZ+rVjxvbT5yo4xowarqlLq8RhmtFy4yPVxvWVwIJDfiyuoGq?=
 =?us-ascii?Q?B5KEKmYDFJl+2bKmD2NqereaS1aXCZvAq/qfuq/p14jTiAbehW5n8rg/4q9L?=
 =?us-ascii?Q?/oliSODJOl67O6H+V0Qqzi2ne8/gAumC753owF4/Xo62ek6RBJ4MhqCjRFlv?=
 =?us-ascii?Q?aKcNq5Fd9Xc3R4VwF6uygq8QqOCu6Ubm9HJ7e3KApT2JO16+xL36DxsD6Phl?=
 =?us-ascii?Q?xRy0eTWuc0cLzmgxSCuseHH7ddsdP0hxgN4aoKdnoDU5J7jVgDlhI3ja0svB?=
 =?us-ascii?Q?BGeD+VucfEDwVwfTUgcdBAz5lTxQ14nNf9tJx0i3WbmWRnV3kNC3VRZfFOva?=
 =?us-ascii?Q?d6ohTFOWp21uZ7ZUgv2MTBGu2PkLHUCvO7nyNXYSIUXR1pGsGL79eMU8F0By?=
 =?us-ascii?Q?Mnhm7fA6V9cBXcb4tXbi5YOUa8ekA75FmxQ0JOLvAu/GeDtDXsP80i6GYseo?=
 =?us-ascii?Q?ZHaJPiuB87swFKzu00Gp4Giv9zYAMXo4TNQ2ZbIBJT9IfZvEnZ+3l910yzMW?=
 =?us-ascii?Q?qCT+8ni0QrtYMnOCxGkEXKCyFkhent559DAPmvgJPC1fECs1yVZbxgOPpNnE?=
 =?us-ascii?Q?HYOJe/YQ1O8o7nL4wnq53MuxFu3PxhpONvEiWpVB6brKVJbP09kRLNmxiFiL?=
 =?us-ascii?Q?swH6FS2vSyCiqCR9Ax0B8GxrqI2yeb9kNyMgZ3B59PDHug0qWsBCmstyPIrM?=
 =?us-ascii?Q?zrc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9650
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3af7d2f4-1823-4006-770b-08dcf43bd45c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WyTNWC1TQ71qHXVRiOwYLAE7kOgjyk4CcEnRBDWGdPPDdmjfAHDlTrKjmO2t?=
 =?us-ascii?Q?1st38NOyxMFGSJtrkBApjWAvy868Vf4ZPrsm/ptAE+lUzt3gQ828pRu8/Tet?=
 =?us-ascii?Q?Z5cES04tanaf3XGl0+OTdnHIeieOexara/nyyFp+3Yg/MKGdiCJ6SC9vlI4A?=
 =?us-ascii?Q?15bo6Pca4vqCxHW5NcnufPhE0rAAmZrupFN3E6EYho/pQqqsNGTEg2YIzjj9?=
 =?us-ascii?Q?e881YhUUc+aoHaA/GuFdfbA+81mK7lDe37ceJdf77sLmdBxaBYiDDKocw25K?=
 =?us-ascii?Q?sQi9AqRvdMzOBiHb3sHkOFYjYq9Hrt4mXe0lnj3TC35Wgm912LFwyj2D97Bq?=
 =?us-ascii?Q?xete7PFxxjXSC332SsHay1fsyqn19myzB3APCgNZdWRRNY/tAs6Mio/TikTd?=
 =?us-ascii?Q?SW1EvFeFlKew1fxb0EE16tYLzROtxkcNFSbc8fgyu0U36ugdMWFIsYINRpCV?=
 =?us-ascii?Q?BmhcFhgqDwb9O0KEhCUH2SPVCm1hX244RpBsHK1R3zFLlpNDkxeVgE/SrW/6?=
 =?us-ascii?Q?8zuzJw04FzURuA6bCz9JVXEFDvaD7hTsPn1PEYvXPAZAUJZR6lQtVazYfHNJ?=
 =?us-ascii?Q?MNQEA6DEwjm079wYF2A03C6bqeBCOtoA+ldqe1B44mH/7TrDySHe5DfjQhgy?=
 =?us-ascii?Q?Z+7HpaPoBL7gda+mFduwLopcElG+DLk+PtXPvV3fmQsNY1uIQaQk1TSOj/29?=
 =?us-ascii?Q?hCoDxAZoHvcLDhaQgLr80XWWOZVXiHN9xmHv5+zjkot22uzMyuRYRxwHllmx?=
 =?us-ascii?Q?rh1+QjX4PzwtUMSHnYUYKxn9e5mvtIJIFEa56VDqDO7fiayS75b6g6JiX4/b?=
 =?us-ascii?Q?Y149TKQEE1tIXN8NrTtpz9Z3W1geM6d5lszERYjFqy7jQwXciRFEqk638oWh?=
 =?us-ascii?Q?iZJHOJmnfGpJ8BfNjFd9cTtlF5UXw6hHB4bcIEh3MC1io9uPfOO5XyEaVH30?=
 =?us-ascii?Q?CBuZjscCgdJYQca0q2O4w2mM56WveTwEDEo2tO+x/vNggfFt6cHOjn49ps53?=
 =?us-ascii?Q?e7Mn747RqTUY2ppV91kB3doXzVEojKNlWssLsG/IJ29un6GUz9Rofk+B4nAY?=
 =?us-ascii?Q?zQ85p7AfQT+RXQgKK+EYTrOlAFy/1dtpDf9fH0/4LpqD91G12OhU+SpH+ULG?=
 =?us-ascii?Q?9IC7VM9WoyedsvT/zRYW64Emu5IpbxgDMCMBQbpEff+bPsDj8r4PpugtCnEK?=
 =?us-ascii?Q?6YikHXny0OW6CgpPU+aQDYBiZOWO6LgqEVw0n8I9T/5ZconMn6Jj9uUsjD0n?=
 =?us-ascii?Q?5gSaNnyUYZHMIsdFAjWjRbgqt5kEcxsDD5NHDFFn476VmCh/wAk0VXL8O8FH?=
 =?us-ascii?Q?9cR43QnhdgMyRBAPCC0HmmQY9qD6eOEhZ5ZlvONR5q1mzpWCV29/HTvbNkWn?=
 =?us-ascii?Q?eIf6aM4MdeZZwgKZ0JKkWoWcBrCEl+z6imAgLMjkP/zmkhN0Qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:55:14.3337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a654a40-045b-4904-8997-08dcf43bddf4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8197

This commit fixes the potential misalignment between the value of device
tree property "dma-coherent" and default value of COHERENCY_ENABLE
register.
Panthor driver didn't explicitly program the COHERENCY_ENABLE register
with the desired coherency mode. The default value of COHERENCY_ENABLE
register is implementation defined, so it may not be always aligned with
the "dma-coherent" property value.
The commit also checks the COHERENCY_FEATURES register to confirm that
the coherency protocol is actually supported or not.

Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 22 +++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_gpu.c    |  9 +++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 4082c8f2951d..984615f4ed27 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -22,6 +22,24 @@
 #include "panthor_regs.h"
 #include "panthor_sched.h"
 
+static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
+{
+	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
+
+	if (!ptdev->coherent)
+		return 0;
+
+	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
+	 * ACE protocol has never been supported for command stream frontend GPUs.
+	 */
+	if ((gpu_read(ptdev, GPU_COHERENCY_FEATURES) &
+		      GPU_COHERENCY_PROT_BIT(ACE_LITE)))
+		return 0;
+
+	drm_err(&ptdev->base, "Coherency not supported by the device");
+	return -ENOTSUPP;
+}
+
 static int panthor_clk_init(struct panthor_device *ptdev)
 {
 	ptdev->clks.core = devm_clk_get(ptdev->base.dev, NULL);
@@ -156,7 +174,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 	struct page *p;
 	int ret;
 
-	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
+	ret = panthor_gpu_coherency_init(ptdev);
+	if (ret)
+		return ret;
 
 	init_completion(&ptdev->unplug.done);
 	ret = drmm_mutex_init(&ptdev->base, &ptdev->unplug.lock);
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 5251d8764e7d..1e24f08a519a 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -77,6 +77,12 @@ static const struct panthor_model gpu_models[] = {
 	 GPU_IRQ_RESET_COMPLETED | \
 	 GPU_IRQ_CLEAN_CACHES_COMPLETED)
 
+static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
+{
+	gpu_write(ptdev, GPU_COHERENCY_PROTOCOL,
+		ptdev->coherent ? GPU_COHERENCY_PROT_BIT(ACE_LITE) : GPU_COHERENCY_NONE);
+}
+
 static void panthor_gpu_init_info(struct panthor_device *ptdev)
 {
 	const struct panthor_model *model;
@@ -365,6 +371,9 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
 			      hweight64(ptdev->gpu_info.shader_present));
 	}
 
+	/* Set the desired coherency mode before the power up of L2 */
+	panthor_gpu_coherency_set(ptdev);
+
 	return panthor_gpu_power_on(ptdev, L2, 1, 20000);
 }
 
-- 
2.25.1


