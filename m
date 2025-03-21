Return-Path: <linux-kernel+bounces-572064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE221A6C610
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899B9482F05
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251F1233721;
	Fri, 21 Mar 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqYlo8MU"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAAC230BE5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597179; cv=none; b=JwWzvbexivqgLBOmJ5n+wvTm8s8aIgWx1Ce3ZpL+UpS2FGnBsjemA99BrnAy6zWnOWN0n5jIl2UkCOnYtdV2safOGXP9nQGRnEAhniF0JZPSuXTE96Ichcqe4WGXv1ZvI36j5rzt4YL4k7Uouf34P4FNiUbtoYBwggWlXfzorYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597179; c=relaxed/simple;
	bh=ExwGZv6Rl7okLpEEZnQe7KMbNl4fOCrlEd6OalweAtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8QQcpxcPUl+aOn5XJ6HML0bTocvUdUDDknH82cS9lrYkdgBoodvA0UKrc8BAK74G/U3iH4LvSsGfORMpppT6fhwKuU8fM0xbxqYZyjFakqY6fFfJfSaqLie1hsm84mNhqfEKy6KNLJW703FZ0yLxd4Y4hZoYM2mJyXFsw/dJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqYlo8MU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso16264025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742597175; x=1743201975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKH9/VHiO9MRo9eLniQYLv14RerMz6rTdd2gdMpmmOg=;
        b=aqYlo8MUYYSZAAwe+MIoXUjyu5dW55DH2B0znoRqnW7M529J0QOqxIwB1mVDDNk5TV
         mJFl/lzCEwypeJX8V1cdnGXZhcgpFGoSTtB+6VfJvSFVLUXS6GOzyao60pXylwrkYSwF
         OGotARmITeTpOoRZV10J+prRIGx8zFF1vGo5BfjRho/KoC5mocLF0D7Dq1t4jUhS5nOm
         2KfiPftSUSNl7q5ShKb39wd1w3ylDtPHyBKKUgcxaAyRKt1QeI6bce7902qnBqjs2KVs
         gff3CAWmNNE5owb6qUAhjcYzYzdiulYoLQu9MgQzGrUBnCukTDSvD6SkpJZCYe9LBcnd
         dJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742597175; x=1743201975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKH9/VHiO9MRo9eLniQYLv14RerMz6rTdd2gdMpmmOg=;
        b=Nh8YP4l7yfYp+isOAZJz0pcTDywCoNRG5sJo75Dt3bbZYymUUhq2tTIRJ/yQ4QQHfb
         PZRApOjfeqy33f/0B9n0PEqgW0C74po0Ptp5VvyMWHygK7BgCCkApwgs/DaQdnOnHvXa
         zc+f9fbvWVFO054oCM74W084y74/QDfZIXKVEL1Tw3sf7z8AoZLQuH+lEdR5iFWPPcF/
         FrZgOg7EahjCHu14fzgEXAxuTh1ZqLGEkbCawu+LtOPcalY1lchXv+v7yO2pI2HYA9WC
         7y2I3pS18WXg+wN6554Yns/OmgX3HEwmYskxgHFrguK4v8iqSkbquHWz3WJxv2UG02GE
         sYuA==
X-Gm-Message-State: AOJu0Yy66S41JCuMwEhlnlZSavzWYCpSUcuSooHVdALx+BXSsVkzvvCe
	c4pYS5WswGX2ycaCSciQ5VDcx4U1fFaM1a+xELVHWTmRlHpHogG3vicYtg==
X-Gm-Gg: ASbGncsl6VdCL71/uYvS81pWSPIL+c4tR4G+OzjFSn17PqgFwjSgmoLWYKc1GQpZVDi
	M/iIdskeW8bTnYvZurDKOX8CVmRquBhrSyo9hBNfz+DD0i9JI0Ve4ax2IxSgY3DTLQ2Ta6TxBie
	lf8Fk5EJtToETxjcOIwnnO5vV9SIsqEy8DFvUsONoEMQu0ebbh0ec+h55jnQcjIIiBpdOjNYGYf
	FNiqv+xuMDbaAy6fNS8sqqvVBg5okULK7lyOiV5JN/lQ5WORbEd2kG2uxRnZwj/rXzZi53zO6B6
	tlzJXmM0DdvMD/x7s2qbFHGRoU408uX/xO68IRdfQdYfYDt62FRFGGfkal2M/k0fUXVHba18epB
	W06OEx2QytbiJEYrQ2h59yFyvkQ==
X-Google-Smtp-Source: AGHT+IF2FtX0NQn/+Uua9MzkXkpbZ/mS3JCNF+UjhkRJnbOJlEhr7LCQrvYl31jmmpuK6vZQGfeNaA==
X-Received: by 2002:a05:600c:c0e:b0:43d:1bf6:15e1 with SMTP id 5b1f17b1804b1-43d542bb8b3mr29143975e9.1.1742597174939;
        Fri, 21 Mar 2025 15:46:14 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm3609957f8f.38.2025.03.21.15.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 15:46:14 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH next 3/3] iov: Optimise __import_iovec_ubuf()
Date: Fri, 21 Mar 2025 22:45:57 +0000
Message-Id: <20250321224557.3847-4-david.laight.linux@gmail.com>
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

__import_iovec_ubuf() is used to read a single entry iovec[] into
the simpler 'ubuf' format.
Inline simplified bodies of copy_iovec_from_user() and
copy_compat_iovec_from_user() to avoid the overhead of the loop.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
I've left in the assignments to iov->iov_base and iov->iov_len
but they may not be needed.

 lib/iov_iter.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 796ef647bff2..5eff3a307b71 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1437,22 +1437,48 @@ static ssize_t __import_iovec_ubuf(int type, const struct iovec __user *uvec,
 				   struct iovec **iovp, struct iov_iter *i,
 				   bool compat)
 {
+	const struct compat_iovec __user *compat_uvec;
 	struct iovec *iov = *iovp;
-	ssize_t ret;
+	void __user *buf;
+	ssize_t len;
+	int ret;
 
 	*iovp = NULL;
 
-	if (compat)
-		ret = copy_compat_iovec_from_user(iov, uvec, 1);
-	else
-		ret = copy_iovec_from_user(iov, uvec, 1);
-	if (unlikely(ret))
-		return ret;
+	if (can_do_masked_user_access())
+		uvec = masked_user_access_begin(uvec);
+	else if (!user_access_begin(uvec, compat ? sizeof (*compat_uvec) : sizeof (*uvec)))
+		return -EFAULT;
+
+	if (unlikely(compat)) {
+		compat_uvec = (const void __user *)uvec;
+		compat_uptr_t compat_buf;
+		compat_ssize_t compat_len;
+
+		unsafe_get_user(compat_buf, &compat_uvec->iov_base, uaccess_end_efault);
+		unsafe_get_user(compat_len, &compat_uvec->iov_len, uaccess_end_efault);
+		buf = compat_ptr(compat_buf);
+		len = compat_len;
+	} else {
+		unsafe_get_user(buf, &uvec->iov_base, uaccess_end_efault);
+		unsafe_get_user(len, &uvec->iov_len, uaccess_end_efault);
+	}
+	user_access_end();
 
-	ret = import_ubuf(type, iov->iov_base, iov->iov_len, i);
+	/* check for size_t not fitting in ssize_t .. */
+	if (unlikely(len < 0))
+		return -EINVAL;
+
+	iov->iov_base = buf;
+	iov->iov_len = len;
+	ret = import_ubuf(type, buf, len, i);
 	if (unlikely(ret))
 		return ret;
-	return i->count;
+	return len;
+
+uaccess_end_efault:
+	user_access_end();
+	return -EFAULT;
 }
 
 ssize_t __import_iovec(int type, const struct iovec __user *uvec,
-- 
2.39.5


