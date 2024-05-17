Return-Path: <linux-kernel+bounces-182091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4581F8C862C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B101F21618
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063F41214;
	Fri, 17 May 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hwQF7ZuF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hwQF7ZuF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B474086F
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715948097; cv=none; b=gObZUklTjX6pm3KpEgqEQtUNoU1bBOoJXGS/uwnYrzHk7IZf3lJEuzluHbhecGp5qKXY2QBr99lD3Ob1rM3qhu2lo62nGCLB3u6IvKEOXJoJpC5DRCD87/iT1yvCES28VkkYvxsNI/NbxriDU178wPBkQocpkzHXlWYVUtbb3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715948097; c=relaxed/simple;
	bh=FGJJaMByGBbYZYOyJrUGoh3jS9M7Ga+B3tR9vP10Ic8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZafLrhZziNhNApbHKBdOGrWL16yhTQ5evRFQJ2myILeKtpRbTS2qb0ggCTVRCqj/0dNFIddU0CGO5pk3p3qzgeQHCD2AE9BWEqmBwctPDHpZdscHCI7JjtcliCr3a+K5qIpyAbe8A3ABtKyGGAWpKctgbKiPB/71lIR/WcMxaJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hwQF7ZuF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hwQF7ZuF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8107337444;
	Fri, 17 May 2024 12:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715948093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q0dBrwJEirdAJjc8aRzs+naGaaVcmwY3c6T6HYjMgu0=;
	b=hwQF7ZuFZ+zgQIPwcaCfQbrnJWo+YWOK8weKZptkAATgWPyYqFrSnfVvEHmGBNML2A7vIi
	aAKZY0w+lmbYeZpSUTRkJ/QZW1TtxbfZ0O+h7bG/ZNxTcsR7tN0cbaQit1csD0SAFJyF4o
	afi/Dqbrk8lGkxLrDN9DnHqiiUIZekM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715948093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q0dBrwJEirdAJjc8aRzs+naGaaVcmwY3c6T6HYjMgu0=;
	b=hwQF7ZuFZ+zgQIPwcaCfQbrnJWo+YWOK8weKZptkAATgWPyYqFrSnfVvEHmGBNML2A7vIi
	aAKZY0w+lmbYeZpSUTRkJ/QZW1TtxbfZ0O+h7bG/ZNxTcsR7tN0cbaQit1csD0SAFJyF4o
	afi/Dqbrk8lGkxLrDN9DnHqiiUIZekM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3163013942;
	Fri, 17 May 2024 12:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CRWGCj1KR2Z7NQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 17 May 2024 12:14:53 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-coco@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Date: Fri, 17 May 2024 14:14:50 +0200
Message-Id: <20240517121450.20420-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.07 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	BAYES_HAM(-0.13)[67.40%];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.07
X-Spam-Flag: NO

While testing TDX host support patches, a crash of the host has been
observed a few instructions after doing a seamcall. Reason was a
clobbered %rbp (set to 0), which occurred in spite of the TDX module
offering the feature NOT to modify %rbp across TDX module calls.

In order not having to build the host kernel with CONFIG_FRAME_POINTER,
save %rbp across a seamcall/tdcall.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/virt/vmx/tdx/tdxcall.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 016a2a1ec1d6..68728acf0d3a 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -44,6 +44,10 @@
  */
 .macro TDX_MODULE_CALL host:req ret=0 saved=0
 	FRAME_BEGIN
+#ifndef CONFIG_FRAME_POINTER
+	/* Buggy firmware sometimes clobbers %rbp, so save it. */
+	pushq	%rbp
+#endif
 
 	/* Move Leaf ID to RAX */
 	mov %rdi, %rax
@@ -187,6 +191,9 @@
 	popq	%rbx
 .endif	/* \saved */
 
+#ifndef CONFIG_FRAME_POINTER
+	popq	%rbp
+#endif
 	FRAME_END
 	RET
 
-- 
2.35.3


