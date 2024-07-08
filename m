Return-Path: <linux-kernel+bounces-243778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCAC929A70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D051F211E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 01:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DF16FCC;
	Mon,  8 Jul 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+V3YwmP"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8E15A8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720400425; cv=none; b=GmLSSTHoNNlJLmlXxh5qYdNPkGYuRy/lNguAUfceVJrvxQ06vC7AGyvsqVaUkMvDER6iuG0KH6sdSAw1ILb+AToDTipe34dSt5EC0qkoI54z2zfIxv0EBnsVHtG5P+nTwZ9hwilLqBOQbp4ybgk6IhPtwrUJ/fUvbBVL/G8yqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720400425; c=relaxed/simple;
	bh=CWHs1RnZQWzXoqsf0MBy+IdSB7HhewCEIVGilfoyOcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nRRgHMeDZzcoebJP28C6PRBV+cEOmEC0NbNkWFRQGirceq5FEzKwgkdBZCzRoPAo1YpfSVGkk3CCet1VrIyWaylpziaCW68Ty2rBLTiepe1RrqLBkBQBlxg6T2vIzXXIe7xaLKaiCeTXr0WlEu4rtfkHKxRdA8g81lW9aPgXKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+V3YwmP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso3394547a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720400423; x=1721005223; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1GfZdw5ohet6O1nYdwlJF2qI1saYkoy2VpOhi2t3L8=;
        b=U+V3YwmPRqzJLkkmClMF0Sr2nFhobZyaq/N6EhCyVJqxx1b2oHC2v33UNCCafQfLdl
         FJFetJA9KhTEpnAjTi236mCnfD0+9KyjSftX+SkcUAJtc+OhKGWs2294jrCB5+iGkg1J
         EWow+CM/kap83MD+f+sAER78PnqRSEaJjZyDrH4jOfTtl6eeyT+hMkFeMKGFK9QsYgNA
         4Vg6UqTcqYYbGWDuGrzZBhuyLekL7gfPKOgDF4EwCOwA5UFX5k7bovTGZQZwKtD5Pzd7
         tLV90InimRM3Xg+X3FFBhvTA8CCMLXSZjEaGEh8kq/Qm0xLyiGt5Z7y/yxHI7wMDBgLd
         zE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720400423; x=1721005223;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1GfZdw5ohet6O1nYdwlJF2qI1saYkoy2VpOhi2t3L8=;
        b=a2Yr5dly3foPfwBHvn7xifHVVpv+dOOcw3q8mlNxjJIIrj1h9OaQ92g296NiCtiMxm
         vmZIPKUvmHyJwDw+kWDRNCwRTvQg4aEjpXgxYC8XllalF7ztKhj8aoo49RDzN4np5FKw
         x7wHw4Hb6zp/IoD42lF0Lbwia0PgqyX9AeVhvWuv2aIhd6bmkwBt5FSDinlSNdez+fp6
         aWoZqQAYuncJyJxCRivqR2JSws2NrJUkt4yfbu0aRlG1rBypxPfFwAJ68Jfc8Bco7KSu
         hXgdRtUBfs9TgzqdKpQwLrWHII1vvJDvocIN6gBSiS4jX6z+5ZHzt16CzM9//KAhQlF9
         l5jA==
X-Forwarded-Encrypted: i=1; AJvYcCUqEoTbBWb6OCIUyz3s2WMjtuE6+rD+qGy3sXjn5vCQf3nOQWXbQYrI/dm5EK4dhuDbJACMmAWGtd8TkWOD3BlsuemwxeioqkbApoza
X-Gm-Message-State: AOJu0YyTOHf1itre3fzTOXZsuFsCV3umIusHwCoGMqAThMCKKigudct0
	470Bqu9PReZoYte+3idlnDVpHsuJU9csrXcJhpLU3vLpzPO1szr6
X-Google-Smtp-Source: AGHT+IFF/9vfwlHq4uyZ+604i2WZBVekmv9JpXMh9mEhQ568VnjOZHP7nqNEXVDdNyqCqOx53fR5ag==
X-Received: by 2002:a17:906:368c:b0:a75:fb2:8bb2 with SMTP id a640c23a62f3a-a77ba44d1a0mr576797666b.13.1720400422931;
        Sun, 07 Jul 2024 18:00:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77df3d7cb3sm194480366b.100.2024.07.07.18.00.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jul 2024 18:00:21 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	tandersen@netflix.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v4 3/3] kernel/fork.c: put set_max_threads()/task_struct_whitelist() in __init section
Date: Mon,  8 Jul 2024 01:00:10 +0000
Message-Id: <20240708010010.32347-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240708010010.32347-1-richard.weiyang@gmail.com>
References: <20240708010010.32347-1-richard.weiyang@gmail.com>
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
index e80e889543f3..da0b4545d380 100644
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
 	unsigned long nr_pages = memblock_estimated_nr_pages();
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


