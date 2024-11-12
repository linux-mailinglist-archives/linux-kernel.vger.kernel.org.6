Return-Path: <linux-kernel+bounces-406043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 430099C5DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969E6B35522
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9581FEFBD;
	Tue, 12 Nov 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxFTp8cB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF31FBC9B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421674; cv=none; b=DqozTqpZlAwxnWZ+dmzFdOpO0N+rxAyxR+m53DNLcEKrZzRBNZOg9OdaaHOTdcHLRoYBE5Jj060fBsOIHt+B4Sn7g0sq03BgB3HdVHN0uFxtTJzwAu9eBpSHxGIC9l88wKv8tbRcR1L06uL+m3tZgFzM1r4tV5n+ksk2TYCCFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421674; c=relaxed/simple;
	bh=qBlIE7iWTXa5rJmijFAAHJoeXXKYPcqYjkX2GK/+sVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CBVaFez8LzCZKLCp1iWrJuFSRTN/n+euDYcmyQ20iFV3exfyUmnfS8NAHRGhoGska2DxjY4FlFO2jTOZ3twsXGSw6+r2w+nGY7+89gy0Z16TpwXoK1WvuGt+pdZtoMQ8+sxC8BrM1EfQTh6yIbLuk0JcqhiTJhY3+wkAuw/CG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxFTp8cB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22703C4CECD;
	Tue, 12 Nov 2024 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421674;
	bh=qBlIE7iWTXa5rJmijFAAHJoeXXKYPcqYjkX2GK/+sVU=;
	h=From:To:Cc:Subject:Date:From;
	b=bxFTp8cBtHoO6vcpYvZrO83xq1+3weben0LT9JA4/AW730+dFkKsp9viMawhdgYno
	 FiVmAFkw2Px+prCs7h43fm9APNArJuyRFtdxBha/DCFNM4Ryy5c1BxVegrT0oQLaqU
	 6UNe/F63GSHc2NNswxa7DaQa2sV3Nl2gcA5DV/NGuxezmimIFCVyTCVBteKj0o5RQF
	 sSiJc5S/M9H5IPbXJkEAA4TUsysgD7yBeJHvCI9ztppwtPqTVeJyiT5Go5+Atmk57y
	 5L9gLCkx3UIdrjHZcaP1+JHgcmM6zB2aGUKU8V4Dyt6N2HtukB36Z2tbNFpx/fYcsz
	 s29Bzhfq5u7ug==
From: Arnd Bergmann <arnd@kernel.org>
To: Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Sreenath Vijayan <sreenath.vijayan@sony.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] printk: add dummy printk_force_console_enter/exit helpers
Date: Tue, 12 Nov 2024 15:27:34 +0100
Message-Id: <20241112142748.673772-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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
 include/linux/printk.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 232e5fd06701..0f2d7bdcea54 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -232,6 +232,14 @@ static inline void printk_deferred_exit(void)
 {
 }
 
+static void printk_force_console_enter(void)
+{
+}
+
+static void printk_force_console_exit(void)
+{
+}
+
 static inline int printk_ratelimit(void)
 {
 	return 0;
-- 
2.39.5


