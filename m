Return-Path: <linux-kernel+bounces-517020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE9A37B07
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FF2188B939
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3355185B67;
	Mon, 17 Feb 2025 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4K0D5YVM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8256137750
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771037; cv=none; b=izt+Udj5nYGAkonHJk6ZRq7RbGXSNI1CK5j7YZDERQydwSF9ziSDUErCK+7pTahct1mNKmO+mYJ9r0q3xPjth1BFC5R3LvfB1Wz6LcBzu/Hi02xUo2OzyDlhPKLfKTmyoq3azQx7GYXhbn+S+G2+W5sFqupEjmpdwDTZGAdW6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771037; c=relaxed/simple;
	bh=m2nxmlGiCOW1ssdyHolEPPp2zAKvYhXgcwhTcSkeLSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pRQvj0cFLrf5YOyPHBWGg70d1ppMZqsqCY0XY9H+9Ii5TLqg5cLmK2iaHNSSm0FUCfMMuV1hqhLSPDwxpRqFkHT1VcufJeuxA2nhHVQGwRgkjI72gXYOCMr4iWTBiGwJmKRgr4Q06j2ZjWWsKSO8Sp3nqrywWEroj3Si1WJqhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4K0D5YVM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc5888c192so2189941a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739771035; x=1740375835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DFoMPtCCzyh77IMw9FPLeBJxc6vEmk29NKQF2BraGR8=;
        b=4K0D5YVMk2kiTufXoFmP+iAaFa3JrZ1M62gtTI/tGq0I4KoCLIXQyDifEbHX0xnMB7
         rfcx//y7Lo+8l0PZpnddHsPAjBd7sKx8ArNpsb6imjolnH/NmyewpiLIPkZGd5D0KLfB
         /Jl9KsceAf/onjegp8Qg8/J+d+lKuXezu2f3T58pK0DgtwTgEA3NFyFpvwmAvj4naZeB
         yUlG9q5sjOoVzn0QoCpsb8Tg32ifmIfZbhokmwxJ5lC/ErknUqwbCDlWl8W82COiCQl5
         9aTNRZVD6G8HtESR7whw+Q0MprdtHfe//bEVjJ4MRmvnXazHVwPOQrg4g+8aDMc/tZa4
         6DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739771035; x=1740375835;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFoMPtCCzyh77IMw9FPLeBJxc6vEmk29NKQF2BraGR8=;
        b=Y63sNofkS3PGpJf5o03CyRs3UJB02gMMeQJR9IzQ+IuaFm45nZFnV+S3BII2Vl3nzy
         7IaJiaeXZtPbD/A8MQZYgLmouHtfa3ebgyz2VlprFND/A2XC1gulh8XOK+A54rePOv5+
         agVp2TkeDEXt4O8DMqGYUATranc0EMGRC3CGmITO5cW2w6wxEdaaAmJt9Rs5WJo6jqZD
         p6FBGSGAUrhrBPk9TFOdGB2QzbnMUVAGicKHH5B/xevu+xzyiy3TMkO7cW8hxPgFapli
         LSHQHKzpQI1ZMtxExdODVjTYe6m3Ne6teaiAjJJ2l/aaMqeEpy7GrRvUhXevBziUNZMq
         7TBA==
X-Forwarded-Encrypted: i=1; AJvYcCWBoqbGvsyJqX0sI8/IesG7oFRQd8VSrsmXB8b4VRVDp+sSYQdCDVZXsD3+fAcqCO8XXX6ovyfnquCaayY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xtwSyXAW2uQkzkFMH5jLH6gqZf3A/C6YihlXX+3gJax3TZvP
	DCIr53KH157K9bPUIs9ICjuMW00ZwV/z81DMpo4JlT4nvJQb+GpG6irO5iHqbEVDTzL5ciY0/cM
	kXg==
X-Google-Smtp-Source: AGHT+IEOIn9RYGtvux1lrk967wEHGTTg9GGTSq1zzpxzbOkqMJ5gnRYyBgUANO0B80gvOdywOZtFGtHaqtI=
X-Received: from pfbfh25.prod.google.com ([2002:a05:6a00:3919:b0:730:5761:84af])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:13a1:b0:730:8e2c:e53b
 with SMTP id d2e1a72fcca58-732617802eamr10978562b3a.5.1739771034988; Sun, 16
 Feb 2025 21:43:54 -0800 (PST)
Date: Sun, 16 Feb 2025 21:43:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250217054351.2973666-1-surenb@google.com>
Subject: [PATCH 1/1] fixup! tools: remove atomic_set_release() usage in tools/
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	jannh@google.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Userspace versions of both atomic_set_release() and atomic_set() get
translated into uatomic_set(). To avoid extra definitions of
atomic_set_release(), replace its usage inside refcount_set_release()
with atomic_set(). This results in no functional changes.

Fixes: 1465347e498f ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502170049.sHfzQwpv-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/include/linux/refcount.h   | 2 +-
 tools/testing/vma/linux/atomic.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/include/linux/refcount.h b/tools/include/linux/refcount.h
index 1ace03e1a4f8..1f30956e070d 100644
--- a/tools/include/linux/refcount.h
+++ b/tools/include/linux/refcount.h
@@ -62,7 +62,7 @@ static inline void refcount_set(refcount_t *r, unsigned int n)
 
 static inline void refcount_set_release(refcount_t *r, unsigned int n)
 {
-	atomic_set_release(&r->refs, n);
+	atomic_set(&r->refs, n);
 }
 
 static inline unsigned int refcount_read(const refcount_t *r)
diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
index 683383d0f2bf..788c597c4fde 100644
--- a/tools/testing/vma/linux/atomic.h
+++ b/tools/testing/vma/linux/atomic.h
@@ -7,7 +7,6 @@
 #define atomic_inc(x) uatomic_inc(x)
 #define atomic_read(x) uatomic_read(x)
 #define atomic_set(x, y) uatomic_set(x, y)
-#define atomic_set_release(x, y) uatomic_set(x, y)
 #define U8_MAX UCHAR_MAX
 
 #ifndef atomic_cmpxchg_relaxed

base-commit: b2a64caeafad6e37df1c68f878bfdd06ff14f4ec
-- 
2.48.1.601.g30ceb7b040-goog


