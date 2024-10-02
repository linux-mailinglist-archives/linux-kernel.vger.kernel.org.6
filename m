Return-Path: <linux-kernel+bounces-348019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1998E194
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D691C224AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EBB1D1517;
	Wed,  2 Oct 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMXEsf4q"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1D1D150E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889878; cv=none; b=Y4lD1a2II3j58r7oKiNnlpFmPKX9sTUVBxYceC6LWRC1MWpgPho7WAlhjlMsQm10MOATXPqLLjH/PtilE8Y0jG+WFnKrmLeDnJfNUp+SviGt7vuOH7K8Twl+IxKYdDV9RgnD6etKLTkTfWlWe4Dd/Id46/0l27GsiGL3fQ+FOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889878; c=relaxed/simple;
	bh=qTfrT6tSKk34g0+2DBj2RYAUGB6l87ND2TBJVf7hYnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njwcpXQAehc2Qa077knpP0wQd8dDC13AsWnxiVpxcpDor7p/n7GOdBut7jWIyhaQnC/ZU+YYjEsKXhd4yVAHqAv2lZSVxAPeVxOwMhV9jCfuogqZynqDFVSU3e6m9LUujTvHzgjzVzrEK4zBsen5jM/dZYxgy8gAZdwUEip0dEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMXEsf4q; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so73222a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727889876; x=1728494676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IRjOVdheql2hwKCJ4a5UbL/LiNP2NWCqCgy3cOOTpns=;
        b=QMXEsf4q/moojnU4jsRP7w6X0Z2qNfxg/TrBX0W/0oY/P85qp/PXnvqdM70nN1TTJL
         T97SbbQYluMZzTwA+3KR45unGrZ436Ry7nr0egzNWU76292NZJNcIiOnCtS3ILiwU0tR
         TTXt14c3ncoex1H4HSNBXrUstdAXNZETxeyaOhqUy5wR9CPVsmS6d/GqBfRUoN3sM3wj
         /C02cBa8h+wL1lAolxF7UPk/zgAMJXMrm5kd6PMCkxSF+S7Vy/YhaHx6J4f3LcLBEPH2
         PgQpK6yHavw+5HNdOKZW4xDg1YSfnnaHoRJ2dzjN1PfK9NRRYAe/CeIQbcHO4+H9mAZl
         7tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727889876; x=1728494676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRjOVdheql2hwKCJ4a5UbL/LiNP2NWCqCgy3cOOTpns=;
        b=UxH3E/8R7wqmzbiTQKTSJdhKrzTzq8HL9kzTbZda4j6Zahp6ICmRX06pJoip5aSVLc
         Cstq9YabmXuEqUBQXi8TB2iNPUt6NumDtoe1CcNgffLtwKQOdW0WScyg8SlT6siWPwt1
         bUhZr5mmQVtoAmu+VqGZtAMcx6vvVeZobB6JGpYejacWA8IT72cxTZs6Fh6228IJ/aOT
         aE9a9mqYQ2I0dj5o8Al9QZdPhKPsIHsMSQ3kEo3LUeeNIgVI3TDNDwxd4OBIG/HXI8DO
         gxot7EmWLYejenWXT16CLhi+lG0ujE4pa24g6L2kZkhRy/TtMt8JLw9VeoneRfdcTlzF
         +CQg==
X-Forwarded-Encrypted: i=1; AJvYcCVNHkfuKtvI6lU37suw0KDmMlVIoHBgz+sYGdGtOgez/42suPPsyjFGKgOCSiZe0XpoWc93BKlvzkEQDu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMOx70hp0iROf6pBldU+mu0ryQUVe/7itQjqpHQnXSYF2QgCwY
	rIhbR2AMvwpERhcS4gBIltPxemuCsTCq3CMl3vFAKjb7Q0tBtGhH
X-Google-Smtp-Source: AGHT+IEy5Pw5ajtPqBNBsP0jPl1qGfJcro5uSSYQRWnVH0s0wCZXhtSk0nBQrEs1Q7fggc78K9b71A==
X-Received: by 2002:a17:90b:141:b0:2c9:b72:7a1f with SMTP id 98e67ed59e1d1-2e184900890mr4515905a91.28.1727889875793;
        Wed, 02 Oct 2024 10:24:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a74:2681:86c0:2354:bf39:a278:de0d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa55002sm1844123a91.50.2024.10.02.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 10:24:35 -0700 (PDT)
From: Xiaofeng Lian <1198715581lxf@gmail.com>
To: stefani@seibold.net,
	linux-kernel@vger.kernel.org
Cc: Xiaofeng Lian <1198715581lxf@gmail.com>
Subject: [PATCH v2] include/linux/kfifo.h: fix some IDEs Intelligence errors and the previous patch was misnamed
Date: Thu,  3 Oct 2024 01:24:25 +0800
Message-ID: <20241002172427.412715-1-1198715581lxf@gmail.com>
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
index 564868bdce89..e5972c2b10f9 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -123,6 +123,21 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
  */
 #define DECLARE_KFIFO(fifo, type, size)	STRUCT_KFIFO(type, size) fifo
 
+/**
+ * get_kfifo_data_type - macro to get type of kfifo's member
+ * @fifo: pointer of kfifo
+ */
+#define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
+
+/**
+ * __STACK_SIZE - macro to calculate kfifo's buffer size
+ * @fifo: pointer of kfifo
+ */
+#define __KFIFO_SIZE(fifo)\
+	({\
+		DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
+		(sizeof(*(fifo)) - sizeof(__tmp_kfifo)) / sizeof(get_kfifo_data_type(fifo));\
+	 })
 /**
  * INIT_KFIFO - Initialize a fifo declared by DECLARE_KFIFO
  * @fifo: name of the declared fifo datatype
@@ -133,7 +148,7 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	__kfifo->in = 0; \
 	__kfifo->out = 0; \
-	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
+	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
 	__kfifo->esize = sizeof(*__tmp->buf); \
 	__kfifo->data = __is_kfifo_ptr(__tmp) ?  NULL : __tmp->buf; \
 })
-- 
2.45.2


