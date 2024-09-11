Return-Path: <linux-kernel+bounces-325049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE7975438
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BD41C2281A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921FD1A265D;
	Wed, 11 Sep 2024 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="noYObkJN"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2047.outbound.protection.outlook.com [40.92.63.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCEC1A2655
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061794; cv=fail; b=Fjul+TPenIuqyRZpLdXpPXesWss19ekq81Qie/JgTg+x3OlK4ANLLro5ltwlV3OP/lmidndwRE3ouNGb26OW6SLhjfR/lqEUjZbFVRjWYMVIpZfqi/rJJNJmytIVhE5dsY/NRzdVy6Bq0gkUXbL32jisnJPdimdjcHDmozMut2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061794; c=relaxed/simple;
	bh=kCFdvEwNmPeyQsX7xtXq8He5u59nkyxxtvuCCng1DEc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sRGJzjt1DNN6HvMXSTfOeJ4WSh0l0IuEJ86R4wpspd45DuPV3iwm9cZktu++H5da3Hpn1gAaAA2R94tra0CGhh08SNG4pKwOwocgfR3XtZ9lTuxnFTw0w1XyIbL13vuguxHQIn+eExqsyyBKkzvY97adD3mOdr4ENn9ZLdgnGpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=noYObkJN; arc=fail smtp.client-ip=40.92.63.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT0JoY8xS9NgrfdP9mmn7AhmO8ejr0ofUDVBn7VWR3IdsULy9dfr6zprEs+viEM+3kaLbVJTwDM5Okz1vhebQao21G4NxlLDaxax8Pp/pJC8+ITDirv6oh/DTEJ+psjvRd+eBTXVJj4/xMgt8WgoAJscc8sGMP/BBSbgKW6eyPnmxPt6/KCA4KDbW8QmAesqbifFfD625ki/53dOqjZt/i/jQXQ5wyvz6bXUN88ilazGRnTunuxU5DMXoC5pyD6RyUl6pN53fkf958QIITtaHLJBycW4+HE8DSiF+Asolc3FVpd4w+zk1UUU9Ah86J4BmRtLOJnmrSZ6UZjx+W3eFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G0pWf0KE2zlhK3NDLjvyddjo+t/D0fHrGvv8oIfxuc=;
 b=RqRWtQ9CNb1UAc+A8ST5Kkb3eR169B7ss7TuDJtEsErrHgS5/wsyiATpwBvFFev0IyFrSnYycQRrxumibS5N1kDMqT1jAFBUkuo1ZUGpx/FYgjgkwt5TzjRbtgVWy5bnC9oSHxSKz9CpSHGrRFE4/5bM2/Axd9dJ+hJBIPsJqOrB7w8O6WflEkKj69kdlUUyk+w144p6/NWH3fOcRlwZiWkbVLX0aerjJKT8PrAOK/QO6PE+gCnyUncO4Ge3xJA4cwhPcSYdzhGf7xt06maYBrxKPFob8wS5yjLgNk+NTpxCpL4ISc88joQj7n9xgfRZvoF3V6CJGzr+t98FUemCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G0pWf0KE2zlhK3NDLjvyddjo+t/D0fHrGvv8oIfxuc=;
 b=noYObkJNots1cQMvKwJRoS8G7kfRvzmCICJ3tTTR+ZFIPzF/0cDz6C//FDnZX6Qu++WlJ1drldsZ0NsXuOfgW7HDNy4DT2KR79gBLoGl6gL2z0t8qk5mqomG5d86pijo4K0B70BWUGqL6i04UFyJqD9JPTsxSfAJhgB/AKcMa1ZrVbE365QripJT+yqIiQ36Ajoa0GE+5hh+dp5ltCxu83w0kjtUyKp5UBjuKFSdFhPlOIWMd2vdAXDuqEvAkuxsE9YpVp0PgeT6UqR3P3NK/YIEuWT/BhNYk9A4dlwninX7u5y/+OmPPxiOmnpVuFbmFkAQMKW3FTfpQ3vLD5wGdg==
Received: from SY7P300MB0622.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28c::12)
 by ME0P300MB0454.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 13:36:28 +0000
Received: from SY7P300MB0622.AUSP300.PROD.OUTLOOK.COM
 ([fe80::a480:715d:1f02:38]) by SY7P300MB0622.AUSP300.PROD.OUTLOOK.COM
 ([fe80::a480:715d:1f02:38%6]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 13:36:28 +0000
From: Haiyue Wang <haiyue.wang@outlook.com>
To: linux-kernel@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@outlook.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v1] cleanup: Remove extra semicolon when call DEFINE_CLASS()
Date: Wed, 11 Sep 2024 21:35:30 +0800
Message-ID:
 <SY7P300MB0622292694BE714CB9990755E49B2@SY7P300MB0622.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To SY7P300MB0622.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:28c::12)
X-Microsoft-Original-Message-ID:
 <20240911133536.55433-1-haiyue.wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P300MB0622:EE_|ME0P300MB0454:EE_
X-MS-Office365-Filtering-Correlation-Id: 6861141c-dee1-4de9-7b55-08dcd266bd63
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|7092599003|19110799003|461199028|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	OidOYr5KlzaEB+7OFSFaTDsCe1kjrIkGnho4IR8esYFSysenqaZrJsu2GzOUl7B6VTXLPq8dT9uG+DIFeSsalSftST9ROCEqoPLMaQTDLxs97BcW3LJOt+ta4g2/SA6kT1IO0MmwytVEEPIdfJj52l13sRKchFrhHfm29+brcdxGFFg5+F9Yu/0IyyOU86Soc61soXJoVns9ttuP9ukBKYkNXD2wc8A1BtEI84MvikgQuvRDu5UBratUh9/ccL2LIMNE9NBn/F+08ygdsCmiARhc5vNufd/ttZJO/bCuy8cBjnAiIjGTsv5ukKbGLD2KeZBb8N17Xix2A6JVnG6ibU6vu9RhYuNjpAF4gXCVInn2N3JaQl/gWOWGQZCyGo5ipJr/ALcSULK/XqFWZMnU++z4E7hEhswnZyVXRZDK+T8tcvmhvNtKFN4w/ywOig0F8ca08alKjSDhTecr4QUaYk4cV3s4bT84qVyXOe5kza9tGYDsrL+kvFPbO0EP9ctQZM3ELnIk6mDCL8U0vIXQGG3Zqi8axjCa6BdrJMIYfpUWbDR7Rb+zn6cgbNPs4VSCMkOIaxqSKY1bUy4Dlz81rubxDkV1QxWun+cyIVWqOUsBD5hGCxh3HPqve1UnpxDsVuSB5m16g5xqCddOoAOSz3zopZV9sEGODBu6hPIGA/jcKUFZXOO53DpvsmGmKn5wZJ9ZM2Ajry96nbEhnJ6IhDzvqjTCe6bTSYX0EaH6Kvocs8+KJSb+M7H8ixiwE78ZY8I9f4aCwJ3WJs02Og0uoQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z+QCD87b6bam8EQOfrsUAfbe0U9mp0qRCDshvCrM8x7S8MGXrJv0wI5TTvPf?=
 =?us-ascii?Q?kUVhEcoN7q429olkQaJW1qzvrgExxWWHHucA332mLfz55kgF9scepkxaBrMt?=
 =?us-ascii?Q?MY71cpFvi1e94CW7fTjJxTTZpCZIfNHwSTfKIQIScgFjBm5I9bMPV6ShLOx0?=
 =?us-ascii?Q?f/3XmysUPzwz0aBiEgQfIueRV9OJhak2f56JdUhj8xMaPdwPguwf9faqbZ7t?=
 =?us-ascii?Q?zX5+IkUCmPjr6LaHpZp89exm5InT+HQzNbbwLW1eK5lPoKEf75fa56vsjBIv?=
 =?us-ascii?Q?gQXi1yT26Rsw793uExy9fqvbn0tLDzyO8fmox1KtyH3XY05yW6dXWvnH70Ad?=
 =?us-ascii?Q?xDY7Aqkc3RSLxRhtgQGqLUFXVHVI55a3Q533XqVNOUyvBUYelFXPfOrRQEpH?=
 =?us-ascii?Q?bn5i5FtTdTdhuHXZTSiEbIA7uyCxv4G6+OQFlts2QanBc9L5760b/PGXLbcy?=
 =?us-ascii?Q?in9VKllc8fyOLgmIwoMN0GrxaPmtyg/oi3AHh1z1kgBYad+a54AHkbdUhr5i?=
 =?us-ascii?Q?tKgr++b23H5g0vG1ZTWQeK3QP44SnbrltCeoyZ3VKPnXSfBMcPIDlrvs7A8w?=
 =?us-ascii?Q?VhRyVs5/ToDFqFaqUDQBeD6l3z9uGGNzMS0NOcB/Qp4dSAh46fTWMHkmQ8B1?=
 =?us-ascii?Q?vPkpdWWMRmRc/mlmjWh6ySgffS9NTba1QoAsYmQuBAMLp8k2lPVYpGneJ333?=
 =?us-ascii?Q?8qb9inUmNaWGTqawUcQJtiPONTA+XkciPws8QSkBUFeWOzmIK2v0wa0wftzd?=
 =?us-ascii?Q?DGmXBzma2Mdgrp/5SqyHq1Z9gE3h16GVne4ik8MjpvEI+DpmAAkkAq+G04N9?=
 =?us-ascii?Q?XCuJ+LxIuTBd/Ud5zqy0JksEckPnnzcHPxjs9nn79E+moN2eiwVJQNDAD7df?=
 =?us-ascii?Q?1wDny8eshiRjc0Y5jnLq8u0cKOwafMekRe29SMsqfod7DfSqHZWGqjHmUME/?=
 =?us-ascii?Q?HeGDxCX5FkufQFjqiQK0dqenGq6ucWGyT3XjSdgGieLBwNx7mFq8Tc5xgVxn?=
 =?us-ascii?Q?oHyoYqccKsxnQWG1yRnJbrbjgOviVcVFBWl6j6+Ofp9FTEJiDyWUvKQ3n5OR?=
 =?us-ascii?Q?m74BRnErB1I24dcDMTjXk6mxexYIZGviDVqocJdQvRF52fXxjI95pCChHb2L?=
 =?us-ascii?Q?gghBajYYnkZV1ic6JjezhevfpkoOT5a6vFbFqLy0pxqu9IfdfEJe0QyAiRGj?=
 =?us-ascii?Q?gBraj3c27vH0Ykf3wvj9SefipZV3LUDm4+JygS2iN8dpz1AK4jSa5SeF2g/v?=
 =?us-ascii?Q?kFb9mKBI3jlE0X2CGD5N?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6861141c-dee1-4de9-7b55-08dcd266bd63
X-MS-Exchange-CrossTenant-AuthSource: SY7P300MB0622.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 13:36:28.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0454

The DEFINE_GUARD() adds one more semicolon to call DEFINE_CLASS(), it
expands ';' at the end of function 'class_##_name##_constructor'.

A nit fix, like DEFINE_GUARD_COND() calls EXTEND_CLASS() without ';',
to make code generation clean.

Signed-off-by: Haiyue Wang <haiyue.wang@outlook.com>
---
 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index d9e613803df1..abb1d9fd7a99 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -152,7 +152,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  */
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
+	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T) \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ return *_T; }
 
-- 
2.46.0


