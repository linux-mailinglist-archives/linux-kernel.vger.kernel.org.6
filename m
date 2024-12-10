Return-Path: <linux-kernel+bounces-439028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0171A9EA9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEC4188679F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64E19AA5D;
	Tue, 10 Dec 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WcaJOCbq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WcaJOCbq"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3A79F2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816235; cv=fail; b=JCz2XByZKFBBwT7/ChQn+xuRAiZgOri97HVnrF8yuvg+Yxl1HBoAARDLQtXGJHdwRR5GgKWR+0kywQICa7sHwwBlZlIEmvQLPrOBqz0nx8M2p6sClMXLjBgUh0JenHuFRGgYFYXfARfn2OPShXWVltAXAaMsnP+ZOwxs9W1BC8o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816235; c=relaxed/simple;
	bh=FAMuVDNbB/atBZkm/YvD2zX0wEJeUG6aX2DnoGFX20c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rfWbCDOKwmvKpUAzD3PJNFJXi75uSkj4qd/MwpgVCdHcYKqI+jQSq1GCrswopll92v4PzQrLRA5i2nqZkrN/fF0X2G0OsRylLQD6zhZgqDdy+sOavWVwOlrygVW3wJSLUGcxVvifPP2wFyBSDmOOWJfS7xVtL57oP96dxdlHIT8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WcaJOCbq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WcaJOCbq; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qbboPgK7HnoB7Tm2y2YAJU4/kKGGvM7E+0KvqR+B1K5siT+PJx464e5qgMhOc5q0StAefUJ90D/6lDIyMDsQHj9vdOYm+QL6h9+vJzeGfCOkICWF+UAMDW4ELFxRoX+MpRfokJcyHFEE/wSDJzGwUu9p2auLqDSHivYaMY/gaKqDkRyX+BXzP+46OPDmUE3HjisJ8bbRQ33srN/C+KttAHsIa67DfM8G1TVYfXgxYi3xIIszipntdwPcTjictl2hiY7AI1fzPhx3GSAiElUS9jMVjY3eofTnGDna2SHJbmosqLyf/a/cloSjJeOlTVSkXRLK4Cn8wTeRORTKrgpuTg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zbVHDIi4qCeQoDKJ+C7zxQDADJuTho+uuerXAaDhYM=;
 b=ojpoAdWggaTUiDXAr8hHs2uxQxSu4VIB7REI6MutGSfROJg4V9jssE+MCPvMwD3S8Lk6sIpec87PMgILssUzQKUn5J0jF5hbGt7OcRFRlg3W9K5c3Bd7NShbgnJIO5yCznJNTsmAHDIJ19+I0PdkFu23jVX6HrV0UyWYm3YXnAkGWfRrA/g3L0+tr/8sA1rymoXB2okv+10v9eVedUlUTac6ZQ4VNPHD71YhZeNK0EO2WGQO40AYjzWIO32KQoIX8T1bHlRXokrYNcTxHsFwKwmWORGxvIPHskmb6z5lZpLJvlW7IaReqIpXHEGngmEVU3c9ugOI6SadN++aBkWPbw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zbVHDIi4qCeQoDKJ+C7zxQDADJuTho+uuerXAaDhYM=;
 b=WcaJOCbqwH5k3gllbEWLMCSUqy1MEvBtr5ooEdMOip4SPTASa/rnYwoJXMUPKSBl7jL7b5xvkbX9fTFROXrvKx9FPpHNixlnfjVARq/aPGf8z10KUPOvm0W+TNDWNqfzNbESppC/pEGyuCei4nd22jbYTTuA1PqvzaO3Ke8b+3c=
Received: from DU7P189CA0029.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::29)
 by GV2PR08MB8389.eurprd08.prod.outlook.com (2603:10a6:150:c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 07:37:02 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::e0) by DU7P189CA0029.outlook.office365.com
 (2603:10a6:10:552::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 07:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Tue, 10 Dec 2024 07:37:02 +0000
Received: ("Tessian outbound b1586bb311c4:v524"); Tue, 10 Dec 2024 07:37:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9e3768eaa3fe9e0c
X-TessianGatewayMetadata: aS8xIqGSi0mxSx/VkIcW5PBFyuxW2EozCre7xWwr2hodHxqR/f9nyQEwFpoEPuOJwAY1+xRlTT3EtYjjM0CAboEQh0R94k/hqfH++YtoNyprUxzMvvmIw99ymrXpHuzSqoMNk6HKTmjQjyNLN5asXA==
X-CR-MTA-TID: 64aa7808
Received: from Lf039df57b294.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id A65BD58F-634A-4C08-919D-6E90A98A9EFB.1;
	Tue, 10 Dec 2024 07:36:55 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf039df57b294.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 10 Dec 2024 07:36:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e27/26VA2t05renLE0MXMYD0ML1V2IJHxdYo6uPkJJ6doFUw+CWUTgEDqIM4TwjGh8NrHM2aC7r+i5lV7OfFGnVmrVAfDkADXatXj4Y8okG/j0JcqwycNojwKDt5rpYYCVAGgKzvVtfaHsLaMsJgItRMy66UwLFhJhL1b+OyLSG1ddCO+EZaFxu4CQ+fZjX/wvqyHwiBq7WYK0OQymmGw4K2TsdSwkCCizrF3JOxJuEIw7vMm3Q5v0XJo4FtHKEqzNDSgPKOGT5L50NQ9E1p2DDdGM69is0JI2/w9NUOtuaM9zxdP/m9emh3YpZxJlCmx59W8Tomdieb/zvBLU7RrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zbVHDIi4qCeQoDKJ+C7zxQDADJuTho+uuerXAaDhYM=;
 b=OMYmuX10UemBKIeKRYvxmxtXysChwQK84uMSsp2tAARh5k2kl3+JyGnDbMUThtDo/ObcPmvxOErRQY0AAxhaIE5RcDv1Yx0Yj3ctUCdAkqoDMTyP/1E45yheDC4VKC9wiHbugV+EHDOcWu/0Fy4FCTUxNSN7tEfY5uOmu32Yv6yB7evAm28KJBze8EORysV+3QW5hIl7GfzV/8e9kSGLv7IX2LafBFj4OjhYMGsu9zbuuci9ECcoK3XTFnXPfEWRNddX/dsyQRAeIUg2EAVKtKPin5fUips0IhB2hMkN76rJrHs3FnYzmpo0z3mJSzwrd65aASwkw34Z7aYg39Nr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zbVHDIi4qCeQoDKJ+C7zxQDADJuTho+uuerXAaDhYM=;
 b=WcaJOCbqwH5k3gllbEWLMCSUqy1MEvBtr5ooEdMOip4SPTASa/rnYwoJXMUPKSBl7jL7b5xvkbX9fTFROXrvKx9FPpHNixlnfjVARq/aPGf8z10KUPOvm0W+TNDWNqfzNbESppC/pEGyuCei4nd22jbYTTuA1PqvzaO3Ke8b+3c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU4PR08MB11175.eurprd08.prod.outlook.com
 (2603:10a6:10:574::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 07:36:53 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 07:36:52 +0000
Date: Tue, 10 Dec 2024 07:36:50 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nd@arm.com
Subject: Re: [PATCH v2 2/2] firmware/arm_ffa: remove __le64_to_cpu() when set
 uuid for direct msg v2
Message-ID: <Z1fvkpYvqpnjPZA8@e129823.arm.com>
References: <20241203143109.1030514-1-yeoreum.yun@arm.com>
 <20241203143109.1030514-3-yeoreum.yun@arm.com>
 <9e60e996-070e-43a7-80e9-efdfda9f6223@app.fastmail.com>
 <Z1ch52AthTYVhtH4@bogus>
 <0cb655ee-9401-41bb-b9cd-580e0aeef2be@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb655ee-9401-41bb-b9cd-580e0aeef2be@app.fastmail.com>
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU4PR08MB11175:EE_|DB1PEPF000509F1:EE_|GV2PR08MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: d799acc5-b7bd-4157-030b-08dd18ed7015
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?B2DKScDjcQNrS1Ie4Fl5m2ukkJ2v6+i346qd3XMZ/uPBdieaZ68Z3va0pMoC?=
 =?us-ascii?Q?pdOnR0GhrumDT1XrrLHndy8YOKiJGiagT/03gJoAZqAMAOF6FsuAJZu9FNr0?=
 =?us-ascii?Q?t12HL3Th8j1+RRrM/6VTrtOoEcaCITB7iqqgmlDXYrHgfqGE0Tyg/baO5xHN?=
 =?us-ascii?Q?RCzqXqHKzyCZz1rN7i1amz5iPt9fo1uGGBA+V61oqsuXN9EEqnp0PIaqychv?=
 =?us-ascii?Q?U1ZjmQSWHDRY9O1OslgMB9yN7ZK0QIMOtp6HKdbozk70QLylOcG7MPYD/d4S?=
 =?us-ascii?Q?kHMB2QiombXjsgwuaTy8EHK/vXNgxYQADR1dr3LKrqM3/tl5i8Xu6ZhZni4Q?=
 =?us-ascii?Q?X0FDTJd9GLxEATE+hasl6YkmMhZemBwFI/qtGRPcV+ZVOcIjtrBXO+OmcWI5?=
 =?us-ascii?Q?PO9Ml3f/9WjKGKJRY8utoF0QYFnXcL6KawAkcVc5/pM/Ck+xoJDMvn/k2Fk+?=
 =?us-ascii?Q?0PF+VQhi0gGbi786363JCzdwskXA5XDjh6tchY3nUIgvCxDom4v3y1Nj9gcv?=
 =?us-ascii?Q?r3fcM3v9+12XCo+W2Gf0AxrgUObwJkjF/+fg2nn4WWGBEqnR5awazsG1+ZmA?=
 =?us-ascii?Q?jYByzpOPxnQGaW9efTRnNerEMNUrq+S0V1fn0XnOqx9pY6J5HuIG5QgU5h2b?=
 =?us-ascii?Q?5Ld9u9hfeYHYQjaFnbrgMt+8B83kW7qe59XAgdMjgO335gB1cCJTzN+sO2za?=
 =?us-ascii?Q?p+lcOXw6LuwQR27TP175dfqght/eHJwyHJvsEaYq5DihfpoL9K1qYk6Bakp+?=
 =?us-ascii?Q?cd4x6QHRZ2L0JLY0EuVXr06zpMyjKb6CSFjWXZ7dueYRXPsumMYHiQgfmBoJ?=
 =?us-ascii?Q?Ses2DM52vEhG7Y8gofSA5oSXNKdM9CA8nM8JTYa5ICgkcFJDD34FII3EZlBA?=
 =?us-ascii?Q?WscE6iz2CmVhJY3PsX39cgSNzkNyyNa43uWN50cQ6nQFYrdcq++zLKXJCQPu?=
 =?us-ascii?Q?U9DGtC2K/TkRdj+5oAsnxBwVaL3nIBM4Jn9vSVRQ89haDCtE8t3IrY9B2sR6?=
 =?us-ascii?Q?ZDjBS4W4yQwojNOj2i82usX7dVolP0vhs+qWgDmBiC0JFPAo4z3I5c3ikjgT?=
 =?us-ascii?Q?Cg70JwFBP5vyx3I5QUIEy+oX4anGldsJHG1n4BpsGX5RoowkYuZ4PTzHhF5o?=
 =?us-ascii?Q?N0WAOdJVUXR00KZgdtRAzz3peGPmTltD4aMCSd80qr3lJrT0yzSyveBldxhf?=
 =?us-ascii?Q?WdCBLUgDwBpPWMyKgCE4FtRYXkxuDYwYccIViI2vcR9wmzMicvFZFNvN0lcb?=
 =?us-ascii?Q?9ioloNhfy7oC10x3PH1dxcY89pZnJ551oN7jK5vQVCIs/YojVEYm/qLtrMLr?=
 =?us-ascii?Q?Gpt6F18NAhCoZFS3RcBiNIfBAHeBBmIy8WNnx9RxVCGVDw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11175
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6118762f-3ff5-411f-b372-08dd18ed6a1a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|1800799024|36860700013|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXn+ovfq+ty/M3XzhYju4ESd+rhBh7E02MTF7FDSEpWp0XrQp4WfnTwerjoZ?=
 =?us-ascii?Q?jnK1Vapu/xJSda5dmlW3loFqGvPtRB5FiFKoiMre4kLPfIWR1kmeeIQEYlDH?=
 =?us-ascii?Q?bjIpHHdiXglcRPUmXenxhdX/hMnLyYb7l2P2biysXCtDwVagnA6+a6qclFqD?=
 =?us-ascii?Q?05oUJdvm2Yuc4fgc5TV6dydaEkJCdmLYHXEm4wEdLZ/MT35SN164DZLzqLgW?=
 =?us-ascii?Q?0RBf4fQEzIqSVs2Ju3q2aeyO8AlGNEg5hhSFtQ0/wD8g0+NGnaSCFP1Q1l9/?=
 =?us-ascii?Q?+5ZjsgsRERUVxANbmRo9KwP8DMJ1iQk0Ea8ralUHKYZ+m/9rm9Vay7VeWBQB?=
 =?us-ascii?Q?pkxtknZf9WjuDwUa9ihu0AHjxyKhAdLuLRWfNkxTjOVILYLmM0L0IK02QLkN?=
 =?us-ascii?Q?He+8amrDGSL8IOiAwxg03iDIuslwTf6HjNqNeAHii9oARwz52Iy8ehA0ozFs?=
 =?us-ascii?Q?x6oOapCbFOBHgeUgIgPOvsTPRDw/GtrSLaSqN4H7VXK33dqvv0pzUugToohK?=
 =?us-ascii?Q?uUoeGYt1DN9QyCDcaoP6UPRPUfBjJMJM/wKjlQe0nCFN31fymRmXHta/1vvR?=
 =?us-ascii?Q?CIgda6j++qU+AG9MH/jesL8o+TtjvXK5+ciDsjfzFdUmUBe83DKZrgk2XIby?=
 =?us-ascii?Q?E65vA/bsbKl/kEYSvnGZ6SkNpp4nCmjVUvB/IPQeHd9TRCuWnSZojcQjJeke?=
 =?us-ascii?Q?9mkX+JQXW2luaCXP610BS5BI2d2MlIdHtNZy3OUNzYznNdzcWx+kzeVJdE6h?=
 =?us-ascii?Q?u7wyjmxSLrTcL/3GytisNjyxOffK+fjvBGyxYUnF/a8MFDTslNepNM42+B1N?=
 =?us-ascii?Q?soaPYXQOYXO0nDKMP3dt8yy6ngaJIzmRw8BIOevbimEFwbSdW9ECeRa+yLtn?=
 =?us-ascii?Q?rbrv8dZrNIH3YWNPb+IEhWnTkCZvzg4N4AhyskgPBgsyZ752aquoLDdhvtjb?=
 =?us-ascii?Q?zuOedmnjsGarQPLbFPeo0wF7Hk/CqPPWS+0vJL573ynj3Gnhfr4z8S2rcIEX?=
 =?us-ascii?Q?0crGNtDmyo964KX139MjNRpQypm/PjTuIT8Y3dRGOuujgS1qdyH+XJDeu86x?=
 =?us-ascii?Q?CuZEdWmsksz2yLdhfjYuT1hn2xDCLBSGzu/73DYTCvX1zX9W2sCRSscgDzgi?=
 =?us-ascii?Q?9oFKgS158FuI4BelRHMvavzJK2Rylz1GNQDI+3iN4PM+IQ6KrhUPf7lvmRbd?=
 =?us-ascii?Q?ON8YpGJ5UPvxfdTQgniVbftpxAYnf4H08MT7pFN825QadPHovKYDeL3oXqwv?=
 =?us-ascii?Q?YKPjQNsf6EZG2Ys0IaF3PKeCxCiu+rcMybhHZPouusfvhDg9fNeZvLqVlsT+?=
 =?us-ascii?Q?G+JI+5wJohT5ZsAjlRBQQoFoUrP1bYcJoHfUbniCjaZHT3+RAHNvE9HFaRhX?=
 =?us-ascii?Q?fFwd5f5hcwQhESvffSARCXmYe4nOVKnAjHRlHujWgVAL4EZJ2ZfxUKnp9p5q?=
 =?us-ascii?Q?BlNLthb16UNNBcanl9QmHZCs2lGLUhu92sKy/ZjgF84By38ldR+r+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(1800799024)(36860700013)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:37:02.3219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d799acc5-b7bd-4157-030b-08dd18ed7015
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8389

Hi Arnd,

> On Mon, Dec 9, 2024, at 17:59, Sudeep Holla wrote:
> > On Mon, Dec 09, 2024 at 04:27:14PM +0100, Arnd Bergmann wrote:
> >
> >> > That means, we don't need to swap the uuid when it send via direct
> >> > message request version 2, just send it as saved in memory.
> >>
> >> "As saved in memory" does not sound like a useful description
> >> when passing arguments through registers, as the register
> >> contents are not defined in terms of byte offsets.
> >>
> >
> > Well I didn't know how to term it. The structure UUID is a raw buffer
> > and it provide helpers to import/export the data in/out of it. So in LE
> > kernel IIUC, it is stored in LE format itself which was my initial
> > confusion and hence though what you fixed was correct previously.
>
> The way I would phrase it, the UUID is never "stored" in
> big-endian or little-endian format, it's just remains a string
> of bytes. The endianess becomes a choice only when loading it
> into registers for passing the argument to firmware, and it's
> the firmware that mandates little-endian in the specification.

> >> Can you describe what bug you found? If the byteorder on
> >> big-endian kernels is wrong in the current version and your
> >> patch fixes it, it sounds like the specification needs to
> >> be updated describe both big-endian and little-endian
> >> byte-order, and how the firmware detects which one is used.
> >>
> >
> > The firmware interface understands only LE format. And by default UUID
> > is stored in LE format itself in the structure which I got confused
> > initially. We may need endian conversion at places(found few when trying
> > to get it working with BE kernel).
> >
> > I wanted to check with you about this. The current driver doesn't
> > work with BE. I tried to cook up patches but then the upstream user
> > of this driver OPTEE doesn't work in BE, so I hit a roadblock to fully
> > validate my changes. I don't see any driver adding endianness dependency
> > in the Kconfig if they can't work with BE, not sure if that
> > is intentional or just don't care. I was thinking if we can disable
> > it to build in BE kernel until the actual support was added.
>
> I think as long big-endian kernels remain an option on arm64, we
> should try to to write portable code and implement the specification
> The reality of course is that very few people care these days, and
> it's getting harder to test over time.
>
> > So the current FF-A driver just supports LE and the bug was found just
> > in LE kernel itself.
>
> What is the bug and how was it found? The only thing I see in
> the patch here is to change the code from portable to nonportable,
> but not actually change behavior on little-endian 64-bit.
>
> Looking through the other functions in drivers/firmware/arm_ffa/driver.c,
> I see that most of them just match the specification. One exception
> is ffa_notification_info_get(), which incorrectly casts the
> argument response arguments to an array of 'u16' values. Using
> the correct bit shifts according to the specification would
> make that work on big-endian and also more readable and
> robust. Another one is __ffa_partition_info_get_regs(), which
> does an incorrect memcpy() instead of decoding the values.
>
Conclusionly, Yes. But the RFC 4122 said with network byte order.
to describe how uuid is saved.

but I think the endianess to load the register is not a choice.
because the spec says:

    UUID Lo  x2  Bytes[0...7] of UUID with byte 0 in the low-order bits.
    UUID Hi  x3  Bytes[8...15] of UUID with byte 8 in the low-order bits.

this means UUID.bytes[0] should be loaded to x2.bytes[0].
           UUID.bytes[1] should be loaded to x2,bytes[1]
           ...

That's why other software spec (i.e tf-a) doesn't loads UUID from register
wihtout swapping byte with endianess but just copy it.

The bug is "not send UUID according to spec" in kernel side
That's why it fails when I send message  with direct message version 2.
So, it''s not change code unportable to portable but it fixes according
to spec (load UUID as it is in register wihtout endianess).

> > > 'unsigned long' makes the code unnecessarily incompatible
> > > with 32-bit builds.

I don't think it should care about 32-bit for direct message 2,
Since direct message v2 is  64-bit ABI only.
that means ffa_msg_send_direct_req2() should return error before it calls smc.

Thanks.

