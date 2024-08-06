Return-Path: <linux-kernel+bounces-275703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1A9488D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57571C22330
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2E1BB6AE;
	Tue,  6 Aug 2024 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="puSL0mX6"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE9B663
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 05:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722921146; cv=none; b=DOMDTLbOjUWA1imi/G9mjlldDUs5KiZ2JDo70NaXBpuG6vxURUBdwxQIatETXdWp1FJKyD9YYd4UwIAxnrMstfCZt994QZI4R0ug4Kw0HupnI+4M88874/KSOq9TgvP1iN3F2kQhaH/zX/3meKODBSKtckiQufBZ9Khi5WkuPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722921146; c=relaxed/simple;
	bh=/TH6cB+n+1ayWn8HHSV/LMald4tEPqBBgejtf1Q1SS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=DyAfv9pFx0iNCD18p9CTD/X4yl35pjdcWRp5wUJnhOHPzM6FpJU+Z3suSGMlXJ63fmISCENsywyHW/2SdLTAvpOK9HLVrw/Q3GbY88NF8UJXoH4DrtbrJvb4/tshuyMfBNVYshZdFxQifCjri6ES3ZZisXEBWbPAyez2Dt+bLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=puSL0mX6; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240806051220epoutp044a4b4389f904137713428997f444cc46~pC6YwmLrX0812508125epoutp043
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 05:12:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240806051220epoutp044a4b4389f904137713428997f444cc46~pC6YwmLrX0812508125epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722921140;
	bh=D6KiA/heKMDS76hm7ohxJiQZ2JEMRXX4D/OeWiSU8XI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=puSL0mX6m6/2vzNSVBhUuYTrTHhRvVX1rxxH19zgyvLctbH0FByx9HN4BGJF7FbWS
	 v+gDsUJMzfe74GxXBtSB1GxmhYL1PN04jmAUhBWs6Nxa3X4YKRDfFQjILTUEGTDe+l
	 100tFy9QFDpEKWooFcjZ8+w2fSLXegfBt+pI3Yho=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240806051220epcas1p2f905ebe529285a4bf1aca0b23d8af471~pC6YaUYn_1773717737epcas1p2l;
	Tue,  6 Aug 2024 05:12:20 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.223]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WdLyr2lrBz4x9QJ; Tue,  6 Aug
	2024 05:12:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	FC.82.09725.4B0B1B66; Tue,  6 Aug 2024 14:12:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240806051219epcas1p42de88463d90d6084ccfea538d929465c~pC6XqkYt10191501915epcas1p41;
	Tue,  6 Aug 2024 05:12:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240806051219epsmtrp2403db729d9db94d091746fa2bd0404b2~pC6Xp7oGq2312723127epsmtrp2p;
	Tue,  6 Aug 2024 05:12:19 +0000 (GMT)
X-AuditID: b6c32a37-245b8700000025fd-fb-66b1b0b4e588
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.C3.08964.3B0B1B66; Tue,  6 Aug 2024 14:12:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.252]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240806051219epsmtip11c52a113b4d933a91c5683f4a8c69a64~pC6XioeOr0178101781epsmtip1A;
	Tue,  6 Aug 2024 05:12:19 +0000 (GMT)
From: Sangmoon Kim <sangmoon.kim@samsung.com>
To: Tejun Heo <tj@kernel.org>
Cc: youngjae24.lim@samsung.com, jordan.lim@samsung.com,
	myoungjae.kim@samsung.com, Sangmoon Kim <sangmoon.kim@samsung.com>, Lai
	Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: add cmdline parameter
 workqueue.panic_on_stall
Date: Tue,  6 Aug 2024 14:12:09 +0900
Message-Id: <20240806051209.3352066-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmnu6WDRvTDJ4fELGYunY3k8WNZWEW
	l3fNYbOY/lHM4taDRhaLX8uPMlps2/uUyYHdY+esu+wem1Z1snn0bVnF6PF5k1wAS1S2TUZq
	YkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QfiWFssScUqBQ
	QGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgVmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbNU3uZ
	Co7xVzSdbmRrYPzJ08XIySEhYCKx7PNqxi5GLg4hgR2MEv8+PGAGSQgJfGKUmNntCJH4xiix
	rGE6UIIDrGP52wyImr2MEr2fLSFqvjBKHN4wgwUkwSagK/Fl3mVGEFtEQFbiyrSHYBuYBY4w
	Skz99QEsISzgL/H8+XpWEJtFQFXixPFbYDavgL3EzEnrmCDOk5fYf/AsM0RcUOLkzCdgC5iB
	4s1bZzODDJUQOMUusePUVXaIBheJNdPWsEDYwhKvjm+BiktJfH63lw2ioZ9R4lR3F1TRFEaJ
	udc0IWxjid6eC2BvMgtoSqzfpQ+xjE/i3dceVojveSU62oQgqtUkHr+6ywhhy0j035kPNdFD
	4sKv5dBQjJW4/76VeQKj3CwkL8xC8sIshGULGJlXMYqlFhTnpqcWGxYYwyMyOT93EyM42WmZ
	72Cc9vaD3iFGJg7GQ4wSHMxKIrxdpRvShHhTEiurUovy44tKc1KLDzGaAgN1IrOUaHI+MN3m
	lcQbmlgamJgZmVgYWxqbKYnznrlSliokkJ5YkpqdmlqQWgTTx8TBKdXAtF6gIP7M0V8ceyQE
	ylhTJNuW/+YLi92vn31n7gKWgEstTJf098tH7y5/ur9TwG6DwLI5/+axBKS1LlQ781WGN6Ko
	dkPplIDbrOppl9nM7ggtnr62LnESp8j6hOy0F0ZbU5/ols+5Ou283NyHMrz7NqmVbVblDft2
	Jekga/2PHf4u8rr6HQp2GV8NfrafvukWXP8pzIZxwd6aLa0tUTY/7a+Ih4oXdwsqGQj9ddUw
	KkzTrN/h+YvrfaXrSa5/E4MXJx+zUffffFSfPfT206qKsvvGhWu8r618fNrvouo5fi6eAAaP
	wzyztxvfP3Hib4h2aUyYI1/+7M2bZR8fMvTwVvpdetXtWmDzZJ8/hgxKLMUZiYZazEXFiQAp
	H0sa/wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnO7mDRvTDH4eVbOYunY3k8WNZWEW
	l3fNYbOY/lHM4taDRhaLX8uPMlps2/uUyYHdY+esu+wem1Z1snn0bVnF6PF5k1wASxSXTUpq
	TmZZapG+XQJXxs1Te5kKjvFXNJ1uZGtg/MnTxcjBISFgIrH8bUYXIxeHkMBuRonPu++xdjFy
	AsVlJHZe3MwEUSMscfhwMUhYSOATo8S79VYgNpuArsSXeZcZQWwRAVmJK9MeMoLMYRY4xSjx
	dUIXM0hCWMBX4tPRz0wgNouAqsSJ47fA5vMK2EvMnLSOCWKXvMT+g2eZIeKCEidnPmEBsZmB
	4s1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4KDU0tzB
	uH3VB71DjEwcjIcYJTiYlUR4u0o3pAnxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIkkJ5Y
	kpqdmlqQWgSTZeLglGpgiqzpXvBYyt121a93340fzV5QYlN55ehvI92v/Ltf5ZzzO7Y9YyEv
	m/lBh8nTbaRvmjmaue3IcNqoZ75i8csHkUsM2LTkz93oC5PSZEicuPJIDKuQh3bmqb4Ymbbj
	tulmd7dWH/3ybIbdySe7o862fZm1NivVnnPFoQ19mz3k3/byqsgfazz02T7mknX61kVLlFV3
	psz9fUX1m4nqzAyms8p1TXZTuRlaT+7KyVZ9Yx3f+1VrI79W34dqwS+vzi6b8eqmwd8LYn1c
	1RtKajar/eAq+fnwybsF7avc1dcHOQRwS9vKyPvtXxnt/2/enaTKiDWLmgUZ76dYmC5Q8Fe9
	KcT+0YFzWtIMG5XO+9frlFiKMxINtZiLihMBDeTECrkCAAA=
X-CMS-MailID: 20240806051219epcas1p42de88463d90d6084ccfea538d929465c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240806051219epcas1p42de88463d90d6084ccfea538d929465c
References: <CGME20240806051219epcas1p42de88463d90d6084ccfea538d929465c@epcas1p4.samsung.com>

When we want to debug the workqueue stall, we can immediately make
a panic to get the information we want.

In some systems, it may be necessary to quickly reboot the system to
escape from a workqueue lockup situation. In this case, we can control
the number of stall detections to generate panic.

workqueue.panic_on_stall sets the number times of the stall to trigger
panic. 0 disables the panic on stall.

Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
---
v2
- Combine 'panic_on_watchdog' and 'max_watchdog_to_panic' into
  'panic_on_stall'

v1: https://lore.kernel.org/lkml/20240730080428.2556769-1-sangmoon.kim@samsung.com
---
 kernel/workqueue.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index dfd42c28e404..801d984b68e5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7406,6 +7406,9 @@ static struct timer_list wq_watchdog_timer;
 static unsigned long wq_watchdog_touched = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, wq_watchdog_touched_cpu) = INITIAL_JIFFIES;
 
+static unsigned int wq_panic_on_stall;
+module_param_named(panic_on_stall, wq_panic_on_stall, uint, 0644);
+
 /*
  * Show workers that might prevent the processing of pending work items.
  * The only candidates are CPU-bound workers in the running state.
@@ -7457,6 +7460,16 @@ static void show_cpu_pools_hogs(void)
 	rcu_read_unlock();
 }
 
+static void panic_on_wq_watchdog(void)
+{
+	static unsigned int wq_stall;
+
+	if (wq_panic_on_stall) {
+		wq_stall++;
+		BUG_ON(wq_stall >= wq_panic_on_stall);
+	}
+}
+
 static void wq_watchdog_reset_touched(void)
 {
 	int cpu;
@@ -7529,6 +7542,9 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	if (cpu_pool_stall)
 		show_cpu_pools_hogs();
 
+	if (lockup_detected)
+		panic_on_wq_watchdog();
+
 	wq_watchdog_reset_touched();
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
 }
-- 
2.34.1


