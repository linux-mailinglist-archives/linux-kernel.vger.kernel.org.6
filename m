Return-Path: <linux-kernel+bounces-249921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C6F92F1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065F11C22E07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50F1A0703;
	Thu, 11 Jul 2024 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jy5YIlwq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0B19EEAE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735505; cv=none; b=WaMFQJSW9g7mUlIym1YvMzVXskWuXFRm6M1nKb/anLQupWR4390URGtwfc3E6tP4y1dxHE6CeI4bIz3j/ZGMfSEknW5QoFfGMlsr7HFx9mgdAfJzA6j9RYb+yZWX5xgy63Z/a1ocyFNcVZTkViaOUHb7iXAD1HBVr9G/O5Yzxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735505; c=relaxed/simple;
	bh=LlMJwvJNjqxvae6ifVFZzwByXNVXKmkRGg9KAloHJRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CR/zBp76UMOT+aP3FrBfu04922h3RVnRj68dlvANLu7tllIpRHK39c7T3wyQ1iKxzPyQV6Fz4lt2JMOV6sFM1AhzSMxu7zAwMJrarNN7cieks5V2gg8120jA/j8jtQgD3bcFEIxU6tW0KVkPO3horiR5aF94pIzdezOc2U5ni4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jy5YIlwq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso2427054276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720735503; x=1721340303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=93kJQnyc8fg8K6y0X8F3xN7SC1oO5b0Dd7FB+lYPuNQ=;
        b=jy5YIlwqgLybij25eTvTV2mF3uXUq/xh/Xhyr0KkZV+ygruJ+yqp1/ERwlyULJLGIF
         uXqkMcWYPFhwynPpOxmHvUSDT3/IDjx4ijyLkFOEHaQ/dBCDX799N9lLAxbhl357+t8E
         ZeVoplXZIkENffypUipn8UbX4sHg5AP4k2kxMMc4VDDCRAIoSPLSf6XD9kbHdJ2goO1K
         q3RC5aVkQMO9q4ujTJE2HgvG7EF1uT7BWC/e9R8NzpG9InaXUnxHp81wTtBxcQdn3bRh
         rOzhGjefJuBQPIC5wJctQqWNDGRtEHGW9iXgt6O+Pho7raTKI3/EwAqPomGRmTknQNZN
         KpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735503; x=1721340303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93kJQnyc8fg8K6y0X8F3xN7SC1oO5b0Dd7FB+lYPuNQ=;
        b=Yd7vulFrKrSalZui5Bzk5Q6enyNI/JrBsIXeuU0hYe4BP6W3AgITmEXHwNrvp+D9uC
         qGFEvPhXheZcUIPheKSQJ9SIjpllRt6jVeDqmcZDQoIfIZgXKZF731E6vd8IP+JHSbAJ
         ZQ4Xsqj8DguJD4d5nos/Yy5mpOjxIx/HM+sdRhIcdQfn1/OS+nrd4vEsles4izTdaXJG
         MAYc0qRtgBpszcfOGF5+0Lqww8YfTWTKOhs1hOGZoaRxCwbgDS5y7Z/K+gqiJyM0t/w5
         N4qYD1M3ppvLAJrrQMSrhfsbUv5Vht5SrP3ji3/rbZZt/d+cYlYEKPJ2IT3L/R9okSjL
         R53Q==
X-Forwarded-Encrypted: i=1; AJvYcCXulsF0zRD2NWOzZmJWx4k4VAj+8Nq3u22pkIJPdEQ9blvTae7AgK4OVBHi7UFky773eVC037DyYZqB6EVlLalw/hLtMECQCMTgauHg
X-Gm-Message-State: AOJu0YwPU+cQOsCRbPXIBZUdrVp08ph+syOFGUzFWTzmqd7wo3CqUGsu
	imuZc9tlt8CG1MTBlqGpl1WiZKbMKyXostd0dUnJiDzEmbZrGdXmSHOEgzzBYdnmaKSGzpzrsxw
	q9A==
X-Google-Smtp-Source: AGHT+IE5Ve5SJ1wAwBQCkjGpJ5hWlIgqCRMJq8/YBUF401ZfiUTIDMS3IJ0Xh5DM4xHnHKnJdlSUE6tovAs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3f97:69c0:dd80:bd4a])
 (user=surenb job=sendgmr) by 2002:a05:6902:1208:b0:dfa:48f9:186a with SMTP id
 3f1490d57ef6-e041b0370bbmr22072276.3.1720735502941; Thu, 11 Jul 2024 15:05:02
 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:04:56 -0700
In-Reply-To: <20240711220457.1751071-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711220457.1751071-1-surenb@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711220457.1751071-2-surenb@google.com>
Subject: [PATCH 2/3] lib: reuse page_ext_data() to obtain codetag_ref
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

codetag_ref_from_page_ext() reimplements the same calculation as
page_ext_data(). Reuse existing function instead.

Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pgalloc_tag.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 9cacadbd61f8..acb1e9ce7981 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -15,7 +15,7 @@ extern struct page_ext_operations page_alloc_tagging_ops;
 
 static inline union codetag_ref *codetag_ref_from_page_ext(struct page_ext *page_ext)
 {
-	return (void *)page_ext + page_alloc_tagging_ops.offset;
+	return (union codetag_ref *)page_ext_data(page_ext, &page_alloc_tagging_ops);
 }
 
 static inline struct page_ext *page_ext_from_codetag_ref(union codetag_ref *ref)
-- 
2.45.2.993.g49e7a77208-goog


