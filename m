Return-Path: <linux-kernel+bounces-513545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40BA34B74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856B61886234
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C421FFC5C;
	Thu, 13 Feb 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buSHgC4a"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B5200115
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466562; cv=none; b=ZmpM+WojPYOpQYCpIkcU2OPP1/zBMbAVSlaQzOISa9b5hjeGykceu4um45VplQ09e8ulRNci9Okn4rQ7uAzZsVa+cv0vvcfaCsrU86WwRfq64ORDa7COzk0vU3/8Wx9YLcjse3yZXCN65AA1ugmomElYd3xMCsUpHHxeo1S9TlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466562; c=relaxed/simple;
	bh=y5FM6tAQMNQALlSwxU0i/GnC+v0z9iqKKDzyHmSz7F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPIG6xPpz8Q711b6wOp+EppGOjJq0ENE3q9fJpT+dT5Jo9Oq5afgE/FnPRQCRWUaJS1xAao3qFflUu6SA274ZxnB0/DxBTVjWsjZYx2qSgpZzdmMhf+ChzkBJSiYRz1/asg+yNXiCWNKKuXO23bUUdAsn0fzNTWGIKgq17G7A9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buSHgC4a; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso203310066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739466558; x=1740071358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nc5IWJ1qyPsINmgWoKig4MjxnUBL7Tefy6WoHZCaboU=;
        b=buSHgC4aTd4Nvmi76Rix4as/QUFxavQLlF9aYeKjuATgaYu/I/6tUQ6dpvcKrRhrEr
         PClVc5ikkaJvJWlfpdEd21TT/Rb4wVDwEclI53yxDsNACg9dzhRiNepp9oLoautva0L2
         9ay80x2PZbLaqkvbgT9IfrDaDvFKiswcqBx1pyHM2Ch9PBwe03PvydjmjiLUGv8I4LiN
         bZfa2aiuivoydNjJorCaLQVyXt2//AuxraieYJEIYEa25sap1yua+6jCSDgBm+VRR663
         ymX/UgVwMFcZifq+hnieIeU/C9mMXpw0Je6r/OeRpUFAwKhHxboZAYnhmn0mN/zEtn/K
         TxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466558; x=1740071358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nc5IWJ1qyPsINmgWoKig4MjxnUBL7Tefy6WoHZCaboU=;
        b=uUnbiClYxqV/B+EUpOT0451/Xg/uVAf8v8mMJLp4EMMqCM5/tJXK45Pr2wvPXjkOoi
         Y4TOU2qSCRdVLcEMR/S4BYTmOhSdJXfCk54Frh2hOZRlq4y9wm6tVzOL9teYugnb11Ln
         68/8as6UCzY3A0ldRgZGM6Uq5RnjcoYGtLrAldwSgdh6un7xlLuGvRc2/wQHHd5PCdyA
         Z977NDOYJjm4FdQLAxmyBWmqr+bj4e9etOCMWqKQq1yyfk4SOD9trH+9gkQkCuNWzthV
         1tlA1kEwjtQrGI1x5dxirmEK5AYbFE1KyO3sec5TVvV53st2AazQHK/ZM9/gO9rMwgza
         I1og==
X-Gm-Message-State: AOJu0YwxEhkMeypOR/ZUt76T+d8e7lh+Y44CSzF6imEIj6zPKrr/2HGA
	aKuFspKVbSETS0X8+JS1nsWKWcGqW3mJTQfJkiif2+FwxAwgSJ6n
X-Gm-Gg: ASbGnctYNFFfIegRQXeLCRlqKkQs57DT4Na9bP/fV81pkdmgVyp7EqWk7rbaMOo5s2X
	GHUK3dUkHD2tz26efObMfeMRFz/ZGQ1XIbhiCvKOW1dVz3umdjh07tLw7S9V+Dmp0dorgGuy1xA
	nyIWqwGvfFzHwNcnwbJoGD/78UTK9cZqJpdQ2xInViP+ohkDPmIz8LsZUyGx3XTuPs8An1r+zov
	XkvdpBKURJTYXTQLq14OK5MuNhK+Xe5afGIlnrD2bI3rkT7/LWZIb+0QLRjzolARnr94EzJmnqL
	L3IHsjBUKfzazHf9NnnQd72PMCShA/aXNg==
X-Google-Smtp-Source: AGHT+IEWCTz2wo77yFYcCRTneg7CKminQHiXFzAYmkGn1WyJxqCdc+HF0JboUvBzhuA9jGeI9+9ZKg==
X-Received: by 2002:a17:906:c14c:b0:ab6:362c:a8ab with SMTP id a640c23a62f3a-ab7f33f651fmr779828666b.29.1739466558231;
        Thu, 13 Feb 2025 09:09:18 -0800 (PST)
Received: from f.. (cst-prg-82-124.cust.vodafone.cz. [46.135.82.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376ad1sm167892066b.90.2025.02.13.09.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:09:17 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org
Cc: linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] seccomp: avoid the lock trip seccomp_filter_release in common case
Date: Thu, 13 Feb 2025 18:09:10 +0100
Message-ID: <20250213170911.1140187-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vast majority of threads don't have any seccomp filters, all while the
lock taken here is shared between all threads in given process and
frequently used.

Safety of the check relies on the following:
- seccomp_filter_release is only legally called for PF_EXITING threads
- SIGNAL_GROUP_EXIT is only ever set with the sighand lock held
- PF_EXITING is only ever set with the sighand lock held *or* after
  SIGNAL_GROUP_EXIT is set *or* the process is single-threaded
- seccomp_sync_threads holds the sighand lock and skips all threads if
  SIGNAL_GROUP_EXIT is set, PF_EXITING threads if not

Resulting reduction of contention gives me a 5% boost in a
microbenchmark spawning and killing threads within the same process.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

So I slept on it and did an actual analysis instead of a lazy skim,
benchmarked as well. :)

 kernel/seccomp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 0ce17c616150..41aa761c7738 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -574,6 +574,9 @@ void seccomp_filter_release(struct task_struct *tsk)
 	if (WARN_ON((tsk->flags & PF_EXITING) == 0))
 		return;
 
+	if (READ_ONCE(tsk->seccomp.filter) == NULL)
+		return;
+
 	spin_lock_irq(&tsk->sighand->siglock);
 	orig = tsk->seccomp.filter;
 	/* Detach task from its filter tree. */
@@ -599,6 +602,13 @@ static inline void seccomp_sync_threads(unsigned long flags)
 	BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
 	assert_spin_locked(&current->sighand->siglock);
 
+	/*
+	 * Don't touch any of the threads if the process is being killed.
+	 * This allows for a lockless check in seccomp_filter_release.
+	 */
+	if (current->signal->flags & SIGNAL_GROUP_EXIT)
+		return;
+
 	/* Synchronize all threads. */
 	caller = current;
 	for_each_thread(caller, thread) {
-- 
2.43.0


