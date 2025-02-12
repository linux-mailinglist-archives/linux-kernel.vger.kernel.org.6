Return-Path: <linux-kernel+bounces-511842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3BEA3306F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E280F7A0504
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A87201249;
	Wed, 12 Feb 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDzqKfQr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A417200BA2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390772; cv=none; b=BmyO7pFUiz06YYqBH5ekIraBiN9Y8YpM5Og8eIokmSVHWPkzIfNNFCtqER4gH/CajaPPH6udZ4lnuBBn8gUmetG4Z9/NtPZz7DfuMN5SpskZPEgOW/qN19axzxp3qKR/IjNgv3hE2bfl/FN6p0K3FKqiNpSMA4wFr/dbspd627w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390772; c=relaxed/simple;
	bh=SMq3tRylkjXeGIrAENWvMD6N50P9AHGv6CJDNT0dJM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxgcu15oAe8L9pInmoa/zNUGjugzCy31xGCf0rND8W+42K/RMljisNsH+qJlUGxTZziWx2b4iP1aRiHl1nu2EjuhR1ZmNPZKvtx6lgBbwKKyUxZCspjolfSiQoY8fmmipCLMb2Yh5RvvA6HNayl+lm+lQGAQUzRXR0bMw3npOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDzqKfQr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739390770; x=1770926770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMq3tRylkjXeGIrAENWvMD6N50P9AHGv6CJDNT0dJM0=;
  b=EDzqKfQrcIcsaJX8a0EpjcIhUNFOmG/vWzPDPiRKEn+WvwffnqVf1YoU
   dCdGpxMp8KgqX7L5XwMFp0Zau/7CKQOTSNByjGY5koJDPehGcE6PSQ1gB
   jJL+IQg2FXaDgHKUyYU8vXPEKrHa01LRcsM2RIS5JO1w3v93zLx1xdJoI
   05U2iaI20R2bxljPrVx+5ZksSzHJl9eifjPHmkF17w6xN3jn3cfFdm/5d
   FA1JRxNfYQKgqtEwzXqpU4VPsqSyPLUpvTgxI4xJoSzhZrnGz3Mr1X4Rt
   1QaKSSVuHBKIsc9a8MGbdWuG+OwqBxU3zqwdunz/J3x+qWsbq2YPNNWMP
   w==;
X-CSE-ConnectionGUID: qPQGMDdJRZOqhKLH1zQOYA==
X-CSE-MsgGUID: GOGNKvBwQqayKJJw5jQA3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50718488"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50718488"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:07 -0800
X-CSE-ConnectionGUID: XsG6tWzXQ22ft0Xl+AHlRg==
X-CSE-MsgGUID: VSyvEcdoQzWlgxLF20YJ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="118010754"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:07 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/6] drivers: base: devres: Allow to release group on device release
Date: Wed, 12 Feb 2025 12:05:37 -0800
Message-ID: <20250212200542.515493-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212200542.515493-1-lucas.demarchi@intel.com>
References: <20250212200542.515493-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When releasing a device, if the release action causes a group to be
released, a warning is emitted because it can't find the group. This
happens because devres_release_all() moves the entire list to a todo
list and also move the group markers. Considering r* normal resource
nodes and g1 a group resource node:

		    g1 -----------.
		    v		  v
	r1 -> r2 -> g1[0] -> r3-> g[1] -> r4

After devres_release_all(), dev->devres_head becomes empty and the todo
list it iterates on becomes:

			       g1
			       v
	r1 -> r2 -> r3-> r4 -> g1[0]

When a call to component_del() is made and takes down the aggregate
device, a warning like this happen:

	RIP: 0010:devres_release_group+0x362/0x530
	...
	Call Trace:
	 <TASK>
	 component_unbind+0x156/0x380
	 component_unbind_all+0x1d0/0x270
	 mei_component_master_unbind+0x28/0x80 [mei_hdcp]
	 take_down_aggregate_device+0xc1/0x160
	 component_del+0x1c6/0x3e0
	 intel_hdcp_component_fini+0xf1/0x170 [xe]
	 xe_display_fini+0x1e/0x40 [xe]

Because the devres group corresponding to the hdcp component cannot be
found. Just ignore this corner case: if the dev->devres_head is empty
and the caller is trying to remove a group, it's likely in the process
of device cleanup so just ignore it instead of warning.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---

The check for just an empty devres_head seems simple and sufficient,
although the caller of devres_release_group() can still shoot its own
foot. I thought about a flag on dev to check it's being removed, but I
want to know others' opinions first.

 drivers/base/devres.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 93e7779ef21e8..b955a2f9520bf 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -687,6 +687,13 @@ int devres_release_group(struct device *dev, void *id)
 		spin_unlock_irqrestore(&dev->devres_lock, flags);
 
 		release_nodes(dev, &todo);
+	} else if (list_empty(&dev->devres_head)) {
+		/*
+		 * dev is probably dying via devres_release_all(): groups
+		 * have already been removed and are on the process of
+		 * being released - don't touch and don't warn.
+		 */
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
 	} else {
 		WARN_ON(1);
 		spin_unlock_irqrestore(&dev->devres_lock, flags);
-- 
2.48.1


