Return-Path: <linux-kernel+bounces-379758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094649AE35B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39A61F239BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AFB1C9EB7;
	Thu, 24 Oct 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckP7SeHy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3917278D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767876; cv=none; b=a6UVIxkLU1PY+7T3UA0jVMzr9njiCoYQb+3+LK14n4gua5h9ShmFPODxFILbWAh5GkpIArOBNYDvWiGKSb+wUzK7lqoS6LLIW6paBpAVeiMZgju9GKC7GwWzc2+RUt9wkXzjVbfOxo2egXcFVNADfKUWmu1MOtER6141qESdXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767876; c=relaxed/simple;
	bh=iqUHT538y1XZ2FPWcMn9nqaJe+HywOwuSLzBsMlplkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HMRKN1++6O9HoAzhq+QFgEhrgoW75uYspOwCRNjfSj8S5t+PtecLDJZGsyJ+eAkOl+6qWqMJh5kcJFHuWC4tnrZZ1Cms9oAQqwbZU+2dvshWtl46uDjtaykigiI5WG0ZX6FDy+OEMBCFWZcOW+u7p8f1Y65WbOtr+q6lfiU7kDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckP7SeHy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43155afca99so12627765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729767873; x=1730372673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Hp3MZ2J5nvjPXe4owm1R1USO0JqDtTZ1bRIkLYYf4c=;
        b=ckP7SeHy43fXPSvol3sAMPedIiFLi5GdhB0XiDm72CQIc1PPiFdLmlXWGNDURg1MVI
         Y+LqoKNj6IuQRsRXDldv1MsMwmDakHGdNcRwMT/G2NKIl7vO+uYAsJqFT2YlX8wqoUx/
         rkuBQHxthkcT68qEzF1ZPdufecrcBaOxaWzN1XueMNhgvFjPDNwn7ZZcrA3rD3pyqc/F
         9MkVFNwvRfTRJpnYTate3ILlQgRcqb1PJB1KTPOY2sdvxY5XP2NwpH+rOdErZsvs/ptP
         TqrrkkQXV7lD3sIOwtb4r9Wmh9sPXalTScuyfOcmtGMsy0XQPz/imBdBwviC0u58MR9c
         cskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767873; x=1730372673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Hp3MZ2J5nvjPXe4owm1R1USO0JqDtTZ1bRIkLYYf4c=;
        b=CbopTRcBQCcrJs3p9daSpjFNqEXdrQ9UKl684NFfwkaLsPqrD60fXdxnSheEFgO+yG
         kulIrduamSDpIfflWAJF4GGTnCKCRU17Elk2na3brMBSdS2yyH/76ESnmFSpKwElOKYS
         Vd7gZKOndlwR0VPLers65R/RSZVT8drOJVkEXf+gCwOkVQa9MYRnXDQKSvrgbdz86IU6
         +H4cY+Zg573xZj1fOC7T3DBNynlPQ5l18ihd62eiuT/rKvPy0rt0FPf3FGfK1/nCdSz3
         XJMAH7YaheWW2/ypCDDTu0Ilg2XVhXCuqmDniz7nU5NOkUv2keTGyNYIjR+cg/H3meA+
         YEPg==
X-Gm-Message-State: AOJu0Yx9FvkrNoC1Zs2CVxj0WWYKRAx/XXbSU2nRn+pgunkxtED/hVHI
	EAytvPw8hIFB3lKoqtpCWp1DCnyx6jY2faa/0yX8y2KAaHEyKZBUZCry/g==
X-Google-Smtp-Source: AGHT+IHvwFm17skStNFtAvwBetWlAr6wTNMIcnXZh06SN4NQvfSTJYIsr0Uu7Vb9CZ6jFfl6Ufp29A==
X-Received: by 2002:a5d:4fcb:0:b0:374:c33d:377d with SMTP id ffacd0b85a97d-380458812bbmr1052145f8f.28.1729767872710;
        Thu, 24 Oct 2024 04:04:32 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c15684sm41770165e9.39.2024.10.24.04.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:04:32 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][next] dm ioctl: rate limit a couple of ioctl based error messages
Date: Thu, 24 Oct 2024 12:04:31 +0100
Message-Id: <20241024110431.1906858-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

It is possible to spam the kernel log with a misbehaving user process that
is passing incorrect dm ioctls to /dev/mapper/control. Use a rate limit
on these error messages to reduce the noise.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/md/dm-ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index f299ff393a6a..d42eac944eb5 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1912,7 +1912,7 @@ static int check_version(unsigned int cmd, struct dm_ioctl __user *user,
 
 	if ((kernel_params->version[0] != DM_VERSION_MAJOR) ||
 	    (kernel_params->version[1] > DM_VERSION_MINOR)) {
-		DMERR("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
+		DMERR_LIMIT("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
 		      DM_VERSION_MAJOR, DM_VERSION_MINOR,
 		      DM_VERSION_PATCHLEVEL,
 		      kernel_params->version[0],
@@ -1961,7 +1961,7 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 
 	if (unlikely(param_kernel->data_size < minimum_data_size) ||
 	    unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS)) {
-		DMERR("Invalid data size in the ioctl structure: %u",
+		DMERR_LIMIT("Invalid data size in the ioctl structure: %u",
 		      param_kernel->data_size);
 		return -EINVAL;
 	}
-- 
2.39.5


