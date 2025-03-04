Return-Path: <linux-kernel+bounces-544449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DB3A4E19D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6D13ACD22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4125FA14;
	Tue,  4 Mar 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymv4C5uR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598D25F999
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098829; cv=none; b=AQ37i1u31TI2FsHcQNe1lnNVaCwp+faoyGiHkNZM5WJ6e9kSoN+wzxRYfiEOFj8wpT44JjMgkFdQZsX2SQ5fpa//NvNIpYdZkRYQSeifW2VDCI6hUtREmxNPEZuqL/nLjo8+b5385IBLxi4Ur9gnnAmRxcP9jooqsVRQb1VMnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098829; c=relaxed/simple;
	bh=A6FMm8UG2dvvc1GcMFpPZomsV45FygJOmtplYtMwMUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GsMuRL3rF3mnoa3AkimGqI4prL3YgiETlAa8s4i1XwJFfXwwXou8ZMnt5XVptmtyP+9MipMNMpz+9M+TQs42n7ksJalyhhXZ2mhkMpAv8qxIXwYLeYIsmNSFvdYrJuGDvxxDGLnLeqVBjfjeQOBZsEftvFAECEzlrGYrt50BXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymv4C5uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E37C4CEE5;
	Tue,  4 Mar 2025 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098829;
	bh=A6FMm8UG2dvvc1GcMFpPZomsV45FygJOmtplYtMwMUY=;
	h=From:To:Cc:Subject:Date:From;
	b=Ymv4C5uRPu2wc+/yiqdQ43mafpM0gVDxGHCXls4/g/Z/IVnyy5eMuQ0xChZTbBttu
	 iKrWRBKMsk5EyQghnXzRaTW9ay0IxU+LUruB8DKECSQbHmiUZ5Ix5OKenE/p/MCFu1
	 /mcdQM3UYCA1Xp0EVogCftgREzHF83zhRyxHWRwemTEV48yII5Lo5B0tPYJ7hwKmLw
	 NA4MepQ8BDzfbh75KtCgkJb4Uw0Hk6F2Au5p4woVUl0zCi13qTw9paMfY+XIhGONSi
	 RBXybCg+Li+I1+HzU53y8YrEIqTx4bSC0pX8QrwP6g9vjU3WOGR2DPjJFyxciY2yFq
	 pD7p/ILs+WkcA==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Date: Tue,  4 Mar 2025 15:33:34 +0100
Message-Id: <20250304143340.928503-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When extra warnings are enabled, the cc_mask definition in asm/coco.h
causes a build failure with gcc:

arch/x86/include/asm/coco.h:28:18: error: 'cc_mask' defined but not used [-Werror=unused-const-variable=]
   28 | static const u64 cc_mask = 0;

Mark this one as __maybe_unused.

Fixes: a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/coco.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index aa6c8f8ca958..9e9204cfca6f 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -25,7 +25,7 @@ u64 cc_mkdec(u64 val);
 void cc_random_init(void);
 #else
 #define cc_vendor (CC_VENDOR_NONE)
-static const u64 cc_mask = 0;
+static const __maybe_unused u64 cc_mask = 0;
 
 static inline u64 cc_mkenc(u64 val)
 {
-- 
2.39.5


