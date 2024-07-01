Return-Path: <linux-kernel+bounces-235495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100191D5CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CD81C20C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9DB676;
	Mon,  1 Jul 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDFUBxbG"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC1847B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719797666; cv=none; b=gfgXsE3FfFDWxO7cm9A126hNR9c4u9b49xJzo+Ps6VyAh/t+wdGwM4QGuqDaBarBA6rbO3jDURnHvGU/3ZEgN08bJg3bnFIF619HLtkMOLZXmbPZCwBzNlssDsjy+dhoLwe9jsBiCsuLKpRYrYqpzNExsFt1KwYN2G0op0xqDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719797666; c=relaxed/simple;
	bh=up6vic00r/EC983lCSpeqOy8ZwRpFze7coNStEEisAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ssYhVPSzyvhtajHXpSocoA6Io9VxcuCQAD9PRrkNLuBuu0TkmLh+98qR6In8dH1iaUKHiE0iQbCDEocsCSs8PIX9pxRYoc7hcqVM0L70yc7r1A8ZrsDzoTwDjfMkzOMZ4dKWSVE/sLE1Bv1fSed/BIcWV7ZnKNf5+SneYgormP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDFUBxbG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so24765161fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719797662; x=1720402462; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qATZEMh/1klgF7W20a4dIuUsabGQyRb4CXLrEd1f3Bk=;
        b=jDFUBxbG5/w0640cnsfljfg7deGZDmWaOqXg86yxaZEBBtchNN1SHZMMcbwNH5uZsA
         IxOpqSQ8I1VXAOi7XERIe5gJg+ffr4B0zYjqom55wUq54c5Dkafl7t6vEJdeIdgLpvOD
         Ww7znhg9ZZsGR56FuSPP5fYiYh1c4OwpBQ/jXHMLfVBB/v8oai4sSrjeCFYkoBKNQizR
         xs1rNhu2VpG+SFsHqoKsen7P76FLHbfaHsvDEmhv8ikOtrV3vitGCALEHq4BohL1Z6fS
         UVkNaf6IXYKBqcJsFnQWCQY/pQc1wzCiJ0LTTckN0Gq8T/NYkyeE/c67vfdH2BvhSwRI
         Ytlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719797662; x=1720402462;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qATZEMh/1klgF7W20a4dIuUsabGQyRb4CXLrEd1f3Bk=;
        b=riPZ+GZFcxOG7LWMih/Bu2LmBEVReEeTTVZ6LUn5RhjQK/XV2biXrdnhn+Cu6Xj2Cy
         v15MfC2WJIhMM7U+GhYn/cvF7j7EaGja0k1CErcTmreGAqHlC+UIGlLwCA/+xmW+M+LY
         2ticg/Ub3wzfwYFFZazm9QIY5+Bw7kDjBqrn0Av/Lw57yqLchIUhpNdX3dx/zKHe89ts
         eH7BtdlbQuUEdE5upru/BNxp8+oAuBW+BRwahuvSh8mCETvaBW7G0gUd62KcHy/kCXEh
         wjcJiZrYtb90YzAACyvxLU4jbQMlJ8Qq8HVtVtTQ3BoeMvVtyH6xhnVRDZqR8VKphBat
         OsJg==
X-Gm-Message-State: AOJu0YzrwmDpPxKo4j5FVTMXmDRX21qXLUQ5AacoOXueRVJfXHxEgOxK
	RSa4yJ4uTXwy7NK1vKGS6ume6f5c9GbOVLKF1co8JFAMo2hggGBX
X-Google-Smtp-Source: AGHT+IFnHIA0qyXjT34qzJBjabQNmeA/pWdMGS+ibJ9rs+Sfp4za1/I/pamjX3x5a/AiuSV4T4GE9w==
X-Received: by 2002:a05:651c:1245:b0:2ec:b376:3a41 with SMTP id 38308e7fff4ca-2ee5e6c9d00mr23666631fa.51.1719797661939;
        Sun, 30 Jun 2024 18:34:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c835adsm3814440a12.17.2024.06.30.18.34.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2024 18:34:20 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	tandersen@netflix.com
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 2/2] kernel/fork.c: put set_max_threads()/task_struct_whitelist() in __init section
Date: Mon,  1 Jul 2024 01:34:10 +0000
Message-Id: <20240701013410.17260-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240701013410.17260-1-richard.weiyang@gmail.com>
References: <20240701013410.17260-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Function set_max_threads()/task_struct_whitelist() is only used by
fork_init() during bootup.

Let's add __init tag to them.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index eb2b5f96aa61..b42334b53bd6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -997,7 +997,7 @@ void __init __weak arch_task_cache_init(void) { }
 /*
  * set_max_threads
  */
-static void set_max_threads(unsigned int max_threads_suggested)
+static void __init set_max_threads(unsigned int max_threads_suggested)
 {
 	u64 threads;
 	unsigned long nr_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
@@ -1023,7 +1023,7 @@ static void set_max_threads(unsigned int max_threads_suggested)
 int arch_task_struct_size __read_mostly;
 #endif
 
-static void task_struct_whitelist(unsigned long *offset, unsigned long *size)
+static void __init task_struct_whitelist(unsigned long *offset, unsigned long *size)
 {
 	/* Fetch thread_struct whitelist for the architecture. */
 	arch_thread_struct_whitelist(offset, size);
-- 
2.34.1


