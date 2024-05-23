Return-Path: <linux-kernel+bounces-186890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C278CCA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AEA282760
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9F3566A;
	Thu, 23 May 2024 01:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQm0MiVg"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CB625
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428756; cv=none; b=fefbF7ZsJahE6S6q/TqdiN3sVP168oAXyS/B3OJo0u2M8fT3z1Nju4zS5pd6j1ttH1uBfSTkrrYCV3WiW6MewzV0odt2qCADtdzqwiaVHImq1UqBpnlkj/vxNvTZH1cqJLPgOQwx6Jkwu8xiMPF5IjtQMUpEJDbKq5mARONZasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428756; c=relaxed/simple;
	bh=eYOoMGgbzvCTJCnFKy+NrqSVjdDcHkefzuiJfYbWVKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NEBLolYt2uTGSKaVPJoKnbPKK/7khhLpKJbXDu1X0cPe4ziIWQiCo+e9J9Nu9NijxlvJ4ky5WrXqQC1NFVzddPs7jG3LsRf8xxogfU/g7ju3Nsr9osqwju9zeJKGe1Qwx7Ul/uv+qZ82YtzS7fjHuK4lML2PaquHz8AklkAUYZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQm0MiVg; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7e6ff0120a5so104835739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716428754; x=1717033554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=90S8FVGI4lULTqLMUztGMhKEB9V78n++cDdmXcmHde0=;
        b=wQm0MiVgCRZN6b5SkEUaCsdGTDFIZRNpJjGYnfQZ7GZuu6Aj6Gj1zKO49omw4Xy0/d
         pRc7Y5exAiLMDqSO03c9mwI9/gjUpujGmi/dQ74T9Ij3XmAiCVZ86KVeAStVfykzgz2T
         LyaU/7LclXkwkLn2dRXR8PGoS6cuvPGK4Z8rX22cNfKiDYh2dBE1SEbPq580hU2x49up
         pEbcMt7Twduvsvd4y/PQ/MUNNn34IMTFpZs16pXoV4UvHRYvs+A1aR0TSK94EVQ5EHzt
         tbtp5f3czh8d0jpiLb2xl46l1ysb5DL0A63pY9zsb2JkA7isy9r85xyfWSm9IWnRhTSY
         7tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716428754; x=1717033554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90S8FVGI4lULTqLMUztGMhKEB9V78n++cDdmXcmHde0=;
        b=LeCPkmE01XOlYSfiHtQGNDeRfKWvLle8RcUu9cTrAojX9r3+/64kpG93vXUZF4eBJ6
         wIo/fDkslBJnwcprL6R1u330swI0sAHibkmB9Q1ApCQSEXteNMPydXFs8NZingtpafdQ
         pviS+qMBsb++DdnHK6LxrA2qBPIAAbAkC587fc9MdVmzLCPfrDURgXRIa9tKUh+BmQZH
         QVeW7rE6c+uvke+ApSp/jRgS6gT/kNtwH0KYV4F7tBc7QDSz3hhhOPTZg/CM6EsySIDx
         sKwaBKyi+3acFyVnHw0ZVp42aYXeoT7j3mdgD8skTJOecPo5ggmq/x7n5dYxu71kf4Rr
         ul+w==
X-Gm-Message-State: AOJu0YypIozhi1mtnOvB/volbIe9fTqsrxeiAOfpv2IbqoVFC2Leclv1
	2Wqw8KRw3lNjMbd0GTfASf68q9BqvfKGBzG45DYjN04bY9qxoittMmU3hSYcj9r2UsAq0ok9ymV
	NEg==
X-Google-Smtp-Source: AGHT+IHZaJ8h6H/2ddjKrO6kfquqpPPoXurvqapCmvW0W4Aqyae7GBmlM7UVaTTLlo1kAQ3QEekyUx4uzoY=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a05:6602:3408:b0:7de:e10d:34e9 with SMTP id
 ca18e2360f4ac-7e3a0ca1247mr15866339f.4.1716428754022; Wed, 22 May 2024
 18:45:54 -0700 (PDT)
Date: Thu, 23 May 2024 01:45:38 +0000
In-Reply-To: <20240523014540.372255-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240523014540.372255-1-avagin@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523014540.372255-2-avagin@google.com>
Subject: [PATCH 1/3] seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all
 users have exited
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Andrei Vagin <avagin@google.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

SECCOMP_IOCTL_NOTIF_RECV promptly returns when a seccomp filter becomes
unused, as a filter without users can't trigger any events.

Previously, event listeners had to rely on epoll to detect when all
processes had exited.

The change is based on the 'commit 99cdb8b9a573 ("seccomp: notify about
unused filter")' which implemented (E)POLLHUP notifications.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 kernel/seccomp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index f70e031e06a8..35435e8f1035 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1466,7 +1466,7 @@ static int recv_wake_function(wait_queue_entry_t *wait, unsigned int mode, int s
 				  void *key)
 {
 	/* Avoid a wakeup if event not interesting for us. */
-	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
+	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR | EPOLLHUP)))
 		return 0;
 	return autoremove_wake_function(wait, mode, sync, key);
 }
@@ -1476,6 +1476,9 @@ static int recv_wait_event(struct seccomp_filter *filter)
 	DEFINE_WAIT_FUNC(wait, recv_wake_function);
 	int ret;
 
+	if (refcount_read(&filter->users) == 0)
+		return 0;
+
 	if (atomic_dec_if_positive(&filter->notif->requests) >= 0)
 		return 0;
 
@@ -1484,6 +1487,8 @@ static int recv_wait_event(struct seccomp_filter *filter)
 
 		if (atomic_dec_if_positive(&filter->notif->requests) >= 0)
 			break;
+		if (refcount_read(&filter->users) == 0)
+			break;
 
 		if (ret)
 			return ret;
-- 
2.45.1.288.g0e0cd299f1-goog


