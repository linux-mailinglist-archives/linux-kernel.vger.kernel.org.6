Return-Path: <linux-kernel+bounces-561154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B0FA60E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78B717EB3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DCF1F3B94;
	Fri, 14 Mar 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVjkQMhJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C01F30C3;
	Fri, 14 Mar 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946504; cv=none; b=nTv0HGSni1zRULmHWDHjw/CCGF8mUc+JZx84HwTmjf0e31WwPEAa/s93pwX9Xu6ezWmReggTkCI1813btOB1S18CK9JBWE0GtsmpjUqkvC2raD1XVwoZbLSO0fM+VL/yr/RhKkNNujUZqEhKlYbNabF1k/Cg7I3HeZ/16/CHJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946504; c=relaxed/simple;
	bh=ssdVXLgH46tCNp5vgZI7lWWdXz1whwaAJoMzKSN4mKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9ZTKCPyFnb20ka4XZ/ezzMbhJ+gxq32Ps22+/OqKxAj/eho99p2dHxuDqTMw0bOxSwbk422q2y1Per6qUYJQOyqBEIq83Ja0ZWEexCPQN/5cl2p4MaKz2KXiPXTY5fML72QQjxuPy88j2L0pA/bN+kgar0osQDsDKnqw3I7O8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVjkQMhJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741946503; x=1773482503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ssdVXLgH46tCNp5vgZI7lWWdXz1whwaAJoMzKSN4mKE=;
  b=XVjkQMhJ5X2+dVcJo5TsR2t7WRXnKiYQg1W8UVy75Jg6QXrmr251ri1e
   GKmr7SClS9TPYZm70Ja92/ETVQZH7G/2IIoiau8aHNCY9nrW7O+nwgtB2
   4z0qFmUOfpRSk57l74aXe/lWcNcEzNKMSGEvcCbCDRhPJjZgIU+wPPV8W
   5swQvEfa9hAwOsBi4Kq4Js5T/FK0cVypnrpj2PhEkMSGpNO8hdSKwLwa2
   wmLieY5rS8ydmGWGl91I0iwiWC273oyhTPIkxlyXjAGM+1qrkdsODglXY
   OACF5eSGAqJiVlEt2IZ/qCOAwxrxPr1BEo4QGOybiLqims5UzZJ9E0NA5
   Q==;
X-CSE-ConnectionGUID: Hc4NP3j+QvCgV5DFd8oerw==
X-CSE-MsgGUID: As2cQozoTLquKVNI4Y8dVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43197139"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43197139"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 03:01:41 -0700
X-CSE-ConnectionGUID: //I4/LOVRtmeSfvdraR8XQ==
X-CSE-MsgGUID: fvqhzmGyQ8+7cLgK3UHdMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="120944855"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 03:01:39 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH] docs: driver-api: firmware: clarify userspace requirements
Date: Fri, 14 Mar 2025 11:01:36 +0100
Message-ID: <20250314100137.2972355-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The guidelines mention that firmware updates can't break the kernel,
but it doesn't state directly that they can't break userspace programs.
Make it explicit that firmware updates cannot break UAPI.

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 .../driver-api/firmware/firmware-usage-guidelines.rst        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/driver-api/firmware/firmware-usage-guidelines.rst b/Documentation/driver-api/firmware/firmware-usage-guidelines.rst
index fdcfce42c6d28..5f8f13e2ee510 100644
--- a/Documentation/driver-api/firmware/firmware-usage-guidelines.rst
+++ b/Documentation/driver-api/firmware/firmware-usage-guidelines.rst
@@ -42,3 +42,8 @@ then of course these rules will not apply strictly.)
   deprecating old major versions, then this should only be done as a
   last option, and be stated clearly in all communications.
 
+* Firmware files that affect the User API (UAPI) shall not introduce
+  changes that break existing userspace programs. Updates to such firmware
+  must ensure backward compatibility with existing userspace applications.
+  This includes maintaining consistent interfaces and behaviors that
+  userspace programs rely on.
\ No newline at end of file
-- 
2.45.1


