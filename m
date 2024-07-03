Return-Path: <linux-kernel+bounces-238617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8CD924CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F90281AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927AF1FBA;
	Wed,  3 Jul 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwbF50Bc"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59003524C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967935; cv=none; b=cBwxw25yMPo7fjxLr3kEr9uExIBq1zRmQ3lG3aJmgtzzEGDL0SfcA1ZRWhp2CJkkZUHepz3LhIrHUFLR/oxHi/ISVIdAmiDU6rEbY7mdlZ+V3EcAH74L57WoMvNgVol/yGfuODFFgCQRSE7n5IJ77XiVmO3hA4mTezNWqKN5BFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967935; c=relaxed/simple;
	bh=CWHs1RnZQWzXoqsf0MBy+IdSB7HhewCEIVGilfoyOcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RAtkhx1gS12gyPMQTWGJnI23F9FrkjYQuSHEoXjrAU+ybMwMVWK6paylIDD815JdlL7bgmJA8FoALf3MJCW6ZQSLNzov+LKEN5PkA6b6SUD+WnbSA/29HC/nv3sY9gVbWKuhwRzg/UWsm2FB6wA08Cd2L3oG+zQgX1F59SClTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwbF50Bc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a72459d8d6aso490047566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719967933; x=1720572733; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1GfZdw5ohet6O1nYdwlJF2qI1saYkoy2VpOhi2t3L8=;
        b=IwbF50BcVcAPyc0vWwAio3Bw5MCaMM+YEXhG04Rx4Nve2zZxXBFkq60/mWjZhaZiSX
         Bo+s3IJpEuVxZKLKPppt0sm7mUUfR5u8hW2qh6Mi+Ubq1M/JiFr38LlCEaQ5pZiSU5GT
         9FSQK4+m2OG4okS6DxC5b6LUgDnP5gWGjOOvxIGZqCEWaVQFQWxUNo+2cZCJxZfmwsD0
         2XzkEFwZi6kKlncgJ00iFrwRlGulUlrf8JwC8YwB4qIhuUejsa3BVXhM26b8POC0Ovea
         TJM/+UXJVUxyhGnOletpreJJjl+zXUEfPtQ/EW0EXljXmGLjWhSwIHftVf8WT+lBR7qq
         sjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719967933; x=1720572733;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1GfZdw5ohet6O1nYdwlJF2qI1saYkoy2VpOhi2t3L8=;
        b=s3/PmiWUpSEdAOdm3ewhcL3/QOzBwwcrygLgkNJWoTpl5q4B1imx2nQrNQA5DZnQ96
         TRPXpay3KWmdg1ydn4qLIh+w+6QeIFCWmvwdW9ZEjAP1T0vDuzV39EqTWU3jTYXEfGcY
         pVYVzSdoXfeeEvgMREC1uoyYbiJv6f3pIlBkwjlLVLSUpN6MpkxRf452eU8oe6CHa4wi
         J98dECwPueAxbhkwsQcrS4wDcmKIAVivwe+GScPkETbPPIm3JBgs88/pFW3yBexLKqAU
         Bm3VQwEfnjeP692fFcHTCV4ha2hZjMV4qJjciTcLHU7yIUcQOrb1lc8y07Txm34uDPgi
         vB5w==
X-Forwarded-Encrypted: i=1; AJvYcCXGik+WedBtDZvM296i8YcdkTU91zfV/EnrczUubGv6ZSARQ/+ZkidTAiyHgg4p7uTAMJGOIk00mJqsCO5r/9hOulH25ifnsB8UzkJM
X-Gm-Message-State: AOJu0YySDWFRQrNDwZgEzqipwY8E7SsOUAzNqeS5Dv1eiE7RcJz5HRb3
	gm9Lc1C5cHrhbewpQRqzYeT0DR25euhZhX/eFZmH15wW5mOyFbg8JxmB7Tax
X-Google-Smtp-Source: AGHT+IFzTtggPFUKEuWZNlmFKVoT2gXq/hU0dG2odaLvrlmUa7GEr2lbhlu4ZHmb/JS8vH4nQBsLkA==
X-Received: by 2002:a17:906:e205:b0:a6f:e25d:f6a4 with SMTP id a640c23a62f3a-a75144b665dmr561697166b.76.1719967932668;
        Tue, 02 Jul 2024 17:52:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1bc8esm464287666b.35.2024.07.02.17.52.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2024 17:52:12 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	tandersen@netflix.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 3/3] kernel/fork.c: put set_max_threads()/task_struct_whitelist() in __init section
Date: Wed,  3 Jul 2024 00:51:51 +0000
Message-Id: <20240703005151.28712-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240703005151.28712-1-richard.weiyang@gmail.com>
References: <20240703005151.28712-1-richard.weiyang@gmail.com>
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


