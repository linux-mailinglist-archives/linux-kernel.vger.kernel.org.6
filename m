Return-Path: <linux-kernel+bounces-260126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23693A376
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFFB1C2268E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC1156F34;
	Tue, 23 Jul 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFC6Uxh5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2F154BE8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747070; cv=none; b=pDSajK8MdcliRwttEr4kQJ/l2kGB1UaLwcfDHa1bO2k8sFEftcYssoV2EMjCl0ZSbjCSiTi1HkaRYffM0uHJ9F4Y22ZdJ69hqp/dpuSkaF5+y/yvkhEWVTxapqv0gSVCowLswy7G3pNgveJDRIjhS5sFtJngwm8T6l9TitVP/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747070; c=relaxed/simple;
	bh=zjPGRyyEZDMLmGkK31czDaTVI5gnoHj+/QGaesuptL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b52rOEqANP7UEdBMH4WgCHb5bYWzNO0kGJVLtsdP2V8kXW4GTvmoyP+dxbf0f+wPb6HVOpajLqy0Xc55pxi/lLkGYqK7PvXTfnNKCnpq2Q3AnfsfG/pgrl/xRScPBjJHY6y0w3hk5ilfOOpzNKIsAMd/4xMY+ZZgc1fiUmlcRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFC6Uxh5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42725f8a789so42915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721747066; x=1722351866; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5EI7OMT8wzZUrRDcneWMkHrOQy15Kz2ZG+1nK4iJU6s=;
        b=GFC6Uxh5VhU8TXAr1zBrcS1Hcb3bRtzTnwpZIvi37J+cG/DHmzay7UAT77QNubV7ub
         TrKVdCybXMqtl6Z356c3+rHC8CceT1mJI/yrp4zf7ImfYHyVZqUcZC+1ySFToFB63QFu
         4mBIKbr16+HyCPz5BtNeU2IlaWFMe+gJgHS/kh54N62wRBc+FKbOX9oUoQ1cSlLXXXaS
         z62wxLVBps6bQ99yrkr2zyZB53Jdgr9Tb5FUeCk6rggE5zXmuGFRdEFm5zk/Vs3pdNn8
         3DWFx/4EKNwDmwQqdtxR4aIjAr2eR1ewbCLlHimldRh4UrJzmXfO3l/BmqDzFe/BvkRr
         m3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721747066; x=1722351866;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EI7OMT8wzZUrRDcneWMkHrOQy15Kz2ZG+1nK4iJU6s=;
        b=qyM1Mv7Td8ZYOXBJHPF1pfvuPB8geNjlO04leYay5E36Y042BZ6aR6V1RxYaoXTGed
         JYPAPsMHzJzgye4VEHv5ZZGuxRGxcJhD2SBZstYymBC+pTW8Eyf5y+1D8pvCgc4Nj8yC
         Nz8LEyMyknSDby4NqQVg9yezL9JLkAMS7iHMCQabEDWrp6pj/hnCLLkCUc4NctQ1JNWm
         DmZkfLwq3lrzHJoHTJK9EAWFIWiGRDeKPELTNEix4XbgPK/gvk6paFDKG5js6BTs5Okp
         LLtNd2uprd/KVYxDAhJPPwWDkalbdCugthSGrXvksFl6SKBVnRCcIhtf4XeY3UoMqG6o
         aiNA==
X-Forwarded-Encrypted: i=1; AJvYcCUW5Nhu7D23MUpwLGoPRmxnEs1Oavjch0ROBPyLhJ7UHi3DgnkcJf2lLHkv1/IP1a1T2a9ks3Gsh1t9Tjxn6Fj/KpvaoQ9AF6DTjl9j
X-Gm-Message-State: AOJu0Yy1/yY7j5hbd0lSXXcdSK4AYfZMBZHax1cpqQ5rdDh8lLl/nGSD
	uReMnOE+BRu/vRI2ZWy4MoicsQ5iQddXTh0lM/uB8mcxDHc8J69WltFZrZT0znc02tgVKiTRit5
	iub0X5Zw=
X-Google-Smtp-Source: AGHT+IHjOntlahZUsysgrc3jB0agxSGVzop23IM0mpMgl6qJ4UpWatZ4rTprcN6Lfh9mBaw3J/nNcg==
X-Received: by 2002:a05:600c:1c98:b0:426:66a0:6df6 with SMTP id 5b1f17b1804b1-427dba6e575mr4890835e9.0.1721747065281;
        Tue, 23 Jul 2024 08:04:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:59b4:7aff:4689:5b42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868423bsm11798247f8f.14.2024.07.23.08.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 08:04:24 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 23 Jul 2024 17:03:56 +0200
Subject: [PATCH] filelock: Fix fcntl/close race recovery compat path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-fs-lock-recover-compatfix-v1-1-148096719529@google.com>
X-B4-Tracking: v=1; b=H4sIAFvGn2YC/x2MSQqAMAwAvyI5G9BWEPyKeKgx1eBSSaUI4t8tH
 mdg5oHIKhyhKx5QThIlHBnqsgBa3DEzypQZTGWaqjUWfcQt0IrKFBIrUthPd3m5kbyh0Y22sVM
 NuT+Vs/7f/fC+H7r8AGprAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev

When I wrote commit 3cad1bc01041 ("filelock: Remove locks reliably when
fcntl/close race is detected"), I missed that there are two copies of the
code I was patching: The normal version, and the version for 64-bit offsets
on 32-bit kernels.
Thanks to Greg KH for stumbling over this while doing the stable
backport...

Apply exactly the same fix to the compat path for 32-bit kernels.

Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
Cc: stable@kernel.org
Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=2563
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/locks.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index bdd94c32256f..9afb16e0683f 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2570,8 +2570,9 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 	error = do_lock_file_wait(filp, cmd, file_lock);
 
 	/*
-	 * Attempt to detect a close/fcntl race and recover by releasing the
-	 * lock that was just acquired. There is no need to do that when we're
+	 * Detect close/fcntl races and recover by zapping all POSIX locks
+	 * associated with this file and our files_struct, just like on
+	 * filp_flush(). There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
 	if (!error && file_lock->c.flc_type != F_UNLCK &&
@@ -2586,9 +2587,7 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->c.flc_type = F_UNLCK;
-			error = do_lock_file_wait(filp, cmd, file_lock);
-			WARN_ON_ONCE(error);
+			locks_remove_posix(filp, files);
 			error = -EBADF;
 		}
 	}

---
base-commit: 66ebbdfdeb093e097399b1883390079cd4c3022b
change-id: 20240723-fs-lock-recover-compatfix-cf2cbab343d1
-- 
Jann Horn <jannh@google.com>


