Return-Path: <linux-kernel+bounces-346168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8398C0C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AB71F236CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596581C9B71;
	Tue,  1 Oct 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMJexj75"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534521C57BE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794412; cv=none; b=AdGVrtmpd6KAUZYLDNrzYJoIjKYtJ3YU+z0sPnBH4Grcq3TmXekZqhhffQcSL/NeT1HV1XOBnbazZhUIX6woUZLi1dmrctvEN2WtIFJ0ZSNCwWv08CswcZdwqIwIFjXuOOp8qFv8L6Yk54q6nFoQqx60whhsxO0FSmfFtEE9t0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794412; c=relaxed/simple;
	bh=yvBBJl5SIqqmo3U4YGxGGFdYZwKItrjypC/o5O9XQxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLIGBUFFbtBfWY8RAivRKWKBG59Ea97JbBr126snLqxdrmDnha7KQWnNivuxXy8BfN/JZ/x1dVl6i4JYbwnv8uELPdWI37R1/ZX+3BkzdXjVDBVEwBvmkarq+XZVlCuFlf5WQl/HGOPQNiEdW1NxBHE1CbTN9HToNywsKQ0Kg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMJexj75; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727794411; x=1759330411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yvBBJl5SIqqmo3U4YGxGGFdYZwKItrjypC/o5O9XQxQ=;
  b=UMJexj75PTvH2fixjiCCXwfU2LjUx9zNCU8OX1m2wi13nwGEygTWVdIo
   Teqn53TDZRgO7xxqwI2Ek4tT2IesRwRhllTcs2KqAQIHboqtcPZIUWqLu
   sBsqayN4VYKkl2MairG6eu3HLTDRa/7BWJ9+VUy7SUdAR+4xiXCbkWeb/
   i5ipqHQMIlxeOJ52VcItnyHbNteFx+9mrM+ZU7mJeJGuGvZmRcT86AqWJ
   2/IlsiQjotkwR/jaMoYMvu3NEIENfNmQWna/KwMKjQ4Bv0kTF+YESHRfr
   pzNgnzMENhA3RB/+FpKeQL+JknAx8iEbRbDvqQ0FuiunQ+yda/IVKyVfp
   A==;
X-CSE-ConnectionGUID: 3UvTtcG1SlGR8wRe42A7qQ==
X-CSE-MsgGUID: zA6W9U5jTy+b+BThFVslrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27091374"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="27091374"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 07:53:31 -0700
X-CSE-ConnectionGUID: 1ijE/HElTkmYjojgOyxuEw==
X-CSE-MsgGUID: 1g6Zju8NS7ygpDcU28iPVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="97048611"
Received: from mkuoppal-desk.fi.intel.com ([10.237.72.193])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 07:53:27 -0700
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>,
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
Subject: [PATCH 01/18] ptrace: export ptrace_may_access
Date: Tue,  1 Oct 2024 17:42:49 +0300
Message-Id: <20241001144306.1991001-2-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001144306.1991001-1-mika.kuoppala@linux.intel.com>
References: <20241001144306.1991001-1-mika.kuoppala@linux.intel.com>
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
2.34.1


