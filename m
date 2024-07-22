Return-Path: <linux-kernel+bounces-259227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 230989392E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4F8B21C50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889916E894;
	Mon, 22 Jul 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iAcxbCde"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2029.outbound.protection.outlook.com [40.92.18.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFD16EC11
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667607; cv=fail; b=PR3KqenVzPpotEI+U/BgBQougj79za/QCnFttPRs9/R2NQ83GczMbfyPenQqC024GCoFalWQ+0uDCq7+YbRcbrJGK5CnvvgmRk2ZpenG8YPTw1c25IIotZZ5FRWSRrwtb05MmWVJVzPsNJurp1M+vXu+Z0Sa6GGoV8qVAo+kqME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667607; c=relaxed/simple;
	bh=nrytk0sh2Ubz8f5S4arvUuQiPcmVZV1fq5pk7i9LBzc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VjYVZ7bOlvCQI6y3BQlP+62hiHZCUtXxSzBXcUwF1AVLjZcOZA+RkrSLHUfsWQiMb1y7yButUXad8bbcwRSMoPfDkkcL1P9FQu9t11RItTpsSJHdCqD26CgpWAe6Xz+JpXS+uxmDGeJa+nVXKLToW7rhvVQmonuIVPpBaWX9nwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iAcxbCde; arc=fail smtp.client-ip=40.92.18.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR2ezFZAUVc7alFuRVyXUGwxON2jOhzvhJRHNOEDeQOr/bDgpTGzVjBPuNRg3lrncVqP6KbULe9kUbud4q3uEq8HT3pb21PT9xp1HLMmggQHhZkO+1Om5qJCZPeEeU7KaB0r5DHaqJ9XarsdDuW1DlS3Z5xj2sAUPueJPvGkGFoYKVhpWqx6VfWC+7ntc/YtyFl4HM6AYjpWKBF6enSkN3oY3gdrSKc9yifEu7wyfC/ahfSv6s9t1LLQKsoDlRWpeYaNbz2zqUE0++wgwSx/XFMODYcsfXSOJ5+V524pORGgEdC+bpB3BQb1ZxWiT6wiGL/EqzUpiGwm4vf3OneWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNZVcLU9xxo4zvrhjz2WqVI5+l+jt5DG+O4xSqwZ7po=;
 b=uahDjCK4KUXDRCiXsU0rTkHgsHbT7toYKFc092A84Aei9cuVVgr56rH8WHDhLDtenHGi8zc2DeleyS+5Na4cnIxUo8V0tZVyCT+yxqlah3c743Qe449SujwhfiwX/3Gy+0JRAxVISe4tHFN1aPF98APLWAyTjv3tny9rAlVc3DW0nMEm5CWGUKX+oKrpV3syuAB4jNMcKLZi2Fcf/aEsW22uY/Uo0GWfVYDws1CGl+FPHuAb7gCh+hF0+vzaUwSDejwQ1pMHh03ABqR2SwOPXvvdNmjmWE1dN9aJE+CGHavt78J0SJY0yhYsYZECid6ksIuLFNyeG8JgKmx9OME/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNZVcLU9xxo4zvrhjz2WqVI5+l+jt5DG+O4xSqwZ7po=;
 b=iAcxbCdeq6/i/xWLn5lQa4JX2+P8p9GS0i/1sqpnQuXJuYPqFG3XmzdUy0mtHxiabG39eztKQumulnF3ZNxN6jrQzVzWDZdhLU8X38mdynczf1vENAzEjShf7MSWMILRO13K8yi4OkFMWI+cllJxpz/RZJ1YJ6O83+JarTJc9Bq2HNkWydOCetYItOkS3h2p86vWZlxgnXX9911IYteerlhiPc7DSilcZVNlXjFUY18DGeJyxGGct5a0ifGvrv9OTWD7wrQMp9TVyYNUH2kZQDmqYTElzRWNFdR+TQH9byO1L7dcbn4M88p8fulG1TL+ahDchmSN2wsr4ukHZqLakA==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by DS7P223MB0405.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:87::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.30; Mon, 22 Jul 2024 17:00:03 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%2]) with mapi id 15.20.7762.030; Mon, 22 Jul 2024
 17:00:00 +0000
From: Steven Davis <goldside000@outlook.com>
To: gregkh@linuxfoundation.org,
	christian.gromm@microchip.com,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH v3] Capitalized "c" to "C" and changed "expect" to "expected"
Date: Mon, 22 Jul 2024 12:59:44 -0400
Message-ID:
 <SJ2P223MB1026B72D6CED70A91E8E55CCF7A82@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [No6sUwrEeAeQgqg9snumeww9qNcZBE4e]
X-ClientProxiedBy: CH2PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:610:53::33) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240722165944.1840-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|DS7P223MB0405:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c89f3c-507f-4e0f-49ba-08dcaa6fb909
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	xd84p7Mj97vwub8A89ruRkDyGzJkxufw6zebkmDXKC5kY/8JL+pTtsjRy2PAx8a56I8myJg4gyg7TQrpnplKqZgRMwoY+0+Ek+wJUoto8wiQSKHRxK5zOvhwjlYzLFfsodp2a1yawx/gakdmml5vr+RK4oxHcH+/suKOgbcXlLXW+kP4Mf2yX5S3ExZLDK3BBTXy4K98QC7ujBI01OrjIhn87GBQN+J/I8GoD/rmq0+1GWkXw+kjwBn69vQlPObBWeQ7qVsQgWw9G25bXHGd+6MHk1mglOMEr0FEFDkIwlO905vaqGlAVDI3pUSohJF1tquAbeI2m4BMq5+oIhKq/HoRXQkI/Nm1aCrjeViKhQjxBTdDkJxqdrhuA/fRwUs7xX1H/x/m8iVRgnkxIZAPtGHpVzjd4nygkVIUzGYACgsnAo+IO6K5e6JeLRWjXohrFX95G1B9QC4oYmhGrTCyn0EORjMAr2mUr5bD+RfSLCEYjU/+l+qmSvmpuU7QwXaLu5A/Uk/2vL7/VdA98dzKqIa/uqDUZ7UvLihCYFlWj6nPxBck1zaACiRXAaUYgMQ+2ABxcB8MDF171qIYHzrvl9DKgCc8VXEyJzrE/Qg3REg5yU/zu18IQMHyo7OZ8g0RZ8SdclebkADTUAK8Blu2/d62QoLXOmJpGJJ8C1uK3uuRhFN0TI5UYnUUC5zWQ3y3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uyOpUopjUT5eXcRPdit0hnzLdgRYnqSyK5/x5UvF8GKniCWTzekAbzWo/TME?=
 =?us-ascii?Q?ZZngoH7bGzGuyf6DPiK3QVbMCsKzPz3ewDTizkeafPZiYCJEHrmg+ef/N1bs?=
 =?us-ascii?Q?oax90Z4uCt/M08Oid2X1v+QhWZGFNHsaacH4X2pi47pNDhn6PHMHXQPnbIwC?=
 =?us-ascii?Q?v2i8jnajTuGPWPbPIBSxjYVw02OTwx7d/e9TKkGJ96q+88tZJdoTz9yu6BIm?=
 =?us-ascii?Q?HZ2q3e6/wWSdKyJB6ahtF7oooZkT7ZaMif7KlV5w5tYqL/0FKMQBYmxeCjB5?=
 =?us-ascii?Q?0T9gf5kihv6Nn+UZ1scrWWXpwJI76K3R83bID5lVIq6aX8UKcc/qLODamlH2?=
 =?us-ascii?Q?NdAMiNx0+UpRuzxbbHPPqoqC5G9qppzNZyaDLnv9owwkBoZqedBzUDMz0AT7?=
 =?us-ascii?Q?24ujCOW+XoyPqALRC0crJVraT2Uu8zODaPVfXtkQo5DoRwXndJcUtFBZQify?=
 =?us-ascii?Q?5UJwxajQ7PvJTTy/Ssvh/mCsOpwIGn5BAhwNnGGgjoZyJJ5+HqqMU066oU+k?=
 =?us-ascii?Q?oL3Wsh+IAQAaRZFnQHmW4GlNZ3z3wqFoFsdzq/a4XWC4amI8VIisFSqmKUQ/?=
 =?us-ascii?Q?NfIDLQLW8F73PHZpYbcLe/gn4gJV3R+9rDMUr+Z3srymuyo12ti+u18oWWkW?=
 =?us-ascii?Q?iV2Y47fFU/Xj1tElr2i6Zd56TRKfqeg+P3J99XH6SnI7xt2tmmfJEBCVR56K?=
 =?us-ascii?Q?e0QgZGlhpJkmIuSR+l0ARNq6rlL78tlVneyMEmRJJ6ofBZTdIfoAuctlh0mY?=
 =?us-ascii?Q?WdaP9RSZzQqSkvRXUs7sIP8VrEXZG+HxsduVaSJBZc7JSmPw5a0ryXcZGxWk?=
 =?us-ascii?Q?Mwq2aZKNz5cvAP0zZL9RgI2IAtmcQvcJa9qxDc/CHVX9VF23Vs9Add9awbnn?=
 =?us-ascii?Q?uV5nwFJ0e5meCzOOimHmac6vEOhGfFXMaifhaNYx3Lxb2YLeh081hEv/wqsj?=
 =?us-ascii?Q?WMdoQYhdUVos17iBEZA57WPVZ3dihl/FqUQ7UT06hcPTSOK0SOf/b4F9LEgE?=
 =?us-ascii?Q?LUVSASA+Z46wtoGjtFyMW2dGxF6J+uxil0ml+jwP5bSZE2L450us96qMYCB2?=
 =?us-ascii?Q?weDDBWm9SXyMYbOnBji5ENcKObouoJDw886oS5oXIblw1459MC6iD4CzwiUh?=
 =?us-ascii?Q?dm0Zu2nMIbhJZGJELyp7//thilZddSmfptYA3LCKUSmRPpfCHK71P9zzKaMo?=
 =?us-ascii?Q?RHNqYf9ZzmLGJMhbZ4tI4H6o9Ejf7kz7elI2XP171TAfA5r8mMTOmm1kRS7U?=
 =?us-ascii?Q?b77o78ZICUIj4jzlfWRN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c89f3c-507f-4e0f-49ba-08dcaa6fb909
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 17:00:00.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7P223MB0405

This patch makes three error messages in the driver easier to read by capitalizing the first letters properly.
For example, "channel already linked" became "Channel already linked".
In addition, "expect" becomes "expected", as you would typically find in an error message.
This patch is necessary for improving user experience and the kernel's quality.

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
V1 -> V2: Added a patch description
V2 -> V3: Changed subject line, removed apology from patch description, added change log

 drivers/staging/most/video/video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 6254a5df2502..2b3cdb1ce140 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -454,18 +454,18 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	struct most_video_dev *mdev = get_comp_dev(iface, channel_idx);
 
 	if (mdev) {
-		pr_err("channel already linked\n");
+		pr_err("Channel already linked\n");
 		return -EEXIST;
 	}
 
 	if (ccfg->direction != MOST_CH_RX) {
-		pr_err("wrong direction, expect rx\n");
+		pr_err("Wrong direction, expected rx\n");
 		return -EINVAL;
 	}
 
 	if (ccfg->data_type != MOST_CH_SYNC &&
 	    ccfg->data_type != MOST_CH_ISOC) {
-		pr_err("wrong channel type, expect sync or isoc\n");
+		pr_err("Wrong channel type, expected sync or isoc\n");
 		return -EINVAL;
 	}
 
-- 
2.45.2


