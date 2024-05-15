Return-Path: <linux-kernel+bounces-180208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A594B8C6B72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB5E1C22A64
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205C939FE4;
	Wed, 15 May 2024 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmVbY18Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E128680
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794089; cv=none; b=FfwWUWKJBMPBJT3EUQqNskjLB4fuBEKiSkQSq/XgCj6OL0SxgQ3h0vN0H37ztPK+iJvkQT7yOIk9C+XxOxoFYA4h3FlNaSRG5csK4WuRo3OCbvbfeMdyt9Sw3FJV7X9Uo6cK5szD61lcXe/1K9So9tosMhrTirmAJ7WcmglpyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794089; c=relaxed/simple;
	bh=ft1sD1izv6Ls/5P8BGtMmhdC2q1GK6uXhKDCovZz960=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jK4XKSGe+cGyBdZap9jLjHf2LZnOFfUL83MyW5pg96iA7vMitv3Dzz+MHysAbIINEuONLnDObSD1qGvr7XYZUHiChXhaHC0aFmu93OnC6g5++7uN5Tyn2PLzOniGz+iqAJxpYzCKGMuI9RcIiN3L5pZh6hxy/uifPN4qPs523gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmVbY18Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715794086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QMSiG36nnnVfJyGDsOKUE/4DTzgz2zsSRWc8YHpsNRQ=;
	b=hmVbY18Q2WZOSNaeCll1zsRPzHLakza7CRovapv9+NrXsYRSNxieLgltJ2iMU5ClXytLDm
	WRfb1Fy77oIsq73NC0by24S4r4b1U/ot01tzwKKOTo1nSfA6FB9a5qlfYTqFseQjVM6Q8L
	YKdtLrvp8XSmdrjdWdV8lfDKaQYgszs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-EhbJqplPOIKdf1_xzsVKhg-1; Wed,
 15 May 2024 13:28:05 -0400
X-MC-Unique: EhbJqplPOIKdf1_xzsVKhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04C3D29ABA18;
	Wed, 15 May 2024 17:28:05 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.226.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0636351BF;
	Wed, 15 May 2024 17:28:03 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bitfield.h: add FIELD_MAX_CONST
Date: Wed, 15 May 2024 19:27:31 +0200
Message-ID: <20240515172732.288391-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

FIELD_MAX_CONST is like FIELD_MAX, but it can be used where statement
expressions are forbidden. For example, using FIELD_MAX in a
static_assert gives:
  error: braced-group within expression allowed only inside a function

It can be used also in array declarations, where using FIELD_MAX would
trigger a warning :
  warning: ISO C90 forbids variable length array ‘buf’ [-Wvla]
(It's a bit surprising, because despite the warning, gcc calculated
the array size correctly at compile time.)

A simplified example of what I actually want to use in a driver:
  #define DATA_SIZE_M GENMASK(3, 0)
  #define MAX_DATA_SIZE FIELD_MAX_CONST(DATA_SIZE_M)
  static void f(void) {
  	char buf[MAX_DATA_SIZE];
  	/* ... */
  }

In the implementation, reuse the existing compile-time checks from
FIELD_PREP_CONST.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 include/linux/bitfield.h | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f173223..50bbab317319 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -76,6 +76,16 @@
 					      (1ULL << __bf_shf(_mask))); \
 	})
 
+#define __BF_FIELD_CHECK_CONST(_mask, _val)				\
+	(								\
+		/* mask must be non-zero */				\
+		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
+		/* check if value fits */				\
+		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
+		/* check if mask is contiguous */			\
+		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask)))	\
+	)
+
 /**
  * FIELD_MAX() - produce the maximum value representable by a field
  * @_mask: shifted mask defining the field's length and position
@@ -89,6 +99,22 @@
 		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
 	})
 
+/**
+ * FIELD_MAX_CONST() - produce the maximum value representable by a field
+ * @_mask: shifted mask defining the field's length and position
+ *
+ * FIELD_MAX_CONST() returns the maximum value that can be held in
+ * the field specified by @_mask.
+ *
+ * Unlike FIELD_MAX(), it can be used where statement expressions can't.
+ * Error checking is less comfortable for this version.
+ */
+#define FIELD_MAX_CONST(_mask)						\
+	(								\
+		__BF_FIELD_CHECK_CONST(_mask, 0ULL) +			\
+		(typeof(_mask))((_mask) >> __bf_shf(_mask))		\
+	)
+
 /**
  * FIELD_FIT() - check if value fits in the field
  * @_mask: shifted mask defining the field's length and position
@@ -132,13 +158,7 @@
  */
 #define FIELD_PREP_CONST(_mask, _val)					\
 	(								\
-		/* mask must be non-zero */				\
-		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
-		/* check if value fits */				\
-		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
-		/* check if mask is contiguous */			\
-		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
-		/* and create the value */				\
+		__BF_FIELD_CHECK_CONST(_mask, _val) +			\
 		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
 	)
 
-- 
2.44.0


