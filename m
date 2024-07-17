Return-Path: <linux-kernel+bounces-254583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CD09334EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA11B21297
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407E54C99;
	Wed, 17 Jul 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q92c68Kr"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9791859
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721178999; cv=none; b=XdmOz5xSbXit39fE17M0oX70gXwIPoY74GctDUsx76QJ3jJMon43nVX5q+JP8a1y2u/M8E1Iiq4Hh5acMPyR1PUBTeYgXJPlgMBqnnZeSaCZFjOzCcR1j9QJF08RyynzVYcPN93MCI5+bBSY+8gvLIJdt0AV7zh0OEw91gEfBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721178999; c=relaxed/simple;
	bh=36ZnYEruNMXzJmeJs7Ee95aE+zNSdiGnPZqytiKVetc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VihodvY6IRJTrX5qGN2kQlBe6V4VlzsKZhgzYgBDUkDybiU8E9ylR/EOh5OnpZnOa+Hi8QEFnKEBWSeTAYUc/qQnSdVqr8JsZkwBtASO7sIN+KGVdKBGeHbZoVjVI609VQ4ixymerC2+lurVSOBGJIiY7OnRqwmxaIiV8oBzSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q92c68Kr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65194ea3d4dso107983917b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721178997; x=1721783797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYs2NQlUzYrTkY7/jBEocDDb/Fk2gTcTv8X97Q6ft2U=;
        b=q92c68KrsZ/ux6DMST6qLajg0wtHl6NLHRwR2u2ZA4u0XLeM/F+m38jdqr+nbnzAOT
         /T5lIJckNl/eJekpYhtkbElXz1SHoA+qTTWTT/6/ccsKFDV3g3LeTrKo6rUpmAEUNv1I
         2sSjsTGNTFUqXGqlCPk8B2lFpWHCwDthiRBhBozycpkvmpjVjqKuIu4LoLHzDtDE4gwC
         Zczztn5oGvIEO9AExUOOKf9ZXM/aNIom6wzhZOJ+I9qYe0tx4YP4jfWS0LK21p2ltZHh
         M6s5ZP0hSB4dfuofmrDAIfP0qUx7EPo1CAWKQYZnOYuPq/aR6aSx4yRs3gOHbVWjtH1T
         1t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721178997; x=1721783797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYs2NQlUzYrTkY7/jBEocDDb/Fk2gTcTv8X97Q6ft2U=;
        b=nTG79fzCk4i1AYsVisaXce35ITHfPTkyxS0uSiXFxPhG5qEUdqJmQqByQw4saZjSd+
         E9zpfj6AQxVufKJ5qq9WNrYhnnCaMZOZbCF5KRMUKAgGxMvDs7gf9NeJwDSb/25nXlVK
         f2In6nmZ/sIpUAC3Om1pWBHXG3JnaaGotYYAqbH1+IJRay8V/7tiBSmtCGCscyN41sYJ
         2XZN42vBi3fVW5EXHQiWKibKvhHdbzckdPlIvIDmJUXjKliYEQBqoQ9HNNE3aTJX71TV
         yDPTOMYz/y9Yod6J6TicDEDHc8mkr/PJJL65+7zN/TAgeM38A9X9QfCTi0dq3xtMPsHR
         sO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGW4vN/zH43ZHOjg7nRcrAeqjJE4tNGMULSS8Fuy9oVE40juNLWCTi/dLk0ZXKzfTSg5zUEUjrA7q+jjD+JIG7aKINID35DPm28pEB
X-Gm-Message-State: AOJu0YzvYfuCdSzprsFB2FSx2rZtQ8JnIf/fo0Ia29VdI4+1aSgKaSAM
	15/11kOK4vm8ZFvHzS/pP0NphiHBoCdGpNWBnRSkoxQk2R2e2dehl5vEHu2QEps57A3kaYHm9am
	Ngg==
X-Google-Smtp-Source: AGHT+IG4pSDPzKKXsAL5A6p3APpsyei6VOH/oQKykr78n8RykTCZ1xTwjZZ801/bXu/vlGnVQoRe9PYRGjg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:9b4f:4efc:3f93:ed78])
 (user=surenb job=sendgmr) by 2002:a05:690c:19:b0:62f:22cd:7082 with SMTP id
 00721157ae682-664ff8d9a69mr152627b3.5.1721178996997; Tue, 16 Jul 2024
 18:16:36 -0700 (PDT)
Date: Tue, 16 Jul 2024 18:16:30 -0700
In-Reply-To: <20240717011631.2150066-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717011631.2150066-1-surenb@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717011631.2150066-2-surenb@google.com>
Subject: [PATCH 2/2] alloc_tag: outline and export {get|put}_page_tag_ref()
 used by modules
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Outline and export get_page_tag_ref() and put_page_tag_ref() so that
modules can use them without exporting page_ext_get() and page_ext_put().

Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@intel.com/
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pgalloc_tag.h | 23 +++--------------------
 lib/alloc_tag.c             | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 9cacadbd61f8..3c6ab717bd57 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -13,6 +13,9 @@
 
 extern struct page_ext_operations page_alloc_tagging_ops;
 
+union codetag_ref *get_page_tag_ref(struct page *page);
+void put_page_tag_ref(union codetag_ref *ref);
+
 static inline union codetag_ref *codetag_ref_from_page_ext(struct page_ext *page_ext)
 {
 	return (void *)page_ext + page_alloc_tagging_ops.offset;
@@ -23,26 +26,6 @@ static inline struct page_ext *page_ext_from_codetag_ref(union codetag_ref *ref)
 	return (void *)ref - page_alloc_tagging_ops.offset;
 }
 
-/* Should be called only if mem_alloc_profiling_enabled() */
-static inline union codetag_ref *get_page_tag_ref(struct page *page)
-{
-	if (page) {
-		struct page_ext *page_ext = page_ext_get(page);
-
-		if (page_ext)
-			return codetag_ref_from_page_ext(page_ext);
-	}
-	return NULL;
-}
-
-static inline void put_page_tag_ref(union codetag_ref *ref)
-{
-	if (WARN_ON(!ref))
-		return;
-
-	page_ext_put(page_ext_from_codetag_ref(ref));
-}
-
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr)
 {
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 832f79a32b3e..5271cc070901 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -4,6 +4,7 @@
 #include <linux/gfp.h>
 #include <linux/module.h>
 #include <linux/page_ext.h>
+#include <linux/pgalloc_tag.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
@@ -22,6 +23,28 @@ struct allocinfo_private {
 	bool print_header;
 };
 
+/* Should be called only if mem_alloc_profiling_enabled() */
+union codetag_ref *get_page_tag_ref(struct page *page)
+{
+	if (page) {
+		struct page_ext *page_ext = page_ext_get(page);
+
+		if (page_ext)
+			return codetag_ref_from_page_ext(page_ext);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(get_page_tag_ref);
+
+void put_page_tag_ref(union codetag_ref *ref)
+{
+	if (WARN_ON(!ref))
+		return;
+
+	page_ext_put(page_ext_from_codetag_ref(ref));
+}
+EXPORT_SYMBOL_GPL(put_page_tag_ref);
+
 static void *allocinfo_start(struct seq_file *m, loff_t *pos)
 {
 	struct allocinfo_private *priv;
-- 
2.45.2.993.g49e7a77208-goog


