Return-Path: <linux-kernel+bounces-572063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ACBA6C60F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2864A482E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884EF233705;
	Fri, 21 Mar 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juzFt8oQ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E99210F53
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597178; cv=none; b=HFmhQmmE/WBUutrwaZJc6purqCdn1fDihgOUWxXvvnv1R7Ip+vr4apAkdGXfOyFssvPy/J6K2lHjifkIXUpzwOkK7T0EDawfxnWyfBLYOSZhgGeKqHfanpvjXqOatQ8OsPFTq7jxMwKniLf0zdv5XJvna1bPZC39bD+7NQ0VYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597178; c=relaxed/simple;
	bh=WgokdCBpH1SKYYWqDCWkpVV7Ru3JbBRFVHwjLClVCWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DRkN0Qph+Y5UvnA2VcuYEh1AOpaHyH9aaFqcIQ2SuJKm8g+Xy2jLFQvLZ6Ele24/NrlCCHZlVUf+1AFmZpzy9vbvPEZsgKhaOZEEFlPzG6+7LPrLBakk12FnXq6i77SWXKtr4+NN5DYROXkqrcL5aFBn2brEccVBudM6gAW1zIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juzFt8oQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912baafc58so1998090f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742597174; x=1743201974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQmTrN/MYIaz61wV3rB8q72p/Trt8rPHuowrU2WUSuc=;
        b=juzFt8oQ30WFLa2IcJ+phfrPt2LdsNiedj21Kf6tLpHLjSvyLsTRR/FXwp2mvMkNDA
         Iqq6W7U7FHk5v7epvKiP2hzrjBEnkclUwT6TXdy74+CSHyyIeNlq+2QzH58lBfJV6lNl
         2l9jyR815jZngwpXuPbIgxqro1XiHid5QOFMRRMDSUU5AvOyU00o5fbz4iQXGJ6BKEh7
         F5frNFd3M2tyTnjHTP6f3aEppUaTigv6IPw8g6QRTyvuznOsavf2Uzl+8UKF8Y/g6wC4
         RS2w6ixut6/X9+raShk/+sGeKzrDRvycTg8MTU6MBY0sweY9EGsFoMgxrveVCs0GkQHC
         gW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742597174; x=1743201974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQmTrN/MYIaz61wV3rB8q72p/Trt8rPHuowrU2WUSuc=;
        b=HfhgM6Gk6H5nlbjWvOTVwNVTFRqIdIbHStj7bdceVgzuWGTWzTMzkQDEhOs9VA55rh
         auBCkMSuP3eOub5tbMklahpeF83ubu9OEVJ7WDfO1rdBuyag57OMsKJG3FNzD83H+a92
         b8Llb3kXQuc/1eE04XqnRktuWRQ2NAle7jMV/EC2topgj3/oT1BtNot6EDiBLF6h91dB
         YSqpE9qVJtdiyQLLuyb1xxFjphReY79O3Q0+WLV3h+hLiFOmS7yGEubAFJvuEzNxI0nD
         bdeL9HBAbFaDtc7ySgrHnY8wH575+xTAgSlXeRg/w6+OlwYondpPbskIQP+K49aEaR8y
         kNgw==
X-Gm-Message-State: AOJu0YzW+PGDU7Or8mFe6YK0t9dzh+6TrP2WtJXjYrVh7uMxy0v7NShy
	5VUnSoWoVX3Jn7VJDrYcpzV8pSwTgWqVFRSqiAcFswq0KT1UaQc7i1eAOA==
X-Gm-Gg: ASbGncuc/jbHTeIIoqSR31wdgPGzV9O+lTCNi0atBI14Lo/U3a3YDOWbkiTo+LgChoR
	uL6EzQvgeWGh3Wt/exWrbBHjdep+ZoKF2FsbVfSjJHSzTj2ojom8AnbpHxX7QEWWPtrSm0mUJyl
	CVBjsnKUqUEcUO0EpQcdrjW1Pj3cPqSuWIlKKJ+xXvdEzi5PZ9RzPa1157UKC3kfe6fQSWj4J3w
	XAlYy8uyQHXMhHV/pmqZ0ugJqlt7kazN1UHBseFaFs+Q118lPrbOhwZD5ZE5zyZyiAK32v6xdPQ
	M3I17csQ4ej5MfEuCQUC/FmxQRUTXJzmIMrvQLje4N0yDx7DmJX8klXZDRUO9HSXfUCifPCJWCm
	klsDbrmVkec/aPZ9bdmLFwlSOEA==
X-Google-Smtp-Source: AGHT+IHAmldxguLvSK3rp2YlKW4ClhOc3VIriyBs2Bw5LbVwUxXNvn6V3oJbajqiNzBalAsRyrE7Ag==
X-Received: by 2002:a5d:5885:0:b0:390:f4f9:8396 with SMTP id ffacd0b85a97d-3997f912d09mr5616659f8f.28.1742597174212;
        Fri, 21 Mar 2025 15:46:14 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm3609957f8f.38.2025.03.21.15.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 15:46:13 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH next 2/3] iov: Use masked user accesses
Date: Fri, 21 Mar 2025 22:45:56 +0000
Message-Id: <20250321224557.3847-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250321224557.3847-1-david.laight.linux@gmail.com>
References: <20250321224557.3847-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check can_do_masked_user_access() and use mask_user_address() or
  masked_user_access_begin() to optimise user access checks.

Read iov->buf before iov->len to ensure accessing the 'masked'
address fails when kernel addresses are converted to ~0ul.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/iov_iter.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 623ec43e049a..796ef647bff2 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -19,12 +19,15 @@ size_t copy_to_user_iter(void __user *iter_to, size_t progress,
 {
 	if (should_fail_usercopy())
 		return len;
-	if (access_ok(iter_to, len)) {
-		from += progress;
-		instrument_copy_to_user(iter_to, from, len);
-		len = raw_copy_to_user(iter_to, from, len);
-	}
-	return len;
+
+	if (can_do_masked_user_access())
+		iter_to = mask_user_address(iter_to);
+	else if (!access_ok(iter_to, len))
+		return len;
+
+	from += progress;
+	instrument_copy_to_user(iter_to, from, len);
+	return raw_copy_to_user(iter_to, from, len);
 }
 
 static __always_inline
@@ -49,12 +52,17 @@ size_t copy_from_user_iter(void __user *iter_from, size_t progress,
 
 	if (should_fail_usercopy())
 		return len;
-	if (access_ok(iter_from, len)) {
-		to += progress;
-		instrument_copy_from_user_before(to, iter_from, len);
-		res = raw_copy_from_user(to, iter_from, len);
-		instrument_copy_from_user_after(to, iter_from, len, res);
-	}
+
+	if (can_do_masked_user_access())
+		iter_from = mask_user_address(iter_from);
+	else if (!access_ok(iter_from, len))
+		return len;
+
+	to += progress;
+	instrument_copy_from_user_before(to, iter_from, len);
+	res = raw_copy_from_user(to, iter_from, len);
+	instrument_copy_from_user_after(to, iter_from, len, res);
+
 	return res;
 }
 
@@ -1326,15 +1334,17 @@ static __noclone int copy_compat_iovec_from_user(struct iovec *iov,
 	int ret = -EFAULT;
 	u32 i;
 
-	if (!user_access_begin(uiov, nr_segs * sizeof(*uiov)))
+	if (can_do_masked_user_access())
+		uiov = masked_user_access_begin(uiov);
+	else if (!user_access_begin(uiov, nr_segs * sizeof(*uiov)))
 		return -EFAULT;
 
 	for (i = 0; i < nr_segs; i++) {
 		compat_uptr_t buf;
 		compat_ssize_t len;
 
-		unsafe_get_user(len, &uiov[i].iov_len, uaccess_end);
 		unsafe_get_user(buf, &uiov[i].iov_base, uaccess_end);
+		unsafe_get_user(len, &uiov[i].iov_len, uaccess_end);
 
 		/* check for compat_size_t not fitting in compat_ssize_t .. */
 		if (len < 0) {
@@ -1356,15 +1366,17 @@ static __noclone int copy_iovec_from_user(struct iovec *iov,
 {
 	int ret = -EFAULT;
 
-	if (!user_access_begin(uiov, nr_segs * sizeof(*uiov)))
+	if (can_do_masked_user_access())
+		uiov = masked_user_access_begin(uiov);
+	else if (!user_access_begin(uiov, nr_segs * sizeof(*uiov)))
 		return -EFAULT;
 
 	do {
 		void __user *buf;
 		ssize_t len;
 
-		unsafe_get_user(len, &uiov->iov_len, uaccess_end);
 		unsafe_get_user(buf, &uiov->iov_base, uaccess_end);
+		unsafe_get_user(len, &uiov->iov_len, uaccess_end);
 
 		/* check for size_t not fitting in ssize_t .. */
 		if (unlikely(len < 0)) {
-- 
2.39.5


