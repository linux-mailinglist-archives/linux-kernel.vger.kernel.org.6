Return-Path: <linux-kernel+bounces-305294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E79962C85
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB391F215B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837981A256A;
	Wed, 28 Aug 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItYPXalJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B713C3D5;
	Wed, 28 Aug 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859430; cv=none; b=aQDwn1GEduEQ9UXkhQ/N/3deQUBMad6H+omo1TMtCes9/f6sW9JfMNtpP0aK54T8mj7WIyEDwYLQhG1J5UR23xUxSvPNq7MzArXjdBC9Ekx76sC/76JwjrQbRy0CzFEUO95qlyOK/FpkJJ8hMjSRbCYGOTq3owIryvqqNew/bHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859430; c=relaxed/simple;
	bh=6VjJoVRrnZ0Dry7YUkRoqiFw1H+R+FwGBq6yfjQsst0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqAnBUrPxbllkdvi5kMu+SJYTJkFu+62s+kW6c6xMO3gAoYm8nlQaDRJ7wmpgJDiaIKkeY2Ti7EqRrBz+CFEbGi8tyJspvWxrRYT/zCfTb6NZ7D/CsoUXeOaKq7GoWv7wY7LjDuOKWLHGyQsIHxnFHXTHOzKn/4tJ+x6BRS6ecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItYPXalJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724859429; x=1756395429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6VjJoVRrnZ0Dry7YUkRoqiFw1H+R+FwGBq6yfjQsst0=;
  b=ItYPXalJdOtXvH/Jnj1aVHhIdhZ7zWZUtpJrK+xHjvMFfw1p0qx3eDdi
   1AgSGZSSj+samEmWzKWDFbSw5HeVZc50d1a8Xs8S202qoQ7AYYnonnvvf
   VbwHzmoq7J9WejzR/hwPqPUUDlnkw9UqGisZYv5FEBqmCyTQ0BqiDdXTQ
   Tk6c8uuNy4D7/G2Lvxb4U1Y5+yb0JbVrlGGJiHlPVqFwliKf4fOOXALCk
   8kLRGCW6Lhg1bB6ZFR100EvjzhN3t6L7OXZpfX+OuzVOMDiOpdfKaW1Lr
   HdrVnloWzAbqu4KGFWazMqMscbnCZCcAUJzpvArlLSDstpF9GiANepQgM
   g==;
X-CSE-ConnectionGUID: Ff5rgHmSTFOEveyEtxzvlQ==
X-CSE-MsgGUID: MKyS37ZuSEKKcH1hYeC/1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34809258"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34809258"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:37:08 -0700
X-CSE-ConnectionGUID: P2qE5eerSga68GAq16FxTA==
X-CSE-MsgGUID: epWNTEFAQ2ubrT2puDLr0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="94064326"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:37:06 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Intel uncore driver ELC support
Date: Wed, 28 Aug 2024 18:34:52 +0300
Message-ID: <20240828153657.1296410-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Updated based on comments received for v1. No functional changes.
  * Updated documentation (patch #1)
  * Converted one long sequence of if (...)'s to a switch () (patch #2)

-Tero


