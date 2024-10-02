Return-Path: <linux-kernel+bounces-347942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBC598E098
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8179FB2B108
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCB1D0945;
	Wed,  2 Oct 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIVZ7LWl"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549B1D0E1C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885708; cv=none; b=DXBC1K61oOsQ7MwnEFMfGuDRtN6kyhZhZ7Bl1rcvCwi8K0RiRZzccHO0D2d/6/ZjWaWWSdW6B5GPBXK2R7vVB6oPZPcGW7PQLiEffA6YnCiy0W+jXbyYRvZmlcpQImgiPBYmmQdDF8TVnrH12r4ddemF5z+qKR2KFOwilhvV9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885708; c=relaxed/simple;
	bh=CXm98g+JGuBVVP0eUZ81pK8jdkgXkmxPtnEygPhRJTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSmD1T4nDC/kjdhxuhq/wXYACqBfi8hxJBlwYRTOO7atAXcGSSMZ9uxgtJYccgLgMi+maZajWvDhloxEdHkhiu2aH93pb7ODfI0PLyk2oPX0qm64bJjDDo8PFf32FibcCmVhGYY1F4GXk5WhCWXkReJbKPge0BzSXFNuazkBSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIVZ7LWl; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2e0d9b70455so13989a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727885706; x=1728490506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYO4VdlmtMCxwpF5Tk5dsDzdBu8l3XxtKjBRRjcI5Xk=;
        b=BIVZ7LWlavdlfRYlbx7+Cyv1wPE01gFo5yFfRCjV6x1dMEYURniTVFEKOqz5njnA8b
         EXLE3qJiTaLmLwrLoz/VGikjDvBcFBUgYKXzyiiGFmbQWMXWytAtMG3Fk1JVMs6NQYik
         JVg9z4Xa8tbAoAKFikoqJphk+qccu8jRQ8yBvtNjy1LpVQbbrUBtmkOEtWEyi0leOjGn
         Dga6XJaNBJCTAwskIEnPV1ED1RRyHrRi6j+azqOG4Uw8JNe+qlKjjHhzslRxwoz/jfPU
         px64RoD8p8YV/0oeUTz4OA93yHxfXckXOdaLqoZ7Nz8wV+aY84p2QckXh5k0pFimzBbu
         noeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727885706; x=1728490506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYO4VdlmtMCxwpF5Tk5dsDzdBu8l3XxtKjBRRjcI5Xk=;
        b=fRTkLmbQDh5BWAQCCA5sRzY/B416Yt+XPRBa8FMrVzjNjjWQRvkNx9YCSVnxXNqTsS
         1KZnhGOu42HPn5LqEgB7Q6bDoeSydNIUiPStxhUbHRw1Pm1aFq1rnSFfPcem8SOsinDa
         /iJI8kpevrso1tRPH/uLZPmkKnOOnQ39UZRjjp8ZwieSK3sp3WK2vvPINUnSxD4bJMvi
         0RCqVVluU3yFcz+f4t5fF6Op7T4Yq0aeXYZfMR8kUo5oxSHilSFZHoNW5ZPkY3BnVBfJ
         aZvkM6U42Ad+tutdnES3SHh4LntBuAwzxOQTRI20aBQKfPxh35vJ9sCur/K2lrVcUGWu
         c6ug==
X-Forwarded-Encrypted: i=1; AJvYcCUQHOOvD4EjXjXu5Cmjn8N+/YpKPn7XNA4/gljKkjW+6u9DXrn6PMS0M8RSp0w/9fTQhZd7vk/ZoUXJBDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZg5nvR8X/K++y90bU/PiQqoUHM3AZWF8X91MizSm7w2A/3tc
	avJMvE/DMCZjCIURO4hhRM4dcbn3jpt7Nbl+IDqUL1NCXrpDybopxgmMzoODcnasUA==
X-Google-Smtp-Source: AGHT+IGRrC8thTOMM5BEOmctr4GXII/lvD3k1/5agk7+QIaVIvttx4JysDf6DQjgKGKPdesu9x54Kg==
X-Received: by 2002:a17:90a:5603:b0:2d3:bc5e:8452 with SMTP id 98e67ed59e1d1-2e1849421famr4474757a91.32.1727885705771;
        Wed, 02 Oct 2024 09:15:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a74:2681:86c0:75c9:539d:76ad:2d54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f911e8csm1740747a91.47.2024.10.02.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:15:05 -0700 (PDT)
From: Xiaofeng Lian <1198715581lxf@gmail.com>
To: stefani@seibold.net,
	linux-kernel@vger.kernel.org
Cc: Xiaofeng Lian <1198715581lxf@gmail.com>
Subject: [PATCH] include/linux/kfifo.h
Date: Thu,  3 Oct 2024 00:14:37 +0800
Message-ID: <20241002161437.376042-1-1198715581lxf@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some IDEs, when using the ARRAY_SIZE macro to calculate the
buf size of kfifo, an error occurs (using incomplete types),
which belongs to the compiler INTELLIGENCE reporting error,
and can be compiled normally, specifically due to the gcc
compiler's __builtin_types_compatible_p function. Because the
KFIFO_PTR type uses a zero-length array and the macro definition
is a simple substitution, the ARRAY_SIZE macro will report
an error because of the zero-length array when calculating
__kfifo_esize in the INIT_KFIFO macro. Notice that the difference
between KFIFO and KFIFO_PTR is only whether or not the buf is inlined,
so (sizeof(KFIFO) - sizeof(KFIFO_PTR)) / sizeof(type_of_kfifo_member)
will give you the size of the buf of the kfifo, which bypasses the
compiler! Intelligence and bypasses the possibility that
ARRAY_SIZE may be passed in as a pointer, resulting in a compilation
error.

Signed-off-by: Xiaofeng Lian <1198715581lxf@gmail.com>
---
 include/linux/kfifo.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 564868bdce89..c080716b5125 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -123,6 +123,21 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
  */
 #define DECLARE_KFIFO(fifo, type, size)	STRUCT_KFIFO(type, size) fifo
 
+/**
+ * get_kfifo_data_type - macro to get type of kfifo's member
+ * @fifo: pointer of kfifo
+ */
+#define get_stack_data_type(fifo) typeof(*(fifo)->type)
+
+/**
+ * __STACK_SIZE - macro to calculate kfifo's buffer size
+ * @fifo: pointer of kfifo
+ */
+#define __STACK_SIZE(fifo)\
+	({\
+		DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
+		(sizeof(*(fifo)) - sizeof(__tmp_stack)) / sizeof(get_stack_data_type(fifo));\
+	 })
 /**
  * INIT_KFIFO - Initialize a fifo declared by DECLARE_KFIFO
  * @fifo: name of the declared fifo datatype
@@ -133,7 +148,7 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	__kfifo->in = 0; \
 	__kfifo->out = 0; \
-	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
+	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
 	__kfifo->esize = sizeof(*__tmp->buf); \
 	__kfifo->data = __is_kfifo_ptr(__tmp) ?  NULL : __tmp->buf; \
 })
-- 
2.45.2


