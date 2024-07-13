Return-Path: <linux-kernel+bounces-251601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9F9306C3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 19:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D68BB25838
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAB313D289;
	Sat, 13 Jul 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b="T/Z0/2Y0"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499713B599
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720892520; cv=none; b=cjAwf33gvImWIS+7PYZSuKFxyLLdWF0kxTJyewhWk/l/7afxWHE48qu+yDmN7FN/tkR8U2vp9ldUATa2V/8hWzCsxfGft6J/BlQn5+ftuVSiYCs5Hs29VvKaqYc+4fMVWopca+mqHOBplL20eQ/I/r5D8gQ1G2q/T+iNFJKOHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720892520; c=relaxed/simple;
	bh=FpY23Y34S2Dy2QRSs+2759RgHdBi54IwvsI+OcGwxuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hU2660Nk8au5V3HjYzsfU07Bvid3txUkKT8ByQjC0OF8ZIV4uNgxQn4RC0zvdHIEzwCPx0QB9p4zruDycZOs+8vimGHVeHrkRPHzokE8bcMroQaUiHzgK7VH8szZeUCm88YwqgPgcWigaohM0L4DLC2BSsk31f3mAdQ43XX2oXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in; spf=fail smtp.mailfrom=mitaoe.ac.in; dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b=T/Z0/2Y0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mitaoe.ac.in
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso2500978a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mitaoe.ac.in; s=google; t=1720892517; x=1721497317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr3cz8Pmuh9T9Xv84+r+mLSB78nqefKRptLQfN0/Ky0=;
        b=T/Z0/2Y0I0oZ+sqVAUHq/N6odD+G+tdZB22GA/kQp6nBZGERUPNv4Zt63fGWQWWGuP
         HaqwnDClyIRK8jSQLeSLYTvQ6NGrQ8bw51YIpdXOJxT3w6N/EK0gSlFW+TCtcUIigAST
         Fb3Ujav/GyGPcmDvLJVwDwADM8zH2KUo8RdmK38cat5NKRgglSXBw4+67kpK4MrxUKur
         4FvOUVRg4/vvtBOz+oay7OCamGI0r0rQePuPlJmhHDRosCJBDtYwuMBGhsxyIvedocrn
         Y6DOLHGsDEz1DyJGlcCrnbSsAtTplu1nOmjBBpNS++qTXmsdpX5ax9rfScufA/gEicPH
         OOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720892517; x=1721497317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gr3cz8Pmuh9T9Xv84+r+mLSB78nqefKRptLQfN0/Ky0=;
        b=LKtvx3Dk6n/tBBMITFQh6pmDOw5MZ1d6xFAoWogXtU3ZZxK1RQFEKpylrtsmnTrKlI
         tklBcDaRQiPLakpQbw0TZtZUQcScrpCYL8gdp5a80gF/DuKBn4YSTw+ERovfhkEY+v2E
         hDQm+5YjfSw4cRhx6CK96+oN5ekwot/q+b0I+7xPq5pdqiCvYbhsJXBdd5ot8F2D3YgI
         1YawE0KflWh3q+pvfGZNdoLNE8wHXFyTEwG06bkus2csnU16dkth09dP4gggzlpVoH7t
         OPwcATwUeXECrmBFMFks4HAEgu8Zj2g3ccHcXslVwoU3TZtSpALGVH7b08ht/FxNhRfy
         7ikw==
X-Forwarded-Encrypted: i=1; AJvYcCVZLXz2r78+QjnyUBkzp7WUKjDpBI2gnoHBKY3Azyj4PwmcFkLOLwnHqaKOl10RaQApZZH8S5EfRIYifyxUh4WZ1BwpBPPNRIn+A4wS
X-Gm-Message-State: AOJu0YzLZYbaobkb23oI8yLXDkIYAz+NnpZyQnJnUDBjv4VfotekWxR6
	176pzR1HDlIO+KflWI6QenamagzEGRf6gYxrFWslrXEBHKJM4MAZgW0kD5K4KhC40NGu6erRs9X
	jJ5A=
X-Google-Smtp-Source: AGHT+IGWf/ARmDTxPAryJjo1tLre3tQf95q9el6+QvRsxx1LB3YbBViVy1vFFWIKQtYzU9JenR+TEw==
X-Received: by 2002:a05:6a20:7347:b0:1c0:eec6:85dd with SMTP id adf61e73a8af0-1c29822d117mr18233046637.33.1720892517391;
        Sat, 13 Jul 2024 10:41:57 -0700 (PDT)
Received: from localhost.localdomain ([152.58.19.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc52568sm12661315ad.290.2024.07.13.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 10:41:56 -0700 (PDT)
From: mohitpawar@mitaoe.ac.in
To: pmladek@suse.com
Cc: yoann.congal@smile.fr,
	linux-kernel@vger.kernel.org,
	Mohit0404 <mohitpawar@mitaoe.ac.in>
Subject: [PATCH 2/2] Fixed: Kernel: user_c: fixed whitespace & intendation errors
Date: Sat, 13 Jul 2024 23:11:37 +0530
Message-Id: <20240713174137.125978-1-mohitpawar@mitaoe.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohit0404 <mohitpawar@mitaoe.ac.in>

Resolved -
	ERROR: trailing whitespace
	ERROR: space required before the open parenthesis '('
---
 kernel/user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/user.c b/kernel/user.c
index aa1162deafe4..9e07264fd6f7 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -6,7 +6,7 @@
  *
  * We have a per-user structure to keep track of how many
  * processes, files etc the user has claimed, in order to be
- * able to have per-user limits for system resources. 
+ * able to have per-user limits for system resources.
  */
 
 #include <linux/init.h>
@@ -249,7 +249,7 @@ static int __init uid_cache_init(void)
 	uid_cachep = kmem_cache_create("uid_cache", sizeof(struct user_struct),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
 
-	for(n = 0; n < UIDHASH_SZ; ++n)
+	for (n = 0; n < UIDHASH_SZ; ++n)
 		INIT_HLIST_HEAD(uidhash_table + n);
 
 	if (user_epoll_alloc(&root_user))
-- 
2.34.1


