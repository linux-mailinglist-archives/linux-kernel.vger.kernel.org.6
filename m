Return-Path: <linux-kernel+bounces-420400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D4E9D79FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 03:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC56B21AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F97125D6;
	Mon, 25 Nov 2024 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UhHaesb6"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2127.outbound.protection.outlook.com [40.107.102.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D614BE5E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732500832; cv=fail; b=C0YxXHhfEJLtmVvqo1/Q/WY/QBm5YNdFXA7/HQvZYiKAwg1ZY/NEc0ywPN6kWEQKNCb+YLHzoGv0aPN8JFnGgdMIN+seA76HV2kFRju1w2l1ZW8O42lybKgoNt5y7CRn+xKUDAwrB8qKAtYnHrhzZykEzt68pW8t79spOXqAjC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732500832; c=relaxed/simple;
	bh=vIiq8Bf5q9DUGpC63Ci1HIqYEve9Oa2/VfZgTxDwBN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CuAtWIXui10c4rImZk0lWP2+cFLAralvyOGuteUc1Ueidswj2OoOFLFt3NFNxDsXR+VY+Tt2y6acrb5PeSnk5b2gqG77nMCToYnvtvgDBN8XRZgxHVn16or3/cskgDSronfASl4qzKG6hNssUD8c/d4f/xI16gb4v49VjFbrfxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UhHaesb6; arc=fail smtp.client-ip=40.107.102.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0pEre7n11bcn4HYIIYmJ3xMoUuhxJk5qz+ypUet7LnBtBzvmzvkRnA3vbbkrBEtOlRpzQUORXw1sf0W8V8titNjTGDz2NRZ6Yy1ZZQk1mP8AI1fwUI01IKoD5u1NowME7mnEcSwDjIBpX9XdE21fMQqzT4mUMSrbrFURMvlsTVAb2ExL4UkUWPJg95FkUrjdAAQxpjqIkpb8hhqh1Hdirj70ltLz9s2XZZf3+/rYFBbfi2H7y5WkcYnkYnIBLCi7PH3O9p0w9C2ufRJ8p2wLpFobAApkx9glTKmB+DvTxyBh+zBdaAAUtEV4WixiBdQ4dzKwgrRb2+0IzAWAWDmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqyHYW1flMdkcJqXZEn03eLQIZogJhxVnO3GsE9q6qM=;
 b=MW3v4/e2SvpSBuVglR4dm+qcMBrBb0skY/M/53ZV2In4IR6AzgqIEdx8GDjwClYhio8CG+JFn7irE4qhMznZRh9BgKj5pLGraVR2pv/y5PBjIlNLg+1k1bvHdwFmr45uFEpT/9TkWPdg36RYJEFWgSnJ+1w++cwhLGDPiUK7VEfv9G8SFzeHxkkcMuDSri7XwrIS5LFYztWGJhHb2TM6/Qy7oKsR1MXfVo7qyFGVpOPaU4OlRVgiAhapDGICT/gqw5HvUkxanXYcWV6EOOMp6W1fB6KyAkyU5KVxRGdkHA5Z8grs5a+feOrjOH8wEzWqXs9sksy3ltM0hWcvJ6mKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqyHYW1flMdkcJqXZEn03eLQIZogJhxVnO3GsE9q6qM=;
 b=UhHaesb60W0b7HuQAzDLKTzf9O28QX3FVpSM/sckXP4/26XOacV1jen+Bb8wsiTD6Mu/zmy/klvyLU5fWlpywLwl2V8nx6KW6bg23zuMRV43iGT7QB4DJcGgeKY9Rd0i+MtvBv/MJQ0ZF3ri0Z3IAR2vEONcnhLMTaLGFuZV+WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 CH5PR01MB9077.prod.exchangelabs.com (2603:10b6:610:215::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.11; Mon, 25 Nov 2024 02:13:47 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.8207.010; Mon, 25 Nov 2024
 02:13:47 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	cl@linux.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH 2/2] sched/fair: Update comments regarding last and skip buddy
Date: Mon, 25 Nov 2024 02:12:21 +0000
Message-Id: <20241125021222.356881-3-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125021222.356881-1-adamli@os.amperecomputing.com>
References: <20241125021222.356881-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::34) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|CH5PR01MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d52226-5a23-4aeb-1082-08dd0cf6cb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oZjOVpBql9zPy5+kAL169JKYhzuF9u0DF3FxIE0WpTECwRvdLLpDIY99ivhq?=
 =?us-ascii?Q?nrilQwr0/xqlQsg/36uAh7/rzMpu7vbbAmu1EJQUaaJP2agXMYkx0M6rLdgV?=
 =?us-ascii?Q?/o2pmO3V40+17KCJ7/1UtbtLjAtcWkFqbw6MRT3lobl73pZucKg2BNY2jQPC?=
 =?us-ascii?Q?xYD31E/i2X/jVgKg+3u49O/HsZhb83ZGHa6Sj4h2lkoDO6UeGPAr4VDNW2qB?=
 =?us-ascii?Q?eJagUsELU7jcEvTdsmCecSUAbznPAT0qJCON5wwg8JeO8Fp3/NLAV3dNAnoj?=
 =?us-ascii?Q?iIqr+ImcIra0Lb4jHkyqgtFY5F1+yFpeBGt8TqdPhenifyCfRljxGGIOh+SU?=
 =?us-ascii?Q?UahgEqbtSw4P6t+ryLZDoh9I0MRfoLYkxbwu73OOD6bNak4RslXCMYpQvr92?=
 =?us-ascii?Q?75hm1FFTnLsjAC6Z0kDj/wff8U2y54/XhipgldAt9jCWUNO00DYjgxI2m5cP?=
 =?us-ascii?Q?n3cimfCUTNIEMsSyH1XaSJ4FY4smfwpXz8BfLnjmB6SAU5IuP4zDRx8WUlGs?=
 =?us-ascii?Q?wLWUYKyCmLIBWQHBP2kcO/Lykhz7E7w2Uuw+fVYHZ+b4NeaqFMOB6Y4rDjoj?=
 =?us-ascii?Q?WtNXr5WGBbECOHN7o3TWWIYjY+sKCpQv7y+4Us8gAHRJnaRml3AWLSdXi3jn?=
 =?us-ascii?Q?/dsSCQjXOY86F6bVzEpMfR9cmR0VagaJywgFZEPIldLLC0+PcSn9FFi2uVPP?=
 =?us-ascii?Q?II5FmIMoJYq1ck1DN/sot/XYwZnVIWIkDKDTlm4zi0hjwm28fsyzYZ25t1yT?=
 =?us-ascii?Q?evqas2uG33795IyfSjjSnmwlEkftuGNnJdiPaRBV5h7e5usH76j8+ria2/E7?=
 =?us-ascii?Q?dzVO5MSO+Ue07qa536czaejDfW+CPrmhshb+Zp1f09jAzHs5hbeRW3s6v/xV?=
 =?us-ascii?Q?cJT87xQVhv/rKuB2ZWD3Di35B3Nsy0m6oeIucc/bp6q4kYl/VP7UWtt0VRPk?=
 =?us-ascii?Q?PeBD7FBmy/Z3WQi2q/QE3VQVNRNXbKL/xCVLwLj+gGvHtEZqMewJ5/NAN51Y?=
 =?us-ascii?Q?TPufBxIxBSynX0GVh6XNDwhyu+DmnHN3psV/rVozGxUAKP+u7nGma5kCc4ML?=
 =?us-ascii?Q?q6HYskqOmvqZa0dUsydpSBCTyOSKGWLJ94w+FWFh2j+qioVJeFoBXPkwK/7h?=
 =?us-ascii?Q?x1K6Vj4/d5fOmujIiaX+WzxEDqxY2ixmQM6w1cc4e616sylWWoMHHpPJ3pt7?=
 =?us-ascii?Q?X9XGxyLTHVr+TnbrzD01ZcsqniU8M5UVdVpCYzB2I6/oFHcpLPDXecr1rkBa?=
 =?us-ascii?Q?FS1UoT8dFtQjV9VHPtIb7PjHikNdHOoAB3IkQldBozd1FEbRGfTqzIX12fUB?=
 =?us-ascii?Q?pki3nLvo2PYIk8SzpJZmaAda24r23Lxx2fPZN+OcX3727UM2PEegDcIdiW4t?=
 =?us-ascii?Q?M9kWUSGBB0T5iw0GUPEO8BixQxRGpe1RPfh19KJBJj6LtuzZ+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IHU1ysRB8UsM3AZOI5JdbGUO9tZa57un+brQnaTKNO6nQFTLTRTDpdguE18f?=
 =?us-ascii?Q?fLRxGriNIgLXCNoAgCuUFpxin6V/fiCZzM5XT+RokXxutRdEF+okwfjemSNl?=
 =?us-ascii?Q?/Uy21B9RzlBYVYYxmLxnTfRJHqNz/V6noCfjdMxcRF99e98YPIyO4N/Upr0t?=
 =?us-ascii?Q?haI0SiO3My4cUXb7Pj5PqF62MEW28xWLXi72OaKKx7Qtqn6FBExzfS8mli0t?=
 =?us-ascii?Q?XQZiR0dv6g08HPcv0mvABChEiUpKUe9+5fuIxzPucDSRdtTXGIUNiDuRwbRC?=
 =?us-ascii?Q?yBxBR1LGu4oEtw8ImiKZi3bDo0DVozpbLJoCt+ocYZPdwDZNBgEFq2gxr9H6?=
 =?us-ascii?Q?SU8pWBrrpDzNk7OBIPIDazfdRX6fjLWqLDldxMFXt0BZLcX39EyMlC5LKX5J?=
 =?us-ascii?Q?0njYQA8aQt5yBz/fe1q2QrJT6M6RkMxl3qMU8T90N5DnYKVq7P9zHMSbUYxs?=
 =?us-ascii?Q?U6ogYQwfXEwrKrEOsZDoaNnuPK7O83mWcl9+vRyBrMIHulbD/gzXaObLO7Hx?=
 =?us-ascii?Q?OPz0eVxwZp0pPjK3WYzijUWlhWJv+5eeyeiVXtrunoheT/WFH6tuAZUuEvfE?=
 =?us-ascii?Q?rnUbZhVwCKMstzM2UAhslaWDVs1dNSeLROMYP91AmjCW8eVsA8oRXu8QHlWg?=
 =?us-ascii?Q?KiZQjtjQZvSSK1fZsyyKZSrkskibXTdYcTmYoCGRwHNyAaIozy+kj3Tdci/f?=
 =?us-ascii?Q?IpOTeM7PrdnMJxbRnFJYcazvZxJ0qizlO5oRTgNE6DKd2Tp8RI7SxHfri2o2?=
 =?us-ascii?Q?JGtNRvrGtCAHeijvF9xL5rYdtdyhwTKaUPVYimASh0XAIap+l++Bz5c0wFPB?=
 =?us-ascii?Q?FekepNemT5k3dKo0GFDkuWOYSD1a/xg5iQxWpWZ6nXLnNeUatTVtrkRuaqUf?=
 =?us-ascii?Q?Kxdd/09LchGQ+T+xeKXwq6lR+LgV74IZc3pyuJZ7btGl+gyis5idXZhmTOzA?=
 =?us-ascii?Q?KYSyoVUSHfrEknrM0fINQbwUxyCPQvKz2fGxlN+unpuK7FYbwLxqIBx4scb7?=
 =?us-ascii?Q?cK4S469FtoVwNAzI9IS/CO5FVPQCxI4f/JKM7kjQESROzbG01kN0axp4lmSU?=
 =?us-ascii?Q?+xrMfEw9wcB9Ik27uJqpSJD/lQHV1JjTfY/dMcAyfG6r4xhqh0aSn2UuKisO?=
 =?us-ascii?Q?7+pmPaHax2oriW92PJB7wgvTj4AAcy5xjyXrlIFhOP+ew3OHWo/YSgNAI2tJ?=
 =?us-ascii?Q?nazMOu7cjkz2jUskjSBMvY6D0JamLGGO9+3op9psxzT5+Z2L5xU6ZW5fsqTV?=
 =?us-ascii?Q?6+p5WZDM06Z8O0V7lTqWO3n6L0v1qMVusaliPLmDY54bpxLMiqAuOn2mA351?=
 =?us-ascii?Q?11tPf3LrjCEcjVMKFNgMDfpo7J/3yjh57GnqM1cixmAtKsEfKoEiELxPZFJH?=
 =?us-ascii?Q?oTBB2EuyFXo8HbJ6vymTsP/Dl7s2EI0p3eXaYAaoVAcVFHoPGEt+2cYcNSF+?=
 =?us-ascii?Q?niNUODxy4eGEDYwzazw/IoI5MNGMo9rzEZ9gakriaLujkMkxRsb9D7HKSNEQ?=
 =?us-ascii?Q?Q1Bz7YTYP8tIXTLpSgVpzbAOCRD4/q3Z+2mOwVRZdEj3XsHtO/VVgyIPbHic?=
 =?us-ascii?Q?KEvXU8UDfBrP9kbXgGcJhvExQae5+5tL6ydFjPhwzpans3duruQPHyaH7u5y?=
 =?us-ascii?Q?bco/J/JfvYxmqyZWwmxpVhc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d52226-5a23-4aeb-1082-08dd0cf6cb98
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 02:13:47.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jui6gyE/xh3YreQyJBEmAZIpwxxD2OC0EukCJLZ20jMMLzMQVziDW1mMJgqqp/t8pylqD/9PIyF4NoVAr0wxUjWpZ/InqMvHS6+4bX73hHC8/fxc+/gVKIuhy0/1da5y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB9077

Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed the "last" and
"skip" buddy. Update comments in pick_next_entity().

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd1188b7f3df..d8826a8e0c77 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5602,17 +5602,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
 
-/*
- * Pick the next process, keeping these things in mind, in this order:
- * 1) keep things fair between processes/task groups
- * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
- */
 static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
 	/*
+	 * Pick the "next" buddy, since someone really wants that to run.
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
 	if (sched_feat(NEXT_BUDDY) &&
-- 
2.25.1


