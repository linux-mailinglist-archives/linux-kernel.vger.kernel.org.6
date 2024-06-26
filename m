Return-Path: <linux-kernel+bounces-230604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40B917F18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9CF1C213BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21BD17E90E;
	Wed, 26 Jun 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FvCplf7A"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2153.outbound.protection.outlook.com [40.92.62.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BC17E45E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399753; cv=fail; b=VZBB6uzoON/dDkUioBn17SApFuTWGaNVciK4qxa1pJiVPLdSke/kyGw+PukoCIyqDfQQtSrJUg/9ENbKtxrw+Nui70lU+G9S69V2c6Iv04GaZqGqVCYUm5j6qDLtVE5bDRXpbVoqFlLF+IbRqE7Y8eYGFltSbua65yjgYJ11exw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399753; c=relaxed/simple;
	bh=N0FjUtSYsqMYnXnNsmZcWSM0H2CKVCCLtvCAUxIln4M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CQJhszjfm66rY6ufeiBGYDBiE3CqrBkC0vVTOIzg678EzoTaeUNwZ5lt6RNFNkDJzDCccmY1SwbkMCGg6bDQkmiFpaX/VUoaIukmvXiI1x3jjFxfPSeNVT5LnI6Mwk1yi4a17x4bouGN0VMn1wfgWuAtjWdn3r0sQiGLhjVGOig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FvCplf7A; arc=fail smtp.client-ip=40.92.62.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ4c9c2SRMek6D5f5QNow/qdYDPvyzeBuf7Ii2rs160cJ/XL0ZCFUUd4//iScQ0h5XHrllfUBPFZcYSzdQjjJ3CfnPJ/ehiyUHpZLZKkq3SNduC3udWD0NMpnL1PIf9KxM9ITU2iVGRt3UPmAzadw7CBk0eYAVJmPioyU5CQA48NK1X8bT0bnBoqgvD9c/AhL7h2Jzkj7WOzOfaoqkRkkW2001PrMYVsJozzFrgM42wNzC4WXT+kyx4wfSKyqzossEQfIj6sedMhuTUdkgNHcvqQ/PZUT/KSm2Wf1XemCTG+6h/V2s5hUhLUmGrUujFrYOwhTHQi/RZDMBvghFIIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eubp37KkZ/RAdu+V0tZbFGPTFeI5eY8DvCCo8q93/vo=;
 b=S8N5Fx82e/WYyB3WCOLt9t08rdgD2kN1020yRGW0ryrwbJcs313w/OByMRfEVpYholWelhVpk8u2kr7iMqdFOBgz/RsGKTJu1rXOiqHoIO/8XKKUa8zKEyglq8zJTlS1NW+NehIEeg5/5UtjNPfHe1DWGxdWkMuaECx9TvLxyq4TPrZghzcx0UVX0ogCv1ad4HG1nPMgx7tJp/Q3RJ7TEzFu/JSp6OJCzszZjT0+fXy4BvvxQ/wLJeSE7G4ObEBXDszg4IXlPhUkJEBjKzKUreDgx+6wBJFltWUsRp9jBZ85AnI9zX6CMJKcetZiU+6g8I6uecJTpRTtzZA8yi2/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eubp37KkZ/RAdu+V0tZbFGPTFeI5eY8DvCCo8q93/vo=;
 b=FvCplf7A66IXPQAcqe6if42hR04EBGKT1xzAiCD2U0vozLdgAVAsm1fB1gDriLPOGmLRIe9GnGlX4kJ3DJyPbwNLkNFGCVsp7bDeYJfxq/ewsXoBvh7rZEAdP02b2LkS4hBVxAoq+01J0f9d+rLSRJ8u2LN56ZeYVZhAInS0f2uWSGTC4IyTydg0fNDzVpEs7uoZ4hMi6tUPI21KPU2gRxRr5T1eptMlhAsctKmwAQcLYLnupLPn3q/N/kjRQf0VRozYavNpN+cDnHz5Pn4axnDPnh0fWn6+OzUxXNPeIuwDNvszIAJeISRyLWafdVPicCNAGl3rBKr+YO4jaIoTrw==
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
 by MEYP282MB3532.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:17c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 11:02:27 +0000
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e]) by ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:02:27 +0000
From: Roland Xu <mu001999@outlook.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Roland Xu <mu001999@outlook.com>
Subject: [PATCH] Avoid schedule while atomic if meeting the early deadlock.
Date: Wed, 26 Jun 2024 19:01:53 +0800
Message-ID:
 <ME0P282MB48902DA6F350513DBD1BE902CCD62@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wYlN+SQIKq1oBIZtLqREK5bvMV11gNRYGMkdg6O7J6I=]
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
X-Microsoft-Original-Message-ID:
 <20240626110153.1201153-1-mu001999@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P282MB4890:EE_|MEYP282MB3532:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c3ed81-d65f-4747-7a0f-08dc95cf7721
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199026|3412199023|440099026|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	4WZWuYXlicbkNHm2X9I9HL2auiXeFo7fgtnWSCO0m9e8j+V+dTVn1sE7iZSlw6y3aSK7W5oqTZR3wDcJ89dpDKDRL+tdgekUmp69lK3AZrXu15L+laDoEEYvWPwo2Rcp+qy5jEFkM3O7pJRMSepzFTuLEoy4H6jP0sjqXo+Z0fcqVI4bm+iGLlxVbbuDfvIjJltN8EduArjZpK0XBYJNbh5i9T8Jm5wNCP1cv++z78EcyKv6dNriL3ckIOXNxgxSSbfLYagfrIFMmDUiwqVRsvT/USWhl7aDAUc9ivGYZwzB10KwoQcIRHY+ZWo3dmOmhQTIqiz4dVaR9EuhaXzmMIydrPg3CeMU7uvU1A8PpTvlLC0B5hQTAowo0FytfTe+W216Z213YOc48OuqevVEkT/JUxKcNQwg0L1Cgx+Uy554fsHttzw5rQM0Xhld9ubrovcv/+Njyk3xl+b/nDImt8BRN8rmh2JwmSftip6JqhffRoj5dDfQUJ+v7Rv2QX1DxBxFOcAIfoeaw2CaylWkPi9+AgPgFpIa6nVrBImN/+MVeJgE+zTtSF+19ehaUdtAAdrf6wx5QBHAPrw3sSJLMef1FWysqmjQn3VRMYTxRjw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XhYAAQDJwx/x1YWWEGuPouNNueSG3P+bHK/ncsP/5MBcCRYfKpygF0uHuby/?=
 =?us-ascii?Q?Ey2d1Wl0XCoyFuSjbInQhMvSuq5Y9ZTnxEJt4N+kmZ+OqYZGRPSf6sEA2Vvt?=
 =?us-ascii?Q?AY0HpMC/VIyhf8HNlZXeizKpQGVMEh1iLuvrU653AmBNW12TLv/IIWEuUSKj?=
 =?us-ascii?Q?IpPCYbrkm5pjaz666G7xSSSK2GizFDhYZGDDvatRi8N/kEKuhyM5xBsNXuMA?=
 =?us-ascii?Q?IGxIl9kpsQJtjLD6RRuOYpz71sx20fJ+QfHrnHzjxqi6hQEta/se3YrR5wFn?=
 =?us-ascii?Q?shYguZGnDZb3JHYgIlcYOgu9QJCy/w3T2SUUgwosYH6LpNnLpTmz2125LaHK?=
 =?us-ascii?Q?9UE2mbP0nNNgw1xPfE68ezkY6sYrsHdDJ0ZRxDHD93Tiyfr7owAjrjOUVZYM?=
 =?us-ascii?Q?gVoYBs+hNq1+eYKkzu+EEQHXTKYbYNGWxHwByFbyAGaD2NQbN36T3Y20InaF?=
 =?us-ascii?Q?uAXjc218Px004n0LY7IYnYpcvFNp9cEeW5A1wnWWLeZHNmvD/CxnhmbvG5Y3?=
 =?us-ascii?Q?GtayM/hJicMKaJLIP7a+adUPR+ITe6OEEiNjPjD2T2RJZOaWgorZxT87rf2Y?=
 =?us-ascii?Q?eopmp3vQ8tqA6QaRnLVHVLBIkSraIEXp6UkgVtYDQkGaihgj7ApG1zQHxICr?=
 =?us-ascii?Q?sdihg7yqsrT9arBC3AWN8NacdGPzUQ1+beWAcAtjzqSgfB3qnTq7R0ox10FT?=
 =?us-ascii?Q?VlPwIM3n0VaQiGLPNkAiDnYqkOA31z4kpaHNVNpsxY5j5tR4/vkL10a7jWE6?=
 =?us-ascii?Q?yf2Fo0ojVG9/sXHXkiQTuiezf49ZhUWC8lYnK7gUQOZT3r8h58kz9k7RTMbD?=
 =?us-ascii?Q?IbbabYYEErJAL6Kxvnkyqtd7zFzsCPfKd0cD/Ckfujw9xb/pGw96rpCvDeQi?=
 =?us-ascii?Q?0o48aJEsY7aYXcHzFT8zjvC5S1XKMboTivCZShkqDU0nLaFLBCcDRviaPMOa?=
 =?us-ascii?Q?T11V6RKDmGLTqGZ9DeqCkbigfrw9ip9HF3GDGMmQ26peu1DbRco4410MuYXV?=
 =?us-ascii?Q?/HiXHaQfJvj6mAXauwXlarGuLeax9emXdxLgLtKcdQ200YTzb450czxn+Hpg?=
 =?us-ascii?Q?nFwcD4pbXyRwNiOAjcSxVlpIEds6OCY4HayBpXRBgcRvFIz/VckSiAVOiLEW?=
 =?us-ascii?Q?ajza53fBelvfsKqE+hDmIF4K+yM9tZZMwshePPhAlrpbaQE+m20bRm1JTebl?=
 =?us-ascii?Q?iqPZ06azHCDXDDiUXgBvKT1FFR/dE10wqm41uxS7UWVponKm93vBfwI/2QE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c3ed81-d65f-4747-7a0f-08dc95cf7721
X-MS-Exchange-CrossTenant-AuthSource: ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:02:27.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB3532

The wait_lock is held in rt_mutex_handle_deadlock,
so unlock_irq it if rtmutex deadlock is detected.
Otherwise, this would trigger scheduling while atomic.

Signed-off-by: Roland Xu <mu001999@outlook.com>
---
 kernel/locking/rtmutex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08eeb8bc0..9188bfb63cb6 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1644,6 +1644,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 }
 
 static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
+					     struct rt_mutex_base *lock,
 					     struct rt_mutex_waiter *w)
 {
 	/*
@@ -1660,6 +1661,7 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	 * Yell loudly and stop the task right here.
 	 */
 	WARN(1, "rtmutex deadlock detected\n");
+	raw_spin_unlock_irq(&lock->wait_lock);
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		rt_mutex_schedule();
@@ -1713,7 +1715,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
 	}
 
 	/*
-- 
2.34.1


