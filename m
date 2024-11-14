Return-Path: <linux-kernel+bounces-408477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18949C7F41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66265282DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FDA55897;
	Thu, 14 Nov 2024 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WytEwoQF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F022AE8E;
	Thu, 14 Nov 2024 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543447; cv=none; b=KjQjc2u/ejBHL8juLFnDnQMyHPmTwdDllcgzttKeYYKYG4e3t2QEh7Z1TI67aIxHhJeUvcRZtLavGF+2PgEOiuqxJ7lbcITsJVMwhs0NnqlRiA9KzzkXjXLKWrmitfQba44FrHkX4bPln6AThQu4tvQQgpw8mNDWBYC2qk/RFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543447; c=relaxed/simple;
	bh=l+muwJjd4b/MMagbFBq0iDX4dVxLpcndlyRlD39vk0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1hlu+c6BzZv4RcAxyz5JEHn+oAjb26asMQYND1J86/1V6pDMb782ZGccenSpxqTMQFJqDTinw0cx+GB8LHtQ9VsxCmQk/H94mmjCfTh268QotQVCw6yqNgZENHgxFUtDEM68SncIKTRCU+4P1eNi8kXx7qo6fUBSz7RCM/+1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WytEwoQF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731543445; x=1763079445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+muwJjd4b/MMagbFBq0iDX4dVxLpcndlyRlD39vk0s=;
  b=WytEwoQFveP1zXhCA7GJq3c/ZR+RO0XWve0rmm7mVmZCyDyFrAG/SlS6
   kWBlF7R33qPvIu48eVNaDsOkoIuVroc8031V5slwQyP2Nrc/orLB7b+wl
   zvgdo7R4bA/mPEeXst2LI+NVEb5fKRk+yc+iGn4kSCj5+NpAiWnP9svfh
   oiWZArwsz/TL8zO8Px2YshEvuyNUz4r8ltlY8n1S9emZhtFfRevFQu0R8
   YoZ26PIYP1N/Sf03+jLk4BuaC73Hxt/Ws27MEBcTjxclr+Uz+/Lk/SXRY
   BqH9B1zKbIYu91jntcheE4ncwEm0o+EKKLZjfrl4yDJT0THYVfnyOOijq
   Q==;
X-CSE-ConnectionGUID: pt5/vAEKS0+IPAK3tpdE6g==
X-CSE-MsgGUID: oKrCxsuLRSuVzIoqEQ8vDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="30869540"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="30869540"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:17:19 -0800
X-CSE-ConnectionGUID: khuRkRx+Qm6mbRfwLv0nGg==
X-CSE-MsgGUID: QVZiBJ/cRIWtxagvcsXg7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="92081175"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:17:19 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org
Cc: James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v9 9/9] x86/resctrl: Document the new "mba_MBps_event" file
Date: Wed, 13 Nov 2024 16:17:11 -0800
Message-ID: <20241114001712.80315-10-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114001712.80315-1-tony.luck@intel.com>
References: <20241114001712.80315-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section to document a new read/write file that shows/sets the memory
bandwidth event used to control bandwidth used by each ctrl_mon group.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/arch/x86/resctrl.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a824affd741d..6768fc1fad16 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -384,6 +384,16 @@ When monitoring is enabled all MON groups will also contain:
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
 
+When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
+
+"mba_MBps_event":
+	Reading this file shows which memory bandwidth event is used
+	as input to the software feedback loop that keeps memory bandwidth
+	below the value specified in the schemata file. Writing the
+	name of one of the supported memory bandwidth events found in
+	/sys/fs/resctrl/info/L3_MON/mon_features changes the input
+	event.
+
 Resource allocation rules
 -------------------------
 
-- 
2.47.0


