Return-Path: <linux-kernel+bounces-339369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958499863FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406771F287EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0C134BD;
	Wed, 25 Sep 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeRFYwL1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C901798C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279043; cv=none; b=RbSeCbDayQARaW6hE4kptth3agYuKwdGL4frXDfK+TKnZh3v9Jl7Pj2Tp3gyytczxJdkHluZYdvGJ9w3mWyGNcEWfOjPH0oYuRJoiFGJARd/RImEcHd2TaYQ2zI1URch6Xvi0sf+xJ7bv42eM51XlQSp2lv/GHKguq2hcR0Keg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279043; c=relaxed/simple;
	bh=BqLe255JOiu6hmojb0qHSWYfLxKQ6rAZ2Pn6Lu8lXt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJDcE0mgBpKIprCBQ8zSSOcYf+YAEDYi7oFbg4hljOidubOUOyoVH8GNhyQxMlvWYl3V4Q+y8OaMK/NsgPZBAa/+gFqq+5TcMtGDuhKc8vsO+eoS2loqbs+J4HmbxoO+F4kF+i8UvA0it0HQov43jh+APAe+xOprE/6NdeYs+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeRFYwL1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727279041; x=1758815041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BqLe255JOiu6hmojb0qHSWYfLxKQ6rAZ2Pn6Lu8lXt8=;
  b=DeRFYwL1YwBt5F3Fiq0SrFm4IlTku4qrlJY8wrgjC+MJtBizC4460EwE
   C0WhI1mqxpSg4vmqHQmJSUCWGMAEYa3QNwrSnBYy9gOe/PNVH1JZwv3PL
   SeQgGhVlZjwojGTXZ8ZO4eFDXyvtf2odgAhXlP4D5793zxFFyq/zBkUEH
   Y9nOdl8rqZ8F7qd9xW9KCi4ZANw24CneMzs/OBcKWLT52BhE+2A4+ZEPp
   KlVn7XIPsGAf+rL6XxNiQI6BLPv+NzoplEWK0qed3J0u/wjYwsx0GLq1r
   8VbVQxQf3E+pMXTpLhV+o8ASSgmBcpH7KbjZmMDWlHo3s+juGJyrKlgWO
   w==;
X-CSE-ConnectionGUID: 2J/f6u86RoW3J4aLpOhDsQ==
X-CSE-MsgGUID: tjT8NGFrQ5e+DwRZKVd8bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="51752539"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="51752539"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 08:44:01 -0700
X-CSE-ConnectionGUID: NAr6OiDaQgOrYu3V0VOw3Q==
X-CSE-MsgGUID: 0t30GgDcQMWPGMrt/wZgPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71411834"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2024 08:43:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 33863192; Wed, 25 Sep 2024 18:43:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] resource: A couple of cleanups
Date: Wed, 25 Sep 2024 18:43:33 +0300
Message-ID: <20240925154355.1170859-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of ad-hoc cleanups since there was a recent development of
the code in question. No functional changes intended.

Andy Shevchenko (2):
  resource: Replace open coded resource_intersection()
  resource: Introduce is_type_match() helper and use it

 kernel/resource.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


