Return-Path: <linux-kernel+bounces-175057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF338C19B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF07282961
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6312D767;
	Thu,  9 May 2024 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R847N45L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C0129A6F;
	Thu,  9 May 2024 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295767; cv=none; b=h7ibZJGaGDGbiCUzDvsf8AoU6MFDl4SrOgYFta4YSk8xNh5lAiG4Je+1EiApaxKDA6/GddnoAIfJWMfgIflulIYdSJI2KmXx+UoBCW9ciBftCiaB8jS8RfSIcRz4je0yQH7id4MsS85za5b1lExj/hYEBI2A6HCjJvjZqP7NqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295767; c=relaxed/simple;
	bh=lb0yokkpk3r1q4T49lqoi5Or6buMCIS/NNB6rF/BxRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NsZAsFMNVPBdScMm4s92U0+fX07hQUuIL5IuR9SkqQceKIGE/0Ab9hWDIznlb20xErq9ncywqfKAskTxqjDWi9sF5GgRuwzAipR4FwUwvhKpINMVvzuA8WdLPnvWvEBgcRL6pzZ1OqUEuyT9EWKdtmDQ2axgqqRvncUbEin+bC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R847N45L; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715295766; x=1746831766;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lb0yokkpk3r1q4T49lqoi5Or6buMCIS/NNB6rF/BxRk=;
  b=R847N45LUL+vReGJB+eR801bmHOEp60hXOXL6Fvihmlk9LMIVzZij+eq
   J69A09HkX7eXh3Dszf1q6woQYRYDmCaMoOnpkB/fJ4L8qVFDakuAksvaX
   Hxs092qssTtN3n6L17TqzyVCmo9RFV7CGV/T6982Y2waCPZM2eHKilMIz
   qPosU7R1+1cFeH/gOYjsIB2GJzz862Pf1F/YhPHF1VIW4ZQadRl/jn14d
   K27OTwk4Szc6JQoPPKh0zlawWDiW/Bu2ligkv1D+6HbFO/iCCN7BGfMHl
   QvyXlY4idzF9eUA6SWwb4ObtLH6/ZAFC2rkidcVmww615K82iMft41F8W
   A==;
X-CSE-ConnectionGUID: QP1wceEfSIC8GZ6B5C8pxw==
X-CSE-MsgGUID: f5uonzHkRRyxFrOt5frh5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11100505"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11100505"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 16:02:46 -0700
X-CSE-ConnectionGUID: ONTc4JsBQ7OQHsMU0XJNKA==
X-CSE-MsgGUID: C23gTMHORIO3G9/q+/F+tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29790212"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa006.jf.intel.com with ESMTP; 09 May 2024 16:02:45 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] SST improvements with TPMI
Date: Thu,  9 May 2024 16:02:34 -0700
Message-ID: <20240509230236.1494326-1-srinivas.pandruvada@linux.intel.com>
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

Since it is close to merge Window, please feel free to defer.

Srinivas Pandruvada (2):
  platform/x86: ISST: Add model specific loading for common module
  platform/x86: ISST: Use only TPMI interface when present

 .../intel/speed_select_if/isst_if_common.c    | 83 +++++++++++++------
 1 file changed, 59 insertions(+), 24 deletions(-)

-- 
2.44.0


