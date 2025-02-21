Return-Path: <linux-kernel+bounces-526444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8AA3FEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B77B17D6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA3253B60;
	Fri, 21 Feb 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwNDunNQ"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF62512F2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162358; cv=none; b=ZF04hzehwTLNX2VihCIUf5WFbKxUfoFy81rRCBQONR638QK+3ZZ9+8KXFVqmbLENRgS5YHAuNyL4opgc8BV5HDcxQXih3qoVsI8abEjW/qeN/ELY+ZcuVyIcu33y0AflrENlcMfr0xzqBv4BXqBy76gCAwSSgsGLM9J3au12/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162358; c=relaxed/simple;
	bh=Se/GydgHH9nLLIGfdGGZR9s2IiE5I/RUbIaLvfmjrag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ouB7KuQFkNCrJdmQ6TYVRyKIKEk5Cczt6fKTpL1U3MQIJHA80JrfEVxK14Y1NNxuyWPDw5XfMwMn471jJeuULzm8XWC0qnAY50NRIEbsQs2CQ738L1fzR6W2CZD5Njd58S/wgu8l4kCZQXcTbpOojLHhzuXfkCoZ5zcRkpGWthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwNDunNQ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f34b3f9f1so1690025f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162355; x=1740767155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0OlocBh0Rs8sEPgodfZSsh3pCn2jLgGhmAgomJhmE4=;
        b=PwNDunNQ4iQ8OFox8WyAWJA0BgqS5SAg/Gur1Pza4LUhj0KA0T85vTztm06k2i34p9
         ElDy+IEDkIitPiF2VT9AqPbXsvEmSBTPAbo8KLK+afhEsJIgP2rm8Q4iLkIhrIK2E3DF
         X5mimesiIzbnbBaiNwGTx1Z5O57lvWio3EyD9qnDKEdz3IwzcUQ0yblR7xFHLr/ZskMS
         hkCy0YNNYGo2wmzpZtFo+IaDNKLq2Hmi/F/lCEN9YZMDSTGP1AxnkSryzYKMcGzkYMpr
         RgR+CMqGfX7wx+d+SN8OUJRgyXjF9SNSLyd+/5KqQXr/Ufk4LCaAWtFuDzFbOhF+SRq8
         jHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162355; x=1740767155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0OlocBh0Rs8sEPgodfZSsh3pCn2jLgGhmAgomJhmE4=;
        b=gKlbkJzvtxPUy6NkG3lrhG8mU35fl3HEkwERfcEd1Ze5mC+OpHhAAE6pilxbmEbvbw
         K2Amlus7zVtLm04W8JBc4AetrYwzP9cwEmo0AVfs2wJlCnIWx9jEDMe1FEVEvwQSM1Ic
         vkPkBXZ91Dzabqf6coBE1xnX2qbR2KSHcy1ctD1Z9gRU+Bes2B3My91/Ys3QBAv9g7KI
         GQegVhzLTy6y62WlcAk7u6qCGPEGkP7+Q+yB6YFcB/Jwj/YCl4hjH+v4EMKbGf8fRorq
         Vr1nP37qOyRb1XJNf2rl8f3CRGOLeAHQkagr3BcJw2eYtYlCjie07m7t6DAqJxv+qaJO
         /E7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwgOu6FrFUlkQydxFuD3eTWPyP0cALx0Z+sJqJHQLoNsH9etex+QQQF98aVVAwmTRudBgXELkf1O1o6HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16XFmgip7wNf8X2r9DBmKvszhtGBF0TGAALsPrWDgv+xm6+jX
	A6BSCWd1HfC+8XzXDPleXmjWVAnr4K5vufj9D4DX4lfWUV4KheJH9B2O9UyBvUfiHFu8nFgSUUZ
	HAyNfCntsJg==
X-Google-Smtp-Source: AGHT+IHF00NYCWo/+nsUyTvFt7hFdbCjIyIp1GC7s9p832mqevEFRq+xbxahQieU1de9AeZKv94BIe2ilx4pmg==
X-Received: from wrbed10.prod.google.com ([2002:a05:6000:20ca:b0:38f:59c8:7f1d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c6:b0:38f:23ed:2c7 with SMTP id ffacd0b85a97d-38f6e95af22mr4581182f8f.14.1740162355261;
 Fri, 21 Feb 2025 10:25:55 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:43 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-4-28c4d66383c5@google.com>
Subject: [PATCH v2 4/9] selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It's obvious that this should fail in that case, but still, save the
reader the effort of figuring out that they've run into this by just
SKIPping

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-wp-mremap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 2c4f984bd73caa17e12b9f4a5bb71e7fdf5d8554..c2ba7d46c7b4581a3c32a6b6acd148e3e89c2172 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -182,7 +182,10 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
 
 	/* Register range for uffd-wp. */
 	if (userfaultfd_open(&features)) {
-		ksft_test_result_fail("userfaultfd_open() failed\n");
+		if (errno == ENOENT)
+			ksft_test_result_skip("userfaultfd not available\n");
+		else
+			ksft_test_result_fail("userfaultfd_open() failed\n");
 		goto out;
 	}
 	if (uffd_register(uffd, mem, size, false, true, false)) {

-- 
2.48.1.601.g30ceb7b040-goog


