Return-Path: <linux-kernel+bounces-247344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199D392CE40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74C01F2411C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27F18FA3E;
	Wed, 10 Jul 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZWPiFYHM"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A618F2FC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604005; cv=none; b=Easw4EsSlSsiFi0DFwYKbbuvcbn//r7+pbiWDyvQKnaaPkLju1fencASc5tn0qnuGddyj8saSx6MrDZ2jR6t0W17UDcAufFJu3rqr7Szg1EJtPW8aqpoVNQCzO8ttMU+vfB7lhDl5HOHoHv0thSNp3Xs9d2Qfn15F/IAfTU47m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604005; c=relaxed/simple;
	bh=3+9DMfYTCxGjnK/e+W8XKa3FLEaY8rQkVl7tyylyIMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aV+mIt/904Bhb2xoheAz2XCleNOjTqK2S0fXALLM2lwoHli0SkuywxXvFA5GvWQOMTTW0FJCCSlrmv3COyzMKYlhin8sLTUkyf5XiTsW9d7qmGKKc9Hip5/up2LJ7KUEBXHpjmZuYzMJ4QPXHgDk/nI55wfgSAwEWKdIrDULeSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ZWPiFYHM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-426593b99daso4541445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1720604002; x=1721208802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzeNSBzyh7QLIzCzfuneqEVx7/nkOlCs6tKZ3S/B85c=;
        b=ZWPiFYHMgh1dXUqQbdlPbEZ+gN7mwJCmBCMEmHaErmXwDXIHA3TLHpX3jqsFuHw4a2
         9qSQCHNZcPJKHxFf5GJMHVQyg9mdrK7kPJzyZm3J81dEThDk/Nk4hlWNno6gcLX6x3rA
         tSBEow6qYe99JrCVrC1Nhi9ylDywJGcCu3+s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720604002; x=1721208802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzeNSBzyh7QLIzCzfuneqEVx7/nkOlCs6tKZ3S/B85c=;
        b=tRWYqM6f/Co2R46j38pgj4MDgYeuWVEsGe3F4hy+/hygfnBGXsc6nWj8ttFp+hVSsP
         R7DGYV3X3jliY4CbQ0I7accMQoRogEC47RudresefVd84nH3Mw9CHijJIS+qT981blXR
         GkUxv9ulH5aabAsQHesoQa0aUczdHQ8D0O5MKArs+mwb1JLIIObb6ikIuWBje1rgxxhS
         jiYlxUWDLb/iK+zI9R4+aDYk5Lhye7o4WgtIUR386LvlRdmeAelC8kUrhzQTQ+a0xFr7
         UzFHUbQga3u9JhFP142GMWr+kSYYt1OUkVspk7hstXV07sYfGtWnigI3Go5OeQYG+QAe
         CXeg==
X-Forwarded-Encrypted: i=1; AJvYcCUlKVT9i49CDRjrs2xOitG2WPYBDfiu14nUlUswvIu7L2SwByBbqFrClPyDuVO/DFiA8oWrngCBMdQs799YHyWomlAM0JWIUgLtlm7I
X-Gm-Message-State: AOJu0YxQqIj0prAk6EjH1FuQfhs+qhYUru8YmIb3P9pmxKxIkeo+eWqK
	vZ50/ErRtL6VKyMTqxFmi+U6XLcNwUzSShO3Scm0tFD4OtCiMZbNzHTHuO79Ky7vBhpPD+vGO0X
	8tLw=
X-Google-Smtp-Source: AGHT+IFAxrCbKthPgF5yUWY01P3adBGwJNfKLQpHeukxHdQeDqaphx4o5novPlwU23HfZb9BgXrQug==
X-Received: by 2002:a05:600c:3b86:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-426708f1979mr35047955e9.2.1720604002571;
        Wed, 10 Jul 2024 02:33:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5a27sm73448935e9.23.2024.07.10.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:33:22 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	syzbot+6cebc1af246fe020a2f0@syzkaller.appspotmail.com,
	Daniel Vetter <daniel.vetter@intel.com>,
	stable@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/2] bcachefs: only console_trylock in bch2_print_string_as_lines
Date: Wed, 10 Jul 2024 11:31:17 +0200
Message-ID: <20240710093120.732208-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710093120.732208-1-daniel.vetter@ffwll.ch>
References: <20240710093120.732208-1-daniel.vetter@ffwll.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

console_lock is the outermost subsystem lock for a lot of subsystems,
which means get/put_user must nest within. Which means it cannot be
acquired somewhere deeply nested in other locks, and most definitely
not while holding fs locks potentially needed to resolve faults.

console_trylock is the best we can do here.

Including printk folks since even trylock feels realyl iffy here to
me.

Reported-by: syzbot+6cebc1af246fe020a2f0@syzkaller.appspotmail.com
References: https://lore.kernel.org/dri-devel/00000000000026c1ff061cd0de12@google.com/
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Fixes: a8f354284304 ("bcachefs: bch2_print_string_as_lines()")
Cc: <stable@vger.kernel.org> # v6.7+
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 fs/bcachefs/util.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index de331dec2a99..02381c653603 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -255,13 +255,14 @@ void bch2_prt_u64_base2(struct printbuf *out, u64 v)
 void bch2_print_string_as_lines(const char *prefix, const char *lines)
 {
 	const char *p;
+	int locked;
 
 	if (!lines) {
 		printk("%s (null)\n", prefix);
 		return;
 	}
 
-	console_lock();
+	locked = console_trylock();
 	while (1) {
 		p = strchrnul(lines, '\n');
 		printk("%s%.*s\n", prefix, (int) (p - lines), lines);
@@ -269,7 +270,8 @@ void bch2_print_string_as_lines(const char *prefix, const char *lines)
 			break;
 		lines = p + 1;
 	}
-	console_unlock();
+	if (locked)
+		console_unlock();
 }
 
 int bch2_save_backtrace(bch_stacktrace *stack, struct task_struct *task, unsigned skipnr,
-- 
2.45.2


