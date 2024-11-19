Return-Path: <linux-kernel+bounces-414204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1779D24B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F86B23CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F7E1C3021;
	Tue, 19 Nov 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mn4ljXIQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF871BD4E1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015225; cv=none; b=BSLFoG+xXCIvbrO0jcal9pf6hr/S3niHHgEJk5WPQgaa75ySlemsOGmK0AR+SOnTFPm99MaC1UTI31119xV7/AsvN7uqDbmv7u6LZs4R0U2FJLf5dexD/H3YihFgvb4XAl8u2zRFt/NDxqcW8/wj+aaAUuW9y2BHUMNTQiWK1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015225; c=relaxed/simple;
	bh=jq7q5gMc0dxUpqOaGwo1iex6hNNf27GUYB57D9I90n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zl/MUsgupsubNnSBBHJcPeuoPN2VXbMOYuY/d+P0eXToQi3aqbiduKxFxTkzq5jNY/8KygHgD99QSE9Sa5OcqOWLQ+sb7Q/09RddOSEWdIuAFV9EAKlzkbeV8gzvwm/V2XOpowiuFrSo1sWikXHq/06rdt3WQVjG7KITx0OTH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mn4ljXIQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314e64eba4so5105625e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732015221; x=1732620021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fVb/aba7kAugbNKh4JU+Sc2Vx3uCwvVw0Yr+o1yHZGI=;
        b=Mn4ljXIQ5FUQRPAePspiHtzRoll1iFzLBFH1vpFBGI1iDknGJeuta1SY+DDV/ZLrGD
         XZhmFRAZ32g7s0q29nSooxlhkXWBQwSdTksDJI4NsV9FLKUJpVUAIX753F4vd1W71jdL
         dXUQpSTTMY+hElhtjiPtPPCrG6zMADIB0GAaesp3/ut6b7S1kNgDqvEMEyW+aIRg5oXd
         v80ahpz9He+HBDhBhYmdtGc5II2P1FcLOgm8vNJEpNKbE08dgV0gbowgwIXjNnUgL2OG
         ONf2975xCIcglMBsPDoTNf6caswZVVG3eH/FmNiCQVXjEFg6QLnYTvABZDIF/l83/EkA
         LdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015221; x=1732620021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVb/aba7kAugbNKh4JU+Sc2Vx3uCwvVw0Yr+o1yHZGI=;
        b=BMJ69nhTJfdzI9giDPImGX11foPaOdJZlXj4wddxYnFbgml1PdIZbMmDpLym40Vmjk
         Zs3rXjL8I/loBFwivyYIQs38bIgFmUjSy1jnHlmImObMUzApW1mQvjFsiYlWrgIyqdZQ
         ljlXcB7foA4BD3gklOth4tl0RRO/s1QPzxDzrW9N8si6UO9OSIsM8zl+zxS6XELgEGUI
         4XWE5KfA+3L5rqEevbWa0GmgX8rHq3fi6GV6YQzMosLZ/tCull9nRmlaKa6Q4/Zw5u6J
         sTAlG8jkSc6BDQMkHSsADBebembQ/JL3mQUsrzpBW5mouoRtugyIt2vP83jOW9t/pXG4
         xGgg==
X-Forwarded-Encrypted: i=1; AJvYcCVPIDhEsCat1WJgCVW6Qq3fclr8WElACAQDJfQrZ7UcB3zFz7tWxhvGWR+PWVwkOcLK9/gkxTT2QkAsVcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XyQQXfUgSjthAWRKE01kIkuOXwQDy2biUP9VSp4aEPIIW1T3
	ZiD0lGWYxGP0Cy8mjiPpjrkgBA07TwvJQJAdIIERWPtFvbjU0YLl3N+aoUpB5V4=
X-Gm-Gg: ASbGncszb+JBYyWqTskzPoKwKyHfKL1wyUK32QTtUoLseDzoYhDAqtB/WsyJEgp+m5B
	pfO3g2ROJYQT15N3k7HCdKspNLg2EYXjWylkgv+MZ1R3RMkhaSY+XwrceOkmSSKd9MPPBgnIBSh
	cwKc2VLFBILV7nkC1X0vDg9KSOwgZn0b31OFte5UyeV8+ZDXGn0Q7xzU6Ltx0atvMnWFWo3cYI4
	8k6j8vsjh2vFgWQDbDxYVxjd+Hu9XCG0qghuKqKK/o=
X-Google-Smtp-Source: AGHT+IE0CgkwbVrPJgyuN/v334z6ESlddBE+ZSqCtlOylTILZqnBOeT5xGKgLIHKCmpm3UVVW48BsQ==
X-Received: by 2002:a05:600c:1c29:b0:42c:aeee:80a with SMTP id 5b1f17b1804b1-432df791c54mr58031795e9.7.1732015221222;
        Tue, 19 Nov 2024 03:20:21 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80a28sm189428165e9.24.2024.11.19.03.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:20:20 -0800 (PST)
From: Petr Tesarik <ptesarik@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Jinbum Park <jinb.park7@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 1/1] mm/rodata_test: Use READ_ONCE() to read const variable
Date: Tue, 19 Nov 2024 12:20:09 +0100
Message-ID: <20241119112009.1286675-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C compiler may optimize away the memory read of a const variable if its
value is known at compile time.

In particular, GCC14 with -O2 generates no code at all for test 1, and it
generates the following x86_64 instructions for test 3:

	cmpl	$195, 4(%rsp)
	je	.L14

That is, it replaces the read of rodata_test_data with an immediate value
and compares it to the value of the local variable "zero".

Use READ_ONCE() to undo any such compiler optimizations and enforce a
memory read.

Fixes: 2959a5f726f6 ("mm: add arch-independent testcases for RODATA")
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 mm/rodata_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index 6d783436951f..3b60425d80fe 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -20,7 +20,7 @@ void rodata_test(void)
 
 	/* test 1: read the value */
 	/* If this test fails, some previous testrun has clobbered the state */
-	if (!rodata_test_data) {
+	if (!READ_ONCE(rodata_test_data)) {
 		pr_err("test 1 fails (start data)\n");
 		return;
 	}
@@ -33,7 +33,7 @@ void rodata_test(void)
 	}
 
 	/* test 3: check the value hasn't changed */
-	if (rodata_test_data == zero) {
+	if (READ_ONCE(rodata_test_data) == zero) {
 		pr_err("test data was changed\n");
 		return;
 	}
-- 
2.46.1


