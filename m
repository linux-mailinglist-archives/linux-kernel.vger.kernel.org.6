Return-Path: <linux-kernel+bounces-391461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6CD9B8775
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495CC282542
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF61A76B2;
	Fri,  1 Nov 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUkTpQi0"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799313C67E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419227; cv=none; b=bn/lAedIRichfS+GykgCuewlYtgQ0gj0XW8UlWaptPmfslEGtsbYBEMOeUsUQcdWxYhTPaU+/xmR1Tv2JLr8j0Z7bag6rRpwH4xOLSLlf1EKUbgcMRCGxT+sL1YAy+X4HOOaNBBacRfTrXmEJNCDoRqaCrrUdKzzkQ9fpI9LU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419227; c=relaxed/simple;
	bh=MTdB6P9eAH1FcYRpKNEzl/sM9MnQi9jhjNqD0z3Miuo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PDAUi+aYnuxfxVUHLXWeb7ksqRYk8RDmO5mv9rUipwGvV05anZfHRHLozP96QxHCOgaGT7+RG/hPRxLAlUoOaPm42wT7hIp+SEyc8fcPEFgiaya7c+J9Tbj/s60LzvVhZFv9A0MgtO708yIY46dOPJnNDxVkeMDs172K9ml/1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUkTpQi0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3231725c9so29828687b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730419221; x=1731024021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1E3qJdavv7fjHbqyvEFCACtggtWj/ztsb6CTdBP0XOU=;
        b=HUkTpQi0ZV75r2ZAniwPmHWFjGOJOzZ8u6GYwZyO3Lz7+JpyT0Nyfdoz5VewcYETOY
         ptEyXEu5MAEJBHxbkB/4aG4eIRmSQ7EOms07721LgHk0fqMyLwsOBExWt3RF4jY47bBX
         ya1XjeITjigayj7Be9sR644GOO5//COokhm93z/J1HfbyE2Gnjo7HDOfyRc9qtwiYoJU
         HUsvUC/8Bh+KgkzHF8w3D+knizLpcxiR6OYNoBYQoLT7e7qPkFmGFz6E3qXh7pxr0cf1
         zld5Ph4c2LKPffuB59JqOdKP4dIr3Biw/EfoDqFi+/OCrwRQXJMcmA3TuT5Pw2m25N30
         eVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419221; x=1731024021;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1E3qJdavv7fjHbqyvEFCACtggtWj/ztsb6CTdBP0XOU=;
        b=UqNPD/EXVKNROpSH3gaz0GxnhrpOKOLVtCh+XX6hnV1i07iyg5ylMS55Ynb3IliCNe
         9ayDYFEEcALJkWQcU02dBnli6JXR3bm1bDb5h9mYSeTLyXpmrJN72REGJPp6lbj52AGg
         Zd3nIDqrAVAyA47YDREkJdErQ6Y0Lzd3e7TOMoQOc2HfRi7qJPY6glmqAjzdfXk+Forx
         ZsSao24WfbzRoerL8tGUzMgs2VMm/xrAxPXGn3pYK6voWJGA/E8TWDDdZNv9Gr7YZt+C
         Mz0fwzW8Msin9xbZ3Xbl4DZRudJKGyffBI/m1YujwsLi3vQRfBXq+1MCZkjh/dOFzvyT
         tG4A==
X-Forwarded-Encrypted: i=1; AJvYcCVlsTUjIH64z/rZMTreyfk8c+yvUlLHo3FgUg9YJvoDACViN/73tWclfYZjrt+W7kOL0H5m/hoaQ4I8kqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3hvsgX/UKP3M2Tqs4JSNOZd3aEqYMq2q4ImSs3SvqDxtPfJtd
	XGjqWhAo9YJtpvzGZVEPVdvhLkJSyJb4P0RHWmiOhczGkUemtX6xA+X6IRveoraK84ooyte1WZF
	6lA==
X-Google-Smtp-Source: AGHT+IG27m+WkXwA4bhIP2BQ4mgmMvXs/r783mfj828zYLixBTSb4bhAFRNU29d41c5oUeeHYirxFASbVfo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:1498:a594:2b5d:75e5])
 (user=surenb job=sendgmr) by 2002:a25:ea48:0:b0:e30:d37d:2792 with SMTP id
 3f1490d57ef6-e30d37d2919mr14776276.0.1730419220629; Thu, 31 Oct 2024 17:00:20
 -0700 (PDT)
Date: Thu, 31 Oct 2024 17:00:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101000017.3856204-1-surenb@google.com>
Subject: [PATCH 1/1] alloc_tag: fix empty codetag module section handling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, dan.carpenter@linaro.org, rppt@kernel.org, 
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com, 
	da.gomez@samsung.com, yuzhao@google.com, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

When a module does not have any allocations, it's allocation tag section
is empty and codetag_alloc_module_section() returns NULL. However this
condition should never happen because codetag_needs_module_section() will
detect an empty section and avoid calling codetag_alloc_module_section().
Change codetag_alloc_module_section() to never return NULL, which should
prevent static checker warnings. Add a WARN_ON() and a proper error
reporting in case codetag_alloc_module_section() returns NULL, to prevent
future codetag type implementations from returning NULL from their
cttype->desc.alloc_section_mem() operation.

Fixes: 61c9e58f3a10 ("alloc_tag: load module tags into separate contiguous memory")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/50f12fa1-17c1-4940-a6bf-beaf61f6b17a@stanley.mountain/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/module/main.c | 4 ++++
 lib/alloc_tag.c      | 2 +-
 lib/codetag.c        | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 129c98e6380d..00c16f5c5568 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2316,6 +2316,10 @@ static int move_module(struct module *mod, struct load_info *info)
 		if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
 			dest = codetag_alloc_module_section(mod, sname, shdr->sh_size,
 					arch_mod_section_prepend(mod, i), shdr->sh_addralign);
+			if (WARN_ON(!dest)) {
+				ret = -EINVAL;
+				goto out_err;
+			}
 			if (IS_ERR(dest)) {
 				ret = PTR_ERR(dest);
 				goto out_err;
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 1c74942e6dfd..00ab18ea452a 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -437,7 +437,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 
 	/* If no tags return NULL */
 	if (size < sizeof(struct alloc_tag))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * align is always power of 2, so we can use IS_ALIGNED and ALIGN.
diff --git a/lib/codetag.c b/lib/codetag.c
index 4949511b4933..42aadd6c1454 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -244,7 +244,7 @@ void *codetag_alloc_module_section(struct module *mod, const char *name,
 {
 	const char *type_name = name + strlen(CODETAG_SECTION_PREFIX);
 	struct codetag_type *cttype;
-	void *ret = NULL;
+	void *ret = ERR_PTR(-EINVAL);
 
 	mutex_lock(&codetag_lock);
 	list_for_each_entry(cttype, &codetag_types, link) {

base-commit: 758db9ca0107bc6c00f0ed4808974d66c8dc2fea
-- 
2.47.0.163.g1226f6d8fa-goog


