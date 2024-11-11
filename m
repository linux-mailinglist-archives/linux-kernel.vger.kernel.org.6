Return-Path: <linux-kernel+bounces-403700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F40BB9C3937
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF741F21F51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89981166F16;
	Mon, 11 Nov 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ok6lqwKd"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020100.outbound.protection.outlook.com [52.101.85.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5AD158A19
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311369; cv=fail; b=kIskGrXymRZp555XJkzIXvDPjW4UfNqHe2XMikw4WccD+rIXx+2xYFxsURj4DtfUcRvs0meEjFTfVdAjiS/mnJtzi5gI2se2r4P2mROt4qR665FSd0pMvC/I8l6JLOihhU187E9IJdihrUW5ald7qpH9IPUx7pkcDLsQJnNeKW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311369; c=relaxed/simple;
	bh=nSevdHl8V7AP2A8EN4PpQHI6P+1U7AwVOV6SSQleQjo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uyPVwwDQfu9Quwih61I3LPdjvb7oIX/V5FfYOB7qEHN+8ZtMbrSuLFyZpKH3LDeQe+FP5asV/KMmjNAF0K9Iv7TZxEwvHjtuxopsBe44sjKEAioaCCfHTUCFT47TwsP6tPnhC8vs6cPGTJTtbRnGdhDPDbDDi+b+CXSihO8pLoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ok6lqwKd; arc=fail smtp.client-ip=52.101.85.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7WkR5nf2kiLvqzjv3GRqPtO7AVfWBhAD2ONYQhKSzOgWTwDStexhMyNtXFcXkYhnhD9w8g6qX6Y1wyscW0Hg0Xn+k+Qdk6v6T7e1Zc4Xq/edoKsRnGPUgL0URv/vFucSXoAA4BXSWzJgK7cWP8S3xeIXW8W8wycvooHhzy8n5x66qWG2aiFtGvTu/VBm/X546lfYr+uluvw4T5HUUvu7G7Lr35tHoz6s/6RHT33QfLeI6eEw+LyRbkqr6CjJEK9lFFyDuiXCfWZDkzGhSh2IlAwGs7rBNyI7IUmN+isrz7JM43kQY/UXn8//5GyE7r9i3XbR9diBPIPZ0qNBGfzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdtAvL4aHGLaWfew6Z51t4NN++kwkGa6CWfuzmVkWos=;
 b=CE60eZQq15oS6uVncP1nAc9n7uhthAhbuLiVWd/zPEZbGfzV9Tp11MHj+SvhTkRF5u+oFs3SJGxZLCkEUrJrefYaZUF3vLhWyyNlDR7KhuqURjOu7DDZv7eFi5GpgQt1AdnWBWjO8eYxBnEMjIzPCOSlB9NBUI5wGHIroGiU+9BzaHuCQto8eiGOgg9r5X/P5qNPEXDvk2c3BnFjqtj8tRowdnneceTGStYJPup5o+1iyGnTe8vY1FQp4/JOpDwMDgBF8cIVYhC0o09UfV8Hg2V4DuJbrwf7DYWXbg9NgQ6jxE/lSKE4mnT05NWIXwI8/H6hElgroHPBZQPwMUHmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdtAvL4aHGLaWfew6Z51t4NN++kwkGa6CWfuzmVkWos=;
 b=Ok6lqwKdhQ1VJz43ibR0UtcI9V/B9B/kzoyUXkcoS/ly8z3MmC5T250tz5bGoAC5bJWD/o0vq9JXLco1xuntZgYOfrmTnOOJS1LCwBcYGVaUdOlHSDl77PpC8BpzV+Io13BMYCUkFe47GrvQbIwndzxT64u8fpBKcB3DbgFf/nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 LV8PR01MB8455.prod.exchangelabs.com (2603:10b6:408:18a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.15; Mon, 11 Nov 2024 07:49:21 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8158.007; Mon, 11 Nov 2024
 07:49:20 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com
Cc: patches@amperecomputing.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	cl@linux.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] sched/fair: start the HRTICK even when we pick the current task again
Date: Mon, 11 Nov 2024 15:48:41 +0800
Message-Id: <20241111074841.8802-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|LV8PR01MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: cf531e6d-c5e0-435e-9b6f-08dd022559e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?seWHtoU+4NBW6p7U1arLNlQQQrQf0EgbSYZobd4ib8mMHwmFzHSYN83656e/?=
 =?us-ascii?Q?gxsPWlno3U2Rwa4+mjJEcYgAmUAWrYNP+OFIGAv9IEjwf+u2xihXTDGdflEw?=
 =?us-ascii?Q?8nEa1gSVSAW3wA0UzeBJnqM5Pe5HrpOIHbEwKGH0mqUgeckrSVLmqpn4w4dd?=
 =?us-ascii?Q?DOdrW5gnkm+K8a72Fm+tnh0bfKSM8hSOYB7Eh7M+DqmCndmWk0wPYPcnHhky?=
 =?us-ascii?Q?tR3Zb2+oN/5TSLgJSQQe/jhzlufzjPzOGOt9P94oGNmwVYgBcIpcI5gClj+h?=
 =?us-ascii?Q?QBzRgdrmwpEyeYm/zV9nzrguShmhL+m0cCznq6sG1NVzsfAIFkkle2DIAYEZ?=
 =?us-ascii?Q?JsCXl8rPofz6Il+jmhUtCcqc91UKXN7QB5JuJ/iFx/St5jIimF4cj/Rz5MWA?=
 =?us-ascii?Q?MS7e61CAD4kaHb/CI6BfwZiyPC4uvhyOnzFHjRI/5qBw/UY/G5fFZAhPx6Ke?=
 =?us-ascii?Q?HA5X/UtjLTCiNhjgGkA4GiHcZ1vSMMTrpMwgodNNNWbd5cj22/UK4W0FeUXP?=
 =?us-ascii?Q?h1pPu75OYyotnvEq51qPqHpBTnPDA7guhi1tt1JQX+IpR5kdlHZi6sk7QTT7?=
 =?us-ascii?Q?FCdVw5R6pKtIf/iF38+R2+9fkqYvwuxZlq0lx96eCOnVQahItwUm7IVk+hzM?=
 =?us-ascii?Q?Eke1OhinBgeIOPEKxkud4GvcqqNCo1l34N1DVuU9/h6HaAbvwVfBf//MqBXG?=
 =?us-ascii?Q?y92NjrmnTYf76YPBTwupRx9bwTECGgY0amgEx6JsyTR02iaBPUOT4i4QQUN9?=
 =?us-ascii?Q?usB+3oRdIV2CX3YTNcE2w9bDr4MeQZE0nNKV2yXDOQ+lxWTdilffc8KxMxqK?=
 =?us-ascii?Q?iErF/v9zh2vj+cyWvCU4p+pKrmFTeUzxHAxC8Nsx1ucEvDVSPFkHN3WE0NC9?=
 =?us-ascii?Q?GAUlc7j8xE9oLsCidumj0BSrXvXcxE2agvuopHlnLlbcqaYnxG5TySKmKB5R?=
 =?us-ascii?Q?gjIVkMbH/+erIBii87hPZvd32HWeVl3+MgYMZ1CP5/8KlfmBnXaxEanrmNb4?=
 =?us-ascii?Q?GjPjgV2NesT+oHf6lxUk2fUE3x1+tZpYIA3rPJUv20QTAOj2PtiC/g7EeQjm?=
 =?us-ascii?Q?JMLd2bWpx0uzDXYhuUKZ52PD9jK/nPTW9rIC/gErxMXKXCyo4o0duDQeAv3W?=
 =?us-ascii?Q?daW0EDOmJrplYmYKu1I2BoR4uTLJX+F+uwCvCAQLfZ20ptNobeWbWX1EY1hR?=
 =?us-ascii?Q?wJSnmvoSNpYsnEKWzz58A29VFtXcIBJJ1oya3KXrERoXLTb3yDZrU+hby0ZE?=
 =?us-ascii?Q?x+AY8fFmOsm8O1IFZkZP0sVnscAleH4qeiFoGw7CHeiloVY1+KGTEIqlEwNx?=
 =?us-ascii?Q?xCOa36Lf/FCFaS6DcM0YABo3X1pQOx1gShrLmkIC0JOmAhJbLseBMDVKJqU/?=
 =?us-ascii?Q?WE0c/pU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q9hq72BK6Djw0pPzcp5F4/NwKC0orqtqIXQdNP5oyT/3FaZjU2ripDuwewVv?=
 =?us-ascii?Q?Uy54o3JMn4azd3ZJsw4YKeNSO6bnzVPIcXhGMdXgvZkI/ngfpKRqA2BG4Dls?=
 =?us-ascii?Q?KhZm+bDmK9DyUQf8yMPzwdyl15Mj8aiSwe4M7a5+z2RM/OeDMGx7UasHrTGk?=
 =?us-ascii?Q?2PegvHx1MKsqJQMTAOBz8IpS5fX7MGbPqIpZwtiHIyZE3K/rzLKRE4aIbAge?=
 =?us-ascii?Q?U89ujYtxG8t+iTo+q0zR7Oa2c+ILBMjo206obKG1VVD1/obm7qsxCC0KIXtA?=
 =?us-ascii?Q?tCc4iSi2zCxkF8IQqYpP69Xg08d9bT/388X6nlCI0qyh716pfvNqSmB7+r7y?=
 =?us-ascii?Q?iBJpM77Nm+o067CmnYjWwKS6XIjFr7xD2Tu+BORr9nARhyZM8o6D7/A0PZl9?=
 =?us-ascii?Q?U7bSKV3mwagJ6wIYGZaBp9/j17RY+5h6Aq6/jbcxKqS1F1l34E9OBsXg4EDK?=
 =?us-ascii?Q?arARfWYWjZCQYzgAjVCIaCQ6XWxSLCHHa+OFLNIaHrkg2BpRh8NA1MSusgWX?=
 =?us-ascii?Q?oVfoSHnpx+XdYykMGnUQ5SAkBfagpNHDTNpnFgn8qhMA/47amZbAKlfiXzeX?=
 =?us-ascii?Q?6TIZwaDK/bmfkt/P6DVssMzir4ScTsVLEt2W9nigjar+vjesXDE/0xIhoPQI?=
 =?us-ascii?Q?dovgyopFtTFOYSsnCsUCUqmdbUswuyW1+aO8vKqynf7d6ck6WcWG9z2hrsqo?=
 =?us-ascii?Q?K/3EU/7yTvCo4lj0GfbJ+8ynJz1SsbDVGO7ERzb0ZMZ9OTHCz2Mrrnxp2W6+?=
 =?us-ascii?Q?Q3ABWHBLilXB9JQYO0WopGcQOLM1Fa/Ck34d3tWdD4bY+N9GGm8RIARCBu00?=
 =?us-ascii?Q?+n9HKKV5nV8r0cGss9lIwDntetW9A5SXaIN1LoOJL45iZib+bTwhA1rx+gGm?=
 =?us-ascii?Q?xm8fxNtedQtJ/DWkKS3c/C7ciUbWHZ6fr4jXO1A28og/Elpn9zuA/24iDnql?=
 =?us-ascii?Q?yfdbLTUfPWuhFQ/v3vDZi+8pODLn+c183U7bCt6aDXbY8AODgVOXVsNkfdOq?=
 =?us-ascii?Q?G83cacu6EOEj7T7aiInZH8vKlSa661F/vp7wKlyycJYn3HsDSuZZddUWTy0i?=
 =?us-ascii?Q?sS82P9N7x+GnWoIkh0QHJrIVM3LYcfkekXGA20f0uj7wHdmCOVteSAftEIzu?=
 =?us-ascii?Q?AZwFh1mfF47MlZeCl+DsKHnInuum5gB00ZTeONqtNLqfO/y5dw+5x2DON+09?=
 =?us-ascii?Q?sveq5J5aDtjg1DdoGybwFEh0AGeJQnm28pAUGwlM3vuwyHvfJS+QxEy448f0?=
 =?us-ascii?Q?b6NARS0RW8hDEPxJvcpLafKa5kcgXvMlkO7BAS0WvSpxAoY+5EbOcMHTem6r?=
 =?us-ascii?Q?xCHCDzIXYas794hgwtsVDMH+ZCpDHlpPg1Wpl+cJwxTc3YWmpIVenIv0cLER?=
 =?us-ascii?Q?6lJbWD/Inv7snlwCFKLU23Rade574G2LNF1LyP8dcTpKv6MpQJ+MZknI6dYu?=
 =?us-ascii?Q?X4NtEQ6ygQATpwMY1LtN2wKE4PSz80FAxXNFpSwN6Q5VUJu+nxNzwZ6ng1cB?=
 =?us-ascii?Q?4NZTN/ptAL0FJ7tPi+uNy4hBMUHYPt3jy5BxTQ65gZb8dPBYbWyMB1u48yKt?=
 =?us-ascii?Q?6oLv+ycRuuwHzMAV4YGhG2+e7klY1jtqpRcRxUkL9dVW3Q8apKgGFniW4XVZ?=
 =?us-ascii?Q?CxOP6e9J/TpvxlUE8D/kQSg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf531e6d-c5e0-435e-9b6f-08dd022559e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 07:49:20.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsnG4dmR5852rijdjFmnmwXTJ6feHuuiv19hpJqqhWNJbT/8a4rO2Sn5s+ht3K3uf5aFfykSrlgij2poGpuBvinMkLksytJbMIS5b9IC18fyyeJJ0GXCHqkW1C15BK2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8455

Assume HRTICK is enabled, when a task is running in its time slice,
a schedule() maybe called. For example, an IRQ(not HRTICK) may
set TIF_NEED_RESCHED to this task, and then calls schedule()
before it backs to user space.

                  slice start              slice end
                     |<---------------------->|
           ----------------------------------------------
                          ^
			  |
                       schedule()

The scheduler will first call hrtick_clear() to clear the HRTICK
in __schedule(). Then in pick_next_task_fair():
       (1) if we pick a new task, we will start the HRTICK for it
            in __set_next_task_fair(), it is okay.
       (2) if we pick the current task again, we do not start the HRTICK
           for current task.

Even when "rq->cfs.h_nr_running > 1" is true, the case (2) may still occur.
For example, we may follow the RUN_TO_PARITY.

This means the current task may run beyond its time slice:
  Since the HRTICK does not work, the preemption is lost, the other tasks
should be scheduled may have to wait for a long time.

To fix this issue, this patch starts the HRTICK even when we pick
the current task again. If "rq->cfs.h_nr_running > 1" is true, it will
start a HRTICK for it.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c338df26d26d..c7b54eb069a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8949,6 +8949,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		set_next_entity(cfs_rq, se);
 
 		__set_next_task_fair(rq, p, true);
+	} else {
+		if (hrtick_enabled_fair(rq))
+			hrtick_start_fair(rq, p);
 	}
 
 	return p;
-- 
2.40.1


