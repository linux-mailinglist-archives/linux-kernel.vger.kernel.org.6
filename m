Return-Path: <linux-kernel+bounces-373914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8644C9A5ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC3E2833F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D0F1E25EE;
	Mon, 21 Oct 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2ElEZRn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E931E230F;
	Mon, 21 Oct 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500061; cv=none; b=Vf2qonPJs/NzXIYtuNhOxVnUaUwwWX00T1SFKLm1BV5DexXo8LaexBqVxhmIR8hPTMySCTcT++esLgPi41V5vQsSkUgpUzbjEVPFNlG5SH1/vkDvhtKwa/YDki+r5RXvQzkBCSpzXNz43BhU4yhP66768xWBmbeoWmbSdpIMDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500061; c=relaxed/simple;
	bh=IMwA+Y9b49AIBE5Uho/w9chwVPBTVHRrN2kZSqZ6wM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXKrj7Bd4oXakROQD1iXlsG/mzYoJfDFNAKtdrBzkK6pEPkMgZ32giB5JT4wCXYzMHIiphEFvmdLEE/dkOdfe92EWtGmIf0vLz0ZlGD30IjJi6B2dj/nZmCLJHUF5u8V7YHWHvZ+7VrYdEKrU6NjPnbhy/pwVmB8f6kq8JfoeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2ElEZRn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500060; x=1761036060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IMwA+Y9b49AIBE5Uho/w9chwVPBTVHRrN2kZSqZ6wM4=;
  b=l2ElEZRn4FQokPY4OG6F4T5OumpnTXqLRJfJvG9MWDsE05SX5P+hWf8u
   yNOOx88v19NVpaYFbY6PqeHzwyw4ut6l6n4q6WFCON2WWYAsK9gc7FN+l
   yR20kYaR/OXWxdVTkM6DSqC+gB/DORQQFelJEl02GqsdABWOEtpmXTL9N
   wD2nxoo+l92YDx2N7T21kJL/YLkjM9zuu/z+VZEwz1mrJwZIa2ezghIkm
   K9YV/1jAP0KyggBc0Dl1JRgasJLxnYYLPbNXALHYev3HXlZ7Xfvqyzx7F
   thwHmeSkvS+syFstradBP6ALdikWRsHi/nzh7b3+aTszHNGOI+VqFPfuU
   w==;
X-CSE-ConnectionGUID: QULIgLaVQU23nWdhC9Nl5A==
X-CSE-MsgGUID: r8PY12ZKQT6i9RxZiBBoOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="28407174"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="28407174"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:40:59 -0700
X-CSE-ConnectionGUID: 3fy3TltxS2yhYj58ULdRuQ==
X-CSE-MsgGUID: m6x6q73PTyu4MyOKrugn9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="110299459"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 21 Oct 2024 01:40:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E6FA412B; Mon, 21 Oct 2024 11:40:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/3] platform/x86: intel_scu_ipc: Avoid working around IO and cleanups
Date: Mon, 21 Oct 2024 11:38:50 +0300
Message-ID: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch avoids using a workaround for IO (which seems unneeded).
The rest is a batch of cleanups. Has been tested on Intel Merrifield
(thanks, Ferry).

v2:
- dropped stray change (Mika)
- elaborated conditional changes in the commit message (Mika)
- gathered tags (Mika, Ferry)

Andy Shevchenko (3):
  platform/x86: intel_scu_ipc: Replace workaround by 32-bit IO
  platform/x86: intel_scu_ipc: Simplify code with cleanup helpers
  platform/x86: intel_scu_ipc: Save a copy of the entire struct
    intel_scu_ipc_data

 drivers/platform/x86/intel_scu_ipc.c | 141 ++++++++++++---------------
 1 file changed, 60 insertions(+), 81 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


