Return-Path: <linux-kernel+bounces-349634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99D98F950
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068051F22E0E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06BC1C8FD4;
	Thu,  3 Oct 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyuBWWWh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63E1C32F8;
	Thu,  3 Oct 2024 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992560; cv=none; b=mv06t99DYBp2PbjILNVqz8lo7q7ieFrGnbDX3/6EB4aWXVxzRf4LUe9QfsRoc2C7P15ffov4Hoi6JVkwblxOB9B/rcLjsk8iygLFsptG/Ndm5YL7v2qAvwdSJOur7O/YT76Gq2cA6GFpMPv5kGxF4zX9zFhvl8xMmrHhUUZFUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992560; c=relaxed/simple;
	bh=esDs2RmdrB6/nAxGGpfrppBHn38pThHzYzo6g9GO/xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jowODIkHXvTSZugbu5f0Ui5GKdO7vNq49TCNI3HMGqM3ecQAIrYBVREBFKF+7oIRe9XimdN5dke6uJ/0IdmG1iHv0K6ahL7wSly4MIuEZRUkrDgP7VfJcaLHd8yCGXx2QihkBk6j8xWjnDGfhgJ9cQ67M+h20u13iVphUQI8pCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyuBWWWh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727992559; x=1759528559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=esDs2RmdrB6/nAxGGpfrppBHn38pThHzYzo6g9GO/xE=;
  b=TyuBWWWhydRjNfaIqMF81rhtc3R72Muy/JoYnzX7wdIlDQjRlxBFcGdW
   9UBeo+Sy98yQq/9wRL8NcjH1HQJfqItG+W69IdmFdDRu1gaTOno+4Q+Nx
   Gn4Zx2qQStUXs3FcJ+5ZqpT/1fHzSr/puJN3w1CKX0z3/AWuYLyZI/QI2
   6zYBZ7b4NFbwMoUmA9+7oyXZOWhsXQGbKgIKLwIi2Cdv57CcjklYuweT9
   SWf5cJNZwPYUdnvq1P5ZMahHaSC0SS+w8/CIvo/ac6XY7G9BxCkjg2Wyw
   pz7nAYo+a9vxTDBlAX37NE87KHRUQBoazjAHaZEeSNT5YfHez1nLzen48
   g==;
X-CSE-ConnectionGUID: Df/OkG7kQhOdbXUqQFveXQ==
X-CSE-MsgGUID: LByqolk9TpS56Ef+DCjqSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="31094005"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="31094005"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 14:55:56 -0700
X-CSE-ConnectionGUID: YGTJgXKjSwaxtmurnWjPFA==
X-CSE-MsgGUID: lFFfD8QLQ9GhLXftHfCHDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74613939"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa008.fm.intel.com with ESMTP; 03 Oct 2024 14:55:56 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] platform/x86/intel: power-domains: Add Diamond Rapids support
Date: Thu,  3 Oct 2024 14:55:54 -0700
Message-ID: <20241003215554.3013807-3-srinivas.pandruvada@linux.intel.com>
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

Add Diamond Rapids (INTEL_PANTHERCOVE_X) to tpmi_cpu_ids to support
domaid id mappings.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi_power_domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platform/x86/intel/tpmi_power_domains.c
index 4eb02553957c..0609a8320f7e 100644
--- a/drivers/platform/x86/intel/tpmi_power_domains.c
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -82,6 +82,7 @@ static const struct x86_cpu_id tpmi_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	NULL),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	NULL),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	NULL),
+	X86_MATCH_VFM(INTEL_PANTHERCOVE_X,	NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, tpmi_cpu_ids);
-- 
2.46.1


