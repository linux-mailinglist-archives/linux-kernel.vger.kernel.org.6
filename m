Return-Path: <linux-kernel+bounces-209965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CFF903D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9BA282158
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750F17D341;
	Tue, 11 Jun 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AH+2No0V"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6F17D346
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112756; cv=none; b=MYFsg0PvAjq8SIbmJ5GBRgrwiTKNbe9T1yKu5CxMbp34l7/9YmKy9jpy3j+XrckcAMtXC21Er30rVJVnqR6PAycpHkRVcu0jxeUaUsJEIIb0u5oeUkxpPBjgnytr9yvzqMXl7fMN6PlByQpfMylEXU0P0A1hXln91ri7N1b7wEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112756; c=relaxed/simple;
	bh=AjfnKmSBKF1H0bkdDVE5AzBTFJqttfCK9emE7wy2T/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o2dK006P+4RqGpPPV4ro1k8IkGIXYXFA9PnCQ+F625J9TioL8lqfolIiMzo+/WZrNSldCgK0R1cOkyne3K/aBapGRF2sZ0J5F+Wtdq9hLFm/qDN0G/eKGpl4KUNm4TvVYEzcSk/sKhb/mMdDs8vaN7dA+7sxdDa2NMsCtF8JLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AH+2No0V; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7a6530373so10306519276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718112753; x=1718717553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CczDrlzQ7X9eqfdK0+v+uqDqKtRnCLBrcF8URyssx0A=;
        b=AH+2No0Vk+VXpBCzm+L3NbWwg/16v5i81RplCnC/VX3Pt37wmAd1ywrA3IyrQBLjgh
         q8gu8tV8jEIuLIYdsUBtICEw9znu5s3DqxRt9dZUHsPDuJVGCmRj95Im9PLkQcuuhReh
         fYlFcE7vIdyWHHkMKDas2J7fy/RExXY61WtRYrGj1bwW37mV39uFvLRi4rP4jqGNAeJf
         1V7dl6YPs05/BsDrx1nXwV4dlv3gaWVPYIYJ5elwkDoViCOy4T23OsWZ3q9GhuD7xDLL
         Wmcdsrwro96TuM3wE8xOyYJX2f6n96IZmiVnwsR+dFESxpaZ4MU1IDRFLY4FrAMAqAZU
         AYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112753; x=1718717553;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CczDrlzQ7X9eqfdK0+v+uqDqKtRnCLBrcF8URyssx0A=;
        b=Hhv45wKgoM6+Dp00Duz+EL+/hQyWDo/B+SlHbYAsRJnspcCbqFE76DGYpaa5FWPVMZ
         YgXZkyVBq+2UUxIb4yWsjZM9W4xL/MTv34mjBimWji63oqq9/Qvr1aEjzu2T1tH8k0hV
         Em8oVHeK5TFGP/owJ1fswd9PvscqNH9rOZhtahf3RXSz0ayN5d226wdBDetQUjgOOis+
         4G702l7sVkAng7up+H/J8B67DXSKWPt4ZxYNvIMrPTF5opTxlQzMD7D1INgUxqCbiNGX
         5tBsuECxSNLcw5QkgkiFYWq0Vyh+GpPiMj5VqKn4EeJTP2smbF5VZFLGleeU6T4uM0mz
         WNqg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Kcf2BnpVqy7l+jrSVemYBKj4JYNs4eTRQifrNUrSxJ3/81IM5+2k3Fx9/7GlS3qRhT/S+TFSl6PZ82/awyJq40svLPeMc3T6jP/v
X-Gm-Message-State: AOJu0Yz00BuIRlEPDjXCJ7yWypBcxUx/uk44eGAh91W0eGZdQWhWtMUy
	0M9Z0L80BfiGiC3W0jopwP8SMJ9UDhMm8NSIvtmfLgLaIShkKxGQVFDRGi0/YANYeEqYAfU0qoF
	KBw==
X-Google-Smtp-Source: AGHT+IFFhHwAThESi5lnx2MoAAXjIEDBUPhcXxjiflTxgo8L4rhg6+LIiU1xgIBisb/pLrJtZeBlk5y4vAQ=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:4221:fb00:2718:295d])
 (user=nogikh job=sendgmr) by 2002:a05:6902:1547:b0:dfb:5bd:178a with SMTP id
 3f1490d57ef6-dfd9fc66fa9mr704907276.1.1718112753540; Tue, 11 Jun 2024
 06:32:33 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611133229.527822-1-nogikh@google.com>
Subject: [PATCH] kcov: don't lose track of remote references during softirqs
From: Aleksandr Nogikh <nogikh@google.com>
To: dvyukov@google.com, andreyknvl@gmail.com, arnd@arndb.de, 
	akpm@linux-foundation.org
Cc: elver@google.com, glider@google.com, syzkaller@googlegroups.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Aleksandr Nogikh <nogikh@google.com>
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

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")
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
index c3124f6d5536..5371d3f7b5c3 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -632,6 +632,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			return -EINVAL;
 		kcov->mode = mode;
 		t->kcov = kcov;
+		WRITE_ONCE(t->kcov_mode, KCOV_MODE_REMOTE);
 		kcov->t = t;
 		kcov->remote = true;
 		kcov->remote_size = remote_arg->area_size;
-- 
2.45.2.505.gda0bf45e8d-goog


