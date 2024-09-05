Return-Path: <linux-kernel+bounces-316549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7837896D117
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0311C22EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE0E1940A9;
	Thu,  5 Sep 2024 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Pp0/fth"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48807193070
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523195; cv=fail; b=bhRgK5bL3rVG9efZh5kWpz5+Psz8H2FGOGwxlAL+B2USX18vyz37O9ub3LdeAf4S95xc8YX5aueaMaLLiAv2t4ufCq7I7bxAEf+2OCdvOOZ10zJXFZHBwXFb38Kku7CRndBlbE/IYwPBHIYB83KdyuYgyMbJWGoUMBFcy25dM8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523195; c=relaxed/simple;
	bh=AZRn8mRDG06PJy0QlhmOaIwpRpWXUhDTTrVjXo5JwuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZ0iiIih6FbwAKpM/MMVBnGTnobgOZ9GLtvd593yiHpkO41dCRngBN/96pXN0PYDBbnqd7zvvsa0enzVKSvfiF/hfLpiNhSEqqnyzHvakoClc2FP1zVypyy6QeuNWJhnVtEepyD8u9KeFnM/4MltUo2wZYgKcbXAF9P8tqP1NaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Pp0/fth; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PixtSipiuFhqA77AOeJAznUqqK6/6nYpNm9alAQk6XqqrQH7KQJmhf/XG30atVV9mKg6iiXsVM00+lVTTYGsauvz1xv+HUfnLlE8WJ3rHXwVH8hQj/sz+/++czxLpbEU8zhay9rAPUmVsmQztRk6733fpRvEzyLJ/Z6hIX7gb7uCU0JmdSj285OVFZ4fpgHrBCBTIFPUfh4U+ixee995YXouQkB2Y+2yvamQ3kWNVIeE36+RRtZwNva0B134Hhg9EB9DK389QvOkURGRF7XQmtjRlHyffpevu9euzhQuxgXuqCnomnVfEzWFLsI/7k/1Z4B8IOIYyta1aEwI/zUI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZkmkoKZ3OBzfv5dEhDiTD1FpxS3rAd6lqYiWTTa+J8=;
 b=TFP/oAsOE88nFEiN1zMsPh80b8N+lTHlm0qGDmED0F6bhCLhKJgG1sinGp7zObnEH4JzyBRbmxJlXv4GDD/zl05tAT2TiSQxYw/+MyJ5vUxYqrYv9QSsSPKVoidodB6IBjc9lf+Un9A0RSzJ8NTQUHyxg+TYQleJQc7Av5Pg8OV9r4GJ1ek1/AHV5alFJgqZp6c4s+KjePDDm+DZbJ80iK6GDg6kTlPXFA0CfB0VItLk9598oaY7TyhZ456nFJo9vz8MxO8MYcsYejUWlOTn0y/3Dhs1NUECQGLk1mZOAt/i4XWNTturJzRslLToKoWNaLkzxCaPBKIwD7yW738Pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZkmkoKZ3OBzfv5dEhDiTD1FpxS3rAd6lqYiWTTa+J8=;
 b=5Pp0/fth8tvt0H2iIl5HkLpU+nlK5Xh9bX7AGvCsyEKpycQ3RYrUFcJ+MYdMo1nrD8BgYVir2oHq727V9/wQq/S8XQoA51p88hGWt/qe8hG7XEeUAU2DNAoj20VDdsmehpRumGfVEYnizbaS+zFG0PgsEeajQBvQ3bFyBbfLlfM=
Received: from BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 07:59:51 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::fa) by BYAPR02CA0064.outlook.office365.com
 (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 07:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 07:59:51 +0000
Received: from sh-genoa-67ff.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 02:59:48 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <paulmck@kernel.org>
CC: <leobras@redhat.com>, <linux-kernel@vger.kernel.org>,
	<neeraj.upadhyay@kernel.org>, <qiyuzhu2@amd.com>, <riel@surriel.com>,
	<tglx@linutronix.de>, <thorsten.blum@toblux.com>
Subject: Re: [PATCH] locking/csd_lock: fix csd_lock_wait_toolong() error warning
Date: Thu, 5 Sep 2024 07:59:30 +0000
Message-ID: <20240905075930.234337-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ba64c1a2-c334-4e04-8641-7a7d2abaee5c@paulmck-laptop>
References: <ba64c1a2-c334-4e04-8641-7a7d2abaee5c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b9e28d-9f6e-40ac-28a8-08dccd80b863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jp0IiA07ffdMHoW8Xf1gAXgzFS+3d8DaKVq8OBMwYSMz954R6a3gvwEWwYJr?=
 =?us-ascii?Q?Zl3KtNgKhvsCykmKJOcZK6ac8loMHECN3B9PMXssr1Jjl52hXNgCrCGqCKPc?=
 =?us-ascii?Q?O9PP/Yqz3NAKbfW4BEOAq/GSe2nukxRsnYCdt+Bkf0TbeXFTR0K/1189hxVr?=
 =?us-ascii?Q?7qJqSMQeIQADKxG1MZfC9azUhFKrRqXhZEo5Nl+zhGRjnTe9Y6Ie4NqKlNmC?=
 =?us-ascii?Q?d64pDXTmG3crfq4ka5sL/tyU7Kq1piS8cxgogteB856ivg7wiD7gCsHdK1vL?=
 =?us-ascii?Q?p/sr1xiEg25Sc8xMcVoD+kvlQjJTcb/DBcNFkrHj9njdRnV2NXKZxXmyd8dH?=
 =?us-ascii?Q?mR+wVive/ABv/JlakL0G0Yp5xDerpqy1d4h4i54aMzhlUKLthLxB+q7FfyOC?=
 =?us-ascii?Q?5J99DZqGLYQiiRAFpeKqwucjeSPquybFAr0uNqCPMQnuT7Boptxe90TnFMsL?=
 =?us-ascii?Q?d0klMjd/66UFGkGAuhxnGZqdbmGlfzsjXKeNBVTOvMoWk7IihrsMY3Au4GwH?=
 =?us-ascii?Q?Aj8bk5l/+OPqguke07HHYmI9vUuVWrVuxpOqgbTiDxO6IUqjvP2FlWRVtIeQ?=
 =?us-ascii?Q?bJ6TeREpNj7nNZ5fLduPylLhtcW/043O17DSfqYZ0OkYJUsDi5JIbHOLGTw+?=
 =?us-ascii?Q?T7KB4jAvh7T39dkYNAlwD061ZHhU0EadavaS1dRGjzMU/daRqGegohnWqslo?=
 =?us-ascii?Q?NbFt/l5dat0LEkS7R+sHctJHNhrjRpmTScL/qWQXwbleXFsH76cTywb/rOMc?=
 =?us-ascii?Q?BQz3BfSx6sPbMl+Oj4tXSs2M3pKng5bBmFhlvsZAMO/4wyqe2wHi95fkidsH?=
 =?us-ascii?Q?1ArZUllWwQNive6aiyb06MFJ9LZnMgH+G1pHt+5eSFO5+jp17YIQycVApHnH?=
 =?us-ascii?Q?ITL5oTBrpDOUbJTnHpK4NlcYvM94LpM1MUplKFtDzIBicxHlSY2koYjL2ciQ?=
 =?us-ascii?Q?9UOOepH29My6x74ZyexL400/BTYcHP2IxJTFwe9X2iPITOkHfqoQ++VypPzs?=
 =?us-ascii?Q?7lWt26j5HWbxCX2bL4an2d9506vvnMvQgYxzzlEvoXybeUBNeGu/0Q6ntOUB?=
 =?us-ascii?Q?otT/B3T9L7AW4nR8yVP7G5KPMMitKTAVePRXD4DVe5u6qt/kpESGqkFZu9QJ?=
 =?us-ascii?Q?mfFQRJThAtc/6XS0FwNBcV+WS6o39gkNDXu1H111BaV8seFOTDTNgUZ7tKXQ?=
 =?us-ascii?Q?EyVrLLxyBU+QP8hpGVJGOspU+lAXgNBpEIFMEKpxyT6+p1E8H1bYRbHLTVHc?=
 =?us-ascii?Q?jxH35dJtdkI0GQCcTlDGib+oe7AC1trNYYpPdC+CGJvTqR1UTc8H49xNvpw2?=
 =?us-ascii?Q?383+E5AfZaJQlLcfezAsb9Bvyi3Nu216AVETAExWm2a2XZbSuN1g8o6M7pyE?=
 =?us-ascii?Q?aKgpmjPu/Jpt0yDnBFFpIIjKu2LWyIrgjY4pAdLjkznO6yaBa359gUmhavC9?=
 =?us-ascii?Q?uk4WjkbOKJ++DhOTxxfthe8wpyX8F4+D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:59:51.0125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b9e28d-9f6e-40ac-28a8-08dccd80b863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207

  I planned to wait for the test results before reply. After discussing with neeraj, I believe that there will be a positive experimental result after applying this patch, and if there are any experimental results, I will update further. For now, I agree with this patch.

Zhu Qiyu

