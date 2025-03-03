Return-Path: <linux-kernel+bounces-545120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC765A4E916
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4E37A608A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC592E338F;
	Tue,  4 Mar 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VZrF0NCD"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28652E3390
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107980; cv=fail; b=WK4HR8g6pEwxAwwdgVO6uUsxOLSjQJCwya5DEvfhWPoa9DvEbYHt56klN0CE4oYSWowShjz7VChjsUlPPFZZG+lXT0uNPfEK5u0DlwU/ve+lay3vqkh/bIAdsEeWg72f3OApzYFa7vHrBkmYArsw2KdhwKkMbimgoPBQzCPliAM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107980; c=relaxed/simple;
	bh=BXWAPyNsgxAy7EFH9LCa3pbjpO8L60zVKWtBg7yJ0wM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqvSPHlTWp0lhzHEegxZfw0GLXXa3q09CXhYWGQcUifhlnCwc3UFVcyTKX+1CgsjIe+zSNpmlFM8df4dVjUXktOr+gI6g6INlVdegZQqBit0tzjzEOGl9MadxgQYSRIt4wYCeRkxpG0HhQlSbtFeE9pYnLBPkdqDUNg4jIHYMu8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VZrF0NCD reason="signature verification failed"; arc=fail smtp.client-ip=40.107.244.41; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 0D2FA40CEC8D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:06:17 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h4l5ggbzG3Vf
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:30:47 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id AE52B42728; Tue,  4 Mar 2025 19:30:45 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VZrF0NCD
X-Envelope-From: <linux-kernel+bounces-541474-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VZrF0NCD
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id D8CDE429B0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:01:31 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 22C802DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:01:30 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A1D7AAA4B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57501F55ED;
	Mon,  3 Mar 2025 11:00:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1E1F4E2F;
	Mon,  3 Mar 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999596; cv=fail; b=HRSIDtFUg2gJOmoZa04wdzTfusY3CR4CnTs709Z5V3OGsgV/X3VfCgUhCTvnDsJgCufT/7vq6MOfoLjMLlKR5KbTFqBJnTZRgXANVW3d0cPHKwApLO/dyEZcOuO4nvoFQL+d8gistoJlGKff74pnb4YJUZv7TtrSl1UfknoNwwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999596; c=relaxed/simple;
	bh=6czvyvz/aVtniO/PdwmvZ4uROFYXiuR7U6rd+M+6+6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEIh2wWP4q5deXhKhgn5J9Xem1RUcUn56NaXgx6Gl1+OnpHHcJ2qAjs+hIEncGyjHE91FngaEKIq89SaXvd42x3jj+7zwWONpy0fppZkxqOqjxf+NM9/nf2M905+nySp3ZO00JMOD7uTS7rx+7j6SsQCwxNRq7GFY/bYERrdcqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VZrF0NCD; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWVlDLdl8xsgArS85jwh3uKSQxsxhGtwtQB6rgiilOO5kmU5AB8VE1tR2CslWZsudOqd7s8YJNcXRCvPCAxDlnB0KJ0wvz8Ce5CZXRWPHp43LF3ba/WNXjTpeAOBy52EnovO+3b6xLMnyS1V/D2qlts/sBKdger9w2jeXZstoUon5lx0hNRyH0GFLJmlvKvMDxcMflFPIrMI8aC96XXFU399job2A0G1Br8o+9E/LO9QeGP8zH5AZzWiM4s1Skkp3IVfKwzShFb7O/HPzOs7JP8jdA4FIVJy0iLohkWoM1t3wToSlGO6HRXGIijCrSRg7rCJvxCIEkFDDtWjtOUELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si6ylr3W9qfOCdGH6B1BkjXMtHC1yKl6Atu7JYBfS+M=;
 b=b1a/BHvJaaXZU8rs9yi/U51EYId1j0v/g+6o+huwk3jwq/yueC1ucOyBLFIBAG5f2NxHOYG97S1H9WADfXvmJCfj+1qy6/FuEvX/Mabh5Dhg7elPfvrXZjY8HWfYr8JNwB5dhZZ2p7nQ3JU6BH3MOy8RsRT8FDnFITV1cyThL9huuklYhy1Hpm5fQNLbcfCxLP14Rvy7AIBLSZ7G9TeLVP7YsmViJrEByKi318XZ3Oj0IJS0o+1pUF6TYgpUF4m/E2WEQAcS+Ut6dKCh5LEq1we6ZPhF3vbonZeCdCLyA2vLCVziTMr26ROhROz3JxLlJ8iRZ/BQ4HmUpZ33gTeEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si6ylr3W9qfOCdGH6B1BkjXMtHC1yKl6Atu7JYBfS+M=;
 b=VZrF0NCDWRFhyW90EuFiXzM5qxYcX7Cy+xudB3wXFHAyIggBZDu+f38NuwbFkbCjHnrXQvIRCGCrCukyGdMeFiVGm5PTiNxj4zszWLdRzBVUnJr/zNoZCZnkPQOGuvsz9CHJMm4BPYts7JdmBC4bTfYr7UlqcIndtPL1biN7jyY=
Received: from PH7P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::20)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 10:59:52 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::43) by PH7P220CA0015.outlook.office365.com
 (2603:10b6:510:326::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.26 via Frontend Transport; Mon,
 3 Mar 2025 10:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 10:59:51 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:48 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 07/11] misc: amd-sbi: Add support for mailbox error codes
Date: Mon, 3 Mar 2025 10:58:58 +0000
Message-ID: <20250303105902.215009-8-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105902.215009-1-akshay.gupta@amd.com>
References: <20250303105902.215009-1-akshay.gupta@amd.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: de1b99d7-bb6a-4bcb-aecc-08dd5a4285f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4YhP6Q15/YSc7G/CTMJNK6Avy6HRkoEDZX+1AalEKwvFXddDb7TShPfxK1tF?=
 =?us-ascii?Q?XSIgqx9mOXIg2vAWdBPMssEyf5xiwRsRlW2KRhRxNBdncItEBdyZRunat3su?=
 =?us-ascii?Q?BO6apK5+RBooY5c/4Q3fMXomYfphxzYr86IT3+jaFv7yjdN/qyym3Xfvbzu0?=
 =?us-ascii?Q?/993PmZzkImklE/yj9hHZHQuMoJ+XtKUj6Wq3rWUwxVDgndoQ6Zc7DM0EJs7?=
 =?us-ascii?Q?jrzu9dlJ8EhgFdEe/zyj1/LwXxpDdg5ccoaH6pNZRfj8xNRzq24hQdKDC2nH?=
 =?us-ascii?Q?4dQ/dBXqvhQV2na9u83RMo2jZxiPHGrl8WqoL58ggfIr64oSbpiYb6cMG1wd?=
 =?us-ascii?Q?AiX/WjSkbCzK0g5ItP6vLYA5bw0E98iuQNTvmudCu+5m2REuY+MSyFrV+fKd?=
 =?us-ascii?Q?z+gjDna/rB5u7+QEe3M738u0XcjH9LszXKiNWbsBUBLYjKKX1VAjhBDKbnXV?=
 =?us-ascii?Q?y++AUeRXVToi9a1/01CEdcuR638ZCieeP4YA0868VGF36xXgVK9iL1CK48q+?=
 =?us-ascii?Q?7Ag1/NYEut/MqKw6afiWkD4RL5q+tKbg1nXjc+WKEHAI5ABwKnree4Sxxk19?=
 =?us-ascii?Q?+CocI92izUb45R5ZcZZcnzuDCwfleAdzjihNj+MQhMqLpoO1vQf4RZ7MS3b5?=
 =?us-ascii?Q?h6ahAI4t0Rk54q/8dp2+DLm1q8QbWTJS57ETZa3GxxGKTPseWXIjConuWwRt?=
 =?us-ascii?Q?Z6/gv7ER8IZ6BLSV+U7KypNY6qlE9Ta7oQBYNDkTh3QczrCH1VEESABtf8jY?=
 =?us-ascii?Q?AGD7MR2Lz7RvX6bKHSx7BvyNnCF7O8gpREa913iNGJz8p+syqP5jb5q41gMw?=
 =?us-ascii?Q?59z6SEHO7msMiEhwK7sRQsRuhu9ciVr4psn2lfPSy43uvXJlfgxyvCkjMwhA?=
 =?us-ascii?Q?oFRBm9yyiViP1GZdLCDf3Ki87GRkQ127rsCCi90nPxdZ1Xfup8ZTB95Yy2vB?=
 =?us-ascii?Q?ds9FTKgAr+Z71H7l1YnivZGXNYUfto3OMdMOR1z6Cq/8EfuuBbDVIZ+sUue7?=
 =?us-ascii?Q?qoBo/TjGSW6EoahTPbRJthTETaU3mDsgzRdvO1/+rsEpbYDmFLDNFGGexhGj?=
 =?us-ascii?Q?wzMp6KgPAjB62sS/qZNCgejttDMn+/dY5SrUo2pzj7UxMVkmrjjWJesppGtw?=
 =?us-ascii?Q?qrsIInh03OIOeP7Zz/BDJSvu/fjPHzu7I4rVKiZU9sWxlcRMLCThU3bKl2t9?=
 =?us-ascii?Q?4X+5SpOsoKnrsJYgRbQpYJnICWlvC09P46+gtQumQcjiPb+d8bUsybPbCtim?=
 =?us-ascii?Q?27mYZ+4szNz0vNZBTGZsaffAdGpPzBj48YcRZEK0m5lXQdGLs/YnEPqSfohB?=
 =?us-ascii?Q?zqhGGwPyoCcGils2iqZgQIfeFMrLwBMR9o+dGsrmKv9lmVUxefolOIrERBeE?=
 =?us-ascii?Q?CvMRlLMWiOVw5gv1H7lCzYas5vWrI5inhPRLy5MK0rQAK7gaXWQjbNmOLujO?=
 =?us-ascii?Q?q5uF2qq+bDZrpot48Owd3ryryFzRz2bQ/IBkrffaNQwCIaj2y81Pppf/q+Hv?=
 =?us-ascii?Q?xqWx5H/iZAtNXnA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:59:51.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1b99d7-bb6a-4bcb-aecc-08dd5a4285f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h4l5ggbzG3Vf
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712651.34429@bJ9oXI2UW8Rq7ZUK/jHJnw
X-ITU-MailScanner-SpamCheck: not spam

APML mailbox protocol returns additional error codes written by
SMU firmware in the out-bound register 0x37. These errors include,
invalid core, message not supported over platform and
others. This additional error codes can be used to provide more
details to user space.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v4:
- Previously patch 5
- Fix Documentation warning

Changes since v3:
- update ioctl comment description
=20
Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 12 +++++++++++-
 include/uapi/misc/amd-apml.h    |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-c=
ore.c
index c39a29d90c27..642fe762cf6f 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -25,13 +25,15 @@
 int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct apml_message *msg)
 {
-	unsigned int bytes;
+	unsigned int bytes, ec;
 	int i, ret;
 	int sw_status;
 	u8 byte;
=20
 	mutex_lock(&data->lock);
=20
+	msg->fw_ret_code =3D 0;
+
 	/* Indicate firmware a command is to be serviced */
 	ret =3D regmap_write(data->regmap, SBRMI_INBNDMSG7, START_CMD);
 	if (ret < 0)
@@ -72,6 +74,9 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	if (ret)
 		goto exit_unlock;
=20
+	ret =3D regmap_read(data->regmap, SBRMI_OUTBNDMSG7, &ec);
+	if (ret || ec)
+		goto exit_clear_alert;
 	/*
 	 * For a read operation, the initiator (BMC) reads the firmware
 	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
@@ -87,12 +92,17 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 		}
 	}
=20
+exit_clear_alert:
 	/*
 	 * BMC must write 1'b1 to SBRMI::Status[SwAlertSts] to clear the
 	 * ALERT to initiator
 	 */
 	ret =3D regmap_write(data->regmap, SBRMI_STATUS,
 			   sw_status | SW_ALERT_MASK);
+	if (ec) {
+		ret =3D -EPROTOTYPE;
+		msg->fw_ret_code =3D ec;
+	}
 exit_unlock:
 	mutex_unlock(&data->lock);
 	return ret;
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
index 5721aaa0c6bd..47a057226300 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -38,6 +38,10 @@ struct apml_message {
 		__u32 mb_in[2];
 		__u8 reg_in[8];
 	} data_in;
+	/*
+	 * Error code is returned in case of soft mailbox
+	 */
+	__u32 fw_ret_code;
 } __attribute__((packed));
=20
 /*
@@ -60,6 +64,7 @@ struct apml_message {
  * The APML RMI module checks whether the cmd is
  * - Mailbox message read/write(0x0~0x999)
  * - returning "-EFAULT" if none of the above
+ * "-EPROTOTYPE" error is returned to provide additional error details
  */
 #define SBRMI_IOCTL_CMD		_IOWR(SB_BASE_IOCTL_NR, 0, struct apml_message)
=20
--=20
2.25.1



