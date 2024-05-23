Return-Path: <linux-kernel+bounces-186990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C98CCBA0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D62832B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E4713B590;
	Thu, 23 May 2024 05:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ck+zHe76"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825F13B582
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440709; cv=none; b=X23CsNWevpvOX6GDsHR6ViU8Pqsxkh1hMcbITTpUciM0+lpbN2Cwoo52WvIKMb9V7HrUfCY052bS/X8mRC5RVduvwjBCb0mTPQckTxcvmNY7LjvTptVPvdDZFm9NShtKXk0RB2zyTpXj4SnqodpD3D+gWGonXf5WMcEpsD4dgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440709; c=relaxed/simple;
	bh=D0idj180gacOPWClMaDPq0kP4SPZLOm9gI8dLiZ4idM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZTldcBegchLslXIpY0WlvSMAXwv9jmWt/VGpxtj8GeBP5A/zL8CoUcoF+u/r/2R+AuDU2YhL2mXF4ugdUNeC4rmnADCglqxOTJONYHanLdV+BEdL1Z2r9kxrvJzO0khSYkHbeQImMrGeFYgbWMx4RIruQKnemOjaw1EqNeHSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ck+zHe76; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8MpHKd2qvA1wrQz05L9+kKhzhSmxq2MJ20Kk1WvoTM=;
	b=Ck+zHe76OXx5RAghzI8Gw+WyTowXkDPo+PMBkAqjVWvGnfBgMlok0tjgEWNOsrYJHaty3g
	Pdl5i8lIS74xCDRUhrD6i+DI8661K49yKsHsTpg7vA32bNUwWYffaVC9ntPAEVebxB1cKp
	rYslAY8aT9IbC5LAfjkrxrVtqkuqr7o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Og3AVpRFOCGDZoEKMqQs0w-1; Thu, 23 May 2024 01:05:05 -0400
X-MC-Unique: Og3AVpRFOCGDZoEKMqQs0w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2bdb1490ac1so771998a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440704; x=1717045504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8MpHKd2qvA1wrQz05L9+kKhzhSmxq2MJ20Kk1WvoTM=;
        b=UMZcm4AdhheSNhcJUPkrH73NiJlK4oV4x391eh8Kcmm08mvm44RH/2eM6Yvv4BZ03e
         0aYDFQZykJjPUJdoax7m0jzw2dO4IEvD5sAH3pubLPVq0/S8a3+itj265wRF8O7un1xg
         DQESyTBoJH72VsG06ZYXyaZykMCMA3+/2DiMDxMnV2VKpt5Rq520UpaS21DIa/5p7yv5
         eGSuAQTd4LYOgwaJWAr0j1aW1/+dnULDyVZYotQiciRAVXwTPcmr9Joqmo+vRhelq6vK
         W/CeN7+Azw5gbIM4gXMeNLg71Ub6YZwA3aBso2jfDOLtAnPGwJfqFbzTOYBJmpxUHEsx
         YQow==
X-Forwarded-Encrypted: i=1; AJvYcCWv2KYagISlCpRi2XGDMw7EdNgYxAFDUaU9H5HjDuOkiTCkeRcd1weH+2V96oxcXYd0boXN3Te97r5MwLIvmwvG6VmSaFuuNaR8RMYH
X-Gm-Message-State: AOJu0YzNGDzhLF/wEZrUnZ87N5+ra4XkVEJju3piJcZ98I6yzg3adHbQ
	cPpvAMIkuS0WRP/tk9kBqnv7B0ogeFep+B1PgidlU2azYJr+ttUcpRn74hozFCl023dFptObTjJ
	VplDldsW4uUINunKVM+PXYYNSRbubGAZhq6GG7nS8yCECKesRu1BqXZFWkI4JGQ==
X-Received: by 2002:a17:90b:10e:b0:2b2:7e94:c62f with SMTP id 98e67ed59e1d1-2bd9f479dc8mr4289759a91.15.1716440703722;
        Wed, 22 May 2024 22:05:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk1hVL79FAX1DWlXSl4OZVT3g3CW4flDiPn0h7jbGTZiTWbF9DbyM4fGyNV2dF6+9Ycg94Hg==
X-Received: by 2002:a17:90b:10e:b0:2b2:7e94:c62f with SMTP id 98e67ed59e1d1-2bd9f479dc8mr4289721a91.15.1716440702700;
        Wed, 22 May 2024 22:05:02 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f4e062sm684076a91.40.2024.05.22.22.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:02 -0700 (PDT)
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
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by\b)
Subject: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
Date: Thu, 23 May 2024 13:04:43 +0800
Message-ID: <20240523050451.788754-3-coxu@redhat.com>
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

A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
the dm crypt keys persist for the kdump kernel. User space can send the
following commands,
- "init KEY_NUM"
  Initialize needed structures
- "record KEY_DESC"
  Record a key description. The key must be a logon key.

User space can also read this API to learn about current state.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |   5 +-
 kernel/Kconfig.kexec         |   8 +++
 kernel/Makefile              |   1 +
 kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c              |  22 +++++++
 5 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 44305336314e..6bff1c24efa3 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
-
+#ifdef CONFIG_CRASH_DM_CRYPT
+int crash_sysfs_dm_crypt_keys_read(char *buf);
+int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
+#endif
 
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 6c34e63c88ff..88525ad1c80a 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -116,6 +116,14 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 
+config CRASH_DM_CRYPT
+	bool "Support saving crash dump to dm-crypt encrypted volume"
+	depends on CRASH_DUMP
+	help
+	  With this option enabled, user space can intereact with
+	  /sys/kernel/crash_dm_crypt_keys to make the dm crypt keys
+	  persistent for the crash dump kernel.
+
 config CRASH_HOTPLUG
 	bool "Update the crash elfcorehdr on system configuration changes"
 	default y
diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240dfc9f..f2e5b3e86d12 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o elfcorehdr.o
 obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_CRASH_DUMP) += crash_core.o
+obj-$(CONFIG_CRASH_DM_CRYPT) += crash_dump_dm_crypt.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
new file mode 100644
index 000000000000..78809189084a
--- /dev/null
+++ b/kernel/crash_dump_dm_crypt.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <keys/user-type.h>
+#include <linux/crash_dump.h>
+
+#define KEY_NUM_MAX 128
+#define KEY_SIZE_MAX 256
+
+// The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
+#define KEY_DESC_LEN 48
+
+static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
+static enum STATE_ENUM {
+	FRESH = 0,
+	INITIALIZED,
+	RECORDED,
+	LOADED,
+} state;
+
+static unsigned int key_count;
+static size_t keys_header_size;
+
+struct dm_crypt_key {
+	unsigned int key_size;
+	char key_desc[KEY_DESC_LEN];
+	u8 data[KEY_SIZE_MAX];
+};
+
+static struct keys_header {
+	unsigned int key_count;
+	struct dm_crypt_key keys[] __counted_by(key_count);
+} *keys_header;
+
+static size_t get_keys_header_size(struct keys_header *keys_header,
+				   size_t key_count)
+{
+	return struct_size(keys_header, keys, key_count);
+}
+
+static int init(const char *buf)
+{
+	unsigned int total_keys;
+	char dummy[5];
+
+	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)
+		return -EINVAL;
+
+	if (key_count > KEY_NUM_MAX) {
+		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
+		       KEY_NUM_MAX);
+		return -EINVAL;
+	}
+
+	keys_header_size = get_keys_header_size(keys_header, total_keys);
+	key_count = 0;
+
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	keys_header->key_count = total_keys;
+	state = INITIALIZED;
+	return 0;
+}
+
+static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
+{
+	char key_desc[KEY_DESC_LEN];
+	char dummy[7];
+
+	if (state != INITIALIZED)
+		pr_err("Please send the cmd 'init <KEY_NUM>' first\n");
+
+	if (sscanf(buf, "%6s %s", dummy, key_desc) != 2)
+		return -EINVAL;
+
+	if (key_count >= keys_header->key_count) {
+		pr_warn("Already have %u keys", key_count);
+		return -EINVAL;
+	}
+
+	strscpy(dm_key->key_desc, key_desc, KEY_DESC_LEN);
+	pr_debug("Key%d (%s) recorded\n", key_count, dm_key->key_desc);
+	key_count++;
+
+	if (key_count == keys_header->key_count)
+		state = RECORDED;
+
+	return 0;
+}
+
+static int process_cmd(const char *buf, size_t count)
+{
+	if (strncmp(buf, "init ", 5) == 0)
+		return init(buf);
+	else if (strncmp(buf, "record ", 7) == 0)
+		return record_key_desc(buf, &keys_header->keys[key_count]);
+
+	return -EINVAL;
+}
+
+int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count)
+{
+	if (!is_kdump_kernel())
+		return process_cmd(buf, count);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_write);
+
+int crash_sysfs_dm_crypt_keys_read(char *buf)
+{
+	return sprintf(buf, "%s\n", STATE_STR[state]);
+}
+EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 07fb5987b42b..2ba4dcbf5816 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -167,6 +167,25 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+#ifdef CONFIG_CRASH_DM_CRYPT
+static ssize_t crash_dm_crypt_keys_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return crash_sysfs_dm_crypt_keys_read(buf);
+}
+
+static ssize_t crash_dm_crypt_keys_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	int ret;
+
+	ret = crash_sysfs_dm_crypt_keys_write(buf, count);
+	return ret < 0 ? ret : count;
+}
+KERNEL_ATTR_RW(crash_dm_crypt_keys);
+#endif /* CONFIG_CRASH_DM_CRYPT */
+
 #ifdef CONFIG_CRASH_HOTPLUG
 static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
@@ -271,6 +290,9 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_VMCORE_INFO
 	&vmcoreinfo_attr.attr,
+#ifdef CONFIG_CRASH_DM_CRYPT
+	&crash_dm_crypt_keys_attr.attr,
+#endif
 #ifdef CONFIG_CRASH_HOTPLUG
 	&crash_elfcorehdr_size_attr.attr,
 #endif
-- 
2.45.0


