Return-Path: <linux-kernel+bounces-294527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9EF958ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD61C21F17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55815C13E;
	Tue, 20 Aug 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3Qe6c7w"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B215A843
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183364; cv=none; b=SDGQgqib5ffIUaPHaBC0GLgEJMtTSRkMurqMOio49ps/LXjZsLMfo4pAuro4VPrFT79BYBTua15JRN4eKUzvUdfpRlRcldpWovsOEZnubbUsisi9Qd1UhLXoG+vEdIdiejR+fZXD/rnP0FsR89YxRZjderTwySOVfZn9/7UVQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183364; c=relaxed/simple;
	bh=9oNV1w3wGfKsfCywfmT2diaojSN6oTskGZWRM52458g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mVqY5GGwLfdC5BEa03lib90EPfTcBYTKxBiXHicrVy6K9s9LmJ574x7rHGzldZiCwzneRzcsKWvD5+CPYiuE7oUrb5vszF9J3BCSp1wrqWYcCiFx3lW2ux5joak6Ais11Iwgye6E6Eur2AI/oVO3zaxxPTu5G0emAqFsmyFOO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3Qe6c7w; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e117634c516so9591945276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724183362; x=1724788162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhd4bVGt7t2cMFreV83ln0lve5lvedn9wm7Lt/YZotw=;
        b=V3Qe6c7w1Ak7ZdvmZnrZHsUYPdaWepbu6VMZCYO9sEH43t/nm77ADcV6T380NNSuC4
         HRJbuf0UpqTaeuX0MKsKmk4zrmeaSL/bf8lshBSB7W6JCIugeHq+ppuf8w6AfKNWKEV7
         xxJuypUQtXOftZxjhq+gMQ3A3CC3zgZekWt+640DU6vxN1xh7JdRwbKoKCvOrswq5zBZ
         ImWM/RCte2APsl/3rPerLgyieW2bv0OGbuw8DGIjDJPDOlL2EiI568zN6eE5jXfS6PuH
         RewJSbhbzDPXcFoUlE+tjJIK9cFdVI90xDwq7EJXSu2XrxDor9PlcGm1WNPmDKcbp/V+
         Jn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724183362; x=1724788162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhd4bVGt7t2cMFreV83ln0lve5lvedn9wm7Lt/YZotw=;
        b=OaiH29soPoq2+rh/nwf9y37uxu/uLf30nP6zEXBqNtlBHCC3Py+3lL07awdoOKUgET
         2vvvby5qa+Iv7kqpW9C3U5TFmQWg20ov/G6X5C3BH8IchWcF7640SFVtW9yJMH3wYkLa
         Ondcv+VHYhPppLNyFbyw0tvC9W0M9JEgR+6YOeeJkI+xlkKxvGMMg7n1rdcEommnmUjg
         CZ7Wu3YwZbk69SdWND4/vKwOG718C4g+ia6Wg7WS8fCdVsanYJQw+155LIC5LopDYYVS
         MDsoxG+G36WlRHiunVky7SmKdUJqc6pTLwxYIbpz87csoKzGnbr0rTI17ETLTXcufVc7
         wjOg==
X-Forwarded-Encrypted: i=1; AJvYcCUE3BNVAD6zjOm3PT1Eexpiq2Pj4Ilv9Mvh5BGN/lGSkuAyWYcwtMZGDpvUTdIcoiESQhlJiwDnGMTykoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjRZoMx/dGz3jC6xp4O4DpuoA1gM0lCFke1ROTvPz5iWQXcu2
	XjsDSQ4IvOqOCLyshWoH3RFm95+ButPn2844k8QjIx5I0s/vRuTBxlA7DFCLWWwSkNC1xTKL/te
	+6UEzQQ==
X-Google-Smtp-Source: AGHT+IEpsPPXTrrUFHSKqTSK6jvaFKxfwi4lcLZMkRceC/2MJEHf7twykkXKb1aOCg41KLuqfqlpbrkDsfBb
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:9744:0:b0:e11:5e87:aab with SMTP id
 3f1490d57ef6-e1665542f69mr767276.10.1724183362312; Tue, 20 Aug 2024 12:49:22
 -0700 (PDT)
Date: Tue, 20 Aug 2024 19:48:57 +0000
In-Reply-To: <20240820194910.187826-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240820194910.187826-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820194910.187826-3-mmaurer@google.com>
Subject: [PATCH v4 2/4] rust: kasan: Rust does not support KHWASAN
From: Matthew Maurer <mmaurer@google.com>
To: andreyknvl@gmail.com, ojeda@kernel.org, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Yoann Congal <yoann.congal@smile.fr>, 
	Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrea Parri <parri.andrea@gmail.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: dvyukov@google.com, aliceryhl@google.com, samitolvanen@google.com, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, glider@google.com, 
	ryabinin.a.a@gmail.com, Matthew Maurer <mmaurer@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rust does not yet have support for software tags. Prevent RUST from
being selected if KASAN_SW_TAGS is enabled.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 72404c1f2157..a8c3a289895e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1907,6 +1907,7 @@ config RUST
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
+	depends on !KASAN_SW_TAGS
 	help
 	  Enables Rust support in the kernel.
 
-- 
2.46.0.184.g6999bdac58-goog


