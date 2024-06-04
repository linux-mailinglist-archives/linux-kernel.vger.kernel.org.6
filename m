Return-Path: <linux-kernel+bounces-200741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E780D8FB439
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7EF1F27222
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08951755B;
	Tue,  4 Jun 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJYwRNor"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55E1EB26
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508727; cv=none; b=aCEpbQSFsvqGQychLeWhazTuFJ2e/ERWqiFoIeyAyNeRYlSK7kCn4hwSWK8DEiY5+MORegDIu5rtOSYjghhn50eBi73WFOZkGzu1I1twbESGiIMg5X0gZMn7360Ajzo8tUakrCJNkywARnPhPBMPfSKCi6tSkYMPtvcAcPDaWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508727; c=relaxed/simple;
	bh=EOR86DyJUFyt6vi5LLhI5CPugklUIR3Z+4WkALn51GM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kgKgVFypW6kQYqcoxWtKykMg20NkL5yCutP6aK8+0iJf94XXazlGHWloquamcrE5ElO7c9uSDW71hDPOZcBBxBllE0zVHCGKmWlumVezCDUEdPS+xWPqGb7K7RjaF28KwM6vf78fec0OIYeykZAIV6YYGwHfyc3OSDu+P6cEIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJYwRNor; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-57a48571907so2853992a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717508724; x=1718113524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7crr8ViwVUYkJc9K3SnlRI57V9rnb04QET7mfafjGs=;
        b=zJYwRNorktkzoBJ5uMA4tsoxbMlVTvcAcMfh/pymynmDQarGEv88eCEjPmAYTAW+Mx
         4/LBoi+aml8PIU5rbOQGpNOEBXq2ufw4lf3KrNKBqGa0zM9/rYgmQrf0nVGgItXSLmkj
         qSY1XxlPV062Wh1XgRbXFre59UmlzV+5NWYOzkZQOElnKPgUZ+05FCsN/l1mThRRhpGT
         6LmWEy4RAdgBuQ1WtkWd2oZXhtEf/lNGQJMmQWdlyyh9uw0c/KREhlfyBtmqDuBM9lh2
         TEy7p+Epv5lr/UoJ/QqN3wCUben1GGLMRN6DpVCH7nJfu1YoWxibZBHX3CBSb8vmnxaS
         7t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508724; x=1718113524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7crr8ViwVUYkJc9K3SnlRI57V9rnb04QET7mfafjGs=;
        b=CVqYFqFczJPwzG1s9JpGBj6NYUG9KMPHgZHsqK+KLfyisYU7xf2OVbge3UjCfvRRiC
         ZirQMJEhpaDxzSp1l2qUEcxHasP6nUhFzE8xoDPm4yJ1ibbaqFNHnb6XAYemv0LiA4lD
         M7Zhl8CUcFzg+mnnw76CqI7hWjVwAO5lsbzB/vtzciRrgkVo27GD2jdld14145qZj7Ji
         /2kXso9MOVJnh08+IGNZnkXCIL7+/lZTmSrrVsxYvodvzpftPb+GPEPhVGVuflX5BLpB
         BXvEcyjObxwA79WGXzLibjqVVNyIKIAgvDGEWz4/DF3Lh4R8UGo64C6ihkMfzRKyRVXA
         U3yg==
X-Gm-Message-State: AOJu0YxCrsThbZ2rCBkehLpXfzEdiMk+vAs4jtJY6yy8uFboQsnFiYXO
	ILuU2JnxpXw3NlyhNDLdpR1SYdvIU0eK6Igloi10kRr6IhJlSF0xkR8qeXrbrXlIFJfGEOFHhn3
	cMWI7cg==
X-Google-Smtp-Source: AGHT+IGfbXUFOX62jpZi4xsRqvTMlWno8B1zrAd1Vvyf2U/ZTLDJ0EvYZzI7cfb5JDOKPv27f05KuVhm+Fq3
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:789f:7f5b:3f40:46c8])
 (user=dvyukov job=sendgmr) by 2002:aa7:d955:0:b0:57a:885e:1a44 with SMTP id
 4fb4d7f45d1cf-57a885e1bd9mr545a12.1.1717508724013; Tue, 04 Jun 2024 06:45:24
 -0700 (PDT)
Date: Tue,  4 Jun 2024 15:45:04 +0200
In-Reply-To: <cover.1717507310.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <8e7115affb70513cdd9d5ce83547b98c4c5e419f.1717507310.git.dvyukov@google.com>
Subject: [PATCH 3/4] module: Fix KCOV-ignored file name
From: Dmitry Vyukov <dvyukov@google.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, elver@google.com, 
	glider@google.com, nogikh@google.com, tarasmadan@google.com, 
	Dmitry Vyukov <dvyukov@google.com>, Aaron Tomlin <atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Module.c was renamed to main.c, but the Makefile directive
was copy-pasted verbatim with the old file name.
Fix up the file name.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: cfc1d277891e ("module: Move all into module/")
Cc: Aaron Tomlin <atomlin@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
---
 kernel/module/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index a10b2b9a6fdf..50ffcc413b54 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -5,7 +5,7 @@
 
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
-KCOV_INSTRUMENT_module.o := n
+KCOV_INSTRUMENT_main.o := n
 
 obj-y += main.o
 obj-y += strict_rwx.o
-- 
2.45.1.467.gbab1589fc0-goog


