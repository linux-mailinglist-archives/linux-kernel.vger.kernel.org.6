Return-Path: <linux-kernel+bounces-186989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE968CCB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077471F22E78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF113B2A0;
	Thu, 23 May 2024 05:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVmIxDqr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB9129A78
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440705; cv=none; b=cSWsqqoMhArLKpX9afnqECLS9kkuxkOxle2f4bwxOG7TyHmEAkS46qR1/oLXmrf+FU0HZ8slVsHrAJT8yrJvF4AA2q8jdwviLYGnaqcrVBTvafLD07HIKzyNL2z9czaYNfVN/gOWgvDR9zsKEzkRkNiMUuwy3CmvNh9PsQRaueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440705; c=relaxed/simple;
	bh=dGZmp2vLpOIfcPBTPdNO+OvC6zpXCIslEn4uygnmMgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jz6Ji2YRtUC52qhjuueRPrNmL+i29VzBuyMrREPmsg4oq1t/d26kKal4Bwo7H7XI75GNproNZYH1URH2tdKtjhpd/P/hxQs2jmZ8S04tZugFTj05PEeThcwGnwmsxOSVSxyY/8rFJFbjjd7KK4M1wYCOMfOb1Vw5HnfJW7BL1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVmIxDqr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZynSKfZ+ldOQ3kMeJNfuvuSvRX+IwHDcGck7Xj2nRU=;
	b=dVmIxDqrPMG4VFTbMyS37OBLMSIALn63LR9l5dIOdc7gVTp5oVAJuM1iGY/9CsnhojCJWM
	nEtsGxtT4wFHDJCFJHFH/OarCdd+KkJRsbPQ7SrpUHxTyy6FLrKGKT7lZ/qpI6JkQJb1Bx
	Tk1DNLAL4S0s71xT4fA3ue0bkKYJT2w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-O_cr-IqzOBWZ_VVzACwtmg-1; Thu, 23 May 2024 01:05:00 -0400
X-MC-Unique: O_cr-IqzOBWZ_VVzACwtmg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1eec5aba2bdso130609475ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440699; x=1717045499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZynSKfZ+ldOQ3kMeJNfuvuSvRX+IwHDcGck7Xj2nRU=;
        b=km8bz84tTV07bVKPiLMk4OZA9RxItL+BCWVwwNTpzcrWOAfMhUAeQPuJfpmY8OpPCR
         MKyTLDK6snH4BKhBfP+Zv3xOU9DBQkojhc/1bbvfJzxcuks8cFK9iqfzUTM6tZsKuYmG
         nRQqm4QL/zksLX/seNI52wfIPV1Xt2QD2biHiweQ0XBIG+bnRTsejS47Gb257KLUoORJ
         7sUwhfIqyvrGIgd0YphBwrhhZlHLESI93UZmh8OrBfk/7ExMDINehWZOJgfAc+ce0DWs
         0cPdy9cI4o2rL5FufuWyEACDOjKAO83PYMxRBMMDns7kcZs+ojgTrmjhAvof3teUhFHN
         W+dg==
X-Forwarded-Encrypted: i=1; AJvYcCWZbhGG9Kbh1cUnq0WrbrwtL9sBlBK1EgnX6xhxaKPSzs3iV7gV1Ku704jJsua7e2msJwwdajjyxBLDdiNMs1BTeSIq6BSDkG2KTpre
X-Gm-Message-State: AOJu0YyGt+aWSRVAlgSwXesVLmRj3TnG/xgTsmkpH4Jh/zRw/cWrKqcl
	73/DsBOExswAxiBv7E6wJ93N7ZbHgM/6H4IVzNn7vdN2wscBwyU3miZjllcIlRx+RngzuGR1yxw
	TfESniiNeqRG+CBTkch+8yFFv/FPnxeXNN12GhMl/yn330Py3jIGcQ2Ft+bWmvA==
X-Received: by 2002:a17:902:cf04:b0:1f3:2fa7:6d7b with SMTP id d9443c01a7336-1f32fa76e61mr33104395ad.19.1716440699018;
        Wed, 22 May 2024 22:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw+CHnj/MZBKIkFFsXHEy8x5jL+NWT0WhFWjdQIsn/ck9Po7lLmmL2jkJ496RIELn9298gCA==
X-Received: by 2002:a17:902:cf04:b0:1f3:2fa7:6d7b with SMTP id d9443c01a7336-1f32fa76e61mr33104035ad.19.1716440698265;
        Wed, 22 May 2024 22:04:58 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f32d91cd9asm15943535ad.267.2024.05.22.22.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:04:57 -0700 (PDT)
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
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v4 1/7] kexec_file: allow to place kexec_buf randomly
Date: Thu, 23 May 2024 13:04:42 +0800
Message-ID: <20240523050451.788754-2-coxu@redhat.com>
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

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_file.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..cc81b8a903ab 100644
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
@@ -182,6 +183,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool random;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3d64290d24c9..06b77f9ac4cc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,6 +25,7 @@
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#include <linux/prandom.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
@@ -437,6 +438,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	return ret;
 }
 
+static unsigned long kexec_random_start(unsigned long start, unsigned long end)
+{
+	unsigned long temp_start;
+	unsigned short i;
+
+	get_random_bytes(&i, sizeof(unsigned short));
+	temp_start = start + (end - start) / USHRT_MAX * i;
+	return temp_start;
+}
+
 static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 				    struct kexec_buf *kbuf)
 {
@@ -445,6 +456,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -482,6 +495,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.45.0


