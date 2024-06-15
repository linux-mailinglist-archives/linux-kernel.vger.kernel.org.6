Return-Path: <linux-kernel+bounces-215982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C90EC909993
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E8E1F21BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DCE55E49;
	Sat, 15 Jun 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="W7fYUzKD"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB050A63
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718476113; cv=none; b=iXsertQi3speZ8CVN0dTXdajOCgQS7WVga95gArp/ld0GqPZfFbhjl4NlmOUT1BinfRdhicIooJqHaw1cApUD0Y7k9GWTyLaII9nVBmamnmj25JaDhuGWo6eb/Yr5Y4BE9Lx5LMqhT7m4nvtnCuvyXxNvXzD6EA5uyjqXFUAczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718476113; c=relaxed/simple;
	bh=MojULXevuVBZf7Jew86/KK2hIQUH03CY6ojPp9rcZQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fa/hXGdDiRdl7on5Bu6e9uD4RxfRl3x3Fqar4fYZK6ktX+rhNIpgTXp9xgvRv2GQWtIH2istU8c4vv2ljjXFn9NN//n662WCt7xtXS5kpCQSLUIZl5Fk+mCmv1asqM5Ds2XSQHKCpTayaqjgsCsUykuswQNpVyZtzNpuPuxpQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=W7fYUzKD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c2c6277ef3so2649406a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1718476110; x=1719080910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOa4EL2QOHlkY1KBVF4rLIyNml+AHSitErfNXPe/ZDo=;
        b=W7fYUzKD73Myp1IYaIT82nHWCUwgoGCAY9i08B9Z3drMrYUtEIvLyEhOHo1HobklVF
         hri9F13dzAq0PF9KCUr39xX2gnW5ItXKIbNNgQGAAfyBDDItju28xwJMZJVtZ/52Uwi1
         O8hijMwciEm7uE4Qom4mjZk85vQka7RD7nN5B89Fee3gP4/FOC+DFTO6iH4RuDC1tDY1
         8AviCmlyuIr3mCaIordHkLlPLnfHpHCKb3UC+UK8NQu8wpF+SKQmt+FE5k5jiLEylE5C
         tn0AOErJ4yBRqQdPieyu6PIX5bFbxmiLzEuuh97pEzoGgfvEk2d65XvntbC3J781RT60
         +xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718476110; x=1719080910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOa4EL2QOHlkY1KBVF4rLIyNml+AHSitErfNXPe/ZDo=;
        b=Gw6eN5qzXxwfYBiYeoPm4m7oU0JJKVQXX3u548Eor9H3XnfMRMJ3BmeNyZb6uleWm+
         X+KsPAwdTfjN4rs0SmNw4vL+hDdXoC2GXcOIKAqecsCH3kMSD57VeNJxwnT4y+7JN6kI
         JzoTmat3pmAk/M5UFN1kIbiUWpGbcvBvQIgRab1wadOd72Nak2pNMoaA/1V9Yrk2evc+
         V6rlQ3GUVJZ3AwqNaePDCs+t7g5lV7aWCvp0mTcFBWEkiLYgilfNUz+WohTa+NQ5fkQf
         dW2VR6c77BuaPSp13U+YCaJlUQJgvuobWPgNXSnxLD/nuo3PqyB5llaeHJ9q0eO9TftZ
         gXGg==
X-Gm-Message-State: AOJu0YzVmecXy0nYV5mOYkhOCGHDeHLGBXK0NyjqrQeJEvg56Dyhe7JE
	mVMHtCNeDnXpgmKu3NJAHewNz/NL6xMno9ZuUCGblocjj9DcpjQA1n7dN68gXCc=
X-Google-Smtp-Source: AGHT+IGL8+wuMeLtL5lsWvGcn57A7lx2hOGD+VPMZ7Qju9XjYe18J9PbGRRjxgxHxHaFKJWluhoW+g==
X-Received: by 2002:a17:90a:c086:b0:2c2:f6c1:4d87 with SMTP id 98e67ed59e1d1-2c4db24d144mr5662861a91.20.1718476110201;
        Sat, 15 Jun 2024 11:28:30 -0700 (PDT)
Received: from debian.vc.shawcable.net. (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c467c6besm6072463a91.52.2024.06.15.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 11:28:29 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ring-buffer: Use vma_pages() helper function
Date: Sat, 15 Jun 2024 20:27:43 +0200
Message-Id: <20240615182742.1234-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the vma_pages() helper function and fix the following
Coccinelle/coccicheck warning reported by vma_pages.cocci:

	WARNING: Consider using vma_pages helper on vma

Rename the local variable vma_pages accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..473ba56b889b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6226,7 +6226,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			struct vm_area_struct *vma)
 {
-	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
+	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
 	unsigned int subbuf_pages, subbuf_order;
 	struct page **pages;
 	int p = 0, s = 0;
@@ -6252,11 +6252,11 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
 	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
 
-	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-	if (!vma_pages || vma_pages > nr_pages)
+	nr_vma_pages = vma_pages(vma);
+	if (!nr_vma_pages || nr_vma_pages > nr_pages)
 		return -EINVAL;
 
-	nr_pages = vma_pages;
+	nr_pages = nr_vma_pages;
 
 	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages)
-- 
2.39.2


