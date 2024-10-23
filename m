Return-Path: <linux-kernel+bounces-379005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AB19AD88A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5502F1C21A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B21FF021;
	Wed, 23 Oct 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDrL3XQF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5881FEFA4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726762; cv=none; b=E+jUqhMLVaLoyDPmo5Q6xuHPng7dEoqtbKqiy2XfYmbjvKV58Oz+FIpGwAcwBMLiSBtquxo2PfpapwZP81FfftrL13F/VVqSr7DXYPx/AXHkWXaoIGTJDse9u0sUijVXf+KOCeb2H3PCbX7aq6kQWYeoDoP1gPOJ6trFYy8p9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726762; c=relaxed/simple;
	bh=YuZi8Imxyta+JSn6SVxhtiRt7udLfmutbgCLnSuvSyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wk6Hvhis4BdpT1x/zDvk0uJrnkpfvOY5r8oIQIMb2wz2JTWeHlPyrS0nsI8szH4UHrzL3ja1HdUYXT4cIQqiYDX2d5AUcb97oTuqO9o5mrFtdPJCaa+qD1baMIZyLv1KHsk9poX1RNOuprP1dk3XJkIIFCOiGtMx23uWvXlKklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDrL3XQF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729726760; x=1761262760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YuZi8Imxyta+JSn6SVxhtiRt7udLfmutbgCLnSuvSyU=;
  b=BDrL3XQFzeTYHcDTn+zvEahPxIDPeGLw2M2DlemaXYYk73ob5vmV3fsy
   M8vNOc7dzXtPTJti3U/ssUllQKFvn+ApPB2Kfk2tX0stDSb1P7eNTdAVu
   tUhOJ5hPFhtSC2FCppH0tVCOdDu0nl/r0fi0YlHFoq61hSXd0d82z1LoM
   Jf2Onep8TuDw84i4EvwuBiW+OP75IpjnkzRgBmXYypn0iocuWPo185gl1
   uYQSytd6igtsRiZJVyZf861xu7AeLWhgtVIJlq/77K/SdcowjYDBnPjuy
   Wx4CncundXAjxh2FMZ0X3f1badGn6+M8VOBRKaRJ1ViOcYWl/ZkIPVUma
   A==;
X-CSE-ConnectionGUID: wx3jQBxmQ8W3kg4o7UREGQ==
X-CSE-MsgGUID: 9EiG25gjRaayD7Dvzo2uXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33251090"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="33251090"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 16:39:19 -0700
X-CSE-ConnectionGUID: dscCV+K0QqSBJQqAGimn7A==
X-CSE-MsgGUID: 0AXj2NDLQhKXIGnHF35phA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80420922"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 16:39:18 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	simona.vetter@ffwll.ch,
	akpm@linux-foundation.org,
	felix.kuehling@amd.com,
	apopple@nvidia.com
Subject: [PATCH v3 0/1] mm/migrate: Add migrate_device_pfns
Date: Wed, 23 Oct 2024 16:39:43 -0700
Message-Id: <20241023233944.1798835-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Part of series [1]. Sending as individual patch ahead of that series as
this is a prerequisite for merging.

Matt

[1] https://patchwork.freedesktop.org/series/137870/

Matthew Brost (1):
  mm/migrate: Add migrate_device_pfns

 include/linux/migrate.h |  1 +
 mm/migrate_device.c     | 52 +++++++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.34.1


