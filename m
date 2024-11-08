Return-Path: <linux-kernel+bounces-402166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD59C2498
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8011C282E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D91AA1C6;
	Fri,  8 Nov 2024 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="B5rIoUMN"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2064.outbound.protection.outlook.com [40.107.247.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE81A9B5B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088984; cv=fail; b=DXfuu7eNw/y9Bmb4FIskYiwilWbIKasBubcfzcfL2QNZTVUDoyKg5bL+FZlbNCD5db/LwC48zMJwa3c+4teQekzXqixWoZoMnW3UgqWJt4A+Fl3pkVvOt0QtxV9XspQEX/2nxrqNn0qiiX0/r2xaUCYeKw6BVYKF44uWrvxZWoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088984; c=relaxed/simple;
	bh=h7DbveYZRwP+c3sjVZEdbcGN3285kS8jhTCVLv1GoXc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QEvRrF+5Bo79ZCJ41S9lkzGuET871RnNQE5TayNME1rrptnHd+Bzy2+JTBgu4hRLWQPJEUFUNtgVOJEYzgpuhMeOqsZiYENWn42fSzm6rSvj+Fe1Qe1DK3XYYPFpbskAO/vR8h8AHiH1+USNi8ugJSp3uZ0c4aF4ayVoOdSUCvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=B5rIoUMN; arc=fail smtp.client-ip=40.107.247.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdmhVffJaP6zwexkPiIvUFoPqics/2EKEs1Ty7do9XV9AODlKoHKw/29Aou2//J7GwzGcE7eXM/Wx1YxzSHIaEeHPPPbYZfy3WQxuUGqRNufqs87s+YXmXKQIhxeZCks5tENt+MidOKRRcoKQG6b32XOfbQYAlcL0mlPHfI2BP2SocaJ3yGZPXPvsEybYSRV7HGpKwYycPOf6ASZLegfXal4W99Daj5y9+IGfqqDysqsCA3A4YPGe2ePhNXOngejG+uDt5uj3DlV+JIe0HSglNeY9aY9km8cjCFwtJrNCa9ZHhJwdNMf1oOpoB8ZCNL7wQ8Ahl3plLuAJz/7/zY9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7DbveYZRwP+c3sjVZEdbcGN3285kS8jhTCVLv1GoXc=;
 b=ZH9Bi3iRAHow7hU4XRKPv9A/IaMcwR3P2j+Fx1bgQGIx/YJER+1joVcetcOe1NiGXnMqLw1JjpSN6muPS8wf3o6mS170gwrMjr8Fq6rBKMp2p/FG0gaBn1MiSSYXiHjAGKlJy5joJ+fiX1UMwYrG0zK3U+lDZzIBcIMPF8eKsv/bDI3E7Hc/N7k5FqZp0pFTjq0EeaAdixdnIW/k28561+dK8mVeFZI1lU3HWA/RBIFJ33fiuGOilbik7abM0Jky22yiBn9e9LNCPpiaBUuIHj8k7VrbbVvEQmgH62yDcJ9z3O6VA+zhII5etQ3/EzIGTCp3Q4x8lyxcXXW70Jp0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=hotmail.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7DbveYZRwP+c3sjVZEdbcGN3285kS8jhTCVLv1GoXc=;
 b=B5rIoUMN8cgWFnCorA3mxZ+TvKeiKJrFLYdpcfD1N5VQcWqnk1vHXedrVFBbfFAKlsfsOOoUNwM/MQJ7YlKb5kHsq1/irLeZ2H3lquiJABwfzHX/Z6WTc4yrTtY1o3ZMPYTuZAuYGMZJQoyPebZ5qNP+LpiAKH5eObX9aXbVnos=
Received: from DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) by AS8PR02MB6726.eurprd02.prod.outlook.com
 (2603:10a6:20b:239::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 18:02:57 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::53) by DUZPR01CA0053.outlook.office365.com
 (2603:10a6:10:469::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 18:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 18:02:57 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 19:02:56 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryder Wang <rydercoding@hotmail.com>
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
In-Reply-To: <pndttci1xgd.fsf@axis.com> (Waqar Hameed's message of "Thu, 7 Nov
	2024 23:38:26 +0100")
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
	<0f040e0a-c27f-2f29-6d9e-9c7152a18513@huawei.com>
	<pndttci1xgd.fsf@axis.com>
Date: Fri, 8 Nov 2024 19:02:56 +0100
Message-ID: <pndjzddzjqn.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|AS8PR02MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: a32db78d-667a-4d23-bcec-08dd001f93ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|32650700017|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Ljq3JsECBCL/Nno0GE9Ge08ivHOEhuDKBH844ET4oj7uS3bUj4WwveMRYiZ?=
 =?us-ascii?Q?60tQ4Ol5QZSMTq1Wtoyaft4Q0GwBgw/krFK4tn6dj5/NaIm8HaHw10tyyuNC?=
 =?us-ascii?Q?xY4+kktifYYw7CXm/YfadGCej0rqNO2bRUhwp0kvoh0iQ8Cvsqp0fu+rTdpV?=
 =?us-ascii?Q?WWsUXnldPnLRGQt9/56ILBiAJU7CfAJR9yXTCj4wqa5Lg9b+fcdv/Gb0nwJA?=
 =?us-ascii?Q?NBxNhqykdLWu6ARXPM4XCfrdaUI4c4qdaHm9+QrGs80aUmoe4ps1O6joAgPQ?=
 =?us-ascii?Q?RHy7kLrjMIWCR1dM4ZjEVDjPXhD/5jGeRLigVZMw5uTvUr/44/QvHHOxZnwi?=
 =?us-ascii?Q?qA9vhoUIxcX7OBuim8EkAwAuIM2uFhCIua+8hsypfrl4idou1VnyHgq9OEGh?=
 =?us-ascii?Q?0MWB2tfKzrdDopMSbm7CIL/C8sgLV1uD1cn72b8UbA6coUXZuQ0wOWQU4XLw?=
 =?us-ascii?Q?lFU7qSHuWap2JHwBG4nQdW7OfDXnjmuZEn+7AnvdSZQ3NWpDMSA/KEZ4cJVQ?=
 =?us-ascii?Q?bc0Xh4+VncUxQWSfQQHuYafLF3UVJPngEkRH96lJxZfBCIl18rlISv91L4a7?=
 =?us-ascii?Q?n/+1xOexyofmX2ZVNoWaGsMpEUAL+a3rF5wrJ3hRcggRLhn5bUV1n6V3buT8?=
 =?us-ascii?Q?rxls7snFW43dlhcUnwznP/4zBp8nD8RXGRLEbl4MZyqaTBUogGvphKe/xwSN?=
 =?us-ascii?Q?AnejtJFdtcrOaPucTlFNjPz477fzUXpnHwRGX0PLKBac/84W7sdzKL8pfr9F?=
 =?us-ascii?Q?55UfTSZ0ZG6DXdhO+4FE3/p7Bh0TuOWiNyTiG4xOTG/uK0p5Z1rY4mNscjDU?=
 =?us-ascii?Q?mblqI65WtxHtjWVbVfXHUfz/aSrA+cPxStC3b5P6BAIsW+VwqoLFqTt6WvaH?=
 =?us-ascii?Q?JREC9qhDRo9ptIApm+7uiGVQJb8d6jt5NGLnvoZx20TeaKM0ukoFOwSCgS2p?=
 =?us-ascii?Q?20/ZcmuIT3LJX4pjEDCl+pLwLbs9s2zoUQkReRTqq1xjgf3daZX41anUdWXG?=
 =?us-ascii?Q?2ySJubO57ZhJYZsnPm2DG3pv3qDVJuY/fCiiDKQH87Yw+XK5CiWuTZsM4yfk?=
 =?us-ascii?Q?R9Y+W5YoOJUIeqJd6pUl+jhk7Fq68N4zwywsln/8OWvH81wqcRwR9biTaUKl?=
 =?us-ascii?Q?SnmQXMNxCzsaIlUTLE/kf7i/I+D0QzFUx+ecBMvLh1NUNjwpEPVNrJV0wMVt?=
 =?us-ascii?Q?gA0RmyDLM0o3ONfoy7fr5xl9ht96cWet5e+QjlXZoVa4v60Nr97G3O0V9ury?=
 =?us-ascii?Q?pyttP7+jv0t3EuzJPA5ecPHo4o5XD0/0WRlPyJvx0/htRk0tVVkXxAYkjk3B?=
 =?us-ascii?Q?f4JcjPSIYPp8JMZD27lPXx1Kp35Z1xF7rxJypJ1WpKrGWdN60+9muiGJEBMN?=
 =?us-ascii?Q?zybXhkl3++T5x4/GbKgWr7hBAf1OI9G+Ku9KBwNRcvNHQ+muVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(32650700017)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 18:02:57.7476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a32db78d-667a-4d23-bcec-08dd001f93ad
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6726

On Thu, Nov 07, 2024 at 23:38 +0100 Waqar Hameed <waqar.hameed@axis.com> wrote:

[...]

> I'll let it spin for a little longer (recall that the other patch
> "masked" the problem for almost 800 iterations).
>
> This was quite intricate and I really enjoyed your little breakdown.
> Thank you very much for the discussions/collaboration! I'll let you now
> as soon as I have an updated test result (and thus send a new version).

It has been running for more than 2100 iterations now (almost 24 hours)
without any issues. I just sent a new version and added you to the
commit footers as well. Hope that's OK!

