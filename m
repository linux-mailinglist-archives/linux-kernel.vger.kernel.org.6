Return-Path: <linux-kernel+bounces-439677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709C9EB27D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C314287ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C51AD3E2;
	Tue, 10 Dec 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6qQGlYV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602FD1AAA38;
	Tue, 10 Dec 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839286; cv=none; b=NjH6TEP6HyvVMdhnwObmPa3EwP8eOb4DBrbPobFBwm/NCZwYpaOwbLRwKcLQpXsUjZPJ3wojEoDY92isUf9Miu2o8munOAFo+mQevNulCOVpCGA0ZCiU38ngCt9XFbjnsE3ofsXcWqik6FlmVM8WK/rSUZ/KB21jgYWySFthsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839286; c=relaxed/simple;
	bh=TZxS8YWdSRE3cGTNULKvGvPDe3HOEC4ZQaSSlCmOFpQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=saVyWJGek3p/+i03i+7v42y2Yd0J4kj7At17P6mSb1BccrHhCbP8KnHp1N2Xi0AwU8qNl9VMNu8t1QMwBexl+i+zTHFIips2EzMKp1jAdYwCXtE3P2oR3wZC8RarfsoPUh+UPiw7eAq6sKEG8JnBmprCVGsGVVudnhAKB+mJ7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6qQGlYV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733839285; x=1765375285;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TZxS8YWdSRE3cGTNULKvGvPDe3HOEC4ZQaSSlCmOFpQ=;
  b=I6qQGlYVdAMFBbYi0A12ZMifCoycLHGj8vpDYLDDrH1P3orlFSLrYgpa
   bqDaYXj/l4APrqH2Le5ksVs5NtclEQRPLkeYTzIyQDuRrNAkJxfll6hH5
   wk7rNf2hpIDeO2DxDm/s94E2nKCT3saSc7AiAkfyYDMX8tJTT+7Guw16B
   E5ulUAQEOjkqrs8BwChMIUxkzInXGiI0uUI8S8WzivmpOy/0HbpDDWAx9
   m7wq8jOBXK+VGGL9K4raPO6LMsbvulZNZAB6vakzbqxW1EKuTpSnTHRko
   K2mjW7u3EJB7rVc0Kg86PANuhQixTodYYgVj1ZmwKFwa8CXwgsfD0t8Ai
   g==;
X-CSE-ConnectionGUID: k3TNt31FRSCZiawdFw7gRA==
X-CSE-MsgGUID: 8dXPHOKbTX6uOrxjYERunw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34065437"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="34065437"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:01:24 -0800
X-CSE-ConnectionGUID: AJlk2zdpT+G3bqVzafjRzw==
X-CSE-MsgGUID: NYXk3uM7TUyoNdPAvUbuKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="126228889"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:01:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] platform/x86/intel/tpmi/plr: Make char[] longer to silence warning
Date: Tue, 10 Dec 2024 16:01:14 +0200
Message-Id: <20241210140115.1375-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

W=1 build triggers this warning:

drivers/platform/x86/intel/plr_tpmi.c:315:55: error: ‘snprintf’ output
may be truncated before the last format character
[-Werror=format-truncation=]
  315 |                 snprintf(name, sizeof(name), "domain%d", i);
      |                                                       ^
drivers/platform/x86/intel/plr_tpmi.c:315:17: note: ‘snprintf’ output
between 8 and 17 bytes into a destination of size 16
  315 |                 snprintf(name, sizeof(name), "domain%d", i);

Inspecting the code tells that maximum i in intel_plr_probe() will fit
into u8 because it comes from:

struct intel_tpmi_pfs_entry {
	...
        u64 num_entries:8;

...but compiler does not know that. Saving one byte in name[] at the
expense of a warning with W=1 seems a bad trade so simply make it
name[17].

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/plr_tpmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
index 69ace6a629bc..f57c61842622 100644
--- a/drivers/platform/x86/intel/plr_tpmi.c
+++ b/drivers/platform/x86/intel/plr_tpmi.c
@@ -262,7 +262,7 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 	struct resource *res;
 	struct tpmi_plr *plr;
 	void __iomem *base;
-	char name[16];
+	char name[17];
 	int err;
 
 	plat_info = tpmi_get_platform_data(auxdev);
-- 
2.39.5


