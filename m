Return-Path: <linux-kernel+bounces-513472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FA3A34B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022D63B5750
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B82E24BBE0;
	Thu, 13 Feb 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8Hmhee/"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947E242937
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464788; cv=none; b=njJ1ax+3GePiHyLtb9waPzg3kOhkty48g/DvQgZstNPxkWHzMtqn/HOwczN8UqxpIM8AAEQW5vLRsF7eHiTpZyB8U+X8SDptxtyDS9OR136JGNHC2lOQ1eyFLJWN7q12Z45byz7ZbR9wZ/2HAI8jcetX4+oBbfjC9VVtvGEyxqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464788; c=relaxed/simple;
	bh=4xUlRntfz+/weGMfEaDr2cxXw3WyJ6iTfx5dlhd649A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ec2ZZz8q9RufMwtux5cq6jW2Zx4XyGK4yeX2P1yCgSvzS3/j6qciY1bBXp+F5WVodw7zLTW+vKRTP1DIG1moJluzTmCkVu1fYUz2BHJAEeshCZ/xvn1GsnH5NyJD1m1qD1/N75ACDejQwfChPjRqca0ycpmjPjWa30YRfC3g5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8Hmhee/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43948021a45so11828455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739464785; x=1740069585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2whu/TTQdJOOe4LRybvnZZM9A0abjywH/0UjjDIiqAw=;
        b=i8Hmhee/Px2jhitaNjwyvFiBMNMfqt0oYVLsW9iav1+8T5mKKxzerqi51zkQk3F0uq
         yvN+Gj68VuJ8hcS85n4KtW3RDnZ/+LN7VSBPeEArnDzsUIV4FR7MTk1Gwj3tQPwZ2ujm
         W+4qyaa4qOkpi0Mph6+WYkvCMCb81GE8OgCxywMM7ZVXj/wY0MxB1er5iByb/K4nUSP8
         O5WwnO2vOclbCh6XQj/01OSQ7HiYbrhlt8XHkawTry8ccUR/XbyiftHPuX6ddHskUpm1
         7UTs2Rt8fZazi1eZa6MpxqlOgL5pJDxojvmPvHbGdoFsveHI9ViachJcKe7CmPGxrLA+
         sa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464785; x=1740069585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2whu/TTQdJOOe4LRybvnZZM9A0abjywH/0UjjDIiqAw=;
        b=AEaDRBwje6CaAEAUueLB5B8Kmbhox6uLcXOICOtsC2eu/JtOxidOtCK1KmB0fOOz5B
         Lyyq8DRrEeMShaiuo2lMxfKzZ8LAWGVkuLIknxW+X4zZKG274LSmbtujOY/rPLHKjJtK
         ff7nPI/eUNUsOydmzXNSmvjzUSIiRyClvU8Kt22CNEDshA9WE0FxH17A8jm+uQwpvjaI
         oOIhoqjSaDaK87MP+UyX+A9hCb8fC/yhw/6TEJz6Y8/bnWf59fj9VZ7Qbt5JW4/feZfu
         Fiwtbo8tklsBEFOWMUlVDEuBLA2bEngG6DcaDwMX1XftebN+1YUu/fnN1PllA8pU5YS2
         72Eg==
X-Gm-Message-State: AOJu0YwZAxq3sUROGrh2h39RzyxhZiDAY1ryODClZ5jKdBcp2LyMI7LQ
	lDTWzL+e2A7HV0lifbAmLa9Z+Jon4PhfsHghYK+DBKQ8hTwAxkpu
X-Gm-Gg: ASbGncuSg0e/2iubYfXurA9qjZuTS2lOK2IFjNGaK31kfdsxdzVTqV53/5uH65oO5QX
	dNDFH6I9PUFSlhjSKnNMbzWiiEnyEOZYdnIZ/F/1OuccV2q5tLFk6a6zqkZZxJ/IbLDlWv+g8Zh
	xBOIl5Eik606ek3DRTr4VTRPSqgmW0LjG7DITRIUf2GwvHGokNNcPQ6nFwsChkF7OP1siDTCgaL
	G8WcEqJFyMvEx+TcSBXOKpTfsuU1e600eT0qwesnl9sQ8V+VgcmJuMBV/HUUfZF0H5XeOx1HLz1
	h1PMGnEKMTEQN8zW
X-Google-Smtp-Source: AGHT+IG4ihLrpjk27ZDNg+d+HX9dL7ONrqlncvFCYjkeIpbP1ccue2TN1BICkBZokXTQqWCtZQpBRA==
X-Received: by 2002:adf:f507:0:b0:38d:e250:d953 with SMTP id ffacd0b85a97d-38dea2d32a2mr8429017f8f.35.1739464784841;
        Thu, 13 Feb 2025 08:39:44 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f25914d73sm2364857f8f.54.2025.02.13.08.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:39:44 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kcmp: improve performance adding an unlikely hint to task comparisons
Date: Thu, 13 Feb 2025 16:39:16 +0000
Message-ID: <20250213163916.709392-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adding an unlikely() hint on task comparisons on an unlikely error
return path improves run-time performance of the kcmp system call.

Benchmarking on an i9-12900 shows an improvement of ~5.5% on kcmp().
Results based on running 20 tests with turbo disabled (to reduce
clock freq turbo changes), with 10 second run per test and comparing
the number of kcmp calls per second. The % Standard deviation of 20
tests was ~0.25%, results are reliable.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/kcmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 2c596851f8a9..7c1a65bd5f8d 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -145,7 +145,7 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
 	 */
 	task1 = find_task_by_vpid(pid1);
 	task2 = find_task_by_vpid(pid2);
-	if (!task1 || !task2)
+	if (unlikely(!task1 || !task2))
 		goto err_no_task;
 
 	get_task_struct(task1);
-- 
2.47.2


