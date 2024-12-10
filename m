Return-Path: <linux-kernel+bounces-440164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E879EB998
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3091D167087
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A822686C;
	Tue, 10 Dec 2024 18:46:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2EB224AEC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856393; cv=none; b=m0wEKzlp3GCWOjUv5fFULuKq9vcwFiJYD0E88PFkPl3sNqsgkrK2JW8zGPNieXK9pcQKdwZ0XPdortp2560eE8tMn2raja4jmDh3EmmqBrKg188dgTEcw0rS+Kn/VdHUDPDM2dGCfQWJt7wJ5soWfm9Pq3stjJydTH6tuopeMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856393; c=relaxed/simple;
	bh=e5PXCn07MN03XDCW/EIwWcJwKPd78HoTdyEK924UwyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEbMIbZqOCDq0HYiZzPwYWFYzRt8Go3jNeA7MmMGPd/UkLtjjMcJfRAa+HaDr89cl9sShZBHujartnidsMXrxPIVgt6gzPxgoimczAsijiGPS2N9uTMMUSUf5l1J6m1Cn7EkbBmqThWpMrw7WJGcjn4K3fMvcQimf0JDvpIM9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8006D16F2;
	Tue, 10 Dec 2024 10:46:59 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A52EC3F58B;
	Tue, 10 Dec 2024 10:46:29 -0800 (PST)
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
Subject: [PATCH 4/4] x86/mm: Remove unnecessary include in set_memory.h
Date: Tue, 10 Dec 2024 18:46:10 +0000
Message-ID: <20241210184610.2080727-5-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210184610.2080727-1-kevin.brodsky@arm.com>
References: <20241210184610.2080727-1-kevin.brodsky@arm.com>
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

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/include/asm/set_memory.h | 1 -
 1 file changed, 1 deletion(-)

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
 
-- 
2.47.0


