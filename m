Return-Path: <linux-kernel+bounces-336195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F097F074
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360A9B21AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE6F1A3BA4;
	Mon, 23 Sep 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YATp9Xng"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E41A3A85
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115570; cv=none; b=GxnitI9LWNzH9dwITNDqu+whscMegr8oTDHbo+EYWFgoySPE1Fz9OHdn65Q2TSepAn4XrdutCjVbNT8NhV5VBksHkra+jSbEUM46XzI3v8kSSbei3+m5MujQ96wU3zj++T/uYmE/0TumpgF9pedDZWak1Pv4Vn1HmaO0jC44iu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115570; c=relaxed/simple;
	bh=5jrCWgKy6c4XVO9Lg3hj9B9apzoGLkDqi2vgJTVKkFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TN2eVn4ekZc0OzPXerKFurRv5GHd5XisKM63wcOr7eXv2WtE0vrS8yz81kSFAwp+gkf4NulHL1fXMMniIDmsH3xPnNztgYsLar2qxp6DzQNIhts0TG/RlXqEIrNHiAIZ+LuEzEyRNYJnlZWGXPmy+6L8iy5csCkUP6oSpwvac5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YATp9Xng; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2da8c2eeecaso5116455a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727115568; x=1727720368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JY1uJle74XQm0yf6l6izNHChhI79bQGWAHE9tPRlGlo=;
        b=YATp9Xngv3CeHMPnnEctggR44pYDOplQ2/ReScFR9kIuKimn++7qlntDyvLtScRh+f
         jcm37ItjJvbE0jR9jTFrAwiRgaToRE7PP6EDOVPveikLpn4qfAq/IoFjO54zqbug5irm
         9bnwH7n1G+UcJXcgW5C7c9rpiAJRywqvau9i6iTT1gsDKNpcF/eDqgzAd4zKT5ET6Kvw
         AF2i88KoWW6+KicKBCiee8devn9b00y/Tmb9LmnzqsBMn5RYEzORAH848/l/GPx3gpwt
         UKrUEBouZxIxrpAWA2NsMg0jdesmrGATy+SPpgRRGKbeN6p/6dXsFwQ5g4i8zsEVKzTw
         eWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115568; x=1727720368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JY1uJle74XQm0yf6l6izNHChhI79bQGWAHE9tPRlGlo=;
        b=awCN1gHaEgJEQJXd3vtHKnRZ+KAw0NlYtmVOEXh2DA7sxrxbkzwMySq6fmPxxZJoRn
         6SndCSvjVGNHOBa8zJONVR5HZWJvJ2b8kfe5eW0BZDvhIR/YjzMmpogtskiU1L7Rxr0e
         mybezPuFVeupjhqntmH/YYH9upM4Ntajss16Ncrlgi8ud30Y846Kg+mB04zrtpv00BFL
         5kTRsqGy2/t12ob18znRrVYY8VZmFZIpkC6FehYMYpZ/eF9NJE4JghrZOwr2CpbvpiM1
         00YgvgGyRlK+BPw5YFuISz3g+vLlCGfC8fkuf+kFvLCPXO3+L+4Wd24vJqm7gA9WP8hL
         G3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVhISBMsWE7XptATPmP4TwzpVe5zor9+PU7nDru/NyA1CZCcaShSmo7pBZcj3J7JHuK1p62bZPEgeSkgUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNxRDZkruL+zRfwlxFKLWprGmQadv55wCCAV3Ih2ddAKUd1WO
	frRnTywPo+ZAGTYF2j1d7SOpWy4mdbx7LWup2feF8u7KNP/hLipeSCMOMfEo12rZWGj8LZUMyuJ
	8c768nqJ3ERk1b8pLae2cNgedcQ==
X-Google-Smtp-Source: AGHT+IHNkVnvCtV9wup56JFPDu+v4oNO+WNkshVpN7zdW5xRmKK1LUQn3oo3TLrHTIcCE4dCODTQF/nukTA4OVTuUJk=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:dfc4:b0:2d8:f130:82ca with
 SMTP id 98e67ed59e1d1-2dd7f37f32amr22037a91.1.1727115567616; Mon, 23 Sep 2024
 11:19:27 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:18:58 +0000
In-Reply-To: <20240923181846.549877-22-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5089; i=samitolvanen@google.com;
 h=from:subject; bh=5jrCWgKy6c4XVO9Lg3hj9B9apzoGLkDqi2vgJTVKkFo=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDGkfN/J8stnqysVlvOzup6msyXMrlHSdXRROi0ZYNssd/
 Jxhu+ZYRykLgxgHg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZiIQjPDH2696a37j2mVT55z
 MH//p/VTdS4eVw40XcEkGnkxjv+enxbD/1KeQ6dars09xcH76NO5ZyFL7N9s8+uuMWp4frYuUlz HixUA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923181846.549877-34-samitolvanen@google.com>
Subject: [PATCH v3 12/20] gendwarfksyms: Add die_map debugging
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Debugging the DWARF processing can be somewhat challenging, so add
more detailed debugging output for die_map operations. Add the
--dump-die-map flag, which adds color coded tags to the output for
die_map changes.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/gendwarfksyms/dwarf.c         | 15 +++++++++++++++
 scripts/gendwarfksyms/gendwarfksyms.c |  7 +++++++
 scripts/gendwarfksyms/gendwarfksyms.h | 13 +++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 5fb9eadd782c..d2c6e91a7653 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -103,6 +103,8 @@ static void process(struct die *cache, const char *s)
 	if (dump_dies)
 		fputs(s, stderr);
 
+	if (cache)
+		die_debug_r("cache %p string '%s'", cache, s);
 	die_map_add_string(cache, s);
 }
 
@@ -549,6 +551,8 @@ static void process_cached(struct state *state, struct die *cache,
 	list_for_each_entry(df, &cache->fragments, list) {
 		switch (df->type) {
 		case FRAGMENT_STRING:
+			die_debug_b("cache %p STRING '%s'", cache,
+				    df->data.str);
 			process(NULL, df->data.str);
 			break;
 		case FRAGMENT_LINEBREAK:
@@ -558,6 +562,8 @@ static void process_cached(struct state *state, struct die *cache,
 			if (!dwarf_die_addr_die(dwarf_cu_getdwarf(die->cu),
 						(void *)df->data.addr, &child))
 				error("dwarf_die_addr_die failed");
+			die_debug_b("cache %p DIE addr %" PRIxPTR " tag %x",
+				    cache, df->data.addr, dwarf_tag(&child));
 			check(process_type(state, NULL, &child));
 			break;
 		default:
@@ -648,6 +654,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 	cache = die_map_get(die, want_state);
 
 	if (cache->state == want_state) {
+		die_debug_g("cached addr %p tag %x -- %s", die->addr, tag,
+			    die_state_name(cache->state));
+
 		if (want_state == DIE_COMPLETE && is_expanded_type(tag))
 			cache_mark_expanded(&state->expansion_cache, die->addr);
 
@@ -658,6 +667,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 		return 0;
 	}
 
+	die_debug_g("addr %p tag %x -- %s -> %s", die->addr, tag,
+		    die_state_name(cache->state), die_state_name(want_state));
+
 	switch (tag) {
 	/* Type modifiers */
 	PROCESS_TYPE(atomic)
@@ -693,6 +705,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 		error("unexpected type: %x", tag);
 	}
 
+	die_debug_r("parent %p cache %p die addr %p tag %x", parent, cache,
+		    die->addr, tag);
+
 	/* Update cache state and append to the parent (if any) */
 	cache->tag = tag;
 	cache->state = want_state;
diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
index 66806b0936e4..83b7eb8226dd 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.c
+++ b/scripts/gendwarfksyms/gendwarfksyms.c
@@ -19,6 +19,8 @@
 int debug;
 /* Dump DIE contents */
 int dump_dies;
+/* Print debugging information about die_map changes */
+int dump_die_map;
 
 static void usage(void)
 {
@@ -26,6 +28,7 @@ static void usage(void)
 	      "Options:\n"
 	      "  -d, --debug          Print debugging information\n"
 	      "      --dump-dies      Dump DWARF DIE contents\n"
+	      "      --dump-die-map   Print debugging information about die_map changes\n"
 	      "  -h, --help           Print this message\n"
 	      "\n",
 	      stderr);
@@ -74,6 +77,7 @@ int main(int argc, char **argv)
 
 	struct option opts[] = { { "debug", 0, NULL, 'd' },
 				 { "dump-dies", 0, &dump_dies, 1 },
+				 { "dump-die-map", 0, &dump_die_map, 1 },
 				 { "help", 0, NULL, 'h' },
 				 { 0, 0, NULL, 0 } };
 
@@ -93,6 +97,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (dump_die_map)
+		dump_dies = 1;
+
 	if (optind >= argc) {
 		usage();
 		error("no input files?");
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 16d4746aaef9..c913a2421515 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -24,6 +24,7 @@
  */
 extern int debug;
 extern int dump_dies;
+extern int dump_die_map;
 
 /*
  * Output helpers
@@ -46,6 +47,18 @@ extern int dump_dies;
 		exit(1);                                     \
 	} while (0)
 
+#define __die_debug(color, format, ...)                                 \
+	do {                                                            \
+		if (dump_dies && dump_die_map)                          \
+			fprintf(stderr,                                 \
+				"\033[" #color "m<" format ">\033[39m", \
+				__VA_ARGS__);                           \
+	} while (0)
+
+#define die_debug_r(format, ...) __die_debug(91, format, __VA_ARGS__)
+#define die_debug_g(format, ...) __die_debug(92, format, __VA_ARGS__)
+#define die_debug_b(format, ...) __die_debug(94, format, __VA_ARGS__)
+
 /*
  * Error handling helpers
  */
-- 
2.46.0.792.g87dc391469-goog


