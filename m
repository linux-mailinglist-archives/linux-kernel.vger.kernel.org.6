Return-Path: <linux-kernel+bounces-572062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC669A6C60E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D133BD7D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A27232384;
	Fri, 21 Mar 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCZrenZD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527C1F03CF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597177; cv=none; b=W4mC+sFs+7cjFvh0g7EvWBq4X/sNKSbzJ4cv2sHMUrywTDpIY2LUyn/RPjg8DrQwKjHxPHy2sqqtDwx1ILYYq2Gk7d25vEH5womVhwcG9vY+8flKZP/sSYDnW6QExCOAguV/QGfR3dA7CISUiEpYplrEfLPAL1RThxdGF136bZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597177; c=relaxed/simple;
	bh=czu60cFDRiNDyr+bONepwvYfmABNw2z5ZOxwBZ81kJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXMuJITWWv9Gnd9mNa15NgWDppYq24e3Aw8A8eP3RuTTzYu/r73xqFM4Udv79/KNytJFCrIODvgKt7vSF7jVXLLU4IhbvNXUyXv6i0dWf70on0nbegiS1B2iwoxxqZgIhmu6wMB+gllWwVXgLNrU0afom2zb6K8/2KOOubjy3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCZrenZD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso26264825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742597173; x=1743201973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SFb1UWZHNq6ESZ+rORIrqyA0Y2J+NdSM2LpSrRm5nA=;
        b=CCZrenZDme/wPuW1tGkv+xyqUs+fvIDV9GV5sLxDHuon8y5+qw5GsvLrBmSfYS9Xbv
         oOaQeTB0AMV6m7YGDiGqqRBZTZNEr5r08mmCxzYlaPBz/nnZuA2s+jx5VlQRzD+XJ2x3
         9jU1CooJwNvuv9YYYW68x55M1u+G31Eumgo4uGCvGV8Z+6w0T+RPoYpxLvfJgtcmVyyv
         HBi1ZN++Mc/5+xrm9O+SY9QMF7wUC4VEfi+80FAeWt41ijNNxpar/UTNpQ6dQ1sOo9Af
         ctLCYBunVExgX+3i3JgJ1HVkIFnNthuX2Wwn7jMmwPmNjM6lm7vFAiz4l6H2HqsodA9v
         /HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742597173; x=1743201973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SFb1UWZHNq6ESZ+rORIrqyA0Y2J+NdSM2LpSrRm5nA=;
        b=ou1Jcm5lQAzWtDVwBb73s+GZAaBD21cy599Uqa3awPvhPH060/waMSqiWbz3uJwjZ9
         OnF+WxeuGm9SEqhyeLztBz0wYKYF/7nZqsVnVoQchgVWTLm4l0Ozw9GGIsaefiAUnOsS
         aLaqLQG8EYoAeimE+p2aktgLIDc6C85NoJAdMCKAnGbeZadE6Td/cgNY2oSC4RxwnDBh
         UdowqpJ6pEdt8FSEF0qZ75vr4OwvSIp9h1kxcIZ2DJT2rZYZjkzWHhvPRiBi+Y2ZfSa/
         LhkGndjtCvh0EOgPtZRaBq+gYci3tUuvTVZpJ1mhgxDIJeazaqin3s8LVHC/JV+ldEui
         pWsQ==
X-Gm-Message-State: AOJu0YxYe5mftNJj/kdjT9Z8soaEilOxnHtfW2prRtVFu2FQAULyufWN
	p6ks7W6dGu2/+tol4UEt64tpLrQtSVHhCt9MLHZttNJqx2i01Dp5Z09VuA==
X-Gm-Gg: ASbGncvsgS+H12MqA0reSSTPXtZr4UmIuxU2/gHlxZ+f61fNOQci9zrGqvfymodFIza
	Cu4v2nxMYEtDXNeg02iVyqr4sxolpgqQlKamIKOmXvhwl5Ty3csN6pMeS1vU3XieiLWBhwf81yM
	jFsYb762aB4/m9CXgyfrNSyCRq/n/pjol8i3F/BESvqQZtznAZ+V6DjpNTi1D8QhLL8IBUI5N0p
	KyMcEYUYesBPXmWTnUDb9TBUxBHMlEAxV8flop0S71r4TdhRw0FViaugYO/n62ha1YzYInn3odk
	QXQ3TqM4hXWRApLbWd7M5P+PHqqupa8c8cSU6DkpvtZ1CG3bwvXlx5WxNg23FwcZot/THeHna1U
	/6xsC+nalrpy3nq2Euzujtcfl6w==
X-Google-Smtp-Source: AGHT+IGKyNrpOlekTzBlxKIRCQ2WgvhzjoEecxPjJYME40UxhBjKkInj5NLRBj5EemBwG0ZjPMDSQg==
X-Received: by 2002:a05:600c:c8e:b0:43a:b0ac:b10c with SMTP id 5b1f17b1804b1-43d50a33b40mr41753705e9.26.1742597173156;
        Fri, 21 Mar 2025 15:46:13 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm3609957f8f.38.2025.03.21.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 15:46:12 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH next 1/3] iov: Remove access_ok() from import_iovec()
Date: Fri, 21 Mar 2025 22:45:55 +0000
Message-Id: <20250321224557.3847-2-david.laight.linux@gmail.com>
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

There is no point checking the validity of the user address when reading
the iovec[] from usespace.
It is checked again before the user copy itself.
Added in 09fc68dc66f75 (iov_iter: saner checks on copyin/copyout)

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/iov_iter.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65f550cb5081..623ec43e049a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1471,13 +1471,6 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 	for (seg = 0; seg < nr_segs; seg++) {
 		ssize_t len = (ssize_t)iov[seg].iov_len;
 
-		if (!access_ok(iov[seg].iov_base, len)) {
-			if (iov != *iovp)
-				kfree(iov);
-			*iovp = NULL;
-			return -EFAULT;
-		}
-
 		if (len > MAX_RW_COUNT - total_len) {
 			len = MAX_RW_COUNT - total_len;
 			iov[seg].iov_len = len;
@@ -1528,8 +1521,6 @@ int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
 {
 	if (len > MAX_RW_COUNT)
 		len = MAX_RW_COUNT;
-	if (unlikely(!access_ok(buf, len)))
-		return -EFAULT;
 
 	iov_iter_ubuf(i, rw, buf, len);
 	return 0;
-- 
2.39.5


