Return-Path: <linux-kernel+bounces-311993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD26D9690AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC9D1F236AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A24685;
	Tue,  3 Sep 2024 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DD7J1b9d"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0BA32;
	Tue,  3 Sep 2024 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725323724; cv=fail; b=vAd+l5SOruc3RN92VjN69ZEut5CXJVWBzdYyhYfOPqjMUcJpk9GwxZ5o701iOqzhjsbssu9QRuRb6sQ6FKHxMkZjk8dDsDLjX3ljdWYKN9dIT7C1ZlROeu1+SMNwngo1bmyea7lZcvX0VOzBM6jf/JTGsx3cJskD837w7GyP3X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725323724; c=relaxed/simple;
	bh=IgJeFnWDo/xkIF0WeB+5heIH0h23iFKh7c6H2Z+3KVs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oetv5F8Q6h/I5SxASpNpz2sqb3hbM8j+i4zP32aph5ajxS4XCEZnphC8/v8wTe6oPwLLXSBaQ9Xx14pWybpWfw9zvWhTRg83DroRCr+2T7Mz3gibW6nkkaAoUuo3PtkyhRpv3lUOcsXmMJ/TRdc5xDpzGlOnDiHE6wykaPekbxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DD7J1b9d; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALzG67WfYDSwbcuLdgfbaNL1OoSfrOZ2xXbs9DQcp9TZWlHw8PlQBVtDH7rIu3aWiLFZz06FMpbsoubiY8NwOBY/TK5KGsUpwVfhy8Pw2lX083/cXrhN4dDZWfXJOAJfn/gD5topUJw9eMDgpX9qJ8Pwv02PJ4exoHGxW92MN0Gz6b9sFRGe0BZqjo2WoTeGq7SuyAAtbPCgNJDOaIkZdlc83dFR7WAveEKCfhsGDr9j6WUqUtR++zktLe24XqljbxH3cUEiQvkGtwgm6OAmbEqRIhQJB2yyc8W1slWGYLX4o5XX0T2a4Nz597qi3UMfNcFtpV/2oRLhjrFOajhiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlVaQMxHYXeuWgNdIGzM9tHWXt6wZvaJyjCBAFpTc+8=;
 b=yJFHL395XY3XizIdewAeD0BumVRnfIe+dNYPDWO9TIatEpV+IMsUOrOafGZjUB8f50vc0l8+RZjBvoUmzyevmvZcpPU9xskD+9PZJwna12wsGa11p2QnW5XHDSgOT2UFzBcLrEYGIMt27PsKTc/hwHXtwkAD6H+hKR/qoxD0nx4WNDSG0+PlLSD80GqIB5ofCQW+VqFhMqR822jIQH9bmWiOTE+8LcCBR3f8ishnrygAEjRABoHdIvuJ1DBIJgdg5cOVD4hPf3jmWPFh6+FKcRCUfkl8kr8EQkRo+6UupwLLPWPb+xcej1yiENhfVGByYF9gtGVY/Gz8pzy7vVgjvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlVaQMxHYXeuWgNdIGzM9tHWXt6wZvaJyjCBAFpTc+8=;
 b=DD7J1b9d2B8iHX2Az/z1U/E19xHDzDK2+Y2BkiZ2B06EzJdSYVSXghhA1fDfZHEMMY48ZMDyD9sWLNxeFqlDkFffGtknaYbiKNzxWVmc6X9sbdsEAPIKmFFF9FWwT1/l3JjjszkTWdmzzPfwC2pU6IU+nBOR0af458W+7HZ7loU=
Received: from SJ0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:a03:333::15)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 00:35:19 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::9b) by SJ0PR03CA0100.outlook.office365.com
 (2603:10b6:a03:333::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Tue, 3 Sep 2024 00:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 00:35:19 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 19:35:18 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v2 0/2] nosnp sev command line support
Date: Mon, 2 Sep 2024 19:35:09 -0500
Message-ID: <20240903003511.1530454-1-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6df92f-11cb-44ad-7b17-08dccbb049f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BLEJ0LaxVgmZPnsn8xDjJ0v8tZhV0Ik3wR1siQFYbyz3mOQxwN0n3HrfFQ+D?=
 =?us-ascii?Q?LcO7XTFhZ4cqRaf3+jMWrmP5kyZ71Aeh3uhNQpTzUU71cR+7UpBmMEAAA1FE?=
 =?us-ascii?Q?JUH2ud5E8M4FabiyPJVZ/jZjlt0Irk5CPUOykqTjyZQe3Ytq0hZFez9QC6Hg?=
 =?us-ascii?Q?beqM+owYV/K4nS9LC5IfgvYVE8QFXgIGpxNYnpGJ4d/rtXwC6HDAWA1V5jIx?=
 =?us-ascii?Q?tyzskQeQgL8mXxqWaG9bLFn/SPKn3Uv2Z17GNbj7kORkPN4Ckha2PVU0SVam?=
 =?us-ascii?Q?Za1YK4ba55JZ+NzeU5uOl9iGvIyBUR48+g4TaciG6YxZx0TnOeG89Pi7vsgb?=
 =?us-ascii?Q?pnOBAfjbCXpmyXEBFDwV5j6L8nZByLBssNI4PUszdTFCgnn1rh0yjvoXD2WV?=
 =?us-ascii?Q?dmNQ7NmzxhfCIIbrBVRkfwWIdSrA0YFkElPjx+y+LiPFh01NZ7oG9Ih6tDVI?=
 =?us-ascii?Q?9+02XxSJxJh4zRhhU4Ps/x3bupk6dqT8kQO/n+T3+3LwR+0JG5yBZDHnbZro?=
 =?us-ascii?Q?LnkQBKsZU4NYaEbFYQQqF9RrTg45JOgRxNhPU5tuDDukJg6szib6TdQTGRFJ?=
 =?us-ascii?Q?cGbgBWfEHV0SPAPioXpf2yHjiARl3Duu4p060bJzk7F9mAMchqtOZEMGAYUy?=
 =?us-ascii?Q?4eh+C1Ox6rvWqqZcf4fPxCJeIiScHXP4O6c1KnHANZCmKGhq2J/1EbkGA1wn?=
 =?us-ascii?Q?DYwl32jFRsqTeMVWT2Y3xKQacfQEwG8i5Kizk0o0iQelg/8tKaNdCwrPK43i?=
 =?us-ascii?Q?+31dSuGV/eJ8HJrHCtT8A1WTHAobT2kBZLdmwjRr6zOwCoE23Iyj4MTFKhUp?=
 =?us-ascii?Q?OU6IRgrUfp97qXACKMB/r7QQfVO4ta4ncPIw4qcITk7KyRz69kUtMKP+JGjJ?=
 =?us-ascii?Q?ApJYvC6oRqwAy605jLQBzce3vgxXgYfDzGa/iJxcpsMgiOb6rCkEdU+7pVZ1?=
 =?us-ascii?Q?ctG7G5kntcvVcW/2GV1cPeFffW+oOw348o1tnISEO+6ejj/kN8jAnZHTh4xY?=
 =?us-ascii?Q?Ou8bTjCsEBJdwuqO+D8lZAu0Oa1mQyuuJOj/xdlM8qdCH5TCcnXotOfnPLNE?=
 =?us-ascii?Q?tBVP/RZngbeA31I9n0ETcOs2+A/AQsUyzY9/VgENkfOw7rpNXWjlpoVaEmyn?=
 =?us-ascii?Q?2KlvUTABlRto0gk7aGYoHJo6CwbvO6YNwux47N+7INGbtkrAlfOdiKu0fasF?=
 =?us-ascii?Q?c6a2LpdXsOYqyfJdZVI/DK/sM3VtHhLKBHuY1Ocb/vfZteArsAW9tLDv5ZqG?=
 =?us-ascii?Q?7jbzk9cn3dVBqGdy98Oy7YvyrtJ/bSCYV/wT22JmBWGaXib5Kog+lmjpbslS?=
 =?us-ascii?Q?s0S9nu3B43qilRV1bIAjGkBgKgqSxc3t4rvS55aE9W08cP7BuH3R/ynUdBeN?=
 =?us-ascii?Q?dJ35yKZ/OUtz/Fun4KoXqyEKx6mBVMzUT4U1yLIyeLzjvR8F2knwOpc9GLN1?=
 =?us-ascii?Q?Qub4YJ+rV0GqgbnKb6xc8iGdpsZ1ylPQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 00:35:19.2462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6df92f-11cb-44ad-7b17-08dccbb049f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

Provide "nosnp" boot option via "sev=nosnp" kernel command line to
prevent SEV-SNP[1] capable host kernel from enabling SEV-SNP and
initializing Reverse Map Table (RMP) [1].

On providing sev=nosnp via kernel command line:
cat /sys/module/kvm_amd/parameters/sev_snp should be "N".

This patchset is based on tip/master.

Reference:
[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

Changelog:

v1->v2:
  * Pick R-b from Tom.
  * Include only those headers that provide the necessary definitions (Boris)
  * Provide appropriate references to SEV, SNP and RMP (Matthew)

---
Pavan Kumar Paluri (2):
  x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
  x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line

 .../arch/x86/x86_64/boot-options.rst          |  3 ++
 arch/x86/coco/sev/core.c                      | 44 -------------------
 arch/x86/include/asm/sev-common.h             | 30 +++++++++++++
 arch/x86/virt/svm/Makefile                    |  1 +
 arch/x86/virt/svm/cmdline.c                   | 39 ++++++++++++++++
 5 files changed, 73 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/virt/svm/cmdline.c


base-commit: a85536e1bce722cb184abbac98068217874bdd6e
-- 
2.34.1


