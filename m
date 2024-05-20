Return-Path: <linux-kernel+bounces-184249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D518CA4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D401F225F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623D13C667;
	Mon, 20 May 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwGJWe3d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018B13B5B7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245209; cv=none; b=GeX8DodSF1VjyNHPE9rNJmRs6Oiw5KZXcb8boBqW1xgBtJJiu+P7MD3uNYD9oUlmcLV34LgfwkGH+L6yxEWp6WoBYwUuhqiIUWUEMQIoaC0UH3cz2s4D/qp0/QqDC6WWnhRjhLvShM+hh2cV4EKFJQ1tVtDwnzGD+RvN7uTSq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245209; c=relaxed/simple;
	bh=WB9IrZhQaBiWvCtxLVin3lFQLCeXldDe0NZh3MqrvXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqhknZNb5J1TUfzQdIPbOd4DpJ4KCvEu0nABPqDRfarifvpaOvyprLqmiwnb6vN4kmDpvRQt4i3bw16cq80PiR/29754cxZdjDAxmzu0h5FKlXHFu/Cd18rbpKNWwTNK5+ElbUoduQ4Vdjvy3xtwj+0bM2w16TUfEO4TCG9jujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwGJWe3d; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245207; x=1747781207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WB9IrZhQaBiWvCtxLVin3lFQLCeXldDe0NZh3MqrvXI=;
  b=FwGJWe3dbNteHb/HRdDWvt+tjyNhkfVgbmEzyCXIrsjTFqpsLpNxNWZf
   Jlvr59bZyJeUozWf1B3PG4ZNE0zmnP3ASXWL2T540kuCuQ2XM49MEHPgM
   Q/QQAIirgxFLCFzGNxl6upovrAItpvLCE8DpL4d8L9HgIOo+TC8dew42d
   Qk4f5kLZMp8lPev7TJ1hErhMEbS2TldfJCeNKt5oGn3tgXSvrBPYD8VFA
   b6hW4cVUzLlu1JVIxd2GcApLYdXr1h2wqSbPqgKuxn98mEig6xItIRqBG
   s5AW+Y1DVtic+JSlzIup1Lm0AqZCJ8AkRQR625T/Cqs97wmNEVfjWG7qy
   w==;
X-CSE-ConnectionGUID: lmMWICMxQDa9JtYnQl0Yyg==
X-CSE-MsgGUID: TX9+bxpgT2eeZTb3Roc8IA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199745"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199745"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
X-CSE-ConnectionGUID: VURtXdSDSkeM+6BtBnTnLg==
X-CSE-MsgGUID: OiObT9RmQ8Gac8FzHR0c4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593448"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Renninger <trenn@suse.de>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 22/49] platform/x86: intel_turbo_max_3: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:53 -0700
Message-ID: <20240520224620.9480-23-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520224620.9480-1-tony.luck@intel.com>
References: <20240520224620.9480-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/turbo_max_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3.c
index 892140b62898..79a0bcdeffb8 100644
--- a/drivers/platform/x86/intel/turbo_max_3.c
+++ b/drivers/platform/x86/intel/turbo_max_3.c
@@ -114,8 +114,8 @@ static int itmt_legacy_cpu_online(unsigned int cpu)
 }
 
 static const struct x86_cpu_id itmt_legacy_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,	NULL),
 	{}
 };
 
-- 
2.45.0


