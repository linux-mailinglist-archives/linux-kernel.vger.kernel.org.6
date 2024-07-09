Return-Path: <linux-kernel+bounces-245099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E292AE41
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54841281FA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9555E73;
	Tue,  9 Jul 2024 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBYQj+Rm"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405813FB87
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720492588; cv=none; b=kEd8HoZbGyr2DqgpguVgFK0iCl3cN+MpfF6T+bAW9pOvOgIOg9qQFEmBDiJkFfyMuxatUa9xEV1Mchb5M8RAfQQLjTxpnvLJA1mOa4VeRlNrbAZI48Skfpn2nBTLnO7EwznPoSga9+HfwiJFXFDPwePhqa6/M9O4uHNT7odWjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720492588; c=relaxed/simple;
	bh=CfzR8rkti2evfkgqNVmdIytVN9j4U0j7hdxAnuBqTGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tqXIJR6coshAe9XvPDb8DARBPDTC7UKHL+her4p1CWEsikeOyNIT5Zcd0LDVuABykW8XvIFD49ksX834AM2X5w0EQlYfKAAHwAE4jF3E8/GbZUKcS2AHQPz4n6lyUIDUuC4KbCKXO/bJOwZUXdEV7k3e9nc9tvb/miQwr4tqq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBYQj+Rm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b3fee65d8so5062534a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720492585; x=1721097385; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bjE8DwUrlDCrNUnU9lbz6eMDCZBVO75llm/3njyJ2S8=;
        b=PBYQj+RmaGFjsXrPVChKqW8uXm6YEs+KyQVNTRHn8H9iFXht1O5QdcdTbQBIyDfYK2
         M35CCLZSsF7dgnfOyC3hLv48UZRequr4bLRq7af8qseauRJ4gPDqTlEarXevlqJRJxDC
         iIcwQu0lt+hAIIjRxhcpY5Jk2S8YmycQ74LrHGPuYKR/UcrIsIbLGCnSZmxnqP9z1lb+
         T1KoPPnBxglxz7CarkELl4H7bOyouhWQoT6i5HGJDNcOT6F4Tc7jueWsdFOV3qEaHqqi
         zTWar+dKqwkA+qH6hGzX+BcEhq/oSgPJQpGUcgmThFgk+KCYO0HMXGWPcDlOXy2fLktO
         TMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720492585; x=1721097385;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjE8DwUrlDCrNUnU9lbz6eMDCZBVO75llm/3njyJ2S8=;
        b=vZUafFAwRQS8LhjFDmY3RBTk9RlK7Vdeuh78p/ABcZxi+V47pxHDrTirG3eZ2WkGZg
         J4FqAMHAjUh4w4K+30h3X6mUl7O6/vbGR/wf9OXt0EOe8Bk7koEVmzmE1MicSjGSSlvH
         nsACbm034IYn6V+zXUiVp/idCX3uklniqKJgTrqBYeCLkYgSBX85bVjNPnZUNqUFizWB
         JniGjHHKK+aE6Bmp3z4LN0R/WHIi9Ta4ypnjYZK/+zHJEfZokKV53RKTVONYFYygE67X
         2xttD2IRosGOT7cGbZpvah94cxqP7+C08+xZMTNQgWgCd95bgFlLxZ2OZ2SpfiecIUlt
         dzEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVebrIWbyKRgAtGZPK2Oyp50CrLUuxNj47t8Y6wSsCh2jYHFRfmj9QJFl1cjoklUP2SwqgJUlnfCY+XDOYq923cZ0S86Y5ctjflcg7y
X-Gm-Message-State: AOJu0YxW1MhnYCbq1+oms80KtTkzSXm6YXhxaVFue06cwGP0dhrGg4lM
	v0sHQ0PwSiM0Ghe8S3UXVTY91dlUAilPehRXSEBFj61/mtEOgW+F
X-Google-Smtp-Source: AGHT+IHjanqjTqcL0Xrni4Axg3PX3dOfKaO04+W/v8kVkKYxuwW8Byhz9w7CuaPm/tiMa9Xtq5i5xw==
X-Received: by 2002:a05:6402:651:b0:585:4048:129a with SMTP id 4fb4d7f45d1cf-594bc7c81camr639810a12.31.1720492585198;
        Mon, 08 Jul 2024 19:36:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc4e819bsm500496a12.51.2024.07.08.19.36.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2024 19:36:24 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	tandersen@netflix.com,
	mjguzik@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v5 3/3] kernel/fork.c: put set_max_threads()/task_struct_whitelist() in __init section
Date: Tue,  9 Jul 2024 02:36:09 +0000
Message-Id: <20240709023609.21332-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240709023609.21332-1-richard.weiyang@gmail.com>
References: <20240709023609.21332-1-richard.weiyang@gmail.com>
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
index d6c2a4ccd532..8d37c046dfeb 100644
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
 	unsigned long nr_pages = memblock_estimated_nr_free_pages();
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


