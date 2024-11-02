Return-Path: <linux-kernel+bounces-393089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B249B9BB7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50981C211F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CCA14BF87;
	Sat,  2 Nov 2024 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DBVb4zCg"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712D1482F2
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508868; cv=none; b=FeTPA/wSOw6lAUp7t88ixU6JPXkV3cRWtP37O0Vgh14yVmi+T6XaAxQ1QaWKgxQiUqKXpSXh2ShDoYaAEAHMV4YSDbGTrrCeLZWCvRxF5STEMijYJdF5zfqnM5IzGlLeeh/6ZK+O1kk7Go38DmMJpwb7Plfw9UqzRu+00S6hGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508868; c=relaxed/simple;
	bh=nTVHqzMjxVaFGtFwKysoiZKk4YEWDQibSQdexzn6DUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgOYGE+UpQs3mTQVs/XUW7522rr7uD7D/c8WoSTi46iesA9XeyATr+HsLjHWOohzWMcehoqHasH45Jyt1FwqLbaqQxh8FahwKzvgEU6iTE1hvONI7QTaYwNRYpjIQwtUcPa0WUY0tnyHwu81Uev6iVS8JamCETVedpVR2nLmDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DBVb4zCg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso2220691b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730508866; x=1731113666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhVjl1Gry+K7A+Im8XGVxnCvKP7p4PT8RH2VXkmIRG8=;
        b=DBVb4zCg0b0m+ITRxIDBx/rBlI0npPy8CqDt8RQ6bmvcDnI9eFIGCYDubmwbOjwNME
         N1CkCFCL0iwNDR0GnsLtA71BsLhUOiXwDEfrQSOEJiKrfftTA/dZvuADhgN4eX/HCTnL
         TvMLu7zpG++b40o+W6UdRgx0IY+SPnhFmuuQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508866; x=1731113666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhVjl1Gry+K7A+Im8XGVxnCvKP7p4PT8RH2VXkmIRG8=;
        b=vPHK5YWItC2niHJALLrgiSjezaEJqkwkzhFtVT9k9LaMlBqzGl84YKmH9LB73Y3B8y
         xvltYxR4RG8JPURP+pZaJBpEWnAqvE9HKbbdU4ShCXgb9VH81IvOjUSpbL2Y2XPGERio
         QcU9IJOTsR4BKbZZA1GshtF7Ir3nXAP6Nogy0kRZbqIRUzdX3omopNH/4L1P9xdH4z5e
         IJBNkQuSOCLwgclXMK7APdLX9YbWd80RLskKRg1rLbpC7hfLkrz2dCiwqg70w7N7+K27
         K3htDQLRLdpDH3t+5WKXtibuFwP7EvW23hXhDgzyNMwthw+h7bGhirA+rqUvSKaYg/Xn
         JSsg==
X-Forwarded-Encrypted: i=1; AJvYcCU5hbdznpUNvqOgTSj1T2ZU/doiP2mz3SExSKtVdK5kJLxueJB3ztJvwLwVBU8AGKTIY+sNlmE6vofSURU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2aXuHYeQD3684AlcO9ygizQd+22rwI/c2TQAlekiKew7qHzB
	haFeruqAjm54Rvzgle1tnGtzZfB9CgPTBoDoKWF3pDwCuK0FkWlM7dAcexQwez8=
X-Google-Smtp-Source: AGHT+IGDiV9QNNnfOJtUm4iKxVFroPyJZds/ckB2iebIxmJz87BZxpGxHjbsQSGczcnmCMvwIPaMbw==
X-Received: by 2002:a05:6a00:3d11:b0:71e:4bfb:a1f9 with SMTP id d2e1a72fcca58-7206308e017mr32751796b3a.22.1730508866252;
        Fri, 01 Nov 2024 17:54:26 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc3152fesm3274549b3a.195.2024.11.01.17.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:54:25 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 5/7] eventpoll: Control irq suspension for prefer_busy_poll
Date: Sat,  2 Nov 2024 00:52:01 +0000
Message-Id: <20241102005214.32443-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241102005214.32443-1-jdamato@fastly.com>
References: <20241102005214.32443-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When events are reported to userland and prefer_busy_poll is set, irqs
are temporarily suspended using napi_suspend_irqs.

If no events are found and ep_poll would go to sleep, irq suspension is
cancelled using napi_resume_irqs.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 rfc -> v1:
   - move irq resume code from ep_free to a helper which either resumes
     IRQs or does nothing if !defined(CONFIG_NET_RX_BUSY_POLL).

 fs/eventpoll.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f9e0d9307dad..36a657594352 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -457,6 +457,8 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 		 * it back in when we have moved a socket with a valid NAPI
 		 * ID onto the ready list.
 		 */
+		if (prefer_busy_poll)
+			napi_resume_irqs(napi_id);
 		ep->napi_id = 0;
 		return false;
 	}
@@ -540,6 +542,22 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+	unsigned int napi_id = READ_ONCE(ep->napi_id);
+
+	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
+		napi_suspend_irqs(napi_id);
+}
+
+static void ep_resume_napi_irqs(struct eventpoll *ep)
+{
+	unsigned int napi_id = READ_ONCE(ep->napi_id);
+
+	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
+		napi_resume_irqs(napi_id);
+}
+
 #else
 
 static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
@@ -557,6 +575,14 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	return -EOPNOTSUPP;
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+}
+
+static void ep_resume_napi_irqs(struct eventpoll *ep)
+{
+}
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -788,6 +814,7 @@ static bool ep_refcount_dec_and_test(struct eventpoll *ep)
 
 static void ep_free(struct eventpoll *ep)
 {
+	ep_resume_napi_irqs(ep);
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
@@ -2005,8 +2032,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			 * trying again in search of more luck.
 			 */
 			res = ep_send_events(ep, events, maxevents);
-			if (res)
+			if (res) {
+				ep_suspend_napi_irqs(ep);
 				return res;
+			}
 		}
 
 		if (timed_out)
-- 
2.25.1


