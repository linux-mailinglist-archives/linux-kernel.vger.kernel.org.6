Return-Path: <linux-kernel+bounces-510297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB9A31ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118351888D77
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0717996;
	Wed, 12 Feb 2025 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YQuBBhdX"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887C1CF96
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321518; cv=none; b=jJHIW8gWOAi7teAjXt+mRkb46hOLJ5+uk/6rox3Mgo8GdCQU9S8t5alZSksB58+9rrC4OfheOOu+ilDKr1Wq4HW5XOZe+AAzHWZgLMGF9aYhPz+O/q53Z3fmg5cDayVAmvK2XWmR/uifz0qIryQwD241e6Xwu0NWWfm5YxZqmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321518; c=relaxed/simple;
	bh=uybylxy3CxWXbqjZP/G8qtq9yh04SBEkS6ZcbdxAOJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MADy9llYN2903KM6Yp4ibJl/wQAmEXJTcLrQ2xflW2zU0ya18Tesa93c6881YYgc4sAOfxIgsjZmSwd+ZsC6RLWge1QzakAsZQXh+e4jjEnoRKSohQPY6YjPNud2cR63cD1ndBn3aQOi38FAu60a2c+zW/EGy+r8WfmetZDB/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YQuBBhdX; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3d142933f32so1336385ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739321514; x=1739926314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxjIUJ0LCGQtTFpUNlyNV0SkSCoelxvdgjl3lNP3O8Q=;
        b=YQuBBhdXtlhiMYbjNudL7nmHpca/Y0mTj4OVMAt8jhZ3lunmcaFqjmt5+N+ARepVb4
         /HbwefJrySa8AAehPF5SYyd8bvsey+j2f1+d6GmbEQ2FEW7TmmjlD53u2vJZ+UPOB/2s
         TixUWP++afQFjuKjiWUenY5QHxzXx8YN8R3rtmLmD+zuw3WhALLMrPnWj8wSajvnSG1m
         RXx2BaGw9x3Z0DkZ61EBMkiH5UlY1pmDezcky/onvd48YJM2hvidVkJ0wvShTLpDnMix
         fHHzMVo0EO+ZyyN5Mz/L4Z+1cqGJj7GVgdB3sMAePo8QjZAzRz6Zwcn8V8wk7xawEEaQ
         UpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739321514; x=1739926314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxjIUJ0LCGQtTFpUNlyNV0SkSCoelxvdgjl3lNP3O8Q=;
        b=P+qtGtjDpRl7DR1NRYFEwMyqsX7MZwWK7FCjIbSI4M5lKswVDVVHFmMGJ+38VM4ckh
         5fd/2vZptRf/pF5VD2Xk5+OV1+xjZjRzOuql0lmPZvLK1XCOrlzXR3bbc2FoiI9p9b9B
         UKuo92+TBl6yO9EKW2a4rg4sZ5woRdtqIBqJ0FLNxV4FvkJvr1/AkqdpAfp49zPOUPLK
         MLy8MWCDUICWrASGTbE0RO15sGsI5lz/7NT9LbVuZ326Ftlm+F7fyQb8MjluY7ULeRAz
         NKea87cbgbdIxPViTMG9Pk7SM76PgHuRqJtNyLl9H5e72ZLZm8W3vRgeyI8h+gNIhydq
         QIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGwqsK2R7r56dHvT0DRrv57UsJ4ywI85QCOB6WcZooex9EV7JCTYm/RkMQ7dJv2ou1dj/k4u65wUMRQgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbT2XHKm/Fip83TdSyKzPVHBdPTwgRdIbMnokxGTj2qzJeYA7m
	xOGa3kN76G0Hezz+aYI1OltY+rSNfqUxdx3C1Z1d9dxDK/QHQcED7DWgnK1BgGXjhTJxQT3iU9I
	j8oM7aDn2RabtyFKmZK3dCC6YGRctyk50XQ2MN5tgbFwXHpEe
X-Gm-Gg: ASbGncsmJNWlzbGvxjv4j+42QjiKC9Q07thgeC01KZUPeCwnqBKKysWRuqkJhkBbRLs
	/xCWtaMXD8DSbk/WvnduLdr8t1F3fCuW4d9JHMZXqxayF1Ob7KFVk0kHHsLFNORGtiUbw5x+qmN
	CDwqEwHEkeya/swy/HVQs01kr0jVxLYUQuUUUEr3rO/hCgiXxCZUL1vEplpRMfRKK2EXMHowCjg
	sD8nvEkVUapMilx86B02+FpNXIldMtrOUurgnsn2GkjGDjpaih6JPVOZH5NcuuY6PqAmXrufCHb
	q8y/q+nLL2EUK5qo8nZOtd4=
X-Google-Smtp-Source: AGHT+IHYpDUM5IoG8Gefvs4nmEzKc+3MUcQyKzvpDeSdd4lhbhbGh2EnHmPFJjw+Kv8PFBLmrPRm+a/xUBfZ
X-Received: by 2002:a05:6e02:1d9a:b0:3d0:13f1:b47c with SMTP id e9e14a558f8ab-3d17c2155e0mr3318165ab.4.1739321514520;
        Tue, 11 Feb 2025 16:51:54 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d16133e8f5sm3111825ab.69.2025.02.11.16.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:51:54 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 715553400C7;
	Tue, 11 Feb 2025 17:51:53 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 685E6E40C16; Tue, 11 Feb 2025 17:51:23 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: use lockless_cq flag in io_req_complete_post()
Date: Tue, 11 Feb 2025 17:51:18 -0700
Message-ID: <20250212005119.3433005-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring_create() computes ctx->lockless_cq as:
ctx->task_complete || (ctx->flags & IORING_SETUP_IOPOLL)

So use it to simplify that expression in io_req_complete_post().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ec98a0ec6f34..0bd94599df81 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -897,11 +897,11 @@ static void io_req_complete_post(struct io_kiocb *req, unsigned issue_flags)
 
 	/*
 	 * Handle special CQ sync cases via task_work. DEFER_TASKRUN requires
 	 * the submitter task context, IOPOLL protects with uring_lock.
 	 */
-	if (ctx->task_complete || (ctx->flags & IORING_SETUP_IOPOLL)) {
+	if (ctx->lockless_cq) {
 		req->io_task_work.func = io_req_task_complete;
 		io_req_task_work_add(req);
 		return;
 	}
 
-- 
2.45.2


