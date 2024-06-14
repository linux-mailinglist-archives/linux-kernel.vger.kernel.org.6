Return-Path: <linux-kernel+bounces-215321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AED909121
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D679E1F279AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC13319ADBF;
	Fri, 14 Jun 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QutcoE3z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C631974EA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385147; cv=none; b=gnkxZriU3RpHjClK7BXgPXlB8DtU9+2F05jstyYSjdr2baUi7ETEXTD6PrjR9/tvX/PYSrpE56kZlrsjtwg5ZpDSdbvdlBqKZXva8dqbiJb7RfBn0NM2ipArZgNOl0WsYr40UzbLsw6SXvPnfzyW4HKf5I/0CIe2NQICIGrLxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385147; c=relaxed/simple;
	bh=x+otNWEFlQBBRzNB1IF+dRyOkNFfgjJkLswiKc80RcE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=muUL7o85T3bsqyXO2Oe6TdxAzljP1DIVEtilJ+mMkYcG+JI2lUc9H4H1V9KDDNmHEyxPvhx8278kVTkrBWfZbEgmFVUDEzAnfsJKTM0RfyHLt1ZPai4lvNhrsVxljSoyTYjSWz40KjvveciQj9DUD/kRsy7QlvNipxNLoQB7bNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QutcoE3z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627f20cff42so40355167b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718385145; x=1718989945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=emwuEUJzOe3CVEz416PelL/kwtt17NFvxEL+ya6n9Ro=;
        b=QutcoE3zlSANUr4aydUrpuXpvO96BCcSB4vY5yosbAd7ANDgE7/5aY+bNBX6iQ+UjL
         1SSQhZw+i2RiDCYSxL/OUwMqG+8VJgCKZn0UJfI1+ZvKVQ2RhWNgr1AHIfJB0iV0c+lr
         S01goPqvV3thAJNRL6rXx+ZVosWxnGREdXz6XU4pQ2OHDZJGSgpVe2pRPnpf0530qw22
         c/ICOThH5gIK3j2XdBl+pbpAs7dy788d5bYVWZ0hy2IDcSn9CxVf17l42iVGsnf/hLga
         GKOZEpUhlF/SifoiiHam0p2q0erCyuLjOLQmCMeXRxW41qFkqjl9p3gWgbzxggetw5uu
         HYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718385145; x=1718989945;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emwuEUJzOe3CVEz416PelL/kwtt17NFvxEL+ya6n9Ro=;
        b=nqZhDk9Hk6scSIalWCTTrRHoURoY2IMYgeb5rPDWaN8ueZMrsCh8FwDfjmyoLDLkgR
         j08mItyQwzdD0BUzEqs6MjcpsM3qlAy/M+LDvJfc2vsWtTcrKnMgTq2YKbmigDhnUCLg
         +e3K5UlrL+CL9VWXsngzmbpq1FlyOFaX8gIeosvmknB3ogz+pMASZr+ACH2USeLiPua+
         k8maNmkoUWdCLIrKsXYWjoRRDdHsnJvSbeyzqxXkVJ8F1QBa/5fWvRIewK+cZeKoILo4
         1WPjeMN4Y7yeDcFnMXy3anhCIWIK0p3wDlWZKCPwzxjMubM+xwUDo2/VEKX9aAEBdh3Q
         nF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUP8EeOzc5g+Wayzq+ETlXjp860DV3kloQ7eZTO7UHlfIZnJNWExYflHVC3s7PBFrFt828ljRk4EH5CmWEHzCpCcEgGHUtpiw6xB/0
X-Gm-Message-State: AOJu0YxFhT9pHjvV0gTPG6x6tfYaGcfZivzhVHOGQEOI393b8X8UBzYm
	4+kMD/GpgZeXmHkgyqEsDNYsQi6OdIOQhfPQJgID+Rn8q7ixWVHUSIyNd/plV4ig4eVaJN1up7b
	b1A==
X-Google-Smtp-Source: AGHT+IGiu9oi4wLwPHqLP3ZxXb4cITorTe05FTrhviF75CVPQqW7YeLpX0xrl1EMeYTeNk6B1p4U3HnG/YU=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:4f99:8d17:1a35:c8a5])
 (user=nogikh job=sendgmr) by 2002:a05:690c:d1b:b0:61d:ece5:2bf with SMTP id
 00721157ae682-6322265e839mr10188807b3.4.1718385144853; Fri, 14 Jun 2024
 10:12:24 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:12:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614171221.2837584-1-nogikh@google.com>
Subject: [PATCH v2] kcov: don't lose track of remote references during softirqs
From: Aleksandr Nogikh <nogikh@google.com>
To: dvyukov@google.com, andreyknvl@gmail.com, arnd@arndb.de, 
	akpm@linux-foundation.org
Cc: elver@google.com, glider@google.com, syzkaller@googlegroups.com, 
	kasan-dev@googlegroups.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"

In kcov_remote_start()/kcov_remote_stop(), we swap the previous KCOV
metadata of the current task into a per-CPU variable. However, the
kcov_mode_enabled(mode) check is not sufficient in the case of remote
KCOV coverage: current->kcov_mode always remains KCOV_MODE_DISABLED
for remote KCOV objects.

If the original task that has invoked the KCOV_REMOTE_ENABLE ioctl
happens to get interrupted and kcov_remote_start() is called, it
ultimately leads to kcov_remote_stop() NOT restoring the original
KCOV reference. So when the task exits, all registered remote KCOV
handles remain active forever.

Fix it by introducing a special kcov_mode that is assigned to the
task that owns a KCOV remote object. It makes kcov_mode_enabled()
return true and yet does not trigger coverage collection in
__sanitizer_cov_trace_pc() and write_comp_data().

Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")

---

Changes v1 -> v2:
* Replaced WRITE_ONCE() with an ordinary assignment.
* Added stable@vger.kernel.org to the Cc list.

---
 include/linux/kcov.h | 2 ++
 kernel/kcov.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index b851ba415e03..3b479a3d235a 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -21,6 +21,8 @@ enum kcov_mode {
 	KCOV_MODE_TRACE_PC = 2,
 	/* Collecting comparison operands mode. */
 	KCOV_MODE_TRACE_CMP = 3,
+	/* The process owns a KCOV remote reference. */
+	KCOV_MODE_REMOTE = 4,
 };
 
 #define KCOV_IN_CTXSW	(1 << 30)
diff --git a/kernel/kcov.c b/kernel/kcov.c
index c3124f6d5536..f0a69d402066 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -632,6 +632,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			return -EINVAL;
 		kcov->mode = mode;
 		t->kcov = kcov;
+	        t->kcov_mode = KCOV_MODE_REMOTE;
 		kcov->t = t;
 		kcov->remote = true;
 		kcov->remote_size = remote_arg->area_size;
-- 
2.45.2.627.g7a2c4fd464-goog


