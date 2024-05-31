Return-Path: <linux-kernel+bounces-196479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B18D5CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376561C217EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F11514CB;
	Fri, 31 May 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQpjNEmD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A01150985;
	Fri, 31 May 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144561; cv=none; b=qVbxEJCJZjI+s85BZKafPGK65Ftj5EygYkoVNiHENk8QY+VdBIfrVoee67TfL/3UuLkDUhrKYiARezWmyd/3vZufcP2GEI60JFgIlZJbqzl02FDuWXBwEwvVwW/3J4XMv5eodR2EpGfSZ4gCM8LbBzAQwhb0ZX1cF5R42gi9PvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144561; c=relaxed/simple;
	bh=4f8/T+biOZhh1eNGdgFkpAq9HSRPbQqUjuLodB00B+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWKRR0MAkmm11c7XngtfP3XMzqC5KX8fz1Z7uND2OtddJb78ItmYepFJKKyu6xBlkDrOSiuNYhO9+FqbIQ+weuLAoY6HcEG/+qXbm2sAswNjwoBydeCe9np8ZziimMbu3IfYrEfopfO0c7DK0kJGrqvxLzhTxgNhq7wIV3rCwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQpjNEmD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717144560; x=1748680560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4f8/T+biOZhh1eNGdgFkpAq9HSRPbQqUjuLodB00B+I=;
  b=nQpjNEmDG87CVgfcsTMskgUAMjbTqfbv3hEraRcoXqyc8xGT7rneuHl9
   w2xzDJIZYHDT+E8y8eiDLfY3lxe4BsErZc9a7X+sSOGhpqLZAS6acHWMy
   RiA5HtHacrcCLJC/JVZNYG7Ucvz3YIm0m7DYqyIgZTedmNHrfWWSvMB/y
   RkFpZlFofnHFPPR7PiINwKcp95SwbZY4/qyCB8iNW68ZKC1UXlYMER5JJ
   R3Pkcx0VKv9NEv+k1sawz5/MXWUl2u+Tp5z1Sm0KF2ab87HJzVQLt/Mhi
   eH1TP46z//GmumEsxC+pmciRsoZ9ddOV6eBf/XpMOtxg+gtx6WlL3LSWr
   A==;
X-CSE-ConnectionGUID: yGNucmEpSuyZCSopnQ8/Nw==
X-CSE-MsgGUID: QsdKfx7KRrOh53SbQIfyfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13495948"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13495948"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:35:59 -0700
X-CSE-ConnectionGUID: klKcBi3ISgyCaB+DgUYBjg==
X-CSE-MsgGUID: WGphaNj3RqGCjtMk72RelA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36193445"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa009.fm.intel.com with ESMTP; 31 May 2024 01:35:59 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	rui.zhang@intel.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/3]  SST improvements with TPMI
Date: Fri, 31 May 2024 01:35:45 -0700
Message-ID: <20240531083554.1313110-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are some improvements to SST with TPMI, which makes sure that SST
is not available when all model specific parts are not ready and prevent
legacy SST driver to load on some platforms.

V2
Split V1 patch 1/2 to two patches
Use new family model check macros

Srinivas Pandruvada (3):
  platform/x86: ISST: Add model specific loading for common module
  platform/x86: ISST: Avoid some SkyLake server models
  platform/x86: ISST: Use only TPMI interface when present

 .../intel/speed_select_if/isst_if_common.c    | 75 ++++++++++++-------
 .../intel/speed_select_if/isst_if_common.h    |  3 +
 .../intel/speed_select_if/isst_if_mbox_msr.c  |  2 -
 3 files changed, 52 insertions(+), 28 deletions(-)

-- 
2.40.1


