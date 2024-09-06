Return-Path: <linux-kernel+bounces-318112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC296E898
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCB71C22ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A9943ABC;
	Fri,  6 Sep 2024 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpmVtj0z"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD1946F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725596474; cv=none; b=jOW0/t4alGgueGkwZmUuHRcQHQHqHM0PfxHlbLAseAMsLNykjd66ceWwj+csr2Ni14ohCzRPyh4jvF47IOLlO2VLpXPocBS6GKoJC2ozNPYwJqy42gXXfDc132XAe6ldDPQdMWliPEDNo0rNR+59ukuh+preg4LvKjU/qMROZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725596474; c=relaxed/simple;
	bh=uOUkXW83aVY+gvXQ5jLxGDmiAR5z+JI9uCdg1B8qG08=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JQc4BuQ/x3MI6rXKcKekaH9Te+RqdTxd/jILge/ksQeQVBbSEPXV+LnZeqwdLSAe+6tqo4vuKCpb15xxs+Phe5+AUAbzXOYVLF6TwyprQiV788arTzJHaYcJfGqyrOtaGl+N+1wIbKTPIv9fwyNNU5l3ohdzQTEFz/xrOp1gCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpmVtj0z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4426ad833so68908457b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 21:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725596472; x=1726201272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6rMHBDk6aZCVvFepOF3gEumvZVHdTWOkgoEnOWibS94=;
        b=FpmVtj0zB0eI9p552UtPP0LkJafjXaL611iTskgf3cui2Ec4ImkRsdfXpz/ayiScz/
         bs+FCjEIRLbthKCU+2uRTQRtmkwy4Y4NDz9O+t9njjANjU+++3PDCJPPHZ+jZPTBd6lX
         mXLkDH5M86SHaMUEaN+EydEPVYICjEvrqt3ONlKDb6w/5KTlpUZZ9F78Y2L4WOlt0e3r
         tk54wklX7iLai+SXu/lqlJMT5mfIRGHIcpVswE0QHu7sp9/ElbkwHqODSc3V01B+B57k
         OiE2NbBy+TCq5Y9LZbDpvROl8KQF2zQY/1Fd/d8KF3KlY8hIdD+U0s3vZlghlpEIcQx/
         R8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725596472; x=1726201272;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rMHBDk6aZCVvFepOF3gEumvZVHdTWOkgoEnOWibS94=;
        b=HdFM0daVYx0Kpflu44rSi9J1Zr2TGcjMe3V/bGedL0rPKHEVDHHIkN6m8MhAf171mo
         wwp7eBLRImtL95vt2SIZ41zxU88qFGIwvZn6kO+GVufIAq8gvPkll7YrvMieo1XB+urB
         IV5NHoDO98LLguCXDcYRJxEUdZt/Zv2md/P0NxwlsRQo7UPmpE0I6W4pCpUyw+ydqO9l
         Ph9TbEVig5sDNS7ae5n5/+gqr4Zyubtw/dkXHCvBdndSjiQ+7hBdRTjHgfVVgnnP9Chb
         dDwABF85QwjMzCcp3t8Oz3oraWNlFYprBAoTuQ3raaY/sY9BEy+bIHG124eE0cNmgCwf
         FdFw==
X-Forwarded-Encrypted: i=1; AJvYcCU/XjmsstMi1VZtjZga9mOUca9r6yxldeCIDgT2+q8jz/XmYWja6pk176HDgMZ+aQ/lncIc6L9D+nRrER8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcXqe1RdajS2+N0eLx68IgIilqVb9+zZBl/igh7n7mOylzenx
	NbhjSLZ9gF3cHmV7s1FZFsttOxuBkprlaRNz9KU771D1gCJLi0UNgmjeXQm6EKubFKIGIZb4zZ6
	8QQ==
X-Google-Smtp-Source: AGHT+IH6Q0BKXGClpmZdeK87d3hTRQYTLHXHkCn11z/zfigFOkJw6sxJj5jJwGXGw7e9+20J7sDOfg5ifv8=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:5b7a:cdaf:9b3d:354a])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:d91:b0:62c:f6fd:5401 with SMTP id
 00721157ae682-6db451533ecmr738287b3.6.1725596472083; Thu, 05 Sep 2024
 21:21:12 -0700 (PDT)
Date: Thu,  5 Sep 2024 22:21:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906042108.1150526-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 1/3] mm/codetag: fix a typo
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
---
 include/linux/alloc_tag.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 8c61ccd161ba..896491d9ebe8 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -70,7 +70,7 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 /*
  * When percpu variables are required to be defined as weak, static percpu
  * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
- * Instead we will accound all module allocations to a single counter.
+ * Instead we will account all module allocations to a single counter.
  */
 DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 
-- 
2.46.0.469.g59c65b2a67-goog


