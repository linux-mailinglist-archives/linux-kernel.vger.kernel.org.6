Return-Path: <linux-kernel+bounces-556193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95862A5C249
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E273B2529
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3071D5CC7;
	Tue, 11 Mar 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGHkQ7zB"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD11D47AD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699111; cv=none; b=Uc3e3aPV5hIquyfyY5szLhz5+mSf1wuTtqOQBnJYWGhSeHK363RD/OEmKpgiRLo1MqjRrx/9imS5dcfthNApYpFhTVK8A5sE3sgg9XA+Hswz6ulxt+AFzo06iqCEsARDqpxDfgcvraHd+kO2l5fWfJU34QjSSjeLK6kAxkkxl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699111; c=relaxed/simple;
	bh=ZAXSMCvr+IvZnGOVJS0yA66QSG3JhZXcjwBrekeGfBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HaMIoQBNnBEn+N/LnDn1eefrT6IGInb/qa9iqparaKEIUWVq2ZAdvoAwJlYaAbdfpBDfeUbc8XmWSl/jOamt6gNP/bge4ENfGlYhENeYFmjya287pHJIF7tfXdg2D6wTGK0JjYJxiDzlKlROD0emtsfE0GXNZw22yFHi+FYMqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGHkQ7zB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ceed237efso20691295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699108; x=1742303908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGBb/Y6S3RxkI/6vwf1UwhFj4ViFPcNM6Jmgh/1tpM4=;
        b=nGHkQ7zBfBAh0E2oqdVC8DoeXRBzDb5o6fd/qxgNVftEh5BfS8V8XMefPQupXWT6Cw
         OoQww4SZpH+2vtD0gKBju3YWOhP/JOvNWxnjtmAX5s+LhY3ahfCfVTWaSFD+yjeyK9lF
         ADOR8NupGkadboMHeDH0b4p0zjHiLs06Z4MNs4l9kHO0Ko6F01ojAkRgm4xdYJWq1M6K
         6ORviiK+WXuyCoAXtM06rvSCk66nKR7C++Xlk5Ct5ruvb8JE8RGCaP1ehJ6fteyireFt
         gqsgKZcmBi23+CC4RMepurGCXka1zQ3mGBvEO2HUgqiN53E/O4MNM6yn3WgURyFj0DzD
         V4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699108; x=1742303908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGBb/Y6S3RxkI/6vwf1UwhFj4ViFPcNM6Jmgh/1tpM4=;
        b=fh/Pq/CET2w41xUVUve8E4mTRb+MmVaDZ3qWYCgAHAjX6FZiITEJNnuYOAwLC+jgZC
         UYNUrhzs4CzUrbJZHPT/hRCtALJGRxG0Jd/e1Nw+sw2fu3Nz8Fl0Au9xwuP9phU0J7JP
         zAjkB7ZPLcxw60az9zRYoXbO/TKzGGXOoYcoiTbttmSy77iHL3nOnicYPuXsTBkd9xFj
         1SEypgTdEVgDFJi3Lbr/jAj4nmG78U1AQ90iOgRBJk1WR8llZn/+PtZmw8O4YHLilOY4
         A4fW+JriRrsyrxxHSb8b4peI3ixV0pPGDHG1tJIf9/cERfB6at6RPc+p8ky9JqEIO8n1
         JjvA==
X-Forwarded-Encrypted: i=1; AJvYcCXIik+28nmWACHK05hXLH/NWl9Ghn2FXocuzjDC45WP4kx0L3lsuWGReWa6bH9fmYiJ0Td3TaetH6t1aYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+IwA9gNdEymRBfNRw2oRlmA5qEqtx4mVSn4epcSLe7wRYaJyv
	RMWRx0EpIUHSieuaovifc0Pw1NHqc9xDREyUrO0TbdAmvoBZv8fOCUAzt+WVt7rMUWvghe6snWR
	Oiuk9j2F7Qg==
X-Google-Smtp-Source: AGHT+IEB4Ugao+9oG4PoYlVLqRx0MnCh6L1DYai8LwtyRUN8s3dqA+kO7+QszcVXjAFc8ZgqGgWa+WHaCnWckQ==
X-Received: from wmbhc25.prod.google.com ([2002:a05:600c:8719:b0:43c:fce2:1db2])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e8f:b0:43c:f184:2e16 with SMTP id 5b1f17b1804b1-43d01bd2167mr54372315e9.5.1741699108122;
 Tue, 11 Mar 2025 06:18:28 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:16 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-5-dec210a658f5@google.com>
Subject: [PATCH v4 05/12] selftests/mm: Print some details when uffd-stress
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
index d6b57e5a2e1d7611aa1588ee41601ce16117a574..4ba5bf13a0108435ce8b53340b9e17ccd47e859e 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -457,7 +457,8 @@ int main(int argc, char **argv)
 
 	nr_pages_per_cpu = bytes / page_size / nr_parallel;
 	if (!nr_pages_per_cpu) {
-		_err("invalid MiB");
+		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
+			bytes, page_size, nr_parallel);
 		usage();
 	}
 

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


