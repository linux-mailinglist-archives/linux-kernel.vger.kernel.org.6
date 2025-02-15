Return-Path: <linux-kernel+bounces-516212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED98A36E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37932188F27D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C91A5BAE;
	Sat, 15 Feb 2025 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny2n8nJo"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110523BB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739623976; cv=none; b=rD5jJEg5XSdt/GSO5l45OtTex/3kvjiOaqHrQrLXzkgoZLgmAKNy/DyAK0HapM7nzKln2BJsbSc45AyigqvipW3pKnnt07pLO3PHAU8kkbL/D3cxW1+iECD9AIehWxBrYJqwDOEkEDw4b6Cunz7wNiZ5sQsZ214ZEZlzZn+Mqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739623976; c=relaxed/simple;
	bh=rr0QmYvWEvOXfJauXEKOF5Ddo4waTvSOTRXAoEYEHKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XPvWS+rAwKumXeum096HjVgaTpORHyIBKoizOyOKjs2ctyWZETAPc5T8kX5lzY0C3ucXVzrWr8j3jLrRNfqM3MJse63kOPMzF62//Oly6eoOVJqlBhDU2lscAXdGvvoUkj6lNOXkpJF4Ti3/O6yzAeO/EOqiZrZsEqZWma+V40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny2n8nJo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso1266663f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 04:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739623973; x=1740228773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94n+NEgKc+2cWG3iry0+X20P0PdLxq4qF+vg5cgjhT0=;
        b=Ny2n8nJofLQ7YmwScYQ5reY7AUKgRX8h5GTpq4b2wQPJA4L35k652CTYcubp+auUlK
         UPTNnMbxQGnFzghSs1NxxPIESXOWlqRywWpKi9Fd/CaKgDi0ddvSWVoeChviIeaALU6Q
         ccL71jT1e7xFJOr4Nq5Alu3oqhXyFUZEEv+rhBjPnWrQfzNtW8cHMlS+3AQcntQBk04n
         k9OMsSe3sQa3eTFbapN+9ZlDDzJeI09CsjivULMXwyTQE2K7n57HNqj3PCMZS7d+skKX
         2HfAGqXxMsI6vIf0RqIWozTOi+mb5KHuccPxIrpUURwcRnega6wNOqcdHK+iW2xHogYC
         UhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739623973; x=1740228773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94n+NEgKc+2cWG3iry0+X20P0PdLxq4qF+vg5cgjhT0=;
        b=vzxyQ0W5M1JiOXawqzLmbNrCecXwtSmB3S1HYDPqJTS1WuA4fyAp/RKtGcCQqPn8oj
         nsG8MUIoxyznO/ku6Wz02a8FjttnRDr+oXk6esN9Ci16lScVZ9IZSr+dTv82ZDPiMNOA
         OXBV0U0/Kgsi/0O21XjXOISZbdVemAIttCsAQ0LxOgiUTke4K3w8LC4aZVKb76UCsmpf
         NqJoQZho1IH+ez2MrQ1UV1s8SD2VtjgpwyXiH3I7/vxR4+3V9WbhAfP8AID/cl+hxhqY
         4zP4/UVXNARHsd/ZgcyTz/rs9vsycoxiGHlZcwJDMYFPyGWupL9JJJ0LXwH31QCbb5LA
         Hc+A==
X-Gm-Message-State: AOJu0YynvNQBsllqG3unowdajtkB4QlbMsEhy9kCciK1IUUevldB6DQ1
	A1nA1C6258S3CJIBvhvAWQQ+K6kwool3j8LwawfEg6U0zwjP2Wgd
X-Gm-Gg: ASbGncsewwdNpgMHHvuqn8EephQ7vMKH/jnzHF2soEjVaak96KzTVrUUfM60WcdabrQ
	qDCNzVjiZcM3SvLnfproeyo1tKLBR4sdoTgo87kVqsJY7izB/aQ90IQiY2Enabf/nir8+bfANp6
	KAkFVf9c2OgH7xB678j9w294pzcAV+TKT+CLZWyqi6L5UA+Ik6M+zuJusV1I9sSt4e6ZOy4Oh7D
	diOqq6zg9PW5L/uCNRlq3ZcUg7kD1VLhaPr1VUugh+zJRuHyCBzZ7C3FNHUGOi6dA3YHCbMRndx
	7apgI3u1OGBUSsE=
X-Google-Smtp-Source: AGHT+IG+8DCv0BTmuFge5KxLKySJln8y/zb4iZvad0r+qArMGTq1VwvOx4ZUTl8GqMsXmPi9buZKaA==
X-Received: by 2002:a5d:47ae:0:b0:38d:eb22:b12e with SMTP id ffacd0b85a97d-38f33f1cb71mr3806592f8f.13.1739623972945;
        Sat, 15 Feb 2025 04:52:52 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:25c:5fd7:e9cc:160b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c29sm7207802f8f.72.2025.02.15.04.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 04:52:51 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] x86/mm: Replace manual gap bounding with clamp()
Date: Sat, 15 Feb 2025 12:52:49 +0000
Message-Id: <20250215125249.10729-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than manually bounding gap between gap_min and gap_max,
use the clamp() macro to make the code more concise.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 arch/x86/mm/mmap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index b8a6ffffb451..5ed2109211da 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -84,7 +84,6 @@ static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
-	unsigned long gap_min, gap_max;
 
 	/* Values close to RLIM_INFINITY can overflow. */
 	if (gap + pad > gap)
@@ -94,13 +93,7 @@ static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
 	 * Top of mmap area (just below the process stack).
 	 * Leave an at least ~128 MB hole with possible stack randomization.
 	 */
-	gap_min = SIZE_128M;
-	gap_max = (task_size / 6) * 5;
-
-	if (gap < gap_min)
-		gap = gap_min;
-	else if (gap > gap_max)
-		gap = gap_max;
+	gap = clamp(gap, SIZE_128M, (task_size / 6) * 5);
 
 	return PAGE_ALIGN(task_size - gap - rnd);
 }
-- 
2.39.5


