Return-Path: <linux-kernel+bounces-562352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DAFA62489
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E9F19C1A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1041918BC2F;
	Sat, 15 Mar 2025 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PoaPHVLO"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F81F5FD
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005345; cv=fail; b=uQH40AaFJksA4KanGVmL9w/Nit4yjqxKPprfCWLvhlyRey1rL7iVyROIO2HQ2OcJNEpCEVA4sN1M4tlR+ycNBm4GvCxK62VInh03MTcJIMO3hACJHSwxYE3RhATe7+x9cp5D06jKYh2Y6t7/20MU++UNynefzFaIFIV+cTbbtD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005345; c=relaxed/simple;
	bh=hEhcu90qgWVqT/ZFc4OrjtBIH3gojZ3mHIjuVImkeyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8A2arqLVEfXNVKAjVgwP1z3xU0ZXLdQIkw2NUij3EIgm8yvvRlx82Pg12Jpmr7H2UyCX86Z4+k/qxIYNhjt2c9QogCfrFsYSV/NL3K9Ls3RU6vfos9ZTcT/7J8A0sb+tJC99kaAKFopixGeq1diU+pnHRvqRSsiH5OCx9EWWP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PoaPHVLO; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVuiosl0ZNsNo2q+NtfFbFG9BwBwemKrZ702vIsWFJFrBKne+b9oDCIymX+pyvjku+Y/ba2G4nPTMw73Aoc+cMCpoaF4Afw2egfBDERJH0G9Gv65i7lE6Vw7O5m8iUsTyIAqMmIY09vB+r+qnxa1vbiCY2Xr8mFsA6nub67QIbDn3/PpcmgvKkfZdbNoRqBX6Ijv/dfRqOpFBWu8anpASy9Fw4oRLpfx7yzF4DKIru4qE57Apmq6ZOYSlrY4yO2/+IFDlZGSgwRAZjFKiI2QSiGn2hXkcYvUia4grXOI0K1VsmSw24u9g5YbkSW25m/mK63Zlz00We9NEDoISM/7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6YjNt7Wer+tEmh+QeB5+nCohNVxPLmxi0HlqzNpRAg=;
 b=v4IBhhtntUEvcoXFmrjQkzJ4QhCb145kUMMcxdXu2MJpYLnR1ot4a36PdeWz6FOh4gfoWkbxHVoJ9jza0uexvMYigFC1Iggsm+6QeAteGjSAw9WV40bImKzRn1NRXPvdRAhj7oRGYC6lbwNJUdxJceKAaEogVTcr8uHDjhhCCTgNOLVe+HgV+Txj50byE3XDkdZQdzICAlN1PzPpIlNNHfbiYYn3oNovSBf4NAv2PSkeCMCxJ0Mb0zQmFdmBqi20w2RfcPv20KNLLVdgg5NnNU4SbeuRRRb59v5mYiiIO3cMoGDsScxn2ooqRdunDqHfZXnKFR0j6RFTiRYGhfDZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6YjNt7Wer+tEmh+QeB5+nCohNVxPLmxi0HlqzNpRAg=;
 b=PoaPHVLO+YIkKP4JiL+ZTMUPEME/f24Gl7TFzpvT06ZwedTMz3BZJEPS2BsVYdQx63SenRL2+TWtJO/P4X9ECLOsIJxJrlD90sUE1nfMxP6ma2eiwEH/btzGvQLhxqmnvc1D5+ZNo5/18e/J3Jr0+BSGL6U+q7jox4NEAPI9iE5NajYQauRVmeVJZxNX81xOn2Jnt23iI/Vhd3grJAX4iRKeNzfcyZJUD7t/z45BuRE+haIEnBdsyyR9sB0FCZjE9XYSlYnAecq6N0mfz3y+Ufc3he4sBUjTI6LjnkFmRmeuU7LBWUqJRz56I9XvyXbRJPwtV0nLVV9o5ryV8f3LsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 02:22:13 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 02:22:13 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Luigi De Matteis <ldematteis123@gmail.com>,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	David Vernet <void@manifault.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC 2/8] sched: Add a server arg to dl_server_update_idle_time()
Date: Fri, 14 Mar 2025 22:21:49 -0400
Message-ID: <20250315022158.2354454-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315022158.2354454-1-joelagnelf@nvidia.com>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: a47ee941-f99d-40ca-8ae7-08dd63683299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eVwXVvrLebhb/iJnJS0MiuQAdxdQ7gdjU7jT9CFRkf+CGkYJTyb4HluOTuQx?=
 =?us-ascii?Q?UQBvBnF3M58RrBozUJAFlevhbOJPsaaP1wGfQEYXf8MIzBD7/HkoRXIsMyHH?=
 =?us-ascii?Q?5CYXq3fpsPlScUOdsTAuP2eLdx2WjUACkpT1UBjVlo7EmeH/HajmY25godT+?=
 =?us-ascii?Q?91WWizG0jtqrwJtYbfeTYu8NJfvEQlrutBoMrh/cu3+q7aup9KmYHOvviVQp?=
 =?us-ascii?Q?c0r5s9IVH7xZDRb2bQtweymKByWuy5DlRMJGs4zURhvEVULsy2UqJSiECLwH?=
 =?us-ascii?Q?xnYOwC5LzH1LUs+bjTtupFvXkFieHdCgvRzrxC9BDAX1eo+cwkVcMx/mOWG5?=
 =?us-ascii?Q?vJPEv6+5qUsRkOEHkrcD4qbszOSpkrFLqoVPGPvZeYhUPnl3apwLmF+pHzFY?=
 =?us-ascii?Q?MdCxjNdjeKXhQ8WdnX5NUwJKFeVGYhKVUd/GRrXfFVuIM9/Xm4c56Ti6hlaR?=
 =?us-ascii?Q?ztIljOnxL02mXIr7r/p6vPCX3dFmQAMrOza3j9X3bCghkOa/JkI3vULTxnOr?=
 =?us-ascii?Q?TvnjRGSj9H4Dq1SZbfYb8Fuf6/B7J642imnosuUvWC0TaLZpC3QewZ+TEZWI?=
 =?us-ascii?Q?hDkwKK/pRW/A3XX0n+o5Qir9ioqQSOCs0mD2ciaRZXNzlfptGcTZaxkwcGkf?=
 =?us-ascii?Q?4Lm+LBV4MKVlYmxe/crkwVictNHPBvbhn07hbyuITsEA8I3QOdOvpCDhiJSP?=
 =?us-ascii?Q?eok59eID9SiDJ2fDXhN+bFTVzlyv1zgVoeF40RtDT3mgA52Gv+sCCPyUG0Ev?=
 =?us-ascii?Q?mbO6IkCXBTP13cV3pORqd+tMB5xXzOm/BnmDsx719q3qfrhjSoPVkSD4Swgn?=
 =?us-ascii?Q?pH/xGuvRjAZMbKIFvxT55cdS2Q+c6tFfbgrn0+k/vCYurtwhLKcJi8L6rV9m?=
 =?us-ascii?Q?fmq84BMhxq6tOOCk0hPUdCr4BxrqjtWnk6/c7a5YFcQwhZQBTsg5k6Wd6Kz9?=
 =?us-ascii?Q?767ES7lK298uObJkEXoNuTHktOry7TNNIeBkPTH9rJmtGX4C6PsGotOopy4B?=
 =?us-ascii?Q?CsKCCLC7mNWcAU/FS06Jd1dRCqfkjMYIfShZczBCl8HiuW8lH2RjSFr9fks/?=
 =?us-ascii?Q?DdZOiNvBNkqnlupote/gP7OwtSAkOoOE+Hy7WyNQq82agrmJWmuUZzV6mJx8?=
 =?us-ascii?Q?nH4kaE5NWYQWcbP0/2qCMHVVxGkCJIp+mySqh76FgIG0kFewNUMSFbifWZAV?=
 =?us-ascii?Q?3TbvIlVDBsuiLlJ1mcirDRsRKxGUtGahziMsrWi2UZAAj8EIPMxlBvFtvyyc?=
 =?us-ascii?Q?+80dpkcmhAbRWEECo+IeNmpBRPKLiWuSeXoj2OM/SrTBugkQQtWOsjqUvP/Y?=
 =?us-ascii?Q?Omsb3cRL3gGSD9OCuJSI+HQY8A8T+N0PJppfZQBurwHOZAyc/5QUZ8VrVRxi?=
 =?us-ascii?Q?PPV3jh5chozU1hrTzsn4pm3lt3w2aeiazAEJyrrGX0pgFWJiouCflilo/5vp?=
 =?us-ascii?Q?K60+9D7EjhI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HEYn+Tg7pPGnsCCOTlJCTsL1r90PQ5Vuty/wu0wlnfm18hgZQxRSrgovAnHL?=
 =?us-ascii?Q?QQjUMsu+t0xlaZOlIraqbQjOvIk0K/te9wnoGpMt1cGwnpTkO+eiiyWe4jmR?=
 =?us-ascii?Q?ieHGSKZRAB6LRe7IUtzD7I6P6gS6EKUVRc57FiwPTM9+OCBBOPjLzY7ZOPxa?=
 =?us-ascii?Q?+9I8xrac2VdR1mBXIr/nWLI/w0/QCHx6WF/1Ftg6OJDpBfk+82jSBrbDMFFN?=
 =?us-ascii?Q?OEUIa+vxzj6pqdgKWeeHH2z7oWaPahdMuHcDdTLpvO7A+c5UruRj1x5KMMDO?=
 =?us-ascii?Q?MAqS2sJAkYmIjFyKhDUK6SKQtethSbvxKBVCkbH5xNbPaAMLzGlmpXgHAZC5?=
 =?us-ascii?Q?LcNfeg34z3185LEJwZLX+gRnA1tx3rlYPbva1XH9XOe3a/tVAVhxHaf7zaJb?=
 =?us-ascii?Q?IWzLt1wZH6JXbtWIGElnv84aLzyHs2NIt4PkjsqMmZCR/gRMSc/yOLlBPLGp?=
 =?us-ascii?Q?MXn9su+9ZJCx/u2jZj0c/3LB4LuI2Z7AUjT2NsX8zJipllyriCv+oTHISnx0?=
 =?us-ascii?Q?SpDEirX7+ubmI08bY1zyZr0aeCXCdHTcjcui2ssLeMpaWmEU2XI1O5WU/1Xb?=
 =?us-ascii?Q?cBFvJPZsfVLv51iGOxcsY9TZOYprl2dd07CKs4j8O8GI7yQ89vZWjG1mMGXg?=
 =?us-ascii?Q?Jj2fzwlUVHguue3Ne5EgDYj/s1lowhA7Kb3uJ0EwpA5MuLi4OY8WDJOZCEDV?=
 =?us-ascii?Q?8zbto3P9RlzAhYTjwDjy/a5XQ/CHWeMkXDlZQVgXxS0JFvHpHThUdYQB9jOQ?=
 =?us-ascii?Q?4BRFS+zEuxuCiI3e6oBBndSKag/MJQFpINNTSzdzUqGOmENUR4/duEpTtjcm?=
 =?us-ascii?Q?h0QInBq9z4TK3GoSmcEW/TkVaCHuE2M/9Qi9OQHA/yQyfYJledSFJaR1SeyT?=
 =?us-ascii?Q?C4GEAfKrnfC9DPCJgAVgaKd8qEMsPZwuYOhlIC/Ro28GYf+iJMl9W5Xh3bEM?=
 =?us-ascii?Q?h59dQNb9RfmrntVU7au74F2Dxpwn0lvVWwjsqIsCwuYr4ID5n4GzoBZOxXG2?=
 =?us-ascii?Q?nrbNmMQW8wD+jmG0BIsD2mlC1cyC72Ww9KAWgjE+SLxUOQxpKNEgElAzD2cq?=
 =?us-ascii?Q?shQSh+YlYkB7w/yYDGLwFQ3GC3eQtazsyn+p9INw3jL3kXZGgIgWoLCqeFwr?=
 =?us-ascii?Q?BRpM6FXj0OxVUyd94Tt5b1EY5KyZSDGSprvM/NcygHA4fxD18fxXA/1ViZMX?=
 =?us-ascii?Q?4DP0b1726ZdgC2Ha5SpF0F+iTas3GQi01Rb614hrY1K2MLktw979knI+HrPe?=
 =?us-ascii?Q?/cqCvZgKQqQGUva5ESUgFlTHfcE78f572uSCriwB5bKqtpcnW5OX/npxDMxC?=
 =?us-ascii?Q?gDvXsHZ2WNkTqYkvFMpUaPzK9mIABs5YGo2ICELZjCLBAwf9T74CvmFJ6l76?=
 =?us-ascii?Q?CvG6hD8xGhFFZJq+C1sArlAwiJq6WjZhcv4VBUaAqKpe2vdUbLTJPnE2xdf/?=
 =?us-ascii?Q?PKoPIXz31PnLTxT0PMYFYBvc6ZciXbCcr6Pra82XCnHn1UAccz6lX1P6O1nV?=
 =?us-ascii?Q?SBmtg6jwoVNlZYOwSjHhkdQ1ww2wq2bNGVXG/dJD/hTQUbn4oZZ1VJTUXnfl?=
 =?us-ascii?Q?mEW7XQBRQJzOHHym4vsuLY9HYcqhr5f9Y6x4SuHD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47ee941-f99d-40ca-8ae7-08dd63683299
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:22:13.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UmndtZx5HuXVwAI6foM1QxjZG1T3Gr/JICWzKn5oerWHUwu/fohy+aey+mfny6Q1jR1cfltCH4bhTdfVXbKVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

Since we are adding more servers, make dl_server_update_idle_time()
accept a server argument than a specific server.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 17 +++++++++--------
 kernel/sched/fair.c     |  2 +-
 kernel/sched/idle.c     |  2 +-
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3f7fb7251805..ef592751417f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1610,28 +1610,29 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * as time available for the fair server, avoiding a penalty for the
  * rt scheduler that did not consumed that time.
  */
-void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+void dl_server_update_idle_time(struct rq *rq, struct task_struct *p,
+			       struct sched_dl_entity *rq_dl_server)
 {
 	s64 delta_exec, scaled_delta_exec;
 
-	if (!rq->fair_server.dl_defer)
+	if (!rq_dl_server->dl_defer)
 		return;
 
 	/* no need to discount more */
-	if (rq->fair_server.runtime < 0)
+	if (rq_dl_server->runtime < 0)
 		return;
 
 	delta_exec = rq_clock_task(rq) - p->se.exec_start;
 	if (delta_exec < 0)
 		return;
 
-	scaled_delta_exec = dl_scaled_delta_exec(rq, &rq->fair_server, delta_exec);
+	scaled_delta_exec = dl_scaled_delta_exec(rq, rq_dl_server, delta_exec);
 
-	rq->fair_server.runtime -= scaled_delta_exec;
+	rq_dl_server->runtime -= scaled_delta_exec;
 
-	if (rq->fair_server.runtime < 0) {
-		rq->fair_server.dl_defer_running = 0;
-		rq->fair_server.runtime = 0;
+	if (rq_dl_server->runtime < 0) {
+		rq_dl_server->dl_defer_running = 0;
+		rq_dl_server->runtime = 0;
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 734c22fb0e2d..f6511eaf0389 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7006,7 +7006,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
+			dl_server_update_idle_time(rq, rq->curr, &rq->fair_server);
 		dl_server_start(&rq->fair_server);
 	}
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 01e9612deefe..13a3d20d35e2 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -451,7 +451,7 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	dl_server_update_idle_time(rq, prev);
+	dl_server_update_idle_time(rq, prev, &rq->fair_server);
 	scx_update_idle(rq, false, true);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ef6fbc49449f..b3d1201b8f3d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -392,7 +392,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_pick_f pick_task);
 
 extern void dl_server_update_idle_time(struct rq *rq,
-		    struct task_struct *p);
+		    struct task_struct *p,
+		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
-- 
2.43.0


