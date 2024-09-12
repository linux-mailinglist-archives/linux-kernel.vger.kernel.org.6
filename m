Return-Path: <linux-kernel+bounces-326040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C29761AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F001C21426
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1525A18BC1F;
	Thu, 12 Sep 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="PRVOoAkR"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2088.outbound.protection.outlook.com [40.107.215.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF071189BAD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123235; cv=fail; b=gyX7bywqeR3pGY59H5hETkTVS7rEd/5z4CjeVQnvT0pUpjWf8qFRxUo5bbApEOrz/axcKykT04V2wRZIt/cKWTEmelA68xcQyDszNFBcs/RF4qkZDpxRUdqIDmOzf1VVxLY2p+xbqbxGfKos3OFALozbeB9uzjQqe7EfTHN2v/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123235; c=relaxed/simple;
	bh=Ir6k0yeKsehzFt6REe6gcHb4HFE9yH/qCvDv4K4wrDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o0cbbJflsf0AWe6oMz9kFiqbzIPV567ppLrxJhp5OFHFwAVODd89vz5jePx2tMyAbTEbg3o6hnxYqL9HbtGB5gRenUo6AAWNWerPQnmZBcgrZFBkD8CDP9keSR0J5b7X0n2RmgERoOFKefICCn+LbCl4nHj/Di9EXMDSWRMl1H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=PRVOoAkR; arc=fail smtp.client-ip=40.107.215.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoqN21RUlm3XvL1/TfLf+i3NvouSeJsgWS+FUzVARYFQThkWyTfIGdgNsIvqLxrhp3/zSqUZSsYaQZ88prVoh0QBRpgDMIEAxS/+D/XyrSvBMsY3cmsSKFzqVLydIEeCk3mkOJTKo9VSw1ChigdfDZX1Blw7jVtd1iokahqRzDr7oa72kWd421KYQ1TNNRY0zL4jDUswL2dtf/ZiA1NKml0IVEYbV1XdwnJlss1a/j2wlrThVkFPAOJIy1MgI+IC32gOAeiP+dFXTYeS9DdRxjjJtsq1FfSJhkFwi/NHAJabKThWmLPMDrcteoQsTvpBytgJYwwUCSzewZ3Z/SCLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnDLlyve42VPwqNSoylsCt4eAHbMUffU434qD/ag61c=;
 b=utOiVt5wD6bVCkg6DAMT+5M8cRY9NLbR9NOzWYGSa5kscc9UnCOjnHsKQb0y6fry3BjEGb0ZRS1ILwcwX5/LUvz/dE79iLRjaDIvlB1/WwXx0FAvCcPJyPewJYn25AT1C6IZjQ0X+kT0hL8oz0dzqwV/1RcnpI0S5KWGf5RkmRXx3IKBFTa3kHaTrb4KGYWLS+r2bOB+bxui7UA3fq+fEu6LnPDtbhK3fsJO8x+jwk+/SF/WJEIRoUDxdD3c0iP8Lo5nzpN27/0QlEFqR3X+d7r+b3Y93t9fOoXUxR0AzD3sifeozQeqLUCwaJCMrItv/ej9W5tO7r9ELBl8w7gYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=kernel.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnDLlyve42VPwqNSoylsCt4eAHbMUffU434qD/ag61c=;
 b=PRVOoAkRCfVFdMTSzN8fY1rUCDISQ5priFkQUF5POgDDId7YCqV9OGSpfj/+nw6xgm9Jy5LzVW2K0bkDq8tMB+1NYN6xFahxOtbQuwHzLcfD+/G/UvNDOyJER+s4uqENNDv/uXC5qXGXnR+28Z0uluFGQtnMt4XSnfII/w1Cjig=
Received: from SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28) by
 KL1PR02MB7691.apcprd02.prod.outlook.com (2603:1096:820:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 06:40:28 +0000
Received: from HK2PEPF00006FAE.apcprd02.prod.outlook.com
 (2603:1096:4:b6:cafe::82) by SGAP274CA0016.outlook.office365.com
 (2603:1096:4:b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 06:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FAE.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 06:40:27 +0000
Received: from cndgdcavdu0c-218-29.172.16.40.114 (172.16.40.118) by
 mailappw30.adc.com (172.16.56.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 14:40:27 +0800
From: <liuderong@oppo.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	liuderong <liuderong@oppo.com>
Subject: [PATCH v2 0/2] f2fs: modify the calculation method of mtime
Date: Thu, 12 Sep 2024 14:40:12 +0800
Message-ID: <1726123214-208356-1-git-send-email-liuderong@oppo.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAE:EE_|KL1PR02MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c7cd6c-2072-4821-6502-08dcd2f5c9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BjClQDqCRr+hy8sjTdeFR6x3lAKNOKZDo3/Q0XVj29ScjuPU/EWUw2G+jz+D?=
 =?us-ascii?Q?LTpapMcdAv0/foFASzyyystuHqjlNx4U6g56DwzoA+N13UiJNvqk2t4uhk1g?=
 =?us-ascii?Q?1aglftjvWfTyCoC1TFheFsDEqnNJTnDW8bptWr/Xv1vuMjGW1zjxMRiZnxYf?=
 =?us-ascii?Q?uyqjURVd+YB+oFzbksN3FB8a6e+X3Vj/xUT60Lx0GxQYWmj05ycsiOHLOuZg?=
 =?us-ascii?Q?SNJHywd91IeoT153T0utTEPayeghm12TFsKGaQ9I/505i2xXdEgAxzzyD4Tw?=
 =?us-ascii?Q?PEeWcnuudoWgW7BhkQkmsOKjxNzk4vhWbFgx9q384asxgHcCU2UG4pC3Nphc?=
 =?us-ascii?Q?BmOldy/nkB21YHe4IpfJV4z1QosKa5TZhDpgV8bWwG8HiWnsRlSwvJ09SOJu?=
 =?us-ascii?Q?Cb9f2FiGk9i9DDHElO8ttGCZnDgwrsQk/wS1wMtzmh7ODSJDbsXQ1fFZrFdm?=
 =?us-ascii?Q?CLmyqBM9GLRe2xKVnb6d+5UekdVV3vq+ovPucnPNPU/Hm0T6W8lThJcTnZnD?=
 =?us-ascii?Q?lh5yqKx9zzA7S6ZzKSK+QZwZJbrE30+p1MyucivGBO8TPyAfHxeFWGiLGD8w?=
 =?us-ascii?Q?0hDGfyKf8goTHJini1wqjzK/LfzB4CRk+KM6XSJguxFDGpQHTkHD/qKmwho1?=
 =?us-ascii?Q?TTUIe4Z5XXBGsAD+0yujdj0vIriqLKAYyNXUZfJYYVpnkEIAJJlByVTjavoe?=
 =?us-ascii?Q?+lv4pZclMmYX7Snbvibr9hunL8NC2+tWbeTooPBlGaja+NiGUr0IyKguDH4U?=
 =?us-ascii?Q?uMBemM3F4fARB/14qTw2WQxBLXhRMuWhkguNaLDbFWcT8jI2Wuq03Isu1RFi?=
 =?us-ascii?Q?7l3jTuuOD5T8r6hut3VR8HIgNJ4Xm6L+AoOPupKH5Bvk1f9mtudkK/xUZuLP?=
 =?us-ascii?Q?110ry+pw+/E25CH8n6kXJTsAyAhTfPLERt996GRCZ7HkCnOrJ4uWKUCA1EM/?=
 =?us-ascii?Q?SVMZmDDi1nzEpsb77u4UkVZhYbkl8pXng41EWb+bM/1v9sTYoXS8WAV9jSFm?=
 =?us-ascii?Q?z0FAlpdifjM+pO2lTBjppWlrEhq6/6c3+zZjs2lRz6xI9xX/oM7iIJNpLHId?=
 =?us-ascii?Q?qrx/rlZMkf/JWYhhgEx62xtiHvFshC9L3fam9Dg3lJuuGLBLj3mLPmfkX7UH?=
 =?us-ascii?Q?bW10Yfh8o2xZL9qyXflHC54VzyY/D7j/26NxEkS69KglYwilST8XZau7uJXP?=
 =?us-ascii?Q?nhVW2cj3GKlz+/zc3IeevrBhL6gYj0fnHaxOqI0pX1zkkvJsLoxGwKxgj1jf?=
 =?us-ascii?Q?AnW5G7DvZ4EwUOoJ8jXKmVNTrGszSMr936mP2+7TURO96y639RfUXWJbbRNR?=
 =?us-ascii?Q?90fvG4vcmhmKJJqeu5DdpuGMeSjCuD4Y3ob5baZpjsFeTcIy1oIj4ec+6GQz?=
 =?us-ascii?Q?EHu8SXz/i9I7DwDeAXWR7Gdz7BDghNhgmGHhFghKTi7RJj6jl274lMOtdKKZ?=
 =?us-ascii?Q?u4Q7c+gYaj9CFLNFKzZTBDTXBVhaGvZm?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 06:40:27.5696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c7cd6c-2072-4821-6502-08dcd2f5c9fd
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FAE.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7691

From: liuderong <liuderong@oppo.com>

In cost-benefit GC algorithm, mtime will affect
the selection of victim segment.For a large section,
mtime should be the mean value of valid segments,
in order to select correct victim segment,
it needs to modify the calculation method of mtime.

v2:
- modify new API:get_section_mtime

liuderong (2):
  f2fs: remove unused parameters
  f2fs: introduce get_section_mtime

 fs/f2fs/f2fs.h    |  5 +++--
 fs/f2fs/gc.c      | 21 +++++----------------
 fs/f2fs/segment.c | 44 +++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/segment.h |  4 ++--
 4 files changed, 47 insertions(+), 27 deletions(-)

-- 
2.7.4


