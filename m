Return-Path: <linux-kernel+bounces-206035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2100900388
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209391F2710A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12220194A44;
	Fri,  7 Jun 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7lTZuiJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA4194C79
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763220; cv=none; b=Doch5x8oekm7mEpDqj0YWZvClAd55dLR9cDMxztea4O+GVl8F4tAdqF7Rwl6p2gUZfBPhGqP18r7AwbJx26hCcN02FzUs4GRrajn5ls2KO4JyQhn7pG2AvENT99U21YLU3wNUQAdq/1Ixo3EwaqR4zU4GHO+gtKzcrfgKVoMoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763220; c=relaxed/simple;
	bh=xldUFfQCLaHrWyRsZ3+WqfDxiKs8c6FyPyEYApGXNho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQv+Tyv7m2RW1l5qGalhkw9SVQtLy7QEfKk1CL2XlklZxeYapXbwTTKVxSr5AUhye7mxL2tb5c1axOWvEzLKYRu/D7XxvyKlpUy7JiXknsTkd2PvisJk8AeGjZkCQIaN3OUy4kuI/7bNBzZbK+uACwlupoC1nqBOjmxFwoZxfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7lTZuiJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnrGjun192AtksvBWoEeo2xFayBkQDU9eM35Zfke7SA=;
	b=A7lTZuiJMeJUmON1183D1aW+0UYNZxPtPUqv12nqxUKAbPYIWsdBX2+UiY9IbSAMEyizVL
	/5l9RJ8qwvOVMyWSYK2vd6GtKrbUj2ILuw7BV0d7AEYfV0Df7C9ttt6M+NlTlbZtwMZLkt
	X1aYqdLpYHO/Lev2m4umDN3SLGQSDWg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-cHoI0TsNNKCrlYYabjyqMA-1; Fri, 07 Jun 2024 08:26:56 -0400
X-MC-Unique: cHoI0TsNNKCrlYYabjyqMA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1e9951604so1765215a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763215; x=1718368015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnrGjun192AtksvBWoEeo2xFayBkQDU9eM35Zfke7SA=;
        b=MJkO2Y0MujKpNfkeAprcX0OSBmXPaNxq8Zt3SMf5mVH7bCBooMXWZbM3OCZvjF1mfH
         sM11tdVLd37Nk10MgLeSk9l3mx73Dqo7HyiyhTrJS9myVLJwij/xMRgvqjqF4GQ4wyR0
         1T+95SOYMQSeo1Y7ZrRQ2E4gQDb5FtAq3NNpX29+bbNhB+YriCMwyHg2+33xVahVXc/b
         9A1gExTSow8o9zVZ04WTa1msLvRa5BJQQ0maaaHc+QHWPHPAF5Sm3vJXwLnN3aqlI7Xw
         AQoiJzcTztzZmEoW2aMjGAkTvawlgK2R+Adywhu6swgRAvtzD2j3CHVDWoBkKwI8FvIX
         KxKA==
X-Forwarded-Encrypted: i=1; AJvYcCW7+nX7GqUAta7HrGwEWbGfi5z2ADlDzN1abuUUjP96pU7RYT9hrl4YS9xMmDv7iLJlcYtAtHNVQRWD2uzCnasglyW43drybyKsWSOo
X-Gm-Message-State: AOJu0Yxq74kZawuMn7Bg7a3UbZl5Tj7A0+LHSJiqILIVtnqVdZWYTRcs
	ShBxKp81SeJDlEY5ytA167QbTqKKNZO7xrG8j5ZLoIhxirlzQVdt68MwcF0ThejpqS3XAsHLet2
	L7m11lYf/Ufotstyyz0aNcRBi9S1rHGqNmlLXHhOrPHoeLpd71z3AzvQeYQjILQ==
X-Received: by 2002:a17:90a:ce8d:b0:2c2:d442:aa10 with SMTP id 98e67ed59e1d1-2c2d442ab77mr88245a91.45.1717763215025;
        Fri, 07 Jun 2024 05:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVjl4mp00EGKOz+YDE5MMuMdnmKS1XOHdz89KRwxto50YFnqTs7CRYSuimTnD6kBsJW/UMEA==
X-Received: by 2002:a17:90a:ce8d:b0:2c2:d442:aa10 with SMTP id 98e67ed59e1d1-2c2d442ab77mr88213a91.45.1717763214227;
        Fri, 07 Jun 2024 05:26:54 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2c5c05208sm1129893a91.16.2024.06.07.05.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:53 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v5 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Fri,  7 Jun 2024 20:26:15 +0800
Message-ID: <20240607122622.167228-6-coxu@redhat.com>
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

Crash kernel will retrieve the dm crypt keys based on the dmcryptkeys
command line parameter. When user space writes the key description to
/sys/kernel/crash_dm_crypt_key, the crash kernel will save the
encryption keys to the user keyring. Then user space e.g. cryptsetup's
--volume-key-keyring API can use it to unlock the encrypted device.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 Documentation/ABI/testing/crash_dm_crypt_keys |   3 +
 include/linux/crash_core.h                    |   1 +
 kernel/crash_dump_dm_crypt.c                  | 101 +++++++++++++++++-
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/crash_dm_crypt_keys b/Documentation/ABI/testing/crash_dm_crypt_keys
index 7426c9d8de97..56a4b878a4dd 100644
--- a/Documentation/ABI/testing/crash_dm_crypt_keys
+++ b/Documentation/ABI/testing/crash_dm_crypt_keys
@@ -29,4 +29,7 @@ Description:	read/write
         the kdump kernel has been loaded with the dm crypt keys stored to kdump
         reserved memory
 
+    After the kdump kernel gets booted, user space can write anything to this API
+    so the dm crypt keys can be restored to the keyring.
+
 User:		Kdump service
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
index 9a6bd39adf76..00223343473b 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -40,12 +40,67 @@ static struct keys_header {
 	struct dm_crypt_key keys[] __counted_by(total_keys);
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
 				   size_t total_keys)
 {
 	return struct_size(keys_header, keys, total_keys);
 }
 
+/*
+ * Architectures may override this function to read dm crypt keys
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
+		kexec_dprintk("Success adding key %s", dm_key->key_desc);
+	} else {
+		r = PTR_ERR(key_ref);
+		kexec_dprintk("Error when adding key");
+	}
+
+	key_ref_put(keyring_ref);
+	return r;
+}
+
 /*
  * Let the kernel know the number of dm crypt keys and allocate memory to
  * initialize related structures.
@@ -139,11 +194,53 @@ static int process_cmd(const char *buf, size_t count)
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
+		kexec_dprintk("Failed to get keyring %s\n", key_desc);
+		return PTR_ERR(keyring_ref);
+	}
+
+	addr = dm_crypt_keys_addr;
+	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
+	if (key_count < 0 || key_count > KEY_NUM_MAX) {
+		pr_info("Failed to read the number of dm_crypt keys\n");
+		return -1;
+	}
+
+	kexec_dprintk("There are %u keys\n", key_count);
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
+	for (int i = 0; i < keys_header->total_keys; i++) {
+		key = &keys_header->keys[i];
+		kexec_dprintk("Get key (size=%u)\n", key->key_size);
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
 EXPORT_SYMBOL_GPL(crash_sysfs_dm_crypt_keys_write);
 
@@ -184,7 +281,7 @@ static int build_keys_header(void)
 	for (i = 0; i < key_count; i++) {
 		r = read_key_from_user_keying(&keys_header->keys[i]);
 		if (r != 0) {
-			pr_err("Failed to read key %s\n", keys_header->keys[i].key_desc);
+			kexec_dprintk("Failed to read key %s\n", keys_header->keys[i].key_desc);
 			return r;
 		}
 	}
-- 
2.45.1


