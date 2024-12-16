Return-Path: <linux-kernel+bounces-448005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB049F39C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025BE1885176
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B008120C038;
	Mon, 16 Dec 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1zLWh1U"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9D20C00B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377084; cv=none; b=VnUVwfpC0J7QwCBYi5hbViyGQPtguCxEdjflPktf+cZmo4zwisztY82Bwqo5+CxzF2nFs/jJO/lOWjxRuehJc9nZTAckXvCtQuKrqfBIyxjibAHw09+YwdHBWPb1v5IKue8dDktoPMTGVmTsWPa0C/1MTDdnFFCW6urSeoZAJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377084; c=relaxed/simple;
	bh=slEyDSyOmggj5mJJINjjr/YocKsmeusN6XkbngdxcOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XVxfHLzUBeYbnozinR5vfJni7oLIY7I0xAGOwmtakXlZ5RlAb17x5AF2xJTNa0o8DL5pNk2wYVAg1pf1qSmGr4BwENzI0fHbGMK4LyHSs2ni12UQTL0yHbMI+dYpcxQclxcYyWV5Z7nt7Prkeoqz/xz8iWcsT4zKP52YoKpViFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1zLWh1U; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9b9981f1so6675914a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377082; x=1734981882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJyEpzu4DU8rJRmq3ow3hqlNy2LMWwwp3HWnjTLdNPo=;
        b=G1zLWh1UH/CfwHm+0Ij2DjpAsoptAMaKm7hv7WFaV6EcwkIrLbnQEWiMPvN3afu7VA
         9rCE8H3PJIDq5Llbc5WxDZeHMwBMkKA6weIARvQVeoAdYmil13sM8IUGu2u6/2oqYQUN
         1S5uvbOT/CoIgu7bwBFL6QWGB1pRnPbBNWvrN4KBQqHHa6L1lHxyNNtmGAYw3h19wkTk
         T+EsMGfMvpXuVlL+b+Rv+21hRhi0LD84U5jFFDMWTx5Pa4LHYCUdAuaf0Lrw+iIanW3x
         bk9mZMOHCMvmir4CDf3QV7rTp4XsEhtI/Qcu/55Q2+yx0aHDY0WcI4JuVuyvwND2stA4
         Mxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377082; x=1734981882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJyEpzu4DU8rJRmq3ow3hqlNy2LMWwwp3HWnjTLdNPo=;
        b=LKz9soJ7iVODwWWt8Lqq+mkxM3rlXCvBKiJquzIfsTnL5ldmEvikVH7iF6n6jhfaew
         SihddWHKV+wwamYrU/9I1880DTCogJ7CblZbg6W2Y0Fz9DZjD4n3TdNpvWq+xX/DlEkY
         slKMy/W5Kpo7qnaHM5FBeBm01a+A2s89o2MHsDOCedrE+Ro1UTzoyWXNYJ4RrUQV23Y1
         sy5ptWyGTXD+QR9YGN7pulyVHWOQdqG1zpGMBY/ZAjBJCGKveqYd+tYt33+1BvE7o91p
         biyBuOIIeA3xEJDWpnSw9oss68+AWJNktc2+8F47FsR6ELMUV1lrvPrbOmT+YtMVBODE
         dDuA==
X-Forwarded-Encrypted: i=1; AJvYcCWjgTQSnOD+Dj0XzbrffB+z9nH+q2ou/2zcfoHK0m69gH2l2kgdb97mP2YjVUiMBL4qelMKUCBcEAH1iZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9RcRsfhhtfzhTG0fbO1iPAAL7bYLJL71WebiYPwK8cTFuc5k
	ZApy2Bb2k0ejWDhuyPP28s9p2gI6vwBT0DDs15/xnUPTm4+E8I8SUtyUCMjGU75YD0oAv6e95mg
	JCQ==
X-Google-Smtp-Source: AGHT+IGSC/WDrL2DnP38qBt3Yi0DRZx0zLMWebStlpO2MkkwMeYlYALEb8oRG5sXg1v7sD7oiSjMQ3XiMF4=
X-Received: from pjboi16.prod.google.com ([2002:a17:90b:3a10:b0:2e2:9021:cf53])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4a:b0:2ee:7233:4e8c
 with SMTP id 98e67ed59e1d1-2f28fb522d7mr20621018a91.8.1734377082197; Mon, 16
 Dec 2024 11:24:42 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:12 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-10-surenb@google.com>
Subject: [PATCH v6 09/16] refcount: introduce __refcount_{add|inc}_not_zero_limited
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce functions to increase refcount but with a top limit above
which they will fail to increase. Setting the limit to 0 indicates
no limit.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/refcount.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 35f039ecb272..e51a49179307 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -137,13 +137,19 @@ static inline unsigned int refcount_read(const refcount_t *r)
 }
 
 static inline __must_check __signed_wrap
-bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
+bool __refcount_add_not_zero_limited(int i, refcount_t *r, int *oldp,
+				     int limit)
 {
 	int old = refcount_read(r);
 
 	do {
 		if (!old)
 			break;
+		if (limit && old + i > limit) {
+			if (oldp)
+				*oldp = old;
+			return false;
+		}
 	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
 
 	if (oldp)
@@ -155,6 +161,12 @@ bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
 	return old;
 }
 
+static inline __must_check __signed_wrap
+bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
+{
+	return __refcount_add_not_zero_limited(i, r, oldp, 0);
+}
+
 /**
  * refcount_add_not_zero - add a value to a refcount unless it is 0
  * @i: the value to add to the refcount
@@ -213,6 +225,12 @@ static inline void refcount_add(int i, refcount_t *r)
 	__refcount_add(i, r, NULL);
 }
 
+static inline __must_check bool __refcount_inc_not_zero_limited(refcount_t *r,
+								int *oldp, int limit)
+{
+	return __refcount_add_not_zero_limited(1, r, oldp, limit);
+}
+
 static inline __must_check bool __refcount_inc_not_zero(refcount_t *r, int *oldp)
 {
 	return __refcount_add_not_zero(1, r, oldp);
-- 
2.47.1.613.gc27f4b7a9f-goog


