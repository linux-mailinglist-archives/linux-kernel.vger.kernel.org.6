Return-Path: <linux-kernel+bounces-435332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2809E762B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C2C1889793
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04C21CFE1;
	Fri,  6 Dec 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQy7ju9G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ADD20458F;
	Fri,  6 Dec 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502721; cv=none; b=PhIvszoknMbkC4kpXmOZLeFhGdyadW/egd0+O3+imv9dXGSN8Eo/sNRj6nwrlkf50g5Smkv6uq1hIBo6F6gsa16NSHCVFX79Tga43R0OExD3OWrqQUITEXHmgaONgyqnN5DJ5eayoWMiJI2HbemwzRVw2ZmSkfEiofaZkAcuWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502721; c=relaxed/simple;
	bh=RFzKZU16G64WevDvffNNaOLPzBtFmeFhRrOM1vduHhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcF8ZFFivn5CE5E0fRQJWNCmLbjd2XpYfYtR9dZ0xhKagtMkYmLuKL7RTT3c5aLJ+bcEfkbCmjy7M4FnG9HT7h+l4hd+4KXdUxV5nID0Tk12ezPwhw7s5qwXtAZ8xQoSOIW9PjUbHxfhs8Brq8WxgDoSGTs8YIcZFDG78yox68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQy7ju9G; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733502720; x=1765038720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RFzKZU16G64WevDvffNNaOLPzBtFmeFhRrOM1vduHhg=;
  b=JQy7ju9GNAunx5Rc4T6ckckFBDRjFVmiist2LnZCF3/D1J8/gZOfx1qL
   AXN73GHW1UO7gG+qI25d0UDs5d4/JHeL6SDed9pjxYr7XW1gO3yg7vAm5
   byS3g3rGrClRm1ncmNpnvnV7TdJS82gbe+6VnIUDDrqXcLD72PRui/sTz
   iP3YYnVgvfd1/j2J7avHlqQoKoj6hOmslgvHYiOvW5L06OfBfeJGOWa8N
   TErjpfc/ksutifAFCNshtG23NXhngsLNqwVKROtnztF73pJquOlWXCs1D
   7R+54ePFUmLchR+KdeU3qQrVb4k6trjDkiLWzjoBxxR89mUlhtjfWQZdR
   Q==;
X-CSE-ConnectionGUID: VfNi3os7SLyCIMygeDmeAQ==
X-CSE-MsgGUID: YHR7dfaDTha7IIv1Pj+10w==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="44470446"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="44470446"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 08:31:55 -0800
X-CSE-ConnectionGUID: jctF4re7QMyXOcO8Jb6sSw==
X-CSE-MsgGUID: ahdfbdBNT5KrzPn25pqrtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="95258533"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 08:31:56 -0800
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
Subject: [PATCH v11 8/8] x86/resctrl: Document the new "mba_MBps_event" file
Date: Fri,  6 Dec 2024 08:31:48 -0800
Message-ID: <20241206163148.83828-9-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206163148.83828-1-tony.luck@intel.com>
References: <20241206163148.83828-1-tony.luck@intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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


