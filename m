Return-Path: <linux-kernel+bounces-414406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F79D27A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626F5B2A504
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44651CDA1C;
	Tue, 19 Nov 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdUDlAgu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F83197552
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024697; cv=none; b=UuSqB1iuNFTSXW4AyvlRx8+AQpLwLWcFfMfb5sRZuo5aXp3IaR2Vny8Dy5mCdeRVHfJlMXnQp9TglImpDYu5PKdHeOsLQoMtf5PVDAIgZsKcNl7RSbTKXGjex+xLKCve6StS2kzRdsks8yn3BUwU9adSF6Ta2a/2Torpu1Jha0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024697; c=relaxed/simple;
	bh=IcQNej403HdCJ7UY/U6sAxWXZM/9iZaVtJDMUwWPg50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJbpuNRm1wuUZ+vcNVYrLS0lc8FQTXDn3QAQNPrdXdIcAzcZDnMF94SfLR6Kw1AIDLfcbYubeWfzK44KjPSZSCu7v+8U8SeCrolS39pxe3zRgYZFRHauA6LwYMTrGLyCiFfdIoND9zN5KiQKLLB6fwjrodsmlxHVbnmpCWLyhp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdUDlAgu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732024696; x=1763560696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IcQNej403HdCJ7UY/U6sAxWXZM/9iZaVtJDMUwWPg50=;
  b=XdUDlAguWqoO3eoz3nm51AkZe87rxucWAmtCSBQZfrp8XXaS5NtV5N6M
   q0VLUvMFFVI/vIkJE85Xca3rZW2Wmdh9HD6yff2ILa2RrhYKRi5IIN9we
   jpADalYFj6J/ldl2LSiuTysjB4lwoBqaRKuDvFjok0IrEEk+N3wqvCnN/
   fmJ5/x9WLSGG1KmJ3bbXdQhQ+LXYq1k5U86vRuxGyKxKpULklaCkdD95K
   mUK/6N9Y0P+xlPQnMLrYoV9qHUaHuX99UhqGO/x4//ckLX+ybbJ/xEpc0
   FBMzm9TD1a9EvMi1mIaxr6WNU+gW26wtzX0ZeMpji4ynVlX59fLzoqE5q
   g==;
X-CSE-ConnectionGUID: jVPjljlXTT+1y76CVHnCCg==
X-CSE-MsgGUID: Xz/9k1j/S6qibOO5+DzkMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31435314"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="31435314"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 05:58:15 -0800
X-CSE-ConnectionGUID: JrwdKOoHRHWOzWFkoWrVtw==
X-CSE-MsgGUID: pzj2qb/uTZKliYfdQhAGJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89956368"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 19 Nov 2024 05:58:15 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/4] PEBS DS bug fix and optimization
Date: Tue, 19 Nov 2024 05:55:00 -0800
Message-Id: <20241119135504.1463839-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Fix a PEBS DS bug which also impacts the existing implementation (new)
- Factor out generic functions for PEBS records processing (Peter)
- Update the description to explain the reason of moving
  intel_pmu_save_and_restart() related codes to the end and droping
  the return.

The V1 can be found at
https://lore.kernel.org/lkml/20241113151427.677169-1-kan.liang@linux.intel.com/

Kan Liang (4):
  perf/x86/intel/ds: Unconditionally drain PEBS DS when changing
    PEBS_DATA_CFG
  perf/x86/intel/ds: Clarify adaptive PEBS processing
  perf/x86/intel/ds: Factor out functions for PEBS records processing
  perf/x86/intel/ds: Simplify the PEBS records processing for adaptive
    PEBS

 arch/x86/events/intel/ds.c        | 191 ++++++++++++++++++------------
 arch/x86/include/asm/perf_event.h |  16 ++-
 2 files changed, 128 insertions(+), 79 deletions(-)

-- 
2.38.1


