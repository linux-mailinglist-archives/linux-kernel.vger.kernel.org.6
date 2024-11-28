Return-Path: <linux-kernel+bounces-424282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B559DB290
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C96282395
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56E514A639;
	Thu, 28 Nov 2024 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLchBLth"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CA13C836;
	Thu, 28 Nov 2024 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772439; cv=none; b=QXmLBcPa2yV3K0CiN0LQhNI83bGUF5UBmq1FM4llfbdgsSqIgIZc5SqiR3KlJKEpqwA1Z8tPqlzlNZIZHFTNED1qlwhvWcBTkGTaFh5RVmW+ZVI31a5fQsHxQgSlsqp6dDWakMOi+nqgFN0Ch0Jf+2OSxMbAYQrud0mzesrySTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772439; c=relaxed/simple;
	bh=1irOa5iMMXRoDzCJXwveBV0OqpPr+P+ur0YtrHr68zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXruprDbZH5M3rDv7M/+09dK173zjcDLgPz6DU2ueRNdNfIsHn08/3ngXZN4ZiAcUfof+ynMxOOGHfBmtEdFzGgYDdbF0HWMPDQFKml4p2GvLVtQJuOiucu3tAuBxqUXHfkBMIOyR5gJTaepC3nm5ZaIiyAwwFvS56ZxMelhlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLchBLth; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b666215645so22428585a.0;
        Wed, 27 Nov 2024 21:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732772437; x=1733377237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qe5bljGPbBbJFGGFe8TjhBQ9K3SXU61aSYWBPYS66OQ=;
        b=WLchBLthFldz3EG2zc/VKR4/ReNkGJdcPCOHzRnPRj3CMQ+AJpITYDIZGJ8EwVssyK
         Sq8gxa2cDiloOgCXeCbnCa/Bnkc4zwHmXEfK7+S0l9NhhjZSg1FCIdqeZ+OrfW9HHd5C
         MEPm+nc1CRxN8iclSpED1cAqZGBcKYAyIPkOZBn+ycKMyMyhSnjflZgtWojh3iTiqzk+
         RTWTA6dCi3VtwB0PfY1v7qce7/2KyeIjVvWCUofnjQKd5AiyKbfbYEUl47WupA6cgOAI
         vtp5YVTbqZCmiN6dCkrpmwCrKxA+1kb7wCyAIISmwe+a3JG2iArRH2phW0EkK7FBko9z
         Nc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732772437; x=1733377237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qe5bljGPbBbJFGGFe8TjhBQ9K3SXU61aSYWBPYS66OQ=;
        b=PdG5YhLX8By8DJM9VsDVZKfybHPcU333P3y5k/ghQ9s37bzFOuXEKkwH2ta3iGeAw8
         if1UgUABifYWgSjBAdcRSBC8NtA+oWj6dATZpmZ4gpFfWIH5eVu+yuiTxBRPzUAEM2Sp
         dBWqJSNrv2zwoS6+0n6vQiKacwdSpPeSNGaa2vGq/h19o5MBV08Jofc5N60iL7HizDSf
         E76qgh4cqw6H1dBiJNIrv8n/ziEqupC/PvTyUXQmdXXr+9LdBumsA1+XU0IiEvvliCya
         q2cw7FLzkjbfoPsicRVfS0FVgLMWrXn5aCPZHKQrvUco4yBbnl/9h4bVwuWhv8lhEqUj
         CLQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0osCDmgI1bxvDCwgHg9LgjoVL47ruYB3B6XHB6GF+ZzSYvw4ohHeDL+fwFZCo0SVc+I/1RvXo+sYfjdFgOSU=@vger.kernel.org, AJvYcCUf51eDZkImZuutDzanZ9VlJrd6yCxmvrIxLyEvJ4hO4JfDHZYMj7q8SpK3U0R+ALGVez7CyGPgePCopMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXOksNEQElqVr1nw7r0h3tHyI9jL8FkMnMqnGf4gZrGbwRalBZ
	6awQywZRtvXYqYRf+ZduK65aS5RE+9lI0A4o8v2u7DCDHqTiKTqf
X-Gm-Gg: ASbGnctI0ofcNcZSsRCzegFlLNEH4pNd7Oo6Z2agDW9QxLt0bTZOqdCdgli9L3InvAH
	Fxa0mpfjfPRi86uH94sZuY1URQAL7YgeAP1M4Ad/Pb64dn1d0nAdzBVoa7BlMoPNV8wng2lL4oF
	8v5RMItsbE3mRrK4JMu7HsbjAmkuRur+xJ6y/gPVxchSsG8p0FwE3oPT+lXCNX1+pAqENzOt5el
	EzSgzJt+eM+Po9ZzcFK56MDZsYeTsgNKVQoEOSdCNvrCKC0jEVoOpet0+PhU3+Kk0VuQ6CFmVnF
	eaboWbvJNIFY2zZWF6wxY+WsK15QM4rIfRXY7Z8d
X-Google-Smtp-Source: AGHT+IF9fs3kli7JcKoMj1NEFNyoAQcN9hkYTEd2oIPST/YfiSLfaOzVILdiwnWjDfqA1wxkx2G25A==
X-Received: by 2002:a05:620a:260b:b0:7af:daa4:3564 with SMTP id af79cd13be357-7b67c460896mr893254585a.48.1732772437034;
        Wed, 27 Nov 2024 21:40:37 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849b7280sm28985085a.102.2024.11.27.21.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 21:40:36 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 316441200077;
	Thu, 28 Nov 2024 00:40:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 28 Nov 2024 00:40:36 -0500
X-ME-Sender: <xms:VAJIZzxJ4MH3XwaS7bcgWwx8IkjFRDb1tb2h3yMbwZqY2oWUbppjXg>
    <xme:VAJIZ7QykeHZD0Ha-T81OO5DRM1LS02Z3rvny88NRh8dBvaCTCLq0BiEXPG4ajinH
    J6wj_duY_XkmLPKVg>
X-ME-Received: <xmr:VAJIZ9WmsEv6e4u__7w0ArILg5jlumsw62qU8xsdXx_Ph0rVKCMFnAxTJ4h5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheel
    hfeivdegffejgfetuefgheeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgr
    nhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:VAJIZ9jSWbc6tGvYh2dv-BbO9t1daE688Va-ARMcqt3gMgq75yxXTg>
    <xmx:VAJIZ1CaELDWRpguAry1jDFw3MElQYPuiL7th-qpD4FiyPANSdZ_7g>
    <xmx:VAJIZ2IwXATDAhvrfiTft5VEjwwWB2KXXKPY2yjcSapb-E7RrP8Rjg>
    <xmx:VAJIZ0A3rrfxSZ9Q6B-Uadm1hCCBHJqOQJJjOK_71S21LGowUJ32vw>
    <xmx:VAJIZxzTgTKPD3WkufXXHpr8-Jxoy25e4vcouWgRydOiwZk_8h6ITJdu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 00:40:35 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>,
	Filipe Xavier <felipe_life@live.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 5/5] rust: sync: Add SpinLockGuard type alias
Date: Wed, 27 Nov 2024 21:40:22 -0800
Message-Id: <20241128054022.19586-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241128054022.19586-1-boqun.feng@gmail.com>
References: <20241128054022.19586-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lyude Paul <lyude@redhat.com>

A simple helper alias for code that needs to deal with Guard types returned
from SpinLocks.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241120222742.2490495-3-lyude@redhat.com
---
 rust/kernel/sync.rs               | 2 +-
 rust/kernel/sync/lock/spinlock.rs | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 2721b5c8deda..dffdaad972ce 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -17,7 +17,7 @@
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
-pub use lock::spinlock::{new_spinlock, SpinLock};
+pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
 pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 9f4d128bed98..081c0220013b 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -87,6 +87,14 @@ macro_rules! new_spinlock {
 /// A kernel `spinlock_t` lock backend.
 pub struct SpinLockBackend;
 
+/// A [`Guard`] acquired from locking a [`SpinLock`].
+///
+/// This is simply a type alias for a [`Guard`] returned from locking a [`SpinLock`]. It will unlock
+/// the [`SpinLock`] upon being dropped.
+///
+/// [`Guard`]: super::Guard
+pub type SpinLockGuard<'a, T> = super::Guard<'a, T, SpinLockBackend>;
+
 // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
 // default implementation that always calls the same locking method.
 unsafe impl super::Backend for SpinLockBackend {
-- 
2.39.5 (Apple Git-154)


