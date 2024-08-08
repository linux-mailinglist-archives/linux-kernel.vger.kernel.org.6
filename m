Return-Path: <linux-kernel+bounces-279778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C4C94C1B4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D574428A359
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3881917FB;
	Thu,  8 Aug 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn0Uz2hM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC397190664;
	Thu,  8 Aug 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131811; cv=none; b=ZSndCSHyxnF1roRBnD9SCM7MfrJHlDsdgm8OqTb+ZK5+hqG3MUXlhx4SJpqfgruSg3Z/rca2rNJb4VmHFdEvX9GrxSQgKA9eBIFfz667i2ktgBRBHsNhL52/+3599jV4pus41FpYj4tb+60nbPhLPU0j4+JIswT9sfCupCtObMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131811; c=relaxed/simple;
	bh=k/kXFlT9ZVoSlwZ0xX75VFsehWjIsN8n46sZVQ19SWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYWKJiZniJpGzKHRM6akxzGgk0AAxH1t9+Bf4c/wbjJXoL5IxdPqW5hUoYLV8pZciSEToItqdk9PvhvBqH0nOh+k8a56oSeZWJJiViQ42fmFAKlx32+sJE+BvRr3xESiBmc2sI1Ea6+V7nSpUldCkawd35s8n8fnZApFQuXvShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn0Uz2hM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E1FC32782;
	Thu,  8 Aug 2024 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131810;
	bh=k/kXFlT9ZVoSlwZ0xX75VFsehWjIsN8n46sZVQ19SWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pn0Uz2hMo6uhMAW1nMQtGNRaZaSrmqOVgYdGU/tH03DY87jDD4n+mTS6SuYuduhII
	 Q+pw61wZZyhR2MLMdWAnq+rU1APPJsTZ881MiSwFUr29w2zrT0KhumYj9LofeULWGA
	 Dm1VluNAhlTaPOLixNgQrNxK2fmVYSgVK9jSDWDPVN3NMeucEcOOtMnU0IV78QRM1p
	 3gu9Xz+Bvf52n94MHl+iQxoI3zReAkoMVlEfh0u+Y+zw+Idyg+mNltxWq0aibGEdj5
	 FsWuMFbCBQ3REoSPlh+yaBPtx9hHk209axyKkkjXE2AugGiiP0sUGBUScMZ7HS6CeO
	 mPYJFZXFPMT8g==
From: "Alexey Gladkov (Intel)" <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v3 7/7] x86/tdx: Avoid crossing the page boundary
Date: Thu,  8 Aug 2024 17:42:47 +0200
Message-ID: <756b23ce8c953be94d0998de97b080479b9442a3.1723130802.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
References: <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com> <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case the instruction is close to the page boundary, reading
MAX_INSN_SIZE may cross the page boundary. The second page might be
from a different VMA and reading can have side effects.

The problem is that the actual size of the instruction is not known.

The solution might be to try read the data to the end of the page and
try parse it in the hope that the instruction is smaller than the
maximum buffer size.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 5b3421a89998..ea3df77feef0 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -494,16 +494,32 @@ static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
 	char buffer[MAX_INSN_SIZE];
 
 	if (user_mode(regs)) {
-		int nr_copied = insn_fetch_from_user(regs, buffer);
+		int nr_copied, size;
+		unsigned long ip;
 
-		if (nr_copied <= 0)
+		if (insn_get_effective_ip(regs, &ip))
 			return -EFAULT;
 
-		if (!insn_decode_from_regs(insn, regs, buffer, nr_copied))
-			return -EINVAL;
+		/*
+		 * On the first attempt, read up to MAX_INSN_SIZE, but do not cross a
+		 * page boundary. The second page might be from a different VMA and
+		 * reading can have side effects (i.e. reading from MMIO).
+		 */
+		size = min(MAX_INSN_SIZE, PAGE_SIZE - offset_in_page(ip));
+retry:
+		nr_copied = size - copy_from_user(buffer, (void __user *)ip, size);
+
+		if (nr_copied <= 0)
+			return -EFAULT;
 
-		if (!insn->immediate.got)
+		if (!insn_decode_from_regs(insn, regs, buffer, nr_copied)) {
+			/* If decode failed, try to copy across page boundary */
+			if (size < MAX_INSN_SIZE) {
+				size = MAX_INSN_SIZE;
+				goto retry;
+			}
 			return -EINVAL;
+		}
 	} else {
 		if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
 			return -EFAULT;
@@ -511,6 +527,10 @@ static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
 		if (insn_decode(insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
 			return -EINVAL;
 	}
+
+	if (!insn->immediate.got)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.45.2


