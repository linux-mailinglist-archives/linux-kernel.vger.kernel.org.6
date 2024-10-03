Return-Path: <linux-kernel+bounces-349633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDBF98F94E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EB41F21B74
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5BB1C6F6C;
	Thu,  3 Oct 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG6oPR17"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425401C2323;
	Thu,  3 Oct 2024 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992559; cv=none; b=HLOMYtAYsr/ooojniw+XOypszXTVm8KPKe54zq6VlhVTNNXIS/rUk9CRAL1+iiY+ZLasAlw/BQscQGxGowMjStS4ZAxkNk7AuLVdiA5if2jIE1qQBvkDeLlaC7pPL2oFvD8KOACrdwxrR7eqBncliAacSsCsEoMpitc07H7pD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992559; c=relaxed/simple;
	bh=0JI4ZPdqTNkrOuM7wy+cHiSmR6NKMbs59oYKtS+Nz+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xka46cXJkKb8oBGKIdWaDZQAdxQB2qBXvaBXIOkxVzcqOcM7Q2kmAbJfCGfjIXsx/RLkh7b/53OMxKNOEjmnrlqM9qrSUPLm7lK9ud0Dc/qwV+D6EsNj40HnB75S5sEx0K94xrmItLroPv5c7yCVd8otHVI4StHOazIdYXqEQ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG6oPR17; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727992558; x=1759528558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0JI4ZPdqTNkrOuM7wy+cHiSmR6NKMbs59oYKtS+Nz+I=;
  b=SG6oPR173HW+bG73rOLqUUaGrsApnX3pfGFq0Kf1d5wic6Nb4/qxMx+t
   6uFYDy8Y+0cQg0kQZgMbnxoOZDaMR6oHM3WJMVbgz0YIIT2drm19AOSR1
   oWJojl04hXotqS4mzTuEBiXj2n9jKCtiqSov8TvdMpD9e+B0Gi/Fqupk5
   HgUqI+nYmPZQ/lV7NUl7+30ZaixFgwTD/oCDPJuwiW9Kq9xW+gpdTITVO
   Zn+E96Jl0OX59yyTNPrMBkJF98/nduwLGcoMQHuYKqm/ENZ5czBsYqtLa
   3VVgg6XTwslDL/6s5zsZbBUjP9awBkrikfWsQU3nRPKMi7dCKOo5ddrFz
   w==;
X-CSE-ConnectionGUID: fZ2W6cYxRbe5yCHu7N03Zw==
X-CSE-MsgGUID: dxvJqzVHTE2GHoLn8oF0Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="31094003"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="31094003"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 14:55:56 -0700
X-CSE-ConnectionGUID: EB08lSq0Rhm156M4AgeqgQ==
X-CSE-MsgGUID: InLygYKrS/2FQexs/xueMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74613934"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa008.fm.intel.com with ESMTP; 03 Oct 2024 14:55:55 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] platform/x86: ISST: Add Diamond Rapids to support list
Date: Thu,  3 Oct 2024 14:55:53 -0700
Message-ID: <20241003215554.3013807-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003215554.3013807-1-srinivas.pandruvada@linux.intel.com>
References: <20241003215554.3013807-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Diamond Rapids (INTEL_PANTHERCOVE_X) to SST support list by adding
to isst_cpu_ids.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 9ad35fefea47..2a95bd8cf4f4 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -807,6 +807,7 @@ static const struct x86_cpu_id isst_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_ICELAKE_D,		0),
 	X86_MATCH_VFM(INTEL_ICELAKE_X,		0),
+	X86_MATCH_VFM(INTEL_PANTHERCOVE_X,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	0),
 	X86_MATCH_VFM(INTEL_SKYLAKE_X,		SST_MBOX_SUPPORTED),
 	{}
-- 
2.46.1


