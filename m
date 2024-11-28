Return-Path: <linux-kernel+bounces-424279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A659DB28D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CC7B22094
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BC1145FFF;
	Thu, 28 Nov 2024 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKOwXudE"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C213DBB6;
	Thu, 28 Nov 2024 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772435; cv=none; b=FTNJf1CDuX7y/XxyJkoc9+DOAxDtttXqNr2h68y1iCXdI+UQyyYliVQdb+BpcjJ1ZsSvhIOBijdKPC5o47lXSbSg657fOp3vbBGbFdsiJck7klviY/aetynz6yzE7nVEDPx5Jn23O5gh5fAYlXq7DdgVxniWHEp8iyJ1bKgdkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772435; c=relaxed/simple;
	bh=YN8n60PSDMwr7uU95ylj0vAul2eLak7aOtfQxBvzLIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oOCNCELRY/6xWjsr/X0gxKYLaEMQehcX5VepjtBETANkTy8CTkbSS3GsrCBp/sLvkbAGV9Jf5jEOocVLhZ3wuhVu4y12DNM2AMia8fi7yIO3OhugRatwtcAWvvYza2jOF6KqsSh34onJLIBr4tRQn0p1Uws1ARkwGVg6w2ivgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKOwXudE; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d41f721047so3621056d6.1;
        Wed, 27 Nov 2024 21:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732772432; x=1733377232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SJfkPspJ/qv6pFbs/gDVi3DrHQvIU8R6iPu/lyxW774=;
        b=HKOwXudEnnZxPBu5YqItwaYcbtLl1yrWgM6mUE5utTcbWmnCNAcac398U2dSkPwnPB
         zQpovjIN91c+r2AO9MB1rhUSCl+N20ecuz2v3Mr44ApA4ehLOqZhWA0qu/s6s9g3tHbi
         hlBce8x7cTYQ108PjMV9B92gO68n5YsUdSqzCDgJFHlk5Az5zWLfxhjAmv7DrYkFpYpZ
         1iWOQkVLyYTTr6VnWtiE6mNGMBQdJg1rbVsqFblUztZXJ2cbh3wdP9GS/oooILgewDWN
         qv+FduccilmeOFtuT5/ed0u5NryaL4XEX104LmTtEhwPUBVRIbnR7EEl0xRCQTvcpmvI
         8JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732772432; x=1733377232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJfkPspJ/qv6pFbs/gDVi3DrHQvIU8R6iPu/lyxW774=;
        b=EBshqmtXOXazojrtHQO6Q7KSLSVZR2ecyA7rTF/5xOnEMh7RZJ0OmbvCPWA0baSjrg
         a6fzeRL3Pf4goIGeMa/Ns6v5y9K+skmNuANDTkM42JE8JAiNpZPvSZsb4vL8YBL3Eiia
         uYY68b6diCwTnf3hWLmGrSjc7qCsZO3ueIeHag4ft3CIJ06Gm/98FL2RTBWWHCfIwrd9
         dXovSaaD/3xQYoZiUNr7qBUEW393L6Izg370lhZN/AsgmnbBrVvyg7Yy6pBQJe7wBwK2
         NI167XGVyx/pq7ydhRX0K1qyM2hPNvCcpKb+l6tCnKiBmHvoH1+sbBOMRfT7L991qA2B
         46KA==
X-Forwarded-Encrypted: i=1; AJvYcCWmlSHPinQ9rCrYJzb8Ha/6wTrqofrSwgy33Ss/jIT7PSVvcrKhrtbRsTjNghVw4pyiJ/1evZGPjHHgr3aIyy0=@vger.kernel.org, AJvYcCX82VEvwGQu7PXlIN4RbmI6qZg+ERw0p+EoxG1hrJ93Z/IaP8FPwV+ZNkaCmdiKILGVKTPSpRfbA8GVe/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xWKcBZA2bbv5Y7PQcx70/YUl8WVDQxqQtR1e/+PNAFPFza5e
	gI8Q+g3kADLPYl2EfEg0JoTWi/4rnKsguCERZSoPi2vyFlJB7GLz
X-Gm-Gg: ASbGncvNFZV4gKcbXsow/vPOiPYMTCZexwGpvEWqWWCAsLlVIA9jFjcgemaMIAxjm38
	RYo0T33imqpMknw49GVFTubD+Wk/sRkp2Yy7dRNCp36H9LpI4BPXA6zIvyO7jY4nuhduhdPqHNo
	cH9IS7Kq347benw+5RzeCP257AS6+WXz3JzoCZzbIVA9axXXDQwKlGDpUN9ASH32LyKEs+4m/NT
	rNGC+CuABBqTMzRt8ghDrS3eVAoApfTaSQnIj/3xilwR60eUmy4A7gLlA9UDjEeqJQnq4yJSE9i
	m6FbAhn/SRkdEflg0nRQKXAwSPuFCxYS9QpUFalW
X-Google-Smtp-Source: AGHT+IH+1jtP9enrnfOS30VjgW11fLVwljjSRsGYoMiA2+GdavbO0SE2rkj6DI0F3T2YSr7acDoATg==
X-Received: by 2002:a05:6214:767:b0:6cb:3643:3370 with SMTP id 6a1803df08f44-6d864d78d27mr84817516d6.23.1732772432624;
        Wed, 27 Nov 2024 21:40:32 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87516651esm3178996d6.17.2024.11.27.21.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 21:40:32 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB5DB1200077;
	Thu, 28 Nov 2024 00:40:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 28 Nov 2024 00:40:31 -0500
X-ME-Sender: <xms:TwJIZ99UJ4XHXShVLECiLKdD8jA3Aojhn3Dl3XSydT4uHYZpuGQXHw>
    <xme:TwJIZxuZie9MzDw1L-VSBE3f3D55IycyvpdLnbbmsdJOIATce-J1PkcrKeKs3RoLI
    BYVrJj-qXGpLh7afA>
X-ME-Received: <xmr:TwJIZ7DKaCPZCJp5ZueqFEJo9pON1dhBNO8m43SJhwNSf6txSR022TfH99Mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepudekleehjedtudfgudejvedvveeiffevveeufeet
    heeuteegjeefveelffeuteetnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorh
    hgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehojh
    gvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    eprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhies
    ghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonh
    hmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhn
    rdhmvg
X-ME-Proxy: <xmx:TwJIZxfZ2_gK1a-QzEhHmFoy5yx9xFG4Ry_882mfLU121T3dd7cRvA>
    <xmx:TwJIZyPdHcrCfiRycIB4BrePFwm2mF7wvnh8QWCmbKaVM_IvJrkcCw>
    <xmx:TwJIZzk2j5pa9zbiXth7eohIXzMIBHj-EO-qKHUMc3_TfP-e88iMpw>
    <xmx:TwJIZ8vd2laC1bn_3MsNXioXDxkpUTIcOah0XvPmyg_n3NqXrQQwpg>
    <xmx:TwJIZ0ueSSjA8804h1eTfzVpMtLkZD7KTOhJdBTc7RM8BcLhsZL318iP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 00:40:31 -0500 (EST)
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
Subject: [RFC 2/5] rust: sync: Add Lock::from_raw() for Lock<(), B>
Date: Wed, 27 Nov 2024 21:40:19 -0800
Message-Id: <20241128054022.19586-3-boqun.feng@gmail.com>
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

The KMS bindings [1] have a few bindings that require manually acquiring
specific locks before calling certain functions. At the moment though,
the only way of acquiring these locks in bindings is to simply call the
C locking functions directly - since said locks are not initialized on
the Rust side of things.

However - if we add `#[repr(C)]` to `Lock<(), B>`, then given `()` is a
ZST - `Lock<(), B>` becomes equivalent in data layout to its inner
`B::State` type. Since locks in C don't have data explicitly associated
with them anyway, we can take advantage of this to add a
`Lock::from_raw()` function that can translate a raw pointer to
`B::State` into its proper `Lock<(), B>` equivalent. This lets us simply
acquire a reference to the lock in question and work with it like it was
initialized on the Rust side of things, allowing us to use less unsafe
code to implement bindings with lock requirements.

[Boqun: Use "Link:" instead of a URL and format the commit log]

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patchwork.freedesktop.org/series/131522/ [1]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241119231146.2298971-2-lyude@redhat.com
---
 rust/kernel/sync/lock.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 41dcddac69e2..57dc2e90e504 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -96,6 +96,7 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
 ///
 /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
 /// [`Backend`] specified as the generic parameter `B`.
+#[repr(C)]
 #[pin_data]
 pub struct Lock<T: ?Sized, B: Backend> {
     /// The kernel lock object.
@@ -134,6 +135,28 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
     }
 }
 
+impl<B: Backend> Lock<(), B> {
+    /// Constructs a [`Lock`] from a raw pointer.
+    ///
+    /// This can be useful for interacting with a lock which was initialised outside of Rust.
+    ///
+    /// # Safety
+    ///
+    /// The caller promises that `ptr` points to a valid initialised instance of [`State`] during
+    /// the whole lifetime of `'a`.
+    ///
+    /// [`State`]: Backend::State
+    pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
+        // SAFETY:
+        // - By the safety contract `ptr` must point to a valid initialised instance of `B::State`
+        // - Since the lock data type is `()` which is a ZST, `state` is the only non-ZST member of
+        //   the struct
+        // - Combined with `#[repr(C)]`, this guarantees `Self` has an equivalent data layout to
+        //   `B::State`.
+        unsafe { &*ptr.cast() }
+    }
+}
+
 impl<T: ?Sized, B: Backend> Lock<T, B> {
     /// Acquires the lock and gives the caller access to the data protected by it.
     pub fn lock(&self) -> Guard<'_, T, B> {
-- 
2.39.5 (Apple Git-154)


