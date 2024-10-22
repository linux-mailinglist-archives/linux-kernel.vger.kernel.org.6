Return-Path: <linux-kernel+bounces-376955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C34A9AB80D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4D31C21139
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191671CCB31;
	Tue, 22 Oct 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KL1RS+6s"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173941CCB30
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630590; cv=none; b=Gc2uHHScV4IWmHI4LP7EDB9F2UeNcwAU+DYXHUN3QMgLiFFXuBm0idYofbc3qO+yIw7+M2/nmPfNlBGDroJOQq8Lwe7OBgnfwUBEB2KOTAnae1OVYjS5yypgwzdllf4GA1DricymvxMMkGKWRQNvWCNq2nnHVAW5U7xOzli5hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630590; c=relaxed/simple;
	bh=En+AZxhoIvPdGUvI2rByJN+QSXDwdQe/en4gVzJBPBM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XioBxoOheVtHdP0teyUZpXNeuUtRcGQNe/av1/Fnuu5GyG5iF+4FNCX0kzqeQU4xfS9nY1qgCNmSdgkzsX6LI+VszBRyiPwHaGG0QO/t3XWKwWicRjnDF9CxKqGlLWlT/hy6ZmOWqiC93VRagFgZKJ5Fbu4lIfvIhgf0VscMl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KL1RS+6s; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e355f1ff4bso109054457b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729630588; x=1730235388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ta+9b5++FGBmxha8thwxDd9QOf2hx71icgR85vxLNHw=;
        b=KL1RS+6sRmCLp6Fdy3PCbXJO+RjxQ3X0UVpgSVJSEWJ73ZAugya/owynuYrNXAEMy1
         GOkIFnMjK59pH6gKR/UbLLe/uqtnan5BaXXDzAolr6cNLApzv91w16kSEkp12gfyWRbu
         K4cT/3YT+zvwlAzYX1+bfGPDBu70covF8y/YqUeznfzD2JKKQVqLEVo0R/xdSfELNP0a
         5bqMK43727Ilmff6qwf7L5GNP0H79UWWwA1+IdnMJK8BoVciPoM+Hh7GS97pxDKkI7Pm
         h2evPwbeR3lv0uRbic4TqpB3ix1BBdw/bRjzZBnRrnkcESt4pF+W0c5kXONYAVnA8UBo
         6KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729630588; x=1730235388;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ta+9b5++FGBmxha8thwxDd9QOf2hx71icgR85vxLNHw=;
        b=Flvqiv4R75wba0Hh0/MWs2T+PhYiSTiXEvBLcyDiDe9boL5cOPBOb9eMQw15CUxBlj
         Igs10YXIlXQO6X2ZvAq0ft/goJNCfFNPyYG0WJviCKsg3VsRq/6w2MDMLBvfpoktwA3q
         l2/oxrnoZWaylOF6IRjMwkia5edrXE0K4IMpo6C6E/2wiKD7mIOSrkvfOaEWRMBRihx+
         zcOhwW+SWPNPfr5nvK2/ntoafBQcTMGoI0YoaefAtvd5yLVnw3DloyxTV+duTsnA4qb0
         S0xcHhQIzpW8RzQ2BMY2kAuOTuolgBQD4aWmJmOHBiQ1gAnUhYQVKUZvHwu/0itEojmT
         +xtg==
X-Forwarded-Encrypted: i=1; AJvYcCU7E22dOB0RH4LEzd+bS3gChSwNU3Lj1cMjZeviAVbxhrtswFKFOsWVeg+bDj8/pXASodABngYf+krHR4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJ1xUWXQ+4aLJBGUCbWlPCL52hmrw9aGA5IDlsLrWp8fs65kD
	034UsaTRBVg7nfVJEQwUKTBgDew5JGiqbF8fMIimvlVCoUXLZqtCcDsQ0EnD9ubkhYxJ5gKjHhu
	eLa3wbyGtD2z8wRrIjtjGNw==
X-Google-Smtp-Source: AGHT+IGon+dXZEYxGcXSPtmacn8QlE7P8CHLHHb2+HCeuXHqkcSNt/6q6VLRsLJeRjYLFhxF45PjmfdNpCSWu+RPCA==
X-Received: from souravbig.c.googlers.com ([fda3:e722:ac3:cc00:4a:2332:ac13:d235])
 (user=souravpanda job=sendgmr) by 2002:a05:6902:1818:b0:e2e:3131:337f with
 SMTP id 3f1490d57ef6-e2e3a624ed7mr157276.4.1729630587656; Tue, 22 Oct 2024
 13:56:27 -0700 (PDT)
Date: Tue, 22 Oct 2024 20:56:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022205622.133697-1-souravpanda@google.com>
Subject: [PATCH] mm/codetag: fix arg in pgalloc_tag_copy alloc_tag_sub
From: Sourav Panda <souravpanda@google.com>
To: akpm@linux-foundation.org, surenb@google.com, yuzhao@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	weixugc@google.com
Cc: Sourav Panda <souravpanda@google.com>
Content-Type: text/plain; charset="UTF-8"

alloc_tag_sub() takes bytes as opposed to number of pages as argument.

Currently pgalloc_tag_copy() passes the number of pages. This fix passes
the current unit, which is the number of bytes allocated.

Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..2890001c8b97 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4203,7 +4203,7 @@ static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
 	/* Clear the old ref to the original allocation tag. */
 	clear_page_tag_ref(&old->page);
 	/* Decrement the counters of the tag on get_new_folio. */
-	alloc_tag_sub(ref, folio_nr_pages(new));
+	alloc_tag_sub(ref, folio_size(new));
 
 	__alloc_tag_ref_set(ref, tag);
 
-- 
2.47.0.105.g07ac214952-goog


