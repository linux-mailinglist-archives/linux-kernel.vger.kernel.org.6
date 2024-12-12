Return-Path: <linux-kernel+bounces-442732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D99EE0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CFB18895AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05520CCE7;
	Thu, 12 Dec 2024 08:09:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BB20C004
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990963; cv=none; b=HsQLHlAK+/IjfazntnSgTqNzblTy8gRudTUAvnM8TiZpRMLykZ56qCBqu8lcR87SgpDy7UVv/O4aRWbNrpulQmprU/Vtu6XHOtFFMNrhd91QZK6EMns/7f91YOzVnXFYzZXeVwpGMxAe4c4FQwXXe83SURBEnDhuHpn28fcVGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990963; c=relaxed/simple;
	bh=+mMtbs8cmKrUlUmSEk+yek9cpP8G0N2EYmh4zIg2Yv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7MNNFG6nb2/MLZCqnNa0fZs1mXvB2x0l13GHrIdtFryITac2UYdnjdRXEWhQhlo0tRHuZwAqWYVaf7g9FvJ9it4Ql48wXTdQCbGbJLI6m6/mDg+gW1oQXbD+cFZUaoWfXrUYS9/+JifMqZkxzIShJlplww8hPNeyBSg9wZYTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA8771758;
	Thu, 12 Dec 2024 00:09:41 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C0E23F5A1;
	Thu, 12 Dec 2024 00:09:12 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	jane.chu@oracle.com,
	osalvador@suse.de,
	tglx@linutronix.de
Subject: [PATCH v2 2/2] x86/mm: Remove unnecessary include in set_memory.h
Date: Thu, 12 Dec 2024 08:09:04 +0000
Message-ID: <20241212080904.2089632-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241212080904.2089632-1-kevin.brodsky@arm.com>
References: <20241212080904.2089632-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 03b122da74b2 ("x86/sgx: Hook arch_memory_failure() into
mainline code") included <linux/mm.h> in asm/set_memory.h to provide
some helper. However commit b3fdf9398a16 ("x86/mce: relocate
set{clear}_mce_nospec() functions") moved the inline definitions
someplace else, and now set_memory.h just declares a bunch of
functions.

No need for the whole linux/mm.h for declaring functions; just
remove that include. This helps avoid circular dependency headaches
(e.g. if linux/mm.h ends up including <linux/set_memory.h>).

This change requires a couple of include fixups not to break the
build:

* asm/smp.h: including <asm/thread_info.h> directly relies on
  <linux/thread_info.h> having already been included, because the
  former needs the BAD_STACK/NOT_STACK constants defined in the
  latter. This is no longer the case when asm/smp.h is included from
  some driver file - just include <linux/thread_info.h> to stay out
  of trouble.

* sev-guest.c relies on <asm/set_memory.h> including <linux/mm.h>,
  so we just need to make that include explicit.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/include/asm/set_memory.h       | 1 -
 arch/x86/include/asm/smp.h              | 2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 6586d533fe3a..8d9f1c9aaa4c 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_SET_MEMORY_H
 #define _ASM_X86_SET_MEMORY_H
 
-#include <linux/mm.h>
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..2ca1da5f16d9 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -3,10 +3,10 @@
 #define _ASM_X86_SMP_H
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
+#include <linux/thread_info.h>
 
 #include <asm/cpumask.h>
 #include <asm/current.h>
-#include <asm/thread_info.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index b699771be029..e134bee818fa 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -23,6 +23,7 @@
 #include <linux/cleanup.h>
 #include <linux/uuid.h>
 #include <linux/configfs.h>
+#include <linux/mm.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 
-- 
2.47.0


