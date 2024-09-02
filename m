Return-Path: <linux-kernel+bounces-311671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256E968BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E811F23A26
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9396E1AB6CE;
	Mon,  2 Sep 2024 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwcYyvop"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBDF1AB6C3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293966; cv=none; b=KmZBqhIxnPrMUABnk90zQXtuWUES7WnznfMVLf7S3UfKERDzbSZbOhFVXwCHMP33k4fxYAJwKU1DQzePxOwBQbJU8+hHIg61FZ8Y2hiIG5puOkXWyYfIOYxHNcg8n9kGRl9Y5iG/NXXs5spEKTqT8Tr727Rkpg8dGrxL5vKiUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293966; c=relaxed/simple;
	bh=44yzxRSTqwlOROlkCwEXzmTbMUBKaeO1+N1E/oREDTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QThvNnJiHZ0UJ79pLTBMajiDK6oV/uizTTSKzxSMi5l9N8J23isEvY94Otf5ekbDWuHEXoFyvEBqEx0WsYOtH8u6AR1u7Mgo6d/A6KUp/T7mPnT4Vc2+DMZQXN7w0u98l6S2SuB0vrS1cfSoFSk0JNVWailJzR1UrgVI3XIkXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lwcYyvop; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bb6d3e260so37938535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725293962; x=1725898762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DUDom//tRZnCzR0TPrW7dnmFkZZ6kQdXEFrODb12u4=;
        b=lwcYyvopyDeBgfSRp7/tIiAcqCkEOuFwD51W4k3NPu9Z6o0XfXuP2+72Sw/TLb8l22
         nQoGWBcyhptiOP9BWeovgiZROJ/CsKQPSFiQKAz6HVa744lxQEkY8Y8cNNJONSJaqo0Z
         jIwNlMZFR2t5UCdFYyQi+b3ZrSaEsm7QHFderSjWPCWotBHMQ6CHgLXxO1Ek/hU6KEp2
         NPSygsa+43jKjimBcilASH91FJYo1bn5ILNa7BJkZZS7y4NeOiXSYFauUgcDV0fN1jdo
         RiyQpgMOeopXXpxua9DY/ap9RlBvAWatpvlw4KVWhUf2T+78DpwEfJrkMNz+2GuTgURj
         IOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293962; x=1725898762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DUDom//tRZnCzR0TPrW7dnmFkZZ6kQdXEFrODb12u4=;
        b=PRWxzLqaXf0B9/vxTIQrh33FiRRyfvwh86nWKqKKJ3pcGpA910T0nsrfkaRMSaaMc5
         eBTzLEDPLWVvXGyCR9HEQrXEzycn1sQcB10PWEWggz/RFq36IldNd8M8xeIynlG6JhK4
         8YzmD+L+K6fWd5KKMwhsz+15BpLRN2SbAxsB2UTPbrhNnqRwPkOaN9oppR9XyIHbfjwf
         VB9C1AqoRCZ71Qf9qzCjhBnQOHhp1gzjn4++s5V1DAg3E1Hr4cFSV2wfLoV6JNgXOV3H
         dIC0hhxIIBopXOSeFuA04tgOxHWQHthQPTxHBi6sEl+RM5u6qg/I6IvfAO0Bb91CjBHS
         ztfg==
X-Forwarded-Encrypted: i=1; AJvYcCUe/2VYROmLJMAeteEU48zNCzz2n+qMzZVpM6qEXotqgnUNeJ+/2TBmKPiNQRiEkonqReXSSY6H7L0MfW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwTkWcKCjWR8LqKaN9STvAtsGgXbE31MoE+wcifHcL87j6udS
	qmo1Yr+NiQoI1Yhc0udrEUjdmVV7foPAacsn5Kn5ZmwAB0EWUHT8KDSianECbEU=
X-Google-Smtp-Source: AGHT+IHxlg744kdhRp7ia5MEnyLycaQtMyvS6PmquQ558nqH6B/b8PrByKr+corJQzJhDTQ9+etDCA==
X-Received: by 2002:a05:600c:3b87:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-42bdc63348bmr46501825e9.10.1725293961685;
        Mon, 02 Sep 2024 09:19:21 -0700 (PDT)
Received: from ubuntu-vm.. (51-148-40-55.dsl.zen.co.uk. [51.148.40.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb239sm145970065e9.5.2024.09.02.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:19:21 -0700 (PDT)
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 1/2] arm64: alternative: make alternative_has_cap_likely() VDSO compatible
Date: Mon,  2 Sep 2024 16:15:46 +0000
Message-ID: <20240902161912.2751-2-adhemerval.zanella@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902161912.2751-1-adhemerval.zanella@linaro.org>
References: <20240902161912.2751-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

Currently alternative_has_cap_unlikely() can be used in VDSO code, but
alternative_has_cap_likely() cannot as it references alt_cb_patch_nops,
which is not available when linking the VDSO. This is unfortunate as it
would be useful to have alternative_has_cap_likely() available in VDSO
code.

The use of alt_cb_patch_nops was added in commit:

  d926079f17bf8aa4 ("arm64: alternatives: add shared NOP callback")

... as removing duplicate NOPs within the kernel Image saved areasonable
amount of space.

Given the VDSO code will have nowhere near as many alternative branches
as the main kernel image, this isn't much of a concern, and a few extra
nops isn't a massive problem.

Change alternative_has_cap_likely() to only use alt_cb_patch_nops for
the main kernel image, and allow duplicate NOPs in VDSO code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
---
 arch/arm64/include/asm/alternative-macros.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
index d328f549b1a6..c8c77f9e36d6 100644
--- a/arch/arm64/include/asm/alternative-macros.h
+++ b/arch/arm64/include/asm/alternative-macros.h
@@ -230,7 +230,11 @@ alternative_has_cap_likely(const unsigned long cpucap)
 		return false;
 
 	asm goto(
+#ifdef BUILD_VDSO
+	ALTERNATIVE("b	%l[l_no]", "nop", %[cpucap])
+#else
 	ALTERNATIVE_CB("b	%l[l_no]", %[cpucap], alt_cb_patch_nops)
+#endif
 	:
 	: [cpucap] "i" (cpucap)
 	:
-- 
2.43.0


