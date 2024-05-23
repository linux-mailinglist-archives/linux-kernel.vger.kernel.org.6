Return-Path: <linux-kernel+bounces-186991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B755E8CCBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE48A1C214E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC313B5AE;
	Thu, 23 May 2024 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKAbZAlW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687113B59A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440713; cv=none; b=Pdj0cwgvlXn9f/KvqU9wJis10Qno0QirkU+m/RPnf8yQwRFGZMksOtL2d+BtRDGIVLs/ebtbsdpsJRAKTnMTrNni2ZCzRxmN2LObouoPadLCdEPg4v/l9L0nJS0ayvH7ES8gKD4tOOHr+V7B+XMwxj9l97f316KjEBrFB9b1fYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440713; c=relaxed/simple;
	bh=X6sZr2fT7RV3LOGsviKdoHFeDJZA0N4rJIfYh0VRjPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbydFju6qE/MUTEaQh7cGQOeIYDR0J4y+cqpaVVeQ1H2KlvlHQAzT/L5dYOQJIwnnsu4EZ5dD2QbgBKw+N7fvVDOSQjn+2D9xQmiGaULa1dc7ewIi/0yKQ1K7saN7Rmx1sCYdaG22y4UrrNy+lU+hpOLvqsL5MgR3dwWaXk6iQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKAbZAlW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18YOd0+Wa5jPqylPxPMlv7Y+0C4u9S8TvIRTMzUpGf0=;
	b=OKAbZAlW5cXOgokJ3gbxocU88QZzj4yfWL5PyM1ZKmEmMM4zLGqyBGuaennSBY/doIrdVQ
	JG5ccJueXuOvl9fAfUHtvOz2Fl7UG0I5/MHHyRWG7BLDl50FOo4Y9r9OEIOUo8ndAmwyXp
	w1N04hxj+GuxGUtmHFE3JVAC//4Bhrk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-BGn624C4MpO0es6TEjC2Tg-1; Thu, 23 May 2024 01:05:08 -0400
X-MC-Unique: BGn624C4MpO0es6TEjC2Tg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f31943bee9so18000805ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440707; x=1717045507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18YOd0+Wa5jPqylPxPMlv7Y+0C4u9S8TvIRTMzUpGf0=;
        b=sNQXMtaIrpKu1kDXulrRFF91Z1otVEdmAVdSZL5gyw2tTAVLpLnq0gb2aQFoDoYA65
         GKYwoDHJBrrvrenhueSCWanEVIGMIii1MlN578UZG+/2eG0r3njjlxo4e6NRPi4/WrOj
         Zx/zo+EQ3LZmad3Jd3kF3ZnlQMPSVmocYkW6UWugstYrDvlbJ0eWcq7d5CTVSedl8YV/
         6bQrAsYzRMa8vlEXnRrH7QMxBkF/R3B5OilpKRAGe7Bl7ZH7TdghUxzMyiCaAIdiJub4
         Tk1JPJ2t/6pQSzjx19yIMxALrdIYg3kIn145XK30rCxvCeQjnt5yg5pegnO9vlRWDzCY
         cJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+FwrntZVxoBsC5xDLsvnk2RCQ627J7deHpa1SLN9LNfpKTf6jb1eKyOV0stzQ8HdU0tJ0/s9FWhh7z5zaxSv7JzwdRxpoFkWixR0h
X-Gm-Message-State: AOJu0YwdtSfAP5gWbaGp867hbElBMNI87R5cOLDuGzRapdRwIl6+4rN/
	+D83b9JstojOy/yqsXkMGt/6pasjsY31AG+Yl+cHLp9UQ3VosZGsKFNmUGONpftmEp8UlWHF1yx
	83cxqNty5VbgHGuh6XS27B53ZOJMBm21rdAXYhkDYT06Fw8VhibRe8SWxAgl7bg==
X-Received: by 2002:a17:902:db11:b0:1f3:39d9:b2c3 with SMTP id d9443c01a7336-1f339d9b4d2mr17003675ad.50.1716440707024;
        Wed, 22 May 2024 22:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRzZMAyDpsUmfR6YQ3M3Cp6U7ziKK4PidDnLj0rz4oSMtKMe54QBcMLcgMyZ5mWzKqYrss7g==
X-Received: by 2002:a17:902:db11:b0:1f3:39d9:b2c3 with SMTP id d9443c01a7336-1f339d9b4d2mr17003275ad.50.1716440706265;
        Wed, 22 May 2024 22:05:06 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f34076df6asm3603595ad.37.2024.05.22.22.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:05 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
Date: Thu, 23 May 2024 13:04:44 +0800
Message-ID: <20240523050451.788754-4-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
References: <20240523050451.788754-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kdump kernel image and initrd are loaded, the dm crypts keys
will be read from keyring and then stored in kdump reserved memory.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |  3 ++
 include/linux/crash_dump.h   |  2 +
 include/linux/kexec.h        |  4 ++
 kernel/crash_dump_dm_crypt.c | 87 ++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 6bff1c24efa3..ab20829d0bc9 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -37,6 +37,9 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
 #ifdef CONFIG_CRASH_DM_CRYPT
 int crash_sysfs_dm_crypt_keys_read(char *buf);
 int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
+int crash_load_dm_crypt_keys(struct kimage *image);
+#else
+static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
 
 #ifndef arch_crash_handle_hotplug_event
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index acc55626afdc..dfd8e4fe6129 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -15,6 +15,8 @@
 extern unsigned long long elfcorehdr_addr;
 extern unsigned long long elfcorehdr_size;
 
+extern unsigned long long dm_crypt_keys_addr;
+
 #ifdef CONFIG_CRASH_DUMP
 extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index cc81b8a903ab..bd40f4208e1f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -370,6 +370,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* dm crypt keys buffer */
+	unsigned long dm_crypt_keys_addr;
+	unsigned long dm_crypt_keys_sz;
 };
 
 /* kexec interface functions */
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 78809189084a..89fec768fba8 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 
@@ -111,3 +113,88 @@ int crash_sysfs_dm_crypt_keys_read(char *buf)
 	return sprintf(buf, "%s\n", STATE_STR[state]);
 }
 EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
+
+static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+	pr_debug("Requesting key %s", dm_key->key_desc);
+	key = request_key(&key_type_logon, dm_key->key_desc, NULL);
+
+	if (IS_ERR(key)) {
+		pr_warn("No such key %s\n", dm_key->key_desc);
+		return PTR_ERR(key);
+	}
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp)
+		return -EKEYREVOKED;
+
+	memcpy(dm_key->data, ukp->data, ukp->datalen);
+	dm_key->key_size = ukp->datalen;
+	pr_debug("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
+		 dm_key->key_desc, dm_key->data);
+	return 0;
+}
+
+static int build_keys_header(void)
+{
+	int i, r;
+
+	for (i = 0; i < key_count; i++) {
+		r = read_key_from_user_keying(&keys_header->keys[i]);
+		if (r != 0) {
+			pr_err("Failed to read key %s\n", keys_header->keys[i].key_desc);
+			return r;
+		}
+	}
+
+	return 0;
+}
+
+int crash_load_dm_crypt_keys(struct kimage *image)
+{
+	struct kexec_buf kbuf = {
+		.image = image,
+		.buf_min = 0,
+		.buf_max = ULONG_MAX,
+		.top_down = false,
+		.random = true,
+	};
+
+	int r;
+
+	if (state == FRESH)
+		return 0;
+
+	if (key_count != keys_header->key_count) {
+		pr_err("Only record %u keys (%u in total)\n", key_count,
+		       keys_header->key_count);
+		return -EINVAL;
+	}
+
+	image->dm_crypt_keys_addr = 0;
+	r = build_keys_header();
+	if (r)
+		return r;
+
+	kbuf.buffer = keys_header;
+	kbuf.bufsz = keys_header_size;
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	r = kexec_add_buffer(&kbuf);
+	if (r) {
+		kvfree((void *)kbuf.buffer);
+		return r;
+	}
+	state = LOADED;
+	image->dm_crypt_keys_addr = kbuf.mem;
+	image->dm_crypt_keys_sz = kbuf.bufsz;
+	pr_debug("Loaded dm crypt keys at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 image->dm_crypt_keys_addr, kbuf.bufsz, kbuf.bufsz);
+
+	return r;
+}
-- 
2.45.0


