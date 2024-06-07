Return-Path: <linux-kernel+bounces-206031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0BF900384
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C7C282C92
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE91946DB;
	Fri,  7 Jun 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmAff3dr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC3319414E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763199; cv=none; b=ss/qZe19MFA75/UFhDIQfx/br7euliIsPDzvlwRdoQl6a/hUJ5N6yb0YO7EKS/icpapo1uMCtZ8mv/eR+FX+3zQh9MIfHRGsv52sIEncPydTODxuUSmJ81NhfH9QPiDN5Bo6oobiQ5pY3i2uwNljzujh9ddNZGke/0r7MXEJ/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763199; c=relaxed/simple;
	bh=RFJNZU7TLgnGsVmKkHuMKPqdGs2uAqapaQ0gSTvA9Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqRSBa1w6bGgwm9zCYFFDfdWEhRjB7c1WR5CpaqcJMT4OGtksHl1yl9ID9J//HvZ+hcm9OSzx0QCkGF4sHHN+IFuuntlV6FQ5wb/FcoX1qmD4AYVcjC8wZN4BRhgnnwVxkTkkSLJCp7u/Vp+XlbEQsQe/HEEXjZD4JR+8FSkGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmAff3dr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2P/UHfuOg4ehNZSVTesGfCNw2riSEHvP0JbrY+cOcU=;
	b=MmAff3drcqdp8NBqxYVK/rMHkzCKNzm3EVrUAInfUN1prucnBtnCaF5IlrWBJc3cLoM0Bw
	8uIuSjt8l1sudyuxToHuBn0xn6A8y89sG22nV521QMdM+H0R/8/Y5zlibz9R6XicA28pBw
	cF/7lw7T0Ay+93E0GEGazo8Tmn7x+kQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-X0C3hKA-Ohec7NiucwAHOw-1; Fri, 07 Jun 2024 08:26:35 -0400
X-MC-Unique: X0C3hKA-Ohec7NiucwAHOw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f6174cfcf8so21277435ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763194; x=1718367994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2P/UHfuOg4ehNZSVTesGfCNw2riSEHvP0JbrY+cOcU=;
        b=AbX6szlHwuYsT5o0F2Y6r377XAqM37owiwiFBMC2drVYUJsQ0PwCiV5oq+6lH+Nm5U
         jcTh+rqxfF4wJ80/oIiTnJGHpEMbAtaduUXqwts5GRic57XZUdskRsrS1F/GlQoZNRiW
         vJ+Yvob1njcA2jMBK1g5jTDGJsqp1Iqilf5pe3JwJ2avfvx2l8OpSUMjtmjkVUEonSFB
         ea6lElUK/8FYu3uc+BabcJcSjgbjSH8PSIloM5s7B4+S7lwVolHiYDZw7rpa/TICsiC6
         n8om1vefm/0BALoHUEDE+oSIRUwDB1/WW72r67YuyA9GjdKy0H7YuuhH8Nr5IyB0wAOW
         TNNw==
X-Forwarded-Encrypted: i=1; AJvYcCURYlO5PPokpVMohRzblFSuJZbnZifJ4zuFEvi4igHVj6Z/6qM+gozVpooVUqD+p073J+radcR0fSMma7h4GrhNW9jmMd+EQXG1Gi4U
X-Gm-Message-State: AOJu0Yzin799BiNKfYj7bUTUXdFzB5Kze8uwaHUcseQaTn8oM25ib4HN
	tEyxc9L9b6P9zN49KPpvaUl63J9BnOJa7GThjjh9ldAMURQ3mI2+7IHYKqFe+92svALVQLcJ9Yc
	SpOegNcYkqGnwynC+TRGfVP4dWRoQ9F210K7YBmn9JY5Fb47/S9OgR6nV3/FKcg==
X-Received: by 2002:a17:902:e54c:b0:1f6:5869:df53 with SMTP id d9443c01a7336-1f6d02e647amr28703855ad.20.1717763193987;
        Fri, 07 Jun 2024 05:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxwy+yOhlJ8TSNGn0kZKxDg2jLx7D4xuuGL3ibcgvt+PHeSDr3Kf0fwtpAOyE6i5wHI+pohA==
X-Received: by 2002:a17:902:e54c:b0:1f6:5869:df53 with SMTP id d9443c01a7336-1f6d02e647amr28703345ad.20.1717763193274;
        Fri, 07 Jun 2024 05:26:33 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f45bsm33029905ad.35.2024.06.07.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:32 -0700 (PDT)
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
Subject: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
Date: Fri,  7 Jun 2024 20:26:11 +0800
Message-ID: <20240607122622.167228-2-coxu@redhat.com>
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

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  4 ++++
 kernel/kexec_file.c   | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..c45bfc727737 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -182,6 +183,9 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+#ifdef CONFIG_CRASH_DUMP
+	bool random;
+#endif
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3d64290d24c9..f7538d8f67e0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,6 +25,9 @@
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#ifdef CONFIG_CRASH_DUMP
+#include <linux/prandom.h>
+#endif
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
@@ -437,6 +440,18 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	return ret;
 }
 
+#ifdef CONFIG_CRASH_DUMP
+static unsigned long kexec_random_start(unsigned long start, unsigned long end)
+{
+	unsigned long temp_start;
+	unsigned short i;
+
+	get_random_bytes(&i, sizeof(unsigned short));
+	temp_start = start + (end - start) / USHRT_MAX * i;
+	return temp_start;
+}
+#endif
+
 static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 				    struct kexec_buf *kbuf)
 {
@@ -445,6 +460,10 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+#ifdef CONFIG_CRASH_DUMP
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
+#endif
 
 	do {
 		/* align down start */
@@ -482,6 +501,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.45.1


