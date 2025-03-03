Return-Path: <linux-kernel+bounces-542908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0C3A4CF49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36831726F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67923F273;
	Mon,  3 Mar 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3vqxNE1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA322356C8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044893; cv=none; b=qdHKxNhAS6Utu1GF76J4lsfVZJtR1Hbumx8tww7Q6x0gFI7hu19OXzgN1vGnxaxGoJuz/mNuK2TPgUfynAux7ebzZwks5tlOrYIFTPQaPkvBtZCgJAo3FNzFpJdGBBO3O4hKUon2Idp9NU4F1fAU0B9QUpclECkyEj1PT2kFemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044893; c=relaxed/simple;
	bh=2JE7D+GpR0JZonbnGe6IENILzvHBEw665f3y+t4MPlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwg6VjMQL9W6VeQ5gxCWeoTeDMc3WjXCDrvk+jeA7KmrX+mdVKdowtX5A2b/lFGfLiUOv71JarY1Lrjb/ICPBwmktv/MAUSj7k6b2NjdivCtUV35Cp2espwVHfyhhnJMVqcnLl8nLhTHccdKENsjzUd6JG+qyv0lr1fK1Z1MPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3vqxNE1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741044891; x=1772580891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2JE7D+GpR0JZonbnGe6IENILzvHBEw665f3y+t4MPlI=;
  b=b3vqxNE1GPMwLvnpQTgwvH7VPHE7AygwfwktdjL4BcazugsIv/trh7Gp
   3myy9+VwginBoUcPJU4P/XhaXKaLvuXauwcn3Ajw89wqrXNHo5jLpNvQe
   +ZTR6bywk1uNwP8L/B2VENewhIjQ2RqIosq4h+EbGto9HczUCetsyKpyG
   TzELopaU5sGmZSWRp1hGMKQUmIz3tZrvGYcXT/MPyP15Ts3ry7Vrxwo1k
   C6Nz7ViD3YY/yNWP+CLuyJe9EUh+yJLOvlNtgWUccw81WpyH4lnnQETJ/
   bo+Oly2ioCRiDHHuFL2U6C/Xv5ghXv+HPuHFTKeNfp4V2qTjzH3AnH1BH
   w==;
X-CSE-ConnectionGUID: 5w1sJBtORACzLBdCMebrpA==
X-CSE-MsgGUID: hrPcmz1YRqa7aR74gLaXjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41835941"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41835941"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:34:47 -0800
X-CSE-ConnectionGUID: x52Hw6wjSNmnLV+iTLo/Lw==
X-CSE-MsgGUID: ZJMt9MS5QbC/1YGyZ/v9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117982292"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:33:51 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 07/17] x86/resctrl: Prepare for resource specific event ids
Date: Mon,  3 Mar 2025 15:33:27 -0800
Message-ID: <20250303233340.333743-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303233340.333743-1-tony.luck@intel.com>
References: <20250303233340.333743-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Event ids ought to be specific to each resource. Keep enum resctrl_event_id
for event ids in the RDT_RESOURCE_L3. But change the type in generic
areas to unsigned int so that new resources can have their own event
ids.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b8f37170f6e5..c8da6fac4720 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -114,13 +114,13 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
 
 /**
  * struct mon_evt - Entry in the event list of a resource
- * @evtid:		event id
+ * @evtid:		per resource event id
  * @name:		name of the event
  * @configurable:	true if the event is configurable
  * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
-	enum resctrl_event_id	evtid;
+	unsigned int		evtid;
 	char			*name;
 	bool			configurable;
 	struct list_head	list;
@@ -131,7 +131,7 @@ struct mon_evt {
  * @priv:              Used to store monitoring event data in @u
  *                     as kernfs private data.
  * @u.rid:             Resource id associated with the event file.
- * @u.evtid:           Event id associated with the event file.
+ * @u.evtid:           Per resource event id associated with the event file.
  * @u.sum:             Set when event must be summed across multiple
  *                     domains.
  * @u.domid:           When @u.sum is zero this is the domain to which
@@ -143,10 +143,10 @@ struct mon_evt {
 union mon_data_bits {
 	void *priv;
 	struct {
-		unsigned int rid		: 10;
-		enum resctrl_event_id evtid	: 7;
-		unsigned int sum		: 1;
-		unsigned int domid		: 14;
+		unsigned int rid	: 10;
+		unsigned int evtid	: 7;
+		unsigned int sum	: 1;
+		unsigned int domid	: 14;
 	} u;
 };
 
-- 
2.48.1


