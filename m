Return-Path: <linux-kernel+bounces-186993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0779E8CCBA3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0986D1C21339
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0C13B7AC;
	Thu, 23 May 2024 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K49Ezcyn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BC13AD3E
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440720; cv=none; b=GYk+2huhTBJZXQhPmziR/iZmP1dm5ehdYuRdyuxBXzTrUZ7WLGYW7T6wmfNdjC9h16RMAaiorkP+bhgs2mmP5V+/vykxbXIJcIA1Op6/nsHhkI2RghxS/ktZ0UcH6RFYenNMQNJuf8maWsNXjEIOt5b7Q1+YLnhM5PKe1flVoX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440720; c=relaxed/simple;
	bh=mRkvD1MTPK2PgSmvjbHdBMgWLQtsN1Xd8k5RmXh9UMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTF3+DMGAWBH72gvSlYIjeDLhYFEShlBQr+wEtxmRSYzoLreoSTnIehxm3KvTE1p/FI5ErZ3YR3wCd0PD/FS8S7dnPd3iuT1p4d7M7EjSMhivlTwaoE33COqfhqeV10dcw6bOzxIcSZL81eP7c4p47GNv9rFCNO1OGoTY+J8Pj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K49Ezcyn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fa72I6mP4bkKPgXlioSXRQnIrhjQErXvO71QcCop5iA=;
	b=K49EzcynPQ5QWmcVqTEOZKUkcMij6pAyTw9c6Gd0siB+MX3gtW9Sbw8fMqU707UvpYPebS
	UVQf44DL8SlmI2mxvpr67iP/OFYt46/yrNfqQGUrLIVd+E4SHmAMgSANPa7Qkq50X+JJE5
	teNIgAu0TrmKTfRA8SFJW6GmzR81VqY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Zkh4evz-O8G29H9WSwixJg-1; Thu, 23 May 2024 01:05:16 -0400
X-MC-Unique: Zkh4evz-O8G29H9WSwixJg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ed90e91d3cso146589835ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440715; x=1717045515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa72I6mP4bkKPgXlioSXRQnIrhjQErXvO71QcCop5iA=;
        b=oySwe/Oj/eZkdrJCOLS6fm3eAABLwDYKQmdd///Z6wbR1OSQqu5cUzNS9g6XPROo0u
         WoEGS4Sv8+LwDokq7S66A5SL1tM9YL8bQ6hD0RfLvx5VSMBP+T/B3PtoFxKK8P3lq56E
         QNuxR3GkBSfx8aguNoJH2GW48yEEq4yXFD8GELDyuKFEbBf/CRvIGNFAt/ZVJdn2u1KU
         p1L1pL2AAuZoGtvFQ73+wbXaMLG+C2JShxFIAMWIHgRPeAqEK1/DA2fktCRtn+6xUluQ
         C+Rif2aSl6jhhniHLxhanYvoO4/YyoOF8ipZUZhg2Lj61DI4M9/u1XClhGaHrlQop109
         GFDw==
X-Forwarded-Encrypted: i=1; AJvYcCUi9VCaHyCXxTrEJphB7wPj+sLc9eGVjfpnvk2jB3EZCAxtvGQXlfr8pjYGBred+vwsSWt4f2YZ5a3gqyFwTfL5K+S5AtU+k1ZCB3Ah
X-Gm-Message-State: AOJu0YzyIjyY/eog4DyOxzD0GXp831l163lZMkgDeCmTwTQzXdxDceaL
	YSUV/a72d41z2APvPePjo+GtA9JsHHvo9xYQfg4vw6iw+IxO0GI9HLIrKQagazFDiNwiXfntvUm
	jUwv7q+pkK860+AVlbFeKxw1aLpEZpLpZLpQj3WZhZrDo5TqnjSHVQnm/5XIGfg==
X-Received: by 2002:a17:902:ff0a:b0:1ee:a09e:c7b0 with SMTP id d9443c01a7336-1f31c98db57mr32586285ad.37.1716440715014;
        Wed, 22 May 2024 22:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHesrH0cqL5v8PGClCEwXynBSxt1oIPal3K2H0JK1dua8ax6gHHJh4QCElpHvpZJQCyMDnSkw==
X-Received: by 2002:a17:902:ff0a:b0:1ee:a09e:c7b0 with SMTP id d9443c01a7336-1f31c98db57mr32586005ad.37.1716440714356;
        Wed, 22 May 2024 22:05:14 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f336103357sm7676865ad.128.2024.05.22.22.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:13 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v4 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Thu, 23 May 2024 13:04:46 +0800
Message-ID: <20240523050451.788754-6-coxu@redhat.com>
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

Crash kernel will retrieve the dm crypt keys based on the dmcryptkeys
command line parameter. When user space writes the key description to
/sys/kernel/crash_dm_crypt_key, the crash kernel will save the
encryption keys to the user keyring. Then user space e.g. cryptsetup's
--volume-key-keyring API can use it to unlock the encrypted device.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |  1 +
 kernel/crash_dump_dm_crypt.c | 99 +++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index ab20829d0bc9..d7308b6e83f4 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -38,6 +38,7 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
 int crash_sysfs_dm_crypt_keys_read(char *buf);
 int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
 int crash_load_dm_crypt_keys(struct kimage *image);
+ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
 #else
 static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index b4dc881cc867..dd818581858b 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -33,12 +33,67 @@ static struct keys_header {
 	struct dm_crypt_key keys[] __counted_by(key_count);
 } *keys_header;
 
+unsigned long long dm_crypt_keys_addr;
+EXPORT_SYMBOL_GPL(dm_crypt_keys_addr);
+
+static int __init setup_dmcryptkeys(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	dm_crypt_keys_addr = memparse(arg, &end);
+	if (end > arg)
+		return 0;
+
+	dm_crypt_keys_addr = 0;
+	return -EINVAL;
+}
+
+early_param("dmcryptkeys", setup_dmcryptkeys);
+
 static size_t get_keys_header_size(struct keys_header *keys_header,
 				   size_t key_count)
 {
 	return struct_size(keys_header, keys, key_count);
 }
 
+/*
+ * Architectures may override this function to read dm crypt key
+ */
+ssize_t __weak dm_crypt_keys_read(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	return read_from_oldmem(&iter, count, ppos, false);
+}
+
+static int add_key_to_keyring(struct dm_crypt_key *dm_key,
+			      key_ref_t keyring_ref)
+{
+	key_ref_t key_ref;
+	int r;
+
+	/* create or update the requested key and add it to the target keyring */
+	key_ref = key_create_or_update(keyring_ref, "user", dm_key->key_desc,
+				       dm_key->data, dm_key->key_size,
+				       KEY_USR_ALL, KEY_ALLOC_IN_QUOTA);
+
+	if (!IS_ERR(key_ref)) {
+		r = key_ref_to_ptr(key_ref)->serial;
+		key_ref_put(key_ref);
+		pr_alert("Success adding key %s", dm_key->key_desc);
+	} else {
+		r = PTR_ERR(key_ref);
+		pr_alert("Error when adding key");
+	}
+
+	key_ref_put(keyring_ref);
+	return r;
+}
+
 static int init(const char *buf)
 {
 	unsigned int total_keys;
@@ -120,11 +175,53 @@ static int process_cmd(const char *buf, size_t count)
 	return -EINVAL;
 }
 
+static int restore_dm_crypt_keys_to_thread_keyring(const char *key_desc)
+{
+	struct dm_crypt_key *key;
+	key_ref_t keyring_ref;
+	u64 addr;
+
+	/* find the target keyring (which must be writable) */
+	keyring_ref =
+		lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
+	if (IS_ERR(keyring_ref)) {
+		pr_alert("Failed to get keyring");
+		return PTR_ERR(keyring_ref);
+	}
+
+	addr = dm_crypt_keys_addr;
+	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
+	if (key_count < 0 || key_count > KEY_NUM_MAX) {
+		pr_info("Failed to the number of dm_crypt keys\n");
+		return -1;
+	}
+
+	pr_debug("There are %u keys\n", key_count);
+	addr = dm_crypt_keys_addr;
+
+	keys_header_size = get_keys_header_size(keys_header, key_count);
+
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
+
+	for (int i = 0; i < keys_header->key_count; i++) {
+		key = &keys_header->keys[i];
+		pr_alert("Get key (size=%u): %8ph...\n", key->key_size, key->data);
+		add_key_to_keyring(key, keyring_ref);
+	}
+
+	return 0;
+}
+
 int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count)
 {
 	if (!is_kdump_kernel())
 		return process_cmd(buf, count);
-	return -EINVAL;
+	else
+		return restore_dm_crypt_keys_to_thread_keyring(buf);
 }
 EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_write);
 
-- 
2.45.0


