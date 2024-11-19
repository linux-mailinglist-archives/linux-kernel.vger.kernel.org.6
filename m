Return-Path: <linux-kernel+bounces-414146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6694E9D23B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152F91F227DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726B1C32FD;
	Tue, 19 Nov 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9YgQZIC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2B1C1AB3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013035; cv=none; b=bkOqZhP8DrRoGaFi+RFxjQpPr5H6ecKC2Lg4hji4gMSub0whvkIRth9PKMmzigMjovh6CydsHcD0hGvAtzVTPrRWwgQuqh5tTkxBVKt9hTUkQBa2k0f26G4ECTIMEv4pNDdD5p+W5DRRQamGqJL4sVbNewqOfep/+wtZbwwgsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013035; c=relaxed/simple;
	bh=l2Qs9qtZaY8zBuJyu+2rd1IGPTQdfYws56k6k1nNtPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9aQjGqj3ZkJCy+1ZtzvLbeTPA0MBt+cllLGHvkMgKGq7uue1vcSk1yceIqwTlbOZfzkyEgmlqoQilKqXflglInMARBIIo/BigWEHD8PCuij2ku6pslaUVUeknzn54vPOYThK8/sygmCb5o3bAci6ijxcyQbEWvywRjqLyyiJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9YgQZIC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732013034; x=1763549034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l2Qs9qtZaY8zBuJyu+2rd1IGPTQdfYws56k6k1nNtPg=;
  b=f9YgQZICsyf64q1OSaMSLTvE64s54Dco7TS0vVVgIqwtj9LajnBVhR6U
   EzZiciBck077s+OpnzPfTP+zlw8L2kmaKon7glC3JqSAgpajn6vx4vcFh
   b/wSaqACcEOzLbLESfyhh01FlgRok6Nlr0j8ZP84qxTURJT0YK59yr/gZ
   SL+3EPBzvXBzPPLvO7ACDAWEhqvzxPKGTmjawUnxkZu3QAq0U1/VVUpcP
   qT2xHJCQui92sCPLiTx2f3Cd7hivPK+47YsJ+XLayZzPMvPYejniaX3XO
   aFUXSoU50iUuqUNK4m1eMCRSd3wpdpiDP6zVG8Glid1J9Y9nBPaccwSOJ
   A==;
X-CSE-ConnectionGUID: VOKgQBM/SECbFNriErQLTA==
X-CSE-MsgGUID: bcZTNl1nRQGo6fl0EY6McA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="35913979"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="35913979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 02:43:50 -0800
X-CSE-ConnectionGUID: C1WrHg4cRK6NIR7EmX7PPA==
X-CSE-MsgGUID: qi7c2bReSRShyXXfeTqIJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89925595"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 19 Nov 2024 02:43:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5318C1C4; Tue, 19 Nov 2024 12:43:45 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] genirq: refactor irq_forced_thread_fn()
Date: Tue, 19 Nov 2024 12:42:33 +0200
Message-ID: <20241119104339.2112455-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irq_forced_thread_fn() open codes the irq_forced_fn().
Refactor to reuse.

Andy Shevchenko (2):
  genirq: Move irq_forced_thread_fn() further in the code
  genirq: Reuse irq_thread_fn() for forced thread case

 kernel/irq/manage.c | 46 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


