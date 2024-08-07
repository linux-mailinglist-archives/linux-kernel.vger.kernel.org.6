Return-Path: <linux-kernel+bounces-278068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95B94AA76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4151F21652
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41684A5C;
	Wed,  7 Aug 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+lFol/P"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320668248C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041575; cv=none; b=RVdVH70DTbRExZwahgv4sgKLHcJBkLfwblIIhg5O5hUrqDeWa4nvkdoZZGKFQHnv0MFIqTOgi3Vdu+B3tyXfmqVdwDL8w7QE5dGLdFqU39SX7/saeYot02hsrigHvJijod/ToDUD1v07dkUWQDtMcXdzuh64xbqfICm+Qp5/F6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041575; c=relaxed/simple;
	bh=WPQeRoVjbHyBaB1jP3uLP9qNWJc7u6TPtPAVY/T4QWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qYyoxWDgp7ne7GU5YSMGYVT6d5icj2+gH2nrfS/JHf8UDulhwhzsgfYUNDP+7LBT5Kidk4V9QKcls8gNbrqR1d5qB3hmrb8Wl6fmU7vbp+QBYYhwAWyIzj4ztpQO41+4B/weY3yIwiJ1hDydEfg+frsOd22ELez3K/0N9IOG3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+lFol/P; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70eb4de4eb9so1911521b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723041573; x=1723646373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF7GVsamqUptJkU2gJsmYYeaq0bMeaFAbotmm0oMB2I=;
        b=Y+lFol/P8Q4R1pWvopj1ZoMSp7EKBxyQ4RTxNSKQ2vnDhcEfPcphf+FBuBtLYZobBh
         RQPxOERnnqJHstai2rswgjLa7o7vEsclPo2tbeFWoMbh/z5n2izJlTF2Z3i/5S6TzFND
         aShY/M6l/yu8gOud83JDbO8EBnBs+7G/Tq/58XTrRgALe5X5yUEy5cIttQyt7olCEluA
         NaSVQUOzxdkjTTZa5yUkM06HEp4LRyFtzlL5IQv5W8jAQsQQe93x3XEgkqHNyh7O+EyX
         d8xI06k16kVQciE2LW7L1t26zgE9TRwewo/bmnWhCf71FaDGAto1FLRsc+IiiB532zW7
         2atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041573; x=1723646373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF7GVsamqUptJkU2gJsmYYeaq0bMeaFAbotmm0oMB2I=;
        b=eU6tLwfQkYLfCQyhIZ4HLuo45ePV6wwqcBuVtfx5PcZpknqphdb7FhB9httIYPf19d
         mIXpytFRfVpYjXGSXhusbr5tjU6Xbg2mB9oKxGiaJu1dLmRugca7RvO0JGZMmy+2FMOu
         DVTsUfJ7ZMCeFQN1q+Ic36sEnG24ZPv1vo+Mv0iGgqY8xbWkHAXosVsvJHDg/Y1ZuIv3
         9qHXsI6MYrhZpQdnyUI9a4Ge42M/ikS5koNwWpz/4vGL7SEUvG5G+RO1J9XU4hdkV/Fo
         Cia98H7kMkfOj/B4rZpg9s70wsfjK2ENm2Mn7NO7ytTFKR1jcPpvbBkxbutUVaLLchrP
         gYxA==
X-Gm-Message-State: AOJu0YwSSkEmt8ZuRtdK3KcjRnITT+KRlOMeraDO0TYThghRlZHmguux
	KAjL8xqnUH2Mx7JtNIw9d1xxWGX+V8rh/EFCiKFaRtlCYByIZjRDi0WQV4LVy0Va/thGPnORs1Z
	y+gd1Rpc65g==
X-Google-Smtp-Source: AGHT+IGZjcSEFFHc8gAyc+MxGkh5ALwM7EKisvXylP1dqOQgjdhJFnjvbXfvVU14q3/0qmnCLiu4AepSqnEP/g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:9168:b0:710:4d06:93b3 with SMTP
 id d2e1a72fcca58-7106d0735d4mr416051b3a.3.1723041573417; Wed, 07 Aug 2024
 07:39:33 -0700 (PDT)
Date: Wed,  7 Aug 2024 14:39:18 +0000
In-Reply-To: <20240807143922.919604-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240807143922.919604-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240807143922.919604-3-cmllamas@google.com>
Subject: [PATCH v2 2/3] lockdep: clarify size for LOCKDEP_*_BITS configs
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The LOCKDEP_*_BITS configs control the size of internal structures used
by lockdep. The size is calculated as a power of two of the configured
value (e.g. 16 => 64KB). Update these descriptions to more accurately
reflect this, as "Bitsize" can be misleading.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 lib/Kconfig.debug | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index baaaedfde0cb..e0614a415348 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1505,7 +1505,7 @@ config LOCKDEP_SMALL
 	bool
 
 config LOCKDEP_BITS
-	int "Bitsize for MAX_LOCKDEP_ENTRIES"
+	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 24
 	default 15
@@ -1513,7 +1513,7 @@ config LOCKDEP_BITS
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
 
 config LOCKDEP_CHAINS_BITS
-	int "Bitsize for MAX_LOCKDEP_CHAINS"
+	int "Size for MAX_LOCKDEP_CHAINS (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 21
 	default 16
@@ -1521,7 +1521,7 @@ config LOCKDEP_CHAINS_BITS
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
 
 config LOCKDEP_STACK_TRACE_BITS
-	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
+	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 26
 	default 19
@@ -1529,7 +1529,7 @@ config LOCKDEP_STACK_TRACE_BITS
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
 
 config LOCKDEP_STACK_TRACE_HASH_BITS
-	int "Bitsize for STACK_TRACE_HASH_SIZE"
+	int "Size for STACK_TRACE_HASH_SIZE (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 26
 	default 14
@@ -1537,7 +1537,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
 	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
 
 config LOCKDEP_CIRCULAR_QUEUE_BITS
-	int "Bitsize for elements in circular_queue struct"
+	int "Size for elements in circular_queue struct (as Nth power of 2)"
 	depends on LOCKDEP
 	range 10 26
 	default 12
-- 
2.46.0.rc2.264.g509ed76dc8-goog


