Return-Path: <linux-kernel+bounces-552132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4153A5760D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B623179589
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F2425A340;
	Fri,  7 Mar 2025 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0Q5qXwV"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4834259498;
	Fri,  7 Mar 2025 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390159; cv=none; b=HlNNMRwOBcICKWSeKHAbOKlJtb8TYiMr8fFaPYD/7mv8zw1qmdn4xG09XyNzXzrxy371zwHiEgimxF1OT6tMKyYP0YcacWmAxHbUi5fIg2v91dUg+efqPSoxAGXKRCkFEnLnAFWRXU2IgucJ5imrNQFCi63hZ0CmdZixUK+LSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390159; c=relaxed/simple;
	bh=wUb5rfJUOpP8/cv5OVcdeCzQYA9WpFk3XgjGRDPEQ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxB46RWFlZtHg3xlVzuy/w3oTkADmvb2MIRmTMGHEx5mcH0An20RFYG93WXW6EWtUT8lr3Px/+YPSrbEatXg87DvY/RDKmqD+h6aXvMpCIz7dSaITy5DO4KsaYLotyZzmerJmDw6uykl+qgcQYvuUD9ZXuWabTQlKI3BcREKpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0Q5qXwV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-475a77bbd8cso18531941cf.3;
        Fri, 07 Mar 2025 15:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390157; x=1741994957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tE+jSgRvh6Fy38K0jqC+l/4MCEBY1CsSIryETB5MTvY=;
        b=g0Q5qXwVIKjaBHgzklFxR0i63BDZFmtdjW/pBCtEkGSFYb62ztrmDabAbGQKOayRlm
         o5I9esGC7vYYAdmpo4q9N3g1snGgMExx5wHYuZl9GSX6R3vSNjKFnMI4ACj8VkXo+yAk
         tqSsivVuLlQNioNjLpqqs2puw+A5snoMcoeAgsD9+x32SGBY9T63iS86Rx7Np+MuCEKg
         ZjG7wgFVAJIzBxUjWpqn3uQpEAJ0cfBIr15xwReQlLbDdF5JgxXUQ7bmIzzTy/Db/drW
         oGioI48Gk6W6tXS6N5WvbrVRViIz38Qs/klU+A2BYZC4Hpi4+P1yJjWwGBxBYAvRwYzI
         7pvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390157; x=1741994957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tE+jSgRvh6Fy38K0jqC+l/4MCEBY1CsSIryETB5MTvY=;
        b=hTZty4x6FTvLUkbchCBPxDmOOcGVugI0UDsyQjYeMvszFkGkwhScX2eIr6JHJ0VAkH
         FEGB86XAownzxHOaC8XJB05I+YPhMW9xJ5hgjRYVszncvvoJYIZHrGtnXxWX4Jk8N63p
         HcI04+yEXF7gTsjR5ni9E9MpVFB6xOEkcPRYm2+n4vGppUKUmv4zHheBOU7vKYUfyPhE
         kMO9m1ObzmTHrfNjkVW2wcDGw1dAJYkRXT1Jxl7FAerg5RcTzhklLGPXXTaGkDbvM+Kz
         c8965YJDQjQUnAOedhyCU5M4g9gUOtE03m+7PJPuq+6+NjegMh92VkF5/n6rVfgwjPf8
         2cjg==
X-Forwarded-Encrypted: i=1; AJvYcCWYD3kkNbQiQq7hJc5UFlTx4pm4rxQK3ZJxztUh9ScoVA9NxGs7jwx19kBOORn6vipqQyeyd4Ekx5Twg2E=@vger.kernel.org, AJvYcCWi4UdTLDJiAPedi571ki84vlMMytJmLley3kItogZSunKpETcOz4bGL3pdLX83nek9ldo9G4B7vGVvuSN8LGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1tEsoQWXXuOiABtMQT4za3XoxDcoZb7Z/xutZNtryI2s8BMj
	dIWo4WKh9W/MUoEozPgx2F5VTZ4hsfsPE/07a86WGHO/2DXZxEJG
X-Gm-Gg: ASbGncu37jUsE2qjevMLJIVz5cPCLtUWxDjGJkoYmDtc3s3qix3ELSluLaoFxyYUbMr
	igPJ6bMK7FIGESVfOxbLD134gQJ7l80OR35xbgsdXMofeVbRrofIGcmGE681xzv92jtZyHgFaYV
	JtN13M2u7r9WC42aCZDQmCofi6tt/95G9uJRPUgZom9qmF92WSS8MwXBHXRYhgyDbHra9xNJrmx
	DYCSeaQu2xVt4FUiFz5vRZDREtDmPID3sfWosxNyaKbc8a4XLHXJ4TzSKSonOgPJ/cFZ75KDSpE
	YS8fafz9M407xO7pA17l0FsixdzpuHKVlSBe4kkBtC+rtxlhcIbAzimK7tOgxkWWW01YQT4Cx2V
	750PlqzNoB/1EG+Hdy9/mubH+EN8xF7UN8To=
X-Google-Smtp-Source: AGHT+IEgcjb0FSbQZshtsaIF+CM3DH9ikYNkpa/0oUa7AP1FXkeIPFycbNxtS6bc1jBNw+yrLcM+fQ==
X-Received: by 2002:a05:620a:268b:b0:7c0:9df3:a0cb with SMTP id af79cd13be357-7c4e61b96d5mr958372185a.53.1741390156761;
        Fri, 07 Mar 2025 15:29:16 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e54ff7a5sm302875285a.82.2025.03.07.15.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:29:16 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 00717120006A;
	Fri,  7 Mar 2025 18:29:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 07 Mar 2025 18:29:16 -0500
X-ME-Sender: <xms:S4HLZ0Px7diqinuTGQcfcEYfzybpLeXdW2EhoIW_gkI5MuzwOiYJOQ>
    <xme:S4HLZ68HzO-N-evtvGviHvJ2oP508jwSitsTyod_HosEK9KIkPQ8jwLJzLtiEKKcR
    -aA8CIs6ebbXHBPjA>
X-ME-Received: <xmr:S4HLZ7TXejdsJPsEd9oyHFKarnbcNb7AzjrQ2tCe6MVNUJsTegqZzUEtmAg>
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
    nhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsohhquhhnrdhf
    vghnghesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:S4HLZ8v77DOJVcDtzW6ac0b5j1hATfFKoubq72z75AyfxjXVSgB4BA>
    <xmx:S4HLZ8dbh2sBKe_YeXXrlj7EneYRGTxNHIek6ZPtHUqsSGKGZjgueg>
    <xmx:S4HLZw16cRONocPvZ5mBRO69o2DahjfdXtSfCjbKayK9R5o1pVN7Jw>
    <xmx:S4HLZw83knd-lFfMSIpli5r6KxExKLqnYkfWFIQFQHSPKeMO1XYoag>
    <xmx:S4HLZz-4PRPz7rZjvaK0FFAWqgoBQa2Pkv0S1tbtW1Rl6szM0UKbqg0X>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:29:15 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org (open list:RUST)
Subject: [PATCH locking 09/11] rust: sync: condvar: Add wait_interruptible_freezable()
Date: Fri,  7 Mar 2025 15:26:59 -0800
Message-ID: <20250307232717.1759087-10-boqun.feng@gmail.com>
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

From: Alice Ryhl <aliceryhl@google.com>

To support waiting for a `CondVar` as a freezable process, add a
wait_interruptible_freezable() function.

Binder needs this function in the appropriate places to freeze a process
where some of its threads are blocked on the Binder driver.

[Boqun: Capitalize the title, reword the commit log and rephrase the
function doc comment with the impersonal style to align with rest of the
file]

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250204-condvar-freeze-v2-1-804483096260@google.com
---
 rust/kernel/sync/condvar.rs | 23 ++++++++++++++++++++++-
 rust/kernel/task.rs         |  2 ++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 7df565038d7d..5c1e546a26c3 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -11,7 +11,9 @@
     init::PinInit,
     pin_init,
     str::CStr,
-    task::{MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE},
+    task::{
+        MAX_SCHEDULE_TIMEOUT, TASK_FREEZABLE, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE,
+    },
     time::Jiffies,
     types::Opaque,
 };
@@ -159,6 +161,25 @@ pub fn wait_interruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T,
         crate::current!().signal_pending()
     }
 
+    /// Releases the lock and waits for a notification in interruptible and freezable mode.
+    ///
+    /// The process is allowed to be frozen during this sleep. No lock should be held when calling
+    /// this function, and there is a lockdep assertion for this. Freezing a task that holds a lock
+    /// can trivially deadlock vs another task that needs that lock to complete before it too can
+    /// hit freezable.
+    #[must_use = "wait_interruptible_freezable returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait_interruptible_freezable<T: ?Sized, B: Backend>(
+        &self,
+        guard: &mut Guard<'_, T, B>,
+    ) -> bool {
+        self.wait_internal(
+            TASK_INTERRUPTIBLE | TASK_FREEZABLE,
+            guard,
+            MAX_SCHEDULE_TIMEOUT,
+        );
+        crate::current!().signal_pending()
+    }
+
     /// Releases the lock and waits for a notification in interruptible mode.
     ///
     /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 07bc22a7645c..ea43a3b8d9c5 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -23,6 +23,8 @@
 pub const TASK_INTERRUPTIBLE: c_int = bindings::TASK_INTERRUPTIBLE as c_int;
 /// Bitmask for tasks that are sleeping in an uninterruptible state.
 pub const TASK_UNINTERRUPTIBLE: c_int = bindings::TASK_UNINTERRUPTIBLE as c_int;
+/// Bitmask for tasks that are sleeping in a freezable state.
+pub const TASK_FREEZABLE: c_int = bindings::TASK_FREEZABLE as c_int;
 /// Convenience constant for waking up tasks regardless of whether they are in interruptible or
 /// uninterruptible sleep.
 pub const TASK_NORMAL: c_uint = bindings::TASK_NORMAL as c_uint;
-- 
2.47.1


