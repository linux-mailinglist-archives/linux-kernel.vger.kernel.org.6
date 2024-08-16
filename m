Return-Path: <linux-kernel+bounces-289755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 475AB954B58
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49151F23FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47A1BD003;
	Fri, 16 Aug 2024 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLVrfZ3R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF11BCA0F;
	Fri, 16 Aug 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815918; cv=none; b=SDwSWNCGGf9CcGF2sp92EEjM4R85vDemufqDkLNgdkcVlV0IQ0dVil/BAdDZ0Pt4osgSDDVQoOyOAoLlroQF7MButS62wumDiG2JLztDJGBOTz1DWn/wPdF2icsIl4TiUvXF3YJGUE2bBiiSXLo8o4ImFJpl4/oMg0xmdVGUy00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815918; c=relaxed/simple;
	bh=P2CiZHuj4n0wzBrGJeq7xdgx8UuuSPVLHbtVZzRm6cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXXeNoQV4Xwl2J3zjoRBOuOM2YEhZKbE3SHiyt9GdbZ+nkfL717cdv51h69A4Eo98Ofo8oAw1PKlgJ9YC8CXCaOimKBmrjxLkqhxVDjdxJ0yTKutJqkqNsQ0YAXDYVemNkuqk1SZVPvmK1nHEgbDN7lpxjB7bzSU0TnhGaeUmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLVrfZ3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF185C4AF09;
	Fri, 16 Aug 2024 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723815918;
	bh=P2CiZHuj4n0wzBrGJeq7xdgx8UuuSPVLHbtVZzRm6cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLVrfZ3RCQJY48FPpnHaSf248JkZQZNJFlsMdKa69x6kAZjmJs6VwIQYzGK5eewXG
	 seav76X05XpPe01S3Wj43mBfTVsm18RCtDA3T0YiwOTkxrHwgo7DkWUzhHdCsmKIsN
	 pH1+bhc93xNgWdGqWR8LdYoSnjB4gIvAOD2cHS0tEL3anMdTJdXYSGYxhwTS85SkgC
	 fK1ya7EJoKmX5AnmJXNB4oM5yVZh2vRj33RKu4kMG/mSLgODNNhYM0Le9nYnJrY2Es
	 fD2igF4fIySpwIKyX1SQnDDyHeG/iCtd4pwNFJ/5zkNIjGTjeVemkRGomHZyhD3APU
	 Hs2MbuZLBCQIg==
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
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com
Subject: [PATCH v3 06/10] x86/sev: Avoid crossing the page boundary
Date: Fri, 16 Aug 2024 15:43:56 +0200
Message-ID: <56607a180717a4196738224c995fa2c16af44da2.1723807851.git.legion@kernel.org>
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
 arch/x86/coco/sev/core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 082d61d85dfc..b0e8e4264464 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -311,17 +311,16 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 
 static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 {
-	char buffer[MAX_INSN_SIZE];
-	int insn_bytes;
+	int ret;
 
-	insn_bytes = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
-	if (insn_bytes == 0) {
+	ret = insn_fetch_decode_from_user_inatomic(&ctxt->insn, ctxt->regs);
+	if (ret == -EFAULT) {
 		/* Nothing could be copied */
 		ctxt->fi.vector     = X86_TRAP_PF;
 		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
 		ctxt->fi.cr2        = ctxt->regs->ip;
 		return ES_EXCEPTION;
-	} else if (insn_bytes == -EINVAL) {
+	} else if (ret == -EINVAL) {
 		/* Effective RIP could not be calculated */
 		ctxt->fi.vector     = X86_TRAP_GP;
 		ctxt->fi.error_code = 0;
@@ -329,9 +328,6 @@ static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 		return ES_EXCEPTION;
 	}
 
-	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, insn_bytes))
-		return ES_DECODE_FAILED;
-
 	if (ctxt->insn.immediate.got)
 		return ES_OK;
 	else
-- 
2.45.2


