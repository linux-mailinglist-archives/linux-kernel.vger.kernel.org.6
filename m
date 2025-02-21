Return-Path: <linux-kernel+bounces-525182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44060A3EC18
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B0F3B56E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997241F91E3;
	Fri, 21 Feb 2025 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emus/noH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0F8F6E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740114507; cv=none; b=XC2iRXH8ks6JLa9kZD7aV7FBAlS6qeO21IwDb/jMF2P6q2vsx4G1cRW+MKH+C7JfFZNMGmdD4GGu2yXvPydyB9Rn6UU5IxE2Rldp4WzVRwCf2NSrDDfvaq141lI35AueEkeLvC0WWteajtJm7MkmM/1CsnZ5tBztWvhrFVk5n98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740114507; c=relaxed/simple;
	bh=+NmOMgp3sw/84tlLSWQsgw92FEDnHBV7l1MrBV4clM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SiPiBC8PbvnTZ8iELIA0bsbBgbd0NHogLzAWwMcE3WkhZfCxw4bgOIz+GWSNzS/FodCwYfnrfgOjFJvSE0ExlWh6bpAiOuVlEGLhLBEAZqGeRuDkBp91p4zIG6tEfq8xKNT3va3vKuGudPd4+rrJB3C6BvnctNkxbDmj3nX2f4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emus/noH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740114506; x=1771650506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+NmOMgp3sw/84tlLSWQsgw92FEDnHBV7l1MrBV4clM8=;
  b=emus/noHaN6BrCOETeaarqNNp6teeteKZ/DAFrN+kdIJUeVRIRVdmmTi
   EYlG+GRZiCRezpiYgFXZlqITqbrmZR+X+DadnOKxb7bcQg2wlU/3ikh8e
   bM902ZzH8PgRge36Uu9neLhSs4BnzvwrRI6b/PpWNWbD1dU1yibMN/TnX
   HEg2EurAUNVnKpbYaMhf9RL/AbNdph2lNR3kUMmKcFzlJRXWMwy96qw8W
   UQZF5V1WEaqjfWu4Itd5rut69zvzYvjfhg4ckXzPCzFXCHVV0cbxmj8+X
   xrCes53Ibm5OjcUp84IuuwAWg1Rf/8DlKAwhD10KvfrK8YvXEmRQk4QXl
   w==;
X-CSE-ConnectionGUID: MlonT/MFTcuSzmVU7E7UUQ==
X-CSE-MsgGUID: F0E4iBTCSOmNVbDRoINBVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28518716"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="28518716"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 21:08:24 -0800
X-CSE-ConnectionGUID: qTsMHrWiRTCuCs7zoi3UGQ==
X-CSE-MsgGUID: Gl/KwtSER5eXgTAaj6HP9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="115459297"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa008.fm.intel.com with ESMTP; 20 Feb 2025 21:08:22 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/2] Cleanup io.h
Date: Fri, 21 Feb 2025 10:38:02 +0530
Message-Id: <20250221050804.2764553-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a wider effort to improve build speeds, we're attempting to split/cleanup
core headers.

This series attempts to cleanup io.h with "include what you need" approach.

This depends on earlier modifications available in immutable tag[1]. Feel
free to carry your subsystem patches with it, or let Andy know if you'd
rather let him carry them.

[1] https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com/

v2: Fix drm_draw.c build errors

Raag Jadav (2):
  io.h: drop unused headers
  drm/draw: include bug.h

 drivers/gpu/drm/drm_draw.c | 1 +
 include/linux/io.h         | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)


base-commit: b16e9f8547a328b19af59afc213ce323124d11e9
-- 
2.34.1


