Return-Path: <linux-kernel+bounces-245098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DD592AE40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F9A1C2121A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF35842067;
	Tue,  9 Jul 2024 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3AnQSYK"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA472BAE1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720492587; cv=none; b=GPFd796lIfAXbCrBbx6Jav+lx3yy+YAcOUMZSDp69J8tYCU+5W5o59jz/oJOO+guC/oHiCVRT7ltzFfISXlXS2JH43xcYF1IXG2o7FOBT1zgf7Tp3rh1i3vR3cZCPwmtyc3A6x8o1VZ+icITwIyogG0UoFNG39Yliq7nRxTp57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720492587; c=relaxed/simple;
	bh=HdzocyhhcEsTlYjD+Ksx6cmA+tXZLJk/zPoz420JlTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Mi4iY5R7kt7Gt5v+xqwcVxoZhB3xw6iW5e0pfvO6SCHAaMqcp5LiYaeQL0q+uolTVyg7O5gLtWMjjGezGmbc4WeE5/TzIAX5NhInKrsJgprGoGeio/2PdhPQywseD1Qpurnq+j22YpSFOTtq8cbPhbTCBlPP2TvpbgJfNQu3XVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3AnQSYK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso249550166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720492584; x=1721097384; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d/wAyZTOVWvFtpD3rAecyL5NKhlbJZDYmglLcjhS/4M=;
        b=M3AnQSYKOkHUXLJCaTlGXh9o7f9GQKSG1cOt3T1YGPPyhKYtgBshKKfjZ6+AR8MFBx
         0Qkad8vdq3K7mC5X/9DSs+LfwKUb29wvI1HAxkZECfdv4uccikS8vqJz22mSJmqYyJHQ
         rtSsrp9PM0z4wfl17h0csGe7sP23CVZj2cUfyd1myMpXbX9GR38Iqp5IVm/L2T+8vysF
         o26zdgtl02B47EW9QdHm7WsqT5d3nmFgQ/oyXHJI+6+RimMud3kxmkb6vLkTkjtfq7ar
         TbeFtMmJuFxpOUJG1bGmraST3GxJwwYpMc/mlmVQw7HL3d000nmkSXGvp+UPSoHZz1Lb
         lV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720492584; x=1721097384;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/wAyZTOVWvFtpD3rAecyL5NKhlbJZDYmglLcjhS/4M=;
        b=u1jnE9DUDpBWF2IzMuSXuOuMLWco4Z7oRP9l+rCP/iAdDliQRXdXCmTUf1K9O5VlnQ
         +/mTZCUvCUwNSdU5+7rC+YzDMQmE8V0F4mHtY0SPCL9yyRRG+J0y7FkMJwqtTHM/apoR
         8k+C0S0sJ1AIuwMKL7fiz+L+vLiR8a6VGYnZm90dTJWwQPN0M3AzwWm2MkGKXXfQQCSX
         Fz1fd/YvW1h1po8uHoB/tWxFsXZdrvhmzfrqTSM5g5odeI67WST65l90eejV0qscw/89
         gvNZjUqtsEP0cdInxx8lIqwMobZf6+3bkU7gH7WeoDNDYP5iw+DQNJFZRI96frzzIxVT
         dDMg==
X-Forwarded-Encrypted: i=1; AJvYcCX4WXM4Xu6uqvyCQDfFQzwj0Yn7mxr4xmKsCpEfzW77/CxIYr2rWyzMS0hW5ZQ/Eqb2S9awFTll94M3cpTfn5pZepOYlTkEQDWbgK6o
X-Gm-Message-State: AOJu0Ywp81WdokukZDUx+iG6EPhE9xdquf/3AfpHTGbe9feq7wwsz+UT
	ZFfPVSExtOcaNI2yMNhcqDCr6yxwig/xflf1rXZ6wXHNJz+xRkaL
X-Google-Smtp-Source: AGHT+IG0bFuBDe46akiyEVESqjZ03+fBK7ogEUSgXPWIa2oJals8wXjwQoZDybeIteOOj7JIhyhzvQ==
X-Received: by 2002:a17:907:3f19:b0:a77:c548:6456 with SMTP id a640c23a62f3a-a780b88608amr89849466b.59.1720492583774;
        Mon, 08 Jul 2024 19:36:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a72fd39sm39561366b.91.2024.07.08.19.36.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2024 19:36:22 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	tandersen@netflix.com,
	mjguzik@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 2/3] kernel/fork.c: get totalram_pages from memblock to calculate max_threads
Date: Tue,  9 Jul 2024 02:36:08 +0000
Message-Id: <20240709023609.21332-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240709023609.21332-1-richard.weiyang@gmail.com>
References: <20240709023609.21332-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Since we plan to move the accounting into __free_pages_core(),
totalram_pages may not represent the total usable pages on system
at this point when defer_init is enabled.

Instead we can get the total estimated pages from memblock directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport (IBM) <rppt@kernel.org>
CC: David Hildenbrand <david@redhat.com>
CC: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 279efadabbf2..d6c2a4ccd532 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -44,6 +44,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/memblock.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -999,7 +1000,7 @@ void __init __weak arch_task_cache_init(void) { }
 static void set_max_threads(unsigned int max_threads_suggested)
 {
 	u64 threads;
-	unsigned long nr_pages = totalram_pages();
+	unsigned long nr_pages = memblock_estimated_nr_free_pages();
 
 	/*
 	 * The number of threads shall be limited such that the thread
-- 
2.34.1


