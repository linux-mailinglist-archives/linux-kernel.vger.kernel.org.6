Return-Path: <linux-kernel+bounces-566079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A170DA672D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB6C189F911
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB2020B818;
	Tue, 18 Mar 2025 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cIvOosqi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cIvOosqi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845912066C4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297775; cv=none; b=D5mn48/8qsP4513/oCW1bN56+mGLhl/JXALIDZ/w5QmtNYyXEAqrZ+Kp9uKYksnpup+fuaWhwSJ9jxV81tymfMbFBeJUbc/ARjJnwq4JK6tV0Q//N7XpBP8CSNSvQcjrVHCkER6PW2DWNSlOa2L/LyK9nHZtppmUKW8PlP8t714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297775; c=relaxed/simple;
	bh=u3R6TPSjZAWMViwz069Yr3AnucF3/VhpDDWr2fzb9Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJepmXGZlj3ZSJXZ65vRSi8nRKRebbvqDmYkIQJso8bWST+E+JRD3XvoNtxb46Jxw333R36H1uDCd7JLbk0hzLOGUCFy2YmHM1Aaik4ole2HQcfEN5afhL4SgVmQxayCzTK+gYoiyC7J4LiBUkZnBYZoEayehYvmR/Ira7aGEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cIvOosqi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cIvOosqi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EBCB1F7DB;
	Tue, 18 Mar 2025 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742297767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VIifVpBaBf4OymjJPi77fojIKu5ZPDkldDazxhwaoGM=;
	b=cIvOosqi0x4fsFUH5L+tXKtSoandBt3xmqhmLX2AZmO6N+jPzdoREX3H4msjToF3VR8rGp
	kEgUVxbTuZbbXpoKNf2s9sWJ9k8deJAPpHiB0aMc3ys0rk28xyN46a1H79HfPLGCHLodRM
	wpeYS4O9DXaBD6V/rnsv8A5ZG8qQilg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742297767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VIifVpBaBf4OymjJPi77fojIKu5ZPDkldDazxhwaoGM=;
	b=cIvOosqi0x4fsFUH5L+tXKtSoandBt3xmqhmLX2AZmO6N+jPzdoREX3H4msjToF3VR8rGp
	kEgUVxbTuZbbXpoKNf2s9sWJ9k8deJAPpHiB0aMc3ys0rk28xyN46a1H79HfPLGCHLodRM
	wpeYS4O9DXaBD6V/rnsv8A5ZG8qQilg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15926139D2;
	Tue, 18 Mar 2025 11:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MD0CAqda2WeDTQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 18 Mar 2025 11:36:07 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: dave.hansen@linux.intel.com
Cc: kirill.shutemov@linux.intel.com,
	linux-coco@lists.linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	vannapurve@google.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
Date: Tue, 18 Mar 2025 13:36:04 +0200
Message-ID: <20250318113604.297726-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

If a piece of memory is read from /dev/mem that falls outside of the
System Ram region i.e bios data region the kernel creates a shared
mapping via xlate_dev_mem_ptr() (this behavior was introduced by
9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()"). This results
in a region having both a shared and a private mapping.

Subsequent accesses to this region via the private mapping induce a
SEPT violation and a crash of the VMM. In this particular case the
scenario was a userspace process reading something from the bios data
area at address 0x497 which creates a shared mapping, and a followup
reboot accessing __va(0x472) which access pfn 0 via the private mapping
causing mayhem.

Fix this by simply forbidding access to /dev/mem when running as an TDX
guest.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

Sending this now to hopefully spur up discussion as to how to handle the described
scenario. This was hit on the GCP cloud and was causing their hypervisor to crash.

I guess the most pressing question is what will be the most sensible approach to
eliminate such situations happening in the future:

1. Should we forbid getting a descriptor to /dev/mem (this patch)
2. Skip creating /dev/mem altogether3
3. Possibly tinker with internals of ioremap to ensure that no memory which is
backed by kvm memslots is remapped as shared.
4. Eliminate the access to 0x472 from the x86 reboot path, after all we don't
really have a proper bios at that address.
5. Something else ?

 arch/x86/coco/tdx/tdx.c  | 4 ++++
 drivers/char/mem.c       | 3 +++
 include/linux/security.h | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32809a06dab4..615e8a300fc7 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -40,6 +40,8 @@

 static atomic_long_t nr_shared;

+bool devmem_disabled = false;
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __noreturn __tdx_hypercall_failed(void)
 {
@@ -1063,6 +1065,8 @@ void __init tdx_early_init(void)

 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);

+	devmem_disabled = true;
+
 	/* TSC is the only reliable clock in TDX guest */
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 169eed162a7f..8778d46216f2 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -616,6 +616,9 @@ static int open_port(struct inode *inode, struct file *filp)
 	if (iminor(inode) != DEVMEM_MINOR)
 		return 0;

+	if (devmem_disabled)
+		return -EINVAL;
+
 	/*
 	 * Use a unified address space to have a single point to manage
 	 * revocations when drivers want to take over a /dev/mem mapped
diff --git a/include/linux/security.h b/include/linux/security.h
index 980b6c207cad..1757f683a09d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -265,6 +265,12 @@ struct request_sock;
 #define LSM_UNSAFE_PTRACE	2
 #define LSM_UNSAFE_NO_NEW_PRIVS	4

+#ifdef CONFIG_INTEL_TDX_GUEST
+extern bool devmem_disabled;
+#else
+#define devmem_disabled 0
+#endif
+
 #ifdef CONFIG_MMU
 extern int mmap_min_addr_handler(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos);
--
2.43.0


