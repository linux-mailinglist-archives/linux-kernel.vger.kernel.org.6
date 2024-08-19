Return-Path: <linux-kernel+bounces-291621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778769564D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA70F1C21508
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF7E157E82;
	Mon, 19 Aug 2024 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsQLf6Dj"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678D14AD3D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053304; cv=none; b=WzZhXTalxYJPDZQFbxiozob2z0ZudKcfXwBdCtcGjvwBSDabn8xor5z8VQLN6y86e2W2JJpQIcWNAoSiNuJP40DjsU9faytBUhMXa+fg7GRL4zn56CZQNkQeaM5j6TXG2JJhNE9haBp4e1xJSvDNfkN30y3VYdfrsPUfIpCWjLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053304; c=relaxed/simple;
	bh=pMOKM3RBsC847tUB099K/Qd4wLcn3O1RCtfoiU2rU1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msRxvsM4d+YUS+ZcELfqs4lK1jZpqz7+sG+6X85VqwuWBK5YJFCfdQTpExlmSOcZueLL337wTo9KcYWSrNiaqzIZPyg+hhFZaQU2NHkEJcb+7S38XoRIG5Ay7sqyn/A3s+g6Bl/EUsI8RC9aPihtmemGFuxLxYvPhzZxh6LB3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsQLf6Dj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a94aa5080so454093566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 00:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724053301; x=1724658101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4BNLaKPQ8H2b7/0myD7ZpvHq9yb9ugQtH6z/mwVSiE=;
        b=TsQLf6DjFzkN7im95bHmPvsZdOmT3fik4tLHhsU9DaMdalOYRjXcorRaReFCTZv1xs
         muCWfYivOjQJo4ok/HsvHbbAuj/J1meeA+0wor8F5Z4xYLgM9o3EOIRH9RWRHni4bwOw
         sd0taHhb+Lo32+GS8yBhselKH1y5G51GisVrcpqL/8+OAg+KPtOkchrfRawsRrk9+JqV
         C+FKogV43Fb/5/aoQtPIzdDAZQqFU5at4uq6srlpRpWm8oIqIWfl3Q5nGbGsUw3dN0bU
         iepQ82OEOBVIiN5O/T4DheqkG2r/Bv8yo2WE2FDHgwdgnL1TkwoF5saT2BZ+7I0qAdZ1
         M17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053301; x=1724658101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4BNLaKPQ8H2b7/0myD7ZpvHq9yb9ugQtH6z/mwVSiE=;
        b=qG07tcsD0gJNYFj5OColfYu1To+ZtcFnY7k0VHQXwD18bu2o8/HHjFS98OihYC7+cI
         DSCTSnc7jY76wgy0w6N6PTVX0DoFN0Ug9Kh8bmrDy0aCq2DJN442lK7ZQcixwZ6iFMFh
         lt3Y4Qb1Y+bef5YooTWluoV9dpZBhKdX6ZJQcO+zX8aXZ8N8adw66wKjLpaE6P0qd88h
         FQEPhk42zZ4SWZjmJ8HHMFCn3xQOi66Ywsfbe3LN5n9GxZebhR+DqHbpNF9GhBxgnHsJ
         ipVRxEFoMJ0VgVwDYCVQnTPvMsvaekoOa2NNVnJKnho/EOAXEOp593oWfOe0+/jo4VBl
         9eqQ==
X-Gm-Message-State: AOJu0YwnBh+uAdKB7hNTWIS+hCt0Mz4mawHuXXCNuxQkKSV2309VvSfy
	Ld3Ja0Fy7pDgKHrn8zGPKMV+KumM3w5/mSLk43yCRDjcTCVgqGxyZjO5ts5v
X-Google-Smtp-Source: AGHT+IGPw7qhaBFVt9/ceZnnt1oC2wT45i5hNIpKz9Kf1rRA8pXiDQxeXeHb/+jbWpbKyU8tTSJgKw==
X-Received: by 2002:a17:907:3fa9:b0:a6f:4804:d41a with SMTP id a640c23a62f3a-a8392a03a86mr724050166b.55.1724053300332;
        Mon, 19 Aug 2024 00:41:40 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383948d19sm600006866b.186.2024.08.19.00.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:41:39 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH -tip] cleanup: Remove address space of returned pointer
Date: Mon, 19 Aug 2024 09:41:15 +0200
Message-ID: <20240819074124.143565-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guard functions in local_lock.h are defined using DEFINE_GUARD() and
DEFINE_LOCK_GUARD_1() macros having lock type defined as pointer in
the percpu address space. The functions, defined by these macros
return value in generic address space, causing:

cleanup.h:157:18: error: return from pointer to non-enclosed address space

and

cleanup.h:214:18: error: return from pointer to non-enclosed address space

when strict percpu checks are enabled.

Add explicit casts to remove address space of the returned pointer.

Found by GCC's named address space checks.

Fixes: e4ab322fbaaa ("cleanup: Add conditional guard support")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cleanup.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 9c6b4f2c0176..48da01c1c082 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -290,7 +290,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return *_T; }
+	{ return (void *)(__force unsigned long)*_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	EXTEND_CLASS(_name, _ext, \
@@ -347,7 +347,7 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 									\
 static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
 {									\
-	return _T->lock;						\
+	return (void *)(__force unsigned long)_T->lock;			\
 }
 
 
-- 
2.46.0


