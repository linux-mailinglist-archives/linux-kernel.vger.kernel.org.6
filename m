Return-Path: <linux-kernel+bounces-196948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 649898D6414
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946E11C23C63
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6CD15B112;
	Fri, 31 May 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVd9zaMo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969715B578
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164667; cv=none; b=MXuZuHjpgX/lV74KsjwA42PywaEG4Db0OYTdHKq4X8zKX++yYErArSFmCtHSDQ2hA7RkeF3jY/XP7HD2XL8gylf+SbpZw8oToe9eqUWEKWF38t9XNP8TN2XT3BuIjfxAmEGhD5qjFrcSJEWNwjeZQVg+U8rN2qQJyzzPOvX2ci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164667; c=relaxed/simple;
	bh=Jr9+4d626a6bVHXAZebNVIeaEt+0aIeZfHVPmB0HWTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rfPf5nnHhnPDuN6tj7i4RQjUpQAGTJ5rlNIs/rFk043YRl0re6u5gOe0ht1ajwzY9y4/kxxxFkgpHEirIlTxKO4H0Hx7DhfAi30YANdEVFsLIvCz8NhxO6+0/6ImZzVdYWBQFEixbC8nsOqGz6HjGJ+OzY8973Vrb9H8UHfHmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVd9zaMo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717164665; x=1748700665;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jr9+4d626a6bVHXAZebNVIeaEt+0aIeZfHVPmB0HWTU=;
  b=QVd9zaMoR7xCIEOMHvzG1m3s+IrH+58MHiLV+3IXhVkqniszyfbPyDoP
   cBf+8rdcznVKGXDhJKVOvKTYE2+9NGkRrjvqHaUkWU9Ds0dDPgQQPRCT0
   n76gfm5PIqYG1ZqB/U9YwpTOgygxPBntDP/ycKODj/m9RmPxf9UJqVloE
   8R4sRaIo3oo9QUB6JKhbVljbGsbX5b4eZJZzB0C1v0TOXW/47qSyoW4wR
   aOsw7f0NCvHBCL561JDcnwiSaceo8DWl8h29GrVqgn2hih3pF/qpvIDfa
   +qk93kIqxY20Fs0bOKWyKiGoHvYmSeYzmr6Vzb/9pWMhlmOh7pilpJvhT
   w==;
X-CSE-ConnectionGUID: L8p8Y0drQVmoTXWCIq4yRQ==
X-CSE-MsgGUID: lyJLQgxySXaw50dLD1pRIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24370441"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24370441"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:11:04 -0700
X-CSE-ConnectionGUID: RQ0/L3NvR1S6TrsgYIma9Q==
X-CSE-MsgGUID: ARK77DD+QoKLLid+umIJOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="67369288"
Received: from unknown (HELO fedora..) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:11:02 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Xe driver maintainers
Date: Fri, 31 May 2024 16:10:51 +0200
Message-ID: <20240531141051.504610-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Rodrigo Vivi as an Xe driver maintainer.

Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 572be0546e21..8f9982c99257 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11037,6 +11037,7 @@ F:	include/uapi/drm/i915_drm.h
 INTEL DRM XE DRIVER (Lunar Lake and newer)
 M:	Lucas De Marchi <lucas.demarchi@intel.com>
 M:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
+M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
 L:	intel-xe@lists.freedesktop.org
 S:	Supported
 W:	https://drm.pages.freedesktop.org/intel-docs/
-- 
2.44.0


