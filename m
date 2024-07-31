Return-Path: <linux-kernel+bounces-269345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF3E9431CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D016D1C21A99
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE81B4C31;
	Wed, 31 Jul 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScvPa+yV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87871B3F1D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435214; cv=none; b=TzlrX8igOt4Ddrb6BsqAKbkbva+kGp+KOBqM23lYuf+qYZofKQuB7YRO5BhbuXan6YfLTki+IojQvry0YPoBObljkjXndCl+nPLHa+gpPbwhH+E49wnaxUontFdm7q1ysdwSHkpqLNGOLaskKU6SCCXzbLOKiXviDiuohR1zncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435214; c=relaxed/simple;
	bh=f1mlblJ6eozU0CpRxhm3GKTQ2ISOd688sKsz808HlHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNkVPyqDlcmCAoxG6vArL9YmdBU7Xv30UviY9XhKDtkpGDZWF5Sx+u/SerLGg+pzuBONxnqsWN3MNyB/LQwadGQGHRmrm5Y+IIoozh67H2urcWBU1XzrmnMLPUPTN7fXT++Om6x9h5nxwTxBvSELpISK3vGsoU7Mn/wGJr/0OAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScvPa+yV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722435212; x=1753971212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f1mlblJ6eozU0CpRxhm3GKTQ2ISOd688sKsz808HlHY=;
  b=ScvPa+yVAidQ8x2epu+qEtW82feeAqoMgJEx63fLzk0gjk1ePRc741AU
   /muKu8TDin7y0b6ARqhxBacVN0PqfM9eqfI6ZBeW4IfuuOUFe3ALw0zb0
   5reUEyew+97M1zMQB80qyXesxYspPGL5hrOFJiGVwnkmNMwMqq8Kez8KG
   Liha6Jyyckenhm5t0TfdvMteXEMa5RHWTF++PUhjOA7ZbhkDLQQR3OZ1L
   HuF5/ZhLILcBSUT1uwFz9FdVZlmt28m2W+o4vCSQuwIy7c/2A5jDsDfjP
   dylugTR0aeU5VAAnpFaX+jkkLYNplylr2Fvodeq0sqwGOBcVSRWeIBf89
   w==;
X-CSE-ConnectionGUID: k/hQBdnTTqicmxDj907UKg==
X-CSE-MsgGUID: 9bQzApeURui/hcolySXAOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20011637"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20011637"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:13:32 -0700
X-CSE-ConnectionGUID: K3qqsMMGReiEhp7PEBWhag==
X-CSE-MsgGUID: JOZOdKz0STOCQ13ByZ36ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54357887"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 31 Jul 2024 07:13:31 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/5] perf/x86/intel/uncore: Use D0:F0 as a default device
Date: Wed, 31 Jul 2024 07:13:53 -0700
Message-Id: <20240731141353.759643-5-kan.liang@linux.intel.com>
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

Some uncore PMON registers are located in the MMIO space of the Host
Bridge and DRAM Controller device, which is located at D0:F0 for
Tiger Lake and later client generation.

Use D0:F0 as a default device. So it doesn't need to keep adding the
complete Device ID list for each generation anymore.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index f0495867f054..1de24202ac7a 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1504,6 +1504,10 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
 		ids++;
 	}
 
+	/* Just try to grab 00:00.0 device */
+	if (!mc_dev)
+		mc_dev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+
 	return mc_dev;
 }
 
-- 
2.38.1


