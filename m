Return-Path: <linux-kernel+bounces-374247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1D99A676E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C394282A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDFF1E6DD5;
	Mon, 21 Oct 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/MWg+zZ"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D531E570D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512035; cv=none; b=m5ZjX6xAXviq6xrBukgLwahxXr1p79f7pF2EEm6OOFEgUC/d3+yJfjZmsZckmmqlGoFNicKfGPWx7tC+0GN5J8cbEOPeigwiiP+6n+9isdkNdbyJlcc/nVTfJk4nnYdtdWbN2BbXTQNStueryiZQOhJE/FaR9HJH7CBCBMRSp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512035; c=relaxed/simple;
	bh=hKZjavByO1oruI1RUjFozDNzOMjKJafPYJzUybLsS+I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mIC6TYH/vHDhhKhH63GqxY8/Qtp93wcmO4jKeDoa7k9Fjtz1kYONlFbn6gwVKborwf6OkRynmfInoRmipndP2EKTCj2Ng9+iWIxJk3MwwoRGC/gT9Q6n4fffx8qE5RZL4S8u+1Z+r+Oscsqwke5SHbc37inDpmEkWZaESZB1WF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/MWg+zZ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a9a01cba9f7so285697066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729512030; x=1730116830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lpdvHkmKazBU3FnaALiA1RaWjop5m9wz4SmJnth5vPg=;
        b=q/MWg+zZpzaIWO3St41jV6XWaHEm3NCC2npiZnFn9AbsGu/6+tYvwK8ZWOUXGUjpQc
         ADZo4f/2KOJPzAmjqsFrWGzjQ80SS7h0xwyjRgcE7otxV/zMUXV4iQ3hMyHNy7utFedD
         T8xGpObkgekHb9eh7CGyXFKDwzfFLqIDGVfg3BOa0Ep+s1EdK8HS/xhFcxX1E4phBdQQ
         Stjzer/zuky7A8i0KNiiciqjTsHfpLNDuD02SDkl+Xaj/fsnZAp9tuVN0J3+lstFL84m
         aLw9CTrUYEAEZGDmt5THWrOssGeJPlzccuf4gaGCkKbS3wh6pVesWMVqEQlGCKp99Kzx
         MX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512030; x=1730116830;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpdvHkmKazBU3FnaALiA1RaWjop5m9wz4SmJnth5vPg=;
        b=xRZKgbzHH1sU2E9FNeex3aAkQemk4vm5Naa9dGHHaU6T9OegTS+idJ3QfKOT+sysFc
         bPp4lQdCx+L5IRR4+BTigrQ7ccL0t6FWTjbDWX8ks3RAIVcl7mNHjAlWBfPolPIoO1Qx
         5eIBlkeuCd7GnJIUnpHPNQJQseS+RZgXAfQyVkmaXUUSZuGI+t3KwnymDtINJzH5frwR
         UhP1kZxdP314kpEvVHs++xW19ekqZAHEWcNhhpzc90U3NaPwU/tRwMWyjfeyBxKcmCCg
         sy+fouTjGfpr6beP/G9YSXbRwe1lBr7VbK3WSR6BckZh1arKQIlBWdlAYHV5UYPy8BqL
         wf2A==
X-Forwarded-Encrypted: i=1; AJvYcCUK2PUIWtq9OE+U36erApOJE9J02ax5cLXSn1ENpMWMjicwjLxFGir7xPzPJjYaPKRSW54jSUeBx05kgDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEEjP0qTFw16E4zrS9eGFhiYLDD3klyV7rCvjH9OpIFVKWASi
	86H8ozyYHTrEslhGRs4EsTpGK2MtCA8WUn1RpTj+g1eZaO0lTbIkVNU2EmEspbbGHwuQoA1DGw=
	=
X-Google-Smtp-Source: AGHT+IFJm5SlwG3vf3FvXgvvro+V8pc3lkXThohPvqp5mcrTewUwVKQhuOWQVVonKB8vxoeOJx+BbgDYBg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3103:a9bb:c02c:c514])
 (user=elver job=sendgmr) by 2002:a05:6402:3585:b0:5c5:bcaf:43f3 with SMTP id
 4fb4d7f45d1cf-5ca0ae87bd1mr3010a12.5.1729512029802; Mon, 21 Oct 2024 05:00:29
 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241021120013.3209481-1-elver@google.com>
Subject: [PATCH 1/2] kasan: Fix Software Tag-Based KASAN with GCC
From: Marco Elver <elver@google.com>
To: elver@google.com, Will Deacon <will@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, syzbot+908886656a02769af987@syzkaller.appspotmail.com, 
	Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Per [1], -fsanitize=kernel-hwaddress with GCC currently does not disable
instrumentation in functions with __attribute__((no_sanitize_address)).

However, __attribute__((no_sanitize("hwaddress"))) does correctly
disable instrumentation. Use it instead.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117196 [1]
Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218854
Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Pinski <pinskia@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f805adaa316e..cd6f9aae311f 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -80,7 +80,11 @@
 #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
+#ifdef __SANITIZE_HWADDRESS__
+#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddress")))
+#else
 #define __no_sanitize_address __attribute__((__no_sanitize_address__))
+#endif
 
 #if defined(__SANITIZE_THREAD__)
 #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
-- 
2.47.0.rc1.288.g06298d1525-goog


