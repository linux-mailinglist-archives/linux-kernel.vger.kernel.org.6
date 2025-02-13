Return-Path: <linux-kernel+bounces-514032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E16A35189
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E70218912DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40A927FE7D;
	Thu, 13 Feb 2025 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="is4xf5wa"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A921F274274
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486844; cv=none; b=W2l9rUx0R8QTsvFNPbESIwdE9Et2Qo/FDu+xY7z+p6h5XlbDpY/N+zoQi/w3P+LK1EKmlrwCqyopIvBQsxSvSvmxb/RVeq+Ly3lEt1wvWbTc6qHkvjccqYcWrnLz8xoHfXBgw/w7ir3SNtYpbFmyeisHJuIww2MY0lAgQzxIZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486844; c=relaxed/simple;
	bh=WpaO6E6d4lQ17I42nTsw4iPOWxgreoNygD4rGF1BfSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F3vG+FZIar0PSR4f3Ov8ebHQ1MMfH8DwrA1Pf47wVjbE1pxNwYzdii9ShXEw9U9NxYHy3vzlhba2JkLH9XWP3L5pMXXymNwVVVEqTJdVF5LTGPpCi9I89WPyUaD9QS9Hh7uaIeK+kZGvkaqove4GVIinjWTeG1OnhfEVWHDLxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=is4xf5wa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d1c24b25so31170575ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486842; x=1740091642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2U39AcH2pHA/F+TfYeY5gc/lOd8HOvLuGlgxJNlsXk=;
        b=is4xf5wa8TO0pYycgep56N9Yc5hT4s+jgrvcfvJnE+iXCwxCagqapXniBmlASdKRbK
         lHSq4JbwytZjaquZ8SqtZeSsIQ1e4cHkmPARw7VMoxrT6m/oUV6/ghmJ2auOVdTDRjF/
         UhntJLKxP9+AhRDlFXTXXH57UA3Sg6bCaOzyrXEKaQFSSsOR3WbWfOB47M32YbkYdhd4
         NmS7zYynMF1UVcGJp0Qik7rb0Ii04Snpqz+UK3XjahifpuNS3ezZlVoni1y9MhxLsrqI
         CBFCEFWxSLYdtbPFzyQTf3IXCEgyQhzOmApwnDPBUmiQNVwQMRdqQ3EyDsWglVmW5afu
         2i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486842; x=1740091642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2U39AcH2pHA/F+TfYeY5gc/lOd8HOvLuGlgxJNlsXk=;
        b=R2QZh6TYcwMBYZcWS43VNgyIFcIyTykq+d6KnZUbU1hfl06Pz2GImPe0fsTAgQMgCa
         KIqTjHdnVN9e8wS39X8mOnpnNJUhW2iJZLqQ7qSmbaiAyZDthNynljDg1Jk9O6pRFOyp
         U8sAIBErKKpJkx8RlL/O08HI0yDu+I09yjXYIZcmzbXIgo5EaPl2ifspjJAJ4yU+/oYC
         YzBAY9AhAKgCA2MY91vBt0op+M5j9AlFpZhNFrDxEQPo9lo4iBdkw4i91jjOmWnqPO7U
         n03EXbhcmUge1rs2acxH16gpfapHQIyGtK5D5zl4OIycDbX1dIlV9ZCBv/0BvzzG1c/d
         5odQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD9z4Z5qwuOC8ZJdR+nZp/du2rSaHOjq/havgcyuhHk5xi14W9enY5j0EGTsIt1zSXvpQt6y1ngpSH0wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2BH9iw4umwTsm73nCIW8K2k9XbqSTKilFtoAVwYo+yukLVVu
	IfXgDGEZO0QtV46FaNGIAUrEphgSG3oV30eDMcZkE7XYZHV0Fw3uyedYr2zPVSBg8DCvz1MqrNP
	ppg==
X-Google-Smtp-Source: AGHT+IH/ab4L3c0kIEwgibMtPWiyLfRxDS8XonLWZO0QHAdpAq0IEkMMWm+kC4zlUCoEzXuh3expkwlJzJM=
X-Received: from pji4.prod.google.com ([2002:a17:90b:3fc4:b0:2ea:aa56:49c])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f706:b0:21f:7964:e989
 with SMTP id d9443c01a7336-220d2368b12mr72348425ad.52.1739486841935; Thu, 13
 Feb 2025 14:47:21 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:48 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-12-surenb@google.com>
Subject: [PATCH v10 11/18] refcount: introduce __refcount_{add|inc}_not_zero_limited_acquire
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
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce functions to increase refcount but with a top limit above which
they will fail to increase (the limit is inclusive). Setting the limit to
INT_MAX indicates no limit.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v9 [1]:
- Change refcount limit to be used with xxx_acquire functions

[1] https://lore.kernel.org/all/20250111042604.3230628-11-surenb@google.com/

 include/linux/refcount.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 4589d2e7bfea..80dc023ac2bf 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -213,13 +213,20 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
 }
 
 static inline __must_check __signed_wrap
-bool __refcount_add_not_zero_acquire(int i, refcount_t *r, int *oldp)
+bool __refcount_add_not_zero_limited_acquire(int i, refcount_t *r, int *oldp,
+					     int limit)
 {
 	int old = refcount_read(r);
 
 	do {
 		if (!old)
 			break;
+
+		if (i > limit - old) {
+			if (oldp)
+				*oldp = old;
+			return false;
+		}
 	} while (!atomic_try_cmpxchg_acquire(&r->refs, &old, old + i));
 
 	if (oldp)
@@ -231,6 +238,18 @@ bool __refcount_add_not_zero_acquire(int i, refcount_t *r, int *oldp)
 	return old;
 }
 
+static inline __must_check bool
+__refcount_inc_not_zero_limited_acquire(refcount_t *r, int *oldp, int limit)
+{
+	return __refcount_add_not_zero_limited_acquire(1, r, oldp, limit);
+}
+
+static inline __must_check __signed_wrap
+bool __refcount_add_not_zero_acquire(int i, refcount_t *r, int *oldp)
+{
+	return __refcount_add_not_zero_limited_acquire(i, r, oldp, INT_MAX);
+}
+
 /**
  * refcount_add_not_zero_acquire - add a value to a refcount with acquire ordering unless it is 0
  *
-- 
2.48.1.601.g30ceb7b040-goog


