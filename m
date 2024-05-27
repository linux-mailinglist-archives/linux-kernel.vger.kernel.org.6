Return-Path: <linux-kernel+bounces-190727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ADD8D01C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A061F21FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DDC16132A;
	Mon, 27 May 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzkeUPJW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87D15F33A;
	Mon, 27 May 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816856; cv=none; b=EpUgRKEFgtwL8O2hYH68KOGLzVUXbgKhsdI8dVdzatLL+Czopy3R822y0L4ylUUZFmftcXZKhzwHtxll8qgWbux3ar4RObTHvZ4Q9PtwB0tCO0NMcxmfz6ZVBxnitwFE5zk/ZKTqEqAYR08ZlMihm48p91ghyAwVCQeT/2lwsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816856; c=relaxed/simple;
	bh=CcSTn8aSTYpTe6INcVUlkFKxcfUFQmwqltEpS2pU9IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZyZLvCJHoc686FJ2k8oGSXFL49jXsWaqe9bJaDG5aQSJAjZ4E4+MkfALsm96DvL3AlE+lOJKIVkEgSg8bWL/+jBu9olqy73cskCLlQeoZwO/EjODEWRexnRIhPjn0jKt0vHIdiVrPNp+t7ZtnnDgUHZtBAHoEGY9YGslWcnuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzkeUPJW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816855; x=1748352855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CcSTn8aSTYpTe6INcVUlkFKxcfUFQmwqltEpS2pU9IM=;
  b=SzkeUPJWcTG/AKLXeHhzPibck5+uol16wnZbUy0aYb4jD/XNDXUMmLNM
   W/18fTaFgvWKyh3u8kHGBxwhbYxPCaYFKQSTf9Xd4agbp98jtUSI4zvAw
   xa/BDC+Zt/5MEuBtWH3zxpPKVZzFM6JNId4t349BNkUENu2SC0fr+HB/6
   aUyTULmaVaBcmvYofFVVwK0SXvjSualwXVT2BX1AYZ0LlUTwYS6+4B1j8
   Id5cy+Ab75SzCoiZUp/jWEOucAOlKwBz7RNAB+eQFypZt6v061Ml/IUXI
   QqfDxFrHmB4qVFDiV1mBxvuAV0gQxG/+9FxH0dMxgmM0HZ71QELR4givc
   w==;
X-CSE-ConnectionGUID: 8SRUNchqSp+rqnqZEngfAQ==
X-CSE-MsgGUID: DBJRvf6MQrOkeoJjgp+aFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="11714372"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="11714372"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:15 -0700
X-CSE-ConnectionGUID: a0uo65HUQXuv66qYeZmfqw==
X-CSE-MsgGUID: TgatDQY9TsO2aZdoyWJz7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34847972"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.180])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:13 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/6] platform/x86/intel/tpmi: Add support for performance limit reasons
Date: Mon, 27 May 2024 16:29:33 +0300
Message-ID: <20240527133400.483634-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527133400.483634-1-tero.kristo@linux.intel.com>
References: <20240527133400.483634-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add TPMI ID 0x0C (Perf Limit Reasons) to the list of supported TPMI IDs.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 2 ++
 include/linux/intel_tpmi.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 6c0cbccd80bb..c2ef2cd587ba 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -577,6 +577,8 @@ static const char *intel_tpmi_name(enum intel_tpmi_id id)
 		return "uncore";
 	case TPMI_ID_SST:
 		return "sst";
+	case TPMI_ID_PLR:
+		return "plr";
 	default:
 		return NULL;
 	}
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index 1e880cb0f454..a88ac937d2c2 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -21,6 +21,7 @@ enum intel_tpmi_id {
 	TPMI_ID_PEM = 1,	/* Power and Perf excursion Monitor */
 	TPMI_ID_UNCORE = 2,	/* Uncore Frequency Scaling */
 	TPMI_ID_SST = 5,	/* Speed Select Technology */
+	TPMI_ID_PLR = 0xc,	/* Performance Limit Reasons */
 	TPMI_CONTROL_ID = 0x80,	/* Special ID for getting feature status */
 	TPMI_INFO_ID = 0x81,	/* Special ID for PCI BDF and Package ID information */
 };
-- 
2.43.1


