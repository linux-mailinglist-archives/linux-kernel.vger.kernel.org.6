Return-Path: <linux-kernel+bounces-417058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F579D4E66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3C42824ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610FD1D7E5C;
	Thu, 21 Nov 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fksCXW1x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C71D0B8B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198462; cv=none; b=UxI/vasisRUmSbtYjX9J0WWhTjKGIu2W1l2lOQyYZ9DJaEujLFD4sTdQDuMfB4e5GleggTLIWaho1MT5kWNNdKNoqn1/1B6oaN14XH/5o62azmehQbNSPi3uRHAeolmCm4ocOmmtxwc9qUIzqudmFTlJ1226HiiSKdE2n7gZ6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198462; c=relaxed/simple;
	bh=h9R00gX+uUFixhB2o0vnFzvWl2L9ZuugrWhKGhOGrh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7S73QdUiGU02jC19YBCKMXtQo/qnyZ+oqRowRVlGerIERkjPmsFXk85NTJ97uWBh43OGZa+Hh4FRx0m3BBtS1JVQ6WvXe3WImQVB8M9TD/fUULVjjCP248Omws0sQkDy+n6e8mONAt0o1EVl1MR27XTerRcwo256jaq5Xyc0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fksCXW1x; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732198461; x=1763734461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h9R00gX+uUFixhB2o0vnFzvWl2L9ZuugrWhKGhOGrh8=;
  b=fksCXW1xndU2VGM7YASwiDpkN0zwzWqcK2C1rMW52RR4tl+t7ps1wV0e
   rdLDJWr0qkoGgc56IgegScEutpXEaEtchjdC39y64qfz1AUOtPmMEH509
   BPFLUuXkdUZnuWyoZRNqFU/KqT/xoChXEc5F5cIVxGq/Dv+DZcXhE4Se1
   hRemiudNI6DbYKsS0AHE6XjTq9vQN/T4I4caM4UmMDD0kwlvA8QxTVwUs
   E6M5xlEOfCY9ljlD+P1mo/qkF551IZEVQxGzpNgC4EzQwDv7GrzGbedtN
   c+qbhPLSIr8B19z9SjeFWIPpRSX+t6vE08ZDSf+j52oPgJnERW9KofboH
   g==;
X-CSE-ConnectionGUID: c4iTrqkEQ6G/u9kWfif2Mg==
X-CSE-MsgGUID: JWU4isI6RqmQumNi7F+Rvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43707171"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43707171"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 06:14:20 -0800
X-CSE-ConnectionGUID: ThFwL1k/Qg+gBsWkB6sdQA==
X-CSE-MsgGUID: LKK6tNodS0KGm7gk5wEEaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="89867595"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 21 Nov 2024 06:14:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4B2A918E; Thu, 21 Nov 2024 16:14:18 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2 0/2] kcsan: debugs: Refactor allocation code
Date: Thu, 21 Nov 2024 16:12:50 +0200
Message-ID: <20241121141412.107370-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor allocation code to be more robust against overflows
and shorted in terms of LoCs.

In v2:
- collected tags (Marco)
- added patch 2

Andy Shevchenko (2):
  kcsan: debugfs: Use krealloc_array() to replace krealloc()
  kcsan: debugfs: Use krealloc_array() for initial allocation as well

 kernel/kcsan/debugfs.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


