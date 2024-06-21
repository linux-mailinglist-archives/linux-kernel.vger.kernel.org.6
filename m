Return-Path: <linux-kernel+bounces-224348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE9912129
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE381F26665
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB016F84A;
	Fri, 21 Jun 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cbf912Ol"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10616F27A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963349; cv=none; b=kc9ziH4nfbFVN8SOzTDCk2sQdqhOl9C6FbbXCSObkpuKKqLkM/7msYMeNfdEWAd6AGB0Vhl39j5IuX0ascNR4DSzk8xn0lM/sog4v58VRNY6/04b2XUqqVqSUuRQlP5DWgx9w42Jgle9F2ChfMwxIRhUukBV/NFt5QeDDOFJ/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963349; c=relaxed/simple;
	bh=Q/93htzV1f4pgWziB7+EFdOv+wjFJEYERTrhNigzES8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VkaFlctFDRM3sz2lLG+NO4e7c3l8D5XFosfN/DQREuBXfqbgClw7uAmBSsamOoUbNaTXcoH9exoGzDNmKJl5T4YSQ1mD1GwyRpVAipkjqErNEN8qSsAsNooFxFAFekuuCZv33AzrCzLus0K4q0dYGMVFSYGnonAJe++PQVVbZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cbf912Ol; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a6f381ea95dso184453166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718963346; x=1719568146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OPh0O/AeDSq3BCIIPxPFqWQwYbgJlUXgbUqbCxM5Jxg=;
        b=Cbf912OlGSunZ4T6Awy5gfZ/+qY4As4zhmLS2qC3Bixq8m45ctYu7UlnOhW0Mt7Xpx
         zihuoALisexrLKbOKcglV9JKPB64J3VgsXy8WpyaVadTjd3XFQ2I8jvLsZYpHheUcqy+
         Xvb5LyjuT7wtPWdBA8mxTrfNSOnRPX8zGecJSpWoRoJOGenWH1Yqnf2t4mGw36H/YLk/
         Jxmo8w42c6+bSVtwWSqpKob7fBC2noSf5XqCbhpcLGu9ZufY3plTl+o8szZ3Kg+Wzzfm
         f0zUxBVgvSbaegOEgAidlg/QlDQYJMXxML7NLoeXV8ydAQjGegweCq6FNZ7LruQlU2tl
         tTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718963346; x=1719568146;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPh0O/AeDSq3BCIIPxPFqWQwYbgJlUXgbUqbCxM5Jxg=;
        b=r6JRmVhF8rLXMJTM2Ey3eltf4UpYwhbiTT3+lriiT/TFcI2e4xiR8ypJeF03kEOEy9
         oeiSF4WUflvSxZtm/Edq70aeZQXCEFLijHVG4nCjk9WkUGxF0rF6QGpaKL4IZXxar4FL
         uCj27HfHDi/Et76W8x03J5yaVYrbpWHyMUf262AnFgzaQtOW5SiZgFgPQ89K+IV+GS4z
         tBu1jRrzoIP86RT3JWiDRQIoemwdDSL+QSqgxh58bFunDIhSRqpTRRtj32n0DIqFwDFN
         9UPf/M3c2nayh3gEbfMH0ClGNVTrvN4RRfZk/S1VTSQjdqQ2B52DH/bn89K4iMn1iHaD
         uGwg==
X-Forwarded-Encrypted: i=1; AJvYcCVBqK7enylixORunG1/b3xc9M/NXDDICODuu7ugAFYZROUEfwfsZ3/3OIDATkWHa9i+h6PUgEi1BpI1o2gw3/bJKigvlF+EjlzdHXYl
X-Gm-Message-State: AOJu0YwbL1v+ByGs+mcFiJ3WadlYLNTlKkKMNzfhYT51wIBwkepb/4l1
	ZkobYe1m7d2kLZA1Af6oUXV+BvuqN+uYPiZAihD1x9u52kgpJt5epJzy+jCOslWkVQwUmp1/cNF
	ZsQ==
X-Google-Smtp-Source: AGHT+IEEzcGvrlxVupgcHFpn6/WpX6CyVovSzyD9QI3w9QvTRnlQXibdIsi9MmF4EhOEKK0vCfjb5ZPG0ks=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:485e:fb16:173e:13ce])
 (user=glider job=sendgmr) by 2002:a17:907:7215:b0:a6f:9f9f:fabb with SMTP id
 a640c23a62f3a-a6fa449538cmr731166b.5.1718963345670; Fri, 21 Jun 2024 02:49:05
 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621094901.1360454-1-glider@google.com>
Subject: [PATCH 1/3] x86: mm: disable KMSAN instrumentation for physaddr.c
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: elver@google.com, dvyukov@google.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, akpm@linux-foundation.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Enabling CONFIG_DEBUG_VIRTUAL=y together with KMSAN led to infinite
recursion, because kmsan_get_metadata() ended up calling instrumented
__pfn_valid() from arch/x86/mm/physaddr.c.

Prevent it by disabling instrumentation of the whole file.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Closes: https://github.com/google/kmsan/issues/95
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/mm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 8d3a00e5c528e..d3b27a383127d 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -17,6 +17,7 @@ KCSAN_SANITIZE := n
 # Avoid recursion by not calling KMSAN hooks for CEA code.
 KMSAN_SANITIZE_cpu_entry_area.o := n
 KMSAN_SANITIZE_mem_encrypt_identity.o := n
+KMSAN_SANITIZE_physaddr.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
-- 
2.45.2.741.gdbec12cfda-goog


