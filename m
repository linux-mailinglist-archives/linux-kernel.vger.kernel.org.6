Return-Path: <linux-kernel+bounces-437695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E3D9E96FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95AB283388
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF20835952;
	Mon,  9 Dec 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bafPpX9c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04AB233159
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751183; cv=none; b=O62oz8JAi+HrYtyf6hyFZOQwyq/9DrAcI672tzLnA6d3eapwLFUko8BzLALVVokhYTR5DLeRWUmxO9XMosB12VkI1wcA06SFOghai2FfIK9tHXsw18aKokmNJ2q5YWOO8SiWLfW6f8O3SLIhdVE86CTDpWtGo1dgVye29l6OnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751183; c=relaxed/simple;
	bh=tVQZnPZQN0kBtWeOaQJmx0P/Q5d+rwbyumCvJqbkGcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaYEpHjg7NSjrbCCYYg5RwFB7IuNVjoadfYIeH1RY4mfnXlaJVfWPH+9Wd/cfjW+/URjuPlB7b7m8E+OE3PFqsMGcOSU1qBPJnw0xThVaV7GBsJWPbGwlRrhqYeB/ArL97iV3bM3wC/PmgPl41iwTutBUyydGIZlq9dP6TDYKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bafPpX9c; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733751182; x=1765287182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVQZnPZQN0kBtWeOaQJmx0P/Q5d+rwbyumCvJqbkGcI=;
  b=bafPpX9c+E6uCVaSuxA+HWh8pK+mDhWb+nmymHK32PQTfIJbNChtV6Ms
   F6JoAvw+TuJTGvG0/OTEwSApoFfVmc4wbpLrypzKmr+Ve9iBi33nZ5kNk
   EaFFRKaDNaPXtUyXfOtENYTGRfffV0/zq+pRDfdHVma9ERYh3RtlbBSHb
   NL61hk7ZXxy1QTWNRUKro1SsnFf+CfRdkZZ6Ot2XpigKEARYw8g3dU/p2
   AqcH4Mt5sP1h343sPQrgIb2HAQRrFzY/O9RtornlPFFbtdCEQ0eXX+zQH
   6smnnXF009Umel5O2IcmmUOWO+XkBTtJ4/cQOq4tBK2ZCEDNOaqF0ZfOC
   w==;
X-CSE-ConnectionGUID: mKFl2AWfTXOKA0w2vip22g==
X-CSE-MsgGUID: l2+X0UwiTU6oDlMOSZwXiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34191893"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34191893"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:33:01 -0800
X-CSE-ConnectionGUID: oIWXo/SSSn27cBE95jrq0g==
X-CSE-MsgGUID: +w6WQHGOTZWY+f3GxU1VSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="99531232"
Received: from mkuoppal-desk.fi.intel.com ([10.237.72.193])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:32:57 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	christian.koenig@amd.com,
	Mika Kuoppala <mika.kuoppala@linux.intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Andi Shyti <andi.shyti@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Maciej Patelczyk <maciej.patelczyk@linux.intel.com>,
	Dominik Grzegorzek <dominik.grzegorzek@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH 01/26] ptrace: export ptrace_may_access
Date: Mon,  9 Dec 2024 15:32:52 +0200
Message-ID: <20241209133318.1806472-2-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209133318.1806472-1-mika.kuoppala@linux.intel.com>
References: <20241209133318.1806472-1-mika.kuoppala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xe driver would like to allow fine grained access control
for GDB debugger using ptrace. Without this export, the only
option would be to check for CAP_SYS_ADMIN.

The check intended for an ioctl to attach a GPU debugger
is similar to the ptrace use case: allow a calling process
to manipulate a target process if it has the necessary
capabilities or the same permissions, as described in
Documentation/process/adding-syscalls.rst.

Export ptrace_may_access function to allow GPU debugger to
have identical access control for debugger(s)
as a CPU debugger.

v2: proper commit message (Lucas)

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
CC: Andi Shyti <andi.shyti@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
CC: Maciej Patelczyk <maciej.patelczyk@linux.intel.com>
Cc: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d5f89f9ef29f..86be1805ebd8 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -354,6 +354,7 @@ bool ptrace_may_access(struct task_struct *task, unsigned int mode)
 	task_unlock(task);
 	return !err;
 }
+EXPORT_SYMBOL_GPL(ptrace_may_access);
 
 static int check_ptrace_options(unsigned long data)
 {
-- 
2.43.0


