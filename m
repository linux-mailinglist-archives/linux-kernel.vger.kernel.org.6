Return-Path: <linux-kernel+bounces-206034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BE6900387
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C9E1C21592
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ECC194AD0;
	Fri,  7 Jun 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/9WDXCT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D605194A44
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763216; cv=none; b=FXW7WdCcmL9XT2WToPovyQLxLGy48w+W4G72ry+u8DkOTSrxAedOfnKBf2l3Xz2yZfIaKdHGSB4+Oj7lsGj5Pk5DA4lMZC/fE0hnT2r9E8W10wkTEOnpxbPITWT7kn4jEK+twKCZWBbNMnol1WSSXQohYxfVQrUSEOjBnitVaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763216; c=relaxed/simple;
	bh=SbX0OWmkyiQ25VmAS101r+rK0t4HDEEZ6y+7sHI5W3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5LDKPMwksC1invN3nc1XpFLOBO6FrCvRX/erWH0XJ/FguoaAONUj3p6d8lzZ7xnJoZhUF9tHMa7G6rBrXrMqX8gQew90PH8qsBwdqzp8WAbCBzgol7GJkcWaBUc4OGURjJFaArJAngESM6qFiWSZMEJQ9bxLrxCTujQiCEstrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/9WDXCT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NY6MlWJnYNHj2CGE0jYmgrV3LdjseoctScg0CAsxuF4=;
	b=d/9WDXCTmzlz+pMy/n9CShk4AHQc8+254rgrSBmTVHWX5p11ic3SZWGYJvVNFzXwyA9OU4
	XspscSdXZPxl2aIpsXkGbgQFePycAHY59UVs++DkdJtGQUQ/dEZYM/BKZuk2c7+82IOEp7
	+vs3Cpv4cG/emxQ2pxe5M6FFwjNqkIw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-x4UoXJ6lOAuGsjj1Cvn1Xg-1; Fri, 07 Jun 2024 08:26:46 -0400
X-MC-Unique: x4UoXJ6lOAuGsjj1Cvn1Xg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-66348aafadcso1675069a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763205; x=1718368005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY6MlWJnYNHj2CGE0jYmgrV3LdjseoctScg0CAsxuF4=;
        b=WXQ0NsBf/19hD1LuA4/ci61wrvFBuq9GWP8mo7ZEBZ4bc7F6YN3Nuksu/5hx+EaO2+
         PoBMhEKo4h48nb2/iCk8Q7NjagyThTU8EMRJoLUWMhToOlHF72X5WsodY01sC/1idNSV
         RTKWBeL01fSSY+5WCwsL3aMQfUcaWm/5GziF4P3yhR/r931GB9VtbYnb50Xao4Jo1JOD
         ScRPloMNBnN87WAhLGGz0mPRsYNdnXoNOWIb/+q8IPgT2FYB0XIv5h5Vk6066mFc/D/S
         Lx9antzG+Z70e8r7bAV29HbhFPOCBjWtfpwRZRn/MRKW8ZePmCmZ4IEaAEkF+zEiNlHY
         4QIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvZr2gTm39jyVWv3VExx51IphE2xR5crRO0Nw+grys4Ypl8+0MohHHu0zC1y/maTg45qXg9erLYJuxqN6+W4x9LOvY4m6TwVPkCm7T
X-Gm-Message-State: AOJu0Yzu7d/hVyrHNEC/kr/HYnZ5jqmO2c6IYC2T9elpqKuEN6Q4XjKP
	XWQncHpuPHtjE0evaJfR1E6rzwLE6b/eTwILzEIWfaVFORK1aw/dTsFd/35o/5F71PtaC/95LOd
	VagBg9fRZiT/LBmDBwb7GeFahnDmp8t+anQ2QjVnWbltZXQkYgzxIqYxqouG2sg==
X-Received: by 2002:a17:903:32d2:b0:1f6:39d8:dc4f with SMTP id d9443c01a7336-1f6d02c0542mr26932975ad.10.1717763204577;
        Fri, 07 Jun 2024 05:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpdAyFSQcoxBOdQJBinBNNpDMf5FnhUP8x16FFmg6d0auNXsy7A03SjZ++vuIxTUa+Qb9LFA==
X-Received: by 2002:a17:903:32d2:b0:1f6:39d8:dc4f with SMTP id d9443c01a7336-1f6d02c0542mr26932625ad.10.1717763203770;
        Fri, 07 Jun 2024 05:26:43 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7eddf1sm33133565ad.249.2024.06.07.05.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:43 -0700 (PDT)
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
	Greg KH <gregkh@linuxfoundation.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v5 3/7] crash_dump: store dm crypt keys in kdump reserved memory
Date: Fri,  7 Jun 2024 20:26:13 +0800
Message-ID: <20240607122622.167228-4-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
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
index c45bfc727737..cb6275928fbd 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -372,6 +372,10 @@ struct kimage {
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
index 608bde3aaa8e..0033152668ae 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 
@@ -128,3 +130,88 @@ int crash_sysfs_dm_crypt_keys_read(char *buf)
 	return sysfs_emit(buf, "%s\n", STATE_STR[state]);
 }
 EXPORT_SYMBOL_GPL(crash_sysfs_dm_crypt_keys_read);
+
+static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+	kexec_dprintk("Requesting key %s", dm_key->key_desc);
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
+	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
+		      dm_key->key_desc, dm_key->data);
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
+	if (key_count != keys_header->total_keys) {
+		kexec_dprintk("Only record %u keys (%u in total)\n", key_count,
+			      keys_header->total_keys);
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
+	kexec_dprintk("Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
+		      kbuf.bufsz, kbuf.bufsz);
+
+	return r;
+}
-- 
2.45.1


