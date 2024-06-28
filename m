Return-Path: <linux-kernel+bounces-234449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B091C6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E2E284ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726D768EC;
	Fri, 28 Jun 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="pxUkttFm"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D156444
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603865; cv=none; b=uufSZsso44TgxPFQmz2/3s+wnc8lBuqTQCKl0mqdCwY4Kzz3obA2Lty4YGGSEP8e9j2Rw2xHggAVDE9+4Rq9A15zGxPvONaCLwWCggHLEVYqR9ew+FAzyOhT1vtKNKUK4IBCHWkawHGxAsDPepjfV9u6pR7fYg9RKH32vx5R1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603865; c=relaxed/simple;
	bh=crrG3dHuMFZI2z5r3QQPDZWjEi5v70GoDQxG4hmO7P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfYtI9/EZL/hxnjymtE1/Bd3F6jQ2nGdoE9ePR3IOFqq9Jr1fuWMoW2oVeoWp3Uk0qIaPSq9Q7gz3lTOry0hBJEYOqR+s9tiRuatlw5VET59cGjCGLZEUbyKATJBVv+nxIriXAnYl1bGIiz9AJTMOhugpZaYoZg/t0A8C9bSDj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=pxUkttFm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7178ba1c24bso675896a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719603863; x=1720208663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dABxp0ZkWRDnxn2dOPgubLZS9MUogARXawlgCy4vPv8=;
        b=pxUkttFm4632MUfcf+k7wNF0sjtMGXpaXCWaLi6T0bSlF2yYvak6d18izZpd/SZMzZ
         tFTtLRIDODiT5WCKp4F6Ws9/R0WjMtmNHDMa/PUNtpHxMgb9U5MLODDmFuaK+LSWpA5W
         oxLDO5rixzPLUF9GOTBVI97TPTAWcYaoIKRWZHFYu4BKRdZCzssP3/NAsCwx2ZyezCxD
         BzmWl6JFfQYoAU4jnoICQgXhBX1Ckzb3bZ/286Xf1ECuEs/U7V5Dq0k55ZUUajd8QR+5
         QYByRyfeEqs8uVnkOGYsmuRAUblbRzvMg7xAJSKsRnqtnptP04MjGgM21zI70fOXjgj2
         6C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603863; x=1720208663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dABxp0ZkWRDnxn2dOPgubLZS9MUogARXawlgCy4vPv8=;
        b=VNMUhjZds1Dopf/XejUjzWfld0MHvXC/SOgIus6elnE76/b3ewnS9rCv2jngy9v9cq
         Vp1uXvwQqYnGkaTnQgkMsAk6Vrqb/0vEjA/jG6eWpov8/YWu7SGaW5OPOShoAWbdAd4a
         wVpmZVuBqvb+7Iz5HPS8wThqhkSnFcdcsy0oHcoZfcsvZcFywRrhirAN6DEcTfpVMW76
         1OS/828UXdtZzKDiOWFv1+AnGQNNGFyIhbFkq6L6pFjD1NutW/+VuJjxtljbg35s//gW
         DRTPb+yJD7UbYceErwRvotCHxJzvDlVDh9bOfP3Pz18dXwPudg8UoCh1m1lA3/QWHKHU
         /C/A==
X-Forwarded-Encrypted: i=1; AJvYcCUDxbnGPpNzVVhCNfDGYLkqrMp5doDsEYcT6KLY8ggFdz72mIEnsl24TBgUOBxA4ZQwLTfas5mDTzjHD2z+ZWNEHNszYw9oTNxvON8f
X-Gm-Message-State: AOJu0YzLQF0Wrw/LG/jlkkbR6PVSeFP3DAcnYKpkwNOCgj4Px83/ga/8
	vhmjm3YR5XlynPFEteyNaCGFqTkF4tvFUr6UChsTYY8DwE9a3jkY45eVDpEKVCE=
X-Google-Smtp-Source: AGHT+IGosIJ98e+iQTAN/G3Ny99mkxMe8FqNhA1llX0ioPTUMT4HP4VItawejXCrbopfrjS07dPfmg==
X-Received: by 2002:a05:6a20:dda0:b0:1be:c414:7ae4 with SMTP id adf61e73a8af0-1bec4148122mr8323596637.60.1719603863617;
        Fri, 28 Jun 2024 12:44:23 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8f1asm19227145ad.48.2024.06.28.12.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 12:44:23 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linux@armlinux.org.uk
Cc: mingo@kernel.org,
	sshegde@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ARM, sched/topology: Check return value of kcalloc()
Date: Fri, 28 Jun 2024 21:43:51 +0200
Message-ID: <20240628194350.542376-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of kcalloc() and return early if memory
allocation fails.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/arm/kernel/topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 2336ee2aa44a..b77d1838e5a3 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -93,6 +93,10 @@ static void __init parse_dt_topology(void)
 
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
+	if (unlikely(!__cpu_capacity)) {
+		pr_crit("Failed to allocate memory for __cpu_capacity\n");
+		return;
+	}
 
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
-- 
2.45.2


