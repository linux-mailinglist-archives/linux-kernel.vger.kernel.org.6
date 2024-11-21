Return-Path: <linux-kernel+bounces-417214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F49D50B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCDFB25F08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68019D8BC;
	Thu, 21 Nov 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLI+ZIdo"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1210A3E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206511; cv=none; b=X06+2RS4osw2GX0GCtkWu4OBjEdcgyfMKtqDyUtZr0KaD9GHJA6smp2B9Yqe3p1wiD9R9+TcK90QJ/r2Ng40f13ItQT1SlU/lxMLuHhVbXZKh862l6iWNHLwKL0mVfzbmYwoZwdACgxUh3ruwkMxN+suR6Fg+Y6b0lvrUPJ6dYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206511; c=relaxed/simple;
	bh=D81l3HNYy8bAFwvcJs400vi0Wt/K5OiIyV3ZyRCm3xI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hjIUsjWUAPosr5ucQF/VcZsn1xcUwVQPj4zxWvdrSTkXTriAJP1aFC3eWHLuL4FyDQFbOPtFF2PLPJswnI5qvtPuAP9PlibvshNcTOWuYvwl/JMCWcGVWw8g+nDF0cMseG6nzFM7N2pnI/zHPOmkchVgzEEipdvjdg7VH7N/gnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLI+ZIdo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3890bc5ec6so1935805276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732206509; x=1732811309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DzshYmtDI4/275THI8fMkxHrRvuypnNNcYPdRzlGWBM=;
        b=eLI+ZIdoODJxkAi6Co4RM+mcY76yuJc9BYOD/ZCZgdYr6GLYn4EyWwf/NrZCZII6m3
         6wB+Ob8/NYsGnZyWJ+tKLr7hbiSy6RFLQ+bmbhYW2K73rmgHud5iKYwWTzLLADO4awl9
         NYC6wlZLePySVCpiW52VFw/7zkAtKpqsDWLpLkH2ol7Ec/SegQoEE2NhTGAoyspGCd0R
         a0nkSAimqLZOVzXur7WI/veVipEmay/ohj99PJCVGgDy/8ee1P8EnWZvnmE8PCGwU8TO
         BLblspcKQ8moauPOzKl8pwpWu57tJRLbwku1LBdXJr29fMd/LSNfB/IXf8HS2h51LJEk
         Kuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732206509; x=1732811309;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzshYmtDI4/275THI8fMkxHrRvuypnNNcYPdRzlGWBM=;
        b=PxZsaO7ZQLvq7xDonWDRSqcIUMRQIdFBK02OBMGNs7qxY3whZHwqKXDBAiGmjdfZzn
         SHVlfA/DWaHiXxZhWdxbHh1tG8Az6bg0IxD0qVUd/Tqcvz1h7oBwQcsQa24/Dn/vIrG9
         Qlq3W1Kzevg8RBBEbQuf3oLD8T9opQHNXEc8Es+GIHZiwwuxcVuaY9W7VAG5XYPFjYw7
         T32586sufG/tjUXxbyEGMUeyBSswEg6+I/iaFC18ni+zR5PwXdeRdgdEDe4wRaDZosFv
         3XQLLAwkOwOQSSVt3yPjbwHNw+mfFqV3BEYn5JNnZvi225DSTUw5WMQYOuwJSFqNc9Hs
         Qb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6gcFNKnaS5OaH8pYsrw1De3WQSQvX4QHJtsx1sZBBoQP1Y7fifgMuTOT9SYqUEZgjhjI3NwtCJB5nvD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aPauZqqp6Aq4exBSqaJiSzA0lz4767h8MOJ64wovD5gK8/HU
	umxnv7zidsT3esSBtqZ5lPFYk9Ktj4CWv1U6wzK2CAzXlDE1s96q5EEbr7mdI4GrUL1FltBlSJH
	e8g==
X-Google-Smtp-Source: AGHT+IE33qxVBVPbXuIrP36mPBIu7ro+9/sXMzayf2Pcl9WA+DZzBVqH09gzO70e2f7gvoUxthb+t2JPckY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:ab6:ec44:b69c:2388])
 (user=surenb job=sendgmr) by 2002:a05:6902:1b04:b0:e38:840d:3a9e with SMTP id
 3f1490d57ef6-e38cb60a27fmr47366276.7.1732206509139; Thu, 21 Nov 2024 08:28:29
 -0800 (PST)
Date: Thu, 21 Nov 2024 08:28:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241121162826.987947-1-surenb@google.com>
Subject: [PATCH v2 1/3] seqlock: add raw_seqcount_try_begin
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, andrii@kernel.org, jannh@google.com, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Add raw_seqcount_try_begin() to opens a read critical section of the given
seqcount_t if the counter is even. This enables eliding the critical
section entirely if the counter is odd, instead of doing the speculation
knowing it will fail.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Applies over Linus' ToT

 include/linux/seqlock.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5298765d6ca4..22c2c48b4265 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -318,6 +318,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 	__seq;								\
 })
 
+/**
+ * raw_seqcount_try_begin() - begin a seqcount_t read critical section
+ *                            w/o lockdep and w/o counter stabilization
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Similar to raw_seqcount_begin(), except it enables eliding the critical
+ * section entirely if odd, instead of doing the speculation knowing it will
+ * fail.
+ *
+ * Useful when counter stabilization is more or less equivalent to taking
+ * the lock and there is a slowpath that does that.
+ *
+ * If true, start will be set to the (even) sequence count read.
+ *
+ * Return: true when a read critical section is started.
+ */
+#define raw_seqcount_try_begin(s, start)				\
+({									\
+	start = raw_read_seqcount(s);					\
+	!(start & 1);							\
+})
+
 /**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
  *                        lockdep and w/o counter stabilization

base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
-- 
2.47.0.338.g60cca15819-goog


