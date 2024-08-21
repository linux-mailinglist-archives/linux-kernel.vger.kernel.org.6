Return-Path: <linux-kernel+bounces-295664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29246959FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D708E1F245CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863D1B2EFE;
	Wed, 21 Aug 2024 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEsAjVe3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745A1B1D7F;
	Wed, 21 Aug 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250364; cv=none; b=sa6l4x7Ep8jR54ouxw1++6egR9ueFdgB2H7xJU2rqVf8vApMbflcORFRwLgzBGtNDBNy6hnwaUHOQDzYzQ3Bi5G8yC4bhIqJ6Y8hMvPKNRuYMcApF7uTAB986ibaMPgq6A2dFzRhG2SDSZ5cUPXV2mpp5FPdfzURFaXiiLOh7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250364; c=relaxed/simple;
	bh=YU4h73oQw0zQKde8/rV+ORs8akZE2n3EpYgUMr0XtWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9aPbA7l5pgbL2VxbADu5itKUihU8sXOQ/EMkYDTvRzTHHqMAsB7j5JJkqMCeJsESqCVw0sEEQ+nNzO7rsbcWb0kyjw4b44fRGRJLK7Zt64VncIYnqyq4s/bln/K/awwwsg5lsHYKX+DhNsXDJMGRUJt86TpvYa7pYdYO5shtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEsAjVe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0394C32781;
	Wed, 21 Aug 2024 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724250363;
	bh=YU4h73oQw0zQKde8/rV+ORs8akZE2n3EpYgUMr0XtWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEsAjVe3G1eVVSwsbUTOnJOGWQXntakFxgOSI2/AW/LGrX2JadlvTdK4tPT1bddai
	 TEn5BXAYgXmgYZcNjJUaTDCys5eVfBJvQ9wO1RWGbZ99ZOpI1RbNNF4HawyHikhZ/K
	 bQAWNislGaPYa/y1hImylpapKL13DuyjzB1kPCVCei2zbxiouB0L0z0hcngS4m/CYO
	 IyN4UMqrVo1YU6S8pcoFLDe/KQ2VsbK3S1e2C1lDy2CFloTnHGkfiDj7Ixr6JtoLXz
	 CBlEl+mFXs0XJvEhf0F54QqY4en10SieLefPZXCXgn2y+nqu426SWeMNuleYE68/eu
	 UmqqRHAvSfgrg==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com
Subject: [PATCH v4 4/6] x86/tdx: Add a restriction on access to MMIO address
Date: Wed, 21 Aug 2024 16:24:36 +0200
Message-ID: <0d4381397c33426bda5d3b0e5541965dcebdf962.1724248680.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724248680.git.legion@kernel.org>
References: <cover.1723807851.git.legion@kernel.org> <cover.1724248680.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

In the case of userspace MMIO, if the user instruction + MAX_INSN_SIZE
straddles page, then the "fetch" in the kernel could trigger a #VE. In
this case the kernel would handle this second #VE as a !user_mode() MMIO.
That way, additional address verifications can be avoided.

The scenario of accessing userspace MMIO addresses from kernelspace does
not seem appropriate under normal circumstances. Until there is a
specific usecase for such a scenario it can be disabled.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 5d2d07aa08ce..65f65015238a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -411,6 +411,11 @@ static inline bool is_private_gpa(u64 gpa)
 	return gpa == cc_mkenc(gpa);
 }
 
+static inline bool is_kernel_addr(unsigned long addr)
+{
+	return (long)addr < 0;
+}
+
 static int get_phys_addr(unsigned long addr, phys_addr_t *phys_addr, bool *writable)
 {
 	unsigned int level;
@@ -606,6 +611,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
 		return -EINVAL;
 
+	if (!user_mode(regs) && !is_kernel_addr(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
+	}
+
 	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
 
 	if (user_mode(regs)) {
-- 
2.45.2


