Return-Path: <linux-kernel+bounces-313237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A698596A232
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82EFB2919E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DEC18BC06;
	Tue,  3 Sep 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SaU9sjrp"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2059.outbound.protection.outlook.com [40.92.18.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164D18757C;
	Tue,  3 Sep 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376801; cv=fail; b=sJCzcrv5l+IPK1hb9MDaGoYNCIG21iJxXh6RioMqyHR5X/Q1yKAarwlAmWO6qyIz3fT63s+xobjAnPUgXx2XZeSPoJoCrAmIXwI8uZGB99MgBVB2hNvNabri4QgAQUX/qROI/UcRmhhxZOavoNrb1/qZ+FOnHzYJd9eZxVZ2EZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376801; c=relaxed/simple;
	bh=o7oVyoWdexFWTTYlKPVhbu5Ugjjqs/qAmPcpGac0u9k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UICqoZR4zHNdr14kJEkjguWw5EKf1ahw2qpSQTddLON8UukMA/+7EAMbdC12vRczGplB6uRymkfllHcnMynd8uCwrDh0CAFAWxQeU2/trFECmweTljXTN26fXgpTCUVKS8PTLpw2wlwGuSJClEGmKMxOmQAS/PayJKIwdva9mPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SaU9sjrp; arc=fail smtp.client-ip=40.92.18.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHlzSSjZpm/FBUynNM4a+Ivu5UoBkms1tQpGPAUBIkkIoSi0cA8w09xxB5wyA+3Z7tvh7auEzBIoeeemG780sg59d4tYoDsbCjAIJQOPKjgPq837m3TKfFN+4T6p6SgxMHo5SAMZRxMS1pz3FGcxWr7PV005U5Jl/5jD5VNm90N8fyCGGOGl450vI1BH2s7WuKOMSbjILM7lDWJTwgemaXQVICKpExWOkSOnG6uW1PMWkQyWIpWjjQGWzpYSQeIgTjTZ6rpcw/TcqmOtCIDbhJ8zN4Q+GsBMkd96ydcZLVlxLvfcYD2KxsiijXqn7rn/Pt2mwtUVd5njqDsaI87OHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdPvQpD5yfUHbGBfLNeGC8wiSNe1cju9PBajbobsikU=;
 b=GK04aFEJPa8rhHjJ7/ogIwtslJnffQBZkZNar4T5vVEcmh7PTLuSL+ExIBZ7HTFSx3RRvDwO7hTL/tpZLVwX1vf0fMgyQ4ZXffW4kCWwJPhrqcyWDPHJEXT+kIgZYbqbG2eCuocQbunFjx9XDHTMNWlqHTpJBRlbDEgIuibDlCLn1dRx04brigm8M0fxQ7u3yQ3+9UouegO57ZGwZSMCl/P8QRjErepXVNuVFmey2PIFF3beqE6WMBGaJxNIRc6JAxZpkb5SSV5rt3l5DcAnlgF7ioO15agRuMSMVB/P9yGN6lj/fGcTOXKACHwqb8+JsLXL/2RwwsVnC6RNILeaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdPvQpD5yfUHbGBfLNeGC8wiSNe1cju9PBajbobsikU=;
 b=SaU9sjrpLSuBAax5i1J2SlXyeUHTyjo3j45ZXH60LvMQ58nf2Kaj5rhpwarP7hZWHcxJ8iuA+7BFjTrLy6Du3Eg3e8ShQ/E+S1yCPll7F3u8XwoeIXDGZgvOnQ0d7ka3kt0m8Ej6ZN6vfeJI7cWN5t7ZTijgEP8ZY4X8Ac/GEmAcuh7gP31QejGKMKfRgjQ3jft/ehv0UJ8HLnARZmEP6Gfv/V0hytR+tr4rVWWlQMdXF44jGw88AuaMlCUqAx6A9uNtwbx4RSKKYEUwkFGNq0e0LJBJAdDsRKLKYZFzH4KAlGmumVhvP1dVqr78n+acZM63MNLKF+1S22qRYxx+gg==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by MW4P223MB0633.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 15:19:57 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%2]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 15:19:57 +0000
From: Steven Davis <goldside000@outlook.com>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH] Documentation: maintainer: Improve grammar in mailing list participation section
Date: Tue,  3 Sep 2024 11:19:25 -0400
Message-ID:
 <SJ2P223MB1026BD1839CFD474395FACDEF7932@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8/W1uacSFlEl72h71bwugoeL3SWYy3wN]
X-ClientProxiedBy: CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::15) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240903151925.17307-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|MW4P223MB0633:EE_
X-MS-Office365-Filtering-Correlation-Id: 96df7a78-c7c5-4e8a-bac5-08dccc2bdeb3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|15080799006|5072599009|1602099012|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	cyHif1cae3p5OmBmjcntmByh2qeRaHlBi2d58LEs/S+gE2609PoUoarASOUgtPPSRxbNwfzDO5A8JR4DsFcz5aYDaWn4FJitV9hn2dur5fd1m/bKR4DUccaWpbbfySo/F6ppIS9hzo1Qcsey/f4lXZL2hj6pPGNktTNE+3sB/1MIP65N4pMN7/YzBHudHpeoHX6i63YGML8NAil/TRbvaYve+xyj1Y4I+UlhIyg/0opiUGq+EUjM5jLvfCwJjja89QIjhnU1v8wiP+S+3bDCB67czy2PHnqnLa/YQN2wFQ/KcZdAI+O3rg5HrO2KWXE4DJ/D/Exg61+5MHXT6YjYELWcuEodbK6WR4dAbQuAbeP3fvBOsK4bveavQqaNObbakNIPsxgeP+UNHcgqLLNvQNrhIPrGOE0t8dE8j83MuDWacDalKySMQFLDdCXLhNjc8t/Ix4CQ0biRTwFtJ5Am4ufRFunjqmycBbQx2fnCedgo4nIUa/qTn5yo5WtBLQra1JTki64wtLJ6m2uiRSxWwkKSZ1TgMw+Bp20wibt4/aTAtoP1PI/GVsgncf/MY7SO3fF59hIeYdNLxvsIsMGhzF+ETXUe/ejBiANncUL9GR8mpCN+TAmpegYFqv8qM/tG1JZjdrcnkhjmtsJfNP6/fWmJ3IZ3HMBvd7jTjfXPFxE0jbeiFLjFC7qD3LMb8OdN2xsrW62XZBhq9HRzPEE2r0GM6EkWrJ8er5uZHPd+rv5mN8OQhvocnTuyMqgs8qtTEh0cDNjYyxFCsl73YCemE/SqamqrxeH6eDWzFCKkNj9zIfdgnPNOlJ7hyOdeDGaC0aRPPlR5QDjqmDGwJdtQhjzNEik9VSZOeT+YZP2Ymh0OTmre/3xvm0ZhS4MlR97lvNtlZPdi/nZRMax5Zk+Q1w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5azED9V5vSl/ikmsZ3DUtWz8F5iGRSe6JBF2A95afUQn3eImyByp9dJUN1SS?=
 =?us-ascii?Q?WwcAcC9W3OTexnW8r7Hcxb47Q3Kgk1HYql+0WTNmI/+NmezeDITPkQPR5ZH5?=
 =?us-ascii?Q?eOkmChPsGdsDDivjYSr3i1a+4UD5ts/4F1wkH+ANM6z4SY2EMSamwSG5e5m4?=
 =?us-ascii?Q?2gXyt7AgHZD7lZ5qbdXU3qOeBxrFuQCZANR7zhOKNSLTHtZ3qFsp1IKvZ6hC?=
 =?us-ascii?Q?5t7nf3M5hcwsB2zDfchIUmlAyuE5U/pcEbBNp5eS0xMMtAlJy+5dk84QahMT?=
 =?us-ascii?Q?5gLmDpPv4n8FH77PnvdMGq1cqxle/x0Rnt+nv+60eNOiE226iMlMlNpJDG3u?=
 =?us-ascii?Q?owXjBYsoz9DefNsSCM3VgbG9UGfbbhK6JQWtytbSbcEljU1IZ8U6XXz8iuw9?=
 =?us-ascii?Q?46eiozQVRP83R2NQHLl9u1FPAo7Y/A7FngVrHowCfdAQk0D0b8j5G8gZ61fp?=
 =?us-ascii?Q?iHJevYqk9ATuXARN/KBGYRxFmjFwxa4W5V34r6q24KXvitxleF5kjU3NaMf3?=
 =?us-ascii?Q?Yp9dzE4GbMtjH6EPJ4CN+lDD7zR1TeQiUTn2NXk2wuDJ8CyDqTPubZQbqaLz?=
 =?us-ascii?Q?sQmXo7wLbV+v7j3oseNxjaKpwMtkXCyT2SBojAIGntEjshmNB2y5ZD0LFiZ7?=
 =?us-ascii?Q?GKfIavt7BxiDT7c83MGkQ9r6My5xgX81IJEpUhYlro4H6TOQREB2BbVIbR7S?=
 =?us-ascii?Q?XBOqLiyWV4NVygdhZmIZDMIvQl3vtv1p+4hNWdbtW5IYv5u31+fAfYOc5JKh?=
 =?us-ascii?Q?HPh06lsA0WJUrrzJRIiF2us55EH7moTI4YZ+rNeu4hv7G5wGUm8rjpikbfP9?=
 =?us-ascii?Q?CCysf65RntKIciMbh+0iIor3O+obpyKyBZW5fcS5lsRxSeH52m6TARc3/Plv?=
 =?us-ascii?Q?LWZNbcpCFRtlnkCGwN9bRu8uMwHk7FcmyFwJyv84gTM9Qg8ZBsQlsVsofQ4z?=
 =?us-ascii?Q?NvVB9XakmLMWB9yNVOQ3+jarb5f0iuCzphdjQyLgIQo1STwiSC9xZd4HZ1A3?=
 =?us-ascii?Q?pDV6lku9MkmN0elGP2Mksc5zogBiebT7nTKnZKCqC1fZYpCFXHmbX9R47g5T?=
 =?us-ascii?Q?npBsxBNZxyZxvT8S/86/w08NV078BZlrszmmDq1h8E+7vqk4Z6UmQRDycivd?=
 =?us-ascii?Q?vGhNhfv9UCsKHRW4KGM1acDDYzC6s+dujIl3wnHuN/m+xS9IDbT3WOK5uRaT?=
 =?us-ascii?Q?VnhtXb3N3bxEoSuqUxqMh3KgiRJ97VRP6nySM19dV3jq2klaCTnJsy3nzICU?=
 =?us-ascii?Q?wAjOxoCyyPLT4zQxVVX8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96df7a78-c7c5-4e8a-bac5-08dccc2bdeb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 15:19:57.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4P223MB0633

In the section "Mailing list participation", the first few
lines had grammatical errors and overall was not clear. I
fixed this by adding "The" before "Linux kernel" and
specifying that the mailing list is for developers.

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
 .../maintainer/feature-and-driver-maintainers.rst         | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/maintainer/feature-and-driver-maintainers.rst b/Documentation/maintainer/feature-and-driver-maintainers.rst
index fb94a9b29061..b56b6ad5ba4e 100644
--- a/Documentation/maintainer/feature-and-driver-maintainers.rst
+++ b/Documentation/maintainer/feature-and-driver-maintainers.rst
@@ -39,10 +39,10 @@ to as long as a few weeks in slower moving parts of the kernel.
 Mailing list participation
 --------------------------
 
-Linux kernel uses mailing lists as the primary form of communication.
-Maintainers must be subscribed and follow the appropriate subsystem-wide
-mailing list. Either by subscribing to the whole list or using more
-modern, selective setup like
+The Linux kernel uses mailing lists as the primary form of communication
+between developers. Maintainers must be subscribed and follow the
+appropriate subsystem-wide mailing list. Either by subscribing to the
+whole list or using more modern, selective setup like
 `lei <https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started>`_.
 
 Maintainers must know how to communicate on the list (plain text, no invasive
-- 
2.39.2


