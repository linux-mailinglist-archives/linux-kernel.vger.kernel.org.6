Return-Path: <linux-kernel+bounces-538982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB10A49F88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311823BA278
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F6280A40;
	Fri, 28 Feb 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qd77Jd84"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181BE280A2D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761709; cv=none; b=C9hgt6bUjIf7Rbav0ZGhvmfxU5Uzsm4ZC6201z6MrDvJhPSK/5bl/BrWPHflKFA8T3fOBbL/DPU1LnMvd925f92HelHFtkXM7g62JtDA+cKIYdM2iMy/OGjwksBPpCiiR6GgYB10M52C3ZapSM8A7uq7r+YpRjTm7YoZfYkAdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761709; c=relaxed/simple;
	bh=7XspZM8ZAnG3LYxKGks+Dzhnygkc4NT/9ogDGinmMCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s8dPZxvWMj1v1KFvotspz7Rd/Ux4V/XqDNASqMUgo29ffzHZGFYMql0/ECzGki1qpBaZCea+S+sm3GBlfqH0ao9TGe5uNNXfMksD8ujWk2FITidr/SfIzf88WcilqcLQ39R3822e6iQoYRzp8xqwy8+1viTuPJ5iaTEhHO5xCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qd77Jd84; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38f28a4647eso1123618f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761706; x=1741366506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9d0/khHAO5zgmsRDUqio7iG7quhZmE2f4ksjxnf1MHE=;
        b=qd77Jd84CQ9m2DNLGHmTlx3hwx1X7C5PUcBsG8fI1f6fh6EaFKsLMx5/y2er1UnyJ+
         +fNkT0VhoCNYeC2Pl9mvpPcMOWSS+/1g98w5RKbG1RzCiU3sJSwmzqiGsxjFaZLxZSv8
         cdY4c8hVEPTCk2eyD+BX6tCcHM+DE0JRZLXaqze8KZ8dLhFuArrEmnHbpmJVHXojWtpo
         opWBky/yp2HrqR3RffICxm0Fp03Cy+Zxszn9Mjz9tc0wqBR7gqqBWzBgNPI/FQiFMnqG
         52wbOX53bh3wX1vzCf7XGGUJa/I8XGgpjIc2qNHgZt0Ly929UQXjMhkZqDojLXJ//Ab4
         O1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761706; x=1741366506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9d0/khHAO5zgmsRDUqio7iG7quhZmE2f4ksjxnf1MHE=;
        b=jBJm/yzx//gxRTFNS1pnmcQjqOOGzkBQ4Em1yChOOWvYDpbJmxo3p68LM16wG8QTqN
         WRad64qOpf44M/MmR4bxujYBxOEOWFrc6Ag5Ny5qiURFLGgvo2atuSv3NKdA0ES/UWym
         q5hLdG9OjSx7MPzFMO48ghD0ywhsVkb97Jg22S6K+AS5KR3NCvj2R5smZNc1o+wUGHKr
         vGNFUKNx2GXgxdEi2IOQB8uuxWQEAbbiGGSYk4doa6SAI5jYlp3tJBkV0ElwMTP8jYn1
         LUA9WKZWUe7ruAmczIXN/XolPT7gDa04KS8ep7rhZ9xC8OSbJToMuHdfiY5U5TK9Msxs
         DuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7URc1QUrMLRsTZpPrV2qlp1ZWJ4JKBLiX6Kb6nVAJQt+V1+yakGfz3Bs5gceMvoh0OV6u1QQ0LWDHQXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SF4qFBuuf6wMkympnRZsuentPXVnc53ONDpxkGc8gsnu1hpI
	+8pUKA2GdvPXQqQiCZQaYJM1YNDC/rgGxNjwsORDvlOhtF3N4SBWqzwaaANF2bRZ45Mqa3KOHtd
	sRhUXQee1+g==
X-Google-Smtp-Source: AGHT+IG11sEYt2OnuCbnie6xNgIUE5IX6nCNDcxXVlZV0z0FMYzaNDcNJwgRdo42mUkZXMNKwRZc5xmL/K51cw==
X-Received: from wrbfy2.prod.google.com ([2002:a05:6000:2d82:b0:390:dd74:bc9c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2a10:b0:38f:4d20:4a0a with SMTP id ffacd0b85a97d-390ec7d1dc5mr2770264f8f.28.1740761706596;
 Fri, 28 Feb 2025 08:55:06 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:53 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-5-958e3b6f0203@google.com>
Subject: [PATCH v3 05/10] selftests/mm: Print some details when uffd-stress
 gets bad params
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

So this can be debugged more easily.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index ec842bbb9f18e291fa51de0ed8d1fbf9aaf14372..efe2051c393096e237d942c04a264b6611a6e127 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -456,7 +456,8 @@ int main(int argc, char **argv)
 
 	nr_pages_per_cpu = bytes / page_size / nr_threads;
 	if (!nr_pages_per_cpu) {
-		_err("invalid MiB");
+		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
+			bytes, page_size, nr_threads);
 		usage();
 	}
 

-- 
2.48.1.711.g2feabab25a-goog


