Return-Path: <linux-kernel+bounces-544868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE2A4E697
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C261C8C199B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE8298CCB;
	Tue,  4 Mar 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLf4Eu1b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F7298CC8;
	Tue,  4 Mar 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104415; cv=none; b=Hp3VvoCeE+hZg0rn1bhbSnT0ap6AJ9fR7EivTMWupPhMnv+ghQvVj9zJcRbSo+npEmbJH3uXWso8M5vubCFZ4t9cYxY2979PR1tANVMxdVkAsbLQu3CfHTpbtLhv46EOlqmxguEINUYHk5soE7WOj9VCg2OvVNjb7lZZLHNjuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104415; c=relaxed/simple;
	bh=GJfr6n8P13lZlLbfLOvwJgFnZdJL9uekh4JYU3YHHk8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Hb+lelSWpokBrR6YttzeU4MNemuRVk7LK2Ecv8xvpLG0oJWhOlpKfO3v7Cgrop8pqvapvZy0b0LZ6Pp1nBSNc5APXFdNLRua8W5OAsuPh2yeS5Wl/etDjqkNR7eqqZ8WBbFJhjIsPw4M69EGKqdClGwD1jNFQk8xf0NdypLitYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLf4Eu1b; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741104414; x=1772640414;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GJfr6n8P13lZlLbfLOvwJgFnZdJL9uekh4JYU3YHHk8=;
  b=WLf4Eu1bcnf4gs36efYxvjx5zVdQ2bh27ZxCvlNDYpoLq8AvQTc//1aX
   4sPYl4BDvXFJS3fT6HAPu4SQu3LV8/TMWt+bjMIJfkXPhzmKr9aOv7v/c
   Kj8BPRiuKkNRT1ewZKDtHth1WmRcjpDLBiCHlhJBTFbCrCmSnBUkCTrYT
   0mNYaXdZoJd7QRrV73TTMNM1hPIRTXDT9UT0nUutJ44bHFRSyqXxyNImc
   9fIj584kTX4nDDHKI4XsBvG9X+DtaQff5U3NobF+/y+sBzNqiPXw1WRzg
   usSOQDHmahK10azggJKjnW0RwE2LDZxQEDLZB+pQrjhGb5ZO1ll7W5MnG
   A==;
X-CSE-ConnectionGUID: ZJySQ3tgSp6VS2B9E6T2Gw==
X-CSE-MsgGUID: 3iNWKu0YQMaLXx/vhWCWtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42223505"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42223505"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:06:54 -0800
X-CSE-ConnectionGUID: mDm+q3hGRlqtWYCzWyzbvA==
X-CSE-MsgGUID: xTARPw/xRS+ZFKmV/h4pZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119319795"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:06:47 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Make symbol static
Date: Tue,  4 Mar 2025 18:06:38 +0200
Message-Id: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sparse reports:

lenovo-yoga-tab2-pro-1380-fastcharger.c:222:29: warning: symbol
'yt2_1380_fc_serdev_driver' was not declared. Should it be static?

Fix that by making the symbol static.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
index a96b215cd2c5..25933cd018d1 100644
--- a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
@@ -219,7 +219,7 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 	return 0;
 }
 
-struct serdev_device_driver yt2_1380_fc_serdev_driver = {
+static struct serdev_device_driver yt2_1380_fc_serdev_driver = {
 	.probe = yt2_1380_fc_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,

base-commit: 432c2adb9e2f84f81c4b218acb07a2cd3dce64a9
-- 
2.39.5


