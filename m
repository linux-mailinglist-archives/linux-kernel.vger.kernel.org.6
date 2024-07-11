Return-Path: <linux-kernel+bounces-249828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F192F074
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2C3283D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993F616EB4E;
	Thu, 11 Jul 2024 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxmTLU0R"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA48BFC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730791; cv=none; b=jzrqttSdmUxzO6zreRr358hG6vNc2ZeH0K3GfSLUHIEjyLoVkXl0mpILfdxCHcbjzy6nZDGYwRnJf0IzrgbaMBsDneUgE/z4hULos5KWEkBwP5F2cEytqxjYfbIEU9wPSVxiiyOJdytIxwwvI+lbvINTbO3x8rn3s8puAXapufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730791; c=relaxed/simple;
	bh=XyehR3DLyZgYwH8e/DpDka8HDZxX4cthpMcOdYREdb8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L+chkZ+yMb82noUHFOi3hAnBCSj+RfIk2QaJPsRfncfU9j9YJ11BxrJOr8n6o7cYZHTyBP2uejxqYko4Do0mVkSX/QYiR2gdeRqg8SHk6PFc07i/EV4oJGNraFEsziuFS+fQQDF0qqdaARoEXdrIIpB+e797MulzgyZN4pZykK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lxmTLU0R; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65bbd01d146so18733037b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720730789; x=1721335589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iqw7bB5EtRZn2HsYQyPavRWErefeL3ZC3fHJdpwKJ1M=;
        b=lxmTLU0RfF+5aAYgM1A/cFXtbV0axK0ZmkFNwhRp+rPrTrv8P4HSfFJpdSKiALfywk
         l4CcfkvQVn5RvPwLF5IC91PSIubfTBn321hd6EWyMzDAmKMeK3XZA4LRe2QYEAbUrBVT
         5iDLBjaSbciON0+EtB8i8T5pFptuOSsL1h6A4Ed4fZVrI43oXTmE9Lhu23bCgjOT2WPJ
         zgjDFe7Jy0HkmMdwkiaatOLSRAiOfJg1gwtvbZN7uqvM0aBobsLzouxkfo+sXA0m+5IK
         NjWGj/sFaLblclxHoaU+Qoo5QzO4UTHt7sNqFz3QjFozs76RhZLKh63Dz/7B6pIcmzrs
         IHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720730789; x=1721335589;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iqw7bB5EtRZn2HsYQyPavRWErefeL3ZC3fHJdpwKJ1M=;
        b=AqiLePEkUqIpDtiTXlJzgewKGv33s67VkBC8KV/sPgLCmml+uJHC3QbLCRW7784INB
         5iw4sp2sy7qhs5xjBI801v5TJaqfnOIl1Z9NSf/T4IfyghOQLy+98zZbe/xFpmwLwlmH
         auZmF4pU5Y6nFfbbK0TW0FPtansOUw6vnNKjfId+NIWS8Y7AC609Z+AjWb2vPI4XT+xE
         EZyvTJWt7oWGsUFGWXEhsgYGJjvDWQwJXOlGouqD+9cy89DLF2hZnwplA5vEyRzm4ofP
         no9QwT1QT5WXPfO+LE5W8ke/Y97Casj6RhofFVu6VQe8LjB91YxUvrfbSoJT3N4UZkC0
         CnqA==
X-Forwarded-Encrypted: i=1; AJvYcCXO4j3LExMCxWfMZJMiscTGuNsgkZFAH3FHsOqkjc2JIazViKQQ2GHFE8FDjkjCdPjGwIL6m2zK7lf27+g2Jtc/GmcgLYCjSj4pOeR7
X-Gm-Message-State: AOJu0Yz1XULUfG+SRggBLkQLm7SY3bccYppK1sUu3NT4w8m7wgsdLQwd
	v/3bgiSojtgkfxA/Y1B9KgRkUHYppOGdTNJsTTZj/A7hEe0zK/qeLCOCsRNTrppgjw1Jf3Q/0S3
	HmQ==
X-Google-Smtp-Source: AGHT+IH9ZEUDCCO5kgiHI9GxlPSQWXi9xocUYKs1UWHjubk4cXKtT5i5Mw1fHi5ZkC8TDC/xgJpMaTn6a0s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3f97:69c0:dd80:bd4a])
 (user=surenb job=sendgmr) by 2002:a05:690c:c04:b0:61b:ebab:ce9b with SMTP id
 00721157ae682-658eea766f7mr543127b3.3.1720730789420; Thu, 11 Jul 2024
 13:46:29 -0700 (PDT)
Date: Thu, 11 Jul 2024 13:46:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711204626.1669138-1-surenb@google.com>
Subject: [PATCH 1/1] alloc_tag: Export memory allocation profiling symbols
 used by modules
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, surenb@google.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Export mem_alloc_profiling_key, page_ext_get() and page_ext_set() symbols
as they can be used by modules (mem_alloc_profiling_key is used indirectly
via mem_alloc_profiling_enabled()).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/alloc_tag.c | 1 +
 mm/page_ext.c   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index c347b8b72d78..c01f9f4e92f2 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -15,6 +15,7 @@ EXPORT_SYMBOL(_shared_alloc_tag);
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
+EXPORT_SYMBOL(mem_alloc_profiling_key);
 
 struct allocinfo_private {
 	struct codetag_iterator iter;
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 95dd8ffeaf81..57a198c70f98 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -527,6 +527,7 @@ struct page_ext *page_ext_get(const struct page *page)
 
 	return page_ext;
 }
+EXPORT_SYMBOL(page_ext_get);
 
 /**
  * page_ext_put() - Working with page extended information is done.
@@ -545,3 +546,4 @@ void page_ext_put(struct page_ext *page_ext)
 
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL(page_ext_put);

base-commit: 9d9a2f29aefdadc86e450308ff056017a209c755
-- 
2.45.2.993.g49e7a77208-goog


