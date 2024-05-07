Return-Path: <linux-kernel+bounces-172121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B658BEDCD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E97C1F25916
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4C14B96E;
	Tue,  7 May 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwGZnkpf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473314B962
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112163; cv=none; b=lLy811pG3LWEkf7y+YMH9/0axY3DlL1WHO6jtxqmFF1CkGjGBkxz9//xaIziJdZPPNP6bKZB5r8+doCfn6oBTH4km1bopo5cIc7UIF+KpR/HZJlxPz65FaQY7ek+XAa+9J0y/G+o4WmV+7T/8+P9DaHTm10WJqUOoWKSwJIAb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112163; c=relaxed/simple;
	bh=iqU2yt+YftKdbR2lVoCPnIPr3BqQEJhtDc0zH9IzPSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+++YRgvWz6Ju9woQXiSPlifERrN9RbBV3VHrPGin3Y4MxhcbtlEpxGIyglcAdUJWheM/D5ZPgv6Pkx8y+G1PxVMUXAAW8teoW/R9ZWpqvtPe1uoLJwfdtL8AEo3jaSw6WSC5RdIrHXuzm3i+PmpIxJTik39igtM4Qf/01dNOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwGZnkpf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715112162; x=1746648162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iqU2yt+YftKdbR2lVoCPnIPr3BqQEJhtDc0zH9IzPSo=;
  b=WwGZnkpfj0QLHANHfF0ge1HSfVyLY+MrPJXqBm0LGltF8AFVOyxpdKdG
   VZ+XADO/1+x8ayBXkhMCqblo83xVLRn7YuNefW0MKQ9LDrRt/HEtiet4j
   zGelej8iAL4YcGDseMPALC2ZBIcquZY0OfeHsyesL5rKiiJglF6yL6CZm
   /UY1t/AWsFkyYfLUE2NufvaqJTA09txE0uxD4TlgKb85ZDKLIrkEYREI5
   WbIF5INe9WjlcDoZVh19WjM80JikOIt9V58yH+yK8UV4bsDj6fHFbSPlt
   BdNQ28mCKLR/452ZobeuMufXGnoAiXL6KfTzbBeatLeGfkRDEYH6gPdkL
   Q==;
X-CSE-ConnectionGUID: NEojcdeNSZOfD+J/j5NYqA==
X-CSE-MsgGUID: sUQo6EFkQYe66QY0zby1sA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10804797"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10804797"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:02:41 -0700
X-CSE-ConnectionGUID: lV9xq1aaQiOW3ZZusx/odg==
X-CSE-MsgGUID: mSqkrw40QjqXBFpjnHd5YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29194238"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 07 May 2024 13:02:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 69F2A12A; Tue, 07 May 2024 23:02:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/2] bitops: Reshuffle bitops.h and wordpart,h
Date: Tue,  7 May 2024 23:01:30 +0300
Message-ID: <20240507200236.527688-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move word part related macros to the respective header.
While at it, fix the inclusion mess in lib/usercopy.h.

Andy Shevchenko (2):
  bitops: Move aligned_byte_mask() to wordpart.h
  usercopy: Don't use "proxy" headers

 include/linux/bitops.h   | 7 -------
 include/linux/wordpart.h | 7 +++++++
 lib/usercopy.c           | 9 +++++++--
 3 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


