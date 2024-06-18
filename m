Return-Path: <linux-kernel+bounces-220048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2BD90DBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63A4B223B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78215ECDF;
	Tue, 18 Jun 2024 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sILDxUkM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02A15ECE0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736974; cv=none; b=r5Sy6hMiOx6b0vORUw36gD5Y7JXNGvD3hzUjo4UZoHcMQSgtwRR/2pltZHfFX8CrNwE27pHk2crGoyPs3uPrIO+HSVCShvjmj89SY+7/k6TvBCn5uOceyiYdN+dC5sZF1H4N2Nd29FrruBrDGqJDJZsdbhhHDiz06arcGHkYxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736974; c=relaxed/simple;
	bh=DifcGgZ4gqLiYudF45uENxryUqD1+XBdS+PO9ke3mRg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oD/GBCrXbDfgvW9q6Xuiwa4WOFuHIw7gB3Tv1/um+qrzmxoLk1gxrJlYQVQJKHgHEJ6DFJZxqGCC/kuVem1+cNKPpda15XDT7ZB6NPYjLQ19EmVfSGztZi5+OmL0EpqAGH1uJbuP5W5nVUQ3RsVMGlKWB8Di5SLLGqpO1C1+PSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sILDxUkM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f4a831dd8so105328847b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718736972; x=1719341772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GTbgu4ja5vqrEkefct+zJFTUB3eF6qISm880FN6/VHA=;
        b=sILDxUkMMh2kuT3VcMeyC3+0vy1KmZhVV77lTZjO4a5pLf/jAvsBl812ONUshKN1e/
         OVu5O3N9HH1Hou8soKz6FPS9rQ8tu/pgn6vMWnLXwYlb71ZAKlCE6j8XcieIhj7WCTsw
         sJ05OCj/WWK4AmlxXSW+712ed53dhO4M6CWT/XD8GoUzrD4kqqhEVNXeviuhwzfnoGxW
         r30Fo/SkTNZYRr8SRclajL2Jp0BNsTMkInGIWMepqQJWIYkcTWKnWrPQnzeNJ6BFzf1i
         qACBVZB7UCD+Ehrh4UZp2tNwnyshQpaLFPTttyNuf9qEHXMtDDY1jmyhU4XGUfLmeoGW
         xcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718736972; x=1719341772;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTbgu4ja5vqrEkefct+zJFTUB3eF6qISm880FN6/VHA=;
        b=mhxIESaoFgXu3yEuUxypCqBymn9/1HtklDxxb1AoQOCAdJnqpiQOSNKs3e6iO4Q903
         yahsgftvxGk/CNQShgQgwbLz68JcSCrobJk3xQ6RhuG8KrbGAWH6bcjNLtBAszTfYVlp
         8kOafR1I11h5oVNoMSKVyPUd3O4VtngwXx0NtkQS+TYluM/feknTeFhZs6rFTbB087Cz
         vuv13b2SlrdP/5JBEkgAWWk7VhJZIIZQUlFk8MICN8Iim3Jk10ldIjcYzqfFShL2LSDt
         dN4wTLYjJ4M2qy1U93thETKQHVoPv3B6+5E7Z+LTwScZLLsjhYStx0iaIpn9uW64o+z4
         zJmw==
X-Forwarded-Encrypted: i=1; AJvYcCX3Ch0VxWlpTbgKHXn8+ZPt3hp2Si8zowhrTc5LI4Z3TbBWgRFFkc5H3jlzU+KL24goMvhhEzDbRnPNOhm3da5+KBqkNiFQCHYTmL4Q
X-Gm-Message-State: AOJu0Yy/l6miih4cIhmpLm2EI1CfkYlZNBskaFjqNhoHDzrfvZoSuS49
	tVN06/MXmzwYhu804m67pFNAg49qVBWxn/r9vTXlyxf8fUYVWKr0/iPaLVVXubWUn+zmZw==
X-Google-Smtp-Source: AGHT+IFZeEsxJqQbDjMsCd8Wkmied2xaJ0XNpiPIC05JKI7BgGaBpQVrxgjyuAWOdir7s1t/4HRURCmK
X-Received: from elsk.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:dbd])
 (user=elsk job=sendgmr) by 2002:a05:690c:7091:b0:62c:f01d:3470 with SMTP id
 00721157ae682-63a8fbea0d1mr1446157b3.6.1718736972216; Tue, 18 Jun 2024
 11:56:12 -0700 (PDT)
Date: Tue, 18 Jun 2024 18:56:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618185609.4096399-1-elsk@google.com>
Subject: [PATCH] kconfig: Prevent segfault when getting filename
From: Yifan Hong <elsk@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Yifan Hong <elsk@google.com>, kernel-team@android.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

... and lineno in recursive checks.

If the following snippet is found in Kconfig:

config FOO
        tristate
        depends on BAR
        select BAR
        help
          foo

... without BAR defined; then if one runs
`make tinyconfig`, there is a segfault.

  Kconfig:34:error: recursive dependency detected!
  Kconfig:34:	symbol FOO depends on BAR
  make[4]: *** [scripts/kconfig/Makefile:85: allnoconfig] Segmentation fault

This is because of the following. BAR is
a fake entry created by sym_lookup() with prop
being NULL. In the recursive check, there is a
NULL check for prop to fall back to
stack->sym->prop if stack->prop is NULL. However,
in this case, stack->sym points to the fake BAR
entry created by sym_lookup(), so prop is still
NULL. prop was then referenced without additional
NULL checks, causing segfault.

Similarly, menu is also accessed without NULL
checks. However, sym_lookup() creates entry
that is not a choice, so technically it shouldn't
fall into the state where menu is NULL for
choices. But I mechnically apply the NULL check
anyways for completeness.

This mechnical patch avoids the segfault. The
above snippet produces the following error with
this patch:

  Kconfig:34:error: recursive dependency detected!
  Kconfig:34:	symbol FOO depends on BAR
  ???:-1:	symbol BAR is selected by FOO

That being said, I am not sure if it is the right
fix conceptually and in functionality.

Signed-off-by: Yifan Hong <elsk@google.com>
---
 scripts/kconfig/symbol.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 8df0a75f40b9..72ab4f274289 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1045,6 +1045,8 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 	struct menu *menu = NULL;
 	struct property *prop;
 	struct dep_stack cv_stack;
+	const char *filename = NULL;
+	int lineno = 0;
 
 	if (sym_is_choice_value(last_sym)) {
 		dep_stack_insert(&cv_stack, last_sym);
@@ -1060,6 +1062,10 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 	}
 
 	for (; stack; stack = stack->next) {
+		filename = "???";
+		lineno = 0;
+		menu = NULL;
+
 		sym = stack->sym;
 		next_sym = stack->next ? stack->next->sym : last_sym;
 		prop = stack->prop;
@@ -1073,45 +1079,52 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 				if (prop->menu)
 					break;
 			}
+			if (menu) {
+				filename = menu->filename;
+				lineno = menu->lineno;
+			}
+		} else if (prop) {
+			filename = prop->filename;
+			lineno = prop->lineno;
 		}
 		if (stack->sym == last_sym)
 			fprintf(stderr, "%s:%d:error: recursive dependency detected!\n",
-				prop->filename, prop->lineno);
+				filename, lineno);
 
 		if (sym_is_choice(sym)) {
 			fprintf(stderr, "%s:%d:\tchoice %s contains symbol %s\n",
-				menu->filename, menu->lineno,
+				filename, lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (sym_is_choice_value(sym)) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is part of choice %s\n",
-				menu->filename, menu->lineno,
+				filename, lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (stack->expr == &sym->dir_dep.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s depends on %s\n",
-				prop->filename, prop->lineno,
+				filename, lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (stack->expr == &sym->rev_dep.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is selected by %s\n",
-				prop->filename, prop->lineno,
+				filename, lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (stack->expr == &sym->implied.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is implied by %s\n",
-				prop->filename, prop->lineno,
+				filename, lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (stack->expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s %s value contains %s\n",
-				prop->filename, prop->lineno,
+				filename, lineno,
 				sym->name ? sym->name : "<choice>",
 				prop_get_type_name(prop->type),
 				next_sym->name ? next_sym->name : "<choice>");
 		} else {
 			fprintf(stderr, "%s:%d:\tsymbol %s %s is visible depending on %s\n",
-				prop->filename, prop->lineno,
+				filename, lineno,
 				sym->name ? sym->name : "<choice>",
 				prop_get_type_name(prop->type),
 				next_sym->name ? next_sym->name : "<choice>");
-- 
2.45.2.627.g7a2c4fd464-goog


