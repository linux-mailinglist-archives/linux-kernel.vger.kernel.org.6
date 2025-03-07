Return-Path: <linux-kernel+bounces-552130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36C1A5760A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B791886FFA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F420925C71F;
	Fri,  7 Mar 2025 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMrxsTJz"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA225BAC8;
	Fri,  7 Mar 2025 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390150; cv=none; b=phf7sAvWkWfAGBS4TIvfVhEhEbjRq4Mkt7ZY7QYY3PXBkoY33mQhsmXDZSUI/4H6oa+19Wub5QO71MO0XBLVhZSo0+PvGXTLoPbvNxV8OFpj8brOMpVvsIgCXbhl8BIJ1V3y5ipOTKfc9rROQZrLimEJx9eC0s3109CSKT+KMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390150; c=relaxed/simple;
	bh=nl25mqOSxDqiYyUcE43CHVQwdknuB5u30lCgt3g9Sh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uqv8tNK3G4Vcoen0+tsxrIT7SPp85sZLl8u05JW8uWJUWu+/UNe0QPQaKHF7s7ggrhXFIefIwm3mgGq0p3qM5QazSH9pW8fFKHeTPCbRTwLSYLD6MUbQ3W3WYw0LpuPc+WLKpSRzNmRD/lW4dEhbd66QP/LrIY4/eOV++YuW3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMrxsTJz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso36752476d6.2;
        Fri, 07 Mar 2025 15:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390147; x=1741994947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bLQdfjh9zsl19tiH0Lw1EUrOmo9Rg9QbErOXRQYmnV0=;
        b=FMrxsTJzCo5c/QO6FRIN+NjPP0Uwozaj7ivjLMFvkisGOTYw/bDQP0TaNd4LPbpsoi
         JrSF7GpnpjRKdTIL1JslfJ8IQ0U+pfgpquxp1n6/PlYQ+Ui8r9/RwH4k0TTPPuhXGag9
         XCXbBJfBqqeKj+RuTLmOw69/sduChsIhqMwnOyUo7L32kMqb+nzNATxBNDrYLdUpFH3G
         kuCYTx+1eqkIHEXddy/DD/gsdrlT5Tij6ylpwvqgv730PjHztmyIYmT4CxXYh/UeCAGn
         J1iW3LzhNHiBE4kAonDA+2kcBVkOCrzTmawkC8uBwdALfl/obsAbeDzYXRfsgmj+kAan
         jm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390147; x=1741994947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bLQdfjh9zsl19tiH0Lw1EUrOmo9Rg9QbErOXRQYmnV0=;
        b=M0IkQgyrteiNn0oOrmulTZLLm8vlqfED3VsAJG/uMWsbypXW5/b1eQ3kPNlho4ZLH9
         5QkQAx2u9lbAGdhgXDOtyoA1rDmdqNCHQ438YTeswRhsK5ojRI1TeSBEfl3lDMYb1NzJ
         k8yTFwFpURr7QFsQYoZPzJgZwOyEOgVfcSYTjF9H2Hbkp3hnOy/hTOb5UJJ2jnzhWNwM
         ihif3P4eKdHDVVbgpcO4PTNKgpHtP0wbip5DHs7/9xmx92Y6XOdy33arjNH/TuI5KgHz
         5/L7SGQ0wYOgb4XhsxLqrZ46bfefIPTyqn6qB1UeahdwcMhOxHE2BCuj1fuAYgfc1ZQY
         QLKw==
X-Forwarded-Encrypted: i=1; AJvYcCUuWTWLRaJWCFVzSp/u1xoDGp0dHB1qERvAB5/0ro+cw3qrJCzY+QwZFaBFWdzUmWiN4yNIdD0ZeXO3k1ULHQs=@vger.kernel.org, AJvYcCV+3Je3tkf+GXIed7fKXnM7CGbqalDQoanKQnN2mD9Uo6FMYNbF5gRLaU+k2C4icE8evuHP50uo/z/ZMEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdaKjDJhJSY2muSoCoi06UKPcQqeuVT9xWTQ3+TwTHVrnQjYH
	D+Mv4I3vV6lEwx2fldfoQUxkvCf6wZaq67W4vwIymRMfbLp5VSYN
X-Gm-Gg: ASbGncuJ727CHbnfL4KlyltJth6NO22iaLCHRE4HJspJPlxE4nocFyNENLfkCcIAcFE
	GfNk7c6P9uchN+YgjpPlQmDpTCNEh+2stxNVsBeEppqMrP0g0mh/dNmYZA4weN5WMQ3Qzq68hxk
	oJngIq6myMl8r3B6Q6ZXjferaDZAY2gzVr4U3sXWdQAjXP3A/2OnKF2mEQXD4VqEUww8subymX3
	OUfmv27DeGMCXVg5+VCUAE1Ub8WQStDZ3FMtKR2oT31AICa1V1KV/xNSNpnaX9PWaFSRkvAzqIO
	mN6yHwoNKg+z6bDzvoTzwsebcQERlP6nIDboZMXmFw8BylAP21uJ7TaXEkvoE7Q7sPoM1DqrVkJ
	9CSlTZ+duUKXHDKPdCJJpra7R8eycyCQwEHM=
X-Google-Smtp-Source: AGHT+IGkHwsbUOOaEjNaBUuQ4z6z/Udf2U+2u0ei1UzbhAqrpyOYvd2Rgzfu4BsSO6u23VxJbRKXww==
X-Received: by 2002:a05:6214:2622:b0:6d8:8466:d205 with SMTP id 6a1803df08f44-6e9006049c1mr51710416d6.6.1741390146944;
        Fri, 07 Mar 2025 15:29:06 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b718sm24714966d6.91.2025.03.07.15.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:29:06 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1E642120006A;
	Fri,  7 Mar 2025 18:29:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 07 Mar 2025 18:29:06 -0500
X-ME-Sender: <xms:QoHLZ22eU41Qon6F2EKAoh-a1CnZwpjfpG60OQSbQSGPYFzj-tAyPA>
    <xme:QoHLZ5F-YicAq9rK71BlMPISxQQIDewoeLkppa6_YOWcH58YaCH4_nErxc-0u8ey1
    uODW6bIAl13AKHpCQ>
X-ME-Received: <xmr:QoHLZ-6BsqVKajCOPDBOjIXng3RmFJlE2BJGK-hHnUx_b54mW6oF4X-t8Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmvgeskhhlohgv
    nhhkrdguvghvpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:QoHLZ32SCF7k4pRwlTXIxPOpCglRGova4V3K7y5pJtJzcazfXrVeHA>
    <xmx:QoHLZ5FxwmrOwQQjY5VMKb_Rl1f3ltjCRL49Asx8iwjtjpv7imGDWg>
    <xmx:QoHLZw89ZReeKpe8SwM4OPsT3INs0A8jW5G-upCela6IqBFwzHgV-g>
    <xmx:QoHLZ-kKaKn-8Bg2jihwofDbfXQu7K3xq4l0skvRlhYBdcA68_di6Q>
    <xmx:QoHLZxHIlsDp-sVG_Zi-TNKJ5mkvExt1-k0GYn9o3fugi5rrcISxQhHw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:29:05 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>,
	Fiona Behrens <me@kloenk.dev>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:RUST)
Subject: [PATCH locking 07/11] rust: sync: Add accessor for the lock behind a given guard
Date: Fri,  7 Mar 2025 15:26:57 -0800
Message-ID: <20250307232717.1759087-8-boqun.feng@gmail.com>
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

In order to assert a particular `Guard` is associated with a particular
`Lock`, add an accessor to obtain a reference to the underlying `Lock`
of a `Guard`.

Binder needs this assertion to ensure unsafe list operations are done
with the correct lock held.

[Boqun: Capitalize the title and reword the commit log]

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250205-guard-get-lock-v2-1-ba32a8c1d5b7@google.com
---
 rust/kernel/sync/lock.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index eb80048e0110..8e7e6d5f61e4 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -199,7 +199,12 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
 // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
 unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
 
-impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
+impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
+    /// Returns the lock that this guard originates from.
+    pub fn lock_ref(&self) -> &'a Lock<T, B> {
+        self.lock
+    }
+
     pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
-- 
2.47.1


