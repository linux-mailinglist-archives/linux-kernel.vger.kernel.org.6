Return-Path: <linux-kernel+bounces-532973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F083CA45456
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE3F3A481A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126925E456;
	Wed, 26 Feb 2025 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiQl63gJ"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E04438B;
	Wed, 26 Feb 2025 04:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740543129; cv=none; b=i/PyKu/bzEpqPtFy1GPdfpgsT/NitfhU96Q2sGit6LR7YgiGWz9hL73ya0ZQRjKfDaeAlWxiSiXmeUPZHVEccl+eICUuH7hO0Sd0oNbhNRkHSTFehErnwOeO0LKTunPX9cjiooysPHto2CVgNLDdUatA2zua9K8kiGU1mILQB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740543129; c=relaxed/simple;
	bh=jE4HozIz4OJoK9RxPIgXqTheW2YckxNd8nlJKSHOSMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YiMgKi4c0vDhxlZgv7HLu9NEozSD7hSp9YD9Pr72uEx6kWPQaYi/pgW/t5GDlPGUzPkyGrB/zeCHGsUsPy5XhncNX8I9NsWBdeW/AY4Xg6op3Zpqk+mN+ViyOeUnTIR+gRilgBdnjUQyc3cOVYHK7znE0yTLElJPdYjgUluwIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiQl63gJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c08b14baa9so580195485a.3;
        Tue, 25 Feb 2025 20:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740543126; x=1741147926; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ7k0j3DLatcrnDMeGxc15Ktcta7+QFz88V0/sLszQw=;
        b=IiQl63gJTyf3DmlYqJXVyH3sESaS0iQnsq3Gy5GFeGPcL/8muE3AgsfKjeo1j+fJXl
         31QHazyFf6fMkckscA5s8deVn+woREm0n9CQA/UTUAp5T5Xjc1E2HsvHHeUfXTY06DXY
         Ym/elbKBLBuOGuBri/mHxCVNXhETFClNbCGffiplQsl1UnmmM7RPXjs5hYaUE1TvgEb7
         r9hVdx5iLCtijI6uj+ZUTZXD2xZGvPvOUnAV9kDsV9+Sl6mNHquSRt05PMLTcIQtwB2V
         SzhrhYZE2ULKWSpIecKbYAxnlhRpRLHAOszUVGHAsK48JlZAeoF4xSFd+I+rsAdOdBdd
         ysIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740543126; x=1741147926;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZ7k0j3DLatcrnDMeGxc15Ktcta7+QFz88V0/sLszQw=;
        b=jp3u46vHW5CeFMmHBRumnSlYKkYAp4IRxARkXdoEj8c+vnCGR4dxlFvcfxqv5bTJQQ
         MgZRcbr40r9mXuopeipw0w22XS/3VU2PqHxfDnzMQWf0kZrG0wYZMi/TDndJBi42jUaT
         +wrR6C088GpsHoT7MFlQJWbMsUWjrRMqYtjUYQPeWDXVDY1SBI097d2QapJ5GrBF9jqw
         i3SwzIy19l4f5oRZ5Q0HvWknOvjd+VR8WQHDxzx56PR2qQ8D+f2Tw0No6oA+s9HIjmL6
         wYVxZ+mhFEQo7ape9JQixIw5i0603EPpm3+PnchOuKLfYZl8Q3BRhrbbsj9h6gc/EyVm
         UaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvfOh7dzf5GHAN/rvIQ1FI5XKTVVDbEbzG4yVbQNr6+H0MPEyznL7aS0z5WCzWnjGBLEHrMeUOLZxq8Ms=@vger.kernel.org, AJvYcCXchZkL4MjYzm1Df+HVI4jTWxcgVc8oyVV4KNR2BYC4Ik7dAY6WzLNjquqOl1WpWK7VwGlXJP+zcmdaqF+8kT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKN7tdacBmUCstJAMPMUhJTo7F4oqvV4LnqHUbmHnImHDVjNi
	1JLFtUpYAN1K1S7Lt9O8RiYupKeIOkzd3OiRuX2ZD/pp+17yAq3j
X-Gm-Gg: ASbGncshYdinSstlzgiap/l/zmFICCcJIGo7OqET55mFAgjys8h5Kiw05zHxhY15ZPp
	2i59tF5HyBwpYSMyfRfrqsYrWEXbpPrr17rCHIKB6ApEfMHgWr94fDX6JiCv2RPfWhNXdA5xDGY
	wabhAJnEiIo7bksEZJH2/KXtST2n7xBoO5Goc0OW+WReD0/4Gv9RKZ4oToOd2G+NvkAXGpyIp00
	uRr0okjd3YftofT6McKeUee4woOKEB2VR2eFyciebOlMRgZ/bB+b4MzvIunXsTGcrQUZqvKIHkU
	hQhigNCkzjWwhbXIIHGe269KqI+7QsGhhFhjeOUXjxGqoUuxzpoaLGxDqHH8xG9it/MPKS6uxS8
	juKurCOtOhQ8b/W1l
X-Google-Smtp-Source: AGHT+IFs8MtIbzS5E2ikOKDXRgSkM6VJLjoH49XxQv9iZB6hzt/LwkXt1vqPgLqQrZ401hrQVnyq7Q==
X-Received: by 2002:ad4:4eea:0:b0:6e1:700e:488a with SMTP id 6a1803df08f44-6e87ab6fc30mr70140206d6.22.1740543126401;
        Tue, 25 Feb 2025 20:12:06 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b19af0asm17647086d6.121.2025.02.25.20.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 20:12:05 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 265781200043;
	Tue, 25 Feb 2025 23:12:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 25 Feb 2025 23:12:05 -0500
X-ME-Sender: <xms:lZS-Z4PxGm1mZ0b35FyJjpLzuORQebyhUygNfbLKFH-EhYx2GzupOg>
    <xme:lZS-Z--iLjC3hlh3GyFjyJMQ0dIaL8x2RXCu9UWwj_iVNRVNPx2J4FpsjvVzhpBJm
    x3Mgeo2aWz9PO5Tmg>
X-ME-Received: <xmr:lZS-Z_Rx8tc_SzEGAAsnmrk-5qjnQlMUeA6PagEgITsVzViiSJ3d8vWJqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekfeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfggtggusehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepledtfeeugeefhfeutdehfedvlefhfeetvdfhtdev
    leeugedtjeejvdeiteetudfgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehr
    vgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvg
    gurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhm
    rghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:lZS-Zwspb64zqQG3_nCQlhqmwjSUTEK99c5HbyAahftHjGxh33LG5A>
    <xmx:lZS-ZwcgnMDevN8uApbAQvcCB-yLRXCzQMT-IAFmgtvTTZppaThI7A>
    <xmx:lZS-Z02JmmAO0dikeaFueVPmDUUigwURmTCqJWp8kp30RtvVTyvmgQ>
    <xmx:lZS-Z081wcQzvn6oJZECT7PUVKfOf99sY5ETmUgfj-uSo6N2LSZr9g>
    <xmx:lZS-Z395rQuEIe2jtdsqvHhExUDwtGitj26boZDWRVE92s0FNWb2Npau>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 23:12:04 -0500 (EST)
Date: Tue, 25 Feb 2025 20:12:03 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com
Cc: Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: [GIT PULL] LOCKDEP and Rust locking changes for v6.15
Message-ID: <Z76Uk1d4SHPwVD6n@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter & Ingo,

Please pull the changes of lockdep and Rust locking for v6.15 into tip.

The following changes since commit 337369f8ce9e20226402cf139c4f0d3ada7d1705:

  locking/mutex: Add MUTEX_WARN_ON() into fast path (2025-02-21 20:19:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/lockdep-for-tip.2025.02.25

for you to fetch changes up to 3b5b307cf84ca3a73abe797df31e0efe897411a9:

  rust: lockdep: Use Pin for all LockClassKey usages (2025-02-25 08:53:08 -0800)


Regards,
Boqun

----------------------------------------------------------------
Lockdep changes for v6.15:

- Fix kernel-doc for rtmutex.
- Fix lock wait context check on softirq for PREEMPT_RT.
- Disable KASAN for lockdep to improve debug kernel performance.

Miscellaneous locking changes for v6.15:

- Use wake_q for semaphore to avoid wake-up in lock critical sections.

Rust locking changes for v6.15:

- Fix the soundness issue around dynamically allocated lock class keys.
- Add CondVar::wait_interruptible_freezable() to allow freezable waits.
- Add Guard::lock_ref() to access the lock reference behind a lock
  guard.

----------------------------------------------------------------
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

Ryo Takakura (1):
      lockdep: Fix wait context check on softirq for PREEMPT_RT

Waiman Long (5):
      locking/semaphore: Use wake_q to wake up processes outside lock critical section
      locking/lock_events: Add locking events for rtmutex slow paths
      locking/lock_events: Add locking events for lockdep
      locking/lockdep: Disable KASAN instrumentation of lockdep.c
      locking/lockdep: Add kasan_check_byte() check in lock_acquire()

 include/linux/bottom_half.h       |  8 +++++
 kernel/locking/Makefile           |  3 +-
 kernel/locking/lock_events_list.h | 28 +++++++++++++++++
 kernel/locking/lockdep.c          | 17 ++++++++++-
 kernel/locking/rtmutex.c          | 29 ++++++++++++++----
 kernel/locking/rtmutex_common.h   |  4 +--
 kernel/locking/semaphore.c        | 13 +++++---
 kernel/softirq.c                  | 12 ++++++++
 rust/helpers/helpers.c            |  1 +
 rust/helpers/sync.c               | 13 ++++++++
 rust/kernel/sync.rs               | 63 ++++++++++++++++++++++++++++++++-------
 rust/kernel/sync/condvar.rs       | 28 ++++++++++++++---
 rust/kernel/sync/lock.rs          | 35 ++++++++++++++++++++--
 rust/kernel/sync/lock/global.rs   |  5 ++--
 rust/kernel/sync/poll.rs          |  2 +-
 rust/kernel/task.rs               |  2 ++
 rust/kernel/workqueue.rs          |  2 +-
 17 files changed, 231 insertions(+), 34 deletions(-)
 create mode 100644 rust/helpers/sync.c

