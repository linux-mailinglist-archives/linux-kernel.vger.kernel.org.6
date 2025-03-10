Return-Path: <linux-kernel+bounces-554142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DA0A59366
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2471681F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA1227BA1;
	Mon, 10 Mar 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="tKVDYRr1"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE722172E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608279; cv=none; b=qU+MhnIKPhuILfGNaCBM31SIjCczcsBeLCKsahauQn13ZX/vhP4neJ0DAms44XG7fZUeXmN+AagwvTCLK4Zm6aTIlVLvgw0Ktg9yEDBXg1kOR6GALckQA55wyz0pcSYEBX6bXMghs7B9hkjRf0WIK4dtTzmuFnNZr9BI9gj6OX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608279; c=relaxed/simple;
	bh=2vklyyA3ErRN0JV+jV70G8ZrirPgj1dr+ngipHvmLnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyqdxsGaGy1c8PE5T0SGY2kO+zB4k2ktCoTLUX0hGJdMOqbI7mqPnjVr5fqdsdlV6VwAii57Ns/S77x3VMt/mgezaZFJYz9RQ8pMFjhf3qTuHDs7hFjl3iZQIlufSbJfMdna8Rzha9eugB+ytCu1RDvSyYFBxV34BzEFZIPqezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=tKVDYRr1; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D8CAE60EAF;
	Mon, 10 Mar 2025 15:04:12 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-nBaQjWYT;
	Mon, 10 Mar 2025 15:04:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608252;
	bh=9sCYhPB2JXvpHRR7mGAnOD5wFhzVOzlRXeW9jewkrPs=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=tKVDYRr1Fc9PZMG5kcffLo5ML52XYvjB9fT2RP6/B4ZrI68qC5XErlG3jfkkQS0xQ
	 LrPykZVjqAxqEQcIvjW8Q1fYRGUY3Nxe3UrpdFO1uG7CnyBvoqCzCxivetoS5oBrG4
	 Z3/CxdprsbnC7nsU6PIIrdFT3yANX6Z3kGq3BFqU=
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
Subject: [PATCH v2 5/7] x86, kstate: Add the ability to preserve memory pages across kexec.
Date: Mon, 10 Mar 2025 13:03:16 +0100
Message-ID: <20250310120318.2124-6-arbn@yandex-team.com>
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

This adds ability to specify page of memory that kstate needs to
preserve across kexec.

kstate_register_page() stores struct page in the special list of
'struct kpage_state's. At kexec reboot stage this list iterated, pfns
saved into kstate's data stream. The new kernel after kexec reads
pfns from the stream and marks memory as reserved to keep it
intact.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h |  30 ++++++++++
 kernel/kexec_core.c    |   3 +-
 kernel/kstate.c        | 124 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index ae583d090111..36cfefd87572 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -88,6 +88,8 @@ struct kstate_field {
 };
 
 enum kstate_ids {
+	KSTATE_RSVD_MEM_ID = 1,
+	KSTATE_STRUCT_PAGE_ID,
 	KSTATE_LAST_ID = -1,
 };
 
@@ -124,6 +126,8 @@ static inline unsigned long kstate_get_ulong(struct kstate_stream *stream)
         return ret;
 }
 
+extern struct kstate_description page_state;
+
 #ifdef CONFIG_KSTATE
 
 void kstate_init(void);
@@ -141,6 +145,12 @@ void restore_kstate(struct kstate_stream *stream, int id,
 		const struct kstate_description *kstate, void *obj);
 int kstate_load_migrate_buf(struct kimage *image);
 
+int kstate_page_save(struct kstate_stream *stream, void *obj,
+		const struct kstate_field *field);
+int kstate_register_page(struct page *page, int order);
+
+bool kstate_range_is_preserved(unsigned long start, unsigned long end);
+
 #else
 
 static inline void kstate_init(void) { }
@@ -150,6 +160,11 @@ static inline int kstate_save_state(void) { return 0; }
 static inline void free_kstate_stream(void) { }
 
 static inline int kstate_load_migrate_buf(struct kimage *image) { return 0; }
+
+static inline bool kstate_range_is_preserved(unsigned long start,
+					unsigned long end)
+{ return 0; }
+
 #endif
 
 
@@ -176,6 +191,21 @@ static inline int kstate_load_migrate_buf(struct kimage *image) { return 0; }
 		.offset = offsetof(_state, _f),		\
 	}
 
+#define KSTATE_PAGE(_f, _state)				\
+	{						\
+		.name = "page",				\
+		.flags = KS_CUSTOM,			\
+		.offset = offsetof(_state, _f),		\
+		.save = kstate_page_save,		\
+	},						\
+	KSTATE_ADDRESS(_f, _state, KS_VMEMMAP_ADDR),	\
+	{ 						\
+		.name = "struct_page",			\
+		.flags = KS_STRUCT | KS_POINTER,	\
+		.offset = offsetof(_state, _f),		\
+		.ksd = &page_state,			\
+	}
+
 #define KSTATE_END_OF_LIST() {	\
 		.flags = KS_END,\
 	}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 7c79addeb93b..5d001b7a9e44 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/kexec.h>
+#include <linux/kstate.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
@@ -261,7 +262,7 @@ int kimage_is_destination_range(struct kimage *image,
 			return 1;
 	}
 
-	return 0;
+	return kstate_range_is_preserved(start, end);
 }
 
 int kimage_is_control_page(struct kimage *image,
diff --git a/kernel/kstate.c b/kernel/kstate.c
index d35996287b76..68a1272abceb 100644
--- a/kernel/kstate.c
+++ b/kernel/kstate.c
@@ -309,6 +309,13 @@ int kstate_register(struct kstate_description *state, void *obj)
 	return 0;
 }
 
+int kstate_page_save(struct kstate_stream *stream, void *obj,
+		const struct kstate_field *field)
+{
+	kstate_register_page(*(struct page **)obj, 0);
+	return 0;
+}
+
 static int __init setup_kstate(char *arg)
 {
 	char *end;
@@ -323,7 +330,124 @@ static int __init setup_kstate(char *arg)
 }
 early_param("kstate_stream", setup_kstate);
 
+/*
+ * TODO: probably should use folio instead/in addition,
+ * also will need to think/decide what fields
+ * to preserve or not
+ */
+struct kstate_description page_state = {
+	.name = "struct_page",
+	.id = KSTATE_STRUCT_PAGE_ID,
+	.state_list = LIST_HEAD_INIT(page_state.state_list),
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(_mapcount, struct page, atomic_t),
+		KSTATE_BASE_TYPE(_refcount, struct page, atomic_t),
+		KSTATE_END_OF_LIST()
+	},
+};
+
+struct state_entry preserved_se;
+
+struct preserved_pages {
+	unsigned int nr_pages;
+	struct list_head list;
+};
+struct kpage_state {
+	struct list_head list;
+	u8 order;
+	struct page *page;
+};
+
+struct preserved_pages preserved_pages = {
+	.list = LIST_HEAD_INIT(preserved_pages.list)
+};
+
+int kstate_register_page(struct page *page, int order)
+{
+	struct kpage_state *state;
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	state->page = page;
+	state->order = order;
+	list_add(&state->list, &preserved_pages.list);
+	preserved_pages.nr_pages++;
+	return 0;
+}
+
+static int kstate_pages_save(struct kstate_stream *stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct kpage_state *p_state;
+	int ret;
+
+	list_for_each_entry(p_state, &preserved_pages.list, list) {
+		unsigned long paddr = page_to_phys(p_state->page);
+
+		ret = kstate_save_data(stream, &p_state->order,
+				sizeof(p_state->order));
+		if (ret)
+			return ret;
+		ret = kstate_save_data(stream, &paddr, sizeof(paddr));
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+bool kstate_range_is_preserved(unsigned long start, unsigned long end)
+{
+	struct kpage_state *p_state;
+
+	list_for_each_entry(p_state, &preserved_pages.list, list) {
+		unsigned long pstart, pend;
+		pstart = page_to_boot_pfn(p_state->page);
+		pend = pstart + (p_state->order << PAGE_SHIFT) - 1;
+		if ((end >= pstart) && (start <= pend))
+			return 1;
+	}
+	return 0;
+}
+
+static int __init kstate_pages_restore(struct kstate_stream *stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct preserved_pages *preserved_pages = obj;
+	int nr_pages, i;
+
+	nr_pages = preserved_pages->nr_pages;
+	for (i = 0; i < nr_pages; i++) {
+		int order = kstate_get_byte(stream);
+		unsigned long phys = kstate_get_ulong(stream);
+
+		memblock_reserve(phys, PAGE_SIZE << order);
+	}
+	return 0;
+}
+
+struct kstate_description kstate_preserved_mem = {
+	.name = "preserved_range",
+	.id = KSTATE_RSVD_MEM_ID,
+	.state_list = LIST_HEAD_INIT(kstate_preserved_mem.state_list),
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(nr_pages, struct preserved_pages, unsigned int),
+		{
+			.name = "pages",
+			.flags = KS_CUSTOM,
+			.size = sizeof(struct preserved_pages),
+			.save = kstate_pages_save,
+			.restore = kstate_pages_restore,
+		},
+
+		KSTATE_END_OF_LIST()
+	},
+};
+
 void __init kstate_init(void)
 {
 	memblock_reserve(kstate_stream_addr, kstate_size);
+	__kstate_register(&kstate_preserved_mem, &preserved_pages,
+			&preserved_se);
 }
-- 
2.45.3


