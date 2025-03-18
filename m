Return-Path: <linux-kernel+bounces-565345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54295A6663D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B37E189BD69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62451624F7;
	Tue, 18 Mar 2025 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="or3V7+QJ"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC233FE4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742264704; cv=none; b=F/Q9icNMgrkj+K+aJguLegC3u2asVcUDqv3YLi5Ohk16HMOeyKuL2SARiqapBhmgkJTSQ+A0/yXJgFt3xzlYTsVv2+cqtgp6TS4JIQG42UgBlji27UGJHA1CbEi6WPj5KYIsOuQXZfVVftOqdCkTe+Zy75w7J+2ymwRuMun8+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742264704; c=relaxed/simple;
	bh=zzeM9/Wg1R5B2RIYZG3VvLu8RL47bljZAqNUNYM2BRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=LPPq752tUJ0PHUOSRO7uG9uxvWlJjFXadWopsADBSshoWhPm9+Gt+pEMrvTvGqD/CLain4TNWlD1WaA38wiO5S/TsO27wtAji1Rvh0lBaRXRNdsEvn7dzcmwqiDX9XzZpL2/1TZekzFHUGgPIy7ivf7RF9JL9+momMQSQeeTBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=or3V7+QJ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250318022459epoutp01acd00fd3d5ed483a76bf1555ca797ad6~txIN7ITFM1070810708epoutp01U
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:24:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250318022459epoutp01acd00fd3d5ed483a76bf1555ca797ad6~txIN7ITFM1070810708epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742264699;
	bh=7ERCWCpp4Y/e7JtNDwOCreQPuRLkxlN/G1FKuV0jUIU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=or3V7+QJG+F0fXnmKOCFBHnkoRt5a7elGQmvpLYjidbOHxX6qfNWugZYQib0YfNJR
	 UlQ9T2G+t1HFmSvhWlk7z+VclNmEnVAi1xUiMxXdGyljCHQiRvwKwN3UJTEIMrH6UF
	 S9H81VRmjsaQrBweBkRQAtkAS0iaMKp1b5K22xU8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20250318022459epcas2p10f6f4a9a8d63a4ef9492de4999d62938~txINWf3vA2601726017epcas2p1O;
	Tue, 18 Mar 2025 02:24:59 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.88]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZGwfL4Kkyz4x9QC; Tue, 18 Mar
	2025 02:24:58 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.BC.32010.A79D8D76; Tue, 18 Mar 2025 11:24:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250318022458epcas2p31c3deaea27ceca3ecc405395d2cd10d4~txIMTe4xE1618316183epcas2p3f;
	Tue, 18 Mar 2025 02:24:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250318022458epsmtrp1d0320d65cd57b45d0613f03087abc20c~txIMSr_Qh0693006930epsmtrp1V;
	Tue, 18 Mar 2025 02:24:58 +0000 (GMT)
X-AuditID: b6c32a4d-acffa70000007d0a-2f-67d8d97ab155
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.54.18949.979D8D76; Tue, 18 Mar 2025 11:24:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250318022457epsmtip239ce367ae6b57f960d8429644caecb94~txIMCoNNl3027430274epsmtip2J;
	Tue, 18 Mar 2025 02:24:57 +0000 (GMT)
From: Donghyeok Choe <d7271.choe@samsung.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
	<senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, takakura@valinux.co.jp,
	youngmin.nam@samsung.com, hajun.sung@samsung.com, seungh.jung@samsung.com,
	jh1012.choi@samsung.com, Donghyeok Choe <d7271.choe@samsung.com>
Subject: [PATCH v2] printk/panic: Add option to allow non-panic CPUs to
 write to the ring buffer.
Date: Tue, 18 Mar 2025 11:23:20 +0900
Message-ID: <20250318022320.2428155-1-d7271.choe@samsung.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmqW7VzRvpBiumyFlc2zuR3aJp/yVm
	i0fT17JabLsyn9Hi8q45bBb/H39ltdjX8YDJYvfGRWwWR289ZbeYtK+RyWLxgU/sDtwesxsu
	sni07LvF7vHu3Dl2j74tqxg91m+5yuLxado0do/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2V
	vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAjlRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
	5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGd0t1xhLdiiUPFoiX4D4zmpLkZO
	DgkBE4m73QtZuxi5OIQE9jBKzOq5wg7hfGKUOLNuLwuE841R4vnlFhaYlqUvZ7JBJPYySuw7
	8AOq5TOjRO/Vc4wgVWwCuhKTOreBVYkILGGU+PVqOxNIglngJKPEotMaILawQLLE51MX2UBs
	FgFVidPvD4HV8ArYSnQ9/MYEsU5e4vaakywQcUGJkzOfsEDMkZdo3jqbGWSBhMBPdomXtz6x
	QzS4SMxb95INwhaWeHV8C1RcSuJlfxs7REMzo8SkG6+ZIJwZjBJXJn+GWmcsMetZO9APHEAr
	NCXW79IHMSUElCWO3IJazCfRcfgvO0SYV6KjTQiiUUXifN8DRphVG+a+hRroIbFq+15mEFtI
	IFbi8YM1rBMY5WcheWcWkndmIexdwMi8ilEqtaA4Nz012ajAUDcvtRwetcn5uZsYwalVy3cH
	4+v1f/UOMTJxMB5ilOBgVhLhdX9yPV2INyWxsiq1KD++qDQntfgQoykwkCcyS4km5wOTe15J
	vKGJpYGJmZmhuZGpgbmSOG/1jpZ0IYH0xJLU7NTUgtQimD4mDk6pBqaA6PBk9i2v5c+lrfIL
	f1Ov3VI/M+n79MdsR1cLr5qw5YKjWnOONHuYwVP7+f+sNseJyfvn6AcdEjm8PlAi69ktp2es
	ijGsyQX/vFJjF6bP/vr9zLpf+7zK/y3a2e7+x+bKjoq1zy2PNN/t/NizRfLB1GezXXdvvH3u
	lOm1hV/mfJeNv/FB6nJrG9OrSb8KDhz6L/P8yIywnDOnjfqeFTn4+TY/L5zxOnd798nnlg7W
	V21vnPipwPbt/I4i8dQL/9uvyHj1HkreNa2w5qe7qfRVFqP2OZtKFHoXWU8w6hOq53lidc/5
	0gWRn6VLAjP0cs/YRXS7bvU2elCrEHDyjF7Do11O0ZM1uXu2BHuq7ApRYinOSDTUYi4qTgQA
	oc3sQzYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvG7lzRvpBpf/WVpc2zuR3aJp/yVm
	i0fT17JabLsyn9Hi8q45bBb/H39ltdjX8YDJYvfGRWwWR289ZbeYtK+RyWLxgU/sDtwesxsu
	sni07LvF7vHu3Dl2j74tqxg91m+5yuLxado0do/Pm+QC2KO4bFJSczLLUov07RK4MrpbrrAW
	bFGoeLREv4HxnFQXIyeHhICJxNKXM9m6GLk4hAR2M0q8ePOMESIhJdG+ZSYThC0scb/lCCtE
	0UdGid//XzKDJNgEdCUmdW4D6xYRWMYocX7jNiYQh1ngIqPE6e4OsHZhgUSJ7k3PwDpYBFQl
	Tr8/BBbnFbCV6Hr4DWqFvMTtNSdZIOKCEidnPgGzmYHizVtnM09g5JuFJDULSWoBI9MqRsnU
	guLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgINfS2sG4Z9UHvUOMTByMhxglOJiVRHjdn1xP
	F+JNSaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoFpY07KtEPl
	bsuuNavypN6ILstgVjA/ci2f/0/Oj2KT9b65nHzTv1Qu2ekW5vVxx+0Hn3vniL6a6iK07mnu
	mgPHm0qY2Z6pf/8o0/jZb54eZ0RscmHhJIXzV/c57lHaM2Pzau24SRMktzoe+t8r1jYjsWLG
	AYt5OdYu1o3HGxd2fV2s9vTbHZnEz7fffe3cyBv9PGNDp03FxWXG5Q+O2PNVvZCa6mftO//2
	n/2dkxmLsiqnpJ5wFXY5pnZy6fWfZcuL1T4fsm4PPy+my3769rOIaE/O9fMTJn38/+sTj0hq
	SHvqQyVzhj419s9Hr1xxk1iu58HKcKiyp/fSn3B29RPb/7SuW/ngUJFZw8/y+Tu1lFiKMxIN
	tZiLihMBfJ5dguECAAA=
X-CMS-MailID: 20250318022458epcas2p31c3deaea27ceca3ecc405395d2cd10d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250318022458epcas2p31c3deaea27ceca3ecc405395d2cd10d4
References: <CGME20250318022458epcas2p31c3deaea27ceca3ecc405395d2cd10d4@epcas2p3.samsung.com>

Commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer")
aimed to isolate panic-related messages. However, when panic() itself
malfunctions, messages from non-panic CPUs become crucial for debugging.

While commit bcc954c6caba ("printk/panic: Allow cpu backtraces to
be written into ringbuffer during panic") enables non-panic CPU
backtraces, it may not provide sufficient diagnostic information.

Introduce the "printk_debug_non_panic_cpus" command-line option,
enabling non-panic CPU messages to be stored in the ring buffer during
a panic. This also prevents discarding non-finalized messages from
non-panic CPUs during console flushing, providing a more comprehensive
view of system state during critical failures.

Link: https://lore.kernel.org/all/Z8cLEkqLL2IOyNIj@pathway/
Signed-off-by: Donghyeok Choe <d7271.choe@samsung.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/all/20250305044046.1249972-1-d7271.choe@samsung.com/
---
 kernel/printk/internal.h          |  1 +
 kernel/printk/printk.c            | 17 ++++++++++++++++-
 kernel/printk/printk_ringbuffer.c | 13 ++++++++-----
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a91bdf802967..22d193907bb8 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -64,6 +64,7 @@ struct dev_printk_info;
 
 extern struct printk_ringbuffer *prb;
 extern bool printk_kthreads_running;
+extern bool printk_debug_non_panic_cpus;
 
 __printf(4, 0)
 int vprintk_store(int facility, int level,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 07668433644b..6f81a1718f9d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2375,6 +2375,19 @@ void printk_legacy_allow_panic_sync(void)
 	}
 }
 
+bool __read_mostly printk_debug_non_panic_cpus;
+
+#ifdef CONFIG_PRINTK_CALLER
+static int __init printk_debug_non_panic_cpus_setup(char *str)
+{
+	printk_debug_non_panic_cpus = true;
+	pr_info("allow messages from non-panic CPUs in panic()\n");
+
+	return 0;
+}
+early_param("printk_debug_non_panic_cpus", printk_debug_non_panic_cpus_setup);
+#endif
+
 asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
@@ -2391,7 +2404,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 * non-panic CPUs are generating any messages, they will be
 	 * silently dropped.
 	 */
-	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
+	if (other_cpu_in_panic() &&
+	    !printk_debug_non_panic_cpus &&
+	    !panic_triggering_all_cpu_backtrace)
 		return 0;
 
 	printk_get_console_flush_type(&ft);
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 88e8f3a61922..928dd8c7ec2a 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2133,9 +2133,9 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * there may be other finalized records beyond that
 			 * need to be printed for a panic situation. If this
 			 * is the panic CPU, skip this
-			 * non-existent/non-finalized record unless it is
-			 * at or beyond the head, in which case it is not
-			 * possible to continue.
+			 * non-existent/non-finalized record unless non-panic
+			 * CPUs are still running and their debugging is
+			 * explicitly enabled.
 			 *
 			 * Note that new messages printed on panic CPU are
 			 * finalized when we are here. The only exception
@@ -2143,10 +2143,13 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * But it would have the sequence number returned
 			 * by "prb_next_reserve_seq() - 1".
 			 */
-			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
+			if (this_cpu_in_panic() &&
+			    (!printk_debug_non_panic_cpus || legacy_allow_panic_sync) &&
+			    ((*seq + 1) < prb_next_reserve_seq(rb))) {
 				(*seq)++;
-			else
+			} else {
 				return false;
+			}
 		}
 	}
 
-- 
2.48.0


