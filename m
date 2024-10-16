Return-Path: <linux-kernel+bounces-368074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B759A0AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4699B24A49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A57207A33;
	Wed, 16 Oct 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJAqrnzK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E421B0F38
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083642; cv=none; b=Qf8ZjvtlXWcl4GxkJo9HBybYr3EafgpKP8/jz3p7uuLirrthWUtPMYzEYoRyvvmp4Wv2lxirjo1GQZUkB9xGqUWlLcoTQsWEQJVRz8dWfoFKZAgLBQNxEEqz5A+49LCvG5BhUbMYlq8Uzvw+9LwYRNV05W29TsswjlJ60vRcRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083642; c=relaxed/simple;
	bh=j9A7iwVyOfRyusYOYuJqFvkGtA0n/BFyyeDhs/pqDdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JwIOTeK8FXp42U7CfjHepKmlKOXI9UvSI0FOobZYyEY4C6VhxufVwc45JAhkDxK0jwA94uKt0MeVTp3iUEDygp7KRKLoOTQHPmjQCihCLWKBela2A6tw+3odQqq5y9m/p48+Fd4wspbUJJfNLmf3UtaGvE7aEHupVqYet4elhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJAqrnzK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083641; x=1760619641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j9A7iwVyOfRyusYOYuJqFvkGtA0n/BFyyeDhs/pqDdA=;
  b=UJAqrnzK/oGkJpZVZbeayEdczIxG4KeITHjRnwd+aHqHNn35SBlbSKOe
   xHwDNPZO0SZUx8rMauDzjcE2LxxG+lAQtQNT25Ky6Zgz8EFbnrN00ifKw
   i+bilX32lFKwFD9QpzFoF7LW/ebgb9Ldg4Go1a1ZfQoXGQ2RNhdiQFmt3
   n0q9oapZ6ijOCT2tO/o50HJ49lwpw9Gvkxw9KByovD9eoqfs777kdIcIo
   kiIKF2KmLnJHawzSx3gX5b+Shp7kPH/Mqt9sB1Y/LLWdMm/l6H5X8byoL
   rwqjoMiRYcr2luj47ezpG8BqD1eR8xYHC5amTTLejAPuke4o2RRjuxqmI
   g==;
X-CSE-ConnectionGUID: KKeWvA2xRJe7fWeKukLsyQ==
X-CSE-MsgGUID: 9BmjHTkURBSVxMfKXFjWig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51065142"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51065142"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:00:41 -0700
X-CSE-ConnectionGUID: 5pw8LOyFSVOI3P9cA6+IIw==
X-CSE-MsgGUID: 2imdZRkOSriZkc70Xs7pew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82181202"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 16 Oct 2024 06:00:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5AA45165; Wed, 16 Oct 2024 16:00:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/1] mfd: ipaq-micro: Add missing break for the default case
Date: Wed, 16 Oct 2024 16:00:23 +0300
Message-ID: <20241016130023.872277-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even default case should have a break statement to make code robust
against changes (e.g., adding a case after the default one).

Add missing break for the default case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/ipaq-micro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index c964ea6539aa..2370b44e2214 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -130,6 +130,7 @@ static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
 	default:
 		dev_err(micro->dev,
 			"unknown msg %d [%d] %*ph\n", id, len, len, data);
+		break;
 	}
 	spin_unlock(&micro->lock);
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


