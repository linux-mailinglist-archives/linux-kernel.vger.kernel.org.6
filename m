Return-Path: <linux-kernel+bounces-425861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2241D9DEBF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB332281B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8161A2C11;
	Fri, 29 Nov 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAgqBXrm"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7581A254E;
	Fri, 29 Nov 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903961; cv=none; b=RCaOQCDc6q7c97zJOqmeb0mG0QTo2yfKIDUpPgfQVTFj+L1Uu05KbBwiG+2tPITEXvrrKFoLwhZNRQuT83sBJzX28E9OE0+kAXaphKOAJSJHx3b78gjWWCD9tr0eFJ3Y9XnCtHgKdvx3R9n+0IsYBB+Ck12i35WuB+U0i+rxAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903961; c=relaxed/simple;
	bh=y766mzDXewnG0JbivJcEUbCpwpgfpvFzr7+qqNz4Gdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YlQL7UZWIbLmBaR+VYfNoEmpvjrYRPG5cmD7FdoYoa7oiYgQtvsUUBBH/rTe/uTA12umY9sEHovoDKLVkcYngzHRiVN+vr6NvpVr71UpRQMBhI99rOaKiG2qskAGj73ESRHgMzOY4z6LXIqF6dUGPRGi+ThK9qofvdT8kux0Zqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAgqBXrm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-212581a0b33so18398805ad.0;
        Fri, 29 Nov 2024 10:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732903960; x=1733508760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfX+yFdeCQxzje6xRTY7LEEi8jAxpPxXrlMB+dlCPJA=;
        b=jAgqBXrmrUKMKTI6FEPPHxdMtXTiCvilufZvKxYpCi/WBnsotXDwtmapvkBUT9O6pv
         yehyLwCl4lL7qF1E7sPIPWuYGheGlXtRSs/RdYhxiZps8wB1VbWS01uhNPa1bpztF901
         CXKDQ/rEYsWVNKJgs5cVUpVves0SCEeqORWK/ceKct5ylXMVI9G7EE1XXUSTWDHBBlop
         gWcK0ZM8zGN26x8jmZatZCbvYh638kiv+G4z+PJpnXsPdHHlRea1e/0e0cCXRY12FeHo
         Yov+uyQZ2efJUdIL8bK9Cy80Nt4YwDJNamY1j/UP+KuFaPIAneOHQYBx90bAQWIMX3T0
         h7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732903960; x=1733508760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfX+yFdeCQxzje6xRTY7LEEi8jAxpPxXrlMB+dlCPJA=;
        b=BuO7BO2dH3uVH3NIHODHG3eXuIPNOm61ItJURmeGDpGO4qqBsHr2XkIT3zQuzxrhoP
         UV6il/sH+Bp90rJdKRFEitHt1LyKtCX9rzNO+S/GO2od34OhD4igw+MeN0cex5DnJUg0
         1wYeJcsjk1FmEEtIz/ofinKoM7u0/miiaQ7MpdXnY2sRqHTAUax18dxl/sI+4gJPLNUz
         aej8ShJ/3DiLPi2oH/gJlerbR9aspOp3JU2jzoVgLydUbxlq0owodVqpc4N6InnffqwS
         ncczZJP4VKGWyX/Ry/6wfvjJfKJ082wT61JUsRlekwCw/n6d+2B2usXgRiVTjzRUhg/p
         jkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaPqYexSXJdPerGlSF/dC3OEGDJVxNtVZqQXXCd2/KFTYEhZ1TYhPiSUxm4IfbBV5YvU9UVjxVsXs=@vger.kernel.org, AJvYcCXa+kzlqxyRH8ApuFUYQ/SHAmVIPzU8jlJxOBqF0oSXBEqHw7fY9EhdfuRjUROdaqq1r+7EbBqPRkZrneyC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+LSsTCpjUPPfduDSq+HmRGAl10UIRiM7j4AR0NRnRO0SSwhl
	Sr50D8EcNRggriGN+23UYlOkDL9gmCdOuN/ApzQ1lPkFQuSvV90y
X-Gm-Gg: ASbGncvhJMeMiSw1cE6p2WHQIj0vf4+SWEiD2uXDs3i8XbpQQxinF87850jSEndOuJn
	N/Juyc9w94sp5RzaKeWSw9lDq5WZxZSoXUeH5qwkA+O2ZXvH+S4+WO8/6ApJMhWY67uV//99aGy
	IcS5hGP4Hic5jFjlg8Q+OC5CqWR0Y5zg/lh/pNo3ZWS7iNYv0VSZMYgIUrhBV2AKkSl4H7cqXKI
	z5ig31rNGl77JvWm+Ic/HfmTeW39FWcOA3Gtv+foZKkt20bQIvt9SQHgIbdWDAqVgPFKvr3Hecn
	Ho51
X-Google-Smtp-Source: AGHT+IFf/+4gqeKFLs4tGMa7xUdxdMBgjAL+jG4Am5nBgS4kO81kw7uAfZjauW+bG8mPt3gJXuYqyg==
X-Received: by 2002:a17:90b:1c0a:b0:2ea:8295:cd0d with SMTP id 98e67ed59e1d1-2ee08ecd368mr16247054a91.20.1732903959683;
        Fri, 29 Nov 2024 10:12:39 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761474sm3760595b3a.32.2024.11.29.10.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:12:39 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	corbet@lwn.net
Cc: geert@linux-m68k.org,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 3/4] lib min_heap: Add brief introduction to Min Heap API
Date: Sat, 30 Nov 2024 02:12:21 +0800
Message-Id: <20241129181222.646855-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129181222.646855-1-visitorckw@gmail.com>
References: <20241129181222.646855-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A short description of the Min Heap API is added to the min_heap.h,
explaining its purpose for managing min-heaps and emphasizing the use
of macro wrappers instead of direct function calls. For more details,
users are directed to the documentation at
Documentation/core-api/min_heap.rst.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/min_heap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
index 456cfbc1b8f5..55bfe670bbb9 100644
--- a/include/linux/min_heap.h
+++ b/include/linux/min_heap.h
@@ -6,6 +6,17 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
+/*
+ * The Min Heap API provides utilities for managing min-heaps, a binary tree
+ * structure where each node's value is less than or equal to its children's
+ * values, ensuring the smallest element is at the root.
+ *
+ * Users should avoid directly calling functions prefixed with __min_heap_*().
+ * Instead, use the provided macro wrappers.
+ *
+ * For further details and examples, refer to Documentation/core-api/min_heap.rst.
+ */
+
 /**
  * Data structure to hold a min-heap.
  * @nr: Number of elements currently in the heap.
-- 
2.34.1


