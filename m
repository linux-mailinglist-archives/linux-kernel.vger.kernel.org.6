Return-Path: <linux-kernel+bounces-268435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463E94249B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8AC285586
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685E01802B;
	Wed, 31 Jul 2024 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jDWtmkpC"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2094.outbound.protection.outlook.com [40.107.105.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6D17557
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394551; cv=fail; b=bi/DwdlNhiAwP/8BaO30Sx+1+286wlU0C6CuhM08O4DlAKtYtiIg2cxGR5qwKqmNwY2/U5JNHv3vq0I9gtJivLwdyD9F9zmXRtsbkeY1amWHXlN1E7WdixXnwZurRel/BrJmOU4r9QbPonFwvsPiuc1Cs6HBFOH/d/n4CijTBbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394551; c=relaxed/simple;
	bh=D+gYQa4l9y1xIl9eAInejgzhL+rGW7qrSueCtO9U9qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ev3PFkBluWXAaouVmXlB0Cbod8OUyY3KzmUgukkZT0s7xibWnhiKiQsdlOaQVPg3VGhfELqEKy1ITWJuInQe4hokzd97WP1x7uWlB1VMMvOYfO3I9pO0NSdLo7jaj/BC+nY61w44zrSpYBNd4yUyvD6T3aOtaL/n+SAO80Qtr4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=jDWtmkpC; arc=fail smtp.client-ip=40.107.105.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGLQOsCUiz6k0MAw5yNAQ/VVJYfaBFH1jbZrAJvvioLc/+av6i3ANQslPscemKOcO3xUbJ6tEaEB+ArR1PDGSdvSul6nwa8w9QjhTVP+B0TAiBVpT7xoVbub5KROyjMpXFZwwg+kTdi9mlBMfF6RxsDyRKuid8s3+lfAv0Il7xxXo6elaKM9+XyDqJTF4aylRqsOQWeKP3T9U1qxCEKMnL6VWx8YU2yLrRFG2S7la/vwlEjbgRNFGylcb52GAjWH+xJTKUu80g2SHWZ6sPK+RDThai3NM8TFYKfh4D1MYVZvElcqYxygXjknRiiQgGwDvz30wIQxfTecs3AJrsZROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKeqphtEOBju11zfTP+TwSqnt0fLzZERCrRNXEXf0YY=;
 b=h67uS2lnqHUkjliWPOc/A+F5qy+RBAIiKrLWZkAJ2zll43FriVd+W7LhdzLB/pW8zMtxQOhCcVOXgT/8DtZRTLELium66SQtl+H327XulvseSdOV6oroK6nek03QS166VxG9UkmbB635a0THFGCAux2BCdRgGDC7brg++s1XUK4BO31TD5QnZACAC3RkOwj+edoQW9txVnoZsMwhAusCpRQdZvUOIz8NvLUsRn+0v0UP960c5HzUPD8TkgJ0x7W7KfsODDt8bOrRLmVRUvyyoa3WGZUZNSLPjWrGxmHSQ+qaFPvBdEVCF7sEzi2/misttqBLCBqTgUOebozVP1ja4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKeqphtEOBju11zfTP+TwSqnt0fLzZERCrRNXEXf0YY=;
 b=jDWtmkpCTQ9NnySdmhOL6e1iL23jZZ0Xemw+mnuxws393RFQdduc9gUyYQ5EMPozBoba07zxHLj+HAM/hKiL3Gw0gAIu+Tuf39/c6DALoXyVwKh20ygyFrA2PO3654uby0/82omfEl7wTyN0uz862NiszkqRbdZ/LcAeUd7CG/BfnH64pC/POZWPUCo8AcCL/JvgjqjjyHgJaLXYbfA2JXhOugjFNw6fAbzuiLr7keUOOKa4R2inmP/0ayt2tE4ncmpqELJb/8XMcj/f75lkv7A/eGJcSg5Z4nMpp4J4k8KSKtgVKpKHLJqAOCseua+fTGEJ5gVX01W00ljPXKjgWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AM8PR08MB6483.eurprd08.prod.outlook.com (2603:10a6:20b:315::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 02:55:45 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 02:55:45 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Chen Jun <chenjun102@huawei.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	kernel@openvz.org
Subject: [PATCH v2 1/2] kmemleak: enable tracking for percpu pointers
Date: Wed, 31 Jul 2024 10:54:09 +0800
Message-ID: <20240731025526.157529-2-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731025526.157529-1-ptikhomirov@virtuozzo.com>
References: <20240731025526.157529-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AM8PR08MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 720c689f-365f-4b35-6e8a-08dcb10c4629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1DvqCoG5JwbSXEFN7ffASGQD9x2xjVwVNsqFTWkEwal6rUBEHxZ/UUXLiTig?=
 =?us-ascii?Q?POZFQzmCK6ohTBFmQPkCy5WFQ+QrGXRy121YqnozZGzFolhutX9ViqVzarFF?=
 =?us-ascii?Q?apESHSdmbftamhHuikMwK8VMXSZtk5zMrljjaG5o6lgDNZnRNDIqeyjeh3q8?=
 =?us-ascii?Q?oqa0DOy4G0CZT+Xgw6P6dXy5Aon0GZReQWnJ8dTZYywcQeqbCPjKki19KJ6B?=
 =?us-ascii?Q?1GNO+kQlKvPUrIV468AqZ9Vxb4Niq4JSCImIvAkpnpIGiqRyFvWZPeJR1l2D?=
 =?us-ascii?Q?lsRASJOtYpOI2dTJXEx3uuWCnMpBKtYr14eQ1FVh/PuQ0RGclEIV5omyEWc5?=
 =?us-ascii?Q?TyhKX8T48wGheBN0vql2xyUvs/4t7gw3kzVA1iSUiPZEutryJ0PB/Dbe3BGN?=
 =?us-ascii?Q?eJml5+povBvmK8lreAHJhTyibaChPQxsOGQ5jastWzcX3AlqTtHoY6vZ0ut3?=
 =?us-ascii?Q?+a+0BgKTsp+GXqzsxO01WG9wsS+AVaANOKuJLOvt4uYTzQxQ6wSFTwwdnMYs?=
 =?us-ascii?Q?SsmKIbE2t/6y418wkZZ1th2jj1fo/Fcc4oRcExynNrmb4HkQA1pZD66jj/eE?=
 =?us-ascii?Q?xys1rupR2y2S8gbFX2xi231X1lPaKi/syiVgnZWEAIS3E5/ylINa6N+nCtMh?=
 =?us-ascii?Q?d0uZYvbdtkUDKyYHTLOoAr/ckuKCueMQhKPpKB49L79ztRe0QkV2hcqo5FgQ?=
 =?us-ascii?Q?7gVz2Vk5k2TEk7VSGlijNQLtbbQI60JIZwYNHZznYUG0Klp5uh5y0LcWGkJ4?=
 =?us-ascii?Q?ipynX/xOsCtxdVtDpDaLo/NS6fpnXaWOBBlYxU0DKk01k78beeXYwDvch5Sy?=
 =?us-ascii?Q?63ZeOvqpTAmv5psJn1DNOjS8CmjagP7EXfnRgCip5YJaseaGryXZ59fok1K1?=
 =?us-ascii?Q?8jh5KkLIlDHzf3xlFJKHRRzM5WNLocMmC4x08catPEL13uyPlpZ5Z/0z1eqf?=
 =?us-ascii?Q?m0TCI2uAlA8jA7ARqIz4EYsnekOIEQzST8kYw5FGhZQwkxk+8fXdsSGKO/SC?=
 =?us-ascii?Q?d6VBSm5WwomoEa2ZXUM7P4LClEbSQChDZvIUvijueOdGBDr9+ZwBS/BIYMG8?=
 =?us-ascii?Q?Me7imZOtj13RV06pOuJtYkc/za6Dr+RZtKGIf3LMeFEmQoiNTng716Pd/Cv5?=
 =?us-ascii?Q?T0wPH7A3qTViMHJj2UOLsPgiTF+OXeJt4KE1qy9TyXZhENXGrMlR/stxzNPV?=
 =?us-ascii?Q?i71DkWngElOxUkG3qg7TtM//IotbCBVY+d+pm2oRIRoy7qiDZQEwv4rNPEVQ?=
 =?us-ascii?Q?qtaePTsPyXyIa5XCU3QXf7gzvYf3DWWMWRW8u/yGaFzEWWo0zhn0jXdeAKI1?=
 =?us-ascii?Q?RSEEInqqJeoDVqXR4vF9CjsjnDceTd30fWM0LZn31wCSjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5gZj7LdCCZcA7Z2CBQO73APmijBflRIb7ae25vCUCxAjNmBiMPZVZkPM2O+M?=
 =?us-ascii?Q?9ZEnXPYimSoHeN5NIqc0+0D+/WKQ0iNJOMkrS42Gs2ZzaxU7GuNAec9ihUbY?=
 =?us-ascii?Q?tioHyaUMYy00vcw+N9YvcFhG7k5Lu2Xzx08aTDitI4wmIlcVqeDmTlaAcg+M?=
 =?us-ascii?Q?Jtfqrawa47G7NiQuLfRCEOlwPMrwz8YqWECSTc1suowI4p1J6JYT/F2xSINv?=
 =?us-ascii?Q?TIvunPXPaGD2lhwhvCDt3JbUxJRE5Y1t0yfzJ6M7LaEb4x301ZcAGrvm6puW?=
 =?us-ascii?Q?IwYnyZhOIP3tYmp6QKo73PLMogQ9t7HSv4qek6AZ/TJ+bT+wxxi9lhnpowAV?=
 =?us-ascii?Q?+Dv+6HTdNMCjEENeD78gG7JKdXiYqBgKLLv4lwdnvr/L+iAQI0k0ti3h1Np6?=
 =?us-ascii?Q?qHyD5DnGwmgoX4/93U1WuIh0g2orO2WYUPlbToX1WAaBrS07sUj3KBffZbC2?=
 =?us-ascii?Q?Sk+IhS93seerlUUhitQr91QAJzbGgPx7uCVbZ4shRe5QNtyFpStFigAAe2nI?=
 =?us-ascii?Q?O7nCgMcfDv3QKZpHlk805OtpfiHedC/XF7FwtglZ/tIjIyxgs6Qnj5ky4zgV?=
 =?us-ascii?Q?acwVBcW/FyebuCOeeRmap1MisrUHyu+j3JrlqydiGE1x+lJqvM0WJwhqA7oM?=
 =?us-ascii?Q?A2+cRbnm72XSdjeMExWnqbJLM6jPdZ8CqMRMdNBQApMVEtZaHoJqvl9JN7eI?=
 =?us-ascii?Q?7d2Z32vf0pinzJ6gjX2WwjVyw5Bn04Hvtr676LMxn/rsHiXYaw3Nzjw+e16H?=
 =?us-ascii?Q?b3cjmVMXI5RlmVBGaQvnPW5MJBmM942PVs/ZHZNFqyKFhNubLISS+X+Q7aDV?=
 =?us-ascii?Q?FCgy0In3kSxe96WLqHStYyxTnHF6tjURpMHUGDNS8b1IwKOD3TS15TBFsr63?=
 =?us-ascii?Q?t5esAeUUYwVveZ9kjIndxmSjjxFhBL4wgKIGiE12Vtg7LDlA/bIjsYL2n4NN?=
 =?us-ascii?Q?OzbFY5HK7rnpKq/x1AmQ2a0VGteVbEueRltlTRRxGzwDN0oTFOM2TsdEyIys?=
 =?us-ascii?Q?CoyAalTVqmywq+56dPPjRQsELytHAyg0cqsG6MDqllR4MZPIipg/NZpde510?=
 =?us-ascii?Q?hOUrunWC/7znBVf0xpQvXQuLky7/fI0fqQ2NwTZVYvybcy7tvbNJJm/FCMaz?=
 =?us-ascii?Q?to7rRIjwFi6LCJWEO5u0QUK6wdk3QgIvG4QWQTHWEnU2dyAq2vXTM4FkVM/V?=
 =?us-ascii?Q?EKe7cxw17hWbmFORNoG7gtZsJtbLEU4dNOdTDqHIz0uz/E0F6ZXYdIS8ONCG?=
 =?us-ascii?Q?dVcmeb/1x2SztxLd2XwH3wQG4f5/T44gYpk8cyAewNoOtSJvv7v3xs7WPqnA?=
 =?us-ascii?Q?NI16aHIwV38l7iPArNJ8uVcIL0K4jt9cUUBdBTdsYFsauObMvpUMog6ixX4L?=
 =?us-ascii?Q?wqah7C0x9JRT1SQO5cMPfLxlR4K7cUMcY8OUFZZLoDtvELkMe3C5PJv6nEo4?=
 =?us-ascii?Q?xqF3XR4mbO/O8rabEayLyIfOb4ZgMm0twJNAwCT+QXiTWFLeI44P54T8OSHV?=
 =?us-ascii?Q?Vpv2n8NEf3P5WXAHeQPMDOeAxrG/twQn9dx0PIi4G9Sv9/bQPdBwZg+v1Ix0?=
 =?us-ascii?Q?/F/r/huJyM8bcjR/6U1uj4gwGZnZ3plMmIsueT7AqhtH29ErNbMyP5eUE2Pl?=
 =?us-ascii?Q?Iep4jxafK8VhwhBsK0RR2k8iPnyFmxY4MS7h1EtSQ6Ai2qUeI/4fsEmZTHYD?=
 =?us-ascii?Q?p6mm2Q=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720c689f-365f-4b35-6e8a-08dcb10c4629
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 02:55:45.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwuAj9dAKqcsW+MIdkw7KnQ+ofNUWQytTpFCUBYvOFT/W2YB+rjd1V43Wv8bcNcJtr76Ido0eIySh6lLm4u8n6xY8zO1XZ7Pdp5clSjo7H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6483

This basically does:

- Add min_percpu_addr and max_percpu_addr to filter out unrelated data
similar to min_addr and max_addr;
- Set min_count for percpu pointers to 1 to start tracking them;
- Calculate checksum of percpu area as xor of crc32 for each cpu;
- Split pointer lookup and update refs code into separate helper and use
it twice: once as if the pointer is a virtual pointer and once as if
it's percpu.

CC: Wei Yongjun <weiyongjun1@huawei.com>
CC: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

---
note: excess_ref can only be a virtual pointer at least for now
v2: rename confusing scan_pointer to pointer_update_refs and move it
just after update_refs
---
 mm/kmemleak.c | 153 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 94 insertions(+), 59 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 764b08100570b..6b498c6d9c34a 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -224,6 +224,10 @@ static int kmemleak_error;
 static unsigned long min_addr = ULONG_MAX;
 static unsigned long max_addr;
 
+/* minimum and maximum address that may be valid per-CPU pointers */
+static unsigned long min_percpu_addr = ULONG_MAX;
+static unsigned long max_percpu_addr;
+
 static struct task_struct *scan_thread;
 /* used to avoid reporting of recently allocated objects */
 static unsigned long jiffies_min_age;
@@ -294,13 +298,20 @@ static void hex_dump_object(struct seq_file *seq,
 	const u8 *ptr = (const u8 *)object->pointer;
 	size_t len;
 
-	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
+	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
 		return;
 
+	if (object->flags & OBJECT_PERCPU)
+		ptr = (const u8 *)this_cpu_ptr((void __percpu *)object->pointer);
+
 	/* limit the number of lines to HEX_MAX_LINES */
 	len = min_t(size_t, object->size, HEX_MAX_LINES * HEX_ROW_SIZE);
 
-	warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
+	if (object->flags & OBJECT_PERCPU)
+		warn_or_seq_printf(seq, "  hex dump (first %zu bytes on cpu %d):\n",
+				   len, raw_smp_processor_id());
+	else
+		warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
 	kasan_disable_current();
 	warn_or_seq_hex_dump(seq, DUMP_PREFIX_NONE, HEX_ROW_SIZE,
 			     HEX_GROUP_SIZE, kasan_reset_tag((void *)ptr), len, HEX_ASCII);
@@ -695,10 +706,14 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 
 	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 	/*
-	 * Only update min_addr and max_addr with object
-	 * storing virtual address.
+	 * Only update min_addr and max_addr with object storing virtual
+	 * address. And update min_percpu_addr max_percpu_addr for per-CPU
+	 * objects.
 	 */
-	if (!(objflags & (OBJECT_PHYS | OBJECT_PERCPU))) {
+	if (objflags & OBJECT_PERCPU) {
+		min_percpu_addr = min(min_percpu_addr, untagged_ptr);
+		max_percpu_addr = max(max_percpu_addr, untagged_ptr + size);
+	} else if (!(objflags & OBJECT_PHYS)) {
 		min_addr = min(min_addr, untagged_ptr);
 		max_addr = max(max_addr, untagged_ptr + size);
 	}
@@ -1055,12 +1070,8 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 {
 	pr_debug("%s(0x%px, %zu)\n", __func__, ptr, size);
 
-	/*
-	 * Percpu allocations are only scanned and not reported as leaks
-	 * (min_count is set to 0).
-	 */
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		create_object_percpu((unsigned long)ptr, size, 0, gfp);
+		create_object_percpu((unsigned long)ptr, size, 1, gfp);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
@@ -1304,12 +1315,23 @@ static bool update_checksum(struct kmemleak_object *object)
 {
 	u32 old_csum = object->checksum;
 
-	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
+	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
 		return false;
 
 	kasan_disable_current();
 	kcsan_disable_current();
-	object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
+	if (object->flags & OBJECT_PERCPU) {
+		unsigned int cpu;
+
+		object->checksum = 0;
+		for_each_possible_cpu(cpu) {
+			void *ptr = per_cpu_ptr((void __percpu *)object->pointer, cpu);
+
+			object->checksum ^= crc32(0, kasan_reset_tag((void *)ptr), object->size);
+		}
+	} else {
+		object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
+	}
 	kasan_enable_current();
 	kcsan_enable_current();
 
@@ -1340,6 +1362,64 @@ static void update_refs(struct kmemleak_object *object)
 	}
 }
 
+static void pointer_update_refs(struct kmemleak_object *scanned,
+			 unsigned long pointer, unsigned int objflags)
+{
+	struct kmemleak_object *object;
+	unsigned long untagged_ptr;
+	unsigned long excess_ref;
+
+	untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
+	if (objflags & OBJECT_PERCPU) {
+		if (untagged_ptr < min_percpu_addr || untagged_ptr >= max_percpu_addr)
+			return;
+	} else {
+		if (untagged_ptr < min_addr || untagged_ptr >= max_addr)
+			return;
+	}
+
+	/*
+	 * No need for get_object() here since we hold kmemleak_lock.
+	 * object->use_count cannot be dropped to 0 while the object
+	 * is still present in object_tree_root and object_list
+	 * (with updates protected by kmemleak_lock).
+	 */
+	object = __lookup_object(pointer, 1, objflags);
+	if (!object)
+		return;
+	if (object == scanned)
+		/* self referenced, ignore */
+		return;
+
+	/*
+	 * Avoid the lockdep recursive warning on object->lock being
+	 * previously acquired in scan_object(). These locks are
+	 * enclosed by scan_mutex.
+	 */
+	raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+	/* only pass surplus references (object already gray) */
+	if (color_gray(object)) {
+		excess_ref = object->excess_ref;
+		/* no need for update_refs() if object already gray */
+	} else {
+		excess_ref = 0;
+		update_refs(object);
+	}
+	raw_spin_unlock(&object->lock);
+
+	if (excess_ref) {
+		object = lookup_object(excess_ref, 0);
+		if (!object)
+			return;
+		if (object == scanned)
+			/* circular reference, ignore */
+			return;
+		raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+		update_refs(object);
+		raw_spin_unlock(&object->lock);
+	}
+}
+
 /*
  * Memory scanning is a long process and it needs to be interruptible. This
  * function checks whether such interrupt condition occurred.
@@ -1372,13 +1452,10 @@ static void scan_block(void *_start, void *_end,
 	unsigned long *start = PTR_ALIGN(_start, BYTES_PER_POINTER);
 	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
 	unsigned long flags;
-	unsigned long untagged_ptr;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
-		struct kmemleak_object *object;
 		unsigned long pointer;
-		unsigned long excess_ref;
 
 		if (scan_should_stop())
 			break;
@@ -1387,50 +1464,8 @@ static void scan_block(void *_start, void *_end,
 		pointer = *(unsigned long *)kasan_reset_tag((void *)ptr);
 		kasan_enable_current();
 
-		untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
-		if (untagged_ptr < min_addr || untagged_ptr >= max_addr)
-			continue;
-
-		/*
-		 * No need for get_object() here since we hold kmemleak_lock.
-		 * object->use_count cannot be dropped to 0 while the object
-		 * is still present in object_tree_root and object_list
-		 * (with updates protected by kmemleak_lock).
-		 */
-		object = lookup_object(pointer, 1);
-		if (!object)
-			continue;
-		if (object == scanned)
-			/* self referenced, ignore */
-			continue;
-
-		/*
-		 * Avoid the lockdep recursive warning on object->lock being
-		 * previously acquired in scan_object(). These locks are
-		 * enclosed by scan_mutex.
-		 */
-		raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
-		/* only pass surplus references (object already gray) */
-		if (color_gray(object)) {
-			excess_ref = object->excess_ref;
-			/* no need for update_refs() if object already gray */
-		} else {
-			excess_ref = 0;
-			update_refs(object);
-		}
-		raw_spin_unlock(&object->lock);
-
-		if (excess_ref) {
-			object = lookup_object(excess_ref, 0);
-			if (!object)
-				continue;
-			if (object == scanned)
-				/* circular reference, ignore */
-				continue;
-			raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
-			update_refs(object);
-			raw_spin_unlock(&object->lock);
-		}
+		pointer_update_refs(scanned, pointer, 0);
+		pointer_update_refs(scanned, pointer, OBJECT_PERCPU);
 	}
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 }
-- 
2.45.2


