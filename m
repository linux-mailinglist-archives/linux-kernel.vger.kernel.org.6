Return-Path: <linux-kernel+bounces-554144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0765A59369
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C07188B3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE32E227E96;
	Mon, 10 Mar 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="3N8MAR+n"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14D223323
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608280; cv=none; b=sz3QPbTo6WjgMTGOn+G2TKzAA6ATHmy8l1DtbCgh2Gdz7QaN/SU8Hg8K19DhE9uBQJmJqPke9CY9k1sepoa9KpjaGhLAHp+CGw0meWYZlRf/gAa7wmwoAUCcpqnExyDJr5ymzJBpgG5yovGmmQOIah9BcKSTY8NQ0gVFwRdYGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608280; c=relaxed/simple;
	bh=n3dgl6K4Adj0IvmwC1gJJjBtOyR4T3IlLIdrP+cQco4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNNlUOVhDhlwcBqPMhftFhzgEwhLjVkMCwVtWY6fav9+ZGK8RvJoLe9kziyYL2Qfe7+3M8HS6mPxzbFO0e3EA/j0ON5JVO7HQg5XnYxST54x0KnBRY0W6AWO62f+cALhFND0ZYWMJNpvciriyb/7y1XgxmNpA6vaROWQEVA/pTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=3N8MAR+n; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1ED3460EB2;
	Mon, 10 Mar 2025 15:04:17 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-HnZRPCd1;
	Mon, 10 Mar 2025 15:04:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608256;
	bh=yQbSR/IJoyQ0CM0slHnQK+Nqd9vWCYt9LC8hjrwd9hg=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=3N8MAR+n+0LltwNhIsUCsS4z9ZdlN3mVjT3YjhVxhQapXN9CB0W8hACTOOcCmQHqZ
	 mfYcPKoqXadSjs+nvISkRWgKPHTOWWT9SOuKc3vWVBZnWWdW6b1pj0AUVYfILPIgOg
	 7txAX17EwUCueYGi5I8why2gQaWxCynL+viNswMM=
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
Subject: [PATCH v2 7/7] kstate, test: add test module for testing kstate subsystem.
Date: Mon, 10 Mar 2025 13:03:18 +0100
Message-ID: <20250310120318.2124-8-arbn@yandex-team.com>
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

This is simple test and playground useful kstate subsystem development.
It contains some structure with different kind of data which migrated
across kexec to the new kernel using kstate.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h |  3 ++
 kernel/kstate.c        |  5 +++
 lib/Makefile           |  2 +
 lib/test_kstate.c      | 86 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 lib/test_kstate.c

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index 36cfefd87572..0bde76aa4d8f 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -90,6 +90,7 @@ struct kstate_field {
 enum kstate_ids {
 	KSTATE_RSVD_MEM_ID = 1,
 	KSTATE_STRUCT_PAGE_ID,
+	KSTATE_TEST_ID,
 	KSTATE_LAST_ID = -1,
 };
 
@@ -132,6 +133,8 @@ extern struct kstate_description page_state;
 
 void kstate_init(void);
 
+bool is_kstate_kernel(void);
+
 int kstate_save_state(void);
 void free_kstate_stream(void);
 
diff --git a/kernel/kstate.c b/kernel/kstate.c
index 68a1272abceb..3d9b786da72a 100644
--- a/kernel/kstate.c
+++ b/kernel/kstate.c
@@ -287,6 +287,11 @@ static void restore_migrate_state(unsigned long kstate_data,
 static unsigned long kstate_stream_addr = -1;
 static unsigned long kstate_size;
 
+bool is_kstate_kernel(void)
+{
+	return kstate_stream_addr != -1;
+}
+
 static void __kstate_register(struct kstate_description *state, void *obj,
 			struct state_entry *se)
 {
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..1395b852b58d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -356,6 +356,8 @@ obj-$(CONFIG_PARMAN) += parman.o
 
 obj-y += group_cpus.o
 
+obj-$(CONFIG_KSTATE) += test_kstate.o
+
 # GCC library routines
 obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
 obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
diff --git a/lib/test_kstate.c b/lib/test_kstate.c
new file mode 100644
index 000000000000..1d9feb017415
--- /dev/null
+++ b/lib/test_kstate.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/io.h>
+#include <linux/kstate.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+static unsigned long ulong_val;
+struct kstate_test_data {
+	int i;
+	unsigned long *p_ulong;
+	char s[10];
+	struct page *page;
+};
+
+struct kstate_description test_state = {
+	.name = "test",
+	.version_id = 1,
+	.id = KSTATE_TEST_ID,
+	.state_list = LIST_HEAD_INIT(test_state.state_list),
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
+		KSTATE_BASE_TYPE(s, struct kstate_test_data, char [10]),
+		KSTATE_POINTER(p_ulong, struct kstate_test_data),
+		KSTATE_PAGE(page, struct kstate_test_data),
+		KSTATE_END_OF_LIST()
+	},
+};
+
+static struct kstate_test_data test_data;
+
+static int init_test_data(void)
+{
+	struct page *page;
+	int i;
+
+	test_data.i = 10;
+	ulong_val = 20;
+	memcpy(test_data.s, "abcdefghk", sizeof(test_data.s));
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	for (i = 0; i < PAGE_SIZE/4; i += 4)
+		*((u32 *)page_address(page) + i) = 0xdeadbeef;
+	test_data.page = page;
+	return 0;
+}
+
+static void validate_test_data(void)
+{
+	int i;
+
+	if (WARN_ON(test_data.i != 10))
+		return;
+	if (WARN_ON(*test_data.p_ulong != 20))
+		return;
+	if (WARN_ON(strcmp(test_data.s, "abcdefghk") != 0))
+		return;
+
+	for (i = 0; i < PAGE_SIZE/4; i += 4) {
+		u32 val = *((u32 *)page_address(test_data.page) + i);
+
+		WARN_ON(val != 0xdeadbeef);
+	}
+}
+
+static int __init test_kstate_init(void)
+{
+	int ret = 0;
+
+	test_data.p_ulong = &ulong_val;
+
+	if (!is_kstate_kernel()) {
+		ret = init_test_data();
+		if (ret)
+			goto out;
+	}
+
+	kstate_register(&test_state, &test_data);
+
+	validate_test_data();
+
+out:
+	return ret;
+}
+__initcall(test_kstate_init);
-- 
2.45.3


