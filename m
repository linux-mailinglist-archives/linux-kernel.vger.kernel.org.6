Return-Path: <linux-kernel+bounces-430070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33349E2DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 060F2B2E4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F31FDE2A;
	Tue,  3 Dec 2024 19:46:32 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519A204F77
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255192; cv=none; b=bczSWoXQb8MGTvIw52w5ottzioB0qtND28cvpS/blAmVrfX6MqOfv7pSUw3XMUiSDLae3rdf8Wz9WMi2f/nXEbdXXi5vJr0ZDgl0NZENLIGE5334odY6QxexziUC7LCPr4OEJvwV/5Bt53fQ679IT6vO9p7/vmNVSjmzagckyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255192; c=relaxed/simple;
	bh=ayjJhvEnqmcVSyaBeb998Pk3PUd3CnrM4zKpciianxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7+lKrnnoNzv/e8bRYrQS/hIhEN1xfnCfSVpGs2hQdbxO9OBpSvZ5/6nGGNvflbHaoQ//MqEuvzI0jaw6SQ3xNC1x9y3kDlLlJSiDH+WIB8rwtVxMk9pc2C05UlBA2sJUEt03s14fZoclN/HK0O1tCCZRn0TObLl1tRqvu27wQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y2rkT2frSz9stG;
	Tue,  3 Dec 2024 20:46:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCG2vu4-nnmU; Tue,  3 Dec 2024 20:46:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y2rkT1jk9z9stD;
	Tue,  3 Dec 2024 20:46:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 212AB8B763;
	Tue,  3 Dec 2024 20:46:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 7pxtHpRMStCP; Tue,  3 Dec 2024 20:46:25 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 50EC78B76C;
	Tue,  3 Dec 2024 20:46:24 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/4] static_call_inline: Provide trampoline address when updating sites
Date: Tue,  3 Dec 2024 20:44:49 +0100
Message-ID: <5efe0cffc38d6f69b1ec13988a99f1acff551abf.1733245362.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733245362.git.christophe.leroy@csgroup.eu>
References: <cover.1733245362.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733255162; l=1424; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ayjJhvEnqmcVSyaBeb998Pk3PUd3CnrM4zKpciianxY=; b=02Xc17llbaI9+HAI9fOhqoUpXP83GAbmDUMspEMI0XYRDQgjtkrcMaERuxOP1mNS67iZtKewZ UgUC4pDJ0qpDkFH9z99XF7s8DNM0Zhc9ouFoi9BG6F7WIgo+TnQk8yj
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In preparation of support of inline static calls on powerpc, provide
trampoline address when updating sites, so that when the destination
function is too far for a direct function call, the call site is
patched with a call to the trampoline.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/x86/kernel/static_call.c | 2 +-
 kernel/static_call_inline.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 4eefaac64c6c..00b2ea40cbef 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -158,7 +158,7 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	mutex_lock(&text_mutex);
 
-	if (tramp) {
+	if (tramp && !site) {
 		__static_call_validate(tramp, true, true);
 		__static_call_transform(tramp, __sc_insn(!func, true), func, false);
 	}
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 5259cda486d0..7fefbb3d8074 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -206,7 +206,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 				continue;
 			}
 
-			arch_static_call_transform(site_addr, NULL, func,
+			arch_static_call_transform(site_addr, tramp, func,
 						   static_call_is_tail(site));
 		}
 	}
-- 
2.47.0


