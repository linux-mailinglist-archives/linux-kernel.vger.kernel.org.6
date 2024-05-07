Return-Path: <linux-kernel+bounces-172544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B88BF353
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9401F2330E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B18D530;
	Wed,  8 May 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXxGjRjS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B33DDDC;
	Wed,  8 May 2024 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127000; cv=none; b=mYIY0zo5MYNPtK7C9ccHwY1iFvwmXcBEUfPGC3JiRFGVeH8IuN7TtiFxgZMpQEiKHLDVxNVXfeDe2e0PM67Jg1s4bVnouvZUjL8WlsWrHpxb5kOYJvt4hoCoxRrUlezV5T+IdTtzmEPFlVFRJUiiUNZ4cYVSJqxPe230nbQBMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127000; c=relaxed/simple;
	bh=a1a7kGmJhVbWVk9Qjv4HmPA2feFqp8D3U+r5u1agPsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ht3GLMw66aJlJsccV38sXrC187mpkuhe4DQ1lSLP2YPFIopD4fqgnZOvZUqpM8f6+3Vw5U5nF5n/IK6ABw8UAgdE3XNrlmbheiwMsrOadU8mvKyQmY8WxZQlL3D8N45egU911Kxlz/j5v3tI69vOYZYaSJEVjXvMS0f7YptyOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXxGjRjS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715126998; x=1746662998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a1a7kGmJhVbWVk9Qjv4HmPA2feFqp8D3U+r5u1agPsY=;
  b=RXxGjRjSzhdH8cX3E9B7lIKNXp9cEbA9chmD77W0TuH4lhLI1AgRKN9/
   XoNqdUV8rMou+AB7FBEtdfPuOmoelX8eC9500qpODaYx9uAnluMuVIZm/
   PWrDA90uBcADroC4gO23Sn7vQnkL58vToJDDC5qv1OkZwBIuvIi+OQW2Q
   ovs8+9xb0jFcv7AO5kwgSzRMhv/FGpIpRgigHpSgWChmDPfZik+LB9r6F
   YyPjra825rNCrmhUgd+XoA1lJi9mN8z2GGqD0yd5POfGTj17IYVjNDlXV
   ODQexQHnauH7GvbMyA2oUOAe8FM8SouDr2DIe2v7ieLA+KkijCC3kQLb4
   w==;
X-CSE-ConnectionGUID: AuLAhxr5Tg+K6i2dqaRldw==
X-CSE-MsgGUID: XkL2QbgEQF2bIpFbW9Xgng==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10898733"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10898733"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:09:58 -0700
X-CSE-ConnectionGUID: S6NuRJE9R4O3aPD9LAFBDw==
X-CSE-MsgGUID: eNmRilucQreQgMM/ssbf4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29108939"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 07 May 2024 17:09:58 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	platform-driver-x86@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	ashok.raj@intel.com,
	jithu.joseph@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 0/2] x86/fpu: Extend kernel_fpu_begin_mask() for the In-Field Scan driver
Date: Tue,  7 May 2024 16:53:42 -0700
Message-Id: <20240507235344.249103-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430212508.105117-1-chang.seok.bae@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following feedback from the previous posting [1], this revision comes
with the changelog updates for more clarity:

* The recent change in the SDM alone does not fully explain the
  underlying reasons. Provide a clearer explanation rather than simply
  echoing the SDM text.

* While it is feasible for administrators to isolate CPUs running the
  In-Field Scan tests from those running AMX workloads, this approach is
  considerably disruptive and conflicts with the goal of its live
  testing. Add this point to the changelog as well.

Thanks to Dave for highlighting these aspects [2]. Additionally, it is
worth noting that the IFS Technical Paper [3] was recently published,
which may offer further context on the IFS testing.

Thanks,
Chang

[1] V1: https://lore.kernel.org/lkml/20240430212508.105117-1-chang.seok.bae@intel.com/
[2] Feedback: https://lore.kernel.org/lkml/a41d7012-2eea-436e-9f7e-6a7702f7e2c2@intel.com/
[3] IFS Paper: https://www.intel.com/content/www/us/en/content-details/822279/finding-faulty-components-in-a-live-fleet-environment.html

Chang S. Bae (2):
  x86/fpu: Extend kernel_fpu_begin_mask() to initialize AMX state
  platform/x86/intel/ifs: Initialize AMX state for the scan test

 arch/x86/include/asm/fpu/api.h           |  1 +
 arch/x86/kernel/fpu/core.c               |  3 +++
 drivers/platform/x86/intel/ifs/ifs.h     | 15 +++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c |  6 ++++++
 4 files changed, 25 insertions(+)


base-commit: 7598293ab37c92025086de4b0ecd9474013a725f
-- 
2.34.1


