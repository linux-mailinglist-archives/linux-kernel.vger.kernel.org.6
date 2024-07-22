Return-Path: <linux-kernel+bounces-259194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE2939272
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E11F2241B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38CF16D9A2;
	Mon, 22 Jul 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rgaoOZ+2"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2064.outbound.protection.outlook.com [40.92.19.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33202907
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665452; cv=fail; b=rVtqt/s7Ltiws5gm1AVv+jEKXW0Vfzino0gwXBXQrnyC1OhaevgqWd6oIogDCmR9uBuTi4jzrn8s5yyvNsNl5lb9MAxGt15dnRe73Rmt4YV3k2BFEV6ky18iTW9VPc8/aj2PSOMcpc63ngIFpCweynTVP0ukA+c9dZygp4aL1ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665452; c=relaxed/simple;
	bh=vCTylMkyZIb+TFtVY8NPhW9np1EkN8cGPWVQQfRLoVU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hrZyTWYLNbAG+1qIyscMAbrg3Bf1XHC20Ji3y7kLbdREhByA2cwDo4F81GNlidi8NBCpYkclDSIwfDDaA+4ToS4t4qj1NinAPoro7qPsWKItjp5yLCZyXXATh57MvP0bVBkY9n5IdiXoFeT2QclCQmX6AI6QOkoYinA2GTrgikk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rgaoOZ+2; arc=fail smtp.client-ip=40.92.19.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sya82I+0CC8U11iuTVYI+3mN9Vk42nVz/QdYEn/5F2AHzhEb8IjPOiZ6e/2ZRci9P0jCkRVI2HCbtNO4G+XqTJxBmaLbspYfHhTr0DiSPGjFBrhVUd0v8h0hU4UqVIKZhlee/0nf5LgEIOn/C2jpy/OndnkSnSz99XtX76UlthnRbs7lS6Nv0WMod9QGhlDKW5HjZ04sErW8xJ/g86bjUmsgTdWMPV5+NiyYQlaa0Px0qNriS+FKA7GGtfoPCOIQqrSi+JxJ2+TEDI1HEWDmWawbKSSMWlsSL9FUOgvK0hj3PCgy4CEC4T3I74WteV3aDT6Y6omKLoCjfAKiTp9Z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DssJ7a7v/Le6TLjLls1Y3R7wu7tOmpc23dDjyz4pzaE=;
 b=F5N3nQ1tF7Na/cjKW9VX4Aih+93GMzYLs5s5z4QDaU1SWqnjLFS5X/BqqJxDXopnQmSuZwLAFfe4e+WtEeoMMr/IWc/GlLAJLis6ZBJOl7hDp/v2Jb8wVXKLbvFw0N/an8KRpNDKKZJp4mEc/ocbQ0eSEQ7n48UfIwtkHPVR7S8nV4+Na3DQxy6is4oqa0Coclgqq1EonUFOsr4ZZPCvvlskRIGmyzUXSJE/9hXTpw8zQmU5hBo6ewIpXZlmWdnda/whh1tepQNtktg6E1NjtgKi7rZpf1Q8g5ADVtoLnlymaWkPpaa1F3vbqfiaVtJnUohv6MtkZckJLpMURRLJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DssJ7a7v/Le6TLjLls1Y3R7wu7tOmpc23dDjyz4pzaE=;
 b=rgaoOZ+22vQY5bvenJ74icUGP3rKkvhBrNYtr5tQbfpo7AKFzB0vrnxqkkMR1Tge97BbRHs93/HhUqMI7pWcUhKftNXRPwXPKnzH066yPrMzm7to8AEga3i5IApH33ldmk6EAt3Bn0YelypDy5+R+Q011xQ20Y6VmwH7ayQkDJEnkrKfDI+SExTv2PymY5GdH5PK/gHZ8c2Jq8G39FqgEVG8sLwh7+bOPLAbzVcbTAp5pq/KEEFAl0oUr1z4wbZJdYNLrhrj/ksFIvWqm7cq9Jz/HAFNwhKVS4J8GSl9vfRxUb0QK+5FF52HAnzPLlRA+xKX7/uPB7YEFe1ZtTuDcg==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by SJ2P223MB1080.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:590::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 16:24:08 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%2]) with mapi id 15.20.7762.030; Mon, 22 Jul 2024
 16:24:08 +0000
From: Steven Davis <goldside000@outlook.com>
To: gregkh@linuxfoundation.org,
	christian.gromm@microchip.com,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH v2] Made the error messages a tad easier to read
Date: Mon, 22 Jul 2024 12:23:37 -0400
Message-ID:
 <SJ2P223MB1026A88F6556E5CCEAE52065F7A82@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [OaI3O9oKdUZdS4tvWMhxf5gzqgKONmKG]
X-ClientProxiedBy: CH2PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:610:58::27) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240722162337.1422-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|SJ2P223MB1080:EE_
X-MS-Office365-Filtering-Correlation-Id: e35fd75a-526b-43de-6cf7-08dcaa6ab60d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	6QGiM3WKx+gzJHEFIwvnWNrfsb7qxar4EIjNIvkSV1N6/jqsisKufo6chpGH9+Qttsf5xXES9hDbb6O/LFwvqCTbLiES211fUGNyAiHhOldtr9ZcchHrlbqogZFUadKJY2K7sUO/kFe7TD+Nl90k6z1Oc+qH9yYpXmj4hUYIzQYpdytGvpZhhPLXnsnU5tPcc0EUWjoaZremhWwxdJhaOUO2UwSsjc9TbRqy4xPs2P7BUne9wvdT41Kik6E9t5KYR1DD5CNCBqmefCma8T+RXTteb4KeeiFd5Y8Q9ZWofkbsq7AOOb/siNPU6VfSwDuO48/pw2usTiBwK8mExeJz3BnKk/KrhhMRpkQaEwmppnPz7/6J9IA2tvXUjVYLSAmaSK8Hw8ADRl30yFd4GsHC7AbKNupakN518pebBV/j6GxBSNfPokEaX7Ss3fn96tgA1yqmlDuAiA1+cIm9Ldf9xpvsRv/PlYkOzrLzNabBQije4uLsv/Qkor5VbYLnV8Z9/uX0kRi1821FQGd6wA96jucusI2kY/BewGC+lhyd4HfVvEoZpB/7aCrXMCL4X7WlkQN9f+jcYRMM9l+Jaleyb96eHrFjRc643UHBHr0peaDNPZzWrIrMOLVInH70Aa6fLrbdEEZhu78030Aq1AJdXsm2JS6MALgrL/T4ARJ/6Zt7fofSL0dkIM1LNWc7lnYv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBfZHguzYTHJMXd0KkBCcmFZmETTvnPzHifiaPScwn3+I2Fu/w+Dz8rCyysR?=
 =?us-ascii?Q?YVdjPkydDzbVKPNE7pRTHf+EN0NEztjVLQ38+Q7B/mcoY/8+vHd8kjz3u5sN?=
 =?us-ascii?Q?w1ZGTzddC4rC+NBMJgujiuF0izZRmy2jMUFRuf61POgPnFU9Bvtlps/b3SQn?=
 =?us-ascii?Q?rdxf/4pDKLFY0ETNclG+3nxkIzOB0qFGoNmU5O5pHKGPD0ADTefjDrlKWxNj?=
 =?us-ascii?Q?xJE+iPKJMwAiVNeksi0MLRzYTtUKcoTF6YVSnGSjTCEEfowJyFM+1tad2Q2y?=
 =?us-ascii?Q?7gMiyp812djyrG8+d+QU9uvvoiy62b8hh8EiZXT5dRO75zaLitcyjtorQaao?=
 =?us-ascii?Q?+6/AWCpqrjyOGpzO0PTyGibNkAxtx4Hk8pebHcN8qzKzsxu/PizFxoSV1Ktp?=
 =?us-ascii?Q?JdeUfqlXDmLQF8YuLFkV+lxGD2M2tE+MG6LuVQwKfJ2dU1D+G4u9mk900/oE?=
 =?us-ascii?Q?9ue+elgwbYyzg8T2fyeCoANMwojZYld+XY0pZN1+DIXF3QfHpaWGCHVs1+jl?=
 =?us-ascii?Q?wK7bpV7Ziv5Jq5/MeYgV1Qjn0+vvGFVW5CnPtoJFmBeWBeYpDE9caSCF3FQ9?=
 =?us-ascii?Q?vKpQwmjTf5J0BCNk11p2j3SmwUIomQwUy2sCNamS/X7PH9b9RQGIUvxuw1AL?=
 =?us-ascii?Q?5uK7NfY3vnEH4J9x0zjJXi8C8TX3GDNY2fQneb9YK4r8ADczPoo/LC3DMtyi?=
 =?us-ascii?Q?XXdCYCtJqvPLRsAghzmlXjYsjs5qLeSptfvQdltfuVILMdaMJE2b4V8tDitr?=
 =?us-ascii?Q?V/mmgEPXijh4mxvX3XVx5l8gHRsGlrT3l+mVypGXgNLiT0CsdwgwHK4wX0pG?=
 =?us-ascii?Q?TVWG3aRXnQdwn/wbUwUvcM3GT345LRvMWMWouLK4FreSPXGQpHIXDQcLFGTA?=
 =?us-ascii?Q?CBwWZH4K0WH5YcblUhLtk6GKPatxE/EE2Y+xpE0T2cD1FL4GBG5EKx6MQfCX?=
 =?us-ascii?Q?T0r90qC+SLYlAOD4TmAnoXghqLQy+XPpUCEkWqflxKAsl035I6XXE8Xx7xaB?=
 =?us-ascii?Q?zPDzsRUGlc91NML5K6HnzDh6IO8bajh95c6j0h1TtOFyGg2l6mRY9wf9PFig?=
 =?us-ascii?Q?UrdBENslSuSVVmlFEG4Cnzt2kWgdpIg6u7Or0eGqLSXGKZ9skX/0HVX6dcmk?=
 =?us-ascii?Q?Vr6FS3qel7JsekJbe+N8ECUZas5OYW5gjCsJDAMHBYS3RYN16L6qvvjrg238?=
 =?us-ascii?Q?dDGxRoZAfaqTRLB3xKa0/HxouGtp2hCqilzM5RDyih83O60hQUw0OulNwr+P?=
 =?us-ascii?Q?utjmeTBLRt4bGHYUH5QH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35fd75a-526b-43de-6cf7-08dcaa6ab60d
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 16:24:08.0592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P223MB1080

I realized I forgot to add a description in the previous version. Whoopsie!
Anyway, this patch makes three error messages in the driver easier to read by capitalizing the first letters properly.
For example, "channel already linked" became "Channel already linked".
In addition, "expect" becomes "expected", as you would typically find in an error message.
My hopes are that this patch makes the errors slightly clearer.

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
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


