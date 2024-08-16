Return-Path: <linux-kernel+bounces-289754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D22954B57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD121F23AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A4F1B8E84;
	Fri, 16 Aug 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8uOsuos"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13811BCA0F;
	Fri, 16 Aug 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815913; cv=none; b=kE+Vg5HmRYhxgOJR0VMcO3bCmm4/YOj3SJoe3R8GsJs5CyeI6bBW9vi23tSWn7AGgqbWti6mTKFjPq8RTn5ZYIoQQ+MRVtL7JA0xj9/w48HBRpU50fGt3BO+4tPtxGP4NMR22YMFnxypFkYcPphYZ/sXZyMbJzJEHNimR+PXf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815913; c=relaxed/simple;
	bh=oJ8jrbxrXllrr3ZEDRdUWjb+RVr3kNxWUfwyQ6lqK3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9BULfa9Aur8N6jFkGw64+okcfHmONKjsZ2csLuAhhTsB0nIy7entt1m24zzYg6ajA7T3/bxLYW9Y+YACMbPXkqZO8aLFJVqrPdZzcMWGewTohXgYTff7h8Llvoj5s888t0DClhtFSXpWwzSii+6q2NkZ/z5iEBMV+QHhPw/bKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8uOsuos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EB3C4AF0D;
	Fri, 16 Aug 2024 13:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723815913;
	bh=oJ8jrbxrXllrr3ZEDRdUWjb+RVr3kNxWUfwyQ6lqK3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8uOsuosgUzB57cIEOdqWGZUiiOyFB7cwQsfujFIiTRK3EuKyRA2iFRQy/8WImsKK
	 dPJo8wU55kBxBnFECbZHWi40x8ssj+VMJpJQR9A6uLEEAIlwIiI0QWYlFpJDmgQpzi
	 8jcm102O2Ldyl9C+uN8bDpkqQ+CMrKb8rIHWZBLGLi5XVuYsQYOq0VgfBzmMpHNKWt
	 SjZ/OOSL0y1kSDSk+4oTkCrVyeBV5ZfCPNZKehzEXeBNMcfmNEAx6d3yH8m5v3XtAF
	 46k0Z4U7fxUtF7ChMCx11jqztGD3FWwq7kmiX4ozVxjx7TD7/bIW8+xx/U/SKewjnZ
	 H9AfqF0/ZLkrg==
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
Subject: [PATCH v3 05/10] x86/tdx: Avoid crossing the page boundary
Date: Fri, 16 Aug 2024 15:43:55 +0200
Message-ID: <b6281bb223a69ae082d0f31c531ef991e0a077ee.1723807851.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723807851.git.legion@kernel.org>
References: <cover.1722862355.git.legion@kernel.org> <cover.1723807851.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

Try to avoid crossing the page boundary to avoid side effects if the
next page belongs to another VMA.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 254d5293d25a..e3d692342603 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -489,13 +489,10 @@ static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
 	char buffer[MAX_INSN_SIZE];
 
 	if (user_mode(regs)) {
-		int nr_copied = insn_fetch_from_user(regs, buffer);
+		int ret = insn_fetch_decode_from_user(insn, regs);
 
-		if (nr_copied <= 0)
-			return -EFAULT;
-
-		if (!insn_decode_from_regs(insn, regs, buffer, nr_copied))
-			return -EINVAL;
+		if (ret)
+			return ret;
 	} else {
 		if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
 			return -EFAULT;
-- 
2.45.2


