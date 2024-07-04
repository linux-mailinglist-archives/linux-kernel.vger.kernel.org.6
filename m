Return-Path: <linux-kernel+bounces-241110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C72927720
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96631C231E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017511AED50;
	Thu,  4 Jul 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOPN89Zo"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B81AE85D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099514; cv=none; b=IEdKDeORrj2rOEm7tTfvRjGPwyOhyhvheAcAaUTqI4Z0Nfo216VUuL3ApmMImA1ZB5lvCwBG7ygx/u0sICpBY6Z9Mbf038vNJcnjclF89vMGIa8ZUyDxytJyAkbBES9+6Kl7HsmI2e7CEKOYGtrMrCuumd0LN061+xVOOhfW7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099514; c=relaxed/simple;
	bh=rz54NGF1bYly34WveKHk2peLwqlRS1cXKLNWYTQUgeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pg6quzY6EgOpbH/DELCHutqr9d+P6MhvW68j+2io76qRvTQvDjZeCxmYZD3dget8LknHynowTsu5pzvf95aPxJ9cvIwmimqTxfjHK3E0qODB/ARtJSl7bELlfVoWGr90ss7Ui5+7nfKM2yHd5otDg/jC6fxpz1Eb2pZwc5tWs3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DOPN89Zo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a544b9c8so1099163276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720099512; x=1720704312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCULsBZpZETCDZFlOLFmzNWxtcrrOK/eNeDc8GruTOI=;
        b=DOPN89ZoFr2RIqVGAP/ok4qefRbZAoor0hRBEydGbgenu5EVLwqUN4CR/H+xCjced6
         elSKJwkcYyuxyzBk+Ui1Viml4fomi+voHB1Tpg3aGDMZU3GEQXbTZyVIh8u2/Gha3ncl
         hoqFf2+12os8ciex61ZyZ7hhFMshGsqPb4cekadRuuEJ7g3IMTi+HdeXOJdkEcfAuYpn
         wGk3oEK4gxP0Vq7ITVXGLiGc8YczlsIv8QyP+8pscRnyh18ZhyR8Ha7zoXYyQL+1bhTd
         q+NGKK3P5Kib8ffa7o/5vSih5FIVxWSvxbVxQ+/tQsvRsULaheNLpekJ4tXwLsms1L9o
         ZdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720099512; x=1720704312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCULsBZpZETCDZFlOLFmzNWxtcrrOK/eNeDc8GruTOI=;
        b=Vs30hifHgIJeR+Ew4Iu1qUOuBSaDuzhEJZUENEyMkPP1oEjPflwRwKL3MNqLGY0vJz
         hDu6Gk3BrcPfmBUMMyyn/l2y6tnPlCwt/1vr+YMyC8AT4MSYd937LZOnGiWbMB5FkUNg
         nuNom9jvNhmGxWOd2M/uGs1usjJf5t4bjwUs7gfyMe3or2ANuj/IQ+UGVu7vMKXehlnw
         GEUfyfZwSqkJLiAOJ1KcLLHsBZKE5KEYO8ZfaUlUBpGudAJrYyWc0v4BgtB0OHXSSqeH
         9K5rK1YmhXS4qx5bPxW3zBMjeQlb21Ju7QUotJ2ybn7y8ZA6plRpAJffvZuDkOWawDV6
         USXg==
X-Forwarded-Encrypted: i=1; AJvYcCXdd74XJXoc1WV4C44QUAqy+XL0cO83BIz1ncz+q85VC/ht6DRXl0KwGXyOKBmhOlwu0wG8eBO4F23FzlTps5XUqq3Zfqg6CIqyuE+F
X-Gm-Message-State: AOJu0Yya5mWR+cKEsHH8E1QEaI4kYyLp18R6T8Rg/RMO0uGLWQCzFs/y
	hpw098Xnew4T7dXdGH2MJBTJpuN1cSg7gCJEUcPrmFIFwBMDcY3LWA13LGBpCQvZIqOvG82x4WH
	h5w==
X-Google-Smtp-Source: AGHT+IH712XNHqxVjIXgyKpHUY30OYbj94B4bParp2Lp62lZbaqFWNHfdegPRUB0gjfHglxawcMbPXrXPzI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f773:f667:425:1c44])
 (user=surenb job=sendgmr) by 2002:a05:6902:18d2:b0:e02:5b08:d3a with SMTP id
 3f1490d57ef6-e03c15dc5e8mr4473276.0.1720099511838; Thu, 04 Jul 2024 06:25:11
 -0700 (PDT)
Date: Thu,  4 Jul 2024 06:25:06 -0700
In-Reply-To: <20240704132506.1011978-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240704132506.1011978-1-surenb@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704132506.1011978-2-surenb@google.com>
Subject: [PATCH v2 2/2] arch/xtensa: always_inline get_current() and current_thread_info()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, chris@zankel.net, jcmvbkbc@gmail.com, 
	kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, lkp@intel.com, 
	surenb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Mark get_current() and current_thread_info() functions as always_inline
to fix the following modpost warning:

WARNING: modpost: vmlinux: section mismatch in reference: get_current+0xc (section: .text.unlikely) -> initcall_level_names (section: .init.data)

The warning happens when these functions are called from an __init
function and they don't get inlined (remain in the .text section) while
the value they return points into .init.data section. Assuming
get_current() always returns a valid address, this situation can happen
only during init stage and accessing .init.data from .text section during
that stage should pose no issues.

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <stable@vger.kernel.org>
---
 arch/xtensa/include/asm/current.h     | 2 +-
 arch/xtensa/include/asm/thread_info.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/current.h b/arch/xtensa/include/asm/current.h
index 08010dbf5e09..df275d554788 100644
--- a/arch/xtensa/include/asm/current.h
+++ b/arch/xtensa/include/asm/current.h
@@ -19,7 +19,7 @@
 
 struct task_struct;
 
-static inline struct task_struct *get_current(void)
+static __always_inline struct task_struct *get_current(void)
 {
 	return current_thread_info()->task;
 }
diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index 326db1c1d5d8..e0dffcc43b9e 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -91,7 +91,7 @@ struct thread_info {
 }
 
 /* how to get the thread information struct from C */
-static inline struct thread_info *current_thread_info(void)
+static __always_inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
 	 __asm__("extui %0, a1, 0, "__stringify(CURRENT_SHIFT)"\n\t"
-- 
2.45.2.803.g4e1b14247a-goog


