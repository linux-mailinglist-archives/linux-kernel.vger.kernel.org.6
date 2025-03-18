Return-Path: <linux-kernel+bounces-566958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA7A67EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6578419C117D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74BC211A1E;
	Tue, 18 Mar 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ir5ZZQK6"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6442066F1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334097; cv=none; b=QekAy5gDeDKhp6lRadY8A/fElcIEgZU252k9d0z+t6AnZ+Oj9pqjOB7dX+A6iRTOyKEzCYcQlvb5bAXPaUamEsN1KDt9jXWxKCVZKR7gAcXHCmlJa8gkZ4Jsbz7FwOsfU8QxvsQJiezQJi0Q/YllfN0KEHakFUQgDNvUSchjwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334097; c=relaxed/simple;
	bh=2JVg6jNN+EXcNb7mKuWKPPuyH/BrxNNvi7msA7FPZpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZlSvqQethK+sMfvL/7wV+TVr5nTsbAjlXmQQq+eriJ+yR210fxBHFtmao3xtUw4IP8xPR8JAQj0lwO3XCIAWSa7kWCDM/2j4s5M+R6ykl+tTGsPRZimwZx2BEWO9sEj2R+jrLiQk9Jp/bZaLfsMGR+XhiOzopehycM9vLudbeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ir5ZZQK6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so9806300a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742334095; x=1742938895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3v041miGofNddzBnUn4Cs5yNorfDPWogz1+D6wVoyA=;
        b=Ir5ZZQK62/5S4SYS82c6xIwYfeod1V+mSobHilPnykNkBIAPcaEG0e3y3ksPC7qAWF
         CmJuKyiBLOGrR1lyqB0aXtVwLyiSuiz9yvO7DhepJxRRo97a8mV97w0MuzkBFwG9T2fM
         tIUdK01ClzzM2HX/DJD8GvK1tzPXzPxu1BL6e02+bFJSq02vy6UROINqI5CMLEG/ztoz
         RMmhWZUbjqq8FmMqIGKENKXOR9JfOAkbMLzR4UO2Tu2eI6ah+qQ+uQcA3ADRWeAisN44
         TbcSVOk+ke4N/zJAWS8eHS8yQFTCbqx4XUSwHtp4r/jBp8G4jvE7XYObetw/elotG9Dn
         c5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334095; x=1742938895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3v041miGofNddzBnUn4Cs5yNorfDPWogz1+D6wVoyA=;
        b=HH+7n6Ys0q7hkX8KBOcstG3XmcNBmW571Z05FgpwOCaOo/tirrznG8HStfXB0CNw7Y
         7uqKMYqhSdXkPoeEdoHvUFep1WjJ3CV+JTEirvdVbGJ6pFRRZZG6cmynhyZYVPu0EYfp
         +QjWubhqYcITv98Vi2jtXb8kqTnJfByG8LnqCNNpMfne3mEsfRNuxQHV0TWon0XeHF56
         LF/rdfk/UbSCVM4509KjWOv6pQnM0FJzaHcxiWxsCcWKWl19EN7lqNDTXJ3In2V+ro7h
         MwKhI704SlDxyrEb1/N/cNnOuIp3LNnnZBlCbeAzne+pc8SfhMN+QxPSHRtZsMaPrBaS
         1LKg==
X-Forwarded-Encrypted: i=1; AJvYcCVUB8wZvDnDEoCt2s+CluGepnfjK27gPeJUcoT84rEe/cngQCvVtsTkKccjWE2rGjTvj93AyadUdKvDi1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWdpY1zlhWrpupZWAniUG/2Wd4TkpkgvwiCEqVlAtqiSKn66gy
	JtC3pc7P4aGal+nN3cn9f1dwdS92cta8rQTFXZwQxz658QZDBzgCEQQRdViY8rDbIQ==
X-Google-Smtp-Source: AGHT+IFLY1EmXxbPh0DHXmzLlTkBArwizsU3t94Vw7f4cPApT4gnOzyKca7K7uUKbY1tEhJcornmRlo=
X-Received: from pjp6.prod.google.com ([2002:a17:90b:55c6:b0:2ef:78ff:bc3b])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38d2:b0:2ff:6f8a:3a13
 with SMTP id 98e67ed59e1d1-301be1f8f6emr353522a91.25.1742334094908; Tue, 18
 Mar 2025 14:41:34 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:40:33 -0700
In-Reply-To: <20250318214035.481950-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318214035.481950-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250318214035.481950-3-pcc@google.com>
Subject: [PATCH v2 2/2] kasan: Add strscpy() test to trigger tag fault on arm64
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, 
	Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When we invoke strscpy() with a maximum size of N bytes, it assumes
that:
- It can always read N bytes from the source.
- It always write N bytes (zero-padded) to the destination.

On aarch64 with Memory Tagging Extension enabled if we pass an N that is
bigger then the source buffer, it triggers an MTE fault.

Implement a KASAN KUnit test that triggers the issue with the current
implementation of read_word_at_a_time() on aarch64 with MTE enabled.

Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Co-developed-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If88e396b9e7c058c1a4b5a252274120e77b1898a
---
v2:
- rebased
- fixed test failure

 mm/kasan/kasan_test_c.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 59d673400085f..c4bb3ee497b54 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1570,7 +1570,9 @@ static void kasan_memcmp(struct kunit *test)
 static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
-	size_t size = 24;
+	char *src, *src2;
+	u8 tag;
+	size_t size = 2 * KASAN_GRANULE_SIZE;
 
 	/*
 	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
@@ -1581,6 +1583,33 @@ static void kasan_strings(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	src = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	strscpy(src, "f0cacc1a00000000f0cacc1a00000000", size);
+
+	tag = get_tag(src);
+
+	src2 = src + KASAN_GRANULE_SIZE;
+
+	/*
+	 * Shorten string and poison the granule after it so that the unaligned
+	 * read in strscpy() triggers a tag mismatch.
+	 */
+	src[KASAN_GRANULE_SIZE - 1] = '\0';
+	kasan_poison(src2, KASAN_GRANULE_SIZE, tag + 1, false);
+
+	/*
+	 * The expected size does not include the terminator '\0'
+	 * so it is (KASAN_GRANULE_SIZE - 2) ==
+	 * KASAN_GRANULE_SIZE - ("initial removed character" + "\0").
+	 */
+	KUNIT_EXPECT_EQ(test, KASAN_GRANULE_SIZE - 2,
+			strscpy(ptr, src + 1, size));
+
+	/* Undo operations above. */
+	src[KASAN_GRANULE_SIZE - 1] = '0';
+	kasan_poison(src2, KASAN_GRANULE_SIZE, tag, false);
+
+	kfree(src);
 	kfree(ptr);
 
 	/*
-- 
2.49.0.395.g12beb8f557-goog


