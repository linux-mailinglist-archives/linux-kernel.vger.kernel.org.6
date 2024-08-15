Return-Path: <linux-kernel+bounces-287883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 619EF952DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936101C23FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D8917A59A;
	Thu, 15 Aug 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsosl3dB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0841714C8;
	Thu, 15 Aug 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721890; cv=none; b=Jh56ZPrMuG5ChXO8qZGy7RMJ3RnXzcwlwfbOnAS80i0nHEHoaYSYXIkkWzR98KX4X1pGERs3GwkYNuU7FMDsKX3oQiye3tt7HhzpJkuXCi9v89cGfntChS14p+hevmxiF/lf0NDXw3ce9ZyqL9DqKeVC1yuZpnaB+I2muV/iYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721890; c=relaxed/simple;
	bh=8mk41Rdglb4vBzSs0LEjyM84/6fiSyUcAXgcxKJafsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGIeyOrEtsPd2EYR6nJMMUaXfKnXeKUtulswI2QZwOVgNVzMv9v9hx9TxooDfFvfB5/aXioT8Zs7JpykOLaTOi7wx7UZ9Pd+4CGRNyehocRHlDacRvZJpvtlCJS4IJ30SR6/Iz86HODLbwiS6blYwXIVaoiQ30U13y8nwdzoElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsosl3dB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723721889; x=1755257889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8mk41Rdglb4vBzSs0LEjyM84/6fiSyUcAXgcxKJafsw=;
  b=nsosl3dButa3AwuuYP6ywCDFJ/egxVDeir+X8JTeIOBOtM/Yjx/Gn7Lh
   AkYNQFM8bH18gHS0xg2qorAFeOQzSKNxF/c3YKbZHaF0bKIhSWTZL651W
   kUBpCmPfRbJ41z3FMQcskhwqb63qBDXC4jEHry/ffjf6UDQ9OX07ovPhP
   sXulYSSYK56YKBDFF6ee8hTakgzK830hMMuE+oy74WvDvZA+b/G9poLX9
   oU7yDDwiFj8Gh8YCUtxbBY3WnsfQIak+/4PC5N8gmNdU2VXPU1A9b9Lwt
   MrKowuuUcy4jGkexeR07SB4ty3z6n5bQE15rEinkIERYp7xf858IuRJav
   g==;
X-CSE-ConnectionGUID: VZhDz2A4QDGIwWyEKdleCw==
X-CSE-MsgGUID: z74Bf1P6SY6gg0prAR72kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21791353"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="21791353"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 04:35:07 -0700
X-CSE-ConnectionGUID: 4Z5GqCy2RXikyRniRHrRSw==
X-CSE-MsgGUID: yBk4X4btQWyW4uDTymIf3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59354401"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.160])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 04:35:06 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: jani.nikula@intel.com,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] Documentation: admin-guide: direct people to bug trackers, if specified
Date: Thu, 15 Aug 2024 14:34:50 +0300
Message-Id: <20240815113450.3397499-2-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815113450.3397499-1-jani.nikula@intel.com>
References: <20240815113450.3397499-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Update bug reporting info in bug-hunting.rst to direct people to
driver/subsystem bug trackers, if explicitly specified with the
MAINTAINERS "B:" entry. Use the new get_maintainer.pl --bug option to
print the info.

Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 Documentation/admin-guide/bug-hunting.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/bug-hunting.rst b/Documentation/admin-guide/bug-hunting.rst
index 95299b08c405..1d0f8ceb3075 100644
--- a/Documentation/admin-guide/bug-hunting.rst
+++ b/Documentation/admin-guide/bug-hunting.rst
@@ -244,14 +244,14 @@ Reporting the bug
 Once you find where the bug happened, by inspecting its location,
 you could either try to fix it yourself or report it upstream.
 
-In order to report it upstream, you should identify the mailing list
-used for the development of the affected code. This can be done by using
-the ``get_maintainer.pl`` script.
+In order to report it upstream, you should identify the bug tracker, if any, or
+mailing list used for the development of the affected code. This can be done by
+using the ``get_maintainer.pl`` script.
 
 For example, if you find a bug at the gspca's sonixj.c file, you can get
 its maintainers with::
 
-	$ ./scripts/get_maintainer.pl -f drivers/media/usb/gspca/sonixj.c
+	$ ./scripts/get_maintainer.pl --bug -f drivers/media/usb/gspca/sonixj.c
 	Hans Verkuil <hverkuil@xs4all.nl> (odd fixer:GSPCA USB WEBCAM DRIVER,commit_signer:1/1=100%)
 	Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT INFRASTRUCTURE (V4L/DVB),commit_signer:1/1=100%)
 	Tejun Heo <tj@kernel.org> (commit_signer:1/1=100%)
@@ -267,11 +267,12 @@ Please notice that it will point to:
 - The driver maintainer (Hans Verkuil);
 - The subsystem maintainer (Mauro Carvalho Chehab);
 - The driver and/or subsystem mailing list (linux-media@vger.kernel.org);
-- the Linux Kernel mailing list (linux-kernel@vger.kernel.org).
+- The Linux Kernel mailing list (linux-kernel@vger.kernel.org);
+- The bug reporting URIs for the driver/subsystem (none in the above example).
 
-Usually, the fastest way to have your bug fixed is to report it to mailing
-list used for the development of the code (linux-media ML) copying the
-driver maintainer (Hans).
+If the listing contains bug reporting URIs at the end, please prefer them over
+email. Otherwise, please report bugs to the mailing list used for the
+development of the code (linux-media ML) copying the driver maintainer (Hans).
 
 If you are totally stumped as to whom to send the report, and
 ``get_maintainer.pl`` didn't provide you anything useful, send it to
-- 
2.39.2


