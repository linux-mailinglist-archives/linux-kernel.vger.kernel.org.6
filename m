Return-Path: <linux-kernel+bounces-334943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E2297DEAD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AB02816C5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E083126BE0;
	Sat, 21 Sep 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0gPQhbL"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BA7581A
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726948631; cv=none; b=PQfcWGCTVmAHFYSK29i1AoUROc70TwXXoWZ++CXv9U92x5CDxQsk9iUugexaiEG4lUYH6hNx6xMvHtruO+B0GRqWGpxfQqVGXNn/dRiwUEpQFYbgUBOi4rNsNyDJRY2JrJPN5kE1YGyauFWJiexfudNjeU/LVnALG+LK41n4K3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726948631; c=relaxed/simple;
	bh=P0yvwIw4/C32i1K3Ca/Q+dUMGKZrikS92mEUTx5/M/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ugvwg5hM08zslc+GejbDhPFFpEsJjG8hGqjLQ9HZF5Hjw8cLrc939YYBGPZCYZcwXLRlTC72/BIex4h+BAPm6ADdBK9d1hRo3B8V8LKKpM6X8IgG6iSjTMxcoIhn83EN2/RVOBopWKi6WyQRnorNzk4+FNSpL1zfNqbApbpMEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0gPQhbL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2057835395aso35361865ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726948629; x=1727553429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tL6Q4yRMI5cAA833hyiACaaa+MFKJlXA+BVwOAtvywo=;
        b=g0gPQhbLPuP5f2iKQkreXCuaSgsUERk+l2XWvhzdT/5b+4LgGnl0micrR7H0xx1Yjl
         pMJKkm6Mnj71Sb8ctsD9sVZEvJ0yNUPtlAYlxMp9xfThnPEuIgX53SspK0eh9J0oLKMU
         VFTanwaB6y/YmPc0zuFiAPyeXlXIUrK9NB88IlYlNOBP64WWDEgkv/Efj7tcIj5fevEw
         t1Pkgk2ia4+ReFyuiP4+ikUIkuDhJFW/uysyd6FUvDqWWyX93Bkcj7oDhU6vzZ4lirDA
         WCnzNIsAJChRhzTWu3BAy+EOlFdBNQhItK2lY/+FxSDmNK7jk/9cOGf6+dQQo+Tu/e8Q
         QS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726948629; x=1727553429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tL6Q4yRMI5cAA833hyiACaaa+MFKJlXA+BVwOAtvywo=;
        b=oO0JNsAn3zgHXxWY/FtGavomp8W1WEZxUCO8BI1P7Hubci3R2b+lzCEcnm6VElXPFr
         ebkujwoRsxdjD3gI34BL8YhQqEpYusbcOQhbaCldrInxEzH+ODzpDBnmBB5kIwGLS/4d
         L1Q7GNOLcvXec7vm8JN6+7wzV3h48IRHDfb0HyNtlmZ68HG4ZHDDQzTZCUCLNJ1tt6Pv
         B9B8mbviMA7csm81NX3MoXQevTWK2Ci3FXzK1LQgVCjFp35knPxVD5SaPBcGYs1jPNO6
         cY6jAw9sxCa9FeB0rzaNXVR37ziqoXQ/V1f23bDcO7Shrxs6om6IJT1VKLqRTYezabd8
         Hxpw==
X-Forwarded-Encrypted: i=1; AJvYcCVg4KDbW/tSu9YITYnnecBETofH++HGtkqz6XI6NT6vJnCB6x7o0EXUZYFV0K7GZWcOBJjBXmYW+qO0DeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYJ7NjPwh6ymR1mYRtAcE/hK5QrKO0wrfiyhyLWCA6uxf3iJa
	wKyDrEW5Gx9l5OB4CpVEna5t2j01GNIGavNRGLVVue4FyGjt9hFQ
X-Google-Smtp-Source: AGHT+IHOVPLtF44VuR8xtKWdO1Sdnkq7LicaBWc92K+g37O0VEZI4c3J/dixnkEOEekfoeeN1wANdA==
X-Received: by 2002:a17:903:181:b0:206:9640:e751 with SMTP id d9443c01a7336-208d830ed11mr115040245ad.3.1726948628817;
        Sat, 21 Sep 2024 12:57:08 -0700 (PDT)
Received: from tc.. (c-67-171-216-181.hsd1.or.comcast.net. [67.171.216.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079472fb94sm112006355ad.253.2024.09.21.12.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 12:57:08 -0700 (PDT)
From: Leo Stone <leocstone@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	ruanjinjie@huawei.com
Cc: Leo Stone <leocstone@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org
Subject: [PATCH] mm/damon: fix sparse warning for zero initializer
Date: Sat, 21 Sep 2024 12:54:45 -0700
Message-ID: <20240921195511.364023-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse warns about zero initializing an array with {0,}, change it to
the equivalent {0}.

Fixes the sparse warning:
mm/damon/tests/vaddr-kunit.h:69:47: warning: missing braces around initializer

Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 mm/damon/tests/vaddr-kunit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index a339d117150f..3dad8dfd9005 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -66,7 +66,7 @@ static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
 	static struct mm_struct mm;
-	struct damon_addr_range regions[3] = {0,};
+	struct damon_addr_range regions[3] = {0};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] = {
 		(struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
-- 
2.43.0


