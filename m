Return-Path: <linux-kernel+bounces-521128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F54A3B4B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7549A1794D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7321E1A14;
	Wed, 19 Feb 2025 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNOUB4fF"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F181AF0C8;
	Wed, 19 Feb 2025 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954208; cv=none; b=oniZ0KdHTnJipY8kk698wz2vkeTzW6O9QK9VWYqjZH0BfqDmf4GOyKa4PtPijSrxE2zzg0TpFjLrX3Wv4YxNURsVq24OYgaabGz1XIvYCXbxiMmW0yFqUMmkseblXwRIYPwUDyodVFDxKvAkUFx0D01l1xy6FLy04xQmTWdEdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954208; c=relaxed/simple;
	bh=vBWdb5FzpHt5ZjRBzV17DBH89UaJ076ckpjDBTFsSZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fvD2z1VZaq50Jh7Mw12VaZ3TPonfRIze8SO8oCLdQwoZxD6PudHuRwdstjR4/VsWXDDgEy/bG1M0GX6tPXWtmLAZFPeBqFvrKKXeVb8pixcJqpuZHe6O7UnSCIDo2omcLLXmD40fpCv/qp6nbJ9oXux0XSJS21LHtAzU2cBILhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNOUB4fF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so4016328f8f.2;
        Wed, 19 Feb 2025 00:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739954200; x=1740559000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YFUfS4MN212nAVnRhe58nyBjXY8HxrKGCZnWtI4ATrk=;
        b=JNOUB4fFIBPqhkfAtnkMmzYkwgaFH80VRzMisCVhb9L5iMhq+RRRBAMxCGMorelcMC
         fbsbS4r3EYPVltRqRgPWdTzc6tC8LZLXqngu0X2GpolpPxqnRQGE/CiD1zRtVt68XBDP
         vHiXVODOob/Q28BNbxv5/DYDqyv6AhKeUGjmNC7WJDcyx0AZe+9hVxLYwigbVJTJMTsz
         xtzjK0xt61pUufPZV06CrqnRpDMMdLLRiWk298CjdR2QEJ6bOi1ZeLDu2OAZiCRMDSJD
         RgPYhluyw8DhCVaOjuitAtXlMFKXnUvqQh+lV32TtSHT3FiVW0atJZ2onze2+t2qWw95
         7yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739954200; x=1740559000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFUfS4MN212nAVnRhe58nyBjXY8HxrKGCZnWtI4ATrk=;
        b=U6s1XCWa4F7PnYZ7avdavVfUYCAk50hDLJmqkC7wve6gcqwpn5EDqCfXjuf0MA2qCN
         AOP0D7geiXAQQHqj5SLghAbxAJnmQReyBRwjb8+7EUr/THpFVGWzUA1Fr3znJCfOh+RB
         f6EjSAahNbOGSbZYa5oPAp5cmkyYqZyrrIqVbD6YsEaQIIFmtlX+gyqGxuzoK5ghGaur
         vhDJS6iQ+0xVlFiRL3J5UdkrqSh12BSA4bkG6Mu2AhrluRs/c3L6lvBnICmKSzSc+oAo
         ksX/IMIJhjr/jQUSEEl2ty8wMCamrfoWunHQNNf/Zs754LYQmIWSjJhFhr9lgjJ1JB29
         isUA==
X-Forwarded-Encrypted: i=1; AJvYcCVyIwEM97FQL8VQ8PwgUYdZnrj4ypHu2XtEAqgWtdNt1MWRXv3dTMjMipqkmvjmBPSU2JavdOkxEuBAh/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK//aeoyAobebcsmLcHc35JevSgnibHThB+BiXmhY75XvccSkU
	ZAPpr9MjvhcbzWYgpJSRgFziFhdO8Hd2f0C9KT/ZeaCzsm27p6Sh
X-Gm-Gg: ASbGncsOk1yJQYbq+A0Z0WbWLhnL6AWYTJsaVh/RK2N19SfLbPBHCrLoEc86zENZGgZ
	KPAT+8O5iOtKqvZjSilwXZBWptPUZBklt2fG6m+5s1uNvFbF5sdSjvU8WKBCxZ/zpUgiXftSzLT
	Hvo0I52laEI0FZtSHMhyDQRJoSHAzkw5If+Sei0YwG0OID+JdhBMZLiUS91TQp+NKPhKVn85//1
	e/kkPjuDDY5UjTxHeNIKHsNxDsJ6XsXfJ7tGGUORlXFvjWvBUIziTP+zKACCfhnRoOPm06M7ZZt
	xQyvAvjXGY5+JWGk
X-Google-Smtp-Source: AGHT+IGUR3tSkS3WDS6O427aOiUDWFepr6QHmWHQE9Tm5bdBdUFEY/hZlA8g9FMTjybk2Wv4qUWMsg==
X-Received: by 2002:adf:e647:0:b0:38d:ba09:86b5 with SMTP id ffacd0b85a97d-38f587e6476mr1897829f8f.52.1739954199911;
        Wed, 19 Feb 2025 00:36:39 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259f7df2sm17193376f8f.84.2025.02.19.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:36:39 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] mm/mincore: improve performance by adding an unlikely hint
Date: Wed, 19 Feb 2025 08:36:07 +0000
Message-ID: <20250219083607.5183-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adding an unlikely() hint on the masked start comparison error
return path improves run-time performance of the mincore system call.

Benchmarking on an i9-12900 shows an improvement of 7ns on mincore calls
on a 256KB mmap'd region where 50% of the pages we resident. Improvement
was from ~970 ns down to 963 ns, so a small ~0.7% improvement.

Results based on running 20 tests with turbo disabled (to reduce
clock freq turbo changes), with 10 second run per test and comparing
the number of mincores calls per second. The % standard deviation of
the 20 tests was ~0.10%, so results are reliable.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

---

V2: Add information about % improvement and timings in nanoseconds

---
 mm/mincore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index d6bd19e520fc..832f29f46767 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -239,7 +239,7 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
 	start = untagged_addr(start);
 
 	/* Check the start address: needs to be page-aligned.. */
-	if (start & ~PAGE_MASK)
+	if (unlikely(start & ~PAGE_MASK))
 		return -EINVAL;
 
 	/* ..and we need to be passed a valid user-space range */
-- 
2.47.2


