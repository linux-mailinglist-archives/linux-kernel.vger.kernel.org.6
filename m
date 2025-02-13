Return-Path: <linux-kernel+bounces-514027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE84A3517D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662A216E188
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E18D274242;
	Thu, 13 Feb 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+bvfVUv"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026127128A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486834; cv=none; b=tI0egMWLHqI9OiDNs1MsUq0lnMAlsxJRn/bXPZh6jBb8jGsX666VkjZ9VYr3PdupW5CQ/sBpCaMkj1mrg8xaaqu8q3FSgyPMevVNdYmushmwya4m3jhKxKw/mDKygdUxogimLJJ/0iNNvU3oX3UGquyR9UV3LdUHN/0EAwQD72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486834; c=relaxed/simple;
	bh=8Njh8fZrPvZrNtKwBc51MD6ktP5kHik3Z5tjuwiDAWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YG/7n88vyzM76JjS2BomEsnieAwspC22l2D5Eoueflj7EbnlcdnQ8/s6m0xEtZZiK7I+weWwOXXRltuQ+nHV07B0MQ4XXcVr/TMFZ8KrTd7un4b3o6I3vxafn4H3yhcyk9TGxalBwfXVbDmvCQ+tkfvfNa2xUmLq/ubW4p0YV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+bvfVUv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f6cd48c56so21400415ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486832; x=1740091632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f967rAL9Gs1nAaqEwqbs3/KxJ+f7SIc9ekPyYd69/e8=;
        b=s+bvfVUvgOWtFpnu14BOSzEiPG0kIYIzScBGcOYe3kTw+dg7dsui4vqngb3xVAohOO
         Q9cwgcFFFR5x1iEpV/1CpTwDhE/I15zNDeWD8xsl3jFLHjbZRpZX4mkE817bJRVCkoEV
         mjr1tNkGkVge5EkfDz8z5KrCxbDDcDf2jQktO5lo5KIduWOfkbRI0/1lRhrSSOiNos8g
         /xlAjcwYiPRZDyp5jp0gx1rKZIlgGCrC/Vj16Eo6g+e6wbhNzTMIGanj7H4lLMbZXuuc
         efBKGKIfVntD69uf699/Hvw+VdxczLIa1x+wSYVT1UkbGxCIdPB3+byWCbom6AApotQI
         0FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486832; x=1740091632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f967rAL9Gs1nAaqEwqbs3/KxJ+f7SIc9ekPyYd69/e8=;
        b=uIZlSwuQT7lNwnk2pFO6NKRTMk9uJM6bUleAhqzaevqNGY2epHqdP7uyu/i63ZQOVM
         BfQtwVxpbxkST7a0HbBAOc+2w1TUhuKNHVCtotVg67ulsuxR985dQUl0KW9VZg7cUcYn
         TLjinluyoQ+q7mWbIiR1uV82OSLhVYGQPDtJ0R46GmHnadAdi4Ma6cI0lo6kLVG21b/J
         Ls8nvyHDMDvkGz37HdqbjVUD/CId/RvzhwzFVqL3fyDxT0BSmUFWbZOL8YvjtgofbxgU
         EuFXIg5H8QwmARR67jbd/GYGvJ1Af46yI/AVmchE65APH9ClVf+Yf1YnOp7tRZfxiGUs
         aKig==
X-Forwarded-Encrypted: i=1; AJvYcCWX3Nz8AThVpgndwc10WavA/YkhxTOw1NfSJVhUiFNqICQviAX5msD6v9ssVNDPQNFfan7Ez5Shi1pUBGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQlL2gAdUNHowBJZbZ75LXBjVp3GWtc8N/aqwkI997HT/FVJg
	TF+Xv9NZqewqVi/d7Ix1NkUKZGufUqYGT2LJLQWemLDQG0BKMhDsQ+wy5NBN0KUbjisnkGBRAiz
	59w==
X-Google-Smtp-Source: AGHT+IGSWz7GU9dfI59mEnX3KWjK84PY7XxuIsdno4nvi5XjdZpP5t6KXvINYXrYmtHx9RdlsY/1nSR1Ez8=
X-Received: from pgy35.prod.google.com ([2002:a63:1863:0:b0:ad5:5841:9f23])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a94:b0:1ee:6b2f:1a2a
 with SMTP id adf61e73a8af0-1ee6b2f1d52mr9549965637.15.1739486832181; Thu, 13
 Feb 2025 14:47:12 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:43 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-7-surenb@google.com>
Subject: [PATCH v10 06/18] types: move struct rcuwait into types.h
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Move rcuwait struct definition into types.h so that rcuwait can be used
without including rcuwait.h which includes other headers. Without this
change mm_types.h can't use rcuwait due to a the following circular
dependency:

mm_types.h -> rcuwait.h -> signal.h -> mm_types.h

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Changes since v9 [1]:
- Add Acked-by, per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20250111042604.3230628-7-surenb@google.com/

 include/linux/rcuwait.h | 13 +------------
 include/linux/types.h   | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 27343424225c..9ad134a04b41 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -4,18 +4,7 @@
 
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
-
-/*
- * rcuwait provides a way of blocking and waking up a single
- * task in an rcu-safe manner.
- *
- * The only time @task is non-nil is when a user is blocked (or
- * checking if it needs to) on a condition, and reset as soon as we
- * know that the condition has succeeded and are awoken.
- */
-struct rcuwait {
-	struct task_struct __rcu *task;
-};
+#include <linux/types.h>
 
 #define __RCUWAIT_INITIALIZER(name)		\
 	{ .task = NULL, }
diff --git a/include/linux/types.h b/include/linux/types.h
index 1c509ce8f7f6..a3d2182c2686 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -248,5 +248,17 @@ typedef void (*swap_func_t)(void *a, void *b, int size);
 typedef int (*cmp_r_func_t)(const void *a, const void *b, const void *priv);
 typedef int (*cmp_func_t)(const void *a, const void *b);
 
+/*
+ * rcuwait provides a way of blocking and waking up a single
+ * task in an rcu-safe manner.
+ *
+ * The only time @task is non-nil is when a user is blocked (or
+ * checking if it needs to) on a condition, and reset as soon as we
+ * know that the condition has succeeded and are awoken.
+ */
+struct rcuwait {
+	struct task_struct __rcu *task;
+};
+
 #endif /*  __ASSEMBLY__ */
 #endif /* _LINUX_TYPES_H */
-- 
2.48.1.601.g30ceb7b040-goog


