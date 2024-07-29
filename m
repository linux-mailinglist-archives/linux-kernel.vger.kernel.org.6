Return-Path: <linux-kernel+bounces-266142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD4793FB97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6081F23A74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA518A929;
	Mon, 29 Jul 2024 16:41:41 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80DE15ECDB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271301; cv=none; b=qI+4iezCdb5HiFcpNPiXG9FVQwyq7ftCGt717npTOMM+ukW+bju57IcHXqMRQFAqbyt9YUfpUOTMs2tltfuWVQdunux2kDBQawL/f10dcAYCQ74TJ5CcLjdD3RCgzUs4a4Cmv3HMrSbKfUjlTTN+oeSosRroEw1uL4aI+8tyDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271301; c=relaxed/simple;
	bh=rjOy0J+6gbjAabPpcFr8EBNjak5fI9XMI+jdoUUnQ00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzODXZL7EDc9d54LOEZcEh/Z8oNq4Y4buvBAMwY9xxv/r0FEc0NiSjh2av04OgH4GdI/DbIpTwclqZ1rBM0FFN5WcZ+cq8/WfkqO2il+s7O4KX+u2Z6+S+CTE4QggcIRTI4iLU6imTTuaW8Csru5dxpqQv/5S/rDD1MqF61PFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso3226708a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271298; x=1722876098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLEhMHuDWODppIoZZdWJkSUr7OSyKrJFLXS2R27TE1Y=;
        b=gt69a7WL/dcxnYDLcgfilQUas+PdNRSGDIIm+YIrKnjl9VqnXEAee3VrKIxMeGhUSY
         glBoi9Wn0Nu9gZYEtblwbq7H6uiSfLIYWr+H8ewaPaWDYat7Nw3c1EX/0x6pnDUMMZk9
         JTxXj9oKUp3ua6QeVXqISGOLPv1uO3JoDVLTuK6wTi6P9b+Y1jvgyWl+bmPG3PxUbfTP
         x7fUt99cI7aLdX7qnsHbMPH/uCJNbi4DZEsy+N9F80bkUgNej8gT22z8QeHo3/PvsN2N
         9IpgXlhofOJNwDVFAY7lq/x+72UCf5HLTVXTZq+zODojpw5EcIABiBz9foqsjkf6WKFc
         Ivug==
X-Gm-Message-State: AOJu0YzzBmRiDTgxuy1G7vE2wxml2k4DYn1pgEes8/otjlfFEI0Ebuwm
	Y4rsAaJBoyvVJi+LPJiHIW3MzTsExGVKZ0GC5rSKl5pDkrclfIwL
X-Google-Smtp-Source: AGHT+IGk1ouQw30sr4PLwOVHqxHZsD3wCFvolh3kCsHX58FHTJd5X9KMW17/C7AXpXWlTwkqyyPlYw==
X-Received: by 2002:a17:906:c141:b0:a7a:a7b8:ada6 with SMTP id a640c23a62f3a-a7d40075322mr455642966b.39.1722271298324;
        Mon, 29 Jul 2024 09:41:38 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de47sm531048466b.67.2024.07.29.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:38 -0700 (PDT)
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
Subject: [PATCH v4 11/11] x86/bugs: Add a separate config for GDS
Date: Mon, 29 Jul 2024 09:40:59 -0700
Message-ID: <20240729164105.554296-12-leitao@debian.org>
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

Create a new kernel config that allows GDS to be completely disabled,
similarly to the "gather_data_sampling=off" or "mitigations=off" kernel
command-line.

Now, there are two options for GDS mitigation:

* CONFIG_MITIGATION_GDS=n -> Mitigation disabled (New)
* CONFIG_MITIGATION_GDS=y -> Mitigation enabled (GDS_MITIGATION_FULL)

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab5b210c8315..475bc538615e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2610,6 +2610,16 @@ config MITIGATION_SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
+config MITIGATION_GDS
+	bool "Mitigate Gather Data Sampling"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Gather Data Sampling (GDS). GDS is a hardware
+	  vulnerability which allows unprivileged speculative access to data
+	  which was previously stored in vector registers. The attacker uses gather
+	  instructions to infer the stale vector register data.
+
 config MITIGATION_RFDS
 	bool "RFDS Mitigation"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b2e752eeb098..189840db2f8d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -735,7 +735,8 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;
+static enum gds_mitigations gds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_FULL : GDS_MITIGATION_OFF;
 
 static const char * const gds_strings[] = {
 	[GDS_MITIGATION_OFF]		= "Vulnerable",
-- 
2.43.0


