Return-Path: <linux-kernel+bounces-339750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E09869E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B32817BD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC331A4E7C;
	Wed, 25 Sep 2024 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1SuUZMLC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74321A4B99
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307609; cv=none; b=Yjv2GgkQzroP0R23M23WpgHBHjUnwTautw7t45osPeYQ5llQIXyVG803U1uiaCnuSP4ZHD1pcHwhW5dT770s3j8dVunx7v0Uvr20P7nKyy35+ROvBmhGju+xUxlen1c8Mrd1aF3QigsFy+9x0qq+5/RyDjEXxpAmtgeV/niboZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307609; c=relaxed/simple;
	bh=HByXTJfGaacs4MV7ivXCvJq3lGnRepYcPD/jPTnE9OU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kOZtkmHePqPezug1cjtjVbP38SFhpR8OGWiX+TyrNKU8f6VQ9NMTmdugGCDPaBDV2oQA7PlN9GlM5NmaDlmVZFokB2IjCo3C9RyyopTRHltEf5tUNGpZyGZ51vmzJNfUVw01YhCRPS2fCwGnbR+Ar4p1hDevnAqf4XP8ucfRpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1SuUZMLC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db791c42e3so7873327b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307607; x=1727912407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RglsluUoLriSL7HbUF8axxP+liCt7+SgicjK27E/sOo=;
        b=1SuUZMLCLU82vqpwJ2mBACpsNRBNdC6WVgRnSbUsvKFPxY7L7MPK+yD6KEXXfewbGy
         2IlShZajn1rcm4+Adt4FxnGW3f8lAaVwWTOvCgLyz4lO80El+dumIJ5vxIPD6tmYdPmT
         IMI3YebIeq3Y99RT7LKLtANVjjuWVoW6yoISfA7j4SPLgTKRTU9wL08lQDX9W+vKXrhG
         Db6PoovDNizNI94JlyD676F7yGDuXQY2UQvVpdGALp+JbBfwrqrSEZMrivm/JTHAtx7t
         OcWJSv3aWbGd6GN2g4L7o9O40Yc1ANrd8kOlS5e3fr9INjBgQxOPt+Z5QkgtJ8wOA5Xm
         7dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307607; x=1727912407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RglsluUoLriSL7HbUF8axxP+liCt7+SgicjK27E/sOo=;
        b=VoWNq3Co2GiWsStCzUQrjMWTtyLEa2PaEXHzYkILAKwoKL4KgqZM5Sj2xZ40tyAqEY
         emPFG30Mc1DerhimsbaJZZYymlvPq3TNRsqXb2qOvykPY2y8cI28QZiGF4U4n0t4roUU
         b/lcRlNPMRxXwXh+U6BEROsNtGU24v07N1x0xIq+OMQlfuxdB1fweNpdRiJNGVQDlGqo
         JusOBCTG5uKRQv+fbh4MjcbB9u/lc9cONuYicX7L8gRjqDxoiG9O5vTWivVf1zj/p6tz
         g7jNYDL3KOLRya7wUE1b52Wej/eYtMmLchD5Gq2Aei7UqhGYfrqVBGagEGmvx+QeuHHJ
         vDcw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Duj8AwCnK8rBIQzQrJQnknxeR6vKzsKz5jT4EX8mWaauaZIXlyBILibqBGo4UFJRtmrV0FVoCQzyYoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UTo1yMf7fckMCRT44bl1ZhXtesvih7Usd+cTjFoEL8xTjIGs
	DYVzuS0dcrpDWEhax72Uv4FRopOK33kZRsEbNRKncXd/C5MLBQCX+SaySCkqK9obwEfCCiNB6J0
	U781Ejg==
X-Google-Smtp-Source: AGHT+IGASCvkEn2P1gDzoqsewJkQJHaAHK03+0AmWd/xawb1XFk5R/bQgX0n7dG9j+urvSvhJWBpQ1ZaL5iI
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:118f:b0:e24:9584:52d3 with SMTP
 id 3f1490d57ef6-e24d71625d8mr82065276.2.1727307606698; Wed, 25 Sep 2024
 16:40:06 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:30 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-16-mmaurer@google.com>
Subject: [PATCH v5 15/16] modpost: Produce extended modversion information
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

Generate both the existing modversions format and the new extended one
when running modpost.

We no longer generate an error on long symbols in modpost, as they can
now be appropriately encoded in the extended section. These symbols will
be skipped in the previous encoding.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/mod/modpost.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 107393a8c48a..f8b7b793d2a2 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1840,15 +1840,48 @@ static void add_versions(struct buffer *b, struct module *mod)
 			continue;
 		}
 		if (strlen(s->name) >= MODULE_NAME_LEN) {
-			error("too long symbol \"%s\" [%s.ko]\n",
-			      s->name, mod->name);
-			break;
+			/* this symbol will only be in the extended info */
+			continue;
 		}
 		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
 			   s->crc, s->name);
 	}
 
 	buf_printf(b, "};\n");
+
+	buf_printf(b, "static const s32 ____version_ext_crcs[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_crcs\") = {\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid) {
+			/*
+			 * We already warned on this when producing the legacy
+			 * modversions table.
+			 */
+			continue;
+		}
+		buf_printf(b, "\t%#8x,\n", s->crc);
+	}
+	buf_printf(b, "};\n");
+
+	buf_printf(b, "static const char ____version_ext_names[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_names\") =\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid) {
+			/*
+			 * We already warned on this when producing the legacy
+			 * modversions table.
+			 * We need to skip its name too, as the indexes in
+			 * both tables need to align.
+			 */
+			continue;
+		}
+		buf_printf(b, "\t\"%s\\0\"\n", s->name);
+	}
+	buf_printf(b, ";\n");
 }
 
 static void add_depends(struct buffer *b, struct module *mod)
-- 
2.46.1.824.gd892dcdcdd-goog


