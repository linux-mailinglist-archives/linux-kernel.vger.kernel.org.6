Return-Path: <linux-kernel+bounces-266138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17A93FB92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A32B23FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D4187853;
	Mon, 29 Jul 2024 16:41:34 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B618784F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271294; cv=none; b=UCMOkd/BGuG8RDj92beyr11NlPhcUh41Sk4gFwr5Rha2hPCO/RIgtfvgxuEtKYYoP7ugKep7HUNODj6SpfJ/nNqDzCsPQc9BG4NrnhaPg3NQZ0GRfHvC/uFRhr0mhl9UKBwusDY356PgSdGeDxGp252wEdYLmMwtGMvDpl/4I84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271294; c=relaxed/simple;
	bh=EOBwKhK0bGUvkVIxZY8IDJmuNV0cUFXlkWBSib1K8q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGMCo9zMETNaPvnBchxdeQDXdyLJS3ltqzsCo8AHCj7eOrjTdWrd2U9I+TpWFSiziDSZT1Lcz7aw2BD1H8Tw20ZCR2lP6yl5lw0fohEWsbU3ZKoG3fk91B/pM0Kc9Mo3l2N+pXOQOtFl9XMRlXRG9G09gkaQRmwZA07QUNAO8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee920b0781so41028321fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271291; x=1722876091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+wAm72oVKTI2dZM5Qd7Xnr6v/AeXlyV4Shdu2M4ZPg=;
        b=Ui8lVk3b5b7wqCwH6XzgT/LHnrRn37EXpNbDFbo4+W1xn9CBZbuhP9/BcphfJvLoit
         WsZbkG9tBovurlesE9WmDmAahbBrI+IKop7g8dI56FhdbVUA/3e3D17CkKaz6Fuzvk/a
         E+SvvWZFaxM0qzGZWm6WDICbRbVZeKyOhCm7waI+76jCdS1Adf0Zx+yLZxgPULUBKNGY
         EMoHSmAkrKgRgunPVQM9oxzGGiNBuPJkbOb/nWv7Lf+OSPac3wDxXnBgqDtOIZjdCSb4
         JV5IuMQvTAceQ2VfWTDE13DikMTQRxQ0P2ZST7SB0MV2OxJRFz9KTmGhLr6uTxlA4Dxn
         N7BQ==
X-Gm-Message-State: AOJu0YzedYb9fIA6CYlU+S2NFgW3vBEnzh5YwNp2B2aUku/zCOrrFMnF
	tVg+8C5RlIC4bpCsWvo9TFPw5w/IKFq8Cjwy7FVk4Kk2AIeMnnfT4V+YQw==
X-Google-Smtp-Source: AGHT+IFxX/cu2HH1Wi4XQ2xfxFAcfgU28hKOybywhXh+OYmGQeiFFH7XYWZuXYjiF9KIlT5K/ncc3A==
X-Received: by 2002:a2e:98c5:0:b0:2ef:2ce0:5089 with SMTP id 38308e7fff4ca-2f12ee07266mr53725431fa.12.1722271288472;
        Mon, 29 Jul 2024 09:41:28 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afb9422c41sm4366191a12.82.2024.07.29.09.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:28 -0700 (PDT)
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
Subject: [PATCH v4 07/11] x86/bugs: Add a separate config for SRBDS
Date: Mon, 29 Jul 2024 09:40:55 -0700
Message-ID: <20240729164105.554296-8-leitao@debian.org>
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

Create an entry for the SRBDS CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 14 ++++++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e3c63e5208ab..22d324581a60 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2715,6 +2715,20 @@ config MITIGATION_SPECTRE_V1
 	  execution that bypasses conditional branch instructions used for
 	  memory access bounds check.
 	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
+
+config MITIGATION_SRBDS
+	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Special Register Buffer Data Sampling (SRBDS).
+	  SRBDS is a hardware vulnerability that allows Microarchitectural Data
+	  Sampling (MDS) techniques to infer values returned from special
+	  register accesses. An unprivileged user can extract values returned
+	  from RDRAND and RDSEED executed on another core or sibling thread
+	  using MDS techniques.
+	  See also
+	  <file:Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ebb6a2f578d1..8292a96d376c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -608,7 +608,8 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
-static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_FULL;
+static enum srbds_mitigations srbds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_FULL : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
-- 
2.43.0


