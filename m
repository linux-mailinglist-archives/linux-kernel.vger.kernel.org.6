Return-Path: <linux-kernel+bounces-198855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFD08D7E58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6F91C20DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579CE77F32;
	Mon,  3 Jun 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Ef8OxHG6"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011004.outbound.protection.outlook.com [52.101.133.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4107E588
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406303; cv=fail; b=k8ij7AujCZLwdyex1UBWfO6tgsE+SfV7L1rR/ix9RZKIK3n/QzvRiooDy5OG4uUTTb7RP1fnRkguwUgVvEWGwOCN0oGjyCZocwr0b3Rivhv5TIvk8wom4EgdV50G7Ug5wgP9zYo2oDl0hvOytWxz5FB7wnOhsVj9iUUvJD3GLdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406303; c=relaxed/simple;
	bh=uL2qAdRPcEwHOHEP4u4KRvd2XqEQay1uWhE19BKwk/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F+H4e7lZ2YYMC+IMkH7wp4SHCQfSLXmZiLkfHdv2HM/368LsrOo7VhO0xip20j2RLQQ0Y4eIrCssF69j5b/RKNILzK9PpMFQHGuwt/7oZm4WhxvoEILOtYlhBxRc50qCeQ4cpz+CFLlnMeA63zHreoNIUfmgXtXermzeuATditw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Ef8OxHG6; arc=fail smtp.client-ip=52.101.133.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulg/bm/v/VjkHwtxCSGRs8Srjlhnm5reV9DZMIQQiCAShP6lFIxOvpmkl26a2AZlxJqVS+od+rw3NcOtD6P+S4axy6eYmUIXErRol+f0Y96nYW3Dia7mc9lRPoQiLA54aCghvtqX5WmrAAvUK9/71as4rvU/43JUJQ6sRlDM5/SOEmt0TRHPMz1yd2sTud+3GcwBPFuxCqqQRZQVaLiS10dYD5OXzfwJzWFNwBCSKzS27qP3QPVoxg/ZDVQvCbPk2WvEwAT/sfAqabyp3UUL6As8a7sZMJBBcGMvoxRDM+JzdFx9GLAKlW+KrgUsXCbz9TboojvjAxPQ4VVYomGmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wEdPTyZWy2SlAIVj33knFIZzwylOutc6o7w0DUOtPU=;
 b=XnFTw2R6ZvoHJ84BEH/4EjHP+NohNLYIauH7Ib7LB40EfGizOQQx3gU+DzisrD5MFjOgRsK7kXBiTQt7gpMcJfaRaZEb1u2Alocy4GQQuplyfmdNgSpjyjC5ygyIFrsbwj5P+DSXUZRKa0bymn4HKNjr7i7cEOgoyn3JTFRuxj1SlH2MrbGDDYd2oxkwa7f8hk/2KF+dv1RPKDm8mu3pCHhLkUWebyOeXFuuoHtkUx5Hoht11dCt8DejwqE8Gl6phhoAZbHTFXRH2CGEKRtdIB2igVVP71TvFnK/pwFtJUIzr9rj6b4dvcV20ZuxP5kuLZAzigRfxIKrRm3px+2Erw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wEdPTyZWy2SlAIVj33knFIZzwylOutc6o7w0DUOtPU=;
 b=Ef8OxHG6Lvg4Uv13wcspWuRdnAph4kPbbXw5Kc+vIPdvOzplGANpq2RRoAdFs5Xb91Pkc4bQuxhIO/xCdxVcXp0pDSu6mAD+/+TBax1SE1NNph0bEVFjmJZYBzZJh9OzxN3kyW9FgektK+egkDpcf9xb3vwGova50irnEhrQOGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
 by TYZPR02MB6107.apcprd02.prod.outlook.com (2603:1096:400:25b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 09:18:17 +0000
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7]) by SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7%4]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 09:18:17 +0000
From: "Gaowei.Pu" <pugaowei@oppo.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	pugaowei <pugaowei@oppo.com>
Subject: [PATCH_V2] sched/fair: updates weight of cfs_rq before update_cfs_group() in enqueue_entity()
Date: Mon,  3 Jun 2024 17:18:05 +0800
Message-Id: <20240603091805.858-1-pugaowei@oppo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To SEYPR02MB8152.apcprd02.prod.outlook.com
 (2603:1096:101:206::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB8152:EE_|TYZPR02MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c8eaf0-e134-46a4-f2ea-08dc83ae1aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|52116005|376005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqff1L+Dgf/30ZIwbxgtq5HYy1pnp1u+tm67wRHYHtHXJM5YiBdejicpk7ao?=
 =?us-ascii?Q?YAB6qBWbFbtE6U2qUfAB7Rz/B632RvEMJ0RivCkxLESHnIjJ6+YOn/UQXiwK?=
 =?us-ascii?Q?shGUSoHcrnfFM8hRTmB564lc6VANEUq30JVxZZysX/MlvIwDMMwbKud7kivM?=
 =?us-ascii?Q?VpN2jRBPA5sTLWEGBBhoofIksw9a/xBmmQ1oISFQ8ZwBohC3UTY3xNUjE+NM?=
 =?us-ascii?Q?W/VCOPc08aCJ7OUFajxZxiTU+dKGu3iXE0pmHK4JskBKX/Y4kD+teaAVrNNu?=
 =?us-ascii?Q?j3Pkf9l34Zxu9uTH/+KnSGdpSClePDk6xq6D5bDP02M+ZYdHWw0ffkkg3wVu?=
 =?us-ascii?Q?ZLt4vXtqHfKZNaRWxaB560xSmWsms7vZcLjWXao55hzsuXnqgoGciIsMjUXj?=
 =?us-ascii?Q?uzaWv0wy6VIpQprrxniOd/oHrkStX6a4ouEUBvVTVEGDzc/eA9mDxXT7XYuD?=
 =?us-ascii?Q?eTwZW0nr+VvSRbi+CU6QGk1poTNOsRGOjYDHQ4P1w9ta8HEJaqNeP7GYkz5Z?=
 =?us-ascii?Q?ZZBVkoYEySTxKLzj4fIn8bKc/9bDZZlxETE+6QE8HWhJ80K9m6dKEViWxSFk?=
 =?us-ascii?Q?ZzUbXw8C92PDZwaoPi0VtVwtNPam8iJFESbJd57Wir13vR5u9yIO0SgfqbSe?=
 =?us-ascii?Q?62KzXkkvlTyRmzZXptCYDDVAStG4wY2MpVUxzH0C5ynkV6zvKdFkwvLN383u?=
 =?us-ascii?Q?5VQENlgFq994FjftHaBZMCUiJk6lDMmgm4ohnHJ9xEb3z4LJ3l7Z1es9BWiv?=
 =?us-ascii?Q?VmXm/kqGsaI7VFDFlQ46XairXWFXyf/5GD9Nt8mlSicq4T72U1mOmvT+aNUK?=
 =?us-ascii?Q?H/lWDDTVihw1EFGJD1ECHgsfQoCUR5B2DJOXvT0ZCtcEQvtQa1myHx/Wcg3V?=
 =?us-ascii?Q?oXThlyxsC6TGIlba3WD7sSEs+39ek5uvY7JCMy18VeUDXQ588u1mnFOeY32Z?=
 =?us-ascii?Q?QXPvdQfE7HUc9/wbNkGD/tC4i1ZhX+Bfj0fb3RvD9LrO4p9cWd/dnYUdJrRJ?=
 =?us-ascii?Q?UTxVlHpR564jus9lGTyfw5KY+Z4ZVaBBc4PYkA7Sprhm1/BOz+lI8kE2ZuQs?=
 =?us-ascii?Q?bXQ0aPKCz3zFhwgHmuE9eiocKzK1c/lUC93RaoVaum7xg7KY16AC5JzK2eKl?=
 =?us-ascii?Q?2qs/cBNeIHALPP7gbDmhIB7+ZSDocoH7E5x5j0u50kJo95eM/t9MyJXOePDc?=
 =?us-ascii?Q?2byiRr6GjTLLYT7XWJI6jr+FnBet6TIpp4u+r+8DSAz37R10jEjH1YqTq0oQ?=
 =?us-ascii?Q?AUWNxgREoe7VrsaBuGk7T6TxZc9thbq7Hqk0NPp+PeIzHJxNekYXwRhOmprN?=
 =?us-ascii?Q?XSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB8152.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9EbAMi7Hoj4i/6g44thPu1jtuSGJzxfbeEpIvBmCS0eFgDf8pT+pNbT8lcKP?=
 =?us-ascii?Q?O+GgtcvqEmXXAET2Wr6JvgeH5E4s0bFnWaLn8bourDRx4aCpFMMGFOWRvpk9?=
 =?us-ascii?Q?X30tve6A7NIk/c6yogPEqtoU8qD5h29OOa/k29ISdBgdBDBDJTJqbUCol20Y?=
 =?us-ascii?Q?yzDAHJRIrJ6bv0UQU4XM9C670aBiKqe9s4iGLDaer7FzsMYvtl6WwIqJUhZu?=
 =?us-ascii?Q?mXqv3z8lvFTExkmv0kQedrkJrb3AmkwFZdyLr3aLiulva5bWuomyF6gqBemp?=
 =?us-ascii?Q?FI7naeN16ktOkGd/32HAFSXHCh1jHCe5aCqrOIhPjiO4SvmPxfrK6Dv7hS8T?=
 =?us-ascii?Q?EC+MWrXBO3ZP2+H1or5yDkgN2sny8iJI5v+tL1W4fNqb45jtdLP05Ou22JrL?=
 =?us-ascii?Q?5GcGMGAHBRiJHYwqJ6UPGdNt0bKAJRbLAXSYOFKi0A7+JPP5aVvgStlpGqAZ?=
 =?us-ascii?Q?5ZpgOaWeZ1jU6VFWrxtiuvfKzWG1/Bu4jsGw1fnMtspeNKMI7YtzhlJ110c7?=
 =?us-ascii?Q?8d3GzWeQVQdeZFWS0iHbNMwqBDo8MrzA1pkTBCHxlC/Ziw8xXWaQK6lt3jQK?=
 =?us-ascii?Q?cHq2cJ5T8kIwI8m4VaFrJXZAonOcHZWmuwspyDu53vl8bnrDR8DhdaHgQIjE?=
 =?us-ascii?Q?ve4BYLXZQLis3TmcL9TurfED+KVMcCfW4eXSL1s8TJH/r4lKzymdLnDx6zjA?=
 =?us-ascii?Q?9EN/OJGmR75MK32Hwzkm2Z0qgZ6SV3FD/aQO7DR6ryIIj7qlcW1typeBz9Ri?=
 =?us-ascii?Q?qvwAUOnIgASpYOrOuQ5fhZAPsTDf2JUpLnUBc+r5pzLotb34eZdvRBAcki57?=
 =?us-ascii?Q?YH1UwTVFtC2XE0YFRhbaUbwx3/46Kty+o/j4pV2JuEaSfiMgoeZb8K7wcXBn?=
 =?us-ascii?Q?W8s17GWPoTfIIMrTlXl8rnTvdW0ubAw/804yNwBDqvWnLFZWRhdkR3nOeVU+?=
 =?us-ascii?Q?BsOENp47IjIw+ZvVBvB68q9iI5PpmXv5lOWz4irvgyZbzhgFX16EXbI7pL1h?=
 =?us-ascii?Q?bt63D1TPSTHcnL34qPoZK8iLU6U/kEUSJwWd0xpHsU4jIlipGPMVJq1I9w2N?=
 =?us-ascii?Q?zFS17sgn0LGbEQe79bA0WgCsB+pXChkm8pWdKqaXUyDSX7pPhZx4eegb0jY4?=
 =?us-ascii?Q?SMLhdgQ3bb5jGag2ncnDTXAKjzUWqUUDuBpoAMjnRYrlDUfVYeKOKlI/uQOc?=
 =?us-ascii?Q?oA5ZJzMeTbwrZf5gvaIaoKW+7B00piArOYwBnq3VQ8J32o+IX4Tq3yOtCDjZ?=
 =?us-ascii?Q?wAK3ndfSG/t269Fhe3qm3Ns58VyWTxdCldVeveUGf/dq152CB88x1+BM9bEL?=
 =?us-ascii?Q?H71/370W5nV6/oKjj4LIWZY2MRxUehECd6CKlQlYNyYlTs3Z3inJ0thxmuGr?=
 =?us-ascii?Q?iGgTvBvCKWnqWvf59IEkMWYUz13siql+UQmIzxUaQHx4ADudDTBTHgjGah+r?=
 =?us-ascii?Q?UYVXkw+z9A+sk5LjxxN0kjTZDiPT8L+nw+roTs7iyGzFplKX2VE7gH7qyy6J?=
 =?us-ascii?Q?ZwTlh6xUyxGSqCSqqgcpcsAKdpKn2N2fagJVpgaPHnjzPXqGxeczPeQhEImC?=
 =?us-ascii?Q?M8ATee8GwcQ3+yU3tfVSMge3DGLHJajaeVN5nfdm?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c8eaf0-e134-46a4-f2ea-08dc83ae1aa0
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB8152.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 09:18:17.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lAe2UDeVaYgFAXnOJRs33z2ueWLMnQdjrwhM8+fkgXO5GkpU+DEPEx97SCJv8IVMOi0FpLbAtz/EIaE9dXtlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6107

From: pugaowei <pugaowei@oppo.com>

we should update the weight of cfs_rq before update_cfs_group().
Ensure that we can get accurate shares of the cfs_rq when its
weights changes. we can find this work was done correctly in
dequeue_entity(). so fix it.

patch_V1 :
https://lore.kernel.org/lkml/20240531030833.3375-1-pugaowei@oppo.com/T/#u
trigger a warnning below because of the changing order of
account_entity_enqueue().

[ 0.400603][ T0] ? __warn (kernel/panic.c:693)

[ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1))

[ 0.400603][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219)

[ 0.400603][ T0] ? handle_bug (arch/x86/kernel/traps.c:239)

[ 0.400603][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))

[ 0.400603][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)

[ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1))

[ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5182)

[ 0.400603][ T0] enqueue_entity (kernel/sched/fair.c:5328)

[ 0.400603][ T0] enqueue_task_fair (kernel/sched/fair.c:6785)

V2 fix the warnning and keep the lag without inflating it when it is
the first sched_entity queued on the cfs_rq.

Signed-off-by: pugaowei <pugaowei@oppo.com>
---
 kernel/sched/fair.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..2fb1fbcfdda3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5190,12 +5190,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
+	if (sched_feat(PLACE_LAG)) {
 		struct sched_entity *curr = cfs_rq->curr;
-		unsigned long load;
+		unsigned long load, se_load;
 
 		lag = se->vlag;
-
+		se_load = scale_load_down(se->load.weight);
 		/*
 		 * If we want to place a task and preserve lag, we have to
 		 * consider the effect of the new entity on the weighted
@@ -5252,9 +5252,13 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		if (curr && curr->on_rq)
 			load += scale_load_down(curr->load.weight);
 
-		lag *= load + scale_load_down(se->load.weight);
-		if (WARN_ON_ONCE(!load))
-			load = 1;
+		lag *= load + se_load;
+		/*
+		 * we just need to keep the lag whithout inflating it when the se is
+		 * the first sched_entity queued on cfs_rq.
+		 */
+		if (!load)
+			load = se_load;
 		lag = div_s64(lag, load);
 	}
 
@@ -5304,6 +5308,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	se_update_runnable(se);
+
+	/*
+	 * we should update the weight of cfs_rq before update_cfs_group.
+	 * Ensure we can get accurate shares of the cfs_rq when its weights changes.
+	 */
+	account_entity_enqueue(cfs_rq, se);
 	/*
 	 * XXX update_load_avg() above will have attached us to the pelt sum;
 	 * but update_cfs_group() here will re-adjust the weight and have to
@@ -5318,8 +5328,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (!curr)
 		place_entity(cfs_rq, se, flags);
 
-	account_entity_enqueue(cfs_rq, se);
-
 	/* Entity has migrated, no longer consider this task hot */
 	if (flags & ENQUEUE_MIGRATED)
 		se->exec_start = 0;
-- 
2.17.1


