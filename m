Return-Path: <linux-kernel+bounces-370978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9079A3494
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE58B20C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F718132A;
	Fri, 18 Oct 2024 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3t7Z80c"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E017332B;
	Fri, 18 Oct 2024 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230721; cv=none; b=YLtbnXKGD+1SFrASgJGrwuk17DL8QQ5tqb1mXHFSKhXZ4iZ/q+kITTfMpxCNoCtJD/WqhMjRt/u8vNUuOwNDj/7obix2OX0UXkOnRN2vP4/0dVIm5Lv5e6DyLy9++oLciEBSKdNp2lx6ilCfqQAaoLKfIAQsuiw6HLen4vIVMs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230721; c=relaxed/simple;
	bh=eAhL9xtwWzNxLLC9A9a0QdkxAaiyQEWH7sgGM+t9H2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbdJbdrVXdNwBxdiPY2mp3dVcgz4ckG/tQ81oB3AhDYIEfCpn8wL5N8mL274kG9YN1Aq1HL+d0YzCKT62hDQJNlXBxN0o7nGfSYeGI/77lu/4Jo3xQEXelQ3sSvjttP9osSIDGAWlxgVwLEQ9XUJzwb9gG1u/9GegAWmAQvSNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3t7Z80c; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46090640f0cso15093941cf.0;
        Thu, 17 Oct 2024 22:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729230718; x=1729835518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K33FEaP3Z7r7Xl1UJjCNToT4hf/A+FER5tBnwb2tzp8=;
        b=S3t7Z80cfLekOfhS+rsLK//OOixcTd2t/RtgVYmapIRUATDeSOn8agTR5HXP7MATdm
         vKtDHQkFRkSrHbyocaVoqpONcXNjry/xjtS9QKYNMdSZIKu1JYkARX9bnmBp7gf/hoBH
         8FtH5mYQs6meARttP6sX3yaatB38zreGwCk6TS+cndQpy9BjqCLUC9NymuKOl0jrh3kU
         XXV4ZHu1l3lsay33Kg9Yi2pVBsxHslYnNpLH5P5SmqidoacH05ajEAqwM5v8G3x2AvzV
         3jp72dU1zf1Mdds90xpgHw6haTbGrEOOtchomQuBYXUiCR8yr1AjGrReRXWtQvCrhEEd
         tqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230718; x=1729835518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K33FEaP3Z7r7Xl1UJjCNToT4hf/A+FER5tBnwb2tzp8=;
        b=NaDOfNInIUyVcrFaAWNJR22at1Iev+18M/lBB2TZ1qmzr7KwOnCt6neKUK4ICSS2De
         N5mbPLnEvvN0PQmGh6ZVcICY33J/0JYGtkSkUNvg5L6/DIxO2FCS55+P75SeW2/+uUc8
         XYprQe56do1yHzCClRaKnHYwOzMY974ZLlEMvwpg86rtuSUFtq6cUY+4iMXc9SyrlnvY
         lXS0tXAu90+6j8qXXzb/onX1TZpncVTVJRIH+rm8d4Sqq3dEAhvOVLyBE77oxjQCxClR
         5CPdr3W6M4YnwWEKqaIo3UStXd8TnM6V8yBbcJld83/d/JkQdTdqEX4nZpC4h3d+ABqB
         PSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWE6WXz7mNQRMvtKpX7cXZpMzhXwuWXgqFCexuuJv9yesg8kvOb1NmRLq7loBkDLiJj7R53yPe958jgd/OmK8=@vger.kernel.org, AJvYcCXg8qxpBZqvTaUi+GuAjw4d5IqZCEMKfIJqp7ZpBd3vIqKQY2BZov27CnnU/xNaQZ9mEmZ+nhA3pDEcs34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHblGWjdN78X6dsqkVIFkEzbj99XCOBhBIPXD+dsybRZax0qa
	d/7CwPKJOqTs7iVaZaFd69wgN21cOrAiC0xCXKOx0gNONbe+4Zzn
X-Google-Smtp-Source: AGHT+IFC8BiPHIDP++CruiLgFKjf+7YLRJM+2hpzLbzrEp0UM9droiSND9TxyeOlTgZyz+up5JuEEQ==
X-Received: by 2002:a05:622a:18a1:b0:45b:5cdf:54b5 with SMTP id d75a77b69052e-460aee38890mr15383021cf.41.1729230718506;
        Thu, 17 Oct 2024 22:51:58 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460ae999ab8sm4077931cf.50.2024.10.17.22.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:51:57 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18BB91200071;
	Fri, 18 Oct 2024 01:51:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 18 Oct 2024 01:51:57 -0400
X-ME-Sender: <xms:fPcRZ3ySzsWNOnCPmQezx6r7aSSmw5eSHnPl0JF-245AU2f8TxNeRA>
    <xme:fPcRZ_Ti1arKwYm4l4Mqabze2LC0Db0QZllPHqTM8qEu06vx1MTh4HcmtybA9SMrI
    PPKREAPWGSU3XfH1A>
X-ME-Received: <xmr:fPcRZxUySa_hokYYylwlD-D1TihNKTNY_gDmV11B0XC6ilnBpc4Yx8W8Hyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gvpdhrtghpthhtohepughirhhkrdgsvghhmhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqd
    hlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopegrihhrlhhivggusehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhl
    lheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrd
    gtohhm
X-ME-Proxy: <xmx:fPcRZxidaAvl6HQ8WjtxJugb4oJmonF75YomIMavu6J51tnO7_uiAQ>
    <xmx:fPcRZ5A3ErfTTTbjCg3Etw2XZwbN95Ta7TWNhxKgfYE0CI2hlsStfA>
    <xmx:fPcRZ6KkU-rbHYwDLTIdjBAYEEq_WnUrmGHKqYBCSMGlfA58LOfU7g>
    <xmx:fPcRZ4A2fJ_q4sA_pQpHZE9f2qLGRSQxeOe__SIDza0sZBTf4P-94A>
    <xmx:ffcRZ1wBi8dCYDRL2ozULsZjKqwLFpuEwibiMce1sz-7u62ajui2vuu1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:51:56 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	will@kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [POC 0/6] Allow SpinLockIrq to use a normal Guard interface
Date: Thu, 17 Oct 2024 22:51:19 -0700
Message-ID: <20241018055125.2784186-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

So this series is what I proposed, previously, because the nested
interrupt API in C is local_irq_save() and local_irq_restore(), the
following Rust code has the problem of enabling interrupt earlier:

	// l1 and l2 are interrupt disabling locks, their guards (i.e.
	// return of lock()) can be used to track interrupt state.

	// interrupts are enabled in the beginning.
	
	let g1 = l1.lock(); // previous interrupt state is enabled.
	let g2 = l2.lock(); // previous interrupt state is disabled.

	drop(g1); // release l1, if we use g1's state, interrupt will be
		  // enabled. But this is obviously wrong. Because g2
		  // can only exist with interrupt disabled.

With the new interrupt disable and enable API, instead of a "unsigned
long", a percpu variable is used to track the outermost interrupt state
and the nested level, so that "drop(g1);" above won't enable interrupts.

Although this requires extra cost, but I think it might be worth paying,
because this could make Rust's SpinLockIrq simply use a guard interface
as SpinLock.

Of course, looking for any comments and suggestions.

Boqun Feng (3):
  irq & spin_lock: Add counted interrupt disabling/enabling
  rust: helper: Add spin_{un,}lock_irq_{enable,disable}() helpers
  rust: sync: lock: Add `Backend::BackendInContext`

Lyude Paul (3):
  rust: Introduce interrupt module
  rust: sync: Add SpinLockIrq
  rust: sync: Introduce lock::Backend::Context

 include/linux/irqflags.h          |  32 +++++++++-
 include/linux/irqflags_types.h    |   6 ++
 include/linux/spinlock.h          |  13 ++++
 include/linux/spinlock_api_smp.h  |  29 +++++++++
 include/linux/spinlock_rt.h       |  10 +++
 kernel/locking/spinlock.c         |  16 +++++
 kernel/softirq.c                  |   3 +
 rust/helpers/helpers.c            |   1 +
 rust/helpers/interrupt.c          |  18 ++++++
 rust/helpers/spinlock.c           |  10 +++
 rust/kernel/interrupt.rs          |  64 +++++++++++++++++++
 rust/kernel/lib.rs                |   1 +
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock.rs          |  33 +++++++++-
 rust/kernel/sync/lock/mutex.rs    |   2 +
 rust/kernel/sync/lock/spinlock.rs | 103 ++++++++++++++++++++++++++++++
 16 files changed, 340 insertions(+), 3 deletions(-)
 create mode 100644 rust/helpers/interrupt.c
 create mode 100644 rust/kernel/interrupt.rs

-- 
2.45.2


