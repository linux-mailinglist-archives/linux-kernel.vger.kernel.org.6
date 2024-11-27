Return-Path: <linux-kernel+bounces-423049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B69DA1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048BF168083
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA480145A1C;
	Wed, 27 Nov 2024 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Unnl66OM"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022142.outbound.protection.outlook.com [40.107.200.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A328EB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687051; cv=fail; b=Atee9mOr51eIB0PSkZP4B3J31HX9uwBY4QR0GY9n+TlofFM2et5eNK9y64ztygCv8ep4vYu4ez9Bba7h3Oy23EE6IrWZZ9qVE6+1y/4Cmma1JC0cfU7LB4AoJUSVKquqEPe2CushWtDaSm0T1dguFFnT5AI9P1kU6Ks9F5P1qaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687051; c=relaxed/simple;
	bh=agJ3OOs5mBm73cv9+Ndkq15XgtpGy/Cxi9Et9TqJdC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8O6XgS0xMbMHLy4l9zrgos1uw87u069CuPTkTVJDnTbdUiahkY0QqvBDLJrWknPcPIduGhyCZk76WP3COrAEazPhVfMeToLW7lSaxs/Qz1S4Z6c4Po55sJCEUj6vwyRrODm0XOnkYEOb3M9Ku3zBjPw43kKy11BJrBZ7lJ93rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Unnl66OM; arc=fail smtp.client-ip=40.107.200.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLKXNIlzW3/xKUurG2AvGg0nlkZqmfLm/EBo4dlhcSbrXG06GSE2oHWOP9JJR6oYlLStkTNmu5igv0dFT5fwOIsiCe2ubhDoMuUQKgcODwoWDT6apiRPb376Zc2zeRRUtWpMIuR/yxqI5mCF80tA+I7iIDnh88dqA3uviBbut6i5ujoJMVfqQAUl1hfUdddY5KKOCSi5iq7Eaye1WWLjEhxFNIcnZWb+xgTorCUelT50a0kHRfjwZiX9yNhOsDERG/I6rUBvSDCz9+5tmdyN1I5XrXp61nm2hZpHsJypGDw4t3XxorJf0bD33gkvVlaNE/favYR0AOvqBRg/h/zB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nTIOgTO+qYjQsnQ4NpqRvMg/QW7WYohWkM8lwQarB0=;
 b=MJtzTxh1cYg9/2ANciklOO9hI+XOWHS0EXn2WNCtH4+90kUO4TT3fI34WE8RKEwrZ7+js7qfym55OiHimPQH+EL+TLnnpsrLZXAJgbLXCJbVVHLgvgmL69/w64foA0HGWhy1NAw8NkH36QeQJJC7jI5AWKKG6dKayQxupEIyGzhe7DlXa+Dd3VxT9s9UGx7H2dRMkxd9P435Pmo9zXg8+/kT181G8xn9L8fvaQiMPcnUOVP5ggPcrocc3w4yvhm6DWVixhaJ+DFsNE01npOLDOiUSPGbeTw+HWxl1C9wYaTKRkArhlATsHmMz/5k5yCHPOMsVAi3YXUCev6yFv6j1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nTIOgTO+qYjQsnQ4NpqRvMg/QW7WYohWkM8lwQarB0=;
 b=Unnl66OMjqc2CluhtNOzSCA+iXqAJ0/9HnsDB3GZv2CN8UTski68PGh5+GrvTdnoRBlI9No1Er48dfGVr9safTvk1Kb/fMd/szP8dfZXvVAK7G5K7j8wfI66ItsHOObpxA5Y8krBG+9amG6Uk2sY897K6ek5DXGpFkuae7unQbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6436.prod.exchangelabs.com (2603:10b6:303:64::21) by
 DS1PR01MB9086.prod.exchangelabs.com (2603:10b6:8:221::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12; Wed, 27 Nov 2024 05:57:26 +0000
Received: from MW4PR01MB6436.prod.exchangelabs.com
 ([fe80::77c9:9e36:e28e:7970]) by MW4PR01MB6436.prod.exchangelabs.com
 ([fe80::77c9:9e36:e28e:7970%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 05:57:26 +0000
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
	christian.loehle@arm.com,
	vineethr@linux.ibm.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH v2 3/3] sched/fair: Update comments regarding last and skip buddy
Date: Wed, 27 Nov 2024 05:56:10 +0000
Message-Id: <20241127055610.7076-4-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127055610.7076-1-adamli@os.amperecomputing.com>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6436:EE_|DS1PR01MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e50385f-3cfa-4b83-2d7c-08dd0ea85538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9os4AcGsU4lf+Hb8jfK79O4yAfYM38pU2a+sMSNUxKeMWCLlBtR5ZWL3vXUW?=
 =?us-ascii?Q?yredHU1sHzDr9j4d5T7+qJZL6YobUfPTdv2pE/0s/ct695bNAVG3mQ/TEJco?=
 =?us-ascii?Q?DEOBNiTpB7LNGgv5kpx9rk8uEMqjYIKADazaMd12AsRdIayobf/o91GzkAA2?=
 =?us-ascii?Q?nesZE0XXjTAV8gTqWrLo/kz3ZDz6pOypWIw9YkZpkFB/fT29LUCJj9kgKgys?=
 =?us-ascii?Q?rjs3TL+nYLeSDqv2hyWgHEQnhxGCDZMzTZ1Ai+uzmktcU/4sxtKWhhV3lRpE?=
 =?us-ascii?Q?XvfMW1oYzu1QAZI3viRSYF1MeDAiyJaiEoQeOnDcD3vOZWCTKjkHEaNNlFi8?=
 =?us-ascii?Q?zGfwIq/Fz8T6gLxcvIS+YJyMeT15qgUvcjhDNnEUHxSOiVqOE+Cgib5W+MwX?=
 =?us-ascii?Q?Ypix7YlKnpb1498yDjCVWsK0xMW7zpRNhDSvuQ438jOzoAXQLP2u5SMc40F+?=
 =?us-ascii?Q?oaau2RjThaceqMDQ5uuFmYUPlWcxvP8guavJ+DBE+q0jVDjthTxUESOUU9cD?=
 =?us-ascii?Q?JN2SyStRtx2Rnj5GwowGv+WrhO5lSq7hd/kdrA0UCHlOug6WEdsCAg8Iz0aM?=
 =?us-ascii?Q?Okr+XqZ9QeE6CNqbSM2g4QGZoJZK24h9G8TaaxcuBBqKKq7/SaCE1aO1dEHk?=
 =?us-ascii?Q?K8vU1un4cz/lqwr1lzkppKWuwGnHD3JBd/F93e1ZECYPNmAP7crvf6b/HN7a?=
 =?us-ascii?Q?L8zimLVef5sftGHaH4mlgIiTT7asQhwRvVpq2gX2eGdzMSQ01FNAzbCk6prk?=
 =?us-ascii?Q?M9f/SW2i3WCS10Snf3d/OGLUbQLpLvSpkMeWBGLThWCbrZgq9EVfqRZwKrJm?=
 =?us-ascii?Q?Vc0LJ4yhU+NgwwKT9FjDaDwxAmICSCcwyIy1OJntUy24LTABu+MElIHZxBZ2?=
 =?us-ascii?Q?OUv/h35dgPQxZLd6Vk0gDam5qTQiXt4CtFOTqIT4zoIGCth60o7juW+yhnPp?=
 =?us-ascii?Q?U1G7sm5BlHN7KdSzbFhdFumfoFOAuZElkt9ThZdFt7DXTX1ZQtW3QJP7XLEg?=
 =?us-ascii?Q?lMrQDz7xrBZdZZTO23sNVtvIMppeAHKuF6NvShWp6/8K8kp9/tR6BgSte32I?=
 =?us-ascii?Q?Dnp5tS3SB0gjsmZDrJRcSqUAF/k5PVyJNf7+mZiYz6D8N3L//UvYfzOaw2lp?=
 =?us-ascii?Q?G1uzA2zIKael2flJlNKl+CGVXX9drGO1pxFKq5KscFYN7L1sz7ErsExHhMH7?=
 =?us-ascii?Q?Irvw251VMZ67h6uFE3o3QTgdRAxdjIxFm3Pf+Lti/Fba2PRHbex1uew6FJoF?=
 =?us-ascii?Q?DIyLkhqjpA6m1ZMlLAxJgWCeLjs3LUqO6rkdSiM3yQRETVu07RCEwljFru+s?=
 =?us-ascii?Q?z75WC+7/+DMq5cTBzcRTrgqyw96rpTmDJ2QBKePMna3NruamvvC7g54bQ/Rl?=
 =?us-ascii?Q?/GJijJX5jgs50SGH6Z2TUjxBA45PWU1biNIWm9Qg/7Km6G4iOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6436.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hZ7uc8rI14aupxEaZttgr0CdFbzrBrr5ko3Qtze+y3kShKPUYVoQy1A7oaue?=
 =?us-ascii?Q?ji9Q91UtnevMpy1k395Vk/Tw7mD44z456BamZwj8aCHXJRvymt8nKrWifEM9?=
 =?us-ascii?Q?Yx/Y5Jx0NwNHguS0MokvIvoKOZj5XL2mtEfpPmDmFknJYg7Ek2N5YgNpiLuY?=
 =?us-ascii?Q?75hQLgLDRR6i5C4JgLuIf/HUrqurfcx4ogSgEynUrU0yxuZXpfdfDP+d34i/?=
 =?us-ascii?Q?URuQwhRTspMnT6XLqcv4QTsdbh6NNlzKSKUDnDHHZLpj0sgwdDsZGy6SYla2?=
 =?us-ascii?Q?PHe4Q5AAPo3vmJKiQRLlTdX/EHswnBdTX9Wk9qCK9iQy6+GevIxJCMeC6rzr?=
 =?us-ascii?Q?VOkV7qNNPMYT53UFr4kCJrH00bGDtku+Ptu1+rW4sBy7RAF2UDJD2baFj3Hz?=
 =?us-ascii?Q?ZB1dGFbQ25emg1hVaJ267jTUr6YgaUf8CONg3NYsc+UOd05DYiBPbZQyTOEU?=
 =?us-ascii?Q?nvlhpuaomkTPjbktzhGs/7HWSpRFweWx+XSSYnthiqJwzfPYa2MD7flAQfW5?=
 =?us-ascii?Q?/CkPZOS3+5Bp3mgKaaBK7QZFAbTPt/uQYWKA2eNJCFH/nXA0Qo+o60w7uqw9?=
 =?us-ascii?Q?WYecUfAaube5C9geE52xMziAPx8M8bnLHK/W5fAZhyoMOznbHiknEpmEf0Xh?=
 =?us-ascii?Q?hEVc+1kC2uTHlN4EI5Q49FLNbJqWJTtQ5WRRa+8cKdqiZshBCMgSy4czVPYa?=
 =?us-ascii?Q?DedVXz5JjkHvt7vx2x58FLDlgwVVt+Ed6q9ihik4Hl4wKq0dytZsjBWeDzDw?=
 =?us-ascii?Q?Pv2xCrQIkMOE7hHzLV9VmJsAf5zF5rm2UceiUyqv7/A5VjIpmPvd72AKsZzA?=
 =?us-ascii?Q?rmmc2D/z/d1zFXMu1lp7tMnI2qMAyrbO/189+Jp8p9M2l6SWbmwQnMEgBzmk?=
 =?us-ascii?Q?dcS97fhQt5dfJk8iucZ0PtckBG6mLxTgve6vzB4PhbHSDVGFxfqmbjvshgAA?=
 =?us-ascii?Q?N80XTsFY1xRtZR2fn0mJN+LSaFA13J/U3ONDRJNwqKephNvcTF9vHWLUuzgE?=
 =?us-ascii?Q?6MhxekxbUeAFopL9SxrcI44mMx+KcwAXaTJ8Tj9HgM9nQfC+rCjGyqlLFVo5?=
 =?us-ascii?Q?E6BaMgmR2WSbFK2w0CWlpB3zzeTLIM+KJCKfw+f5/9SbMsRqMw3cHSP8YQ7x?=
 =?us-ascii?Q?RoYnBDBebckdOoERpgl1AssK3A2qfIV4+C0k0YoMDRVxYvpwpkQ4SSV28ZaC?=
 =?us-ascii?Q?AuNhoBulK+p56okKgIc88kBAfZcfct6Z4/tuDjvJ69VdGqQE/eKjj2q14y4T?=
 =?us-ascii?Q?dUmBm0cD+zi1/ZzXa73tq/bZRC5P+LY12/ImczAPcsmlU9vGjn3AJZVRQZfn?=
 =?us-ascii?Q?Wh1udxFK95yRZZmyBZhQWk+GEVLFHVV4xdxqkq27/du741AEMO5+/X9ZzD+p?=
 =?us-ascii?Q?hxmytXOnXJJ4OA3x4Xw8P/mapwiCp6d9vVmMjMohzDqLoS5/Gt4dA3NeR9Fe?=
 =?us-ascii?Q?c+1y/8eypDjTad3CbJz2BuOEbIRN1Wx8vqth3dokuFgRgmVqMi90NpqJOvOv?=
 =?us-ascii?Q?IK5rXuTVvKGPOGiHF6pBOUmNprH/mNr86JyAv/P9EnvvhehmXR5ZV8u2pWuS?=
 =?us-ascii?Q?G76YH6SqKkKxwIf559pbbPzCjnoUu6TWzKhAftNTkJUxXg8xhr4zzUNTDvKZ?=
 =?us-ascii?Q?Z+/wGR/VDAA/QcYb550pCok=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e50385f-3cfa-4b83-2d7c-08dd0ea85538
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:57:26.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOmEiGYsBsfuBirw7+yDW3j0hw8Rl6CILvF1eHkZxCmHXGJ5GPHkBzg65zFduS+GdkQfOxkFxVqeETbe9yDyczvSMdi9sfCLBwApTyMaZ789KeinZU2a9mz6wy4mUp9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB9086

Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed the "last"
and "skip" buddy. Update comments in pick_next_entity().

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 kernel/sched/fair.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d5a3b5589e4e..259c56dcdff6 100644
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


