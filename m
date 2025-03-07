Return-Path: <linux-kernel+bounces-552123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B43AA57602
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812FB7A8215
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB78725A2DA;
	Fri,  7 Mar 2025 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKL1ojrp"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44F259498;
	Fri,  7 Mar 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390114; cv=none; b=UyvaC342cbuSep0I5FupXL/MpZjSpAq2ZB/R7df0tYO+5dWHAnvgIaiktQE2b6lRpkhiq8Dw6LufGvSZAvgI0WQocVNLAxf5Rax/3ecilbmVU6GMo2AWu7cLG+yFpry7bNfHkUHtwSkGsjBn3ckExJAjVqBUZuSP654Bix4a6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390114; c=relaxed/simple;
	bh=jEhBkZo52HWmfzIFIG4+10NzNIICT1wwexEgxCTK2Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ckxmqwc0kV8chBnQ5J2sJkreQzAE6MEHPSUyyJz4oyoAAkewg5/0Pu23yO4/jtbLbSVbBX77WTIXj5QPT+nnVXCowm0XmVrk5bO58gWyvgKrxTkqGJIfDCQb+Hsd3g7b9qf0MlCojzcJEsGPWQy5ZzS9cn1ysCvb/vZ3mzpJvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKL1ojrp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8fb8ad525so18975106d6.3;
        Fri, 07 Mar 2025 15:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390110; x=1741994910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cagYFPBuc1gFFptIWVE+jBCNUlwRXwa3KtuVxW66haM=;
        b=eKL1ojrpOZhmG8vq1qzexlTwLYhV1l3PxYoVCThXQIjl0CRdQn95aRdFZ2Brda9jjW
         SkKjwXptxAMsKu0gn0LMj6GLEHlKDjGgHGuE2rN7LbS3XevXy8v1O/9NOCV7ct7yYd68
         dVEY/UjfR+zatOyq/t/OT6a2b0j9QGzwExf0yUZ+fNjY6wIvm7rnSB5fLqZ/GnFesiCR
         GdJvAy9VhcEUZPyBd1bxLaPgk8x7iJw2ur4kO3wZnn169uU7I2JvRxs256h8D51PD7+D
         dAZz0Rp7YxaWXfttV8h6GNRSVtcGCxpnE3mrWaYQg5p+H5H5T4i7iCCmW/SRtHgJAT1Z
         Odvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390110; x=1741994910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cagYFPBuc1gFFptIWVE+jBCNUlwRXwa3KtuVxW66haM=;
        b=gIoRK0FarzH7v+YFLCrq3oS5rOpuYbfY7T/0F13e6AbE6W43T8deDYTpwJxCA4wZo2
         MyTNRNNhI7Rfwj3vlkrsl4GFlBpiwFs18ZSeD1LHps0t4hgUYjFIAaTzCvnZS469E83T
         AxkQ51jlmOnmUDqypOiUsdR3I6CHzdkQrDg7w0FeFaiHL7x77MIpN3l38rdJhKcK6wwl
         0bvLMJ8D3mfyC2oJmdv9ZTe6eaEqyTx9Inu2kwcd/y3qo+6sqg6QQGvMGlmE2bpNkgX4
         WnPysJ4IBU1c8Pg9+aGesAms53MuqueTtG9qUdQgxtT6BR8rW4bjtdYY0v3jj8pwW2WV
         FcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMUS48zp5wNXMIwWTX8CQBdEXsW+f23l4AvzbDw7w2v5MGAguWPvy4us1dNOx8sy5SJ9HWDNiPceLfArc=@vger.kernel.org, AJvYcCXJAyiPk4sRmwccCkIdgIaIcAYmQ1VIpG/1LUJ1YCqRNXJ8Pl1J2xEEP3MSiMYbFs3jKZzWJuBDf6X8SUB+Hi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1Yu/+Io91409rZ4rN0A+dwyDLx9bMZLZU3YhptqIfDRE393U
	jGK8RfV+Jt8WDH/HZZusxORAz3W6KIB1r50vcluaf8d3WB41YjkW
X-Gm-Gg: ASbGncvLv74OD/3nj2rykCvI/r1p/AfxrDyYWya8QTu7zsoctz181u2tHMGnod+fiMU
	XeUyb4zs6CrqIFG5Ei6MFgyXdKMju4evcWe3ijec4tQ/dfVlfyFz7MMsxfI+T/YcH9d1sny1lEz
	ECHzxhRHIC2W/lm9J7B7vC/d6UWnrTmBq7AJF49e9zlXBSUDmbmOE7wl7XFPiuhAGLtC7MacYDs
	BjhP4ZY33XPapkjZSbByucbjyfswah1e/TrZ81dnBXclkjZu2yjKv2f1NRnvu3hLF7NWnPedhVX
	qCxQ9coKlVlwEFtwMcUo/2qc56o206cr0/zd95LWPd29RYmY3rQWaqjvWJ//Og7slUKP37X0BQg
	8LawU7Wm8zSD+grIFC12i+//vn932A8EBNQE=
X-Google-Smtp-Source: AGHT+IFw0P86UbgQ02WPOSx8uxArdpOUWxMPUJ07cDAjcZ8JIfwxGwSbuwH4Wcl0OCabjWiBvknuOA==
X-Received: by 2002:ad4:5ce8:0:b0:6e6:68d6:3932 with SMTP id 6a1803df08f44-6e900693f6amr58038346d6.40.1741390110148;
        Fri, 07 Mar 2025 15:28:30 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b6c1sm24652376d6.83.2025.03.07.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:28:29 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3290F120006A;
	Fri,  7 Mar 2025 18:28:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 07 Mar 2025 18:28:29 -0500
X-ME-Sender: <xms:HYHLZ6w7PJuV36mNq3cERftzGPA1M2D4UTgxF2HdmEDg6P60-3EHXw>
    <xme:HYHLZ2QMyKjcipHgMEUwEGMuZ2ryBkABbQ0h205E_05ufX6vDfylAo22r04zzM-is
    RwwnceemPRjCJ7FoQ>
X-ME-Received: <xmr:HYHLZ8V237Nhyvz0y6zOIYbqaAwYzaa6TkClFgfmB-voAhVH7wOr45JuFSM>
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
    nhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:HYHLZwj8WfOnBEhH6Yuvsa-HU8SPDgYZs70RAoecWIfgnqezJqpyxw>
    <xmx:HYHLZ8BDY_kADWX-Drd7YUQqZ4Pdv78LwelmCnCWAZwBRYuJuyxLBQ>
    <xmx:HYHLZxL1CNRAPYljwFksDKW_HtSprfuUhQ_wba2IZpytxobsSuS8rg>
    <xmx:HYHLZzAWNE-UDS3OJOXOUGp1QQo0Ft1Ku7wmEDmXO0xU4bVNzIk-EQ>
    <xmx:HYHLZ0xfDaLLjR7ZJB2p8bF4kuMfTQ2niF6gjwhLUhgO6n-iYy1eMC4Z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:28:28 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:RUST:Keyword:\b(?i:rust)\b)
Subject: [PATCH locking 00/11] LOCKDEP and Rust locking changes for v6.15
Date: Fri,  7 Mar 2025 15:26:50 -0800
Message-ID: <20250307232717.1759087-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Z76Uk1d4SHPwVD6n@Mac.home>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ingo & Peter,

As discussed, I'm resending the pull request for lockdep and Rust
locking for v6.15 in the format of email patches. I dropped one patch
and will postpone it for v6.16 because of a bug [1], and I think the fix
[2] needs more reviews.

[1]: https://lore.kernel.org/lkml/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/
[2]: https://lore.kernel.org/lkml/Z8t8imzJVhWyDvhC@boqun-archlinux/

Regards,
Boqun

Alice Ryhl (2):
  rust: sync: Add accessor for the lock behind a given guard
  rust: sync: condvar: Add wait_interruptible_freezable()

Boqun Feng (1):
  rust: sync: lock: Add an example for Guard::lock_ref()

Mitchell Levy (2):
  rust: lockdep: Remove support for dynamically allocated LockClassKeys
  rust: lockdep: Use Pin for all LockClassKey usages

Randy Dunlap (1):
  locking/rtmutex: Use struct keyword in kernel-doc comment

Waiman Long (5):
  locking/semaphore: Use wake_q to wake up processes outside lock
    critical section
  locking/lock_events: Add locking events for rtmutex slow paths
  locking/lock_events: Add locking events for lockdep
  locking/lockdep: Disable KASAN instrumentation of lockdep.c
  locking/lockdep: Add kasan_check_byte() check in lock_acquire()

 kernel/locking/Makefile           |  3 +-
 kernel/locking/lock_events_list.h | 28 ++++++++++++++
 kernel/locking/lockdep.c          | 17 ++++++++-
 kernel/locking/rtmutex.c          | 29 +++++++++++---
 kernel/locking/rtmutex_common.h   |  4 +-
 kernel/locking/semaphore.c        | 13 +++++--
 rust/helpers/helpers.c            |  1 +
 rust/helpers/sync.c               | 13 +++++++
 rust/kernel/sync.rs               | 63 ++++++++++++++++++++++++++-----
 rust/kernel/sync/condvar.rs       | 28 ++++++++++++--
 rust/kernel/sync/lock.rs          | 35 +++++++++++++++--
 rust/kernel/sync/lock/global.rs   |  5 ++-
 rust/kernel/sync/poll.rs          |  2 +-
 rust/kernel/task.rs               |  2 +
 rust/kernel/workqueue.rs          |  2 +-
 15 files changed, 211 insertions(+), 34 deletions(-)
 create mode 100644 rust/helpers/sync.c

-- 
2.47.1


