Return-Path: <linux-kernel+bounces-527605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32317A40D3C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3643F3BED10
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353C1FC0F7;
	Sun, 23 Feb 2025 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWndDyuO"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C442BAF7;
	Sun, 23 Feb 2025 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740295287; cv=none; b=h1JpOtYrrwAoR7DJhXkX+aZ6n5tCPIezMus6Q6xpuuum8+Je/TXyYiM4CueuqudbBpYF/qvoEWawUtXR6ONzswfwxzXfksistY6Kmp2UTn9PvUMMGSRALAzN/sZ8P9oubNwAwzSVAv7WEPelQrKjqhldT1+OwNkPVYaNBwjpjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740295287; c=relaxed/simple;
	bh=3jZbuwkJgzGSSTQV5KGdMIZ3VaKpP+yPtQuraumG5QA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=merRNEIRx9p2pUERjnlt9TfKqQj8i9EKquiw2avSgP5+JxdeehogZwcIBUwL/IaxF7XchlpxlgBXqy7GwL9BQ/xW8gZSPSa4526iksMdhEbBXR4C+0WsOx1KzGTS69VQeRsVF7bVCQTOzHnyJ9rFOpQPB9V5HtyIHow6+xBsImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWndDyuO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e66b4607d2so14914756d6.3;
        Sat, 22 Feb 2025 23:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740295284; x=1740900084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4WDu3dM6wbrCY7yXYo8u+7QWo/aMwG/WBfalcegkkRA=;
        b=YWndDyuO9YHfTuOUguZvmJGvTCMtZoz0XAhKkVuPsi+sDlcylM5KOehdNUIWDCBqEC
         b70MiBILQMMJR1OY815s3diujHVqX8UxtTSNruj3clJIQecRZ/mLBLPfFq2viOo8GBg5
         m0r3OwmG6fq0Eb+1ZP9pFzVOvcEG7v+oY3p+sslFbxmfqaMMMA1KCAEYVEAe/fC85fEJ
         1L5ai59v0jX5xaUdAcFonyApt3QnZbYDJeffcI56GXlWqJzEQLtc2l8AcHvhPKX4+upc
         1YQYi8icq1Ki9mkM4OoqBjBXpojoMjjd/hq+Y3Ai3mMPPHTkiWZ0Fm/SgWoYXBruoDtS
         VlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740295284; x=1740900084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WDu3dM6wbrCY7yXYo8u+7QWo/aMwG/WBfalcegkkRA=;
        b=IURTViRc2uu4vX0Fv/s0pVuIq/hgdP2YqGBy0+tRheqW1cSJjLUfjRhBYDbBIxSh/c
         Hw2c1q9FFb0KmJAH8K8fqn7YmHe5I2aDVoy0hyRM49RzwoTn6aMZtoVxhHHeNEZzUY9R
         LXbbKhZUJyyTRO4L5FaHV/2ZKz7coWQ6KQs+YHjqp4RFGMWuKONkLhh2Bre3zOka2rKr
         rc0Tam09TA7C9ycUxZZCPwm9cHZ7Bhr4FPhsb/p2TCyGxvKwYGglEl1UjFZKZe9EjWdM
         WvxDZQ5EllcdT9R5ltUHQHx2fBQWiR1BoNNtc4oY08wCAtmDVHKkGENQtTTUgLfHc5x7
         pyMw==
X-Forwarded-Encrypted: i=1; AJvYcCVi9Qb7wsbVE8bSqdrLhvp3qLgrsSqWpvEcGgWCkmVat6rFlUBhh10FgimZpLzynW1u1nkhxndzayTcZBRuyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46GMbFJL4RJhiz/NQVHvZ085A5YsmN2fTp4LiqCbQjQR0uMAP
	Tofdb7mbR30G8FUAzKzxojd9itcUnP4F9pXfKBqoPe2CZCWU2uQh
X-Gm-Gg: ASbGncvpSlc26mcy6CjyhKJv2UBPNtdnpoyTRwCkfXrM88V3vuJSxaHNO9wpxPH7Ncw
	m+DtwUYycMRABAp/G/3M0QqgIzOpKXBDz7gDAW+PoxDhfIczYx7LVDlV/lzlQv2Ww6p4AyoMqnd
	C+CbyMxTI01H7l8OMYnLKjPf/3XVvCqLWm5n1FNCiCx5mbLQ5D9iShGMLlqhsSjU981Cg3kR6CI
	Wg7P2w8QwMG3ipcGniXzqO9E4CBm2LzzwvwFHS+r2Z86Ma7imENTcplIjae30VWQCQLZ0gqG49e
	7cvn3FmaTfO7opFfE+uE8SUucMPPDM1ePQFni0//5foTbfPlUcTROx4F2reB9H/vz3eboFks6dY
	Z5MXYqjyFL9IP4bhf
X-Google-Smtp-Source: AGHT+IG9DGA3rwxRHTD6TCcsTbXqv71BbA4XhOZj7XWRORb3wAxH5tcojO8kcnnnEiUHkXhnox27pA==
X-Received: by 2002:a05:6214:d8a:b0:6e4:3f59:56c9 with SMTP id 6a1803df08f44-6e6ae7f9799mr125688676d6.17.1740295284207;
        Sat, 22 Feb 2025 23:21:24 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0abf8a181sm690405285a.16.2025.02.22.23.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 23:21:23 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 07AAF1200043;
	Sun, 23 Feb 2025 02:21:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 23 Feb 2025 02:21:23 -0500
X-ME-Sender: <xms:csy6Z1AUOG_CrCMurDM-5yG7-hE6tI--ap593tLwttnUDQSyaAkfWg>
    <xme:csy6Zzii1h7Js3zPZaOK5aAYxYATMZkDPRG6YQFrQzfUcCaarzyPddzmszx_PLFL8
    WzRoXn0lnofELuKYw>
X-ME-Received: <xmr:csy6Zwm6IQr5AGkzPk0yIGo3yVbrAoRMpHzVW7dLjI_lLlZb7SyMXXRx9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejhedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepgeegueekgefhvedukedtveejhefhkeffveeufedu
    iedvleetledtkeehjefgieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhn
    ghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhjvggurgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:csy6Z_y3rzC6Kv29H-FTsQyVkE8Axdq93n5Fl7BrBDhgBRjKa-uAqg>
    <xmx:csy6Z6SCsfpEgPp_wBT1UVn7Q9K5_vUjREAxKIG0hLyv947h8scWow>
    <xmx:csy6ZyaUCmHq_O78wRofnMI1nH60sTCOhe3Behc8KJo_GAv97bZdQw>
    <xmx:csy6Z7TJQMzB3RGvXj7s_mt4TGXvK8TwBBl2JXVqDt6VMfcn6aG0Bg>
    <xmx:csy6Z4Bmbj8xp914wuWSM0NXSkgEoG8WmlRABIV7bifz1GV9tL0l6o3Y>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 02:21:22 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
Date: Sat, 22 Feb 2025 23:21:14 -0800
Message-Id: <20250223072114.3715-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To provide examples on usage of `Guard::lock_ref()` along with the unit
test, an "assert a lock is held by a guard" example is added.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
This depends on Alice's patch:

	https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed87899920a@google.com/

I'm also OK to fold this in if Alice thinks it's fine.

 rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 3701fac6ebf6..6d868e35b0a3 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -201,6 +201,30 @@ unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
 
 impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     /// Returns the lock that this guard originates from.
+    ///
+    /// # Examples
+    ///
+    /// The following example shows how to use [`Guard::lock_ref()`] to assert the corresponding
+    /// lock is held.
+    ///
+    /// ```
+    /// # use kernel::{new_spinlock, stack_pin_init, sync::lock::{Backend, Guard, Lock}};
+    ///
+    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
+    ///     // Address-equal means the same lock.
+    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
+    /// }
+    ///
+    /// // Creates a new lock on stack.
+    /// stack_pin_init!{
+    ///     let l = new_spinlock!(42)
+    /// }
+    ///
+    /// let g = l.lock();
+    ///
+    /// // `g` originates from `l`.
+    /// assert_held(&g, &l);
+    /// ```
     pub fn lock_ref(&self) -> &'a Lock<T, B> {
         self.lock
     }
-- 
2.39.5 (Apple Git-154)


