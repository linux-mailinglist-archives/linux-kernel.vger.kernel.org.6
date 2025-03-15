Return-Path: <linux-kernel+bounces-562355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3FA6248C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CC919C1B19
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989A189520;
	Sat, 15 Mar 2025 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eaq5erEU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C02188736
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005350; cv=fail; b=MQQ1iRyfvlFUU0EHTqnzZkZ7Cd9T0s1HCrrEc7ISJDXiElYEGdyB7Lhm2acmIIPFQ+CVMpfpWaD3jvLkLMpTBimvpvwGJV2MxlXXXxifUPWDC+9LkC6a4KPHGIHj6f/bqnNcR/uTAFaZxtV4nYdyWrS5ynUn5bssUWP4C0aQHQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005350; c=relaxed/simple;
	bh=EEgecK4kKUT5VoczdQqCkMyQjN47LfP9AvxlWh24PB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODXXrMcz3MEhEfxvXZkoMDj+3uO6tMvZn+YS957YGiXccbS0RAqeG0CYp+Q0JcvNi2CkYa18Oa7G9qIczxUqBiz/pLvUPvcECF2PFXhv2EcPTs9l09NUKx2FKKJUQ2cLlNvUdNewB5o85gdxmWpKipunPnKzKMg28NUtVtqMbSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eaq5erEU; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3gyftVVynXdWpCKRLtQR2xL6EILOIPe4wKK3MKDKHXIug8DIhpfTrcIX9NkfuytPoSVdyC1l4egVTHTUqMk65xVHkywQtcU0vg52+kZAyuTLlCVxnP49HCoWpxQP9EBCLZxKbsJGG4OW9hqPRFvpX9I34zCukeibjF02h2AgylyJmoYu4Jl3fsuW0YUpbYm04GiqyW+hlW6msCSlouL1tr9Y792Mwc2nt8A/OFCDewivrqbWVkYARrgTUqRzn1h9tT2qh/RNoIeon3UOnixgjEAanBEIJWK+foXwbS086v9Ms1v3oqRCIQi32XRc6CJ6izQlGvavlaDZ5GJgKLJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3j715JQ4L5YJGHWrDWeMYBBW5Rmn3UP/X3tr4cSc1Y=;
 b=S9uIxv/QmAKZzOls9UdMPG+6m/lDUVRb7R7OeDSnA8f9PrKb1Y1BwFjVDm/hvBWs2bevemd/cXbVBy0ws+yM/eamom3jcKfMtadb7WsyP5Js6I+YEPuvgZlL/I7LMuu3CnEKrOfMUl7oUtKKSqBWgF7bAS5TZRDH99SOb72L9C6iuPUOYRL74ItboYjc6v9d2aawR5s0dV/Sfe/amq2c8bliB49M0LD21JrU8OOsvXAL04xOiYe1HKeVvaCu5Wu9/aJBU0plXCJhvA5TbTK3DP7m4GVXRtxobHF5hqPoSAps4euD9tMgUlzky+ZMyhQTytksuYGpkYHDj3u2tq2cVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3j715JQ4L5YJGHWrDWeMYBBW5Rmn3UP/X3tr4cSc1Y=;
 b=eaq5erEUbJH0chBEoUaGMTRrDAwTCxRwMnnOHSiOPJW2T0i5pZRegeoSS31itULaqMxRKXFm0Yf1v1UNaTPLdGtJ25Y6mtrK8UvbTwmjUGSaJ4p+tEufBOukaSZ1g3W7f5Zz2sY4F8sxKqleFdqGjXavgVK7C+SJFE63U5IGKKeXIGUFtNrbcvJzywfLbceDuPgaXdXL4Y47t8wZHyXHlRK4qqm3i7arjDNngr+I+Cu8GuZXaEYPQq3esDSfA/IaI2PE4ItgIWRhTpBQpwoNbmFRWeB5k+x2w/gbBpgZhvbks1UOHS7CQBbZa6PwhdCy1f/7D/MNkwxz6aBYQsnMzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 02:22:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 02:22:20 +0000
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
Subject: [PATCH RFC 5/8] sched/debug: Stop and start server based on if it was active
Date: Fri, 14 Mar 2025 22:21:52 -0400
Message-ID: <20250315022158.2354454-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315022158.2354454-1-joelagnelf@nvidia.com>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:208:329::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc20d88-20d5-430e-8153-08dd636836ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/JX/O8L0dc3BKtIj0O+drjNaTTm/9EfAmw4ZvobVljBJFqxfyjsjrfnvq8HG?=
 =?us-ascii?Q?klg67KW58p6NJXcdPPZFUNbCZJ0ANCsi5fbivDmBJTQv5k33Mxx9E5GYQ/xv?=
 =?us-ascii?Q?jWMdOPeSCFDIjrTsFnWrWwj/LejEyh+3Cv/fggaj7EXMLAKUDC3G3zS7I4C/?=
 =?us-ascii?Q?fjMXc1P/xny8/eZDaPZohV+CAww2gfRtNnmdGVFrVPKSdF/fLkUT2wJLzmEK?=
 =?us-ascii?Q?yyojhO3Pg/ly+cGFXCvk92V5nVeIFSqnQ+Q4gyAQbIC2TD/E2c4vcsjYzMyQ?=
 =?us-ascii?Q?WplEOF6f+6LF1s9+xoE2F5hJe1FfEJEn2/YS8eneBCgT3sGQi3smKca+BQtS?=
 =?us-ascii?Q?XO9gO91k3fNkKL04NTsQ8vuft2Z4U6egLoKlhGLUGj6BsYelY2/MTgcBr5ex?=
 =?us-ascii?Q?7lI9ag1IQnZXO4dI5kWJu6jWh34xUMaw7SDCtyPCJ1vVtE9zRDmtxxW3jEU+?=
 =?us-ascii?Q?0oaoj5mM3TeXn+OUBPK49Uf841YlIP/ySXjalaazAIOeJoUhq6A62lDri0/T?=
 =?us-ascii?Q?WRBULL9k/1QBB9WJ7Nv5T4Tk2T/reFAnWPMMZOiZcce5vKd6QA/tx7yj+DHL?=
 =?us-ascii?Q?1BiNVMb2UtiZdJmLsUQRhWqImyH3HS+w5oy6+Em9MdDx8/snU/RXRtkfkUUb?=
 =?us-ascii?Q?1g00WzZVNZLFoYfAfk2+/WonQMEjhQ73bqj1LEKXdCm4BXFhExUaDBfWDiK/?=
 =?us-ascii?Q?yJpaYDorauzpC40IKdU2ujKTOUpoKISkH5LM4ZLHHk2zKRc09WSlZ5DrZ7qt?=
 =?us-ascii?Q?+NSDqAfXIlWqcerpYd3V07+rWnF6UO1oRDDcq1A/gQW/aBH6DvVveuhEDmIN?=
 =?us-ascii?Q?lMH6a4lXKQ77jsnoJZliqo+SbZF0SvyB6mQVpLtMg4PLO9UYEi5RFvxsuS8h?=
 =?us-ascii?Q?16x3TPe35uAZe4z13cHZNFqdgLJNILFhK3kKfFTLfk95Og6CotU4GJx7Ql9R?=
 =?us-ascii?Q?qmwS0Mm9fkX3Fe8LTMw+Lo9ocZzP77dYdAZZnMl/Gw6LPWe5garWUNXxtHmx?=
 =?us-ascii?Q?i7QJWP4v3DpQIEPGU5rq7WvNDK/ssFOEHSgJQiBgMBWJn7wEKRS/2MSFmxmN?=
 =?us-ascii?Q?it8rYpJVqZS4/9MSnXyk3LaHFH0GqUW0GPeXEcKgpVqjZnDm//4PLGZ8Ftmu?=
 =?us-ascii?Q?k4k2GGUuzaVP7/d1lxHfaEU5Q697l1KzkvFNQqHgfbCo8JMZ0lJ7qKnNRy95?=
 =?us-ascii?Q?QNMBj9bP/yP8GtjEq4ZByGrhEZETPVBmr8TyJC7E+y8wf/J2QwCVzsXfJPtL?=
 =?us-ascii?Q?oNA6iW3Iv81EY7NQufZVvM3j8BaJvwzLw5Ixf4hoy7LhZ5Ah8U9Df7ashFBr?=
 =?us-ascii?Q?C0IYDTvXhJcSJCpbCv/PYedYc/41BC7+ToMDhIGJCPComr8vcBZv4u4bkEZt?=
 =?us-ascii?Q?+87Ew50INgfeaaOa1sm4Xvqfhlc4kF2z9y5d34IKF3U/5zBETAtSARol/0Wh?=
 =?us-ascii?Q?4PJN4exMNBg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ldmI7HHpZ27ewSrRJaToxPioOTlztdPT3dKDcvNYTTMIx65IajyTUlY/afCp?=
 =?us-ascii?Q?XoWw9Ch6Ky0RpkCKrMyKM3uvkYY4EVKMSScyFMP+4LEN3H+g8i9g0vHpgd22?=
 =?us-ascii?Q?FiVONEADCwIJlr6/dXznGNi9bt4ITgMMgGzsCu+8iTsX4T0cS0oRSS9bLOdj?=
 =?us-ascii?Q?To57zGxCdqcJ6KARBz2c+FKW2HvXTpEsGEgUvaFtDUCpm1pwczwP1mT/Mjsj?=
 =?us-ascii?Q?rDcudnxRx19sWLn2Rc00HIw8aMlhvL79W7Kp4l8r/Wpp0eGwMseGkymeOvrp?=
 =?us-ascii?Q?gYCQ29WeqapbvA412zH4sHakoDaK2Yusk4PL8XvlCDwYF/FvQqojbIMIKqGs?=
 =?us-ascii?Q?v+CJ6e6g5V/GJDKl0+rnki/7zfN06zvobi2qZx7D/kMJ8ArX3uWj1NLXo53j?=
 =?us-ascii?Q?XTEOccsmm3l+Jz8Hld9dWurkVv7LSPUFdiiGgfa4K1sLw9XBhZkBcMe9LsbJ?=
 =?us-ascii?Q?RnGPupnlQXrS0F8jYsgSC5JoiHIlgL/pjeVCPYecYSAFRNprECwvodXJcE4K?=
 =?us-ascii?Q?G6Gta4bicXOnHg3+2UvrHiz6AgOspDKj7/ES/JBDEEwo6hFyU7cll/pUKfuR?=
 =?us-ascii?Q?Zqi3b2FE5Ue3KUiRWCLV+0Zy+Q+9ex9xVXY+zGYfRN3pL6IzErFUGpB4YJga?=
 =?us-ascii?Q?55xTjDHX+y2zBLyhzTD7KZfQjucmSL6H0szdPYQO9lAI/8YOFuSXorfvykYw?=
 =?us-ascii?Q?vLKtPrNVZpsCKoop2YrPTKOACbeo/UreQS9spGbhib+SB2SNVddcGl+wA4z6?=
 =?us-ascii?Q?3AiEcAbQkgCZT+FN5badohPQb8H2bPuIRkxIVPK9m73xKKPScSUdtFyLVRMb?=
 =?us-ascii?Q?YW1/2zpIrb3RrfXqRt5axEUSQzsYGaXh5js6e53kcHQs8lNy7BNYuKLO4b5T?=
 =?us-ascii?Q?csoFYu9xgrb/oFGWdo6RgIjrsXMhCiaWzF7wauZzRz3evyQHI2oBI7E8sLo1?=
 =?us-ascii?Q?i8Ajqd9/hfCsg8hVChZ4lPiMbiTaf7p69RgsPILt5v9+CNoFgI1DN2or2tRd?=
 =?us-ascii?Q?Kw8ZW9cq7FLaVoCfQHkxLXRw7B3liPYcs8/a/XOGoJL8BtYztgxulyIc+Cc/?=
 =?us-ascii?Q?wE15/s2IDmqAhRrUGKkJPNmgBrmAvqNAOERSlL31HdiOH4wpUNsUVNPD4K3D?=
 =?us-ascii?Q?B/rahVAlpKylne+WzD3C8xJfnWg+0RrnwR7Ehi3Xs/kyFJK32OvUUTRIlVtA?=
 =?us-ascii?Q?O+YF+wnFwSsOge0cB20YRjr5IJNc06pz2kxQ7m9IchtntejS6YTTN450PEZY?=
 =?us-ascii?Q?4ojdZl6qhCcWODS4z33Cp1ncMhrCTtGyc1u5bxYg1FESUfhNiwjiueW5/jxp?=
 =?us-ascii?Q?9dgMa+yws10/pt+BtHANLZIxZ6Rg91+okjRGN3wRHjoYRV9TpsjIxl7y5aWF?=
 =?us-ascii?Q?R7YrzqU1ig9uFqAAh4hYcp+R/kC3KcsJSSnVm2n3tXErQ4LHmV96tt8y+Nb5?=
 =?us-ascii?Q?9bk5KlCbdskWTc8QRvLVm1SS+v+MyddXnGE72Kzi34QUVIoDxmhLCEP8Tz7/?=
 =?us-ascii?Q?OiRaFlNXMxyV4g4jTWh/GPb/yNMs61NTLxdHcqxTcOrzZWyELOZm/Pq+GB+K?=
 =?us-ascii?Q?ZKyCdU5ZaJirPZv1XpyWuLTszU5ySq/PbPUXh+/0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc20d88-20d5-430e-8153-08dd636836ca
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:22:20.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg/E7bgQg1ZDVx6Ry8uyiCFxDuleRi4loOA9aOitDhmaLvZ/YxzUes+J/EUAJHuuGipxichS8KQLdJMx2bJNUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

Currently the DL server interface for applying parameters checkfs
CFS-internals to identify if the server is active. This is error-prone
and make it difficult when adding new servers in the future.

Fix it, by using dl_server_active() which is also used by the DL server
code to determine if the DL server was started.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1ccc7687e1a8..83cb695d6d46 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -347,6 +347,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
+	bool was_active = false;
 	u64 runtime, period;
 	int retval = 0;
 	size_t err;
@@ -379,7 +380,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_queued) {
+		if (dl_server_active(&rq->fair_server)) {
+			was_active = true;
 			update_rq_clock(rq);
 			dl_server_stop(&rq->fair_server);
 		}
@@ -390,7 +392,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_queued)
+		if (was_active)
 			dl_server_start(&rq->fair_server);
 
 		if (retval < 0)
-- 
2.43.0


