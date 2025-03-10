Return-Path: <linux-kernel+bounces-554143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE9CA59367
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25FA3A6E16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AC227E8A;
	Mon, 10 Mar 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="N3tQSyH7"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B322156F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608280; cv=none; b=RSTqAt//cCLveaP9EqJDrJkVeMd6feUYEJgfmx7cXhHBanOWuI4hMuFcrYjUz2SSTbQFu0wPwlHDdZDcIUxdds5xslsXQHFm8hDnkHyManIvKgVgjO7nkf09mPbdevnz7l5RaY0TL5dG0jquWGFd0wyFs0o8FWFm5tVFngk5tnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608280; c=relaxed/simple;
	bh=5OH6zwiSw0oNmq1LgVVbHiG2za82nMq8SrllEkAQIHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FL6+u3YesI+DvrFQN6C4w2zhCyvlxrwOKuRwTVSgto2CUQGyvQKGqlxdH7GLJhGXcXzxmpPDbWBid9acHhpzJztNLO1VJPJ/ZGAtkAcjhO0kTkbRpFdEV7nK5ytzVh0Gwoy8BK9/xdIYgxJifs/rqUlmEVx2sayGz7SADseQFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=N3tQSyH7; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3D4D160DE9;
	Mon, 10 Mar 2025 15:04:06 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-U5ZTnMcq;
	Mon, 10 Mar 2025 15:04:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608245;
	bh=QkhEET4Wo+gouJiK8Lgb4vMFbcgAXJpnZW6CjWUXYUI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=N3tQSyH7q5Aw8vLpj6oIzXJUFol2N5amtQM0FyQ56H5V1ZTHW1L15Ttrhb4B+gc9s
	 kwO45GOraHszy2v9J2VM/BFPgJC3K8JF8XkbIkUICHgn30PaHURZx5W6AKTRCMaz9h
	 /YGOyUFNzrS71N7G5BQA84g6wuvpXWXemUAU3A/g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v2 2/7] kstate, kexec, x86: transfer kstate data across kexec
Date: Mon, 10 Mar 2025 13:03:13 +0100
Message-ID: <20250310120318.2124-3-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250310120318.2124-1-arbn@yandex-team.com>
References: <20250310120318.2124-1-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kstate data to kexec segments so it got copied to the new kernel.
Use cmdline to inform next kernel about kstate data location and size.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
I've used cmdline as it's the simplest way to transfer address
to the new kernel. Perhaps passing it via dtb would be more elegant
solution, but I don't have strong opinion here.
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/kernel/kexec-bzimage64.c |  4 +++
 arch/x86/kernel/setup.c           |  2 ++
 include/linux/kexec.h             |  2 ++
 include/linux/kstate.h            |  5 ++++
 kernel/kexec_file.c               |  5 ++++
 kernel/kstate.c                   | 49 ++++++++++++++++++++++++++++++-
 7 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0e27ebd7e36a..7358d9e15957 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -90,6 +90,7 @@ config X86
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_KERNEL_FPU_SUPPORT
+	select ARCH_HAS_KSTATE			if X86_64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 68530fad05f7..d3c98c8bda29 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kexec.h>
 #include <linux/kernel.h>
+#include <linux/kstate.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/random.h>
@@ -77,6 +78,9 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
 	}
+	if (IS_ENABLED(CONFIG_KSTATE))
+		len = sprintf(cmdline_ptr, "kstate_stream=0x0%lx@%ld ",
+			image->kstate_stream_addr, image->kstate_size);
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee310e200..b32c141ffcdd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -15,6 +15,7 @@
 #include <linux/init_ohci1394_dma.h>
 #include <linux/initrd.h>
 #include <linux/iscsi_ibft.h>
+#include <linux/kstate.h>
 #include <linux/memblock.h>
 #include <linux/panic_notifier.h>
 #include <linux/pci.h>
@@ -992,6 +993,7 @@ void __init setup_arch(char **cmdline_p)
 
 	memblock_set_current_limit(ISA_END_ADDRESS);
 	e820__memblock_setup();
+	kstate_init();
 
 	/*
 	 * Needs to run after memblock setup because it needs the physical
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..bd82f04888a1 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -299,6 +299,8 @@ struct kimage {
 	unsigned long start;
 	struct page *control_code_page;
 	struct page *swap_page;
+	unsigned long kstate_stream_addr;
+	size_t kstate_size;
 	void *vmcoreinfo_data_copy; /* locates in the crash memory */
 
 	unsigned long nr_segments;
diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index 4fc01e535bc0..ae583d090111 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -126,6 +126,8 @@ static inline unsigned long kstate_get_ulong(struct kstate_stream *stream)
 
 #ifdef CONFIG_KSTATE
 
+void kstate_init(void);
+
 int kstate_save_state(void);
 void free_kstate_stream(void);
 
@@ -137,14 +139,17 @@ int save_kstate(struct kstate_stream *stream, int id,
 		void *obj);
 void restore_kstate(struct kstate_stream *stream, int id,
 		const struct kstate_description *kstate, void *obj);
+int kstate_load_migrate_buf(struct kimage *image);
 
 #else
 
+static inline void kstate_init(void) { }
 #define kstate_register(state, obj)
 
 static inline int kstate_save_state(void) { return 0; }
 static inline void free_kstate_stream(void) { }
 
+static inline int kstate_load_migrate_buf(struct kimage *image) { return 0; }
 #endif
 
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..a024ff379133 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -14,6 +14,7 @@
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/kexec.h>
+#include <linux/kstate.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -253,6 +254,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
 
+	ret = kstate_load_migrate_buf(image);
+	if (ret)
+		goto out;
+
 	/* Call image load handler */
 	ldata = kexec_image_load_default(image);
 
diff --git a/kernel/kstate.c b/kernel/kstate.c
index a73a9a42e55b..d35996287b76 100644
--- a/kernel/kstate.c
+++ b/kernel/kstate.c
@@ -2,6 +2,7 @@
 #include <linux/ctype.h>
 #include <linux/kexec.h>
 #include <linux/kstate.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
@@ -182,6 +183,31 @@ int kstate_save_state(void)
 	return 0;
 }
 
+int kstate_load_migrate_buf(struct kimage *image)
+{
+	int ret;
+	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
+		.buf_max = ULONG_MAX, .top_down = true };
+
+	kbuf.bufsz = kstate_stream.size;
+	kbuf.buffer = kstate_stream.start;
+
+	kbuf.memsz = kstate_stream.size;
+
+	kbuf.buf_align = PAGE_SIZE;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		return ret;
+	image->kstate_stream_addr = kbuf.mem;
+	image->kstate_size = kstate_stream.size;
+
+	pr_info("kstate: Loaded mig_stream at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		kbuf.mem, kbuf.bufsz, kbuf.memsz);
+
+	return ret;
+}
+
 void restore_kstate(struct kstate_stream *stream, int id,
 		const struct kstate_description *kstate, void *obj)
 {
@@ -258,6 +284,9 @@ static void restore_migrate_state(unsigned long kstate_data,
 	}
 }
 
+static unsigned long kstate_stream_addr = -1;
+static unsigned long kstate_size;
+
 static void __kstate_register(struct kstate_description *state, void *obj,
 			struct state_entry *se)
 {
@@ -265,7 +294,7 @@ static void __kstate_register(struct kstate_description *state, void *obj,
 	se->id = atomic_inc_return(&state->instance_id);
 	se->obj = obj;
 	list_add(&se->list, &states);
-	restore_migrate_state(0 /*migrate_stream_addr*/, se);
+	restore_migrate_state(kstate_stream_addr, se);
 }
 
 int kstate_register(struct kstate_description *state, void *obj)
@@ -280,3 +309,21 @@ int kstate_register(struct kstate_description *state, void *obj)
 	return 0;
 }
 
+static int __init setup_kstate(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	kstate_stream_addr = memparse(arg, &end);
+	if (*end == '@')
+		kstate_size = memparse(end + 1, &end);
+
+	return end > arg ? 0 : -EINVAL;
+}
+early_param("kstate_stream", setup_kstate);
+
+void __init kstate_init(void)
+{
+	memblock_reserve(kstate_stream_addr, kstate_size);
+}
-- 
2.45.3


