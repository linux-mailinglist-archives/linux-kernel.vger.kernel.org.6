Return-Path: <linux-kernel+bounces-262637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D593C9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14166281BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64F139D19;
	Thu, 25 Jul 2024 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FXbof+5F"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2092.outbound.protection.outlook.com [40.92.21.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B7E556
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940613; cv=fail; b=bg510kiUHxKQb8m1hUR+GabbXJWpP/Qub1NbX99hlI1ltzS1LEM1wJqybzQy9YXiNd9pGClSCc1R/wVJTtUexjpLk6c17hZZPKO0q87J2SWh/ZDqfPwl0lRGDnpohf992a22l9SZIu0dUbyL1OautyaVq/TbOPSWBwmv4x5v4Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940613; c=relaxed/simple;
	bh=7p51/6yoxX/UnR5WUzlK8zoiDGPfUDOgyUanlgE4NgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RtD2zzQFeh04vrHplhguoIk7WU4WPAA9oavvKgUoG5AvobzKU35DQVjDyxjDxerxqJBZegPM+GoTUVsg1JL874q0CZhvY9GGeeiX5NjQNKE5NXNMH/E+XtVvEY9wMRGiX0qpFBaDehtdoWD6beQRxMdDYl0dY2TiTXjbF/eXplM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FXbof+5F; arc=fail smtp.client-ip=40.92.21.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9Ie5mBSg7XDFM8GHwQAfsbLo+To7NB6d2oDrG/suUbR2b2+NWR2myGMdPvlf0IuAG/DkAjvdUEBGV0JdAFShjx/8rIuiuIAv0ryct9rZHtTm9s/rsthUXYTYv5QPffylx+UyDYe77QoCSJxdyklPAQawu0IS/fQjKx4v3+I3ieaMsuIBRSluZU/r+kW7aXZfB9PDKH2b8nhNJD7BxsIFYPumqz7464ihU6deZIgfqK5bA2kSJULc6+hZ4mBpv0RU/AKvVrrSDqjDzNePVzeu/FzZHtoF84dHhV7ztKkIXDw1FyVnhSRiR/TJEGCDD0VLkO6aPZV8K3RdRTrtpoyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyM55BXu4Vi/9ChPZy5ns0ggSgudxEWRviYxCXRogvw=;
 b=PRkc7kcMDB3ZnH4DX1QJroTC+KBSNhQt/0s5D2UO7hNgOeBU+/pWAP/y9rpqWlrNOCXPwqdhhYXSPF7Ms8ja46iKHeRRpI2W6TNv6ObDn0ZyeUM5u/qU2fNZ1KarpyyX012Q36afCf/Ieyw6byyfJFrRHB7U6JQwyDRSuyUi2ofl8Y+sCui8cw2z01OB9RXSisnfZsNeQ/PNlhjlFIw+h3qe9VDQBvZFtXZSQsp4Sqia2p2tBpxwFxJASkmuvbvZw8SwPVkXisVMxV08fMiXDaV3yZjbDG/KHBg+NRRhsohdgRR3IOOAfGXYloV2ca8a8cMPA8iZQ4Slo0hFcA/jGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyM55BXu4Vi/9ChPZy5ns0ggSgudxEWRviYxCXRogvw=;
 b=FXbof+5F8GLu6J1GbS2GnCtqXGZz3ywCNj7UmyDm49UvlO8ZlcW+vY1uVqg40OArvkk26aGmFamMZTrTW+MjEGrObUSrJZuL+SGAPOVKe2y2F6K2T/7m26chVtSiwHLup217sooX7yCQ+a65/rSQRVc2M4+K9xk29xv+YqyreYNSQmSDd2Fi09Iy3/gAySktGxNVEOkB1BJ7tu0joxN5xdhWVJr/QnoUr/zXHxrjyqAIyox/+a7F24wpGiCuElsKj5afv9lmmVz7sDzDr3rD6QkMeYckj7MTgr8pOZlovThS7LlvULdUKdLbuRkP36CdXlqOgiMmq/NmDZZwl7mMYw==
Received: from PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2fc::11)
 by LV3P223MB1064.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.39; Thu, 25 Jul
 2024 20:50:06 +0000
Received: from PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM
 ([fe80::9c9e:3eec:db55:6a5]) by PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM
 ([fe80::9c9e:3eec:db55:6a5%5]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 20:50:06 +0000
From: Steven Davis <goldside000@outlook.com>
To: akpm@linux-foundation.org
Cc: chengming.zhou@linux.dev,
	goldside000@outlook.com,
	hannes@cmpxchg.org,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	urezki@gmail.com,
	yosryahmed@google.com
Subject: Re: [PATCH] mm: Capitalize letters for readability
Date: Thu, 25 Jul 2024 16:49:51 -0400
Message-ID:
 <PH7P223MB1039AA3BC1E999EE54B1230AF7AB2@PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725132124.b0d317ba1d9e7d1651b71a65@linux-foundation.org>
References: <20240725132124.b0d317ba1d9e7d1651b71a65@linux-foundation.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Uex/IZwsvDOsGGXPw3qCFA3EHY/oFi8n]
X-ClientProxiedBy: BN8PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:408:c0::24) To PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2fc::11)
X-Microsoft-Original-Message-ID:
 <20240725204951.2704-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7P223MB1039:EE_|LV3P223MB1064:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad089fa-90b3-4f3e-9de9-08dcaceb5d08
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599006|461199028|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	/Tq0Od0vG1yzNQJevMo4gj93LuT2MCTTlhSYwfB5KMFkbf4bYnSwlp76RkWSm4ZFVit5ARG0fiwvI7SIMQh0mVWGm82ETuyheNmCrijkO4zDbwNq0pwYusaJEGtqJ9lZQoEBNqGmcXiijhc2A+joq5IdEvO+xHg3cSbXsvasnsymsts/Lz65nsM+5fCeTblgk3L6nsihTuGXzhxNG2lZm7Tty5mgPhgngjhtxsmf52915xMNi0xTn4BrSm0X8egir4FPU9wt2U+34AyUVkTVL09c4tmOviAkOsy/r1lbTJMnDgkvtuwZy0Vj5LNrUzG0LFgFletolBzQjJqKDQDcWVfDdq6nKl0bCx5YttLAUKzJyskYS0rG9/L3BiFleJv29n7up6Q8yPuCDBiPwNcKRqifDChJ3SB3aGDGAs6b6TaEoZHLqSyTB4rdC7YzHfquBR2ldHy1EBPOKVcKWS0YlyeTfm8eyGBg0IO8FBT2gl9e8ALrJvJF7g3W1YwQA3p9VizQIkS5T/2Y6ons/cCYbQFE/udEYHJV1VM6/XdlVlgHw/QOPoV7rqu5Owt+jlc2jtXkQtxUa/FeuZsbZYDs2JksJTmwvYsItg0OnnVKsmcOehhJozsGNsX8fYf7aEUiPOIgpxU+xAMo4jeRru6xVsc76ItSRS3Tnn6WJVaD0/0Uqp8d+d/ntt+kHhNXSbgc573w50mAq1qEoKE6kekk3Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zt2H606ZWJ5fVuN3aaIi4mVIdyegkJQDVc2runFVDOvV54dwnxlRjvNHYEt5?=
 =?us-ascii?Q?nzuH1E7w2aOTpyfY3RxdAcSq10oQYvd/ddtijNvSlwuPF9ysKx/+6kv9sBH7?=
 =?us-ascii?Q?qIG/niSPr3GNk9J09adRYjBPFX1cYo06p1FuhytPAM0voZtePTKb6jtXJduX?=
 =?us-ascii?Q?VIBnWu5fZ8CuHNzD0UbztJXE8b/k0P1XKMNM+Fkl9ssVyC5l6WPIWI8oqTyb?=
 =?us-ascii?Q?r2QaodxRevHsv9S3qS4d7GvMoTwWXrievERRaQQJvltErA8i7uhoDAeRxX4o?=
 =?us-ascii?Q?TyY4h8s27Ud4dbJ52y30Up+zuQkVE+fvr2t8hV8XwW9dp0sBWMVy4Qv7K7/J?=
 =?us-ascii?Q?w3T6hDiaqpjYgxogKDncNgJMQpfIVjnxQ+VJbdoKxVBIKqyteA0FLuRWFmpu?=
 =?us-ascii?Q?vr0x2rGdKYxuSHE6zaTC+vTtxJ4rG2BcxwhtO3DUi9aAb3J4Fs1OVbtbvKGj?=
 =?us-ascii?Q?Xb+yyIdPxYfYuuCMEbkLnuOyti4adu+M6wBZ5NwowjYUuLIsUeL5oopzSa5D?=
 =?us-ascii?Q?MtW/azeQz2FX5j8JUHlwkNDx0H3CVs0MSnWbIppoSN+kcoZXZR66iRWHQ5lB?=
 =?us-ascii?Q?gMIzohNJSbVVIJi64Q4BASP1JV2X8cZ39GBCFxx2birw/bQ80KRLtO3MHWOW?=
 =?us-ascii?Q?lF1B/BCp/jBk2R/OEp+iKsYVl4NlWx7ygxMmoinJYdQQspJzb76AcV2sJYYU?=
 =?us-ascii?Q?9Nge+4MPwW826xJI4xrB0lHF1vXKHw3ZYOfIs4wsXWgxjwkthkdkE283/35K?=
 =?us-ascii?Q?YQXz0jObRY4R6cGwYtn4xOp9yRCpPgFdTexKetG+c13hQ5bwa4OY+QehFXKk?=
 =?us-ascii?Q?u+vjI7T/EuCujzQcmgkXXhlenyLfZvB89QchfuiyT9Up54EdmaviPxvAvKOJ?=
 =?us-ascii?Q?N5pQSUXoauFewCO4sX0gLwLedmKo5LmQInrLD7HA5TKt1jnA27jN8kSHwS7z?=
 =?us-ascii?Q?vFeGrFv53Q7BSZ28H+4Vv2KHNyfjgr4P/2Ou80bKTznGC/Cgz6VF2xhB+hIx?=
 =?us-ascii?Q?h194PY097cz5r57yUe7ZSwvlqiJsZQ6nBex7VPxOpxVU5BJJ9D8m0LmmOyoB?=
 =?us-ascii?Q?DZfe+6dfMzt54WgsUPTJ0Yqj/aWmii0IA2VLQ+yux4S6ygAdIvMrioj7qJ9B?=
 =?us-ascii?Q?irHgXmwGyN0AbEbxNUKRTHJPwhKXhWHz39UK+jZ7xUIooJ55sUUIUDrM5KQi?=
 =?us-ascii?Q?X58pGSYeyxh2mPwZnhF50F9JhM0pQxvSxUbRxxtMu+mn6k8RGKucjqWaaxs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad089fa-90b3-4f3e-9de9-08dcaceb5d08
X-MS-Exchange-CrossTenant-AuthSource: PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 20:50:06.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P223MB1064

On Thu, 25 Jul 2024 13:21:24 -0700, Andrew Morton <akpm@linux-foundation.org> wrote:

> x1:/usr/src/25> grep "  pr_[^(]*.*: [A-Z]" mm/*.c | wc -l
> 34
> x1:/usr/src/25> grep "  pr_[^(]*.*: [a-z]" mm/*.c | wc -l
> 97

Huh. I guess I missed a lot of them.

> If we're going to make this change then we should change everything,
> add a checkpatch rule, etc.

If that approach works, we could do it, I guess. Sounds like a lot of
work for capitalization changes.

> But I do think such a change is too trivial to justify churning the
> code around.

So how do we proceed? I could move onto another patch, or, as you said,
change everything and add a checkpatch rule.

You're the boss.

		Steven

