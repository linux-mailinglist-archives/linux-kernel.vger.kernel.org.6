Return-Path: <linux-kernel+bounces-313824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4396AA4A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4362C1F219AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F244197A67;
	Tue,  3 Sep 2024 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcwMIkuO"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772613DB88
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399416; cv=none; b=RF5l0Tt3EUjKwKmb3fW9AwHQYUjuVs98VvV99+5QejzH7FAhQCSoGxMAdMyhn7AZv0tfQIP/ytmwljQXZj0WRdyjjaQilE8EI8oAi+rWJ278Q73IopEMIyN5BcTCfJhLVse/IuQK9ORuU4zO86hGFqf6T/LYEoCNvyYwcNAqmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399416; c=relaxed/simple;
	bh=gnjRWvg6rYWtcaH3Fb9oSpupPC8rTBC2uLzUbDKWw80=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sBSIS/RQU2GZtGQwvBkwC1KAsOnCEI+A3GUR+AXpXefFbn200BMhENuQkgTke3PyTJeWXGL5fvEBWRjsJWIaeVwQ6JBWFCGAtJU3E+q0TehIOFGHWptoicSw5q03aN6joScWB+tyHG2N13wqiT+caovDWvqa5w1TykW/xuT7XZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcwMIkuO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1ab008280aso5114704276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725399414; x=1726004214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UmXnnh8rfcf9Ef3Qk2vhXxok9NGUV0TrSFmJAhvfZqQ=;
        b=PcwMIkuOPoYchwcbA6/bUaqCwXSb9V974o0lJTJSKhczo2E8Ht9sdd2JseVyHyS75A
         e8pv/EYQXulxAvDsiKkqg+s3ulN3uftDfEKTJaqjBXx+p504hlSNrun46aeF+6XEWSsV
         3jbbKGUELXu52nFS/iF86VMkJM6C8FDrvpUlmIvMfIITR0AQwCmzs/fZFboGcZ9hFGOH
         uVKDHefp5vAk8bWwYIohzFNhYgWCJi8gtD/pCsiYTjp3sFgvEtfu024mjxFVBzt0+bVR
         v1UZmXMCWtaQWCtz8kqktxTACMyxiKARGerWh93NoUaxx7yuvTEKHHSDspMIFI1gkreW
         6Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399414; x=1726004214;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmXnnh8rfcf9Ef3Qk2vhXxok9NGUV0TrSFmJAhvfZqQ=;
        b=ouaWb41O0ciJ8WeaVDo8ekhc8cr5XZRjfc1Zn7ooHQgEnJhMhTSIkzPa8lfx6CUtGg
         xA3+lKWIVwIX01qfmEE9x2VjK/+pzjPwDgbBm/ZKUXDRIV+K2kThYswNrfY6sogQNMDX
         C0FldYMhHWVJkXhcIXAkQlwG92hhfE0USj06kuRM3skyP+aVEHUkn5QRx485EZdtZUPb
         WhxIIOS9ypbTw6vsZXte19LphPU8rsbBN9vPjoNqDmKyg3ug1Ael1MVu+owqA5gHUuYN
         Tl5oHYx67Y2R/bhlXTRxeE9f+eArTII8H4jBtZNgOehCfwAfbZGNp8e2JwcLsv5WgkB2
         c/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE6ug5C3PTds6oZvz/lMtH2kBQtG/NA4RlmrlLjbK7P6Tk3K6AlpGMWSO+64p4rUHD+ps9PujbElplRkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqumA6D5HAKcIjaigVB04ZN/1VD4QgLWMIvWdRB3jRfPuHTIj
	MMedg8FpTyQsrtFuo1/QiGzfT9tMlNxBxqHHUBeQiq8M87lheCJDEd1msZuBJBdvhyyMtUHpU6u
	uqQ==
X-Google-Smtp-Source: AGHT+IHe87noeWnjfFcEVgXXd4a8n6i/0Cooj3wFTObUDcV3v5LDVjuDx6ZfUiGUxPYz4jmQfYAlTZsvPWs=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:bb58:3d85:3f9c:c6c6])
 (user=yuzhao job=sendgmr) by 2002:a25:e910:0:b0:e11:7039:ff92 with SMTP id
 3f1490d57ef6-e1a7a3e8384mr25459276.11.1725399414110; Tue, 03 Sep 2024
 14:36:54 -0700 (PDT)
Date: Tue,  3 Sep 2024 15:36:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240903213649.3566695-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 1/3] mm/codetag: fix a typo
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/alloc_tag.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 8c61ccd161ba..896491d9ebe8 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -70,7 +70,7 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 /*
  * When percpu variables are required to be defined as weak, static percpu
  * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
- * Instead we will accound all module allocations to a single counter.
+ * Instead we will account all module allocations to a single counter.
  */
 DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 
-- 
2.46.0.469.g59c65b2a67-goog


