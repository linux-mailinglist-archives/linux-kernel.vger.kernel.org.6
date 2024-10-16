Return-Path: <linux-kernel+bounces-368573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892D49A1183
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0861C223BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C252139CD;
	Wed, 16 Oct 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxUHknkj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA56212630
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103206; cv=none; b=kA/rezqkkGJwAB2aMFxSLcaZyMSq6Dp7rOEzKSKBLEwgkIwV6NpXGLpWc/8zrqD42lVV97YbDhQNmBk1Ubx9g5fyrCAPde/FGMBBvGU+4HPpSlGWQpstRo9+1+6iwfCFpSiR86T1WIJqF/am1a7pr6Ije6ZfOuX0Fh/XHTHd9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103206; c=relaxed/simple;
	bh=4HekPE8cbLenPjWbqTnnBFTPRSsWRW6m0uSnu07h+hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVctHYqw+vu/NWMnZBLX0Htg0VNcDKo8Mg+FXWxD6C2mMTtSPaP+xEwvBaR/xIdnnK3DiCj7U/hTCPdi7OUW/g8w98zTwulY2rWjy2zbj8gUZhgkH9EBK3XI9hBqJycQjE5uxfHVOI4fRypROMV1BLpxPLIa2k7ndB5yBIxS0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxUHknkj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729103205; x=1760639205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4HekPE8cbLenPjWbqTnnBFTPRSsWRW6m0uSnu07h+hA=;
  b=GxUHknkjIr4+KvdTpzTH46XPNShEy8LtzOPCz61gUJgBR33hHcJe1Th6
   7qcrGdipfrEsuAf2ahZrAybyl0mKDc5N//z9qj+nfeHg5N4s3XWnQQxPB
   Cq6eHyevIDoe25LgMF7DpWyiqJi0w5QMTgwg5a2ENLWf8BNrOZjVoNmTY
   Pgwd9O+R7GmUaG6RRGid6R111V6843d0/aSL+9j8/f59MM5/B6mdOUCTe
   HR36OW9zYT3OTXowQ8t0jK/DF0uqg0n5VtcBhCmn//9EGVLu81hhjLgYV
   QxfTDovRGMzW8z8AiSZYwFqKT/2A+MEU+2j4S/GukZphLWxWCVC8FjY3B
   A==;
X-CSE-ConnectionGUID: +HnXDZqnRGyN0NDhlepLNA==
X-CSE-MsgGUID: 2B2vtopBQ5m9VTctCOoBZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39685995"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39685995"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:26:43 -0700
X-CSE-ConnectionGUID: Rvnt9MjySWG6GJbtjONehw==
X-CSE-MsgGUID: VWEnb3zNQ3+WVZFatWM2pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78269521"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2024 11:26:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5E55A165; Wed, 16 Oct 2024 21:26:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/2] percpu: Add a test case and fix for clang
Date: Wed, 16 Oct 2024 21:23:50 +0300
Message-ID: <20241016182635.1156168-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to percpu to check a corner case with the specific
64-bit unsigned value. This test case shows why the first patch is
done in the way it's done.

The before and after has been tested with binary comparison of
the percpu_test module and runnig it on the real Intel system.

v2:
- updated Subject (Dave)
- added test case

Andy Shevchenko (2):
  x86/percpu: Fix clang warning when dealing with unsigned types
  percpu: Add a test case for the specific 64-bit value addition

 arch/x86/include/asm/percpu.h |  7 ++++---
 lib/percpu_test.c             | 11 ++++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


