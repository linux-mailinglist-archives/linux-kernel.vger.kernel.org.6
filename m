Return-Path: <linux-kernel+bounces-395823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA71D9BC38C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C75B21D4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F155674D;
	Tue,  5 Nov 2024 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZwP8pNov"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6106055E53
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775833; cv=none; b=Z5nPrS+2k9jxETFmw2KJwwkwSU0ssPHa1zCRU7lJmSYAZ3phgw8Aro3YxFgHDcxXOVelJ0jWdMbSGV6LHfIhTpblUnQqfW+Fxt0w7H4yZZeGf49ak3OIOujFS3fkMvlddJrlHJUWFcrCRXNATu5wvWKooIAvsmlG2PunKcMupMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775833; c=relaxed/simple;
	bh=9BMNST86hXoq7tnK+iM6FaNmtJgWm/NevWWYcnnCBPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qYynvYGno1Bl8xhyYR1s0IFjj5sgQwNV1JiKkNodMAhbztk0V9Qs/119ic2lp4i6C0FWc86n4WH1FUsjbWYqgONa5ACNIoorbErxmTl+t8rJbs04u8TRW05vyCSOpnEdzpFf6x0xclf9L8MY9WDYt34gzfLeLA7c6Iw5zsIannM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZwP8pNov; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca1b6a80aso50479825ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 19:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730775832; x=1731380632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=081u9OxR4oMwyBpE2M7xzAk8x7mY8I7bQvk7Iyys+N0=;
        b=ZwP8pNovTeBq8e6JlxMbamo+sIxakPY1o7IGkEKkW+efX61ZxDNVCuvEz4gc8N2Myt
         lOVl6te3rR8lh6HQyn5/m53o4KKy9fxvG3eHVaKoCpUEJF9pIqv45j42G4XKGqb6CbPH
         hQTlJbdGD1DBF4hp9fbZLF8i1zSSG39Q9uN3Gq7SSefAA1P0kzCD9R1Q988qMQhAX5O8
         3R8vo13xaZVhnYiOS6lcEI2r9Di9J4C+kHUb8fApN8NiKPEkT6JWvrcdQqx11bmcGXlB
         I8UhAbLC1YDHaj0JKdwI9UEsssWoysO32YDXpVWjQlz1qN6ER1smi/RVhPcxDXEv/29f
         ZBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775832; x=1731380632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=081u9OxR4oMwyBpE2M7xzAk8x7mY8I7bQvk7Iyys+N0=;
        b=eAXJnKbY3Rd7O3VzZZqUnCq/QFqoL6bhCTdmeDn840ERoTnbLBQ1DzjZCLir6iswl+
         FWM7hHlITNDKop4swXb5Ljz/OSDrsBWbBO//rg/LbTC1/zvTTVrMF5Ey87KL4oXw/cFx
         gYnFqi3Ad0UVOQfqrXxuRWJycUIzTp193plukJyj6tsPL3Fs92blWnOZ1FKUJWptIjv4
         Vz/6nGjThrMmqqpm4PbN+VxxpJtcMVikqjSb7UgayX+EahHPQw45bDAh4NP5y0Q9brtW
         fCRszQ2o1knHdzema4R70nda8GzRDT9XzWYxJPssGWUPQ7m5S5AViVc1ZSky4f706gtK
         qWTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTM6wnWphXx5Ck5cf5etkOdndyZUrj9uNw2nYRp79IDuznviWaDThrU9TM/O3TJzx6wFPCvpUocfEJRkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDscPzOZEwxUtGAOZpWldYu+dvsxQowwpL/iDv9nncPMXdv727
	fON5tQ61FIZTmJQWqUODS42447oMDmDq/d59xO2H8z0RjEj2WUC7rjC2++1sbsXMzrdS/jzLpMk
	Ko+A=
X-Google-Smtp-Source: AGHT+IH/L7hHG+MT/u1QX/Ur69PydXRoAFtt1JhiVv6qeo3eCMvbbjsEY7Zk1fBjidqC36zg70QWCA==
X-Received: by 2002:a17:90b:3c0e:b0:2e2:ffb0:8a5c with SMTP id 98e67ed59e1d1-2e94c50d149mr19862460a91.27.1730775831422;
        Mon, 04 Nov 2024 19:03:51 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93da8e879sm8538424a91.10.2024.11.04.19.03.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Nov 2024 19:03:50 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zefan Li <lizf.kern@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] MAINTAINERS: remove Zefan Li
Date: Tue,  5 Nov 2024 11:02:52 +0800
Message-Id: <20241105030252.82419-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zefan Li <lizf.kern@gmail.com>

Not active for a long time, so remove myself from MAINTAINERS.

Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Zefan Li <lizf.kern@gmail.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
 - Add Muchun SOB (Tejun).

 CREDITS     | 3 +++
 MAINTAINERS | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index d6cbd4c792a12..717c7d9de5f64 100644
--- a/CREDITS
+++ b/CREDITS
@@ -567,6 +567,9 @@ N: Zach Brown
 E: zab@zabbo.net
 D: maestro pci sound
 
+N: Zefan Li
+D: Contribution to control group stuff
+
 N: David Brownell
 D: Kernel engineer, mentor, and friend.  Maintained USB EHCI and
 D: gadget layers, SPI subsystem, GPIO subsystem, and more than a few
diff --git a/MAINTAINERS b/MAINTAINERS
index 32a63c456aa0d..e6db40f53784f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5664,7 +5664,6 @@ F:	kernel/context_tracking.c
 
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
-M:	Zefan Li <lizefan.x@bytedance.com>
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Koutný <mkoutny@suse.com>
 L:	cgroups@vger.kernel.org
@@ -5693,7 +5692,6 @@ F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
 M:	Waiman Long <longman@redhat.com>
-M:	Zefan Li <lizefan.x@bytedance.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
-- 
2.20.1


