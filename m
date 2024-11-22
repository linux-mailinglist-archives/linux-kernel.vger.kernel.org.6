Return-Path: <linux-kernel+bounces-418872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9089D6688
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A891611F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B131DFE29;
	Fri, 22 Nov 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJVs6z2K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF091DDA34;
	Fri, 22 Nov 2024 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732319925; cv=none; b=rvkYveSB297Vb8vQYsACESgwNxlYr2Pct4LXPzMPGve5BfEz7SWlRFd5Pk+/+BMCTibw5USYc0ruLquW0Nz6eC2RRL1Fl/XgmHtF0iZvAeedWTl9q0Rd35iKXDNIfr3VMIhs69ufu0m+T5IUzFKpnWYEEooFJe2pQgD7R6XVBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732319925; c=relaxed/simple;
	bh=fDfCFpRA+LjYsiAD12YwWZsVIyVX7Go/gjuhBuSbHhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM2EOPmVQUrHi3lQvBbJEDDKnMb1z9PDFb3Eg9Lv28UgYUOSL5g7C9fMemTmb5sEqQpsfKw4MKpenM+xjnUSf+mR/dOqkaGeOctZJpUAt9+yXvMpyUgMqUWYriRcEdS+3WcsCwdoBjbmSrxn4JF2eKdpsWdOArv2h+AqIFde0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJVs6z2K; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732319924; x=1763855924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDfCFpRA+LjYsiAD12YwWZsVIyVX7Go/gjuhBuSbHhw=;
  b=cJVs6z2KqDyOmheMrn2HYie0Zpf5Zf29JHEGM/FcMlv9qqnzAUpbblzg
   /hxDvXqnMg6+d8IJGFt0FTxcFgwEKgATYxWdRX+UvOEcU+y5NHqfvZYoc
   MQW8QdJZD85yG188kUrqW+i/0iSMEF1LkGZtToKAtGBHdu7A45sAppDLt
   vaVQNq6JGsaMW9TZNVNBTzZVqkYZu6GiJLnYbuSOAAIlJkcVF4SDeZiqp
   KwBKE/iJZBNTxs/VKv+UCFK14C32kXy+8fUyOtA1Dixi6LUhjTfGO27xZ
   Az5gNeo2O9ecjxpqPbdkywYFIPDc1iah85Qs4yzuLCbxlxks8IMR3LPdr
   A==;
X-CSE-ConnectionGUID: qJl9lnLURcio6lRDjNcOiw==
X-CSE-MsgGUID: v8+lscckRoK6rUVpLII0bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32642765"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="32642765"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:58:40 -0800
X-CSE-ConnectionGUID: QRhHz35tSHyVzsmQTImAGg==
X-CSE-MsgGUID: /aPj5Iq+SpG2br21mtPLsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="90850919"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:58:40 -0800
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
Subject: [PATCH v10 8/8] x86/resctrl: Document the new "mba_MBps_event" file
Date: Fri, 22 Nov 2024 15:58:32 -0800
Message-ID: <20241122235832.27498-9-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122235832.27498-1-tony.luck@intel.com>
References: <20241122235832.27498-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section to document a new read/write file that shows/sets the memory
bandwidth event used to control bandwidth used by each CTRL_MON group.

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


