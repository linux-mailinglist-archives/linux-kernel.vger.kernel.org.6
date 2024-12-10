Return-Path: <linux-kernel+bounces-440161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820D9EB993
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEB81885AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65806214231;
	Tue, 10 Dec 2024 18:46:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2A2046B9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856388; cv=none; b=QrqSLuJAaC/Lc09+3zXn/D/uLe4OPEKQzUBpClCl4kr2sB+TPynd655zkKK3tRVv8i6Vh/fZgs1O5WEY2PRzIavF+vU8jo6fVGHT8EoYn9AzqnmQ7MUWf8EyaQMTTxFbSaM8JsP1bIOCYOIdwHXx8mh4jkCbBL5dfHeqxyKBvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856388; c=relaxed/simple;
	bh=CTlBCvNJrEkicTyO1DepJXPgXB+HXtAILCY2tlalbLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuNqFybmzZnPKI+O/OfavxaqwBooxxGAK9K0exvn95ymeN7nSzo1C5Y/MzBn/Lqvv9n6sn6rq7mixKog6gNHMBdYFEFXs1tgPetE5Q09aulaWehN8sqcylBz8yxZ3jZ10rYp9Z+CXFXSeWvcUFQ5T5gr7rJWmHJylY3rwFPx7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 462BA113E;
	Tue, 10 Dec 2024 10:46:53 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CC353F58B;
	Tue, 10 Dec 2024 10:46:23 -0800 (PST)
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
Subject: [PATCH 1/4] x86/smp: Explicitly include <linux/thread_info.h>
Date: Tue, 10 Dec 2024 18:46:07 +0000
Message-ID: <20241210184610.2080727-2-kevin.brodsky@arm.com>
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

Including <asm/thread_info.h> directly relies on
<linux/thread_info.h> having already been included, because the
former needs the BAD_STACK/NOT_STACK constants defined in the
latter.

A subsequent patch will break that assumption in a file that
includes asm/smp.h. Include the full <linux/thread_info.h> to avoid
getting into troubles.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/include/asm/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..88e72b414bfa 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -6,7 +6,7 @@
 
 #include <asm/cpumask.h>
 #include <asm/current.h>
-#include <asm/thread_info.h>
+#include <linux/thread_info.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
-- 
2.47.0


