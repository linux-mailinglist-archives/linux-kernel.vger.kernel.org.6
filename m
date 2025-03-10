Return-Path: <linux-kernel+bounces-554103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16550A59303
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B6916B5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E422155C;
	Mon, 10 Mar 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="fyTK8Gok"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2092.outbound.protection.outlook.com [40.107.103.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16290192580
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607249; cv=fail; b=T5wXQEnWTgd1JSQxQHhKpcGdyfha63STy4r7KR1a7PePhPAyLXAJzbw9fvnu0oG8XtMAQcgT876JBlcqMVNeFk5IQ+1re2POq5wGB3pPJ/aV8b00YUKuYKw6Qqr2VOc2KXqJp8iQnmOCfKeewV2is+u/+4v+rmv62wyxFXyY930=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607249; c=relaxed/simple;
	bh=Pdogpba9v8kMZBH3mI4Xjqvzk+yJcFM6WYk3eOuLcyU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Jqn7lNb70JymcAFZYeOaL8rKPP+/xrhKwn1SNVZwW0YusOgkq2JOkwtDMg+HGR/Jp0uFBuBDpPWvV5hiveYk4vYc0RJjpeNlZ8IBQsojYXaXgS28FHx0Wj4856LMpMKPfJQMxXZswmBiewB1yl4GK3aNewnvVfcxkhQUHPYZS7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=fyTK8Gok; arc=fail smtp.client-ip=40.107.103.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=int+H00fNEED6nrhmEtqmM6NPBSqCFPm0u+pvSd2IdepFvE76txXIMHOKvHh39MBRhcPT36qg2Rf6I/3SqYhpxWAGaNrPjsB2wHOXQiiLB1hGw7cvvcA+8Qp3DrxZiBX8FH5JYF7edp8G04rkH+K3V0StrzDByQLbH6nFRMShfghH0sGSfwRcP6sG3XE2oRzu+pgloUjHqbkVUz0z1xDv20vvUfPMqUHqZrEzx3cvtVs/oEBDr5Zuh4Oz46fMUnWxmZFhq0bMKDtNqrqOFoF0lNV/vzjU2S0b4aEEtuoNgzOMH2bLYDIwmO5gLEb8y4rR6qfrUJG8jV9tJAEtEX9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRkznMVwKMr/MRI/zdh5H/5rm3sqxmGrfXVIHlWszwM=;
 b=SLpZeJkC9O4JBtjonEXT5llnOfTaQ6BOep1ZChmF88iNSoYl/HbVV7PUZKxCaJ0b/9GxIN/yXkMv6sPn90Q2yvQCLU/eJVYTg25UMeyhpTfCyzfbFXeAUH5s21iKvsS5wkaITtAyglcAm3OCxiuk5hpeZUhdZo7b0KeMtAqVEsE1wmj8fdQC+LOJ32IvoO3SbPgJshhiWroJRSb6E8iKnl1Z03N7rlXkWYwhuTY581SRD4H8Sg5sj1rWd4PGUSwGdCTQ+eILQtoVxC5Ea/Y6KFFO4yp1BmcVI0fXHxSFfs7tvdXh/o26RQacago2hRfQecqTzLvwkbrv4fow08m1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRkznMVwKMr/MRI/zdh5H/5rm3sqxmGrfXVIHlWszwM=;
 b=fyTK8Gok6O4G+aFDIZxcnmPcvfsp7gUZlpvHiKTT/iGnWOgtJAWKHbMCK4LpP++BfX+U54SSlANrnOq76RrLcZSBdL2tR/zRV2E5aJN2Rs7hkhaPSFvf6B4ETr3Zv7mRH4laHAMeDG+i28PtvmnFcwgfLv9e3cAUXji/BCfBQbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by PAXPR05MB8894.eurprd05.prod.outlook.com (2603:10a6:102:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.21; Mon, 10 Mar
 2025 11:47:22 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd%4]) with mapi id 15.20.8534.018; Mon, 10 Mar 2025
 11:47:22 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: hughd@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH] mm/shmem: fix functions documentation
Date: Mon, 10 Mar 2025 12:25:37 +0100
Message-Id: <20250310112535.84754-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|PAXPR05MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ababd03-e499-488a-c0c7-08dd5fc951a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3qKGt8uk+vGrQF4FTMhxbeZDhgEYZTEwd1dcBPc8+e2vhw8HnpOk3SAUkChd?=
 =?us-ascii?Q?bmZ36TEVRGgXZX7b1l+t1slAp1WPi26XmOgwutB5sxNd/Ub4XwMmQbp+W1rQ?=
 =?us-ascii?Q?dyZNF+f5BDCutYWWvjaXRVkRpRdCxuePG94zoXnYP72GxIMY62e643kwGJbQ?=
 =?us-ascii?Q?R7gROwPwIbbk530DQ3qoo5HOYUWVcPRYsGEu2xEfy6VBDfzkVBvF4TwHRn3B?=
 =?us-ascii?Q?Z5t5YjWzX+EVLy//c43hniNzCmaCkccJv75Fs4nMEjpUd0ffp6pFcf98/qNt?=
 =?us-ascii?Q?Yh5rAN7qeNwwEBMlTy/N8O+VHOsX7xjhXZWe5Br8AJiejqVTe5Zd99lQMEJy?=
 =?us-ascii?Q?MwLhOI/gX7IUnNCWB3Ld5Q4bjQw3jxR++3yTcdHTFBWOIAD/98QjGq5Ll3sB?=
 =?us-ascii?Q?v/B1h2bp/UrY3QWcsnLVftM3ep0xLGCED912lTvuIXj+7zfO78VjeCfdmnB5?=
 =?us-ascii?Q?eHwVS5ChDPQnaQMTky2Hy3gSktCwdYqrTTAeSDr78gQDIVHdNKiB87ilFuCY?=
 =?us-ascii?Q?fxTME0pKmJsBT7Cn6m/+M/sm4nUHe+sb8FptyNsPMPVVDYBPmHds50SsEeJZ?=
 =?us-ascii?Q?Chdq79BcbQLCtYdn/+irqaJp4GQgDYKnP/puh+lpM0aZfW0Irjee1boIP9Fg?=
 =?us-ascii?Q?MblBbyUmsihw1G4u4Cm7xF2U/i+bI5G8aFvb+qWcIzwnzST+xGr8zVkPCK3e?=
 =?us-ascii?Q?RGNy1XEKHxFSJCcM1lq+dF9JG3KTTmFaxOocB85MrW6j4xp/67G+tpXUqmv+?=
 =?us-ascii?Q?Sy6NAbXL4yj0FZ+w0HgVq45Y/+yRieWkcMD/60p9q4SfoFW6w9/OdxDeK7Xn?=
 =?us-ascii?Q?oda2iSCH4IAYVldaOXZE25cmqAwmUrZTzZfzmWkQZAAOtaSKPHP53K1ibVda?=
 =?us-ascii?Q?+r6I06jN0GSpVgqPPLeCTXUJBOzSCYnJNYgyhBQOMiDCvQXG+X0K0Fh+PvfL?=
 =?us-ascii?Q?8J8rVyodBKx6PMHAUkP5DoKpRekoQmT9Y45/rlloossBvjvaURbJeFGyXPDQ?=
 =?us-ascii?Q?68XXHzhpOkvaUn6mEGYCAexDhyz+DYuz9CpkqGKN6kthQKxVYklKgdQNMffl?=
 =?us-ascii?Q?wkDLoaPL8qBhabrMnNcBG7Zd1LnYQ7gQCd1qssGnrl0l/AWwihq1vTSH/gAw?=
 =?us-ascii?Q?tX4qok+uh4zg39cL+54HXw0Va4FAfGxxRtfLkQ52FAzOVpEspwEwMJLrKh9A?=
 =?us-ascii?Q?oJTIvNA76/dsTmEEePdJu9z/F1m7L1RJcNUjT+QJTMq6YA++4lijuKYjA7vZ?=
 =?us-ascii?Q?OtMVAtDAVGrcMZpIkpR6t9X6p5OIOnbJ5ls7Dq2ZwtKcJd9M7r9V2xxd3KMH?=
 =?us-ascii?Q?M39xsCqp8z3lacc6vNO8RyCt+OnaQwDcMGDdxTR3Ak18BlfxZK3AaVgT4sAE?=
 =?us-ascii?Q?bTkhr04W+S89vMgPWvMBoF9DVftq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tfrzrq5Dbyfq5DaqZ11JvG1KGA9qEKIntkSQwUsvSaKG3jJNENleKtbpPwdg?=
 =?us-ascii?Q?6hQwr1Xlip6dsRr3JlX4K2OoFlLQxc9x21vJ1rCFkXfYW085NvuoiLWcri/r?=
 =?us-ascii?Q?VAPuinfY82fmpNBWk2FqGC8kUGgyaapedQz1Xq9hxzzH+egiCOsQI3zh6uLc?=
 =?us-ascii?Q?/ePLxBe1FnP9j4P2H/+HDet9HX56GOkG+ze5O2BtudeXhj6bBxKpJHBJ2Ltb?=
 =?us-ascii?Q?j4JNl3iovsP6gbg0uO6Y5qMlXi+iczeBnywGqdv1BmvjCEQzgP7nzR9e8JQG?=
 =?us-ascii?Q?LyAOoibfO7/GUDoV0Jkv/Mf9OV9+fT7td874F1ZRHmKU17ZB6ugl4stQc11h?=
 =?us-ascii?Q?tgl7t5h9XfTOG0gh+MgQ1LPYEoF0d3Q4IXRj1w/ZB2ek1GF7oy+f8nKZn81e?=
 =?us-ascii?Q?7x0kdyJDu1CJFhMkawEjmylSMSCtApg1MrFSqR/DzvJhj04txiNVKCp80JnC?=
 =?us-ascii?Q?aIsPuuK9ZRc0M6usQguq4HsTuE1S8rA6QYRaj0EeBUXLMXWtZBUpHkx/iXG7?=
 =?us-ascii?Q?zPA1UH1rufrM9hhuf+IOpKfanVIRQVg1/YfvJbpIwH0rnNkTFRQSIe1r9HYs?=
 =?us-ascii?Q?+fb3G1cBadbt3JN7VKNr3SvGSRp+a8G2dhYfkoIwSAZ3bAZXLVfNLVeHiSOK?=
 =?us-ascii?Q?hT9KHJFNx1WYceDYa9AthGRiJn22y7AEqyvhAuiB0D9FXIQq/aEQQ3i/DqMt?=
 =?us-ascii?Q?VYqBYxiEUiy8/nyL6qJeIrjtbykfVdX4+Yx3yJVpx7Wb8s3LfBxHNb429yUR?=
 =?us-ascii?Q?W31ScJWH1tAW9IvMtCPu7Cs8+sXxS5DOeTweYFKzc2pwx8ePi8xpERwXU6CW?=
 =?us-ascii?Q?E2lTq5jzy1h4eVm006ZZzBHLNEWCIOndDkf0FhkqGCN7SwxmVNAN6yIboV7I?=
 =?us-ascii?Q?aY/s7xyr9oqSugapSC+AoNn4ytujK/OvpF5q/Sbt0EZFtb800iz2txPSOL/L?=
 =?us-ascii?Q?wxdoIxAnl1IsI0OXrKPT/8qoQxAOlo1BottunBmuEtzqR83sKRkIpPaLU8SC?=
 =?us-ascii?Q?uZ/MEqCAL7aqFZUtvwCATmQKN6SbXz5nVcK/hFOJVaLnOSOYQy2VjxmsekIN?=
 =?us-ascii?Q?e7zOdbqeUR3Xx0lsaOlDXLyopqRIclvgS/FOAYVMn/NgI3gEX7gQbfvnQ42w?=
 =?us-ascii?Q?2dvIn/cH0ITdVpIrKYrB70RvMQJ5r2ydgPPess19zi7d7aWnmkGQl+kv7r2f?=
 =?us-ascii?Q?vLEHTbq/sDY1iNzNzwiwp6VU4aSXgQ3haibJj0U4ZAZrh+LHUweqBjUomo6H?=
 =?us-ascii?Q?24lIx8O3DnVYCNwjmWkpABk3+vDGeVew8z0DfUwifbKGB+NngX68E58hLsdT?=
 =?us-ascii?Q?j+Hm3sVXRzDUatSzQaEtTjPD+N/SUO2AVfQxlQ5eyRRV7xCOmO9cVVMrhd72?=
 =?us-ascii?Q?+ERXghqElpQjiO6HQbApQEFiRJYESnLUK5t15BA1ZE5Op9Urg8DE6pz/Bl4e?=
 =?us-ascii?Q?iebwPuZx8flyaGgxFshJGiXtu6teETlRwqDusmSrjhRTlQV0K4ej9HR0q3Vf?=
 =?us-ascii?Q?2/v4H3ZR8y8X2+VEdwyFph0ZlLHG76hHT/KpuxP99fKOxl/QQvhfnSbeih08?=
 =?us-ascii?Q?TeCbVuSZaKMCj7kd4Yal31RlcUMIkC4aN5XqWkclBZawyT4ThGgZDYXWRMCp?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ababd03-e499-488a-c0c7-08dd5fc951a8
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 11:47:22.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cGSGjzjPyg2UQfcwRenGSQcOgaYz7/U8DlO2m3/cCuQwsu6OTSbHqMCZTGdsHWOqt0h82udEh0h7h5yrH2cHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8894

Add missing parenthesis in @name parameter description.

Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 mm/shmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a8043..e72dbdc0b180 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5830,7 +5830,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
  * 	underlying inode.  So users of this interface must do LSM checks at a
  *	higher layer.  The users are the big_key and shm implementations.  LSM
  *	checks are provided at the key or shm level rather than the inode.
- * @name: name for dentry (to be seen in /proc/<pid>/maps
+ * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
  * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  */
@@ -5842,7 +5842,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
 
 /**
  * shmem_file_setup - get an unlinked file living in tmpfs
- * @name: name for dentry (to be seen in /proc/<pid>/maps
+ * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
  * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  */
@@ -5855,7 +5855,7 @@ EXPORT_SYMBOL_GPL(shmem_file_setup);
 /**
  * shmem_file_setup_with_mnt - get an unlinked file living in tmpfs
  * @mnt: the tmpfs mount where the file will be created
- * @name: name for dentry (to be seen in /proc/<pid>/maps
+ * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
  * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  */

base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.47.1


