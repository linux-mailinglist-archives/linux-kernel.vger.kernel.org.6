Return-Path: <linux-kernel+bounces-574650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D6A6E820
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CC93B8B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9512C188713;
	Tue, 25 Mar 2025 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkjewmG+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C89213632B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867785; cv=none; b=HMYedxRhNGmri9y5Ek96d7lswMXAlEkhjfJ+UAeDeiwwEqcLdUkpwQGqKkh/fnkFUdBm5TD/HhhzjMSl3ABQln0Mo824P2fGJazOBRYSzqvZaOShHr8+V9LZXQI3fzaevxkDCxZcJg/jGJrnYf8iEia09yZS+HBpLjhw0dK1dYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867785; c=relaxed/simple;
	bh=48tNNYVxNbJIhapHHVTjKQnmA5ByjfhX/glfPRAKIhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d20iNE2DXEH8bOjry7YSxP/v+fJtiHtWf+JaQjZ6bvpKvw2Ur40WWD/mDK7oLpLtlgl5c3Z5xh2m18013eCFamF5FrEp6m1/kdUaj71DtIw04nZ1006khQFyVSAadZAxW8EWxNYauZ7N5yBbJG3aRmDuX0OadhErYaNPpQ4gOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkjewmG+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so3810247a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742867784; x=1743472584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTUn5qDH83alwoR8172wGnmaTD/nkQcDeotToQ/FQtU=;
        b=FkjewmG+FV+EP/1KOy41Zni1Cd5leqp1EcL7phKYW7cpCLzn++Zs/1mKxv6n5tipbN
         v6dldqrqUyTQ4n+7PVcr7ZTSnPCA38OJWYhB0kcH9grWUqi1AFYcJ/Kvvrv0JGosqNRD
         U1ezVSKfhrrIJ1G05C5QOck61+fy+ZbPZ0vSEwlSIbkG7RvHdGHmBGBEScKIyQeoAc4l
         Pofpt8FV4VBQPXA8Cmk+wsX17H1XKjhZCGYD+o0CvkIjrzvlHm2dB9bOEqBMVq9Sf30M
         6ARjGhcT6puXgBDjmL6spc0Apu15+90hynW8e973xxVIczDWlACRW8SLAFecjQO8WO9N
         vnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742867784; x=1743472584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTUn5qDH83alwoR8172wGnmaTD/nkQcDeotToQ/FQtU=;
        b=lAiDnn+Xi/EGAMNaYO/3HvQf01CAH2mbg3UsONQvXRgZVmBaLXPwuWPUc5LkQzWoPz
         /ZlHpUiSx4MFBrVVQpmzrEDL0tBW/0JSfQX3mCP2HR0kIjwlMO094lrZ6k7qKA1CvNJv
         OquG9SveVWlmPHWxcL2ZdZ1Q1ZjVfzojwgAsBU8iPAjV+pI1+wSEBnL3cfJ6Fk+B3nMl
         YZYnfwJk7vxMTri1F5hOjcq4GVSGWuecj1E3ccuZP+GnS+0eC0JKDHB5ENFrDFyjdNNf
         jT4K+c8C6EVThxn4bZEcdV76TUP8Pcs2jn3Ev8wCcurp5UGkx4d22O1fQ8fqRhIw1OeG
         N+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX5Tk4fjDMpxRlUMiB3NUM5aZ7OPQ4MsuixF40lQzwFaWGpABcrsJANMJ/7mJ3A73KNC1d7FZ27CVzBLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/WRclbOiW8/Qpv6fDNjQCGRYCfozKWfkF2MZiosZKxOVM6DHr
	WHo1jsXmpri+dWgdiCLaFBgdN7u3dm5APO93M2SVRKI+JTL/1yO0ueBzazY9Y8Va+Q==
X-Google-Smtp-Source: AGHT+IFIvVndmJ5T1LC0v2mYgG4gIWIkXYdD4jSAqc98z2o614eIuEt5Jeeq109zoC0i0zwJ2WUV6dM=
X-Received: from pgrx8.prod.google.com ([2002:a65:4548:0:b0:af2:734a:2cfb])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:788b:b0:1f5:8179:4f47
 with SMTP id adf61e73a8af0-1fe42f557edmr27545583637.20.1742867783666; Mon, 24
 Mar 2025 18:56:23 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:56:14 -0700
In-Reply-To: <20250325015617.23455-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325015617.23455-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325015617.23455-2-pcc@google.com>
Subject: [PATCH v3 1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
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


