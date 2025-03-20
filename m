Return-Path: <linux-kernel+bounces-570220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33F2A6ADF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC474A21C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4D230BFA;
	Thu, 20 Mar 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV84ojIv"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105422F160
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496819; cv=none; b=JsGYT7aFnfMbwu05SXXAWiZV9Vdq5uW7ayz2DQtaJ66WML6ZbxIuiLq8/gdHAzWOPtN6FIXwuZGbjaNlp/iADqyBWQy3S2XRngYjd6gyav8xIWNoqhAiQ8aqcgm2KZOBpHrafz5PzH1z2NAn8xpv4crBBXKaOh7XxzaLw//P0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496819; c=relaxed/simple;
	bh=XnYFPjBXkniGXAmm7wMWDWt6i8BfXNBL/ITGQx1xuUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoLS5aPFcu7dWmbd3QYFUZdR6AZF2yzcG1XTfU1ed0zwLZx7hnRyaQb1gJYnxyLt+XUQH7g1D8txar/RERpDRd2MMaodKfTWaCs3XKq9/FTmH9FX35ckTNt9h7b+p3Fe/d6MZ4D4N6oCPB4sB9kt77zZPnoWlHC49yrpEQllJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV84ojIv; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b43b60b6bso41405639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496816; x=1743101616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A97O7SqLaZSxvMXU0joWzVIjgf8LaQ5hosLUzwNwu64=;
        b=TV84ojIvVcQQ7O0jcXgryvwPBzv331Y1ONP1T4bLaa4fwkebqgiiMF73hwB5lOqh/L
         7iFe/dne/lZjs+t0yWFFnLNYupdJpeV465Ey9aW74hAhrI540xI5omoPCy7A0lnC523b
         W9DnSY1rsJMBZFlM7vjRgDkA8f0NK+DMpuc4MN+md/f44qr5Qn/3GHAKwTMcTpVpETdO
         ZoLi1iNKcqQ4K7eWy5MMAv9Qc3eqwlEJJJnnIGT1AtFSatODTlqPewU/V1oE82wY4u+q
         niwVcZGR6w0QQPKEZ8YwkFILQE83kkaC005gx5MJBn/gdIwL3bwZkLfU4YsqsXAK4pwA
         PXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496816; x=1743101616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A97O7SqLaZSxvMXU0joWzVIjgf8LaQ5hosLUzwNwu64=;
        b=c/peqt0PmZiGxXGvl9SSCx8z+GFk3vvgYm3FzdKt9rB+QnEsYwnqedUWGJKPGzrxRL
         qRPjKlujU1Py3WMmqeE/USs2laq72UjswOb/f8nN+R7DqdijfzjE/2pyzdIjJSXUXmjq
         9rQaaQp279LTKJiziif2afQCQd+6DjekiaS4QeJhc/RyiiDknW89qkgwiITR9lGdr6MN
         LbEWDo+V1z8mnMJSR/TuPyLUvB+wIXjMrJzZpNIBz61bY3cK0m1fs1ThF0SAJ0EQ3jIL
         3z5KTaIxu/NUiKEFO5qENsy2RIiVTXJkk4xOA8irq7AM1rz0r30/vTm8jfLrAXf94j+m
         XrkA==
X-Gm-Message-State: AOJu0Ywt1g7r1xX2oUQtZAfhQctVIjKtloCSjVGVM+/ijFVWkZlvNrAw
	KRiP9ouzKcA71NWwDHnW89Tf08S0WwxhJoqhI63UHoBqGQ61ESp3P6kv9FmQ
X-Gm-Gg: ASbGncsmCAAn+3bmZs/oixroFNyu5pJidrHVkUm1fYwENtNJ0hW/Xuy38xudoZguPxx
	Le9iqF7a+L0swJu8JwJMaXZBQaRXBNQjc+5wPTtmE7O/xAV7i3wSyxd1Qh5w4iL+0m5U98MQFh0
	OMYZfYU0UzZtqp852K16ycytWQGiTgkDURhlq9ZRlEjq8uhu/8jJFlSrp25tRR8aQabhdVhA+1X
	/U+CFJOJ96yasnFoiTXm5xFr1x57i8ERRxx6TOAzgaC2gVxgs8FrE+JKQia9/UOhsBunxZrc+zB
	AoS9FZzM3XUufAV2yE+zjoIg8TuVOIURqFrPq+tURhV2k1WvVU6SxWf5hdnPNXML/FRq25N8s4e
	ISw==
X-Google-Smtp-Source: AGHT+IEBYa+5JQp3odGDvBn5sd+cspLcMtd4IINkheV1kDJq50GiYDaoG3E/JZw5HEYKr6Z/40xHfw==
X-Received: by 2002:a05:6602:6a89:b0:85b:4cb9:5cf6 with SMTP id ca18e2360f4ac-85e2bc71838mr79684139f.0.1742496816493;
        Thu, 20 Mar 2025 11:53:36 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 29/59] dyndbg: change __dynamic_func_call_cls* macros into expressions
Date: Thu, 20 Mar 2025 12:52:07 -0600
Message-ID: <20250320185238.447458-30-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
(expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=y because
the invoked macro has a do-while-0 wrapper.

   if (cond && (drm_dbg("expr-form"),1)) {
      ... do some more stuff
   }

Fix for this usage by changing __dynamic_func_call_cls{,_no_desc}
macros into expressions, by replacing the do-while-0s with a ({ })
wrapper.  In the common usage, the trailing ';' converts the
expression into a statement.

   drm_dbg("statement form");

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
---
 include/linux/dynamic_debug.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 8043966a0fd6..80bcaad03400 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -339,20 +339,20 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
-#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
-	DEFINE_DYNAMIC_DEBUG_METADATA_CLS((id), cls, fmt);	\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
+	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id))				\
-		func(&id, ##__VA_ARGS__);			\
-} while (0)
+		func(&(id), ##__VA_ARGS__);			\
+})
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
 				func, ##__VA_ARGS__)
 
-#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id))					\
 		func(__VA_ARGS__);					\
-} while (0)
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
-- 
2.49.0


