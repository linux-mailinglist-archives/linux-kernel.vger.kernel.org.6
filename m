Return-Path: <linux-kernel+bounces-533964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E391A460E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E80171242
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E50021C194;
	Wed, 26 Feb 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iI5vuBVo"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184121A421
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576470; cv=none; b=Pvoc6zEjdnc40jP4Qn6NVkJt7lNQEwmq/DxwN+abGaaMRu1e78fSnoJiK+h2nk3rUD7raviW2A5agqJ5gVEqBNJy6SsxUVM5GTt0hxO7d4nxGAGt5FqE7Jjkk+RrfgMX1iCtXn2qCvlwkhqM7iCwvclndpnWb8fcFS11zVazPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576470; c=relaxed/simple;
	bh=U4JXAdHq1oPHV5jfSimQVO3olPzSss/NVG5Q/o0L3a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+dRDmZW9L4EjKz9OYyLAF/PL4d2fi05VnuyzACfa8KzzbAl46vitw8HIZJo1EhstO0h9HVbQTdh3Dte/lC0LYc4l9GWHz22kEwVnm62cQQMSaEmxWCwQyOg0ZRITYfDTAu1sutFl99lHUDqP7IEsPlbEjfuY44nqTGxjB3yKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iI5vuBVo; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2H+4Lee7WxfCIUmBwi0YGZZHinb7DCHLwsRbSAu6RYM=; b=iI5vuBVonypsJ6z4rILCSdMyYC
	vHo9O5UBplc9fUv/kZQhIeooLmljai1dcNRZh+ld4T1n4Lp0PvYmY5SZIdesthnVgYKTfU+ehaDhh
	ML2flSeninZRKJDMtVk2R9Rxu3ujqj2gIZbGW20R2kUbhEY12Zme6JR0Ga89xjN8x6XB4isfK6AxI
	/DXtDfd9Un1TUFNfk4fuXntjJkzLIQ9xu0sxXFeuNCV3W0iNhFfWut93MH/24h786kYSSbhkOakoC
	7CRDFJwI7tNw0Pte764dfW5S/sOY7prDJQ+qMg2tg/chLWwR1xaiAzrQ3Y2c8wVLckh1tAEseF2zq
	9dEPUEUA==;
Received: from [177.83.214.207] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnHRo-000yjA-LF; Wed, 26 Feb 2025 14:27:43 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after boot
Date: Wed, 26 Feb 2025 10:27:13 -0300
Message-ID: <20250226132733.58327-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, we can force the TSC to be marked as unstable through
boot parameter. There are debug / test cases though in which would
be preferable to simulate the clocksource watchdog behavior, i.e.,
marking TSC as unstable during the system run. Some paths might
change, for example: the tracing clock is auto switched to global
if TSC is marked as unstable on boot, but it could remain local if
TSC gets marked as unstable after tracing initialization.

Hence, the proposal here is to have a simple debugfs file that
gets TSC marked as unstable when written.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/x86/kernel/tsc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 88e5a4ed9db3..6bce5f3a2848 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -9,6 +9,7 @@
 #include <linux/timer.h>
 #include <linux/acpi_pmtmr.h>
 #include <linux/cpufreq.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/clocksource.h>
 #include <linux/percpu.h>
@@ -1602,3 +1603,24 @@ unsigned long calibrate_delay_is_known(void)
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_DEBUG_FS
+static ssize_t tsc_debugfs_write(struct file *f, const char __user *ubuf,
+				 size_t count, loff_t *ppos)
+{
+	mark_tsc_unstable("debugfs write");
+	return count;
+}
+
+static const struct file_operations tsc_debugfs_fops = {
+	.write	= tsc_debugfs_write,
+};
+
+static __init int tsc_debugfs_init(void)
+{
+	debugfs_create_file("mark_tsc_unstable", 0200, /* write only */
+			    arch_debugfs_dir, NULL, &tsc_debugfs_fops);
+	return 0;
+}
+late_initcall(tsc_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
-- 
2.48.1


