Return-Path: <linux-kernel+bounces-378974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC35A9AD807
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF6DB219B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A582038B8;
	Wed, 23 Oct 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXYgVbbS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59F2003AE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723479; cv=none; b=C2ULm67ukkKixv5HfFCQILCLRxaFTbZYYSFADJRz5kbJC4cUHiJkLzUJkKKNI4tsgn5v2DiUHPLlaR4GJ0JlvpBOnRETO3CESlJQzKM6xTinYOLQYaakpo//EgYo+QsmSdaeLR7WpsBllLx5I5VtWLJEZtLCjX6FUcz56hr/BiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723479; c=relaxed/simple;
	bh=3HFJd1zKl8CuQGyLBoQTCfW2N9SR4lu7/i9sMLQ2fAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p6Bn8eeZCrCSCCQ4/9if9MOvfiErp8R3HxRWMUItQUPDyvDLOsxAHVVDyoPh4yjNbNXieTfZUFQWQ18+FKV14yf8dzOjK0yzpXpiiR3slzfgy/RnUf/osmAGowIZAYeev09Lh5hrl3c8o4A+b7hDTFGSUTolLAiL8TtJYVComFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXYgVbbS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e321d26b38so4968087b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729723474; x=1730328274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZ1FQbvtq5Ei4dhhMu0oVKyyOjQLluD6u8uz9ZwuFcc=;
        b=UXYgVbbSADiwYFz5HG2Z/I0MtmcfOZ6vaeRaaXA2CqL/RVW4esrdOTIcv/0PgMFldS
         TUKlGJgGtVpdpWLI4J1/O+sB1sdjo4dd4mxMR1rSFmvPYAUGv7+LG1nGMJUn1VMMNbKc
         9obLasoapQW5lTQleg6zwooDRAlDhwHz9UPJRG56/YqBYowXnVl7CjxUgDzkHJlDKNdx
         9FPkF3qACt4GxqXxXaNjloUdEKWWwukr5Wkm3yj+KfSwk1zu3CQiGLjd1Px2Z6u9RQYU
         jcnNXekL8RWCOnq57aACy5hluNLOSoEVb1QUWyuJnifqTuo1+QgSXN8Igz3/j2VY32Rb
         NO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723474; x=1730328274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZ1FQbvtq5Ei4dhhMu0oVKyyOjQLluD6u8uz9ZwuFcc=;
        b=lNhzVE/uXpAiAjqDL+oLh3Po8ikJs+n2RNS4XbmvOEcoGEx61oOH1+QfWaxbfsTUtn
         GzwCoHY2pblSMGMAtLRcR+3VjwcPxIL5Y5PBvY8OShXaFFStexVrCnZ94m7AwsdQ2MJV
         P6To9N25qK4GyKeUL1QEnAxc0jatg6SxCiHOTOgb2pDXAc4AF+ZrXgyvsyk4O9OO4Phl
         36GdIzG5sbWfxv0iae0KS7ABgeGS1fLcTnSEQ1ihotPYukuR+8akYKwnRLrzqGpWpCnT
         +TbUTGNmnRkrrvz7jGKM9fV9NDQ/Uoxcig4gCpViMOdVDKAGko+wA9/Fn0BuZotqya74
         3tIA==
X-Forwarded-Encrypted: i=1; AJvYcCW8x1/Jz5UEyu8GKG6KqhXHFmDjXqB25xOCTf2Nz0AhHwufqNQTouYD7H9FqHIr6jFBSM9mmwv0y20jJQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDV6P/Hjbg/nAiUlfMB8zZI0f4LP2Vk7QbmMlsybFaLiWrrLR
	t3e5kx+0pG4F8tgTucTLTKRSiI2fowTC6fQHv4iDWZzGqR+y4tEG6rOfoicJ3J4w5A==
X-Google-Smtp-Source: AGHT+IF3afEi+2DQBQxFPwlVyJanehbLM77LLNnIsTpgrL/SM4QXMp8zeMT5tj5jLEQWONaakf6NLRY=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:690c:7207:b0:6e6:c8b:4afa with SMTP id
 00721157ae682-6e86630e823mr2867b3.5.1729723474568; Wed, 23 Oct 2024 15:44:34
 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:44:03 -0700
In-Reply-To: <20241023224409.201771-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023224409.201771-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023224409.201771-5-xur@google.com>
Subject: [PATCH v5 4/7] Add markers for text_unlikely and text_hot sections
From: Rong Xu <xur@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Rong Xu <xur@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Add markers like __hot_text_start, __hot_text_end, __unlikely_text_start,
and __unlikely_text_end which will be included in System.map. These markers
indicate how the compiler groups functions, providing valuable information
to developers about the layout and optimization of the code.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Tested-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/asm-generic/vmlinux.lds.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fd901951549c..e02973f3b418 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -549,6 +549,16 @@
 		__cpuidle_text_end = .;					\
 		__noinstr_text_end = .;
 
+#define TEXT_UNLIKELY							\
+		__unlikely_text_start = .;				\
+		*(.text.unlikely .text.unlikely.*)			\
+		__unlikely_text_end = .;
+
+#define TEXT_HOT							\
+		__hot_text_start = .;					\
+		*(.text.hot .text.hot.*)				\
+		__hot_text_end = .;
+
 /*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
@@ -565,9 +575,9 @@
 		ALIGN_FUNCTION();					\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
-		*(.text.unlikely .text.unlikely.*)			\
+		TEXT_UNLIKELY						\
 		. = ALIGN(PAGE_SIZE);					\
-		*(.text.hot .text.hot.*)				\
+		TEXT_HOT						\
 		*(TEXT_MAIN .text.fixup)				\
 		NOINSTR_TEXT						\
 		*(.ref.text)
-- 
2.47.0.105.g07ac214952-goog


