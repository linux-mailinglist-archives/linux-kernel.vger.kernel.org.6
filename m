Return-Path: <linux-kernel+bounces-518133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D266DA38A59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FAA18947A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084042288D6;
	Mon, 17 Feb 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9WsG2Mm"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EB22838F;
	Mon, 17 Feb 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812206; cv=none; b=VKEOboV7yy9qtRpLps6oZuu49BnJu4ctJN01P+O0ezd87G9faMF59FYXF/XQxfP4EX912ocFk1lHaZD5K3Rz8uJQF/jwo4twEvahOVqSqzI7JsysHV2w3u20NNEsGk4l4viGtvqYLFDCutKhUQYngLtbS1qhESll9AaXr5WlaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812206; c=relaxed/simple;
	bh=8i74CWaRxLv7NxCrbdApGSKYAo9DKf1lUGbNfyZyegE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZL7OAd1Qr9QohjQj4mpGJ3FargpyPyQmZecKhNgeCmx5fiOW3qnsmoRaQ8Bsh8CwneQDl6nrzRoqyQIevi8wiZi7D5JNS4G5Jt5+S1wYO1MYfvn7tdzECkDDUOYbiMhb6vTgrM08QE8yn8XWAR3g+ibnQG1ku0QI/eIrgvtyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9WsG2Mm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4396a4d5e3bso30733345e9.3;
        Mon, 17 Feb 2025 09:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739812203; x=1740417003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=st4+9SuOYSXi/BL8qizMsgfbdxZRW4vboBrM8JIcEZM=;
        b=E9WsG2Mmmzuk6kr1Bhlq98HWOlfLGQFQ6GrNxWzIVk7VUfENbXRrDjedkcTr5qb5KK
         dHTfo5W2v3igcS1R2Ll90zvdlyMkqH632f2zyPXhlf1dZri9cIwUgc+xJbtcNCm2eKDA
         z0IhceMwUFmN+nA/7dUOUSshEB6w1egpAWnFP04/pn7h5BrsCGfqZ7cydINdXXZA46Lr
         u9rFj4S4x0hK3vgNTTcCZ3vBMokAOMwOksT++Hfo4ACt5aZygrgQ7121LQMbkAGtWRuj
         p8/4Ml8bwZFq2Jma2XpCJGKZTUmzG3FyfuY4LO2JPU7EayQ27vFlCy/xvgqlZhifJ66R
         XiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739812203; x=1740417003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=st4+9SuOYSXi/BL8qizMsgfbdxZRW4vboBrM8JIcEZM=;
        b=Gp9wX/V+L79JLgZ3HVMigS9+vTfRaK1F/z/7DKSckz3hywGPkub/OlXsD2Ngjoo2vz
         lOQ5Ryvirn8NO0d8eNkPG8T71of0yejLG8UYhibOVqvaod9GhcSzXgSiLOCufTevNCz8
         n7HhlEzn0ARj2qybGdjO9vAY3XduZ/9J99xsSYvzP5wDzqmI2fwh2LWm2G7hPluNeFFW
         YbO8NLChD7fnmLSCVXXC4PihEo00jB3b0MRAX1sK59DnxostYsbcuoafmfA0g+rChxsm
         UoHEQfqMPGmvsU3OX3BFWUeFVfEv4kIfg7hAS2pAD76AHbmCUIEwS7vvrV3ihsM/fXhX
         arHA==
X-Forwarded-Encrypted: i=1; AJvYcCXq/YQyOG3Zz6/ynb6STCR+BnAnsiovl5pSGqHq7BmXmmI543o/ASmXJVlffRjVtfSYj5RCnFh0gCJyyIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcd5qRxB2ar/s4hbFXAIcNFL5OkEPcTHou/5YAUnzcHcaY4U1g
	BVGHURNlaFBTzZyvlsV0eqMc5TsLbF2ZtqwUNAVQnsur2122PW0+kx1CmlRvtjA=
X-Gm-Gg: ASbGncvjkfNPCrjL4xmfnj3zrgrpFUhnVntBx6xJBhC5MyXdtxjbxN0qnf3Q9i9rEVD
	t9BgsiEK5pQw4c/kfQc5iY+KtDP77OeLCs166X4QUUvRJ73uqC9aXJUOxkNMlicUaGPwuo1YXl+
	B+Ieqz5z4HfTjRYBxj9ldFdCfXW306y5RLDqdfPKt4RRXa+MJEVEy2D36bL30+I+9nNTb0y2sc1
	rA3GBV8GMcn0zrOMPorL7u2yhfcDevJvPbAY/KsIPlLdACTNI0n9LWsp+PRr2h2hnM7nPbZQNS7
	6ATUX0VHcLyahAHo
X-Google-Smtp-Source: AGHT+IFR8wIX5kzLKdIN4OP3fmjkfv73Yd4uUXOuq7Mpy4RCDvMHb9zJ6sCjSSKf8UjQNxFMmKSGoA==
X-Received: by 2002:a05:600c:154e:b0:439:8bb1:14b1 with SMTP id 5b1f17b1804b1-4398bb117e6mr31066175e9.11.1739812202821;
        Mon, 17 Feb 2025 09:10:02 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4395a1b84bcsm163583295e9.40.2025.02.17.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:10:02 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm/mincore: improve performance by adding an unlikely hint
Date: Mon, 17 Feb 2025 17:09:34 +0000
Message-ID: <20250217170934.457266-1-colin.i.king@gmail.com>
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
on a 256KB mmap'd region where 50% of the pages we resident.

Results based on running 20 tests with turbo disabled (to reduce
clock freq turbo changes), with 10 second run per test and comparing
the number of mincores calls per second. The % standard deviation of
the 20 tests was ~0.10%, so results are reliable.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
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


