Return-Path: <linux-kernel+bounces-209420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD84890345B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E34B2C5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB4A172BC3;
	Tue, 11 Jun 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuKktv7S"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA325174EC8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092254; cv=none; b=hHjQe+gkhxnIR/g85vyz5BE8LZXAF0a1CG7mUWUIlE+YiM2dUWEEAJkvF5B8DRS5tb0ofgWXcFmNpHvyaOdxTfcWzp4L6JzL1qkNcn90S9ZP2UKjWa+6EhyXVR4EStPnFv++bqnpGU8gUpPR9aoUs6Od9ML3WTdSa5JNB3X3n7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092254; c=relaxed/simple;
	bh=02HaGP+l+/mN8/mDpEA4tyGvp1+RJCe805mHVj9C/Go=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CmX9xmEK38zlsqWHwsArzHctoNeL1wRMnFrWWAkivNg86YF6CVTClJv2+K2THf/OYPPpSYD1NX1/6hB7GxcNWGKbWd9DYCwwu/PwZXfXsHQzwu7BHe7ISaN1QaJwNGBJZhWWH956xFEHA/aV06sj10NTq+64HF6gNEHRlQXkx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuKktv7S; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7a6530373so9867107276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718092252; x=1718697052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfoi3weCkLJlClMg6zNq5D1+MumBGC9yK+0o7HU3M94=;
        b=PuKktv7S7zJMHdWhsbx7J9oCyyKijVQk8fDA2ysR41rq9dVWMQ2FYiZqjBPfJ8lHVv
         ls7RX+OnIt6emzsTYK+X4g2P40OHCBRJSeGeATBHd0C1R3nAR433Ntktb1V+uw8TBEZ4
         mpSwdDBxSYlnEQeoYmHwkX0p0ujkiU5FfiZ5Q51stCe5RrSxDPlg+1FmMD4e4YhYSy/S
         01RRBoq3uS/cHYK8ajeJpjgUlO+JaFySUiRmlsUOvwxlKiWMc4B8u2KyGuiyPJmM4yZw
         zqGEDIDDlKSpHY9TwYNlvv+mMPUwifsbthKC7LgDFZhoV7/wmSiueMBeFm7kmR1DUgxt
         lYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092252; x=1718697052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfoi3weCkLJlClMg6zNq5D1+MumBGC9yK+0o7HU3M94=;
        b=i/Wl4psoCXbfzOo03xJPeVuQQG+AZ7kK6Ph/AlSNqJSV+PHNVCNc9sSsEK/ezgMl/8
         T0nWYMNFDL+1SZXGumLiPriyg3uqurbiGLWC5zh8KHgReiDYsVFdsXFgmejdiVK1W62n
         Jxb2Gb/MROuUkHQbpX0u6lND+qu1vZGjUZmnWotdqv3SbNYVESF5qY8/Jz+6E/Xd67UW
         8l5MwEqzHMIC8NJCxfMGW7CP8HgJmNOUHOWBPToTbOf14INeYqaa0V/4QUqCJFdwYD0C
         R6prQQvAvOtRoUEEUuQ2lEn+BW6xLjH7qwlzU2ciVGLgFK7bn5yY8hfoialFbm3rOIs7
         +qdA==
X-Gm-Message-State: AOJu0YzLshfNvSkDbIBj98QrBcaNqCk0/fGt7o8a6YBzq3UJsDnnAMlD
	aiaozSvCOe9aYbvWUt52tTBGR5hoPV5O8Ts878oBPNm1di/fmyEBwZSh/+NjrPXsOVjgqTVYb65
	mX70z7A==
X-Google-Smtp-Source: AGHT+IFyDS2BFRLxLxooh9UBy3w3KkWkcsvlCgTBgrd7BbaqQ654Bv5CYB20hXbhl3A9/BI4CqENsgWJLOFC
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:ecf:76a8:5d44:6e8b])
 (user=dvyukov job=sendgmr) by 2002:a05:6902:1003:b0:dd9:20c1:85b6 with SMTP
 id 3f1490d57ef6-dfd9fcb617bmr539283276.2.1718092251735; Tue, 11 Jun 2024
 00:50:51 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:50:32 +0200
In-Reply-To: <cover.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <bc0cf790b4839c5e38e2fafc64271f620568a39e.1718092070.git.dvyukov@google.com>
Subject: [PATCH v2 3/4] module: Fix KCOV-ignored file name
From: Dmitry Vyukov <dvyukov@google.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, elver@google.com, 
	glider@google.com, nogikh@google.com, tarasmadan@google.com, 
	Dmitry Vyukov <dvyukov@google.com>, Aaron Tomlin <atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Module.c was renamed to main.c, but the Makefile directive
was copy-pasted verbatim with the old file name.
Fix up the file name.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Fixes: cfc1d277891e ("module: Move all into module/")
Cc: Aaron Tomlin <atomlin@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
---
 kernel/module/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index a10b2b9a6fdf..50ffcc413b54 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -5,7 +5,7 @@
 
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
-KCOV_INSTRUMENT_module.o := n
+KCOV_INSTRUMENT_main.o := n
 
 obj-y += main.o
 obj-y += strict_rwx.o
-- 
2.45.2.505.gda0bf45e8d-goog


