Return-Path: <linux-kernel+bounces-386321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4409B41F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67B91F234E1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5A1FF5F8;
	Tue, 29 Oct 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iC9il/Cr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1EE201023
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181159; cv=none; b=pFHGddePBBzUpChhqzxJPzV5fCWfp8TrlNgGgCkIs1rQU3NR4BO977qQbistCDQACa8fKd8ZjtYVutxRMvbj3GxWs0oV8eEIeSg1wNrJic+ZLKoDhru45V/Ne/U2dFnXJYqHuXnIgGqlPdCpUaABrYD+Ef8ZEH8q9xipW+HFMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181159; c=relaxed/simple;
	bh=dyLLggNeeWqOcdpYXsP/Woa7wEigD3m5xP7IGasrprc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzM91m5WxxBy/OGJECccEKD8QVpVcXjwzhePMs176CsLgM6/RFbTtnsvfGYpTzltrl02u5/p/OeOCWnOHM00WrT/wyH03wX/znhkJM6/TFK0pTXqN18tEW3kc4Vg3w/rj/FAZ1IRnp2WjTsbpjpirzx/XyxgEs/YBrtgUSW+cUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iC9il/Cr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfQRV/dv4U0HCeNe7nsPQHTJHsNlbpGtvoqQINu/Ues=;
	b=iC9il/Cr5DleEYXPXg+pDzowXUQt73nPqq8OrtETJqufAzMieAoVe41/f05sNITuoMIH5U
	q2HBn/fQ+j2qCp4AR11ZYfdhC7A+nIIQp+ImgxcP0JXk7oBPO39Pdyrj+3weyfteXJBMAg
	Y+2ff3cCUFwrc19qvTbt4ClDcDco7g8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-cJz7b4iOPbu_zHnx7j2CNg-1; Tue, 29 Oct 2024 01:52:34 -0400
X-MC-Unique: cJz7b4iOPbu_zHnx7j2CNg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7202dfaa53fso7136512b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181153; x=1730785953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfQRV/dv4U0HCeNe7nsPQHTJHsNlbpGtvoqQINu/Ues=;
        b=T7fuAopVCbV4oMHJM0w9QnvqY8d6bptVmhNIOkdajShJzU4BTBNdtB4mm+qwqXb5ng
         TjGFDa6uDGpHyf/kk/atxoqu44YB7lQOmGUZN5BPjoGLQ5ax0m5mh5PMVGC9sy65zGie
         sellATvHSULCGwuZ6Gsw1njPZn3ziUyN94xRW4k/asPEX2Wpr0kfNGDEAhmFM4fdJ43M
         FPAnUe5jwLmPlIpyDW0GJFT21xXTf53QBxUbb2Ej5Ox5eRSitK9EHwMbzo4eRRLkdq0V
         7LxVXEP2/tox+QATomkQMLiQJGtiU1O+vh29Fg8HAVjeFXO454HJwoM7zHmhBSbJLnPh
         DsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1aUmWG397bXnaiK+Yq7jbYpoC2XGYBcW9sFENlbSB0VqdSFR+owP5sgXuG0xLvQHl/YbZqbE0teotatc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTwyRjKj/slrTm/aMxqNXe8bVD1zF2bE3F+u1HXzYNNO/ucJU
	j5jJLFjPG4C6kYug8z2bZpARDzta8ZDF1f0RVT5MPiAIU53hYk8pP54ISdkuQf4mNli6Mj+Xpk1
	XDKtm45Jdvnvc/r2g+wa+EpKDGMpicAVGt38+ggN+S4PmRGM/OnOnp5SG90VDPg==
X-Received: by 2002:a05:6a00:cca:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-72063072a39mr16213213b3a.20.1730181153484;
        Mon, 28 Oct 2024 22:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLxIlu9DkjWvKRHGMJ0mqkMLya+w2yF4n0UBh5fuzAHKNAUx2a3Ph3LsR4pd+vmQ0zxRU0oQ==
X-Received: by 2002:a05:6a00:cca:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-72063072a39mr16213193b3a.20.1730181153128;
        Mon, 28 Oct 2024 22:52:33 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a21b79sm6906605b3a.176.2024.10.28.22.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:52:32 -0700 (PDT)
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
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v6 1/7] kexec_file: allow to place kexec_buf randomly
Date: Tue, 29 Oct 2024 13:52:14 +0800
Message-ID: <20241029055223.210039-2-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h | 28 ++++++++++++++++++++++++++++
 kernel/kexec_file.c   |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..0dc66ca2506a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -25,6 +25,10 @@
 
 extern note_buf_t __percpu *crash_notes;
 
+#ifdef CONFIG_CRASH_DUMP
+#include <linux/prandom.h>
+#endif
+
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
@@ -171,6 +175,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -182,8 +187,31 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+#ifdef CONFIG_CRASH_DUMP
+	bool random;
+#endif
 };
 
+
+#ifdef CONFIG_CRASH_DUMP
+static inline void kexec_random_start(unsigned long start, unsigned long end,
+				      struct kexec_buf *kbuf,
+				      unsigned long *temp_start)
+{
+	unsigned short i;
+
+	if (kbuf->random) {
+		get_random_bytes(&i, sizeof(unsigned short));
+		*temp_start = start + (end - start) / USHRT_MAX * i;
+	}
+}
+#else
+static inline void kexec_random_start(unsigned long start, unsigned long end,
+				      struct kexec_buf *kbuf,
+				      unsigned long *temp_start)
+{}
+#endif
+
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
 int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..06565d867b69 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -445,6 +445,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+	kexec_random_start(temp_start, temp_end, kbuf, &temp_start);
 
 	do {
 		/* align down start */
@@ -483,6 +484,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 
 	temp_start = max(start, kbuf->buf_min);
 
+	kexec_random_start(temp_start, end, kbuf, &temp_start);
+
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
 		temp_end = temp_start + kbuf->memsz - 1;
-- 
2.47.0


