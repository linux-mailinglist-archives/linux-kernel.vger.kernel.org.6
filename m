Return-Path: <linux-kernel+bounces-266135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D85BA93FB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E43B23D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B58F187328;
	Mon, 29 Jul 2024 16:41:27 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE5186E5B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271287; cv=none; b=lCBKai9F7p6EmDHL6O/BGqiFDdQ3d9RHmp1KHE8kehpYp/rVTRzAvSuCqkRErB/xbq1CoHIuOdKuKc++r2LmXlrkZKwCFprVqBMqnxhYlKyNsyOGOqk3YiuXZDLa+pwCiJksNGCwlNJZf5sKQ1Dsk4BdwTLL3ga+26p4Gaqq47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271287; c=relaxed/simple;
	bh=wPDhtggHa5RZ9bALckqonh9BQxteNVANpeptDfKGJhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiCMyGALa2v4pcq1aL7QASUE9PQjOb+uDjCfTEWntJ4OJesC/8F0c62iMA15RiHIoOHOlMusp9EUzGcLQOwe9BDVAcsKX/mV2J1cd1PjNsdyTlwPjtvTxq/02Few0HRrHanI5s/34EWTAPWpNmyaAKI7QESeT15MjrGBJa/CvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso47967071fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271283; x=1722876083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHxK0Ou5TQH/BbrUfl9Z40UrNMuwE5GPHlJfR0iMhfI=;
        b=WrCcRc+DUNp0vF0cB2PwAQFk/8hDWl9txvJHXbpmr74k4HMrRKd/QuNjt6f1nQIkYV
         oGIzUG514dnGXUgtJh5BEo+XIj/Hp8PbB9SxHTQ7LlKqQJmZ/BLzIj0/wwrTQ9qH2XoJ
         nE00nwyYwn2mnSZ7Xny2+i2tHbKpm24AwDfouDptNqu83GjUBJNRpjAoquO4cVG5Ds06
         HgG0jKD4cbwKaVlaTicoxO5T34U09IXEsPECwk+jJ0/ILS0L7Phf93u+4yS1zf9jxUzS
         sPVpxtG7Si9KMCxJvtYeZov8MDn6fT+L1J7Cuq1Rptbxsp6nicQt+Df0wCMw8qR7Mw2N
         TNqA==
X-Gm-Message-State: AOJu0Yz8OK+In5629OTL1J4Ix7XivmzKniJDHYkBjyeNoqadhJpn58rg
	wSIb/DeWfLqx/zQ75CMTQjn2b2XdUazLDabnpXwxQlnn6Co5f+tU
X-Google-Smtp-Source: AGHT+IFUPQmXyXb6LjHmXpoDsyaMiL5pdhrnXDWicvlX3SlcZ+UE9F56bG//e1dDixNsu7f2y7ybEg==
X-Received: by 2002:a2e:8057:0:b0:2ee:d8dc:490c with SMTP id 38308e7fff4ca-2f12ee2f366mr62563601fa.41.1722271282887;
        Mon, 29 Jul 2024 09:41:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b046fsm6032399a12.18.2024.07.29.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:22 -0700 (PDT)
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
Subject: [PATCH v4 04/11] x86/bugs: Add a separate config for L1TF
Date: Mon, 29 Jul 2024 09:40:52 -0700
Message-ID: <20240729164105.554296-5-leitao@debian.org>
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

Create an entry for the L1TF CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b169677ec4ac..290f0865fd85 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2682,6 +2682,16 @@ config MITIGATION_MMIO_STALE_DATA
 	  attacker to have access to MMIO.
 	  See also
 	  <file:Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst>
+
+config MITIGATION_L1TF
+	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Mitigate L1 Terminal Fault (L1TF) hardware bug. L1 Terminal Fault is a
+	  hardware vulnerability which allows unprivileged speculative access to data
+	  available in the Level 1 Data Cache.
+	  See <file:Documentation/admin-guide/hw-vuln/l1tf.rst
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9b0d058f3fe8..4fde9bd368ad 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2374,7 +2374,8 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
-enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+enum l1tf_mitigations l1tf_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_FLUSH : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
-- 
2.43.0


