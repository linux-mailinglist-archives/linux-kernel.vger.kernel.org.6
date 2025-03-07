Return-Path: <linux-kernel+bounces-552129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FCEA57609
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A343B57BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805EF25BACF;
	Fri,  7 Mar 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdUr/rL8"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA925A2DD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390147; cv=none; b=qx/XR1d9Hbi+h4N9H5PvCqqAwnJNAiuawqFap6WrSbbU5hLXJM37pa7rIA1YRTLQu+rc8jocLW7y9e8dDm59l2sTn91UNXWXCKsW/dm8mH/7xV3YzVeaA4QB4fJ4ULDl/nZze37fb1ujvYv/hxdYJ8q0Ddv8h4rrAduf0i0mI1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390147; c=relaxed/simple;
	bh=BhTKRjIMREwfVtTeTmz2dTeC8AQI+l9ny9QW/hOYcxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnbP5oKRJAxqZtwvYKswCm9KgS4hceoTPW+eFgHPNHfhuwDIaDc/SdwAEe6pXGmFBwpz/h+GeKL2gLIf0zrUnA2ONdYkoYHlwBd2tc3W8j+8x9PniU57Zp8xZOIi7vQGYzs9TsHQ08za/5v3iPENurwtMqZ31PU21y2zgK94GoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdUr/rL8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-475162ce281so21946291cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 15:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390145; x=1741994945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MK8683Y4U/Xs0Jj2/W+kaz45+I6ShhhE6QAy0NDqYbc=;
        b=ZdUr/rL8KzH2EP0OMXGblALsxiDXMwDRrHU2e0PVDnzidNSFh4uYCozyJvlRQcC2TW
         rXyoTePhcNxTUa5Wh5VPBVZnN+rT+72VsA+srzhlTtI7OSQQliPUSqm5YQXQJcavyyVo
         fXS/0MZzw/JPzHoKQchJx9I5w0mIZfULqiWJdZqq1QXyPdh0/JEUBWOrA4/98UacEJf1
         Jlwr2AUGhCV7AfM3d81+kSQLu1kxM5tfE8RV84FfnbfdhblufFg4HlPwCpmd52OgSRPw
         N66vwLx7sMaIjBunc5ts9FcNGtt4LiwyuwKgRvjJZRxz3tV67g+swV1Dzmg+rXhq9d+/
         y4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390145; x=1741994945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MK8683Y4U/Xs0Jj2/W+kaz45+I6ShhhE6QAy0NDqYbc=;
        b=h2E2bUju5r7pm1+1CkpT31l1IxALk4VtxQZHKA9dR8jcZGJngfEJ3wjctXusKi/CoU
         aX55DmRTm58VKtLyYkFVcgVIS5mc7wy7iMkplG6c/PvQN+//2HC0oiFH6/6j9U3vdP/z
         whyhkkFJtiivWPr8dlylz5m1OzLcBNdOHwHJJ7j/LfYSV7axnlfryry3H0ii4n0iPBeb
         +FI2N2963rmi5eLaIlVi4HcQR4CT7LkGQfFa6q658uRGqIAIeum5iBwfDZrSt7YooN7s
         7RJOJVAH/1AxDNqcsoXV0sgdDaNqQ9hs+vgCKSK6ef/gaN61CzDXWW9s2eBqrlueOAxA
         Xxog==
X-Forwarded-Encrypted: i=1; AJvYcCUZr6ZyoAvmk0D5koA67NLUh8a45ElK/fgFLAR0rxGMii6bGLq6m8h992iG23k1V4yyNQqKJvd8e9pazp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/I1Y1q5q5aZIY/A0Y5qi/ti8jXK5T35Hd7/Y+RJBDTXhkeA+f
	rZ1n4Hz5FiiGla11xvCkLoo3ktzlc80N9GuZI+g6uUIWmivARCJV
X-Gm-Gg: ASbGncvDdWEJSx1O5FkXRekAMc1tM4ITIj29YAHL8rC0U0aHpLqR0UpA4FdcyaD6lA1
	lkkVscSdPJDk0gJoroHcZYVZBWdyUsrCDubRqntl0HRMzSYGTwj7zwaeg/CpADUZUYF4z8Egwsc
	sgAvMJtVigJWBZIvzrVKFA7xALmzb3hZ8w8raf0t9ppo5StwbZdk7bXf0IJe5AXNdCEDFn/y4OQ
	Ln1pK/ujMnkrp9fxIF57A3vzV0u055oTNK8K+7kARhelleRlILRBhg/N3SACy02SnMpJYznZ7x0
	5Sz4/dk6EBEWIKAxk21KSgRG9lQHM5Ry2e9uDyNfuzF3p0fpleWDkhllLyt92Lzg4ChpBAPb8sE
	gYCAU0OnVit6JIdSno8YlN8Ns5DEGMO5kyus=
X-Google-Smtp-Source: AGHT+IEV33lI3dDrN5pmumJqxSqx+Wk8doSbwh33v9/lcPn3OgK8bRjrkT8IEoccoRhLK2s0fRN4aw==
X-Received: by 2002:a05:622a:348:b0:475:b03:a054 with SMTP id d75a77b69052e-476109cdc92mr57004911cf.25.1741390145189;
        Fri, 07 Mar 2025 15:29:05 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4765f877398sm5558191cf.4.2025.03.07.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:29:04 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 76F18120006A;
	Fri,  7 Mar 2025 18:29:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 07 Mar 2025 18:29:04 -0500
X-ME-Sender: <xms:QIHLZycIRMoC0cS223pk7icKLdgbf25zTFT9girY4O0lzxBZ3UVX8A>
    <xme:QIHLZ8OeNNytHMZesjdZUCKSfCo34V_BUfKOe-f-pgfWIyQQgQw1yanvca2SgyoPP
    1sjyDL14s30-4JoKQ>
X-ME-Received: <xmr:QIHLZzgjL3biF1MVaUurkVlox4FV_rS0Tflu5hfqKP4qiuinscA8rW6cUi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvg
    hlvhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnughrvgihkhhnvhhlsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:QIHLZ_-6OfiSfuSU0sLj13L5Dyz7_i258Qkn9bFyLXkoraIVDWf2_w>
    <xmx:QIHLZ-t87U8owB6FnHKoDwgiAaA2UH7PADH1jQKWvJKF7RGGSg-6ww>
    <xmx:QIHLZ2Hu49npqMzDtVeo7W17YAQVKHlKZA8MOfOPk1CuW9okyc5OYQ>
    <xmx:QIHLZ9M2QeDy7coO5iww8cmpkUg7c62h4tyT-oqbba_Za3omFlLzqw>
    <xmx:QIHLZ7O2OqCOzXFi5Ri6Vf5oHa4R2GKhubAXWql-l4h75OrNK4n5eavi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:29:03 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH locking 06/11] locking/lockdep: Add kasan_check_byte() check in lock_acquire()
Date: Fri,  7 Mar 2025 15:26:56 -0800
Message-ID: <20250307232717.1759087-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307232717.1759087-1-boqun.feng@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

KASAN instrumentation of lockdep has been disabled as we don't need
KASAN to check the validity of lockdep internal data structures and
incur unnecessary performance overhead. However, the lockdep_map pointer
passed in externally may not be valid (e.g. use-after-free) and we run
the risk of using garbage data resulting in false lockdep reports.

Add kasan_check_byte() call in lock_acquire() for non kernel core data
object to catch invalid lockdep_map and print out a KASAN report before
any lockdep splat, if any.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250214195242.2480920-1-longman@redhat.com
---
 kernel/locking/lockdep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8436f017c74d..b15757e63626 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -57,6 +57,7 @@
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
 #include <linux/console.h>
+#include <linux/kasan.h>
 
 #include <asm/sections.h>
 
@@ -5830,6 +5831,14 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (!debug_locks)
 		return;
 
+	/*
+	 * As KASAN instrumentation is disabled and lock_acquire() is usually
+	 * the first lockdep call when a task tries to acquire a lock, add
+	 * kasan_check_byte() here to check for use-after-free and other
+	 * memory errors.
+	 */
+	kasan_check_byte(lock);
+
 	if (unlikely(!lockdep_enabled())) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
-- 
2.47.1


