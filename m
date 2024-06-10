Return-Path: <linux-kernel+bounces-208748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA919028CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907F91F226E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8731514E0;
	Mon, 10 Jun 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZWvxHUF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829314E2EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044546; cv=none; b=aM6uq1mil7ntIl9Q6HUdEnngc0MGpWHkDnR/UZBFycFJU4mVUKE5baV8w4y9V4J8FIq5cA3dgXlDMMkT14mFcPhMy6wGEAGtR5zN62JlXKzzc/4WlKg+oJUzPPjoJdcSfwslfnwQVrl4AFtBUllXLzK1NSHaWvf1n4V9jypNHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044546; c=relaxed/simple;
	bh=trkSesWB4tFV2q3Q20dRF9Du3uBUDy6ngniRBxlmqCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/AADr5DtEH0cxmwDsJweMq2uz53983FOlw/tCT9MzyL5FdHmEbJ7eckZeVNV7iThKCXGbfMKza1ylV2vsaiEHS6tvYEOT5CKdfJZtrsI6liI3LxsX25OHdi+d4mQuczsvnbEeHBrsb68mIcPCCNur/HFWGYHrDuiD+c6D6fmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZWvxHUF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718044544; x=1749580544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trkSesWB4tFV2q3Q20dRF9Du3uBUDy6ngniRBxlmqCg=;
  b=EZWvxHUF/JBIdceVUSOIivnXVQPJ6Y2wC1yta4rxMdZhdRvft6oU+21c
   GTUQSnYGy+E69wmcxbdOiEUrMo9QSdl3HZVuJQnx521UZXP2tVuYW52HB
   DIXUXeaCDhybytozhNu3aYhz0V1YBD6mVfJg94xetZM6C44l8dEk77aOO
   VwyBDr1PprGrz+4bGCzO32dgRNRmj3+i8qBBSjTBofgjEnTGi1V6YydUH
   PrdXBOYDhWKnkgUHE+0fSCFdxx3DC8HbHQOJ7tzP0g8A5w3DoeK1k3ORp
   r0djxYJu3ujA2gZ4/6ZdxaTTb+7KFUhreHgPPdkl8lknx9YOOr/5HJ7RH
   g==;
X-CSE-ConnectionGUID: V5/3Os/cRhar0qaVtaz8MQ==
X-CSE-MsgGUID: Gz9Sxz7qTWSbkV1EnKIt4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12004846"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="12004846"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
X-CSE-ConnectionGUID: 3q3p+jN1QD+YKEm54Rc/Sw==
X-CSE-MsgGUID: ow8kalNWRJG1e76SUtn8Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43576582"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v20 11/18] x86/resctrl: Allocate a new field in union mon_data_bits
Date: Mon, 10 Jun 2024 11:35:21 -0700
Message-ID: <20240610183528.349198-12-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610183528.349198-1-tony.luck@intel.com>
References: <20240610183528.349198-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Sub-NUMA Cluster (SNC) mode is enabled the legacy monitor reporting
files must report the sum of the data from all of the SNC nodes that
share the L3 cache that is referenced by the monitor file.

Resctrl squeezes all the attributes of these files into 32-bits so they
can be stored in the "priv" field of struct kernfs_node.

Currently only three monitor events are defined by enum resctrl_event_id
so reducing it from 8-bits to 7-bits still provides more than enough
space to represent all the known event types. But note that this choice
was arbitrary. The "rid" field is also far wider than needed for the
current number of resource id types.  This structure is purely internal
to resctrl, no ABI issues with modifying it. Subsequent changes may
rearrange the allocation of bits between each of the fields as needed.

Give the bit to a new "sum" field that indicates that reading this file
must sum across SNC nodes. This bit also indicates that the domid field
is the id of an L3 cache (instead of a domain id) to find which domains
must be summed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d29c7b58c151..77da29ced7eb 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -133,14 +133,20 @@ struct mon_evt {
  *                     as kernfs private data
  * @rid:               Resource id associated with the event file
  * @evtid:             Event id associated with the event file
- * @domid:             The domain to which the event file belongs
+ * @sum:               Set when event must be summed across multiple
+ *                     domains.
+ * @domid:             When @sum is zero this is the domain to which
+ *                     the event file belongs. When @sum is one this
+ *                     is the id of the L3 cache that all domains to be
+ *                     summed share.
  * @u:                 Name of the bit fields struct
  */
 union mon_data_bits {
 	void *priv;
 	struct {
 		unsigned int rid		: 10;
-		enum resctrl_event_id evtid	: 8;
+		enum resctrl_event_id evtid	: 7;
+		unsigned int sum		: 1;
 		unsigned int domid		: 14;
 	} u;
 };
-- 
2.45.0


