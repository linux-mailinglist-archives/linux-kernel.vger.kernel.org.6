Return-Path: <linux-kernel+bounces-389235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC289B6A60
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94991F23F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACC622442B;
	Wed, 30 Oct 2024 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIB/cBR/"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D632281C0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307701; cv=none; b=R2hXa21YBUyGWVZVkPctOjogpwR4vZmM6Z+fPC3SLfKdQiKYbwEoNZyf2gVPQVcoQRlQUBGi6QHYA1YkxZ229m2ah6SQY+gIVZ+qO4FLhoa+JBFv/sqYNi74D9DwDkpCnCOe1rPucBFQ1FNLvch0unWW1PQRR4NkvjoqRs0rasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307701; c=relaxed/simple;
	bh=Noz9czmLGberHPSSvaY1aroMtLwxWawxwTgpooPBzsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hr7Q1pOtxhTzEoKHXTeWATfhKFoZRIhv74QEgHQq+3sU8x86I4e6C9PzxWM71sgJ+VXg0vGyNyW2tuAztrOSDpdlKoYH5FAVcHC9UgdQYEE15pzi9A5tpG4w1iwG+swQjzJnqyZmA781ZAAQOebrAKX27PA/0va05Kqk/cFWGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gIB/cBR/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7edae5ec254so40991a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730307697; x=1730912497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSeLVSqjX7ISXbQe+qPsetZKu3D0M6OAyprkgMIQj/E=;
        b=gIB/cBR/qRxycJVfzzNi/nCmis3lfak3PkY3dDqQbUPfBTy/LlMhl7cb7razEjAVEy
         UpmMGOjdwI7bleauv4/98AXZzbH+HHl2iHrE/e9tqizNJV4YZU8nuJ8e5bferf9vzKVu
         rd+ZMUID0euM3plTjSPpgvuAytxDW5Kq/Bb/bda2f+v1W6wCcyIxB6H/UTrwxX/yHl0P
         P7iLnEXvmgTLuWVvRlQ5YDEs9SqnNkHu3SU48NOYiRZruY0uWD6yiGMGcDvMyN5/TNui
         +QbIpzHYnKanaPmncIrMx7PP86dB1KqFFUuYwcD6khNdM5Gm4c/n7bMdwJTttJvrIllW
         Q50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730307697; x=1730912497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSeLVSqjX7ISXbQe+qPsetZKu3D0M6OAyprkgMIQj/E=;
        b=OF4/NViEKbHSN/FdcFdaivebX0TB3nWBibmDeqRXKzxHlWh9EBVnZWSwJ0/97whCr3
         q+hsuv09g1WiBEZZJ21fLq2QZnhCcBP21WwwBADxCSjZWJM5CvoIr+K9iCeIZjB7f50K
         UKMIvpPGCB244rl8RvgtcEjeOiTJ1unlJ4os2t/evl1ZkkHU2Cy3D4dgiQPrl/O+HW/T
         ivzpO1jBSXioIQimya0Jo67Qh9zdRp34Xj0CWOPJZeKTjb19FoOwFBKRDFNHzrD1IQtW
         bZe1Jnfpy0P459ZSwOCw3LmSeiXOg+ilr1VZP1DsdR56bVqgHz1rpvuzUVi8/x0hxTVW
         LG+A==
X-Forwarded-Encrypted: i=1; AJvYcCUtgV4m9cgYkbwmXBJj1E119MQw6TPLES7r6ZwD1V6djx+GkTIK11UePU4eiDR40oWxC8kqCbdyzWRqO+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4BJygVQ+ZlenN8enBhm2osL8v4FZvFKs8vYcAQEeC000p+rvX
	C9krSPzS8pT9h1ZdZjYn1HFbKEIDACdQQmAqNc9aAxp94PTty8iolgVfAIsLw+9djW+Em/2GLyM
	zEIb5HvaQDjViIXwTaRF8blOdbg==
X-Google-Smtp-Source: AGHT+IGQHAmK0AYLc/JkZISAN+5bLnqsNbj+cfliELKnNYBQqmo5Lc8u43dLpUjfviTrnRuuKiKODcqKS7OGpv/UmzI=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a02:4681:b0:7e9:f93c:22b9 with
 SMTP id 41be03b00d2f7-7edd7d773e1mr53187a12.10.1730307697061; Wed, 30 Oct
 2024 10:01:37 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:01:15 +0000
In-Reply-To: <20241030170106.1501763-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030170106.1501763-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2339; i=samitolvanen@google.com;
 h=from:subject; bh=Noz9czmLGberHPSSvaY1aroMtLwxWawxwTgpooPBzsg=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOlKaWGr47bMTt77dXvcXZOwics6vt1RNBW/8jVUQCJbL
 8/9teK8jlIWBjEOBlkxRZaWr6u37v7ulPrqc5EEzBxWJpAhDFycAjCRtj5Ghlef0p3mbr+8UCj7
 xMc3gg8fvrEOkORf6b/Gzlf0zB7VIhNGhr8fNniVnW7tyJ1xfUXKzICMJZY7norqnZ96zV3AodD uOh8A
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030170106.1501763-29-samitolvanen@google.com>
Subject: [PATCH v5 08/19] gendwarfksyms: Expand array_type
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for expanding DW_TAG_array_type, and the subrange type
indicating array size.

Example source code:

  const char *s[34];

Output with --dump-dies:

  variable array_type[34] {
    pointer_type {
      const_type {
        base_type char byte_size(1) encoding(6)
      }
    } byte_size(8)
  }

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/dwarf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 7e6b477d7c12..ade9b3b7b119 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -219,6 +219,7 @@ DEFINE_PROCESS_UDATA_ATTRIBUTE(encoding)
 	}
 
 DEFINE_MATCH(formal_parameter)
+DEFINE_MATCH(subrange)
 
 bool match_all(Dwarf_Die *die)
 {
@@ -341,6 +342,33 @@ DEFINE_PROCESS_TYPE(shared)
 DEFINE_PROCESS_TYPE(volatile)
 DEFINE_PROCESS_TYPE(typedef)
 
+static void process_subrange_type(struct state *state, struct die *cache,
+				  Dwarf_Die *die)
+{
+	Dwarf_Word count = 0;
+
+	if (get_udata_attr(die, DW_AT_count, &count))
+		process_fmt(cache, "[%" PRIu64 "]", count);
+	else if (get_udata_attr(die, DW_AT_upper_bound, &count))
+		process_fmt(cache, "[%" PRIu64 "]", count + 1);
+	else
+		process(cache, "[]");
+}
+
+static void process_array_type(struct state *state, struct die *cache,
+			       Dwarf_Die *die)
+{
+	process(cache, "array_type");
+	/* Array size */
+	check(process_die_container(state, cache, die, process_type,
+				    match_subrange_type));
+	process(cache, " {");
+	process_linebreak(cache, 1);
+	process_type_attr(state, cache, die);
+	process_linebreak(cache, -1);
+	process(cache, "}");
+}
+
 static void __process_subroutine_type(struct state *state, struct die *cache,
 				      Dwarf_Die *die, const char *type)
 {
@@ -436,7 +464,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 	PROCESS_TYPE(volatile)
 	/* Subtypes */
 	PROCESS_TYPE(formal_parameter)
+	PROCESS_TYPE(subrange)
 	/* Other types */
+	PROCESS_TYPE(array)
 	PROCESS_TYPE(base)
 	PROCESS_TYPE(subroutine)
 	PROCESS_TYPE(typedef)
-- 
2.47.0.163.g1226f6d8fa-goog


