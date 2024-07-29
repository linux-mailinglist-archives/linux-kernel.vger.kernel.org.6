Return-Path: <linux-kernel+bounces-266134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D493FB8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93361C22520
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14867186E4A;
	Mon, 29 Jul 2024 16:41:25 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22D1862B3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271284; cv=none; b=T89AAj44aklUAwnifq5PpzINK3GzL8YnBBPnKXNCkimvXU3RSIcTCJmIo45PB24ya4Q+Qt+9A3lKzvwsw7MsClumq3qXEErA0c2zUt3cLnsDcJocew1jkX+2MdkIP25zHk+HCX06kgkcczPizlFfI9LHC4x9DiegPFAah8P94t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271284; c=relaxed/simple;
	bh=5SzGz/KTwDj0a/VZvVkQDlZRxnVxfpjkb94/P0J+SL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqMyr+DC8z6x/fA3X8fE2bA+sGz5nWer5c/ihXTl4wXRz0ah2V/GdF3+rOqe/p9oFRmLOtTeTwjFSFoy+OXlxjDy8yPdftGznKJuyvchKaNZvP4zwf5AcH8RA2aQ4lXJzORo8qQT/86gT3DqdK6v+SJ+GMGMhkqD1MKvHmDnz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so7618044a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271281; x=1722876081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJn9p6h0NKu9+lrIgQgiVHObU+GnWBQY2H1+Gtbp0fo=;
        b=dxhPcqFnWMn/JtT/cI4GpMgqcd/yp77rw6NU1PhNIwjgTuOi78FZBDK9/y2VWmpmbl
         +8Hqf5KY+jon2y0obO0zwip2NZ0AOvx8Q8JgC0HQLtcX/f4li9VaAewD4V1eBxIu7tLr
         NzVB2Uz5j6S1aaNcpB9+OfLyVqsn42rRMPEOnhDnPtCPFOWKNztc41zHPqAvXEv2hz6A
         ZcdY6Xhmm6Id6L1DHWl3rLVQeLJrbmtytQ3u5iAVPYRp4PMiyRhm7TiQO3tQWRMKDR97
         9/udaVZETnf+aLTRZBMZfzV9G5nCYs5Ezn/VXheETrfmd+9M1qEyeeBqKgH79rgHYzwC
         zC6g==
X-Gm-Message-State: AOJu0YxrVqtw49kaHS0W75E5El8Ty0t4nd4R+KoOYYd2nPCEuNhTXLi1
	QytY+tAi2+xdqSXbbspb+zQCTAJix+zq6V+a4eHtoW1Az66Mw+O6
X-Google-Smtp-Source: AGHT+IFYkTkuWHAZt3u6ogSqWJdeWbMestmbm4cf4JYr9t4CTdhgofnbhtBOAzLjMJWe3JoApxtJfw==
X-Received: by 2002:a50:bb49:0:b0:585:5697:b882 with SMTP id 4fb4d7f45d1cf-5b016cdb714mr8371822a12.3.1722271280987;
        Mon, 29 Jul 2024 09:41:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b017787967sm3967228a12.9.2024.07.29.09.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: bp@alien8.de,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] x86/bugs: Add a separate config for MMIO Stable Data
Date: Mon, 29 Jul 2024 09:40:51 -0700
Message-ID: <20240729164105.554296-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729164105.554296-1-leitao@debian.org>
References: <20240729164105.554296-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the MMIO Stale data CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 12 ++++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 712a4f8cb7dd..b169677ec4ac 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2670,6 +2670,18 @@ config MITIGATION_TAA
 	  which is available in various CPU internal buffers by using
 	  asynchronous aborts within an Intel TSX transactional region.
 	  See also <file:Documentation/admin-guide/hw-vuln/tsx_async_abort.rst>
+
+config MITIGATION_MMIO_STALE_DATA
+	bool "Mitigate MMIO Stale Data hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
+	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
+	  vulnerabilities that can expose data. The vulnerabilities require the
+	  attacker to have access to MMIO.
+	  See also
+	  <file:Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ab306986762d..9b0d058f3fe8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -393,7 +393,8 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
-static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+static enum mmio_mitigations mmio_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
-- 
2.43.0


