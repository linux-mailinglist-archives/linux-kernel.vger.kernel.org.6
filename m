Return-Path: <linux-kernel+bounces-346161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D6E98C088
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB32283A70
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EFE1C9B77;
	Tue,  1 Oct 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/FcWL21"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736F1C6F73;
	Tue,  1 Oct 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793807; cv=none; b=CqqvCrxJ1n45zUpEegobj8AREfzAv2I5UVaexr4J7Hs+9c1hr/JvMBmvwAWe26Z/UKh3A6ToKLeY6pNWjWbypMl6ENGbFUqSuHQV6EdbaWbdeTByDei7GRiBUjF/+9Kp+2e4Mx+ielLlW2aeFWAlCDCO+Q2tJk7mOlMTnq7JfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793807; c=relaxed/simple;
	bh=We2gFdTkmXBbG4yJZ3+PeSOElzTCat11hqEXL05qy/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITpOpAFU1hY+dryk92LYy0xCTzwcMF6bcImWCLji1hE85iWALFfb5E7Mc/DeI5B/+y8bdd38Qh7Qz9gGNH5ccY4VTeiq9HS4AaCw8sH/etvZgCXd06/vvpkdDeg/XeT5pIJFBRiuywcVbwvmX3SdXXcv8o8zwnypD02jEsXWQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/FcWL21; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a99de9beb2so349183485a.3;
        Tue, 01 Oct 2024 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727793805; x=1728398605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mru1A9do/vVb8Ae1r8czZpnZUz93o86nBvUQMdJ5VE8=;
        b=b/FcWL21SruJa0OOKYFxdvkh1m9XXIDeOhQzpelOBTCrjl6ttlCJywSGjc4XTOMPHC
         TpqGY6wE/NFrp+STE2iFq1hmDsE0AQBwvzyF0l947HwgiFqRRLEnSU6LofCl8j1ZffwV
         DgaJ+QbNKZ2pUp1jneE1z9Y7z7FJdg+5STp6TUwxn8NWVYNjGZwNnje30H1xiqIMvX61
         6Cc3Vxm/MGQoGtLIU1s+A4ksmyO5K9dZTMSm9pXT6dO1YUCF041xzCGI3C1ogy95z/Y2
         nKegH4Kk9TfHT1XVe7ZhK5Ll1n/JyN6og2Xf2/AJ4DEot4Ls4tikK29Cazh+sGXTUqXa
         q/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793805; x=1728398605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mru1A9do/vVb8Ae1r8czZpnZUz93o86nBvUQMdJ5VE8=;
        b=ZOWHtEpQpvbrmhdf0d9dum31U48GiUjJ5ltw5N8VcBNS0S+ujyDsNE51+UNWs0DdNY
         rD502OHwqjAQ+a3v2FMDRyDZ8XjMEsp1y3UIsWJK9Jq1QpMgH4qyGvEomh+CyqI6o+Zd
         pzwANGuod2O9IAoFaYkMksaJ8bckpcu04UuAn7de0xsiHyZloCUOHvphUD6i/iTyuXey
         mO19DWBZFy7W6652iA+r1DPAcBIhqSeIj3tVCj2njU8kyp+d+3oLobTx1PhxHoUtfz0y
         whliJcZYwOzgbx27gmHC/Rv9v/ViVzktCvnnJG3dJPBNqBeYj15HEcalG5s6Fo4Dag/Y
         QHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU74Yq/G39xOkodI2WhToKxU4RKVSPRL3FkOUZnPHz2KtFq52ZXLUYMuE1I4NnMENRm2ORgeagtwyl3tVw=@vger.kernel.org, AJvYcCVQJak7qqY4abDrtuzK7w8mRY8MI6uUk4u+I12gb1LVb41nezWAuTOAWValN099mjoSDaxjxZYVyjHiq2Qvzw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5FbfEmlxXTevkOeDDbfM+l6cBh8CNeMJsiE9h3XRH7GVQ6hn
	e5v80vJh2Jdez+rZV4gffQ8j4cWDwDjeW1FRl5qfIl7/Lo23QTxL
X-Google-Smtp-Source: AGHT+IGZvOYg0eN3Ign+A8pEWTV9V7eNpGD/Hoq9aULrRdAbW7yElbiDWJtXOpzYBg7qpyfNrhoQLw==
X-Received: by 2002:a05:620a:4115:b0:7a7:f18a:e46f with SMTP id af79cd13be357-7ae378c2cb4mr2194069085a.43.1727793804528;
        Tue, 01 Oct 2024 07:43:24 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377d7530sm509459685a.49.2024.10.01.07.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 07:43:23 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 41D391200043;
	Tue,  1 Oct 2024 10:43:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Oct 2024 10:43:23 -0400
X-ME-Sender: <xms:iwr8ZrAmsz8cr_E2moAtBqP4Ma3xDU3ClAHnrX51YdHiPHJSXXzHpg>
    <xme:iwr8Zhi1P6aVzX3SfJULjMDAoJqpceDrlHxqDr029WC2cDj1WM4xbEnfwRjlZUtph
    ei3Z8foQdEjvsNNQw>
X-ME-Received: <xmr:iwr8ZmkDVL8A-bmvZFMzHIFlpUqbLXa7XqI4udcOJcvsF6Sw5cGLyeMcjnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epughirhhkrdgsvghhmhgvseguvgdrsghoshgthhdrtghomhdprhgtphhtthhopegrrdhh
    ihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprh
    gtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhg
    lhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepghgrrhihsehgrghrhihguh
    hordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:iwr8Ztw1hWnZV_y37Wv9GgQqeazJYbAIBTrwFoi_5oK4FBJYv4tnKA>
    <xmx:iwr8ZgRbL0c0PqmoUdnopCGajmTfRzx0kR9m44GMkzpwZWV3oD_LUw>
    <xmx:iwr8Zgb1hbt8ZeUaQ0awHMQTWenBeB3oVgW7YIqkiMN33U-74WmOMQ>
    <xmx:iwr8ZhRJUroBVhk-HBIlEkZ9hq7ri8FRrhf35xNhPX6H8BkBMbfDzQ>
    <xmx:iwr8ZmDi0QFRSgcgeoBML9IeLwmtANowBIKXOd7RfEstw7MQXWt2bD98>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 10:43:22 -0400 (EDT)
Date: Tue, 1 Oct 2024 07:42:22 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
Message-ID: <ZvwKTinnLckZm8aQ@boqun-archlinux>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>

On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
> On 18.09.2024 00:27, Andreas Hindborg wrote:
> > Hi!
> > 
> > This series adds support for using the `hrtimer` subsystem from Rust code.
> > 
> > I tried breaking up the code in some smaller patches, hopefully that will
> > ease the review process a bit.
> 
> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
> Example from hrtimer.rs.
> 
> This is from lockdep:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
> 
> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
> interrupt context? Or a more subtle one?

I think it's calling mutex inside an interrupt context as shown by the
callstack:

]  __mutex_lock+0xa0/0xa4
] ...
]  hrtimer_interrupt+0x1d4/0x2ac

, it is because:

+//! struct ArcIntrusiveTimer {
+//!     #[pin]
+//!     timer: Timer<Self>,
+//!     #[pin]
+//!     flag: Mutex<bool>,
+//!     #[pin]
+//!     cond: CondVar,
+//! }

has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
irq-off is needed for the lock, because otherwise we will hit a self
deadlock due to interrupts:

	spin_lock(&a);
	> timer interrupt
	  spin_lock(&a);

Also notice that the IrqDisabled<'_> token can be simply created by
::new(), because irq contexts should guarantee interrupt disabled (i.e.
we don't support nested interrupts*).

[*]: I vaguely remember we still have some driver code for slow devices
that will enable interrupts during an irq handler, but these are going
to be gone, we shouldn't really care about this in Rust code.

Regards,
Boqun

[1]: https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/


> 
> Best regards
> 
> Dirk
> 
> [1]
> 
>     # rust_doctest_kernel_hrtimer_rs_0.location: rust/kernel/hrtimer.rs:10
> rust_doctests_kernel: Timer called
> 
> =============================
> [ BUG: Invalid wait context ]
> 6.11.0-rc1-arm64 #28 Tainted: G                 N
> -----------------------------
> swapper/5/0 is trying to lock:
> ffff0004409ab900 (rust/doctests_kernel_generated.rs:1238){+.+.}-{3:3}, at:
> rust_helper_mutex_lock+0x10/0x18
> other info that might help us debug this:
> context-{2:2}
> no locks held by swapper/5/0.
> stack backtrace:
> CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Tainted: G N 6.11.0-rc1-arm64 #28
> Tainted: [N]=TEST
> Hardware name: ARM64 based board (DT)
> Call trace:
>  $x.11+0x98/0xb4
>  show_stack+0x14/0x1c
>  $x.3+0x3c/0x94
>  dump_stack+0x14/0x1c
>  $x.205+0x538/0x594
>  $x.179+0xd0/0x18c
>  __mutex_lock+0xa0/0xa4
>  mutex_lock_nested+0x20/0x28
>  rust_helper_mutex_lock+0x10/0x18
> 
> _RNvXs_NvNvNvCslTRHJHclVGW_25doctests_kernel_generated32rust_doctest_kernel_hrtimer_rs_04main41__doctest_main_rust_kernel_hrtimer_rs_10_0NtB4_17ArcIntrusiveTimerNtNtCsclYTRz49wqv_6kernel7hrtimer13TimerCallback3run+0x5c/0xd0
> 
> _RNvXs1_NtNtCsclYTRz49wqv_6kernel7hrtimer3arcINtNtNtB9_4sync3arc3ArcNtNvNvNvCslTRHJHclVGW_25doctests_kernel_generated32rust_doctest_kernel_hrtimer_rs_04main41__doctest_main_rust_kernel_hrtimer_rs_10_017ArcIntrusiveTimerENtB7_16RawTimerCallback3runB1b_+0x20/0x2c
>  $x.90+0x64/0x70
>  hrtimer_interrupt+0x1d4/0x2ac
>  arch_timer_handler_phys+0x34/0x40
>  $x.62+0x50/0x54
>  generic_handle_domain_irq+0x28/0x40
>  $x.154+0x58/0x6c
>  $x.471+0x10/0x20
>  el1_interrupt+0x70/0x94
>  el1h_64_irq_handler+0x14/0x1c
>  el1h_64_irq+0x64/0x68
>  arch_local_irq_enable+0x4/0x8
>  cpuidle_enter+0x34/0x48
>  $x.37+0x58/0xe4
>  cpu_startup_entry+0x30/0x34
>  $x.2+0xf8/0x118
>  $x.13+0x0/0x4
> rust_doctests_kernel: Timer called
> rust_doctests_kernel: Timer called
> rust_doctests_kernel: Timer called
> rust_doctests_kernel: Timer called
> rust_doctests_kernel: Counted to 5
>     ok 22 rust_doctest_kernel_hrtimer_rs_0
>     # rust_doctest_kernel_hrtimer_rs_1.location: rust/kernel/hrtimer.rs:137
> rust_doctests_kernel: Hello from the future
> rust_doctests_kernel: Flag raised
>     ok 23 rust_doctest_kernel_hrtimer_rs_1
>     # rust_doctest_kernel_hrtimer_rs_2.location: rust/kernel/hrtimer.rs:76
> rust_doctests_kernel: Timer called
> rust_doctests_kernel: Flag raised
>     ok 24 rust_doctest_kernel_hrtimer_rs_2

