Return-Path: <linux-kernel+bounces-406046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E049C5A64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF38E1F2128C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810C1FF02F;
	Tue, 12 Nov 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs7aLYiR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992641FCC5E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421784; cv=none; b=KyeMLsA08/I7gMr4m1SI6MUXw2B6sJTG57+dGGTuzWS94uJdmkG4/UTFS4UDrCDkPVVJSIRaRg4leegp4iTh2ujGTDbkj0XSc3L/Comcf4ogyb8SRawojV5DdY9TvV3MY+SuGjAiIbIyCHs/QSZ9RE0K0xSxFvrhf/jrVIqSGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421784; c=relaxed/simple;
	bh=iXCsHGQ+ZCVsCmTau0YGGaj88yRrb+k4V3WFOQJApOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFTVDZocN3KGaJYZdAAF2oznRZvZgHu4kwbhKRvYIwhWa09H0bWtFr/bt91y2yd/8o5tRY+gGtIRF0pCDVblpAEtulHlrrmOlVaK+7PNOS9KwfLYV8aTUujZqoGtKZ9Gx82t+hwmYhaWYOUyr6fAK+itRsLGMHuboO7A6GqdcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs7aLYiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4ADC4CED6;
	Tue, 12 Nov 2024 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421784;
	bh=iXCsHGQ+ZCVsCmTau0YGGaj88yRrb+k4V3WFOQJApOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hs7aLYiRMSPzDhBgNRqG/eOsTpM6qfyiogz+9Mm67EmGVbSMv8k6K7yRB2OQ2B7W8
	 RjhRTKmVb+CBp9pyLocBvl9K5369gADQbur8hYP0DC4srybxjszYKWuSdrUf+zsicd
	 shlw4MxLhYiRVJ6xsTte1nriTv4u9vV05xZpO07weku22bv0i2Hv34S/kICj+lvf2V
	 y7t7D5XEH0atrjHQYmCFzzxl6/xdiy3PZ9unDUYmSjq+9DiZuwZ5QLwvFhfCl2xvyg
	 fZkOemEEzYRJg78y1lWwJHjzxxu/plC0r4K02fef5CZQq+Of9G0WeMSavNjPAkTFj4
	 u3cvEEwRYTWJQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] printk: add dummy printk_force_console_enter/exit helpers
Date: Tue, 12 Nov 2024 15:29:15 +0100
Message-Id: <20241112142939.724093-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112142748.673772-1-arnd@kernel.org>
References: <20241112142748.673772-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added interface is broken when PRINTK is disabled:

drivers/tty/sysrq.c: In function '__handle_sysrq':
drivers/tty/sysrq.c:601:9: error: implicit declaration of function 'printk_force_console_enter' [-Wimplicit-function-declaration]
  601 |         printk_force_console_enter();
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/sysrq.c:611:25: error: implicit declaration of function 'printk_force_console_exit' [-Wimplicit-function-declaration]
  611 |                         printk_force_console_exit();
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~

Add empty stub functions for both.

Fixes: ed76c07c6885 ("printk: Introduce FORCE_CON flag")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: realized I sent the wrong version that was missing 'inline'.
---
 include/linux/printk.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 232e5fd06701..4217a9f412b2 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -232,6 +232,14 @@ static inline void printk_deferred_exit(void)
 {
 }
 
+static inline void printk_force_console_enter(void)
+{
+}
+
+static inline void printk_force_console_exit(void)
+{
+}
+
 static inline int printk_ratelimit(void)
 {
 	return 0;
-- 
2.39.5


