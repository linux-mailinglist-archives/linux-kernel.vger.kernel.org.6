Return-Path: <linux-kernel+bounces-414235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8779D2505
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BE31F25073
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F61CACEE;
	Tue, 19 Nov 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YPAuLRxB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6211C82FB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016345; cv=none; b=UAxS6KuBI+3o4cvrAURsJlWHsO5IW5axJf0g3YeNBuAGG9Rc8GGlWB46cXg+xMsNjEuI9Gw1HRw1LkNVMmECCzP8MUMKioAuAulctWTFsktuP6laYr3HvQoGKfdj2/71VW0n4bYeXkLBVaHz9AcJf9bC9/ZDmCEJtitlpuQLBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016345; c=relaxed/simple;
	bh=AD7aVppiEUoypwwrI5fFEnFREg2RF9r+D9t6p8/lmKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifwCNk90SdoVd2mphSZsrTClMIHp98oMahyZm8Q1LbG+iuLlE9s1EFvXe9fIkiASvHxJa9dpJLOM2X0IuyRIGqAKbRzVR8jInnA+DT1TvzaCJ/ue+msBYE5qB66rI5K9uFBEXpuAGYQHev56jf3DWCkexj1gzKoijtM9/Bpe7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YPAuLRxB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43158124a54so3572935e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732016342; x=1732621142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG1Omio8IVFrPBZwlyZ1caqZbGlQSUOI66Ha8ppX290=;
        b=YPAuLRxBevyzWs/jf7MVUQVUqHI97VABtYsf+2VyKCkVAqkK3xWSRcI8fSpUwYmohl
         B7yuMiHefl3tiFXNAJUnE3lzkC1E6cHe9WY43HomUVXOaIPe8nnQlGCHTMD+/v/SqjYJ
         3Po/KYHwCmXoKQoPCVH2hWCExuM5RWK8fh7GPdxezaNBgLK/NYtUu7xtw/FjAVbMN3EQ
         A5XBN3ZeV5rChoNYG9t+Rf+NlQOGs3LeRIEgwuqitq/9L0sRKy+e0nO6q3lmg8ktG+tY
         rVG8dqdw/GZjlm1q/08Zj1WN5fVmn6TLSGVlK0JfR4py/rE27PyhfcKeV2Cb+LTiv/mR
         6ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016342; x=1732621142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG1Omio8IVFrPBZwlyZ1caqZbGlQSUOI66Ha8ppX290=;
        b=vU8Ul7RSzzrFuotrdM4gk6mBE60Dswg/caWL8nScl/sKrmdwMpZwVMt3K0mzCtcCth
         6an3vwddGUpeP5xWOzMhlWS/7HhJodgIFjyP6EU88SDALLS52SCJ66I3vx8ebEL39dnO
         +9tiwPgBc1p7apvpp6IvIsXlIQQjJriUpXkT2BpDpOyfVfnXdhEaKpTfN85nDpllmv/X
         p23QxGoWOWbCwrBdaN9ogALexWeCciOkQ0A7eFoQPjeYbiMXt7a+NYjByHJyKJo1pSIv
         hs4v5XJB3Cq9izaxyQFATQj6vOinvJTr88OX4y8wbHNqOInorFrEF2Y7TKBZB59S0HVn
         XHOw==
X-Forwarded-Encrypted: i=1; AJvYcCXHtbhd2bteYHBNF9DqX/E0wQ/621vVKqcaZ2ElbzZoQNZfs3IYUWdCBGAA1BfIpr4lYRw3/+jizx0IMzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5AnqojTremDBA9q0pdhRqJEX+pe4cGF9EuuY8zMlHkF7lLPu
	3Fzv1u5aL+7pHWWUyrn9UZ5/ANECGRIoLh3wMgvHXIasmDmW99lY1H6v1pm6fc8=
X-Google-Smtp-Source: AGHT+IHe6Ej3iWlGns6ushsZHJY6uBzioMg6a5JbQcYzYab97s+KPixmL4yqtwSD1cB4PFDMg9dZtw==
X-Received: by 2002:a05:600c:3ca8:b0:431:5316:6752 with SMTP id 5b1f17b1804b1-432df71e06fmr58418785e9.2.1732016342211;
        Tue, 19 Nov 2024 03:39:02 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1fbf9sm193085875e9.41.2024.11.19.03.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:39:01 -0800 (PST)
From: Petr Tesarik <ptesarik@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Jinbum Park <jinb.park7@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v2 2/2] mm/rodata_test: verify test data is unchanged, rather than non-zero
Date: Tue, 19 Nov 2024 12:37:39 +0100
Message-ID: <386ffda192eb4a26f68c526c496afd48a5cd87ce.1732016064.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1732016064.git.ptesarik@suse.com>
References: <cover.1732016064.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that the test variable holds the initialization value, rather than
any non-zero value.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 mm/rodata_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index 3b60425d80fe..e7173fcd210c 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -12,7 +12,8 @@
 #include <linux/mm.h>
 #include <asm/sections.h>
 
-static const int rodata_test_data = 0xC3;
+#define TEST_VALUE 0xC3
+static const int rodata_test_data = TEST_VALUE;
 
 void rodata_test(void)
 {
@@ -20,7 +21,7 @@ void rodata_test(void)
 
 	/* test 1: read the value */
 	/* If this test fails, some previous testrun has clobbered the state */
-	if (!READ_ONCE(rodata_test_data)) {
+	if (unlikely(READ_ONCE(rodata_test_data) != TEST_VALUE)) {
 		pr_err("test 1 fails (start data)\n");
 		return;
 	}
@@ -33,7 +34,7 @@ void rodata_test(void)
 	}
 
 	/* test 3: check the value hasn't changed */
-	if (READ_ONCE(rodata_test_data) == zero) {
+	if (unlikely(READ_ONCE(rodata_test_data) != TEST_VALUE)) {
 		pr_err("test data was changed\n");
 		return;
 	}
-- 
2.46.1


