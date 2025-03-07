Return-Path: <linux-kernel+bounces-552127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D05A57607
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBD218850FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26D25A2D3;
	Fri,  7 Mar 2025 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhCDMisG"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940325A2CB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390144; cv=none; b=CSRi/NNhYeTH9HruRyTXPULmHqZZnCsRHWszAkrLENN20s69ooWtaCrNMC7MiUdNobNQFio4425LU2qZPcNk/0Pu7pC6LdyXrxUaIfTzi93Fn109zL4qlEkrppMoJREgrNREIUfsrfNmFi7iM9qvDjcoGC0sm3XvojQjNCqJKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390144; c=relaxed/simple;
	bh=jn0DuQ9IMi7jCb85Jk+1q9FpJFYxx2es1I9LoBLuqIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqWRVxVdVHifiZJDHQurgbTKWFadzs4rL8Go558Sjjsdst1hspSUIYHymfHrNuGrs6LpOcNnG1gbGkHkA0Hd87QphIZfOqvHUfau9UgTGiqGF75482fqb9Bl6D4alEONEAdqCkdZCXXdGmLv8Z7PnAhuInb8FU+Jburi7iqz6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhCDMisG; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd15d03eacso23100436d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 15:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390142; x=1741994942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6oa0g1rkDvXXMBgFSGlnnbz7MDZtKGDALU7XEJAN79k=;
        b=XhCDMisGr7W1y9nkZRELMM3G4sm5XnxS0q4cUu2cMQOtBBlSB3h4OlJjSszAEHlh0L
         oZ/0XBIho4wZtawMTBng4Mt7UK8lL+M6IzvcFcTOnGtxEq/EttQkSWSHYj7SAlWLAvyq
         0JwyZossPNdLWrNypyoU+EvPT252c/Fhtuaq+NOZRgbXYhbwn4s7U3l6Z/EsXcXDze4K
         3/eJC94o0k8pAGGlavP9b7SXYS6YslTSfVwUrCEI7B8AvnzjH8Ria49UllQscjAV6o10
         d/WItC8XSa3a3EvQs5xzUVNGWUC/2Aio3B7vhOtErku0TGXKL9V/aoDtf6bTpQS8WBhB
         0okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390142; x=1741994942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oa0g1rkDvXXMBgFSGlnnbz7MDZtKGDALU7XEJAN79k=;
        b=WcRV1l1QN0No060S6d4Rir32VaKhtNtSAFS3b5qhuqd2bioBTMJ/Y6r+YkTQ2X8ESz
         JyDVUtLnYiMFQ0tugh/NOPq2K/M/64/TpsYxNcWI9bBdUi6VQyS97KFbk8YQhKhXRyF/
         zTOW9HlqAwrhNJX5KWXbFXt/FK0ta03C76rIBC7JsC4hTr2/6nR1ckgec9ywV+oqfBVc
         DUGTmp+FmDmsFavIQHVK5XQg6fySUtJmTHX+uSb4VivUUiD9eYovvUyhUlxOO/QVabqZ
         nEugxI/ZJrn8B5RWFfXotXIcONZrJpW/Ujq/c8Jo8StgC2QUgq3MKob6dVPtBYJfGOXD
         Arsg==
X-Forwarded-Encrypted: i=1; AJvYcCVuMKpXhY6iGR29qMEtxWaBEApQ/mNnTs0BnMNE2X5uqiW5dy8TzfIuJHmF3OCSIzmhmhbaIlcMDzOkzHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+NAfRqkUSx00y5qgQLV+//4kLt2X0vITZ6IB/eKDEAriSXXy
	cG/mJZ62wDJG1ZiDF4vYGVf5Zy9EwQ6dNGAGML3rM/zfa7yfj1Q8
X-Gm-Gg: ASbGnctCK0v3ctzZuFd6FBpEQp+7W+NMM6uKYJBvTRIAJoqvx+hiZXQSViGQV/jwDDC
	XfhonWEW17VQFdKao8pkeNuJPBtlr1GD83QCPI/IKuKgxa0ZTg7akxgMSO03uwR2S4grhJFi8Lm
	OtGh8BVdrlL/EakBxIvCRewanA8nX0gGvkWqJE7h+VcqPQV8umI3zYKQSboFAWEGv8Vu+jCt/82
	nS+Mpi2XtJCY9O+McRiOejNAHlArNUYsJDbzvpkka1XQ9odb/ON6BJHI11d042Pwhy0zKB5MZGE
	+9DRE5ZWIuLHQz2wQOUCkr6+oLg49woXEMavFdAzi32dxcqMV5bHYtXznBYHBHnbaA6Pu16Gow+
	F+Lni7+STA/T+gQp9tCZaHs2PvfIl2Bh+nww=
X-Google-Smtp-Source: AGHT+IEyQbV4bi3Auefqc0BIAvh/1iCfeShsZjtTfSTfrzZDVli91ksnjs3y9w+XYA4sf9RIiEZ6QQ==
X-Received: by 2002:a05:6214:ac7:b0:6e4:540b:5352 with SMTP id 6a1803df08f44-6e907d3b5e5mr24505566d6.16.1741390141707;
        Fri, 07 Mar 2025 15:29:01 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bec2sm24919316d6.6.2025.03.07.15.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:29:01 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 12056120006A;
	Fri,  7 Mar 2025 18:29:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Mar 2025 18:29:01 -0500
X-ME-Sender: <xms:PIHLZwHlF6ZGvvPJUgMO_8zpT3IgRjA6Q_srYX_IWQ65JnK0uVnuFg>
    <xme:PIHLZ5WDzXKqr076uLKegdR3YucyBDBdt00m8exyo5YUESz9bkyTSCinMe-KiQGQc
    IVO_yFBV6J5nM2rTA>
X-ME-Received: <xmr:PIHLZ6I8dQBIfMlTVzfQLhvWS1pNoOB484UygvI9OWk_X4XLOF8dpEK8mjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    hoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgv
    ughhrghtrdgtohhm
X-ME-Proxy: <xmx:PYHLZyHJnyxY563sdKWomWz2PePJDrG4X88XNgtIDONXd7j-M2ga9Q>
    <xmx:PYHLZ2UNbNMobfLf40jEmkGUHgFlle7Y29oFll9eAJ9XgdGGVPM6Xg>
    <xmx:PYHLZ1MODYm0mKwlM-sd3ZcMuEyaDV1NcHYXhBpD_c-fsl9QbJK5TA>
    <xmx:PYHLZ908j7Z34-9buehRkXUO4MAz6bljMIcgx2Q_2591616QZEbieg>
    <xmx:PYHLZ_VEGDbrYPRVWSc44rhCw0FqCGM_vrvUwUSmR2r9NBH74Duexoqt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:29:00 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH locking 04/11] locking/lock_events: Add locking events for lockdep
Date: Fri,  7 Mar 2025 15:26:54 -0800
Message-ID: <20250307232717.1759087-5-boqun.feng@gmail.com>
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

Add some lock events to the lockdep for profiling its behavior.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250213200228.1993588-3-longman@redhat.com
---
 kernel/locking/lock_events_list.h | 7 +++++++
 kernel/locking/lockdep.c          | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 80b11f194c9f..9ef9850aeebe 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -88,3 +88,10 @@ LOCK_EVENT(rtmutex_slow_acq3)	/* # of locks acquired in *block()	*/
 LOCK_EVENT(rtmutex_slow_sleep)	/* # of sleeps				*/
 LOCK_EVENT(rtmutex_slow_wake)	/* # of wakeup's			*/
 LOCK_EVENT(rtmutex_deadlock)	/* # of rt_mutex_handle_deadlock()'s	*/
+
+/*
+ * Locking events for lockdep
+ */
+LOCK_EVENT(lockdep_acquire)
+LOCK_EVENT(lockdep_lock)
+LOCK_EVENT(lockdep_nocheck)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4470680f0226..8436f017c74d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -61,6 +61,7 @@
 #include <asm/sections.h>
 
 #include "lockdep_internals.h"
+#include "lock_events.h"
 
 #include <trace/events/lock.h>
 
@@ -170,6 +171,7 @@ static struct task_struct *lockdep_selftest_task_struct;
 static int graph_lock(void)
 {
 	lockdep_lock();
+	lockevent_inc(lockdep_lock);
 	/*
 	 * Make sure that if another CPU detected a bug while
 	 * walking the graph we dont change it (while the other
@@ -5091,8 +5093,12 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (unlikely(lock->key == &__lockdep_no_track__))
 		return 0;
 
-	if (!prove_locking || lock->key == &__lockdep_no_validate__)
+	lockevent_inc(lockdep_acquire);
+
+	if (!prove_locking || lock->key == &__lockdep_no_validate__) {
 		check = 0;
+		lockevent_inc(lockdep_nocheck);
+	}
 
 	if (subclass < NR_LOCKDEP_CACHING_CLASSES)
 		class = lock->class_cache[subclass];
-- 
2.47.1


