Return-Path: <linux-kernel+bounces-249922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1133492F1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13AF285F54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E6E1A08AF;
	Thu, 11 Jul 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twLjVOY3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF861A01C3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735507; cv=none; b=p3VoY6ZoT8BGth1tDkWLnWOUhJJX8PFzO088iBVYXuG4jMAfOpzPyCA2nr8cV51FczkdO5KZdrfsdgjhDCXF3zN8946CcKdYIsuuQbxf7oQS0ojptz39UCKDoWlz+uW03vbnapHgEaEOwhMH+MiUEWlg7DZUY0KRoQOoIK7VyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735507; c=relaxed/simple;
	bh=pxW4+P15ET2YIVL0yaeCRUNdIbPJTpUXrDx6OKKZ0lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YckcySiMEnazlOIbDIYTbMUN1XfvsTb2uKpFT1WFE+DLut+h58IbmMODqaMOTfyS3BFVYxbrquGR8en+9GW8vIGGGF2ut+GZtgv8dfJqiXrDBGZD6q9cPZWSNe7L9gwu8qQCRG3G9dQS3AGqfZCqPF7UFvZAd6UKXcR6q/F9dmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twLjVOY3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0335450936so2546271276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720735505; x=1721340305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUqZ9LjRSmNrW6ngPL3y0CGgomBIu4HcNtQ8V/Usrc4=;
        b=twLjVOY3susDdK9B+9VNHW+A/QMdYi4P+ylXoQ0Fj7x6cEq1BrUfw2tFpgnkM2kck/
         msIOyXd0e8RbPcu1qbwgBy+cQooq/QVEu9jj8MI17eZSTWpK+BtqDROQPm2B+grIY1Uv
         5BDE5N01dpftam1R3vHMFGSoCkgmQRhu791WeXT5nvb4JHvoKQ/76vTAG9ZpX9a3sNUq
         M7GSLwCmTcDRD/X4AILZTan4nxRyucOy0qUYyGu2h4+neGhP2s77bm2E3czZmR/h3nSn
         /NC2TnaRxMF+YRqvwF60/jPLb2CziRuAyXLNQtzPhyqq3h5SZU3JULJIZ+4YdrVjRT6D
         MyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735505; x=1721340305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUqZ9LjRSmNrW6ngPL3y0CGgomBIu4HcNtQ8V/Usrc4=;
        b=Ul8eLRrCiU5LwOcIenh4QgcJqt7kW/b0rXp/OFmt+KvPLzR7Nn6iTjClSM9yLG2+N1
         1xt5xuHSFtno3sGcq3ZEoGKaA5Ag/Pc7FGMpdpyEk0U87gARqOH4dnRcxYW/987hAi31
         +dNQ1efXcWD4Lnryl4BZKJeW9enV70MAhnG9dGInaN9bLrW91BF8tp74i1oI0N2M8Ley
         IbOTttU+IJNiO5vHF3FeUL4vCoDTl61ru4Cvq4rpypiloV7kYTJmy1BR/S68pfwAyeRs
         31yn0MbW0gcYM4T1JkCTdQ76JZptGtFZXgFOF/w3F/uRUeh20ll/3tRloOjhdo5Ai7Ix
         /CIA==
X-Forwarded-Encrypted: i=1; AJvYcCV3z5m3EPBWeiJg+y+cJxrxMyudn1HFGDT/KIpPXxKMBN/UjgInsBRYi8+l0aT7dcYFugFgdTS0SOlW7s3OmrbwTe3MSArTU8Xr0hY2
X-Gm-Message-State: AOJu0YzCwCyeJgpU8ORM8/WRS2y8xO6wf0LlHDYk8ai7TdPzK0oJ6JzO
	XwvYRUgitg3KlUqr3KSFJC6zK6miApHtPHViGhkIyXvoM8u3sNAx1pXfQr0DQ2CeRK6w82s0GXl
	5/g==
X-Google-Smtp-Source: AGHT+IGhq4L2iZI0qjQrwTOUQOvU97/c4AmsbzpWcAXlY7wJJCThuhaIO+OEQIc1xTorafJYcExQaSO905U=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3f97:69c0:dd80:bd4a])
 (user=surenb job=sendgmr) by 2002:a05:6902:124a:b0:e03:31ec:8a25 with SMTP id
 3f1490d57ef6-e041b10fd77mr20935276.10.1720735504863; Thu, 11 Jul 2024
 15:05:04 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:04:57 -0700
In-Reply-To: <20240711220457.1751071-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711220457.1751071-1-surenb@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711220457.1751071-3-surenb@google.com>
Subject: [PATCH 3/3] alloc_tag: fix page_ext_get/page_ext_put sequence during
 page splitting
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

pgalloc_tag_sub() might call page_ext_put() using a page different from
the one used in page_ext_get() call. This does not pose an issue since
page_ext_put() ignores this parameter as long as it's non-NULL but
technically this is wrong. Fix it by storing the original page used in
page_ext_get() and passing it to page_ext_put().

Fixes: be25d1d4e822 ("mm: create new codetag references during page splitting")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pgalloc_tag.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index acb1e9ce7981..18cd0c0c73d9 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -71,6 +71,7 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int nr)
 static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 {
 	int i;
+	struct page_ext *first_page_ext;
 	struct page_ext *page_ext;
 	union codetag_ref *ref;
 	struct alloc_tag *tag;
@@ -78,7 +79,7 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 	if (!mem_alloc_profiling_enabled())
 		return;
 
-	page_ext = page_ext_get(page);
+	first_page_ext = page_ext = page_ext_get(page);
 	if (unlikely(!page_ext))
 		return;
 
@@ -94,7 +95,7 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 		page_ext = page_ext_next(page_ext);
 	}
 out:
-	page_ext_put(page_ext);
+	page_ext_put(first_page_ext);
 }
 
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
-- 
2.45.2.993.g49e7a77208-goog


