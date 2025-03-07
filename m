Return-Path: <linux-kernel+bounces-552131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3986AA5760B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F133A3E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D825CC93;
	Fri,  7 Mar 2025 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c84TxJrF"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8744258CE9;
	Fri,  7 Mar 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390156; cv=none; b=gto6YnULPDF2Fm+zohE8iuiZ9DTazn/3PRsl7hJOupKO/dDh1DNYkZnM2vrEIHSWLgXAz3uuWYoaF5TezCcIn8GB7cPuXBGGr8wR1T/n80lEP2aTmUg3xnAuRU3yEAke+Hev+6tW772zsNXSY9owFPQduxiKKwlSV08FSVf8h6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390156; c=relaxed/simple;
	bh=Vd5EkNo9wfox14TAXRzD0lIZdPzB8y8QIV6QgguuxEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kK3sRnemlbb1owx+XTTEP31vbnhK0wwoUK9anGb66aYw+/iQkAIXr5JFrJxGlmceEy0AOww9MSlDnJDWkKeLoTTQxrmoCSUrQNOuw2fbUt3Ysm5Ip7p4KKEIIFwI1LXYXD80NfczKqH1D9oafS8ugu45c0WJEqgWdpeD+g7Kwyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c84TxJrF; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0155af484so348560585a.0;
        Fri, 07 Mar 2025 15:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390153; x=1741994953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WDEaEguToLusUNSt4i7vCjrvhnl/P8iCXD1cRcQPnHQ=;
        b=c84TxJrFfID+NkZyUNDz87jif3j8l+DCauxBjVMeN71UKr0vNrzS9IQdPNQFWUiZJh
         oMdoZN1Am8TP/ZYyMheSApZuV97Zm+tlsMBuIEGKfAtGZgrNbVx3ywdtEpNHbfz0eXFc
         2BNEHV/8IfJTowr+mGBn+47KS4SAp9A6ZbnuLroxDNCgQgK47835jCJsb7MVWXez5exo
         TXf1mTjyzUpbs3peyM9LfmZtdKn3EE/+9hcXQKYs4QNqyYLoIVFbs49UHZVC+XN18TTe
         GR5/3r/DnsOA9Oozk7TbErReF+c7LrMSdb79Vt32sRmaulpiFdm1nEp+7rblwsRvFWIM
         I+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390153; x=1741994953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDEaEguToLusUNSt4i7vCjrvhnl/P8iCXD1cRcQPnHQ=;
        b=I/kTRtUYijcm4bPIFcJR25Ibpaa4FNOXsaruk4uslsKNgDl+erYJ6LDw01cMtK1QhN
         4wJ4apnkkFRR/0D8nXz6HLBcpIzC4zCGRKt9qTTAR3F14XuV7zq59SBqFBiDe1Xgj1of
         /imNfHTR9wmO8bOSHRkyj8iT5mZ2cPY5I4j1qnXNHQVxsz1eh/B0CU02no6aUtSvd3Yq
         2BNEt1FerikIyg10DptjpcCHaMCV+5ulM49L47TqrFSnNaG2zh/20n+GIj9V1vW3fksr
         1BVjP0E0tHlTm2VgXMoou4/fKg65XwN7BNMS4JzejkdOQbKxee7c79sUikcuL1tJOj4h
         gnDw==
X-Forwarded-Encrypted: i=1; AJvYcCVV2HKhcvbJuD+kBXCxAA8X/xZIy/WP0qYonsdxbMt2f3ERBzCDr5lv67VXcDN2H7XAjaqERhEDlVdswWEU0Fc=@vger.kernel.org, AJvYcCVgPV+G3ZgzRy0daihxXqQoTSgau29O7p8O8XaXV2KbNRIt4+BjTvmVQzeh0qOQbHIjxEY0NHegqZOVfF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKo+sZBAJ3rDRDaZmYkYYluWdFkWB+wuMOTXqGAOhZEIU4mtfL
	xP8ZMc0wxTD7NJi5Z8oef6nyroYJiFF8NM75RMOoK8MjUP4hr6bQ
X-Gm-Gg: ASbGncvz6HhpnTywIZyFCKN0I04CAi3lwYR9uDXPh3SU/rmhJeMituDnfNJFXodiisz
	gaCI/PVmdYHiS5LTdhy2tjyP/xekv4KDcH34J5YCUd+zkaYEAE2q7VScDIf4qoS9QiN9ffj7gn6
	6QJgLFPy+ReYM7lc4fwOW6IvBTo0TIK5XmGDutNWgguqXM4eIiKjsHy+1yHNg8JZtlJYiAYSZnV
	Ub3CoOd4o4/2pDedcqeFr9UbTG6R/Bu+iq9OKPl05HesaCT+SllmS1ou38F0sTJvQWWgz3hoNmw
	Mw+NB1Q80PJFDlRJHeDKgoWETD/Hpdi2HFqGlMRF1JS868gb250tP2kBksOE+1lVye4ndNoUH1m
	sCmYYfhp4lqj428t5kPCtXa5ULi33pW1Q244=
X-Google-Smtp-Source: AGHT+IF5cFAvN3uCa1O+zL+UsBCYoiXQijEgtAfDlQq9ii8OhEQ4J8/m00zdHDNaRq6V+ePNWY5tCQ==
X-Received: by 2002:a05:620a:4394:b0:7c3:c406:ec07 with SMTP id af79cd13be357-7c4e61ceb7amr757627085a.45.1741390153585;
        Fri, 07 Mar 2025 15:29:13 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5389d57sm303390185a.64.2025.03.07.15.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:29:13 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id C0B9B120006A;
	Fri,  7 Mar 2025 18:29:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 07 Mar 2025 18:29:12 -0500
X-ME-Sender: <xms:SIHLZzKUD8HQ9xR18DG7YHyczyIIayq8ix9DXUt1iNuhD6puh93U8g>
    <xme:SIHLZ3Ih1XTswC7o59PE6KMdVXTg3UqOWzD7PSQofCKnZ6tqhJjO3g5RT8-6QINyd
    JjpC5wg8rJ9mnmWyw>
X-ME-Received: <xmr:SIHLZ7sBROMe13tmoH8I-TomTxmWZxgi1Ctro2s_VroVkcTTqR6WnEcmSjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrlhhitggvrhihhhhlsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:SIHLZ8YqyuTIr5eEFvL1rekBJxXQ-tYvWX6pw6jaNJLsyvQwVeIGkA>
    <xmx:SIHLZ6beTWt8NdFTDsiiAqmN6TiI16IHaGzgFHL_rYqrCbssgQDnhQ>
    <xmx:SIHLZwCNH1wwc4zAWBgD9o5RJVB_4pakc5RCk5O9Ch95bz-xhg9hjg>
    <xmx:SIHLZ4aaugDGvuQpGTYauqiL-v4rtPPzll_lxLbKpsNXn5X7mnXBfA>
    <xmx:SIHLZ-r7gKadrxo6wkaJcskV2e6dCrqFQM0yVeZecUtXj9p_vvD3H4zu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:29:12 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:RUST)
Subject: [PATCH locking 08/11] rust: sync: lock: Add an example for Guard::lock_ref()
Date: Fri,  7 Mar 2025 15:26:58 -0800
Message-ID: <20250307232717.1759087-9-boqun.feng@gmail.com>
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

To provide examples on usage of `Guard::lock_ref()` along with the unit
test, an "assert a lock is held by a guard" example is added.

[boqun: Apply feedback from Benno]

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20250223072114.3715-1-boqun.feng@gmail.com
---
 rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 8e7e6d5f61e4..f53e87d04cd2 100644
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
+    /// // Creates a new lock on the stack.
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
2.47.1


