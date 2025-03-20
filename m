Return-Path: <linux-kernel+bounces-570519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC90FA6B1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71CB7AC593
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0622B5A8;
	Thu, 20 Mar 2025 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WekmP4LY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1C22AE68
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514079; cv=none; b=hHwst6HRfSxjLloNjECZGUFjBaqpA8t2MxexTTL8dkByR3gLcK88XVs0joIg/uL1/2+RSzE54Lta0oytkTFm1ZpECKrkO9jJvpBy2j+jyqHxV41LoPaFYYGI6ExM25OER2B9TptcPzNDkoyE1Uhj84mG79AXnh7VH4e0ppYCnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514079; c=relaxed/simple;
	bh=6sgvqNek8w2WkzBgdawUu7psYuoacHnTGTRIzEB/zEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN23t5bklC/Iun/4CIMJw84pM1o6xQwFPJtRFuJoqXA2lwE4tj6Sh+VQiUZsOAESS5lmeK95buoIcU1zP7g+UkQ5f3FsI67gjFbhwULUxdRDFroBc+5WiXZVZv1HbviO/RB5wDSOMZSHI3tQsMwMaTsT+UhnDZjewW8k6NKUT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WekmP4LY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514078; x=1774050078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6sgvqNek8w2WkzBgdawUu7psYuoacHnTGTRIzEB/zEE=;
  b=WekmP4LYHxV5Ri1x87rdHqkV3W9VACDzevh6BGa9Ozl3v0TEUbe2Qrhd
   wimj4xRVJf0MAIW4QY76i1yK0QnNUWpj4fv2I6ttY9IdKl7pPBVgK0Dnl
   hk4VabLmZDVprDgbXwmF6/BLtiwCVoeEV/z4Hx1tGhngo2gJmxxvZTsU3
   /mZH+hYpLA/dXmOi/2PWo1MtG8BipUpYWTmLLZvgv+UeyAc9ch94cTVvz
   bHKUfP+Ritu8YV6mf326ENzcGRt0y6poUp288+JWvlw9S4mDFEG0hw7S6
   8ZrWg+240vjD8sgJhtMS6Ah5/GjThuMyVbyMn9qRh3bxp/pemBc+9IMAB
   A==;
X-CSE-ConnectionGUID: hyVqpZ9EQ+GA/fXiwNPzoQ==
X-CSE-MsgGUID: m6oO2A43RaSej43o9ZRiww==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54439139"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54439139"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:41:17 -0700
X-CSE-ConnectionGUID: iuXtFZU3TDWLwj773i3Msg==
X-CSE-MsgGUID: DBa/xgNJR+WhUYVmtFP3FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123418028"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2025 16:41:17 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 2/6] x86/microcode/intel: Define staging state struct
Date: Thu, 20 Mar 2025 16:40:54 -0700
Message-ID: <20250320234104.8288-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234104.8288-1-chang.seok.bae@intel.com>
References: <20250320234104.8288-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To facilitate a structured staging handler, a set of functions will be
introduced. Define staging_state struct to simplify function prototypes
by consolidating relevant data, instead of passing multiple local
variables.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V1 -> V2: New patch

In the previous version, local variables were used to track state values,
with the intention of improving readability by explicitly passing them
between functions. However, given feedbacks, introducing a dedicated data
structure looks to provide a benefit by simplifying the main loop, which
is now prioritized.
---
 arch/x86/kernel/cpu/microcode/intel.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 819199bc0119..57ed5d414cd1 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -54,6 +54,27 @@ struct extended_sigtable {
 	struct extended_signature	sigs[];
 };
 
+/**
+ * struct staging_state - Tracks the current staging process state
+ *
+ * @mmio_base:		MMIO base address for staging
+ * @ucode_ptr:		Pointer to the microcode image
+ * @ucode_len:		Total size of the microcode image
+ * @chunk_size:		Size of each data piece
+ * @bytes_sent:		Total bytes transmitted so far
+ * @offset:		Current offset in the microcode image
+ * @state:		Current state of the staging process
+ */
+struct staging_state {
+	void __iomem		*mmio_base;
+	void			*ucode_ptr;
+	unsigned int		ucode_len;
+	unsigned int		chunk_size;
+	unsigned int		bytes_sent;
+	unsigned int		offset;
+	enum ucode_state	state;
+};
+
 #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
 #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
-- 
2.45.2


