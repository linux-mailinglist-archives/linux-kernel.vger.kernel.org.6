Return-Path: <linux-kernel+bounces-546088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 656DCA4F62C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC0547A327A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BE91C6FE8;
	Wed,  5 Mar 2025 04:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bCP+rZuA"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471422E3364
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 04:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149768; cv=none; b=JLYdOpYkF6QqJT8jfGEr2XSnCH+a3nRCW/sCOa7+qjGo9L7c0TDdyP+uZ9sBYxxhpqmYi0UK7Nn+JMEiwNQ6vQ2uiAKSWOJEdlY2rHqepKzXqEV7QAfUAkGOe04kJMztPn+KifwIb+dbUDEGo2wG5MmJbxSIFm+IMHARx2BlDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149768; c=relaxed/simple;
	bh=SvEQ5JkryVYSwzdb7oZNKH7GgRigVM5rF/hpijpASjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=ct4+lO7t53O/R2W2EeZH5I37kvLWWnFADfjcXkEzochtLhLtl3r+hYQoOyvZUMMGXwU0dmmWl7RTAP2Fh2U7pPWU9XWexqbRJoN/rvu/uNRKfmnGraBSxsMg4jXmtF7+14Aqmzg4wjsDZNwudsCMjaVUBUJmna9D4hw/B7D64yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bCP+rZuA; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250305044242epoutp01c52ef4c6d899074e7bda42d3363ced68~pznwEBihD3123131231epoutp01E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 04:42:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250305044242epoutp01c52ef4c6d899074e7bda42d3363ced68~pznwEBihD3123131231epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741149763;
	bh=+Z6MHiFP8iZ6y/UmUR+jMtBiTXuE0WeHIOFVj5bxvH4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=bCP+rZuA3uXpJJ88KYtseFswtJKp5LfpveQTawq4Af9nVHmedL1A7UOiElgmmo5Dk
	 B/EPHSNktb8Ez7jsClVsmprtIAL0excVOrYKD2AtTf1SiwCMqEG4qTKsBNua+E9jP2
	 WlzbcRU4kLB3MAWbJDB6XyvAAymHjRA83BqpAfzU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20250305044242epcas2p2a68e8ddd482307b1ef6adeca754dc96f~pznvZDslq2233622336epcas2p2J;
	Wed,  5 Mar 2025 04:42:42 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z70KF6Gbnz4x9Q2; Wed,  5 Mar
	2025 04:42:41 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	59.8B.22094.146D7C76; Wed,  5 Mar 2025 13:42:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250305044241epcas2p45a526aecf91f33b9ac253f561e909978~pznui0LXv2771927719epcas2p4X;
	Wed,  5 Mar 2025 04:42:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250305044241epsmtrp2f23712b340d87451009b7f564d5cf158~pznuiAVAU0314003140epsmtrp2I;
	Wed,  5 Mar 2025 04:42:41 +0000 (GMT)
X-AuditID: b6c32a48-e7eec7000000564e-9d-67c7d641eb5e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.4E.18729.146D7C76; Wed,  5 Mar 2025 13:42:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250305044241epsmtip16bfa2f3d9cdd063c18b30237b1edaa36~pznuTB4Bz0210702107epsmtip1k;
	Wed,  5 Mar 2025 04:42:41 +0000 (GMT)
From: Donghyeok Choe <d7271.choe@samsung.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
	<senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, takakura@valinux.co.jp,
	youngmin.nam@samsung.com, hajun.sung@samsung.com, seungh.jung@samsung.com,
	jh1012.choi@samsung.com, Donghyeok Choe <d7271.choe@samsung.com>
Subject: [PATCH] printk/panic: Add option allow non panic cpus logging to
 ringbuffer
Date: Wed,  5 Mar 2025 13:40:46 +0900
Message-ID: <20250305044046.1249972-1-d7271.choe@samsung.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmqa7jtePpBtsPGlhc2zuR3aJp/yVm
	i0fT17JabLsyn9Hi8q45bBb/H39ltdjX8YDJYvfGRWwWR289ZbeYtK+RyWLxgU/sDtwesxsu
	sni07LvF7vHu3Dl2j74tqxg91m+5yuLxado0do/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2V
	vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAjlRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
	5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGe82bSCqWCuRMXa63tZGxininQx
	cnJICJhI3D40hbGLkYtDSGAHo8SGBS9YIZxPjBI/zjxggXC+MUocXD6bFaZl6ulFTCC2kMBe
	Rom5H0Ihij4zSlx6cZkNJMEmoCsxqXMbG0hCRGAJo8SvV9vBOpgFTjJKLDqtAWILC4RJvLv8
	jxnEZhFQlVg47RkLiM0rYCux9OdNRoht8hK315yEigtKnJz5hAVijrxE89bZzCALJAT+skvM
	v3SXCaLBReLjgefMELawxKvjW9ghbCmJz+/2skE0NDNKTLrxmgnCmcEocWXyZ6huY4lZz9qB
	VnMArdCUWL9LH8SUEFCWOHILajGfRMfhv+wQYV6JjjYhiEYVifN9DxhhVm2Y+xZqoIfE2plH
	2SChFStxt2cf6wRG+VlI3pmF5J1ZCHsXMDKvYhRLLSjOTU8tNiowgUdrcn7uJkZwStXy2ME4
	++0HvUOMTByMhxglOJiVRHhfnzqeLsSbklhZlVqUH19UmpNafIjRFBjAE5mlRJPzgUk9ryTe
	0MTSwMTMzNDcyNTAXEmct3pHS7qQQHpiSWp2ampBahFMHxMHp1QD08HllxofpjdGzHWZtHz+
	/X2yAb99myWCnvMLnb38eJdJbdftt5X3Zi17fPynpt6LAst4Fd81hoYhC2t6tPbviHwZ/Gb2
	hwj+iY4vmZI5Siap31l9Ki8yTH6ypUv4exHBvaocjh/XzGgRWzmrt+LNHz2hXJ07BUECW3+9
	ZlBbnTlRqkLziYXS/femz4UKz7zLnbV8+3uDzZxODqs6C1a73Ws48Hl52u6awsDOLMYlpdUr
	JxYZH1aasf9czKQTW/mvXfL6HVzvfVv8Oq/KmSWdtkZ+5ZN/Hq7y4tjy90tJg5Sym8Yc5YA1
	1z7dE9Mqydeb+jGkV6l73Re2nVqXeF+19DnK98cvvFooq/X0hCGLuhJLcUaioRZzUXEiAJwT
	dvMyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSnK7jtePpBl9u8lpc2zuR3aJp/yVm
	i0fT17JabLsyn9Hi8q45bBb/H39ltdjX8YDJYvfGRWwWR289ZbeYtK+RyWLxgU/sDtwesxsu
	sni07LvF7vHu3Dl2j74tqxg91m+5yuLxado0do/Pm+QC2KO4bFJSczLLUov07RK4Mt5sWsFU
	MFeiYu31vawNjFNFuhg5OSQETCSmnl7E1MXIxSEksJtR4tSTR4wQCSmJ9i0zmSBsYYn7LUdY
	IYo+MkqsOnidHSTBJqArMalzGxtIQkRgGaPE+Y3bwEYxC1xklDjd3QHWLiwQItFw7THYWBYB
	VYmF056xgNi8ArYSS3/ehFonL3F7zUmouKDEyZlPwGxmoHjz1tnMExj5ZiFJzUKSWsDItIpR
	MrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzjMtTR3MG5f9UHvECMTB+MhRgkOZiUR3ten
	jqcL8aYkVlalFuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYDJv5L4r
	EyoQtSj150uZ6pLJtTsz8zvmMESlsW349nPlRWmZo8+/bjund3n/hMVr3zhdjpVbr1Dv7/c4
	uEjoS2puSUbtl7kv31wpW7NwX6XJsYIbm3L1TLb4/PCYv9D03sM/O+02MJx9sTPy/dQHUVND
	9oaHz+g+94nFUeO3Qy7Lznfrt/h9vcfsX37Mt/YX32OVnYdKi23K1dYuVLra3n7iuCj7zXW+
	0pML5qbM+v1RnLv44vFDe55UFeZXBtxTPOt2a/X/y47bvPWNUh55lIf4PJaY96VwxbyM5Qu4
	P05Rer3pyZOyNefntuxOEhF2PJHWv3hnrK/HIQkVtx03zN8sN/j4e/rkef/KFPpeGB/YpMRS
	nJFoqMVcVJwIAPaWJL/iAgAA
X-CMS-MailID: 20250305044241epcas2p45a526aecf91f33b9ac253f561e909978
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250305044241epcas2p45a526aecf91f33b9ac253f561e909978
References: <CGME20250305044241epcas2p45a526aecf91f33b9ac253f561e909978@epcas2p4.samsung.com>

commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
to ringbuffer") disabled non-panic CPUs to further write messages to
ringbuffer after panicked.

commit bcc954c6caba ("printk/panic: Allow cpu backtraces to
be written into ringbuffer during panic") allows non-panicked CPUs
to write backtrace only.

Since that, there was a problem with not being able to check the
important logs of the non-panicked CPUs.

Fix the issue by adding debug option(printk_debug_non_panic_cpus) to
output the non-paniced CPUs' message.

Link: https://lore.kernel.org/all/Z8cLEkqLL2IOyNIj@pathway/
Signed-off-by: Donghyeok Choe <d7271.choe@samsung.com>
---
 kernel/printk/internal.h          |  1 +
 kernel/printk/printk.c            | 17 ++++++++++++++++-
 kernel/printk/printk_ringbuffer.c |  4 +++-
 3 files changed, 20 insertions(+), 2 deletions(-)

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
index 07668433644b..7631fd8ba1c7 100644
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
+	pr_info("printk: keep printk all cpu in panic.\n");
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
+	if (!printk_debug_non_panic_cpus &&
+	    !panic_triggering_all_cpu_backtrace &&
+	    other_cpu_in_panic())
 		return 0;
 
 	printk_get_console_flush_type(&ft);
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 88e8f3a61922..ffab5f6c1855 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2143,7 +2143,9 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * But it would have the sequence number returned
 			 * by "prb_next_reserve_seq() - 1".
 			 */
-			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
+			if (this_cpu_in_panic() &&
+				(!printk_debug_non_panic_cpus || legacy_allow_panic_sync) &&
+				((*seq + 1) < prb_next_reserve_seq(rb)))
 				(*seq)++;
 			else
 				return false;
-- 
2.48.0


