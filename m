Return-Path: <linux-kernel+bounces-198386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD738D7789
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 21:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82001281651
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 19:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2206EB51;
	Sun,  2 Jun 2024 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjSEd6IE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008EE6EB56
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717355588; cv=none; b=U8ckKFf8EIQ4x4+6BzfpX330KygUq26fX8IM8KZOGP62FQvuC9JQ/ID7fOUF6EVZEe5EcMbHxfCTQ03QCGNyFD7P9hUvUTUz5z/rlN/uIuiIFzhL9/3yBTiqy3iSXQgfP6+gGeKDwNgcQMwwhAbFgi+tScQPv20wtN0gptFh3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717355588; c=relaxed/simple;
	bh=rKvVyYSCxCQMA8ehm3RHTVkgQ/7MJe3SBF+8guMhULA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RBKhqOf9TT411T+bhWKm7FvLFggmaNn4x8yYVnZo9fenjEyIdc01X8pMETHdkP3A6Je999H0Llpkrgn8com+O+xPJvPVjZEBH3HJqV3K1uq1GypE5Fp8aU+2a0URT/xj+hxzlFg0V5M0OxBapOjJETj50JCwn/8jeyZfa07eWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjSEd6IE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717355587; x=1748891587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rKvVyYSCxCQMA8ehm3RHTVkgQ/7MJe3SBF+8guMhULA=;
  b=fjSEd6IEAL+tRs2/0On40SLMDDpC9ZFLyHiFr5GzU2pj/JlOiECiWC0O
   lnYFE+V3qoS/TRNLNBJmaYFqc7S+RZg7Moh99nQOfd7b7c2e1k/9NLiBv
   bjTz5KFRtw1ZoWaUIMhA4wzawGnpR4PEEGRnpBGUEvi7rZTSc/WoOGWJu
   SEaMYzph8mnCR0ICTD1FZUPzKokRdQvLI1/L3nWffv4ixyIpO1TiMlrMr
   O0CfCaP4oSpzpdHE6tWxPnH2cv4+xCjQMB+Xo2NaVss2UYnAQCTts68Jx
   Lo3EIky/3yJorVy3nMvAaPNQOTkt7+iPmm57Z3icBAVUM9/OdUkO8354A
   A==;
X-CSE-ConnectionGUID: l04t5GsSQ2msTWTSMTRFCg==
X-CSE-MsgGUID: K2jO1KGuSoGxcdHOA2K2fQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17672839"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="17672839"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 12:10:36 -0700
X-CSE-ConnectionGUID: JwjuhTSGR0CR2oAZY/9pjg==
X-CSE-MsgGUID: blwVm64rRbCUlj2XhiZNTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="67520106"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.245.150])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 12:10:34 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Update Xe driver maintainers
Date: Sun,  2 Jun 2024 21:09:59 +0200
Message-ID: <20240602190959.2981-1-thomas.hellstrom@linux.intel.com>
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

v2:
- Cc also Lucas De Marchi (Rodrigo vivi)
- Remove a blank line in commit the commit message (Lucas De Marchi)

Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>
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


