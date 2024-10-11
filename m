Return-Path: <linux-kernel+bounces-361543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D974C99A986
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6502D1F219D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18EA1CCB58;
	Fri, 11 Oct 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4WFxcMl"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE71C6F58
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666557; cv=none; b=jHgI41yYlZj+8oikCobeW6h/H77pZjThu7dbt2wi1kU9LXWwGRe4NYqYKYT6+Ei7pN2HD/1mHR4DPHLe+sjdFzGVFhn70dDX9vb3rhxsbWnGrbalzz1AvZ1PvoCR6tEPk7+sjmRnJQGwf87H9Gs8TzSivDwahjvAyvlqfT7aOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666557; c=relaxed/simple;
	bh=0an784L5kpDmdK8mN18dKa6e13LcwOa+SLNxCEIV8x4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ano3HMD7t+5zoo5cFvowU2z9k+gle0dzUH8NtI+QUCbnwkPfpUMn43qio4wUjkdp6b+Q6FrMvphb0xVYb4O8gWpvxgu28aHJeNEH58NSyaDHlA3MLwv9NAnUN9e4Dl8blzGQC66zFfwPD6Fd93U6g7eP3kNz5CuZnn4xRrQPQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s4WFxcMl; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43058dce286so11757975e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666552; x=1729271352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WkO7vfvBh/UE7nLoKyOKLo43oPVJ4Pq/WcQaO1W6Bnw=;
        b=s4WFxcMlArwxprN5ir0T6F0uVDBwRfqMRUlhWdd47nzXCXjb4o51HZQsbeajrsb8iM
         b4m3fFTyNQYAhxbP7WVWqMUBYkEoQjnRSLSN/0jrTfCFN6200fhSHmNnc/DHgtQO2Mif
         Ttc2m2AWJIX16cTDdVbttC9Tb6xKkWuRbMK8HHv06Y3uIBwdxZK6hcnYM+5Zl9Lt2gyA
         6bd+lTQmuCrWJamYW2enzMQr9uYOzi6iO61HCPf2URY0WZ8+lepyQi8tgmCqwhQ62ZhN
         xRFZEF1nWuqnJQjB94TNYOKjpfhPAl8XH03D8JUy8VOp5WY1zwRFxXQLJyfnyP8QMR26
         4Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666552; x=1729271352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkO7vfvBh/UE7nLoKyOKLo43oPVJ4Pq/WcQaO1W6Bnw=;
        b=nkZMEEBWhqNGnhoRSbQj1o6Qw1u3jW1PD4M6LidENFhz0aLbK24D7gn3sHK2VBS7UW
         C99IDyesCNp2MI0rCD1j4GLHKvwNKSngTZdUP9EEli44RIfhnfHmJ+JdYs3ZeU1UaXp5
         yCrvbDfUU9L43bFHfeiIRVMoVQL7YU6F2sNrbwXXzl5qbnvqHgJ/r2MLZ4iWB3HYZgZZ
         ZdHip36OKcsbLJcbYCh+7Pgcp5v6/5ZpvK7VkT2yM8s48I9o/wDstbuTKyaUNxL8sbNy
         j0KSk7KilhXIAGYKuts0z7n371R8+LyMjxjf3BxFg+oQ3FUklmxjrWZfOoejQpNsaIxx
         8s2w==
X-Gm-Message-State: AOJu0YxLTAVTRn0ay70H3cEzjegaxjwTCGaKgnqSge7qAUCawlmZQ5SA
	9QjMBeswTU9gO3FtAmg9xj20FKeR9ehUMkZIVvOZp+O5BirbKw+3Fe9bDWYoN6/8/F8zJC2Xw8+
	9td9IUC9VaX0qu3gzIVSuxOIuYKh+PTgsrkraOM+H7cuNSdEFvUo//nibvWUTvKO8H0NarakyUb
	ibRwPlOzCM/zXwi6ZOXKd49Fs1QPwOBg==
X-Google-Smtp-Source: AGHT+IFed+Jkm09W0qDIY/JP8fTr1qhYOY3doVvTKyQfexNDvmU8Qio0ZZDRztBB0SAbldwZsy30PHAh
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:1c96:b0:42c:a8b5:c1b with SMTP id
 5b1f17b1804b1-4311de86414mr276615e9.2.1728666551095; Fri, 11 Oct 2024
 10:09:11 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:51 +0200
In-Reply-To: <20241011170847.334429-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3782; i=ardb@kernel.org;
 h=from:subject; bh=A2/RO6uk5klpid4u/+fW8dDiGa2vurlmiGxn2abwXOw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zesm2OynG/CefvNqzuP2B3f2Z556oucZEiLe5TWrVM
 c4UbnjcUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYy8Rwjw9964dRnPnNTMjNf
 xZ67JjnNas4TGxb2uVeiciP75zndvMvwz/bi+aiTD+/42b7psc+aa3V49Z5j2h/UKj5/OSr6N9j kBD8A
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-13-ardb+git@google.com>
Subject: [PATCH v3 3/8] objtool: Make some helper functions globally accessible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move some helpers around so they can be used from arch specific jump
table code that is getting refactored in the next patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/check.c                 | 22 ++++----------------
 tools/objtool/include/objtool/check.h | 16 ++++++++++++++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b73e43b9b9e3..fbb05e973acc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -61,8 +61,8 @@ struct instruction *next_insn_same_sec(struct objtool_file *file,
 	return insn;
 }
 
-static struct instruction *next_insn_same_func(struct objtool_file *file,
-					       struct instruction *insn)
+struct instruction *next_insn_same_func(struct objtool_file *file,
+				        struct instruction *insn)
 {
 	struct instruction *next = next_insn_same_sec(file, insn);
 	struct symbol *func = insn_func(insn);
@@ -93,8 +93,8 @@ static struct instruction *prev_insn_same_sec(struct objtool_file *file,
 	return insn - 1;
 }
 
-static struct instruction *prev_insn_same_sym(struct objtool_file *file,
-					      struct instruction *insn)
+struct instruction *prev_insn_same_sym(struct objtool_file *file,
+				       struct instruction *insn)
 {
 	struct instruction *prev = prev_insn_same_sec(file, insn);
 
@@ -110,11 +110,6 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
 		for_each_sec(file, __sec)				\
 			sec_for_each_insn(file, __sec, insn)
 
-#define func_for_each_insn(file, func, insn)				\
-	for (insn = find_insn(file, func->sec, func->offset);		\
-	     insn;							\
-	     insn = next_insn_same_func(file, insn))
-
 #define sym_for_each_insn(file, sym, insn)				\
 	for (insn = find_insn(file, sym->sec, sym->offset);		\
 	     insn && insn->offset < sym->offset + sym->len;		\
@@ -141,15 +136,6 @@ static inline struct symbol *insn_call_dest(struct instruction *insn)
 	return insn->_call_dest;
 }
 
-static inline struct reloc *insn_jump_table(struct instruction *insn)
-{
-	if (insn->type == INSN_JUMP_DYNAMIC ||
-	    insn->type == INSN_CALL_DYNAMIC)
-		return insn->_jump_table;
-
-	return NULL;
-}
-
 static inline unsigned long insn_jump_table_size(struct instruction *insn)
 {
 	if (insn->type == INSN_JUMP_DYNAMIC ||
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index e1cd13cd28a3..e2f755484c4a 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -114,14 +114,30 @@ static inline bool is_jump(struct instruction *insn)
 	return is_static_jump(insn) || is_dynamic_jump(insn);
 }
 
+static inline struct reloc *insn_jump_table(struct instruction *insn)
+{
+	if (insn->type == INSN_JUMP_DYNAMIC ||
+	    insn->type == INSN_CALL_DYNAMIC)
+		return insn->_jump_table;
+
+	return NULL;
+}
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
+struct instruction *prev_insn_same_sym(struct objtool_file *file, struct instruction *insn);
 struct instruction *next_insn_same_sec(struct objtool_file *file, struct instruction *insn);
+struct instruction *next_insn_same_func(struct objtool_file *file, struct instruction *insn);
 
 #define sec_for_each_insn(file, _sec, insn)				\
 	for (insn = find_insn(file, _sec, 0);				\
 	     insn && insn->sec == _sec;					\
 	     insn = next_insn_same_sec(file, insn))
 
+#define func_for_each_insn(file, func, insn)				\
+	for (insn = find_insn(file, func->sec, func->offset);		\
+	     insn;							\
+	     insn = next_insn_same_func(file, insn))
+
 #endif /* _CHECK_H */
-- 
2.47.0.rc1.288.g06298d1525-goog


