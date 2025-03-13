Return-Path: <linux-kernel+bounces-559395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27630A5F33A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF91A19C27F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1612686A6;
	Thu, 13 Mar 2025 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhFfb65d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CC26A0D9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866296; cv=none; b=KNP/VLr2EjJf0FKoPYLUIUV6ocZENg5QKoykImp/JCAhAtaHCG9by/iFY2ocnAO3COG5muKVGznX2ZC1A4ocPmx1d5Ndrng2/YLL6yHTWx4Rp/qxraNmjN8ZbVptvyHE+4zykouqYcKRQ0j/E8HfXd3z9g7Rx8de2iRiQ69gq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866296; c=relaxed/simple;
	bh=J4X8YZO4x00QVWpFsvAbnTlhyYgUvXZEkg17s47TCi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=hnclenmufB271fKsIeNSqrUbEz8vDNO9r+6FEK2eilmZKWOm9o8gDzrezh7PIBV9eammpWxG0bH/1U2z8DNInW7k6vWAYMejCCwQZFLkcKw12Xa6fftubvjcVyhPTaYxsUr6OnjnfsVgnXayU0pZ+vtGHoOc2fCV5bI7WHNiU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhFfb65d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdALik7flTFVSWTVblU8JKKGGV2JCoENkhxrfjNtUxw=;
	b=JhFfb65dbLIFuTOsmZM5CyAKYRE/nYHwuuMUhfMFJXL71ecgONeVT5sCU0JRbnXWD4mjRw
	lvGo4rzE2KKAHaAR6Sjbaw7cgLxcwbzmlOQn3InlGswLBFVfjH5CFHvADo36gSWlI307hK
	tLxIwCyVHTjMXtBBhaYy7bzTtx3Zz7w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-1j0kVaVQOHaMzZWoXK7r2w-1; Thu, 13 Mar 2025 07:44:52 -0400
X-MC-Unique: 1j0kVaVQOHaMzZWoXK7r2w-1
X-Mimecast-MFC-AGG-ID: 1j0kVaVQOHaMzZWoXK7r2w_1741866292
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391459c0395so372331f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866291; x=1742471091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdALik7flTFVSWTVblU8JKKGGV2JCoENkhxrfjNtUxw=;
        b=J9DO42BMa/bho1dU/p+hN0uhz9zj/LOTop/nhg4N715ctGv9LWvi6m+GPAPgYgC+bS
         MZK7ZSnz8chklWT5HiQq1fNogAyzvcnXjaunRhxEKNJenQbkoGV5SEuQshys7L2Xdk+6
         OUGqNrguNL7MpUP8ZHE/bPImivDm/NilGQXwKIzUYO45iKrI2TwuVtQMeYyB/n7Imokb
         jsyz5byWYCx/7lHm5PjWEzGrpOB+jSvE1yMHLSaCKpe+ApZd+3/4pYAlvOMbRrBj/4zF
         jbGH1Czp+9g9HKKbRfl7adhTszRLM5esyoQf5eON/+93qmBb6TC7g6UuW40W1fxlq8Jf
         nUpg==
X-Forwarded-Encrypted: i=1; AJvYcCUxy3Dl5l6IG/ErPE+Wn/maRtRdB2DyU0zWTSknhPZ5ac2ZlTLB+d779+Bj/cfaScQ7PD07YkyLQyxl7Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomG//58CrTCbrkMydeh5EBusauq2XKAKzqlHBS4qddz51mffV
	CIgrqeOv5K44qYC2S6x16vlv/XkoBir7S4cUORgQAZj/g6cikcDi7QXD8B+F2EGceFZelXe982W
	P3J+QjlU9yLCcyNxhnwg2KqEN2UeIz2GzcWE+Qs5tR8DNE0wjkLwm56SV/KABjA==
X-Gm-Gg: ASbGncvkDMNgOkQ75KgiTTp6BOaoLA1eEY0nJkwTEbRiBsEIdgQ+/0XWotcWuBLqb/5
	xMAJQxkrsgkwC+gxXNOVwsr4HoKSpyYUTiruCprKDguZ/aSA+ez8Ci36Cv2QeqqtfpNLEkHgHjj
	JNsytS022VB+D4gaeeg8hYEEC5CuPQpzYfVGA0LPisSvEqJKzoPi8n//GvGY3EkFfhooBJK0Lyc
	Ic1HQfy1JeMK+500+DG3IaFhifLSMMAfsB9G3UtNYsmq/rCzr3uGTSiMuo9zSPO8v4SY8GLMzAV
	No/zXdAmIt897yCVQ7TA
X-Received: by 2002:a5d:64a4:0:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-39132db7543mr19148458f8f.50.1741866291578;
        Thu, 13 Mar 2025 04:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc68icOs2UFLsGvYM02K+KaAXrxdUkEYYl5CYIXnV4BsTbvYwzMB6bzWlvY18H1nYSqaV5qQ==
X-Received: by 2002:a5d:64a4:0:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-39132db7543mr19148405f8f.50.1741866291178;
        Thu, 13 Mar 2025 04:44:51 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:50 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 10/14] s390: Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:25 +0000
Message-Id: <20250313114329.284104-11-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Add name of functions triggering warning backtraces to the __bug_table
object section to enable support for suppressing WARNING backtraces.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
parameter is replaced with a (dummy) NULL parameter to avoid an image size
increase due to unused __func__ entries (this is necessary because
__func__ is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 arch/s390/include/asm/bug.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index c500d45fb465..44d4e9f24ae0 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -8,6 +8,15 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"	.long	%0-.\n"
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define __EMIT_BUG(x) do {					\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
@@ -17,10 +26,12 @@
 		".section __bug_table,\"aw\"\n"			\
 		"2:	.long	0b-.\n"				\
 		"	.long	1b-.\n"				\
-		"	.short	%0,%1\n"			\
-		"	.org	2b+%2\n"			\
+		__BUG_FUNC_PTR					\
+		"	.short	%1,%2\n"			\
+		"	.org	2b+%3\n"			\
 		".previous\n"					\
-		: : "i" (__LINE__),				\
+		: : "i" (__BUG_FUNC),				\
+		    "i" (__LINE__),				\
 		    "i" (x),					\
 		    "i" (sizeof(struct bug_entry)));		\
 } while (0)
-- 
2.34.1


