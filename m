Return-Path: <linux-kernel+bounces-339142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD598617C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E79EB308D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FEF1AE874;
	Wed, 25 Sep 2024 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bbZT9dkA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="EtH8K8tD"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD518D63C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270686; cv=fail; b=XdEL7WXahwNQQ8vfjsDKW31Z5WiULvInwoqdFQbI8jPtT6RvoC2HM5tX45GMMTxIX6xccgtsrQ4P9LkQZ1qhSJzBU2ovxbXv17h7cMBM8tBcRncpoqauqeLTQuhv4AMVLMOcTWnjydF/Apr3a3mEX+/I7qISimW5IGBP5KJGO84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270686; c=relaxed/simple;
	bh=eisW3SBIVwOZU6byfxqbeAuBkiCC3dpFYJhzGoq1knA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNLpMMOksN0H8bdV8BrqQyeejDXKegDcAEOgpzNldp4L4KWo1nEoeghFdyIwId2aH1Jog9NWpeeFEk5+T9Df7Z13beDl+SHg1qUWy/1xTe9bI8vOn8M1AMs4yd9UThyW4U1E6f8WUdt+qJFt9WzQeLgxhlAM+5wX/TI0xq00EZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bbZT9dkA; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=EtH8K8tD reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 01564349655
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727270677;
	bh=eisW3SBIVwOZU6byfxqbeAuBkiCC3dpFYJhzGoq1knA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bbZT9dkApxj08wdQ+wlCWgYdR1sFJH9vLkS2mH/Z+Md5raX6hQ6K41d5AfP6VIyic
	 mJRoe+zQK8QFQ+XWAkQCxVhaiui0CxRZNwebjz3U3897AROWXYLgiFA7chk6eKMMZl
	 LETupCl+3Jh6ODgXKJdZ0u1Wzjps4ML1RpnfXkhY=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id BA29134965C; Wed, 25 Sep
 2024 15:24:36 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx601.security-mail.net (Postfix) with ESMTPS id
 445FB349655; Wed, 25 Sep 2024 15:24:35 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2543.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:24:34 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Wed, 25 Sep
 2024 13:24:34 +0000
X-Secumail-id: <ab3.66f40f13.42078.1>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/KCqzohJEdvZgRbnrrmKoc4nc9xbnlHSvIBcapef2l5jUjTKFTrNXJjJz1+XM0p6E/BRvvZVMkLR4Dl1TsKu1/jBo+zQj8tvBmUpvicQARIclQWL0hprrCQafoEElwsnBmuiFvpSr4bBGdbRrq4SjkZsEHPdzc2+uXsVHTNe4xJ6jOdnJn1GvQOlfjZpgqfiefnjAQOW27HJ8RMyg7JgJ/qZDVYXHcLuk1iqdmuagPD8OeeutpGRBwjzDZJniCobOoRwyo8WArmAaQLQclUAw1VgLNmULRNyK0zX5hU88p+TgJLsqLiqcnpJmAnWHPudQpaL5ii6H5no+lJ32qjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXFM7S6Vi+7rJo9WQg8c5X/ZkfhFn5Zye+NI5Q+SVVE=;
 b=dqM+09NNv1E0wFpEB07emZBNYBQNMg0q0D1//FWuSjCjjmktFnFtK8WQUhYZhDEj7KJrikbzN8f9nhjhyrgF4imVzF45FEfqRR7bOhvb3te5nNOtARPO4hb1Tl6LIU3NCL7ztCKB95alxl6CjfndnZsnqs/DSYhZTglJFQIFWaI6DSGtJZVLwmNqfe0/4xyfyPjA9MxrnOUsGSsRagBD2mGr3RdITQPRgVUjEXDfLNBaj/OXxPEBeF960ySsHNUXOY6Gq0qDlUmeB5rkBcYFmURK1bEmAIAawoKMBHlkxHRREyM74UNnk1YGAcoWW6R2Z1aw9025nxt5hFmYztzv7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXFM7S6Vi+7rJo9WQg8c5X/ZkfhFn5Zye+NI5Q+SVVE=;
 b=EtH8K8tDSddSks9PiSAM+GYdEOY0DPELcU0yWutPttmYVcZTrV4hlg4kgCwey14MQ5J1l1/Yfg03mvViEfKIH6FXzzxcDO1HhMOrskH043k1xsHOsr4GCDO16RobeCUMK52VSeSeXlLj/q7g9bl6mvEwIrsnNhQdv3yVbc04xt7SUann57g/ILNqz38VQgzVldxrnu83b2/fmz5cdlx4B7AnzPkCwByPEdClPNn4UlxQfr5XYNM6AHxJHhdJRwm1nkFfVZ8tXKqY7/OJ+Figs6iMPMDO8aoidmTLJmNcilM6bdRuZLl5R1gddw++nW9jAFBCqOr91hfm1yXcg6+V+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v6 1/5] Consolidate __memcpy_{to,from}io and __memset_io
 into iomap_copy.c
Date: Wed, 25 Sep 2024 15:24:16 +0200
Message-ID: <20240925132420.821473-2-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925132420.821473-1-jvetter@kalrayinc.com>
References: <20240925132420.821473-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0138.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::43) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PAZP264MB2543:EE_
X-MS-Office365-Filtering-Correlation-Id: 30065667-2947-4e73-c280-08dcdd656556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: zDBlCoq9ijUe9lYrR+M6zFP7bC8ptRFCIzYfMEbW/b5yHpRW6bqvqn4jP4Awvg2rVx6B/8liHmGkKeWWMxcHbll5nipjFWo/Kf/OutJ8NTRCy1hyqEWG7Ho/4f1jtGaTyZp+E80bVxbN7V42ueA6h375uNqYtFSjlA5Q7WOdIaj2LF7PVIwYkmu/rjOSir0lHF5SouNiBXr+1l1eD6fyhcSfTen6fNZuIysJX4zpizMMq62JfkRLsRPwc5Xr9QKGKGgk94wm1ufrS+bjXK2akI/TverOgoxNYJK0cAD7FQOHu0N1IUe3o2UmsrIs/rVFpT+hwNkrliDFIbeG1CO2kmB73478+9LWTepFlACjvE0r9lQ7LlbAk1/Q/iyVae7bPVtb7ZDqfNpRYnbF7oQpoRSFpENSOyH0LvGRWqDH3/9Q7MZccRw7vrMj+2qXh4lewhQE0mtatjxGPGavIGVgifQAdQoJ0fHkOSlPC3a15MJQ2OfGFDtF5PuCb2cl6lv5p7rMqcF8AWoI6FU2yBX4XyGJDI1t0cc8zIuXdNI1l+WXwdDW8vGh9bffDvjdZtSxT8HMRR4EsrqTLX/b/QQR4y9myRfcm1lNGza6dl8993K3rAJQ6Cji9dSG30DJtnqp9rStn0czG2ysogOtQ4yyNL/Vs+Fp6GrZpIyR+9SKkPQhhpsDKe5VGcBOZ83qC8maOUa9NGtlqHVdQHnuk1U0oE/19DN53cSRTllhsiijLKiKHKgFB8GaxeSEXImqJavGvhFFp47W6G2VQhPPYkC9hgjMJQ08J13f54dBbikh8BzgoDZ5H3Kuv9cnOln9QAQjsvidWm+TmeBDFz2ZcXCk2UBrUKnAhlBQ9oguMwvJfXP0aJu1HaEMUywH1jg7PEHPVbPdpmtou+iVGDT++UEmyx2T1JOKIyD6wjamC1m8f6/Ro1Abw2qygv+gvpMnYH9NnHi
 jaAqpOgWU68R4OspR+vkJRMKvXzY7eaFQ/WpvtWh+GpqASJivxWgsY+btgO3yufDTPeXNCFohWnOVFUcIYHYvRhXXATqE7WH9X00zdF8s1+GtxfhFso+/+gJvSIOTu949v7vlooBnZ6Xmtm3o0PPbpXgIRS4B5oIU7KRNMFHX1eMAhw916NrrcznrZlCDV1kHLQNTxKwIM6bDCYKeUiGE+P4YCb30k4O3CCDXw5Gtwl7NKYRKNzGIIXo0d3ZQ4Q+1qlbPjGXyAavEMu/Jm5EEcC95cgiT6TZKWD8ZG2JiPza8g6O2CyMc4JFXq54t0EwBDJXVKMiSg00pQD4bwrEEgJoTSM8mJAeZGzT1WtV+PgnE+cxklTzv4z4jJ8GMNoanp/DaXX8CT0NV4ArcwE6M4u+8ng4kA259AsNWTAhGC953AeKaDoNCtTZ86BpFTul9BU2Uh8ZekQBt8IIhMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A8/AFkQclqh0E6JNLZao2axZu2+pwkwVn/8+TLwIUBANlhaV2NfkghIbV3en7GG11I7tYbcR8y2Ks331QrECDy4q2YOVVUwrgSnoZVicKPaxv/naPuewi5rC+bxuyUXpS56O7HqzHNH/ymwcfweF0zx7cu9qKpGU8ko4aD0seepjMyexPY4nbJqC/+ahgnTTZFZJAP05beMldy2u0jWPJSTySbmdcDHa9d6QP+jp+cMu4EeW39dgNWz82P5WXOUCFYX2eBpoUn1dQIIqt89n8NrkYsjsAGQUKxwtkG/qjRpW7t2hsn2yOnpo/JttfMFvq3aUKA2zZR5IX+RVrU5fV7ASX7N6tK8Vir4V87CO4YD1lPpvhRUB4SuLYes9zWpWIJxu+uwgLilgp7e0LtQGfmTg0yAQJydezsiGj1uEYpSpbIc0BsB4NwfpvlVByf0FhrcA1ab7AwNMyokCGznd452MJCxcekhdl0T1DhV9CBMs7mfYelx8PZYu1V0IAIb6/DcgJxAxMJdU9+VOMAwEbbJWXyaZ4jqHsgzfmyGGCLP6Ara0KBPq4nPDY1hY7n+6EAzukM6NS3ODRR0q9443FutajWh06JrB3aGEoJ2jBJ0xgBymUMnaoc6J/ifi4gSS+RBANBbFGTjJRpSqWf3ycz9hKLrbR3kwIBNcboTWToqlA7ronzvQgbFygCUjuRwVM0Xh/tJ2HqBJfOJcCizHxWayA8bI0NVLfNkYVrFQEmxdHYSPrmClULSSdWozfK4Z6REt5G7lKAg4lfZQ2i3vrISkhCzQ0yJ6oSyjUFFpfaOqt02fLLSdiEoxxvOXTFNFL439gUzb8UV3qxP7p1SZ6HhgnO9l4LWz9LlCLbduSX2U+mkitGuPLQCTfk+dG0gUUh3vIRU05cA4rR/4vhRHZyiXn/zM4UwiiWUpp5txcJRtl4Iq+gkMfFgbv8xlSx0W
 idJjrQqNEiwqZTlrm3Gr2CMAn7nexkbSOWv0vLdFhpYQGlKhV6HlzhS15HwVCb+DldkSitd9Nku9kvwwKDGu4kJIO89jdlIMz/d5O+MkScXLRvWyBNp9aeuIjaCtF04Nvojq21B/h516Iza1/yo2XmVh5vtiOgXZMpg8/+lI0R3r7v4P1qTadKimbtA/ApCKMYRI3f5ExUkispjxRTwdZI7olajgTpNO4BvSsK16axll3WYb76CMD/NYxh5MoCJXiR401ByAUsw0dwHdNuPtEzyAG5yiJu0J9AKukuosx4Q5EclaFNiNyABpRdnUXG3jy6eSPvS5PGNHVjfAMWN37EPHtGD/FXqV7MgIoHEE3G38EbzD2zvhPADLIJp28LSOI89Y+gpQRmmYYmYTfm+qxq2O/S87oiheUXR5XI3IdqwRerwHKNxRKC4aBGVqrxsNrWcVF6Z436/N2Pyed+yoAr3PfJyv1jQQs43w0/o+HAB6zGc3Zgwr8WOjIUYSYSSGJl3wVJKvS47RHqB8fYSBsUYVMO8ayrBTI5EzTSeYDzZDbeTgZty2Smnbn4fbKneDfF5+bk+4l5qmxPJhjiWjgXiCblS7cScHuuSRZfhmkNS/zLwTR1nAGSo8Mw4nQGX4
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30065667-2947-4e73-c280-08dcdd656556
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:24:34.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaJrsY8jFtxjBTahp0KvK+Kbvh8OSxbuZ87OHu0JQNIdVm/COv6gMg9AXGTqZYHCM23BGiz58CHz5q0qFMnCSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2543
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Various architectures have almost the same implementations for
__memcpy_{to,from}io and __memset_io functions. So, consolidate them
into the existing lib/iomap_copy.c.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v6:
- Included linux/aslign.h
- Replaced compile time check by ifdef to remove compiler warning
---
 include/asm-generic/io.h |  12 +++++
 lib/iomap_copy.c         | 109 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..9b8e0449da28 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -102,6 +102,18 @@ static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __i
 
 #endif /* CONFIG_TRACE_MMIO_ACCESS */
 
+#ifndef __memcpy_fromio
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count);
+#endif
+
+#ifndef __memcpy_toio
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count);
+#endif
+
+#ifndef __memset_io
+void __memset_io(volatile void __iomem *dst, int c, size_t count);
+#endif
+
 /*
  * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
  *
diff --git a/lib/iomap_copy.c b/lib/iomap_copy.c
index 2fd5712fb7c0..c2cee6410151 100644
--- a/lib/iomap_copy.c
+++ b/lib/iomap_copy.c
@@ -3,9 +3,15 @@
  * Copyright 2006 PathScale, Inc.  All Rights Reserved.
  */
 
+#include <asm/unaligned.h>
+
+#include <linux/align.h>
 #include <linux/export.h>
+#include <linux/types.h>
 #include <linux/io.h>
 
+#define NATIVE_STORE_SIZE	(BITS_PER_LONG/8)
+
 /**
  * __iowrite32_copy - copy data to MMIO space, in 32-bit units
  * @to: destination, in MMIO space (must be 32-bit aligned)
@@ -76,3 +82,106 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 }
 EXPORT_SYMBOL_GPL(__iowrite64_copy);
 #endif
+
+
+#ifndef __memcpy_fromio
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)from, NATIVE_STORE_SIZE)) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+#ifdef CONFIG_64BIT
+			put_unaligned(__raw_readq(from), (uintptr_t *)to);
+#else
+			put_unaligned(__raw_readl(from), (uintptr_t *)to);
+#endif
+
+		from += NATIVE_STORE_SIZE;
+		to += NATIVE_STORE_SIZE;
+		count -= NATIVE_STORE_SIZE;
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_fromio);
+#endif
+
+#ifndef __memcpy_toio
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)to, NATIVE_STORE_SIZE)) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+#ifdef CONFIG_64BIT
+			__raw_writeq(get_unaligned((uintptr_t *)from), to);
+#else
+			__raw_writel(get_unaligned((uintptr_t *)from), to);
+#endif
+
+		from += NATIVE_STORE_SIZE;
+		to += NATIVE_STORE_SIZE;
+		count -= NATIVE_STORE_SIZE;
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_toio);
+#endif
+
+#ifndef __memset_io
+void __memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	uintptr_t qc = (u8)c;
+
+	qc |= qc << 8;
+	qc |= qc << 16;
+
+#ifdef CONFIG_64BIT
+	qc |= qc << 32;
+#endif
+
+	while (count && !IS_ALIGNED((unsigned long)dst, NATIVE_STORE_SIZE)) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+#ifdef CONFIG_64BIT
+			__raw_writeq(qc, dst);
+#else
+			__raw_writel(qc, dst);
+#endif
+
+		dst += NATIVE_STORE_SIZE;
+		count -= NATIVE_STORE_SIZE;
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memset_io);
+#endif
-- 
2.34.1






