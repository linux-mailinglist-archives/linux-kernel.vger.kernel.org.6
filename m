Return-Path: <linux-kernel+bounces-295281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF08959948
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA671F21B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3757205A65;
	Wed, 21 Aug 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kbMTYiF4"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B31A2860
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233607; cv=fail; b=EcRJF6TnQbFg8jxt+9o1qjayHj1ViLsXuoEQQ2n04q4+EYEOPa+ekUZ6rMsfuNE/RvBWHUcepfzfzp3GvAaPvVrTcJuv8/6DOplFBQodCxbxPoQo6WIkngGkxFv9F+z8WDNySTQjr8mKLZhRQCaq+g5ij9RWAzWVyieaKSJvWXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233607; c=relaxed/simple;
	bh=dLD01/SvRd4JgbK3Ocykvtb0loiFH7A2MRR2fgvRLXc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=i/BIt9SQ6+v4QB0NkWaQJSK+Y1m5OZTaW1Wln6OlqNfuo40jZeCWwblFsj7xXDvmrNRDxleEOEncpjE/tj+HP8Psc/w6dFuKqP1HAScsJNOb7ZPzcE6AnMkuCeo+LeKHBXfWRnAfS/fpYvzGAm2EQLjXiyREkP9u+V/pRnZPPjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kbMTYiF4; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvM8NVyHwnN5OCuJWoEAyhKqOkAxR2JHW/aHEe+1sYepJwD0lFx4J84tWfBJ/KGnt3hxkJB/IKlTerROrFbR9s8HjhRo6zQVSkPBIVNdTQcGZNV+d37x02uUCeEgmSvZJDF6UqVAemJk2J+oOh22J+nrLjQz3z4B3nX7JBZT/SRSE2xKKs253T77qep76U3UiSjprTHtLsVoB1hwG90BteRBK7329Lwjn/mIJw/1KEihIOgZUatRfdQgN+l0X6VZ6pOHeC+fVpKRrVT+CX1rpukTQTkvfvnRCq0Cc71mASZ8iIBxzXnUzOFM9ILI6VaMHbTPBeCIazbKAORHIygrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfpakWd731jjXfzpCz2SAJCd/Ppam3LMTo7OP7pT+ys=;
 b=j03U6kUdyoh5r2MW9Ogd2tL5ER1FFRdfQ6kmH5ZUq9b0s/ILmpZ9ODmkptCSXlgu56wpcwT+9ko6a/1VwYxDYLzLi3o1ucbu9WjtMdJ1ERvriHtQUsu2aRzA5XgIu9xrvb3SgMK1RIGHmNoLfp3hB7NuhSWZQFJtq1AHw9V5cyemxAlOLPZ1zaXcb/5YEnSGdYzdl7z/mQy5tO3Qr2oa/UZFXvT4QofKpjDF9Q3tMCswXO0tdME2JQv/xd3hkFxcbi2jn3ymhm9JZJJ0WPBmGnoGv7EBmFRPoMssVCs8V2nApoY7LGD/alJ2flL1yfzmLQYTuawmCKokm5RWNR03sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfpakWd731jjXfzpCz2SAJCd/Ppam3LMTo7OP7pT+ys=;
 b=kbMTYiF4oKuXAAN8leqwyzehdwhZ4bbW2gQwedz4Rv+Lb5L77dDo79xaRIWSEKO1feY6YWoZmqOL47/g5EPmjPJw8IGr4FhbUjLZVI5Id+j+tvCMTUboIY6HLGLQUfg28JD/ZRW6DKHwVKf48nz4zpJUJQZG2Fs1PxzgvuKFtTqzp2OIw3VTuu/Xla0QvY/b/jxqSxB5NXn+BeGYt9pSDq1QCy1po0xY0+4/z23SM3aTkdEUlw4bbV0ocHDNOMnbhNyLkdpEUiUs6/bzGW3cx2uPs2eAf/wcGWoZ3tdWf4Zvt/Uuo/FShdGxOacL02mE6uEBR/BJvtJspKcMtKoB6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by SG2PR06MB5057.apcprd06.prod.outlook.com (2603:1096:4:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Wed, 21 Aug
 2024 09:46:42 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%7]) with mapi id 15.20.7849.021; Wed, 21 Aug 2024
 09:46:42 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] kernel:time:hrtimer: Use helper function hrtimer_is_queued()
Date: Wed, 21 Aug 2024 17:46:33 +0800
Message-Id: <20240821094633.161298-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:404:28::18) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|SG2PR06MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f625e96-523f-41b3-3dce-08dcc1c6296e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BL4cNZnMhNqlZ2Xwah4vgyZwNWlK4IIg+JRQdkGbDcNImn2lwMkhuLW55YuJ?=
 =?us-ascii?Q?06hZxGwCpRb3H2aaA2Y2F6A1HHaS+FdqdyvWujUVJ0Hl6jLM5jvKrDBNqP6W?=
 =?us-ascii?Q?YTmIfthmJ5K7pJPYJPnb9y244MEaTTUwmXfDtpEAlRBwSr8cmQwgR+YZx227?=
 =?us-ascii?Q?c2nZyQ5SsmwhAmA/rh3Mj212G1D/KM2z87vr6AJEz4BNycH738B6wMDTmQPg?=
 =?us-ascii?Q?N/tsmR4PJWGrVdWBbhLMwuowwEbMBSQ+gOfRn/1aquFhzNjt0weh+VU8pq56?=
 =?us-ascii?Q?AFf8ZS8Wi733T1Mkhg2R/bY+3hA4e2/YU6xIkKyaxuBJy6ZUIlxn6P1urEPg?=
 =?us-ascii?Q?33CwD4VerBpGY7ssMKtmDYpCCoppLOFWv0yYcK5CCq8aPeOjamMPX48dfV0d?=
 =?us-ascii?Q?wqkDdpewctvvWdeXgcp5+hyh1I1KI5Ro0VviYST9rUbSmpnMoDUX1GxJgIxF?=
 =?us-ascii?Q?3ST6DZNMUT88XpF+OYZ3cr0RPt06xxDw0EKWNw7sQCOMm5qkB2qmEtuvCF3C?=
 =?us-ascii?Q?ySk+8JZwwxyDAMKr0uWKb3LmmydcsoA9YjU2MwQgYO+akorywGlgDeB9pqSK?=
 =?us-ascii?Q?tCJ5VZ4peKwVUW6g1IWvoUbg8M6DmG+/3YQjDIsm+qHew7Iu9xbXBuE2n92r?=
 =?us-ascii?Q?+s9MWVUBjk6vHIqbKzepRbyREpTQaHL7rC8sZb44S5Plz74bxVGl0RzzGivq?=
 =?us-ascii?Q?JnRVbioFl6dDeMibqXJDnownU4kX5iReEanI4jECIK02dY8I1QpN60yb7atk?=
 =?us-ascii?Q?OG8xTpG/G7ghAO63v8DADZpKVqdyJPLC+Pq3ygoAoAtuPJN85fuoUtgKzFdY?=
 =?us-ascii?Q?0U+9us6xGOM8NQTjcRfj732gTJLqOfVq7/ne6UQHjW7rFc54w6BHHAZaH9Wk?=
 =?us-ascii?Q?iQ+3vTCpFwepw8v6Lif0f2Thb45UpvmuRUGVe+g9tz6MF1Xd/HlgrokAPoi+?=
 =?us-ascii?Q?I1Q1/LwmkhNApIExnjrW77Qz9nKjSEr88l/sfF9sxvdEjxIdEZ7Jf9GM50f+?=
 =?us-ascii?Q?QziT+SOxlakUrmuZ3sJsjonNHgM9ktoMuB+4+56qt902mvRApdFW2nCGf3xL?=
 =?us-ascii?Q?M5u409KN0qkeEWT4RQbyWm5wzMeM6kiGVFPWB1I3eV61vWgkFvhhIJpOwMdZ?=
 =?us-ascii?Q?gpWZQ0L6Ywxm5wnikhuEZDbwywuqol+wcClVKRFA4tGU4QAzI/k1mKPe97MJ?=
 =?us-ascii?Q?pvrqb6JcGwmZX6CNq8P2FtPyz7FFWkYNQCCt1Vgt/OBUUDrWVnVaEEF8p0kF?=
 =?us-ascii?Q?8VbZPBSN2Zsjo2tqBALIysgn5l9p0KfAE15RL+8bC/1w6Bo0nBtO6BgbJfgD?=
 =?us-ascii?Q?ozbrxjofGbO1w/jjK9n7GMVXwnxtOst632Uo7Jyv9RwEvP1lWc9aMXMJJNlL?=
 =?us-ascii?Q?L+VHvNjOA44BU0Lr20T9fPKmDMTni3KYSyIghHPnSnuP9Qik9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Sbqsu9mmy142L4oA8CjWEDqmC579VgjFyT6OtTQn9drKsyg1C7n9smVC1zg?=
 =?us-ascii?Q?EHQxVQ0lEDZI3BL4NkWowz77wJHZvit2kXTPPfSewGs9K7XcQP6fqpqRiMd+?=
 =?us-ascii?Q?We50sqIIWXXxSRL8DQKFa9Eqy1xbzoi8GiJ3jxS7+VR/u8wmNpxK4PcsKyuJ?=
 =?us-ascii?Q?MrbKAF/mm0AIVvCo1+vT4xVstWDlsQ0l2G1rNQxEGi0KKNbZFAoyMe4hcmuT?=
 =?us-ascii?Q?ZHATGMFQAg4kKeTGhdmuv72XU3jxVE4V0Rw1wFmzCUlm5w1bmRk9n2XhFDfu?=
 =?us-ascii?Q?eXK2d+Y80uuwxeknDlj21p6ImNsMx0B+s8XBfZ5h5fjj7eZ1RmZ3ZsWw3rfD?=
 =?us-ascii?Q?yQxaau9bNT3MFF7WScUs8i9XRB5fM5GU6fxGSSugrO0KWjLSXJChJ45N16yJ?=
 =?us-ascii?Q?PbRU36Hn1VGZ6tgAwsOQnAkU2Bama6V1yDI6J4VC7x093wfxR1f3vrKTn9sq?=
 =?us-ascii?Q?ehVw5x5wiy1oqDHgXHG1R+SLd+XXWahklvHG7APFb06sT+/5RQ02/lA+P+D4?=
 =?us-ascii?Q?yu551zZIgGk/js7vrXnUAjkuSkud4leayKkcwthfHCUgb9wm3Axcb7XKBbxD?=
 =?us-ascii?Q?/7ra1dhSfEEA04rrwb8mqnTaz90t95jcesbOguHSPyZpArNBC/vxPkdXzoxJ?=
 =?us-ascii?Q?gZh9KIw23ZP/ARzAnCuQ1wyua08+LZIF/hTiK4p3WEQMHNYcApSUg58NrcX3?=
 =?us-ascii?Q?zuciw19oIXflLj55dX+1Gi6HRofTte9Cmm/qU4GkufoxW7bmzmq6NuXPOS0g?=
 =?us-ascii?Q?RQeA1N6a451yDMmmMV/IsUEmCeR23geSTpbfT7Ll+nYbekVvZsSIiharYS9f?=
 =?us-ascii?Q?16SkpmKMRJhinM9BOESMaC8P1ZsUWqPhLYqUia8iele5qg8k2NXIgUkuWIOA?=
 =?us-ascii?Q?agmuso2gZIrgn7VO0UnSgdQQ1FZBWVVDtVCRaqgmscKGe+1HETSehOFn49U1?=
 =?us-ascii?Q?AiIi2l7MtTjlcse4VD2LMO6Tvb9zXjJjvqNAeKCt8E0RqtV28RWsjTCeCC2G?=
 =?us-ascii?Q?KFCgyteS8GoHtX3fMSVFbbEbd2l4rVwHWu0fzsVAa8DEPUYSrlNNpLA5VNyl?=
 =?us-ascii?Q?UYiiDrJShVwxRyphiVpPNkJejqWmRLX3im6wUHbOc9KhtrtAky9K5JLTHgTM?=
 =?us-ascii?Q?fWDb/xD06vWkd4cBFROB4DTeZVelWRKzGCDAZDj9KzO0xSFlB6v53EUxzBD4?=
 =?us-ascii?Q?nDgRGDcZBPDV8fUVTRDounwjNzai13Oz8E37LmC7hOSxZQo2jH2y4KFNPL9J?=
 =?us-ascii?Q?8IHjvJjhybKkU1gqqFNK+GBcEe5djK2amLwO60f5Nh5hHHPMEyOG5ySAE45S?=
 =?us-ascii?Q?/KEzoZ/3cBHX4NKp5shYoa3icMhH4lrBj8VodKpmTR6X0YjJ/LWCAU0J/HX/?=
 =?us-ascii?Q?mm3+35gEjuTfh4avG0HPmInH0I5ox05BZfWCn7/a3nzKgOAa4szbmL8y59u5?=
 =?us-ascii?Q?WN9ZPWzWgRGvZ1vTu6IeZknqUiAb/Xcy1AO6/oA8gT2eV/FNEoHGKWWtzNQc?=
 =?us-ascii?Q?/AOdA/cAXFdCftslx+edwpK1KEVl7bPTa47fa4VuM9bexmCRMpi3GV0CVySm?=
 =?us-ascii?Q?UY/qskUznzJ3gryi2unI4NKOyDC3O+E6d+Wm0Y7U?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f625e96-523f-41b3-3dce-08dcc1c6296e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:46:42.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EHAyCt+XFsoDdISqbBs+WmEksbgV4ZHbeqssmeCC3AnBgV+ln+GSMtBkOu7OMEzrfQTPwn3CK12y4cu/XJkTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5057

The helper function hrtimer_is_queued() checks whether the timer is
on one of the queues. Replace the raw check.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 9f8e5da62ad3..543a917905af 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1045,7 +1045,7 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 	if (delta < 0)
 		return 0;
 
-	if (WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED))
+	if (WARN_ON(hrtimer_is_queued(timer)))
 		return 0;
 
 	if (interval < hrtimer_resolution)
@@ -1704,7 +1704,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 * for us already.
 	 */
 	if (restart != HRTIMER_NORESTART &&
-	    !(timer->state & HRTIMER_STATE_ENQUEUED))
+	    !hrtimer_is_queued(timer))
 		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS);
 
 	/*
-- 
2.34.1


