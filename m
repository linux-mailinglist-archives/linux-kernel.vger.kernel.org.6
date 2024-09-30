Return-Path: <linux-kernel+bounces-343971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51398A1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A5E2815D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94B619049A;
	Mon, 30 Sep 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuNtCHDY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9818E36C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698189; cv=none; b=JbhEDtDoqfFjfIi6vejJAQw1wQpEHo87IfV96T2DU5KoUpNIH3aYV7MdmcU5UkKNyZeatILq3QJ0GUjcX5awhahPW/htzSfIA1fUUzj67HXxO1Pmptcy+NOMwnMiyz4cEchE99fz+PiStLgY8OBAGbBDpqhQ9S9shHqAWZa2rbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698189; c=relaxed/simple;
	bh=66Gpn3Z+P9WB7V6XC2MntK3wRYKHyN7IlAHqDWL3r7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=esxR8zDXJKdsLRXp6e+u7sCALbANX/84AeRGf3+eFeNitEzl/fnUd8LAYRQUqtyKPYq9JOaSCDFCHw2OTIQaJXWaKsvSuIz3puzjRQpAsAI9tPMkdMlgOwzA7g2nmOt/kiTM8EpsscBk9CKOnII4rJqfae1kJ6bJD7W5+MFE5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuNtCHDY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727698187; x=1759234187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=66Gpn3Z+P9WB7V6XC2MntK3wRYKHyN7IlAHqDWL3r7s=;
  b=RuNtCHDYxDBXJ/kpbySebQfvr31+pyXPMnITDyFIFqzo7G3hF0gv1YyI
   Y06M8CuqaCGYw0cmzFWdRq6dY6hkpXT+j6lWB3QOM9BLOuToGTOdNtGhy
   OQFAqGaoFusPjaqViF8zUdxIZIeW+7WC/L6teEdUM4MG0N+U5MQsAz6S5
   K/D/7h4B2sQhNqnCHfEzVku/Gt+jlxKzl8o2MCC/kBjfBxcXJsg9muPri
   eCRNMNHJC218cClkc6wsa/YCRt0LB5+p0v+hR2Avm99pIxPypDM2SSAGi
   7ho9R+Xv6BxpAsrTBYGp5x3JZ0eStlBoJNvKlNVcHvbRCjnqewzrMHlBv
   w==;
X-CSE-ConnectionGUID: s0PNS/B6RtGouCZzzs54ww==
X-CSE-MsgGUID: JiCB+o3aRIGmCokTwC5BXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="14407875"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="14407875"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:09:46 -0700
X-CSE-ConnectionGUID: AiJIV5/uTAGI75st/HVEng==
X-CSE-MsgGUID: 3HZ/FjWGQUWdlxmIwUidsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73247159"
Received: from baradhya-z690i-a-ultra-plus.iind.intel.com ([10.145.169.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:09:41 -0700
From: Aradhya Bhatia <aradhya.bhatia@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Intel XE List <intel-xe@lists.freedesktop.org>,
	DRI Devel List <dri-devel@lists.freedesktop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Aradhya Bhatia <aradhya.bhatia@intel.com>
Subject: [PATCH] drm/xe/xe2lpg: Add WA 15016589081
Date: Mon, 30 Sep 2024 17:36:02 +0530
Message-Id: <20240930120602.1720218-1-aradhya.bhatia@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add workaround (wa) 15016589081 which applies to Xe2_v3_LPG_MD.

Xe2_v3_LPG_MD is a Lunar Lake platform with GFX version: 20.04.
This wa is type: permanent, and hence is applicable on all steppings.

Signed-off-by: Aradhya Bhatia <aradhya.bhatia@intel.com>
---
 drivers/gpu/drm/xe/xe_wa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index 22c148b1e996..2f9cde4b7d45 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -710,6 +710,10 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 			     DIS_PARTIAL_AUTOSTRIP |
 			     DIS_AUTOSTRIP))
 	},
+	{ XE_RTP_NAME("15016589081"),
+	  XE_RTP_RULES(GRAPHICS_VERSION(2004), ENGINE_CLASS(RENDER)),
+	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
+	},
 
 	/* Xe2_HPG */
 	{ XE_RTP_NAME("15010599737"),

base-commit: 0c8650b09a365f4a31fca1d1d1e9d99c56071128
-- 
2.34.1


