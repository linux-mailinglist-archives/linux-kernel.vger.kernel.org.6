Return-Path: <linux-kernel+bounces-273914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81085946F90
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3948E1F21E51
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6220858ABF;
	Sun,  4 Aug 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meoTYuVf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B312B6C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722784656; cv=none; b=sZ2Ye5Xs/q5IHmYp7CoNBTbV2r3OGE7e+2VCnUtb2YLyCniEyvwvyAGuSqKU9JH+PfivWlHNlVlI239YMYfuO5OsU60ftjFIbxur5bDUtCYOX4rfsl3ZVCOd30hlnK87IhDqNrwlmkTiTbCi++P1+bCJzGL0Zn+jXvO9KJOzKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722784656; c=relaxed/simple;
	bh=Ot4YrU6tG6RVc29iz6ggink5xwevXCY9bRND5jdQ2ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MTk5sPwA51IEagu9eJnJEE37IvyAK3fQP0uHs8qGi9sN9UERFYgJkEEdAedUGeDqSbvgK7391x8rY/ZYOaOBJuDhF2e6yDQNvnVUHK7PHPbe5g2TGCWjnxhoACOeaSmys7MzFt9Ku8W8L+Q0KQ0mRbG0w7YzXdjQ5WNjmliANWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meoTYuVf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722784655; x=1754320655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Ot4YrU6tG6RVc29iz6ggink5xwevXCY9bRND5jdQ2ok=;
  b=meoTYuVfWfRdei/4x56z8Dh0rWY3305WBDrufGOisN0W/J9maZW/SNdV
   67EfzsSb59BUHMTSw/0cmWJCRDMCKcbK9dKU7xENMnU8WSMQN1QahTKSu
   OpMyJ3l5P+eYgKCkLkLM5t7f9xAHB6VCEmPOfb1Ubk+ioiNC0UMB0vLeI
   6qd2mcyL8naOpFwKtBRtWr8TrAeQ8mwhYxFrtpR89fSr6N8XZfyfKtiwK
   wff0/XZfXk5Q35Ii6aBqaPf1TauhpI6gZPuf0VVyaIqv8RGR5PTrN7XFp
   hL3RecTfMKKOk86l5BFsUjnwrf59UaewMo8wnvEy7v6ZRvIK2A/EGlgkY
   g==;
X-CSE-ConnectionGUID: ODnfNmivQAOeeIFmHCIGWg==
X-CSE-MsgGUID: 24CqUkxmScGChh8HK8UNIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31402943"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="31402943"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 08:17:35 -0700
X-CSE-ConnectionGUID: cX205jJ1SYul/l9WjqbnPg==
X-CSE-MsgGUID: dzauwrLNT2Sl25iSQbdblw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="55877102"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 08:17:33 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tglx@linutronix.de
Cc: leitao@debian.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	qiuxu.zhuo@intel.com
Subject: Re: [patch 00/15] x86/ioapic: Robustness fix and cleanup
Date: Sun,  4 Aug 2024 23:06:00 +0800
Message-Id: <20240804150600.26989-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240802155038.556977544@linutronix.de>
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Thomas,

> From: Thomas Gleixner <tglx@linutronix.de>
> To: LKML <linux-kernel@vger.kernel.org>
> Cc: x86@kernel.org, Breno Leitao <leitao@debian.org>
> Subject: [patch 00/15] x86/ioapic: Robustness fix and cleanup
> 
> Breno reported a panic during testing with failslab in the IO-APIC
> code. This is a historical leftover and can be handled gracefully.
> 
> While looking at that I stumbled over quite some historical leftovers of
> debug printks, overly big comments for trivialities and a pile of coding
> style violations.
> 
> So after fixing the failslab problem I just went through and modernized the
> (IO)APIC code.
> 
> The series is also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/apic
> 

Tested this branch on an Intel Sandy Bridge server and an Ice Lake server.
Both servers booted okay and worked well. No regressions were found.
If the testing is sufficient, feel free to add:

   Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Thanks!
-Qiuxu

