Return-Path: <linux-kernel+bounces-213948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B69907CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245C61C237D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA67BAE5;
	Thu, 13 Jun 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="PKaSj4ZB"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2093.outbound.protection.outlook.com [40.107.94.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D15A4FD;
	Thu, 13 Jun 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308228; cv=fail; b=U4X9W45B9i4W+NSb18PggqJxWJMIE1gmYBTTxM0AGX5TLXThsr8vl3duReAUwmuzQUGHja64SirVNBmlXYl8F7/RuyQwGDhKMQtjBl+a/yZGPOqAfhdmDQLoXZ8B/ZnQzib2v63cKxC8amcnlvy6oHWOybC3aKOAcoyoJpW06Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308228; c=relaxed/simple;
	bh=xVbP2ClhTjyT4zV5yOctUkMXaxteAUgM/0Dm9xxm+oA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lbKGCMFl//WKA4t/IVAtMW0oiqOGS4JEUPfOYQ/ntTHONB1pyjo0FZwduRW25OIhwbJk03UDeinVQD9OYB9OL+6hNBtMgPBiKHXhiV1XjLqmyA97x7eJRPkbadymHOktMoeGbyb0GN0S4Ulyaj1C28mX4NXAu++lZNs0i2ehl7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=PKaSj4ZB; arc=fail smtp.client-ip=40.107.94.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy/pEuIsXrLSq0sSmsBXyKawhhVx1/Hsq/D8T47HMZtgHzMQwrKuNulMCG6kEitrj1HBNfwVz9QQG2+x5wYkh8GrYUly10ZCguNyNqkogQlQKfkk+hMQfg/K0s2wCYUe9Mx/Zzlhe20ughYtZLjLyO6uAshaq34ITzvsI35o1ZvBH4dAItv2EcCZFbZLQQ+Pq+VV1Zw/sPgVVTVstr4kBJiq030C6N3l1EEt5UhmP9sooo+zB6i2xMpPxCkIowZiJ8KoAmFLYhgMup7Vd9B49KI9e89O7BvVZf6nTilhjyQB28msGlf4GsgOKaRKRJxg15c+rvdZ5QbuXEFfR+JEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gink0DkEuZmT+hXmJEOwQ2q7ct7p3O9A2GSmgX4tPTk=;
 b=FrEafJVWkOEYv4TY+uKR+7n8N3/Gt+l0QOXSJIjfeyFsWmAKO7Rjz4G6CkeYlbTh+0dtnwj0M5MJN+Cbop/6jb6dpWiK/6O/yIDICMZSwGhzErgfX8OwtPsfbgIFPyX5ANE2IPkIs5Qg6CbdkqqgcJXBJNZRSTONdabvIbG8p2JOZpVPJRiDfvgaNNwP+Ekt3dfRD1d4m1ZNOFYYrHXFnxm2PRdb0bAP2TLOmjkxpxtUBvVl6pwJINJlhTk5q69kpmU1EIgEdtBPz+2KGWP70DMdpu2psok+oD1h6HjdHrjSGiX9exPPNmrOeiO8MRKNQc/CclsErX51xW0sNI4Iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gink0DkEuZmT+hXmJEOwQ2q7ct7p3O9A2GSmgX4tPTk=;
 b=PKaSj4ZBQeNJMfX74KYzj+3J96ZNKAOtPVK7qKdNDB18rbezFWg6QBKVmTlNAF63/7E9mdFrJN8HBicx+KCi4VNb693kKebcFISZalCVZx6HhaoC2UFY456kYcVdhWyxnfYXB+EBNccemIguN1A2hu6d/88PdEzoibFimAJzd4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by LV3PR22MB5145.namprd22.prod.outlook.com (2603:10b6:408:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 19:50:23 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 19:50:23 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v4 0/2] Add PCIe overlay for am642-phyboard-electra
Date: Thu, 13 Jun 2024 12:50:10 -0700
Message-Id: <20240613195012.1925920-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:610:119::34) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|LV3PR22MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c6ac5b-0a60-400f-d869-08dc8be2102c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|376009|7416009|1800799019|366011|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vWWnVmgJNVSwbUzqPeSPF7lwscZ3Cox77jkjq4SLq+al/s8H1pWKDg/6PPKb?=
 =?us-ascii?Q?X5uC9NBp2zjD0RzNhEydnsZkSaxZ4Wj12DBToyjCDBRG2RywH23cil3pGTL8?=
 =?us-ascii?Q?RtQldhVgtoP1S1CrMxq2n6C9SrD6Rjvelgl/58u46P/jIOCbZ4wYNP3VEduz?=
 =?us-ascii?Q?vlSyyZk0YGUGjPFNi6iVjk1AxAD5vnJkJDovliMq1rgL2/2V28l0AYEWbFEI?=
 =?us-ascii?Q?naq9agJCK2fH5ibLHLklKB/9JrUEaQmgPLnyiZ0WPymNLxzze+hn2CM9v5Ds?=
 =?us-ascii?Q?pQ28JPchFHvejAF8PjGhOpnwYTnpvqVT7XkpjFHNaIRzoP2YSREa2FP7/+hz?=
 =?us-ascii?Q?/y5oT0i9wRjVBtGB7JBmdyLntLA+hDMhNPJWcAu/3g5cjeoKvl/jM6AYRKEj?=
 =?us-ascii?Q?l7jr+iFExwyktMX6HsE806FG3pIaMWEfIJLahrkxCYUOnwd4lcSlppK+AXaq?=
 =?us-ascii?Q?mpK3WgY0XMEcow3WcYUwrd/GfloXUAdQGNdFL1qwR9709YH+Ga0kMgi8ibc9?=
 =?us-ascii?Q?mrZ1WovvhnjzDPiLVkP38F9pijv2bQKZDvFHeb+QnE1tIU2IRbgW0cb1d7qi?=
 =?us-ascii?Q?Hv8xsXUQaWLsD+rygze+o3NQz/rtgiKd6MdDCvKjP0nXOB8OQ/G16p1mvqpa?=
 =?us-ascii?Q?8wU1hQcO3do06ZtVW0exXsJ+4jJZepsGfmHUf9qPIOfgVDH+u1lJv9u/c5y2?=
 =?us-ascii?Q?Un8Z8kpXP3lDUBoVqx9ygowp0VLplcKiPBdDkW+t7lJneWa19MxrW3RwPXmX?=
 =?us-ascii?Q?4QemKaEWtIgM/sTXUpyqn/FWdN2/VIoGpQdWDr2Y1F0IF3SsgvDHv6GtshY4?=
 =?us-ascii?Q?dpZ37rUjWrh3ZtIXU5Vi20gcRi3OlOULXumHQfuOT+isOcJUbxrTESQN5/dz?=
 =?us-ascii?Q?cS+v0nGQCizbolOy6nFWRGTIgsOmFIV6PXLiWhIVVkSb7FBpdLoMUgqjt3fq?=
 =?us-ascii?Q?2VwPgqEP35/VJaaoLd6dLEnbKoEgzyhjgCWY/Kv+5E8TVrUCaHuov8MXrxRm?=
 =?us-ascii?Q?chmVd1hqd6M44MEM4aPSVCqDwStU9yRwuICsOnOhvnxFyRhubj5WksxwsrIr?=
 =?us-ascii?Q?8aaJSwTxP5CAoAHLSxAfEuqa/16uwKOC9M7fnp3EuybojQ1uQZ8lJg2H8fFV?=
 =?us-ascii?Q?l6T9m9iGqIcfI4aVH7IelunbM/lAzjoteyAPvL/5+Hy+5tsEJ8EWHn6YrEfE?=
 =?us-ascii?Q?At/Ug7NCtOpWk8ejS22MvhsUc3yvNLZRw/5k9wnnVTBgXaf6yu7vIyh6fbiV?=
 =?us-ascii?Q?5hcRpIJ6Lfa1+7mMt2cTRDM7OZfq1e3BRGQBXbSzvrKEh8PZdq5oUZE/ep9y?=
 =?us-ascii?Q?lv4gJYTdkLPoMB/nJc5KG31aaR6yXEMQhSx5p6h+d2kVM+QqjDJFuUAbkpEF?=
 =?us-ascii?Q?fsAtE/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(376009)(7416009)(1800799019)(366011)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Z5z1S2WA/CYmCcK2y+G0oHiMZnrtP8HN2/xf5209RO4DvCfCcG19Ty3v/Fn?=
 =?us-ascii?Q?R2kuHXYb8xWCovOfQqRPodpVwfPux7PWltZVAwNyauprRn6UmjrtOZNqWxR8?=
 =?us-ascii?Q?345dCj+G3PrwTK4Wti7+ZmW9hO7OfvVmiaaHa2CzmDxNlwiNmrziGc9E4YIX?=
 =?us-ascii?Q?JugLztREIWq+YyOuh4J7njtLfGJNV//7PVDH0hWWFFFX8KGDxu7du8VDG7Xe?=
 =?us-ascii?Q?eCXNNfAzq/pNc1Ws6Q9nsKLjfndOV7DAsqwGPogPQR0vjhvIwQ0h2L7RiyoJ?=
 =?us-ascii?Q?pt+au3gnBfVraZVXxzTcHHtTrLI9qzj6Y3yB0c2C+HEuBXxJsNeMbA49/cTo?=
 =?us-ascii?Q?3JAXn7YslvUpMqp7KJnQaNGbt2niPJKUetbPpKtKcjALTvIupLJExJfvGk4E?=
 =?us-ascii?Q?Kr1S5Nq7VwYPJPABUTzSydLuWG9VFOngqU2zPaonlcn8mcdY5XJRJPbkG5sL?=
 =?us-ascii?Q?8y2Ix26uquEvni7wBRHWYu+pXNqvlz6JnWRVPDBlk31DTEA8Zc6i3ZuAxgAE?=
 =?us-ascii?Q?PGKPjMSgX516RC8OciBtXX1GH4lUtRZBLrcyMBciYVhLYM3MXtBVoQ4n9Be0?=
 =?us-ascii?Q?42mcULDGqDpwV/kQ73O5PJ/j7Ul7IJWiZ6q3yuWS27u9udYc0RE2HDSIgoaD?=
 =?us-ascii?Q?0KToNao8eQov1ggdI+K8KkkwykajyRf+GJo5AL7xGyj6lEefpFWHxVsT22aG?=
 =?us-ascii?Q?WVQa551m1v+UUhYrcXTltRlIsy1Xeo+pnyVlZmRtMv9cyeSfJWFRhVhahapz?=
 =?us-ascii?Q?/f07TkDxUBjOc1WewCSEGygwcht7UQqa5tfr8jrDxrRcPJFX4fIGeARCCb5d?=
 =?us-ascii?Q?KJAxofI8T0VeW54Zp7WqjGtqOOm3MXfMPy8jLYkiDoBsOKYpbA7X5np8sx7F?=
 =?us-ascii?Q?u1QbPHltNegHgN0LADwy5vhw38/WQAEXDfziwqsGWDIhqBQTDdm9Ouxszc1E?=
 =?us-ascii?Q?e8KFmKTOlH9ltTsobVDXVShQpkpIayfTCHmIzBTu/lOcsEIN5IUm4AQ6qtCm?=
 =?us-ascii?Q?PaNcHJEawreJ6z7cmAuYuzVWoYtaxelhZEuX+wBmfql/kcaIT+a/H59NuNnN?=
 =?us-ascii?Q?19r6KpQlvsQm5DycGc2lOGX6VOMq7liH3A4RRF1E6U0tbdXUNXBy6HRLdI1C?=
 =?us-ascii?Q?Rrnj+9xKf2iMgQgfbm1Ir2kH2ZD4Rkwyii7jF1NtL7NxPfz/roGqaXIXEGQ3?=
 =?us-ascii?Q?GLtTsVC23ND2Vvyy2M07g5QGEK9eNqc+q9qqdg4GSZOqotlkn42TJ5yTfe84?=
 =?us-ascii?Q?kYd7S9usZxK12jMvmtf4yfzSIJEjz+KAK8qFK5E8yeE6/dl2R2zTFZrTk5rD?=
 =?us-ascii?Q?aI/6/xUR/wq1TcWg7/M2VY8BtYKyemnZwz1iQSmsUb2/pAKZFc45XwLKC9Uh?=
 =?us-ascii?Q?DuGSn9dtwQE+bT9MZTiFgeb8vGkQCNPDn7+bW45tjpuFq6obmeo+5Ow33jvp?=
 =?us-ascii?Q?/e5kYBJTR3yAorDc727bCYcENFDWwVElIufffgXUUMTaein8O7jDbiWGeydW?=
 =?us-ascii?Q?pkCE008DmSRk6VDY8rgsZbUU48z9fiPnEBqQ9wa4jMbvgwhh29PvOYTgR7Ez?=
 =?us-ascii?Q?cNtPVcBhK2QbwvuQ5zqtWofm/gCvh0z77Ndm4u0B?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c6ac5b-0a60-400f-d869-08dc8be2102c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 19:50:23.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIAF4h+VGqJ8wR5ASNTQj2vThwGUOZNshtumN2cfweJSmTIyvxSc4oFQqZCilbzLoGtME1ep+EW583/G86bZaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5145

Remove PCIe pinmuxing from the am642-phyboard-electra device tree and
provide an overlay to mux and enable PCIe.

v4:
  - Add explanation for disabling usb3 to commit message

v3:
  - Fix typo from .dtbs to -dtbs in Makefile for overlay testing

v2:
  - Fix double space typo
  - Remove redundant status = okay

Nathan Morrisson (2):
  arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
  arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../k3-am642-phyboard-electra-pcie-usb2.dtso  | 87 +++++++++++++++++++
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 12 ---
 3 files changed, 90 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso

-- 
2.25.1


