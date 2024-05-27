Return-Path: <linux-kernel+bounces-190121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78B8CF9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9D31F210D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926A17BBF;
	Mon, 27 May 2024 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNwh4O8g"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE01755A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794037; cv=none; b=ZtWUSjNMaE5rVRspsp3tTl8n8OP1pvnWB472iUNy3tNpmN1PpY22XJ8dDw18idDjA7y39Sv6S3jJ6MEk46gTBHBwxiG70tIYYlYSZppEv9Y+we3OPBS8a9cQ4ahzoQtgL7tTZSK/6YmpqreufhO2Wy0D/GQU5f15lLdSykzFnTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794037; c=relaxed/simple;
	bh=hPOiU8EzJd6UGf1Qrqx8b1T+bxulcNCNVewdy3U/vsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oeIABBuaWwC3GKldrEPMHFkl7ak7a4P1vt2Qm62zXXr9lw8uCRKVeTt4sl5tMbmIAbcJEeQdUKMjN0QF0tyrNRuL3I5BVDOo8fAmfKruXw6NFuERNw8oUt8C2ulSnexMILdNP4Si9Ewe+z9QniNi8f3MGXyGOhRLIBBgT6x452U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNwh4O8g; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c9f91242dso1540892fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716794035; x=1717398835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uye+qPyIlPr8r1G8aGQy8xNPlvuLVvJZ8ppLZ/tUAB4=;
        b=nNwh4O8g3TO5/glcAzO8PEvdX07FSqBCRl/rHk6GG8U03EKlKEMNlR5COe+BEm9VCR
         QA2iqmc9lYNKtUpg/YKXuT07ER0o13afijEOIJWejLBrEmSycbW4Y4UfHIdgI5I5VClB
         vsQPTKMlk7GKxDqOSlGb8Np6QHGXFpbUct31u17Hh+C22rTbce3+QRtoiPKumX6k/Zrx
         SEk7xjtMQqlL/MRI5oaUCQuyjy1lQpXHFwfwTxUM0ClDUXHqet007nitX6qDZm/lrzjI
         JxLTtAEDmG/RLi4fSBjBRcHbHniqI4hpzfQI/EtxiEvc6VCmPHHSEqV4QgvpuGTbtARA
         3y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794035; x=1717398835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uye+qPyIlPr8r1G8aGQy8xNPlvuLVvJZ8ppLZ/tUAB4=;
        b=NTYiDQA92kDZAjm1GBjp3R3cbSiPjqL2gdTwNJ5MoJbu4Zg2cPIEI9HKnkhAlamaAg
         cJ4JdsppfcvbbvLaA/HCvKmS89NO/Q8j+BuPnl0omydPKDINHI9wVxkXGKlfNjkPINaI
         79Y8Y80GMpaMeKThnMw9Aiv6PNuiivWa36k4RfD1vHdZ/5ihCsubgb+ZTpSH504CX4D8
         ctAzyiCAuZcktlkqinZdqPnncmUyufnJoAyZlKoUflyX6NiQVJ945K/MzvEr4vdz4RPb
         cEwELpfyID7xINUh1aPvCuqFkqgYBLXLbJgpeqQq7vWExIzWRfao0HW91Nx08jQBQeQk
         HGEg==
X-Forwarded-Encrypted: i=1; AJvYcCWB+FtvLBnZ20kgo0qsDq/hJZROzFMYdP9JDwIO7eXpuKEvl/vTzxf8mlTncjpCrhuEwHwDRa/3E0rAcnUnkqdSt7V/TXZwSgE7uHmd
X-Gm-Message-State: AOJu0Yy5FyPz4EFFTE3HA6lgT5Buqb+mJWTSwBKi3kXzbyDDcUbGQ+iF
	+QNog75qG3WE7sbaJClZ+PH20zBJa7Jc3FcFJRFFWa5B98JKrVMl
X-Google-Smtp-Source: AGHT+IGDFKLKRkNsLLmb9PBuSt2+uES2v9ZFulvy+8S4g4S8berIKqqGnZ6WVt4Fg9LxWzPpocp1WQ==
X-Received: by 2002:a05:6870:fbab:b0:22e:8a0c:ea26 with SMTP id 586e51a60fabf-24ca13e796cmr9174312fac.44.1716794035173;
        Mon, 27 May 2024 00:13:55 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d56casm4357253b3a.199.2024.05.27.00.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:13:54 -0700 (PDT)
From: yskelg@gmail.com
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: skhan@linuxfoundation.org,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] tools/virtio: pipe assertion in vring_test.c
Date: Mon, 27 May 2024 16:13:31 +0900
Message-Id: <20240527071330.105268-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

The virtio_device need to fail checking when create the geust/host pipe.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/virtio/vringh_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 98ff808d6f0c..b1af8807c02a 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -161,8 +161,8 @@ static int parallel_test(u64 features,
 	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 
-	pipe(to_guest);
-	pipe(to_host);
+	assert(pipe(to_guest) == 0);
+	assert(pipe(to_host) == 0);
 
 	CPU_ZERO(&cpu_set);
 	find_cpus(&first_cpu, &last_cpu);
-- 
2.34.1


