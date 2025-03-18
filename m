Return-Path: <linux-kernel+bounces-566957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E78A67EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7673BD590
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9F20766F;
	Tue, 18 Mar 2025 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+0JuCPu"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35332063D7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334095; cv=none; b=D8Vgv6vvbeGKht7UPMuczdxsbascO/lYAaOWQTQpoFVWoL3+0q8M6rJJHxQP3GxxnKb0qmbxpwqvDLAHBLH9RBxE1TW5D1/mVHPbnEnrg9PIvSfLOkZnv1Ca70OKbRUzYCiZ1N8pdgihnwi50jjV/0/ushKnPbiDfnGkNRyJ7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334095; c=relaxed/simple;
	bh=48tNNYVxNbJIhapHHVTjKQnmA5ByjfhX/glfPRAKIhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=POuY45mg3/Lo6ELbq1hld07kvSeodtVYdKOo0LzhDBCrxlW6ue97LzPImzGcbjSwBEKlsGdr0ZGo6tOHOeb/33tVbin6KVR2gKP5A80IY7ufJ6Q7UJI7fzrjIprnaBPKvdupfFZTuCr/PDQnqvRPAcymqFys3WtINQ36lh9SBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+0JuCPu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225ab228a37so86775365ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742334093; x=1742938893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTUn5qDH83alwoR8172wGnmaTD/nkQcDeotToQ/FQtU=;
        b=E+0JuCPuXCTRQpxwuJCoPOuxF5kCEkC/7dh9RpTVY1vd36GHCre9gUgN5wIA20WDmh
         v9ah15eJ4BiIeGZ/MXE7wXesI/NjKWY2vivmuKO18oZfYhqC+iLAqXljJrQ2AJnVipNN
         TppDy357MnlZBUkqmlLwfdx6yobFatF7Dnubot0usBH9Cve4k+UtMD6hAPS8NtBw2dkk
         CO0+agWZuIznwDGLeO0reg59qWzpmwpQTpJZa79dQhJwP34sJ3fDc2F78LJIJX+uTNKW
         7/Z94xujnNdvrEmTR4RF3eg7QrL4B+KX3qL+XyFShFhCfyF4M07YhPjuDbpE4sI243jD
         A4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334093; x=1742938893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTUn5qDH83alwoR8172wGnmaTD/nkQcDeotToQ/FQtU=;
        b=v0ISjchNqBBwz1LoiXqVTInua8p+hGOpT1iRwy7XIzPUOk9EE7jo4XeleKnvjhq/AA
         PvEzqtET2qo1yl+VrxYFDo/3Ch09iVPWVw7E4u4NxGFOLpekouD4+czPP/FWPlqgs2ld
         YkdFqSob2zX/hhmSP/XqSqStg9OgABN+fMCYDiZN7xwh3I9CBg43ZBwGxMDLkmvxa3A4
         TKP0RuDeEDjMY9CQwbt8RHYBIhux8ja1Ko99qnaWv2qWwcYsA139VCBxGBA5YGeJpl6X
         8SZsgtXy6H/FnqHK6i3n9bbXGL2zXNKMrxpzwoip+1zpqeD7LLCEPHt4SHw63ZS17/OR
         dxKg==
X-Forwarded-Encrypted: i=1; AJvYcCWz4k2RbvI7vOwYD5Ujh1BgVar/av35x+C8L+OM3lCqO+r+gsxupoINtR1U1Bf6gA+xR7jbQBlWzlkYsI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTy19QX6RW569LqALA9Rwq+EwuErwRsWeqXVBJrMvGTVwBziVS
	a1uGbS/WtOtlL2kP9U3xTHPC3/EHoF2tAj43y+L9r+N1BkMXlerBl9YasYT/44HN2w==
X-Google-Smtp-Source: AGHT+IG/QGxbxUqv2YDIjQQv/YN/p4GQJhFMy09dmHyQiNHhErBBFph57AE76+yZ/pqecPFGYqZrens=
X-Received: from plsu3.prod.google.com ([2002:a17:902:bf43:b0:223:f487:afc6])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2412:b0:223:3ef1:a30a
 with SMTP id d9443c01a7336-22649a57c52mr3056545ad.45.1742334093068; Tue, 18
 Mar 2025 14:41:33 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:40:32 -0700
In-Reply-To: <20250318214035.481950-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318214035.481950-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250318214035.481950-2-pcc@google.com>
Subject: [PATCH v2 1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The call to read_word_at_a_time() in sized_strscpy() is problematic
with MTE because it may trigger a tag check fault when reading
across a tag granule (16 bytes) boundary. To make this code
MTE compatible, let's start using load_unaligned_zeropad()
on architectures where it is available (i.e. architectures that
define CONFIG_DCACHE_WORD_ACCESS). Because load_unaligned_zeropad()
takes care of page boundaries as well as tag granule boundaries,
also disable the code preventing crossing page boundaries when using
load_unaligned_zeropad().

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
Cc: stable@vger.kernel.org
---
v2:
- new approach

 lib/string.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d25..b632c71df1a50 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -119,6 +119,7 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
 		return -E2BIG;
 
+#ifndef CONFIG_DCACHE_WORD_ACCESS
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	/*
 	 * If src is unaligned, don't cross a page boundary,
@@ -133,12 +134,14 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	/* If src or dest is unaligned, don't do word-at-a-time. */
 	if (((long) dest | (long) src) & (sizeof(long) - 1))
 		max = 0;
+#endif
 #endif
 
 	/*
-	 * read_word_at_a_time() below may read uninitialized bytes after the
-	 * trailing zero and use them in comparisons. Disable this optimization
-	 * under KMSAN to prevent false positive reports.
+	 * load_unaligned_zeropad() or read_word_at_a_time() below may read
+	 * uninitialized bytes after the trailing zero and use them in
+	 * comparisons. Disable this optimization under KMSAN to prevent
+	 * false positive reports.
 	 */
 	if (IS_ENABLED(CONFIG_KMSAN))
 		max = 0;
@@ -146,7 +149,11 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+		c = load_unaligned_zeropad(src+res);
+#else
 		c = read_word_at_a_time(src+res);
+#endif
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
-- 
2.49.0.395.g12beb8f557-goog


