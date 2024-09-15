Return-Path: <linux-kernel+bounces-329888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D3A979721
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0CD1C20BA5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD141C68A0;
	Sun, 15 Sep 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyLSp7SC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA71E520
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410698; cv=none; b=MBlDbTvjKQM3BShBWZNvaVz6POG3OkEeDM0f4I92V3hdDKQziAWIHwG29VIcAtelYHwdZNuOcs/NKKVrKVFd4/z/n0yGfg7F2A4SYn2JzAl8s1eKxW2kdA3vQCVPPQAdFbMHgySFqz2hEuhaSUkD/Z5PBBa9x3qao59r8Wfj0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410698; c=relaxed/simple;
	bh=E1rcV/usKkmgQ6tsM87QBKE2ZzsSc+KknzdtyV0GDRk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ogizVkpHEm+EfGXLJlW0AgB2gEeNMPh4dT3bpRYNAwSvYZdst2y9Q8f/yFdVCUKL13Qj9URkN3WNQIzKvJj3H8rkz5TfHCPZV5btWiJFCQMaP7qxp6rx8DUHDy5KeoL2ouZfbzxRFURy1Sa1N5ozUmgtNUIYWx+dSjkmokQz+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KyLSp7SC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d5235d1bcaso112707477b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726410696; x=1727015496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H1q3oYY/AuqpTagyokS1Yr2O5fJ+yqf6LS9j6A1zLuQ=;
        b=KyLSp7SCU4a9lfTy+cS3lZrqNS9s68Bk1dN87tnnimaOlgtu/u4tKMsXgPm2fXTE4p
         CQDC8LuC8Ua6wqqOJ0aGtIiQUmFgxItq5Zbo6lpIWQEhrSSlXWZ7mLaX8oJBxvOa5ZAJ
         N4aeQOF+7+KxUc5v5rY5DFKUc27QpB5ybJRkfAIZep8ZBkCalv1FBcEh95X4hLJ9eQ8s
         qL8BmTXig0MY7ZV1IHRskCu9EixFj0Xd18/qwmtDG0LBhdpJenI7czjiZROeMYNeBLZ2
         FDjUm4gav6wHNDfZnarkz6knjedRraWRZ8YmRrfavT6lT86UGbQsixGzNuZiXQqrMxdH
         voWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410696; x=1727015496;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1q3oYY/AuqpTagyokS1Yr2O5fJ+yqf6LS9j6A1zLuQ=;
        b=R3DK05y2+kFJTHZsWZaSj5DrwNUcpSZ+tWU5zTzlPsEoE2A6gtQmrcim4PFBoHq0Mp
         Gy+TWFyyOWTP+jNTq14hBNtM5j8FR3YSeJx89pOJbnMOs+Bia8+nTTCClj0Qine03Rn/
         tttJe0tOdAB5CGv+c/3x4DNAwQ6RdJ6FUjydp+us7/Xe9+FnPf31n4JCeaCDOEepLW5k
         /lHfMuxfE4ntLseP3Xb4GvmV/6k9+2OVrJww8q4f69TrdPzaLuEEAWLmt+k71E92qDWg
         7MmRG858W7NCYIV9Su4E1syIE0p7mIok6fpZzg6P84fLZIPpdBr2eqWEH3dtOkBQrEiH
         IPiA==
X-Forwarded-Encrypted: i=1; AJvYcCXX8HIQROrLW0kSKRn+c8sXNp5G8lxfOqcnhRA7w8qQhAfJKuyLrI/x2JBNL+tSU9RlZZY4cSrXNpoOAww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh87t2A2Jwbe/+4QOYmf1K7krIt+KzbvhJ73tbwfg+195WO11x
	v2bZ6LciiZ/JCXDD6JBBFSFySfl7qR8UrdLbXyp7GJ/5MxQzZE/MEuC9AxuASj4vA4S182vMMUr
	FHpb7bLdJfiX1Ow==
X-Google-Smtp-Source: AGHT+IG11VSQ9XzuHNxC/CO/c0D6GKHtXGVcHkyDcqG+q3LQf+IZys+3czs+L7efzeoi+IwnP+6MVKGIINkxKb8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:9c86:0:b0:e0e:4841:3a7e with SMTP id
 3f1490d57ef6-e1d9dc1b21cmr33603276.7.1726410695545; Sun, 15 Sep 2024 07:31:35
 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:31:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAL/v5mYC/2XRzWrDMAwH8FcpPi9Dlr/knfYeYwfbkVtD14xkh
 I3Sd59TKKnxxSDB72/JvoqF58KLeDtcxcxrWcp0qYWEl4NIp3A58lDG2hAIqKRENYRzSTzkcub
 BoImemIJDLSr4njmX33vax2etT2X5mea/e/gqt+4jxj/HrHKAIZMMmSk5tPL9OE3HM7+m6UtsO
 SvuFsE2FqsN2UqXYPSj151VD6tBSmqsqtZbr6PN3hCkzurd1qOxeps5+YRAYK2KnTXPtt3XbDM
 rR2QdKUDTWbtbI11jbbWxvnvIY/LRu8663Vps93XV6tGBzFYpk1VnabcOTWOpWmMCMsHIIVBn/ W4J2nt9tZiii15pBm7/93a7/QMguQNWhgIAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6849; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=E1rcV/usKkmgQ6tsM87QBKE2ZzsSc+KknzdtyV0GDRk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5u+/QoSKI69hWYWqu5Yvc90es715+7+s6Zld/
 Bj0rf2iWzyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubvvwAKCRAEWL7uWMY5
 RrL5D/wM1M0BVC8pzu3gFtV1egAEqj5RfIFi47JKL7bbcMFtBUjkSqMOXq1WiINVUXwUyRcd/2+
 r9uZwcnWz6+PyjnlElgznOCxM3t6R69BM/kSyQVK6tqX+UB0rAhPy7U1wqwoaHCS3QLA6HkmRbH
 pP1zTFThjm+HHnHHCMZyU2LCIqvfL25mFyzPYTopN3xAd8seEWtc+Y9nozCSiwyAhXzOxZdQA1y
 DE8kCzIjeC5JBQEgwLUphqtdud4b1l9kZ5rUw9bWKRGcJxD2TQoQ+s+Bt/rRs7nvxa35MMcdxGa
 Be2nZV6/uljFQSKQ9HrJdeS9PUwLCPSx59dmYkblISCnpFjDEzMHMoRTj0DfRhBZgGLNL8wyvKh
 HRZLi+7p8K/WPZQ5lJhHv+rz/Rc+T8/53sZDVY/EnNaBsCzO62JciGeEwa1vBJx90ji6e9r/1S9
 aQIj8rLHi+u5hZJoFjvZR9ybPo9R3iDbljqiT0XLxf/aBQnUdo7mJwkEfk/FyjgmIGoYTHOENYX
 vcazcHTAPTBdpGOsSoLS+OxNp8R4Iyh1s5lEr6uxQKrBY/0JIb6+sbJNW89GyUa8H4BikkB0QaT
 3JVw9UkGv3GLxWrGxF5oZDIyEuNn4RsyDNuahJvGS3ZOZvuPiNG9qg/2kX87OzLkBm/cgDBcmeD u/0WQ1SbkE8OyBA==
X-Mailer: b4 0.13.0
Message-ID: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
Subject: [PATCH v10 0/8] File abstractions needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
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

LSM: Please see patches 4 and 5 that add Rust abstractions for cred and
secctx. I did not CC the LSM list on earlier versions of this patchset,
sorry about that.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v10:
- Rebase series on top of stuff in for 6.12.
  - This required changes in rust/helpers.
- Add more info to commit messages of cred/secctx patches.
- Link to v9: https://lore.kernel.org/r/20240808-alice-file-v9-0-2cb7b934e0e1@google.com

Changes in v9:
- Rebase on top of v6.11-rc2.
- Reorder things in file.rs
- Fix minor typo in file.rs
- Add Reviewed-bys.
- Link to v8: https://lore.kernel.org/r/20240725-alice-file-v8-0-55a2e80deaa8@google.com

Changes in v8:
- Rename File::from_ptr to File::from_raw_file.
- Mention that NotThreadSafe also affects Sync.
- Fix copyright lines.
- Move rust/kernel/file.rs to rust/kernel/fs/file.rs to reduce conflicts
  with Wedson's vfs patches.
- Link to v7: https://lore.kernel.org/r/20240628-alice-file-v7-0-4d701f6335f3@google.com

Changes in v7:
- Replace file sharing modes with File / LocalFile.
- Link to v6: https://lore.kernel.org/r/20240517-alice-file-v6-0-b25bafdc9b97@google.com

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
 rust/helpers/cred.c             |  13 ++
 rust/helpers/fs.c               |  12 ++
 rust/helpers/helpers.c          |   3 +
 rust/helpers/security.c         |  20 ++
 rust/helpers/task.c             |  38 ++++
 rust/kernel/cred.rs             |  85 ++++++++
 rust/kernel/fs.rs               |   8 +
 rust/kernel/fs/file.rs          | 461 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  74 +++++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  13 +-
 rust/kernel/sync/poll.rs        | 121 +++++++++++
 rust/kernel/task.rs             |  91 +++++++-
 rust/kernel/types.rs            |  21 ++
 17 files changed, 965 insertions(+), 12 deletions(-)
---
base-commit: d077242d68a31075ef5f5da041bf8f6fc19aa231
change-id: 20231123-alice-file-525b98e8a724

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


