Return-Path: <linux-kernel+bounces-206033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF0900386
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1700D2881B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57494194A7E;
	Fri,  7 Jun 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daW6goiz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197D193066
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763215; cv=none; b=KF+xQ1yFZoyI6LaGaupShaaFI/HjpWmB7KddLbZwu8Z/M61NBdBeWzqq/PADSaP/6MqF91VtaSc3b8RP6GOZ0aLYHql9i864Kjv3scJbjVp4FWUEgPJQTLqdS0pPSObJjn/Z4HOhJ+ociMLl3XbqJQKUlqC+ywtCk1fYajPCB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763215; c=relaxed/simple;
	bh=IBYPengZsz7XC1vanBmnhe17XfWTwTLjGq2J1MdC1Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiXooct6XXyoSW7+cNpoggcxulsY8u/6+EW1GdbZwklkxO/2pbhF7smuKvX3utqWkLilrQ2y3dSyoDp9MAZI2kHEOUxY5ySJ/fn2wupRO2UEaP+BIw3vZjioxlUkYFTns7QOfNKA5Du4shXwmglQSq1PiO2EKXWl2f0Y1Ed/LJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daW6goiz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGp8yBhj1+knJlcnzRysXoXCImiASNI+KRbes2MGqNg=;
	b=daW6goizWE1k5G7VHuvfIK2PPqseCSXOw/Y+8NciIpw8BMChTBKooXb89mlFY7L8eVeCCm
	53WpeHoh02SxMwKtqHjYjjfQTnYPbCcyvWFM7ChlKWEx+ntz/HWEXttzYnm9LYoWYlxvVa
	9XQl4HHAZbBQwe7w0qqnoe+AKXy8RtM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-QILmmHBUObOJFCc2tQvQcA-1; Fri, 07 Jun 2024 08:26:51 -0400
X-MC-Unique: QILmmHBUObOJFCc2tQvQcA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f67a4842dfso15049025ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763210; x=1718368010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGp8yBhj1+knJlcnzRysXoXCImiASNI+KRbes2MGqNg=;
        b=to3CkBaaVViUUv22IdjC/zMZthDNtqYdSX5OZUSt+Vd0lmIkKy7qXnR+a6UHwD2/OL
         bLUyg9Rd3gqvFEMm9jpdd1A9xgj5CouqfJqTwfWMuQS/qw+NsKuvTefMm31d370mPVtg
         /238f5FT1/klCDkrDjUIozDyEH1TIoZtEq+hdVkR5ZomVD0JkE8oVQWEFuErWV6HXx2Q
         HRlUrxHw/GdhTpysJ3itY/101ctWLkcIqXQqP4eNnQSg0GHvmT0/gkbk8PVvep9wlBzZ
         ccaPigTi9TEJXYrCeLi3BDxw8bJUWJ4qjraDqnWyanT0Mn6hNr/+o5Xb4wjIx1B1+IGh
         qplg==
X-Forwarded-Encrypted: i=1; AJvYcCWOfYDeu/+Av9J2DsvcZD5BepB94n9vmdBNOrbVG03gyGgqB4e2vR9XSoVGHO3gZ8uWNBqAzXk4en1LEUjXlZQbk6AmRHiLJB8EeIIC
X-Gm-Message-State: AOJu0YwmNM8WJR2ksT7gCTTP//LHAsQvTmZCjmxlqYQa0smY3x35OlQq
	OhXhITZbnPEYuGq+SLqfm/Z85o1V5a7jP6C/aL5Ar0KCtRAdwd7YnbfzBdj3y+yrd/JyB1Lrj6i
	KvgNfPgx9EeoTSx4pmfwsWxyStlfl5uRAsCjz8uxt0A0O4FDkTlhXoajPwtgWug==
X-Received: by 2002:a17:903:950:b0:1f6:e338:348f with SMTP id d9443c01a7336-1f6e3383556mr8776735ad.3.1717763209947;
        Fri, 07 Jun 2024 05:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXnqypVfmxKF1aFiPxUul2uqRYNx6AqzNM8EiDs+ZbbmDh4kF2hq/Ga42bgvJ6dM0meVp4Qg==
X-Received: by 2002:a17:903:950:b0:1f6:e338:348f with SMTP id d9443c01a7336-1f6e3383556mr8776405ad.3.1717763209330;
        Fri, 07 Jun 2024 05:26:49 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccdc3sm33218575ad.131.2024.06.07.05.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:48 -0700 (PDT)
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
Subject: [PATCH v5 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Fri,  7 Jun 2024 20:26:14 +0800
Message-ID: <20240607122622.167228-5-coxu@redhat.com>
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

When there are CPU and memory hot un/plugs, the crash elfcorehdr which
describes CPUs and memory in the system needs to be updated for the
kdump kernel.

Currently, there are two solutions to support this case. One is to
utilizes udev to instruct user space to reload the kdump kernel image
and initrd, elfcorehdr and etc. again. The other is to only update the
elfcorehdr segment. For the 1st solution, the dm crypt keys need to be
reloaded again. The user space can write the "reuse" command to
/sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.

Note only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
hotplug support")) and ppc (WIP) supports the new infrastructure
(commit 247262756121 ("crash: add generic infrastructure for crash
hotplug support")). If the new infrastructure get extended to all arches,
this patch can be dropped.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 Documentation/ABI/testing/crash_dm_crypt_keys |  2 ++
 kernel/crash_dump_dm_crypt.c                  | 32 ++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/crash_dm_crypt_keys b/Documentation/ABI/testing/crash_dm_crypt_keys
index e6a6f6be5a9e..7426c9d8de97 100644
--- a/Documentation/ABI/testing/crash_dm_crypt_keys
+++ b/Documentation/ABI/testing/crash_dm_crypt_keys
@@ -15,6 +15,8 @@ Description:	read/write
         Record a key description. For security reason, the key must be a logon
         key whose payload can't be read by user space. For details, please refer
         to security/keys/core.rst.
+      - "reuse"
+        Reuse the dm crypt keys stored in kdump reserved memory.
 
     And you can also read this API to know the command eructation status,
       - fresh
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 0033152668ae..9a6bd39adf76 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -15,13 +15,15 @@ static enum STATE_ENUM {
 	INITIALIZED,
 	RECORDED,
 	LOADED,
+	REUSE,
 } state;
 
 static const char * const STATE_STR[] = {
 	[FRESH] = "fresh",
 	[INITIALIZED] = "initialized",
 	[RECORDED] = "recorded",
-	[LOADED] = "loaded"
+	[LOADED] = "loaded",
+	[REUSE] = "reuse"
 };
 
 static unsigned int key_count;
@@ -107,12 +109,32 @@ static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
 	return 0;
 }
 
+static void get_keys_from_kdump_reserved_memory(void)
+{
+	struct keys_header *keys_header_loaded;
+
+	arch_kexec_unprotect_crashkres();
+
+	keys_header_loaded = kmap_local_page(pfn_to_page(
+		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
+
+	memcpy(keys_header, keys_header_loaded, keys_header_size);
+	kunmap_local(keys_header_loaded);
+	state = RECORDED;
+	arch_kexec_protect_crashkres();
+}
+
 static int process_cmd(const char *buf, size_t count)
 {
 	if (strncmp(buf, "init ", 5) == 0)
 		return init(buf);
 	else if (strncmp(buf, "record ", 7) == 0 && count == KEY_DESC_LEN + 6)
 		return record_key_desc(buf, &keys_header->keys[key_count]);
+	else if (!strcmp(buf, "reuse")) {
+		state = REUSE;
+		get_keys_from_kdump_reserved_memory();
+		return 0;
+	}
 
 	return -EINVAL;
 }
@@ -192,9 +214,11 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	}
 
 	image->dm_crypt_keys_addr = 0;
-	r = build_keys_header();
-	if (r)
-		return r;
+	if (state != REUSE) {
+		r = build_keys_header();
+		if (r)
+			return r;
+	}
 
 	kbuf.buffer = keys_header;
 	kbuf.bufsz = keys_header_size;
-- 
2.45.1


