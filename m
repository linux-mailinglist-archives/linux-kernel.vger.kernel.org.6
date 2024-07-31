Return-Path: <linux-kernel+bounces-269344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B149431C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FB21F23B62
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6762B1B29BB;
	Wed, 31 Jul 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wa7VfHah"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C1611E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435212; cv=none; b=J+fvuzzoWlChDvSLDaXihwdle9jb89cf95U9zclnLIFC5ynN2VflJmS4XOVh+Y1wJvV0O/LZoy5B2Z3QUBku4jACZX+kjv7WH2VYZc9lh8picLRogx9P+p2xrFJmskEPUOVG1tpOK2bpQr4wBPtGBSouTBO271BvGSH4clKsJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435212; c=relaxed/simple;
	bh=reLqKuENToej4Vhvuu+yfD1E6YAQNc6nN65mGLehm58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FrFa8hboF6+9f/Zj2nj+oKMRpPK2iLIT46TWeuc2y8J8oUZJExQRk9uMD7Ed/jQmqlrrjjUJ7l2PkU88rFo6i3qR8UKxBaepBefwRomYLUmZ8ejRFq5mkcQt6bZ24XVvusAR++km2zyizI6ybOBg7wxEZkOohSqlA6vcWo7MCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wa7VfHah; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722435211; x=1753971211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=reLqKuENToej4Vhvuu+yfD1E6YAQNc6nN65mGLehm58=;
  b=Wa7VfHahrZMISU8w58QRFu9tm0zfkpGbF8DV4g6/G4DBgCHTupYavyJY
   omgQLgZGT831+ctTCKWFOQ9sBANfTat1nCRZBGXnUONJLH2Gao1pSwNRc
   SSbh2whY+PREPVa7TVbaCu81Cb+vwCUo9190iiJPXS2mAIzuvZXv9fFbG
   b1O2UGP3X7snOGJ0eQMc2pYs+HAXgHYwmWv0eR4Al9HRmxV/Rf/5xibCu
   s0XG4eM/NHiXiOOcPYJXNUAl1btkbApjysct1a1PtcMtBh2oik8EFJEfz
   Vjd4gDjoIwKhzbM+PRI/h11q7j5PDXfdqeUAoc441evyrkjdG2gUvJ74A
   A==;
X-CSE-ConnectionGUID: SsziWTw9RsSe7GnqlsMwMw==
X-CSE-MsgGUID: AkhVBTF+Tn2+7+/V2QMHYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20011631"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20011631"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:13:30 -0700
X-CSE-ConnectionGUID: K8AMWA75TQWHC6+kiR6Haw==
X-CSE-MsgGUID: 2MxbOhhJRUyD5Hse0QMFmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54357886"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 31 Jul 2024 07:13:29 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/5] perf/x86/intel/uncore: Add LNL uncore iMC freerunning support
Date: Wed, 31 Jul 2024 07:13:52 -0700
Message-Id: <20240731141353.759643-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240731141353.759643-1-kan.liang@linux.intel.com>
References: <20240731141353.759643-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenyu Wang <zhenyuw@linux.intel.com>

LNL uncore imc freerunning counters keep same as previous HW.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index e02603e468ac..f0495867f054 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1840,6 +1840,7 @@ static struct intel_uncore_type *lnl_mmio_uncores[] = {
 	&adl_uncore_imc,
 	&lnl_uncore_hbo,
 	&lnl_uncore_sncu,
+	&adl_uncore_imc_free_running,
 	NULL
 };
 
-- 
2.38.1


