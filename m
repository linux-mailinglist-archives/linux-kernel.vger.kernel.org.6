Return-Path: <linux-kernel+bounces-176618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D68C3238
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928AF282058
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5A56766;
	Sat, 11 May 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JmuVYyDg"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2105.outbound.protection.outlook.com [40.92.19.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFE5674D
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715442550; cv=fail; b=Iz/14hhq9FA2HOQt+CXDfWFfVTHqKzMuUclD9AQ4xjd8CI0Zbqy7cUyEkO614rQH7sRH7fBiyxWco5zlX6WPRBnY/BiIhmp+C68t5luRtE8f4joqgqkeQBCcCePzKc3goLNTHERSZFglrnrZ9KkfoNwJaRu6nMpS41f6YJLLx5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715442550; c=relaxed/simple;
	bh=bgwj2wILC3N+WTBbZKsexDsAKFtxn0EauDjqnaoJw64=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s9O0PSe0+D01Nnaaiw3YAxMVTai9O1vhpG3JhQLFugRzjmLsvD/HuomvBWRSI9qrclLiTCRYAmlqKIQUFf7byj4lgps/46BS1N7YiydwiLpQoyAvG3np/W2mHe/w+6KNldHRP9iVFw5WVhNMwZCEyy5bzFEjSGKotwefA8kLfYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JmuVYyDg; arc=fail smtp.client-ip=40.92.19.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knOGoEl02/vewa4dVsX9l/UoU+T1uOKUd9Y5c0muQinlhZKaR3k1ZSjxCJobWcr+f+DvQvx+5MRL6m/AFDYsO/RwGYnTY+DPj+O9+UW3utgoVcbHbbjwM1tbU7WfiKeOiws66/sQUoL4PvaxckAPs3Kqs1dI0K/elbDXhim59W4ZaZ8IFLVJ/8eoMLpZZlMSvlXJVM5Q9U6AQQVspjTkgpecQPzSwLqnSZzYJG8T8IGhTZyFhMEGsRomBffTy1ExgWXD5vvO4+9QH91hURJGbzfrvAVncy3hE1e/z24Z7aTR0kLyg2S3rv9cGppQi1r5RPECkc1hnhWlyo4T6Wefww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntTtdvmO/G84hYBYkD9gR6i3brkublwEgV/fCstZalA=;
 b=C+4yVnoYg+jFa6mjy7hFFpSqusIA7+QT1ioygCCzeBmcGgh8tkAmv1upzd/ujmM5N1SjLm/7CE68vgRCArg6xNOVwSTM+09wTvR3ztEHLfPxhTsf9Bs9sX+O0nkOw7zvI857TJI4wuhxU42gdoYVuvZkPZkp0oXV4Qt6LGANLW6OBmBOMxC6nNz4g/Db4B1g5kFfj4XXA0yoRBA6ll7dOeAUWAEiw4yI0TAni2NM4rtpo96BO50C+d9nB23OksVepv+bBkxSNE7TflxcVvIHokEJZKAL9wzeqB+qM8cLWc9Lbo3tLZJeP8oO+X5qgj2u16co+drPGl3e8N6EbkhyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntTtdvmO/G84hYBYkD9gR6i3brkublwEgV/fCstZalA=;
 b=JmuVYyDgG4a/JsrygEx3bqKXhN3QEiRXGL53EDoTGjDPz4WW+WD69RPdM0Og5C7jyL7c8O09gFOj9GbxSCkbXvCEB1oN4FnRfOiqE4n4j+ItWSHracSmnTsQBmmXq9ZiL9llomJdkdXjBmH21pqCyFSCxhBImLgKJCTDtN0whJ3UqVm4ocpOd8sQvf8zjVlWO1Bj/Jv3vZ84yf0hLZjRi5LGsO9VU7lzfMW/0emnogRvTtgGf2Q1/zhevmPe3srsDM7sJUsrvyHuOukAVIfzezkmrx1U+RfKoj7vkKVOQM2cY/8srNCYunO2mD0fvkBVk4zCLG0ezHLWS8D7xEy8ug==
Received: from BYAPR03MB4168.namprd03.prod.outlook.com (2603:10b6:a03:78::23)
 by MW4PR03MB6540.namprd03.prod.outlook.com (2603:10b6:303:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 15:48:58 +0000
Received: from BYAPR03MB4168.namprd03.prod.outlook.com
 ([fe80::b8b1:7fdc:95d4:238a]) by BYAPR03MB4168.namprd03.prod.outlook.com
 ([fe80::b8b1:7fdc:95d4:238a%6]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 15:48:57 +0000
From: Jiasheng Jiang <jiashengjiangcool@outlook.com>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch,
	chris@chris-wilson.co.uk
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>
Subject: [PATCH] drm/i915: Correct error handler
Date: Sat, 11 May 2024 15:48:48 +0000
Message-ID:
 <BYAPR03MB41680146FAD88A8F26C3827BADE02@BYAPR03MB4168.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/Jk6qVychFBa9zPV1HzyuO5GGLdH0GQ/]
X-ClientProxiedBy: CH0PR03CA0392.namprd03.prod.outlook.com
 (2603:10b6:610:11b::31) To BYAPR03MB4168.namprd03.prod.outlook.com
 (2603:10b6:a03:78::23)
X-Microsoft-Original-Message-ID:
 <20240511154848.39492-1-jiashengjiangcool@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4168:EE_|MW4PR03MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1a62d1-a73d-40e7-2f73-08dc71d1de08
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3420499023|440099019|3430499023|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	sk0rCforVT/htuuf443BClFV4OIzQW1Al+5frb9PWdlOrQabj6YRPaNfJriLXC2tdzKcFQVcoj0jQFo1tgHWqaCkonLK54oA1EQpwSQuaTVdQi10282Byzb8r9RnYnemY3yIWIQIP1wSuPS6fOnCCJjuLjI3g8tSuFTfOGQs6OChC3m35mvavemWqo1bSISALxH7IK1Aa0MGwXmhlnltQEN7IVexJscQWjkbwxBEgmQB6i9NusiQxgQZh0ZOWfyhLZvSCZo1FuxsLtkS01Xz0qLRww+TxImAsRnvHM0pO+8n5jPtzSJ7y9aUy0zK03sIh1lbswnPai+aOezvwlju2+Y7l5g0C5sV5h6/ixINiE5WYBdBmQ+oKxcU9EOH+EQvkndVuVHqTqpJ4f8er9nwgQLtBhpX7ELy1J17+QTHh+ak4cfeI4dDrDr42VC5GmGJ+9Jh7odm0ZEI+vJmhZtaVceYd4z9XAEAcKGuY+nPy16imJmJldWUuEaw8HXGaF23xgT+fsr8bd+Mx3KjoHNjXjB8MXNHx37rfE0bPGSwCuNMOrzwxJZzSWBHlb01Rhc5rNnCTjFJj5gtur56fjwmVrUSIdE8QzPviqaXGtZYFm65buUFB5JUjRyq3b0U3ZWL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yEr6VPBax8czFmUWzFzi/XrIubkEJ5wfEeEtHu5+EgBgYqJg8HFS8MwrbwFA?=
 =?us-ascii?Q?TLI6hr0nFJoWwZjNAUn24etMW+KfhAiOE116KkW2CJJS0WuD2LuGPaoNBYN0?=
 =?us-ascii?Q?VYe/8pbAGYhGNr2KN1+y/H3LNWSmJtEHZ3+YftxBInLODO5ruC7YkHbJUxJm?=
 =?us-ascii?Q?jLT0LYFmSwL89fyeW5Zos+THRxaz+UfkEpWVCe13REjvpO2AnYCZQxx4NfNR?=
 =?us-ascii?Q?RkqHeWh+GR9bJpDXKmiEWAx/3iCOiZZSwoDrtRbXSgfUufNc5Gz7vnXVutMS?=
 =?us-ascii?Q?RYfIbQdexZ1FoX4Zh0BztGbluBRi4Uy272eInkjAO/1heaApsiZiFgaPDmth?=
 =?us-ascii?Q?3d4XfZFbTWetorNv4W9KoBebOdVkhnIrxqAzyeSV1wFgVwyy/vrAGrxoc1tl?=
 =?us-ascii?Q?UGGUaAqHMBLvFksMkvOmyR6Iuvu763FdH3u7aDfZRvhWvKHYA9FJKjAa4Kly?=
 =?us-ascii?Q?r5D3mFufl9FjtPv6Rd4XSCARRkY1fMSTYOIfJkYxvuk/NvdU3KdlAjX2G4sb?=
 =?us-ascii?Q?KGtckbsjasH3XGCYON9jYfy3aIMp1TmcvwykfPu5MgPQzD9LHbAixiNzhM5G?=
 =?us-ascii?Q?DITr37Z6l5++nRqpBXSctePJFeCeCReKgrgRRl+hYcsBKzk6m5Yx+bX1aeQS?=
 =?us-ascii?Q?sZE6SskGbQcsOy3JEk0FosVur2UVPORSxobovsfilQXoZ9dbvM//YiR86QFT?=
 =?us-ascii?Q?vlrgNAfiHGnBbc+F88tIIdNnBJsf1IERyuM51Lg5gbggiUokaxD7ZYP/D4hZ?=
 =?us-ascii?Q?7QoSCYZdXsfAmhrRZ6fLwYflwoHTqsWu0Hn3CsTJJGOnWVdjOj1SFb+XGyLQ?=
 =?us-ascii?Q?TeHgwcUxqJOH7NTw/DTqf9HEHrh0xzEDH491EAOBk6LjygdnMHvRS50klqI1?=
 =?us-ascii?Q?/L6mKfcwk64feE4kVHRduZlwLBduCGT9gIcCR582rTM2zljtnLZ+m/yjDzHD?=
 =?us-ascii?Q?jnY3M+7mvhwk61S/u/Ej9BjD1qzepHft6i+CN6/kauUamU9GoYOFS5wycRNP?=
 =?us-ascii?Q?+nEOpknFXIDKIwEoYUcSELItm8JCh0+mKsdAIASWDkQX2ETwBsHDn9OJmpvS?=
 =?us-ascii?Q?iRM8+aFVgng5v83t5l5wvItmXyZ/bu8EUFVmHbLWWDiY+MVYM8pLIaZpFoMM?=
 =?us-ascii?Q?gm25sxbcfB2QHzK9nb1nhBrJiP/5HS1/eBOdzeie1GBEVbjdFfpVqUUgbHVN?=
 =?us-ascii?Q?b2aKT8R+1wFaJV+GkYIrJF/dzMCrfmHPSww4ibTK7rU1mKPYa0AcyYA5IPFO?=
 =?us-ascii?Q?A/nLxcu3B04smv62yVvg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1a62d1-a73d-40e7-2f73-08dc71d1de08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 15:48:57.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6540

Replace "slab_priorities" with "slab_dependencies" in the error handler to avoid memory leak.

Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
---
 drivers/gpu/drm/i915/i915_scheduler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
index 762127dd56c5..70a854557e6e 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.c
+++ b/drivers/gpu/drm/i915/i915_scheduler.c
@@ -506,6 +506,6 @@ int __init i915_scheduler_module_init(void)
 	return 0;
 
 err_priorities:
-	kmem_cache_destroy(slab_priorities);
+	kmem_cache_destroy(slab_dependencies);
 	return -ENOMEM;
 }
-- 
2.25.1


