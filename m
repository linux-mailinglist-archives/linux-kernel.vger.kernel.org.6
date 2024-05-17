Return-Path: <linux-kernel+bounces-181931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2F8C8383
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7710F1C2248E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DDA2C1B6;
	Fri, 17 May 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYClSJWU"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C128DC0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938288; cv=none; b=UXeBGPAzsOa78yZGyE3+nt/2Yw5MViucljdY0p9eO47Pq36j7G4vCDd/+ppYEAG0aMh1AVNYLplDSjdY3Bq0AZlSixi9KGm2prio1MUp7zn50gux5Fz4RgbFqsIUHSLpv+UwULSstwCbKsTFcIy4+Z6OjZPFhKMWNqjKNKH3iP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938288; c=relaxed/simple;
	bh=hSK+knjcsqKhhCAnnycqnUg4XBMIyHFVkdVU8n8ahvQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZOgMNElWol0HYz0VD8dpMDbZZ42eVMU0WvIJITUbkaLQfzwWCCz4cTXEbKarhCqloi/VeO1z5mo2Z71UwaNuyhrSzt/uqLvuDNCoMlmWCEQqoIpXsn8RiGo5Xf3hkX88icAd6NNDmQErnfkghX74m9azWVtdTgDihJ1OWI7hPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYClSJWU; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2e6f31e5909so29510571fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715938284; x=1716543084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2/To727/n+aLzSDrbT0W4j64hJKiEwlroEI7/qAwsAE=;
        b=RYClSJWUeut/vFFp2yLl0+OsY7OTiDNY10/QGSVgmXtsTz8XCZl6k/vB8bNImdKSsK
         INV8ZQtl4Xs5k3FGv/uannuhPaKum5KtA1/qg68ITqGBgYHQf6qYT/8POP2/5xdOgIUh
         fIu1L2yAJgccaRQuVK/D1TNvBQfo6N7nTlzI2JZtdoWRulsKUv0OYCS7GM9STHhMLXuF
         mPuevRbF7TPEDQ7VrdW4LC+Kaxl2Gw+TyoJsgGD36WAdZ5u0fdXGjIOip4uEO9QVlgvi
         pE6thaggtwdIyW3gP9/t84Tjifm7eBajcccSLwpNWlGF/Y0Bay1T7yhy2eKGrFEK2qa/
         5SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715938284; x=1716543084;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/To727/n+aLzSDrbT0W4j64hJKiEwlroEI7/qAwsAE=;
        b=qh/UWtPwIa/LtoEachMhPH8QnXpuC9jiH21LwzMO7avnGkdL7ZqhXnSk2glaI7Rzt1
         WBef8o5pkcXsND2qxmle1nfHsYp3dQ7NwNY3RByoljKO2caRiLl42bhPWdFSor5/zXJ1
         OfR3wlIlQQMCCzZQBShKLWzuuVlEegOzLYrAbPozhdNc7EQNn55nXHRv7lED5So4cFfG
         zzxAtHN/tlKGTh8wVXoawKN9spOMZjFidB0KA30WGFZqZCq84Q76qPe3roFCXY/BRhO6
         ivd5DA2TUtCW6lLtOuQsM24dVsOKGYrfi4GKttxQr7JV3jDrZpMdJFJOt/8MLrdb0F7u
         Xa4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXljsVlR4eVlTZXRQ9TO2v6HJ+cwxqBsypdsWaaWM9jE9VCncHLQ8erxX2bYeRNwChX6t639oFsrUPBIPOCmOJN3lwAVdb4YrM7vC+F
X-Gm-Message-State: AOJu0Ywbbd3ecbo5UmYyP9S6yOC7/9qlZ5SK3c4Zz8qkrfd/pzzuMvWg
	nmSe8bVLBoECF9dlT6WAw6ktg5sdizy61L81Y4sMNksR90dgp/A8alq3aLKiR6E7+dKWLX310vk
	RKnlrgcJx6quWQw==
X-Google-Smtp-Source: AGHT+IHNdDEZjFcycPEFWtxfyl965wyqycW7lOOcmPg0I5NmYgekQ7z0KPgz7ULB52CqKndexAklv77dUDBU0VE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:19a9:b0:2e5:67a7:dda5 with SMTP
 id 38308e7fff4ca-2e567a7dfa6mr193011fa.8.1715938284225; Fri, 17 May 2024
 02:31:24 -0700 (PDT)
Date: Fri, 17 May 2024 09:30:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALojR2YC/2XPTWrDMBAF4KsErasijf5GXeUeJQtZHjkCNyp2M
 A3Bd68cCInwZuANfI+ZO5tpyjSzr8OdTbTkOZdLDfbjwOI5XAbiua+ZgQAlJSgexhyJpzwSN2A
 6j4TBgWYV/E6U8t+j7PtU8znP1zLdHt2L3LbPGv9es0gueEIZEmF0YOVxKGUY6TOWH7b1LPCyI
 GxjodqQrHRR9L73emfV02ohJTZWVeut151N3qCIO6tfto7G6u3m6CMIFNaqbmfNu23/NdvNyiF ah0qAaey6rv8/gqGVlQEAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5505; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hSK+knjcsqKhhCAnnycqnUg4XBMIyHFVkdVU8n8ahvQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmRyPUk04BJtJTBHui5PmAd7jWVds0TPhG4CxKu
 SGEr+RqHXaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZkcj1AAKCRAEWL7uWMY5
 RhkrD/0coG025BTMLiCEoOUW1bopEFXyqGJ+3uAQDuzfGpzlSRzHH6J6tM/NGqw62UCXzUSAF4w
 Yvp70av9jmSpnW4Sxw/TsoZ6Z/g82u+ZcOdmMcY+IjUunCbKEjvzdjzf5/EhUoAN7zBpucqR4+d
 Why3J3oOxsR5H3quZHDfHoyGXl052cE2ljhCSr/JtT2N8YvNXlhFVB2iLOt8EqzLvymgDMMJ2cz
 D3T7uZqRV5b85H3Y6tYU05DdlWD9qIEUXzGR6UQxbbK3NdCCTKkIeQcr7h8av+Hxi8tU6zRCNwp
 Fh6aJHqsw/2i9k/645I+aODNndaPlPpmkqCrz/obGIhRsrZH8vjNLOtEcaywM3aC4o1OVED4wc6
 a+a28V/BP5VzuMCbtU8IR1PSfLOlcOkQgE0X6wEkNCbCGz1koV56cQL7XnVmOmTtMdvG0fJou3L
 d3qiRv3MZq4DkyOpainALhvGl1pb3SM+6TjQ9K92HcerxX8I8byjiubEvYKp19oNxPDx07vTubJ
 6PUfsu+45gHIztjyX4HifEqPqtutxdXw1Pl4GH+Q3R5eE2RD0GLaWRxAGmDKCHG/1asNiGCjD3I
 01ho+nA7C7akgdI+drrwxaYZYUc1luNuCyXlz+QLsi5j7HZZ6OPpWI+Gcw+VVQZdt6Lvadtv23R o4PXDfbwSgwrB8w==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
Subject: [PATCH v6 0/8] File abstractions needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains the file abstractions needed by the Rust
implementation of the Binder driver.

Please see the Rust Binder RFC for usage examples:
https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/

Users of "rust: types: add `NotThreadSafe`":
	[PATCH 5/9] rust: file: add `FileDescriptorReservation`

Users of "rust: task: add `Task::current_raw`":
	[PATCH 7/9] rust: file: add `Kuid` wrapper
	[PATCH 8/9] rust: file: add `DeferredFdCloser`

Users of "rust: file: add Rust abstraction for `struct file`":
	[PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
	[PATCH RFC 03/20] rust_binder: add threading support

Users of "rust: cred: add Rust abstraction for `struct cred`":
	[PATCH RFC 05/20] rust_binder: add nodes and context managers
	[PATCH RFC 06/20] rust_binder: add oneway transactions
	[PATCH RFC 11/20] rust_binder: send nodes in transaction
	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support

Users of "rust: security: add abstraction for secctx":
	[PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: file: add `FileDescriptorReservation`":
	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support

Users of "rust: file: add `Kuid` wrapper":
	[PATCH RFC 05/20] rust_binder: add nodes and context managers
	[PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: file: add abstraction for `poll_table`":
	[PATCH RFC 07/20] rust_binder: add epoll support

This patchset has some uses of read_volatile in place of READ_ONCE.
Please see the following rfc for context on this:
https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v6:
- Introduce file sharing modes.
- Rewrite most documentation for `struct file` wrapper.
- Drop `DeferredFdCloser`. It will be sent later when it can be placed
  somewhere where only Rust Binder can use it.
- Rebase on top of rust-next: 97ab3e8eec0c ("rust: alloc: fix dangling pointer in VecExt<T>::reserve()")
- Link to v5: https://lore.kernel.org/r/20240209-alice-file-v5-0-a37886783025@google.com

Changes in v5:
- Pass a null pointer to task_tgid_nr_ns.
- Fix some typos and other formatting issues.
- Add Reviewed-by where appropriate.
- Link to v4: https://lore.kernel.org/r/20240202-alice-file-v4-0-fc9c2080663b@google.com

Changes in v4:
- Moved the two really simple patches to the beginning of the patchset.
- Update Send safety comments.
- Use srctree relative links.
- Mention that `Credential::euid` is immutable.
- Update some safety comments to mention the invariant on Self.
- Use new name for close_fd_get_file.
- Move safety comments on DeferredFdCloser around and be more explicit
  about how many refcounts we own.
- Reword safety comments related to _qproc.
- Add Reviewed-by where appropriate.
- Link to v3: https://lore.kernel.org/r/20240118-alice-file-v3-0-9694b6f9580c@google.com

Changes in v3:
- Completely rewrite comments about refcounting in the first patch.
  - And add a note to the documentation in fs/file.c.
- Discuss speculation gadgets in commit message for the Kuid wrapper.
- Introduce NotThreadSafe and Task::current_raw patches and use them in
  later patches.
- Improve safety comments in DeferredFdCloser.
- Some other minor changes.
- Link to v2: https://lore.kernel.org/r/20231206-alice-file-v2-0-af617c0d9d94@google.com

Changes in v2:
- Update various docs and safety comments.
- Rename method names to match the C name.
- Use ordinary read instead of READ_ONCE in File::cred.
- Changed null check in secctx.
- Add type alias for PhantomData in FileDescriptorReservation.
- Use Kuid::from_raw in Kuid::current_euid.
- Make DeferredFdCloser fallible if it is unable to schedule a task
  work. And also schedule the task work *before* closing the file.
- Moved PollCondVar to rust/kernel/sync.
- Updated PollCondVar to use wake_up_pollfree.
- Link to v1: https://lore.kernel.org/all/20231129-alice-file-v1-0-f81afe8c7261@google.com/

Link to RFC:
https://lore.kernel.org/all/20230720152820.3566078-1-aliceryhl@google.com/

---
Alice Ryhl (5):
      rust: types: add `NotThreadSafe`
      rust: task: add `Task::current_raw`
      rust: security: add abstraction for secctx
      rust: file: add `Kuid` wrapper
      rust: file: add abstraction for `poll_table`

Wedson Almeida Filho (3):
      rust: file: add Rust abstraction for `struct file`
      rust: cred: add Rust abstraction for `struct cred`
      rust: file: add `FileDescriptorReservation`

 fs/file.c                       |   7 +
 rust/bindings/bindings_helper.h |   6 +
 rust/helpers.c                  |  86 +++++++++
 rust/kernel/cred.rs             |  83 ++++++++
 rust/kernel/file.rs             | 416 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  72 +++++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  13 +-
 rust/kernel/sync/poll.rs        | 119 ++++++++++++
 rust/kernel/task.rs             |  91 ++++++++-
 rust/kernel/types.rs            |  26 +++
 12 files changed, 911 insertions(+), 12 deletions(-)
---
base-commit: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
change-id: 20231123-alice-file-525b98e8a724

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


