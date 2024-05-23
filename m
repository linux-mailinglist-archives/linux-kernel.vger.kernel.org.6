Return-Path: <linux-kernel+bounces-186992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE3F8CCBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734512831B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D2A13B783;
	Thu, 23 May 2024 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F43lQ9IO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B813A88D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440718; cv=none; b=icvi95dsrHGA26arMmCwx88pSmGhYaqiQ6GNlqD6qeHyYGnMta3SlVoVR2V6I2cWagOrQH8Sy/m30B3Bq64lMhzN7M9IKVXENbIfmpWK1AYVLvtmEwfWg6aIkX9ZjaXJcstriUWEWOjhwQLOBSRHAvyq0AdHsFFEez6Tj0dCbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440718; c=relaxed/simple;
	bh=XRaf5EmI1n/9OcNzHgkmeUNkMvJvx+1lwOXtc8o86LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5R/PGqGeR3HrWGeHV4fLRnVsouj/TqXdHaGyJhnko7q6tKaFuPokRgXW0kmudm1POtYcPaCH84yHcVR3wjxh3CJi/fxY4wxE7N6DIjiDn6Fmz6siGsEzVTh6PIi3pV8efLN2bX0Ui9AE47vk3y2yPqKIQEEP4CiX2BQ67wgFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F43lQ9IO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwcExXXLPYnBFndSXcLNg5IgaO4KxZIIlwgUQB+aV8U=;
	b=F43lQ9IOneaQlxvac2Ul0f9qCkSdK8gK1/5C9ut+J6hGmAbcizDPTWWyyZf5zk2zBWcxm5
	8beZ5M3nEUcVFdyNeLl1rQJbJQSx++4NtYkH8hiNnArYG2TpP0jc2OOzeLrvlWLs6k7My2
	evQbInEeBKc/1whL6ocU24NCeVXYRAU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-dd9hD7RJNcy2LWssmGZMEQ-1; Thu, 23 May 2024 01:05:13 -0400
X-MC-Unique: dd9hD7RJNcy2LWssmGZMEQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b8700329e6so845707a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440712; x=1717045512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwcExXXLPYnBFndSXcLNg5IgaO4KxZIIlwgUQB+aV8U=;
        b=tFCJ+wAlNy4znC5o8ekIEqY0xgg+i4ChYmU6y75GI7cmUm6n55sOoyKDp5fnLxug7H
         fk3LXZ3jkk8DEHLT9F8R+a/L9VQ4o8sjslHsLVQJHbpfq/u38Ff3QTRH6MzgTJqy8m18
         VRKHp4vCBBRUekaY0jPFihbw9sS9zxxTMDMjOUWIk99z5VecAIsh5k1S7PXHTo4/+tht
         7Qzj8Fee5coLWicYv6nDWAKNzj1YNkP+vpG1ErRgY3p5HAvOIznTKBsYNDQ5iGGJv1Gz
         kaIm+SliqQf8chkSOrfIk1DF8mZgjCLMW61KYTQ0s0qEQ7srvEvJ2JNLpfdYx1wGId9L
         zamQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrxY6CWfv+UHBCFII8OvMalq3meV6K5sJnWKFKxqaxGP5f/GtPgsPCG7VgYQFtKfmpmCVMGTHFSwFO4dinoqHeI9Ap7cQiIbqH234Q
X-Gm-Message-State: AOJu0Yzev/uJUa7IRhT71DGbP574YTMjbBAgBhVRbrTqjuaaTHVs1qUV
	BpIv3jhLelO0mR2Fdw12wK9/J+xUP0Q0vgX4VcA6H7Z9rHL3xihDMk9qQVidztkQkeQKHxEJojH
	X09dcMD0Ekb9pD2VaVJRI5pLiG7qaaqGSUh2LcMa6NNVIZOH1y4EeGoIHdDy8Io4iRtU6DdUOpQ
	I=
X-Received: by 2002:a17:90b:3002:b0:2bd:ec55:9f38 with SMTP id 98e67ed59e1d1-2bdec559fbfmr284161a91.29.1716440711846;
        Wed, 22 May 2024 22:05:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRR+6oMpSEO77P0mkaAygN4BkX2R/W8hIA3+G2zdrDxCovM2XxnoMXOUOMXl6NUFojPYs4MQ==
X-Received: by 2002:a17:90b:3002:b0:2bd:ec55:9f38 with SMTP id 98e67ed59e1d1-2bdec559fbfmr284127a91.29.1716440711222;
        Wed, 22 May 2024 22:05:11 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ee2460sm681073a91.1.2024.05.22.22.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:10 -0700 (PDT)
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
Subject: [PATCH v4 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Thu, 23 May 2024 13:04:45 +0800
Message-ID: <20240523050451.788754-5-coxu@redhat.com>
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

When there is CPU/memory hot-plugging, the kdump kernel image and initrd
will be reloaded. The user space can write the "reuse" command to
/sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.

Note currently only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
hotplug support")) and ppc (WIP) supports the new infrastructure
(commit 247262756121 ("crash: add generic infrastructure for crash
hotplug support")). If the new infrastructure get extended to all arches,
this patch can be dropped.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/crash_dump_dm_crypt.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 89fec768fba8..b4dc881cc867 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -10,12 +10,13 @@
 // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
 #define KEY_DESC_LEN 48
 
-static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
+static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
 static enum STATE_ENUM {
 	FRESH = 0,
 	INITIALIZED,
 	RECORDED,
 	LOADED,
+	REUSE,
 } state;
 
 static unsigned int key_count;
@@ -90,12 +91,31 @@ static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
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
+}
+
 static int process_cmd(const char *buf, size_t count)
 {
 	if (strncmp(buf, "init ", 5) == 0)
 		return init(buf);
 	else if (strncmp(buf, "record ", 7) == 0)
 		return record_key_desc(buf, &keys_header->keys[key_count]);
+	else if (!strcmp(buf, "reuse")) {
+		state = REUSE;
+		get_keys_from_kdump_reserved_memory();
+		return 0;
+	}
 
 	return -EINVAL;
 }
@@ -175,9 +195,11 @@ int crash_load_dm_crypt_keys(struct kimage *image)
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
2.45.0


