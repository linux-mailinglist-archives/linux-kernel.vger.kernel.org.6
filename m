Return-Path: <linux-kernel+bounces-265878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D47B93F72A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33D41F22730
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5B149DE1;
	Mon, 29 Jul 2024 14:01:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA52D05D;
	Mon, 29 Jul 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261697; cv=none; b=XRucaU9r2XbgVQ80EFBUWm828XgqlI4Nne0wBcRC7B7Z7aR2kVufDW3jH2eMmvWPmeRHYVbdZrRF0j6RztF6lalh7Un8GCrF+0KeiUAPQDgv/Q3vPPR68+y1q/7yCl3DvOjFPUT5gvAjaEXmqrdkhC01Cv7sTQ42WCfvSkWAiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261697; c=relaxed/simple;
	bh=sgjboYkTTk6vU0bvlwcipJgHGWfOKI2kUzAjXUJKn7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bu7rm+4R+9pn+MqfR+sTM55REnKZG7UU3gyXVW4WKeNL5GyqxuGRcNjf+L6s2cwAVowt/zfwLc1NysSk/T7PkPbaQ/lj0z0iW1aC44dN6JEEKaX8Nv0f0Fpjmq0VMGy5ozj2cBTzwnIRvDSwJSMAj7eJzHFUNiXWjVlhyUSjcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CABF01007;
	Mon, 29 Jul 2024 07:01:58 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DB733F64C;
	Mon, 29 Jul 2024 07:01:32 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH] docs/core-api: memory-allocation: GFP_NOWAIT doesn't need __GFP_NOWARN
Date: Mon, 29 Jul 2024 15:01:27 +0100
Message-Id: <20240729140127.244606-1-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v6.8 the definition of GFP_NOWAIT has implied __GFP_NOWARN,
so it is now redundant to add this flag explicitly.

Update the docs to match, and emphasise the need for a fallback
when using GFP_NOWAIT.

Fixes: 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Based on: v6.11-rc1

This change also evaporates the apparent typo of __GFP_NOWARN without
the underscores in the documentation, but that doesn't really feel like
it merits a dedicated patch.

Not sure if this really merits a Fixes tag, but the docmuentation
update might as well be picked into trees that have the corresponding
code change.

---
 Documentation/core-api/memory-allocation.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
index 8b84eb4bdae7..0f19dd524323 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -45,8 +45,9 @@ here we briefly outline their recommended usage:
   * If the allocation is performed from an atomic context, e.g interrupt
     handler, use ``GFP_NOWAIT``. This flag prevents direct reclaim and
     IO or filesystem operations. Consequently, under memory pressure
-    ``GFP_NOWAIT`` allocation is likely to fail. Allocations which
-    have a reasonable fallback should be using ``GFP_NOWARN``.
+    ``GFP_NOWAIT`` allocation is likely to fail. Users of this flag need
+    to provide a suitable fallback to cope with such failures where
+    appropriate.
   * If you think that accessing memory reserves is justified and the kernel
     will be stressed unless allocation succeeds, you may use ``GFP_ATOMIC``.
   * Untrusted allocations triggered from userspace should be a subject

base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.34.1


