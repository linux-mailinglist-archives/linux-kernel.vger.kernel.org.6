Return-Path: <linux-kernel+bounces-203916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663B08FE1F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05BFB288D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83F913F012;
	Thu,  6 Jun 2024 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g91mZzVQ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFF13C674
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664287; cv=none; b=EaALp+AweYWILtQVdbQ7gC/kqdAXPjRWjKcTijzlXwevr12QMASMn79cklLn38R37Z5X5LHGz9i6PwWB0Tkq1yw2TezVlMPoWWp2v1DBOUEfpyYOB7hTrvBafmcmxCEkxO8+hp0v3BmaxlEDt79mYaAhQR/xFi8iUAvS7t26gvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664287; c=relaxed/simple;
	bh=CLHwP7L0/ux9CLmz+ukY/+pvEHh7wwe2hBd2gGvLaVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZQtKKa5YeIWnHtY86nIheWX+y+VPL9/Z+525tJLDP2vhzRKqPxG3j/PLQBQupVcmtj39hmcXgle2iPoXU7sFyX8sdqwrF0ETT8R0BLrT1Ua587hm3xdh0xHytDNpPFHPgdgkoLveax5HUYmvxAP1COeM2J2GH0JZYdvgeZTYtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g91mZzVQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f63642ab8aso6733665ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717664285; x=1718269085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LaMMkCgoD2esCAQkiWaMg4nJpbFy0zkLlRqQQ/bL3w=;
        b=g91mZzVQguOCQOO/o8/dh7fps2hj68fn84HB9FJRooG8etfU0xInaabu0GpC5oPxZc
         rwIvecPDiSnAg0Irpyo/KuOxYcuiQlNsyo1OKPx2sUIXTkW7PnvuB2HVjPHWyC7Uu0p1
         nMy0V1k0YOOujf2TYkiwiquQssLJYmgHZjcBU2eBGzyXfgbxxzjZ4uKOUULrtTaas7IN
         fmokNnXKlWwO61HQtF+J0WEFxIs+Bye5FH1xERduomE+34nje4g6SiP7cxPjPje6IdKX
         vbKey8f5bE1OJCxZ/EjQpn9RLS5nnwFBTFvAQi87aHFMRygGOhYN4s4XPSkhJPIgbr63
         azmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664285; x=1718269085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LaMMkCgoD2esCAQkiWaMg4nJpbFy0zkLlRqQQ/bL3w=;
        b=OlBpJxdHOtCBplPvZCeEzWkg6293dF7sfmPHMDHHyIUx/gd2hV84fTT6+UcxvyZRgv
         y5yPH9fmHdFQbTL5R9tp9SHBSjZRapI8fp0YRJ6+QDwMuMIZ9JW2R1CLXzqgf7dKWeaP
         e6Gxfp7Ka2T3PiTbYkGzZkaxhw9aPGTb710QtKptfIDJf2oXb2uLA9X+cNjllc7MkkQU
         Q6bb/UWlBYgSsuACx0S7x6qoQqTmymfnhfDvKX0MEkS++skMBTE7bYXAsKPs1QwP0+CB
         rII3R9/FsKOnilqPgSdC/wB6GXvASEWIQWKEyRY8CUTJ6xOlSJtyd+gk27vEz3s32SgV
         sT1A==
X-Forwarded-Encrypted: i=1; AJvYcCV9U5rnQfYE3PmbKKVZ4n5lc1Jj2R8O+OLkh+x+6GrcSTf+P+j5lILX1HWMuHS7SZqcWljWh3Ox5VkAORLYRr1Ih6OUGhDR6gM0YC/f
X-Gm-Message-State: AOJu0YwR7SPgcZrcKl39Uci27a2MeLhtedpKW+KpSjJBycOVKmzUVx/r
	wg2U6czY8EK9goCNHxQ4hhZfsNLhRbFwLSjyhQbhwQtFK3fb8cuw
X-Google-Smtp-Source: AGHT+IGxpQqwtv04/Y9Ak3EGgBqkshIUytt5ok8MuS1ssOunVPTUtvNCxENcTvSLyI1S0QldY0sVXA==
X-Received: by 2002:a17:902:f549:b0:1f4:5278:5c19 with SMTP id d9443c01a7336-1f6a5a5ca41mr53823725ad.49.1717664284995;
        Thu, 06 Jun 2024 01:58:04 -0700 (PDT)
Received: from localhost (97.64.23.41.16clouds.com. [97.64.23.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f0e2sm9580805ad.5.2024.06.06.01.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:58:04 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH] lockdep: make class_filter() inline and remove unnecessary macros
Date: Thu,  6 Jun 2024 16:57:44 +0800
Message-Id: <20240606085744.3475629-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just a clean code which simplify the code implement and make it
easy to understand. No logic changed from origin implement.

Make class_filter() inline which just return 0, and directly called from
verbose(), very_verbose(), HARDIRQ_verbose() and SOFTIRQ_verbose() without
macro control, remove unnecessary macros VERY_VERBOSE, HARDIRQ_VERBOSE
and SOFTIRQ_VERBOSE.

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
 kernel/locking/lockdep.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..cd8356106da2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -478,21 +478,11 @@ void lockdep_set_selftest_task(struct task_struct *task)
  */
 
 #define VERBOSE			0
-#define VERY_VERBOSE		0
 
-#if VERBOSE
-# define HARDIRQ_VERBOSE	1
-# define SOFTIRQ_VERBOSE	1
-#else
-# define HARDIRQ_VERBOSE	0
-# define SOFTIRQ_VERBOSE	0
-#endif
-
-#if VERBOSE || HARDIRQ_VERBOSE || SOFTIRQ_VERBOSE
 /*
  * Quick filtering for interesting events:
  */
-static int class_filter(struct lock_class *class)
+static inline int class_filter(struct lock_class *class)
 {
 #if 0
 	/* Example */
@@ -506,14 +496,10 @@ static int class_filter(struct lock_class *class)
 	/* Filter everything else. 1 would be to allow everything else */
 	return 0;
 }
-#endif
 
 static int verbose(struct lock_class *class)
 {
-#if VERBOSE
 	return class_filter(class);
-#endif
-	return 0;
 }
 
 static void print_lockdep_off(const char *bug_msg)
@@ -809,10 +795,7 @@ static void print_kernel_ident(void)
 
 static int very_verbose(struct lock_class *class)
 {
-#if VERY_VERBOSE
 	return class_filter(class);
-#endif
-	return 0;
 }
 
 /*
@@ -4171,18 +4154,12 @@ void print_irqtrace_events(struct task_struct *curr)
 
 static int HARDIRQ_verbose(struct lock_class *class)
 {
-#if HARDIRQ_VERBOSE
 	return class_filter(class);
-#endif
-	return 0;
 }
 
 static int SOFTIRQ_verbose(struct lock_class *class)
 {
-#if SOFTIRQ_VERBOSE
 	return class_filter(class);
-#endif
-	return 0;
 }
 
 static int (*state_verbose_f[])(struct lock_class *class) = {
-- 
2.38.1


