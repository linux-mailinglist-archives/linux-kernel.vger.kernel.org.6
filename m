Return-Path: <linux-kernel+bounces-279837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5894C268
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E56281DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8902918DF70;
	Thu,  8 Aug 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jrPYNGP8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CB2A8CD
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133791; cv=none; b=oJ4qw74znMCrrORC8LH7nd7f6u8UyT/dXXZK5MFxNi+bOgrjFM7AID2FgsBBBjsAMvDicSke6GUjC/B9GzGQi6xHIGawi80fOd7rZT2hApeZ01FP6YBOQDH8+EDG0Uk2BsWF1zvgB6+NYzgXOBK7MMGuahEcOQnxT6eyqAqA+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133791; c=relaxed/simple;
	bh=SOYgy4P8Uq9oM6a25K6PQa+h3uLwgPZuAxedEQTf/NY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lljJG59viPN1uBOzTkYjF14S+DRoqeCw6qya38rsX/xmZaBNuX5r08fbOqVyufy9kGuxZ+ziwYLirN+WQS+JZiT2i2v69ASyvOmqpIL5ANiaWWlC0havmqCDSoplReXxcU85rT/YS5Y7aC4AZHIAoIj3UwFIQwa5FzJ3bVTYtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jrPYNGP8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-68d1d966ef7so24596307b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723133789; x=1723738589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j1g997ZUPo5uTCGLqcMqUdwvoRpJcfe+1yvZrZi1dTw=;
        b=jrPYNGP8YWe8ZJ+VNfxFDeEb2TnvJIzivBTf5CBhcs7tWwrPgpYwvZ+Y6P1ELWi6Wf
         pP0sPvFV4Fmev4fYOnqpjSiy9LBJ2jiZqkIOk18crd97WPtV5LffEfkPWaMt4JrJJtRP
         fWHfXj82j2+etYruuNpPV4p2DjrgbwKSX4OOCoHpOmqOiJwz5vaRmBsavB00OhZV7jWY
         9AVxzX7tQyDBc7ozSyBOjrMtckB2BYHLfeVoji508ogfoGNGAqZwL98rXdXjDwaV5YmR
         rGROBzlitqC7+iJZs33mYLX0zW7fAYUKR+aEgvFTnTe8LwJOWTL4VHnZt2ne1pzvszKG
         7upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133789; x=1723738589;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1g997ZUPo5uTCGLqcMqUdwvoRpJcfe+1yvZrZi1dTw=;
        b=dm2r00gLrYGvndd1R7hF+5jALPUHBd8RdPi8fNlPZklTnbT72Z2V+Go5ls+ZjeDgNf
         kqSR98+Wjxxdjw0z4Eq/Rj2Wgiy3UUCNUWoFTFAnVpvR74+AmxnoapuEU4dR0VZ35mIu
         yO6nxK6cEJHqJKCAG9J+cfa+YFOzH4c8YhjW4YLvijr8pv4r45/RuN/BbS/aAp+oN6nf
         5JrHaCm6dzA4lgqX2EJ/ftHDkq3hraY8tziqiZ9weVSaElcGfLl9k+YXkdn8l8hthRt9
         GyVk+He8ooFS4O0We7Er/9dF41N8ta3KUkZrmfDAXgsAg137RcsBcCnUaPUu3pJhUu34
         nU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUczPpEBC1sUjhB/5at5VUwQT8SR1ZQIjSHUqwMNxmRbVnB2FGP/heIYL9eucm87G9PlAXASwnTjd8I42EBE1s9grdDmRV6t1fP5fE1
X-Gm-Message-State: AOJu0Yxsg+14QuTB72dRdb4g3pOsnd/+1tNcujpYayLWfJzkOU6WodZ2
	kdgjPAAqGPPSP2gCqH9AqFBe6l0SpHv3rxwdE+qsuu9jDluDaK54Ik45QAxA0y9BASLRao3Qz8b
	9Bfvi3qOf0YXA4w==
X-Google-Smtp-Source: AGHT+IFNExh/sgSZD9y2EoWqTq3W6QpGxGyaEAJpJOajV2Z59sxKgyErz8I79tAW9ax6csc/LDhVpPKOVEOv5IY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:68c1:0:b0:e0b:fe07:1e22 with SMTP id
 3f1490d57ef6-e0e9db2234emr58583276.1.1723133788824; Thu, 08 Aug 2024 09:16:28
 -0700 (PDT)
Date: Thu, 08 Aug 2024 16:15:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC/vtGYC/2XQ3WrEIBAF4FdZvK5FRx3HXvU9Si+MP1lhuylJC
 S1L3r1mYcmKN8IRvsPM3NiS5pIW9na6sTmtZSnTtQb3cmLh7K9j4iXWzECAkhIU95cSEs/lkrg
 BMzhK5C1oVsH3nHL5vZd9fNZ8LsvPNP/du1e5/z5q3HPNKrngmaTPiYIFlO/jNI2X9BqmL7b3r
 HBYENhYqNZnlDaI6KLTnVUPq4WU1FhVrUOnB8zOkAid1YetT2P1PnNwAQQJRDV01jzbdl+zz6w
 sEVpSAkxn8bBG2sZitUO9u88xuMHZztrDIrT72mp1tEJmVMpk1Vk6rAXTWKrWGA+JREzeU2O3b fsHyPB1FkkCAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6257; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=SOYgy4P8Uq9oM6a25K6PQa+h3uLwgPZuAxedEQTf/NY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtO9B+en6UCwSIgY+owBIXNfBggQV1Bu64LXPs
 s02GT7TMn2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrTvQQAKCRAEWL7uWMY5
 RkvFEACwzWgxCxfZThdM+IksTLxlQ0N+xd+EHF3AdZWmxYpeA2oPxFqYWd6drXHlilOG0jS6Xm5
 7+dRFG9I0cbj13uHPIGPCbw9kLvnMgNpUcLTlECWqdqOKfyEXoPU3shLufNpM7FCmY7Njx/7YMM
 V8DN2Jswsee2qHHfQZ8MfVZOKCOnvQNjIpcdCj9NSYRYVAeOhVA0UmxXSgYcj95RgFHxrFZdg6g
 iYqy+itK9+HiGGRsjArp+X77naO6uL5wIvGOtMaqbzIl/6VVulCOPaSfb5JK3jRoTDaOYHXY4D6
 R1LGmdZjfx51Cnjr/SvgJoF4IJnGbOLAtXC7OubsFtIA4vGU3h+yujl7Di/s5ab7mwxKcRrg3+C
 OuXEHB+rX2j12E21jYigIQpeEWLTrWlg47MZAyXpwnqN2+e1z01D39mPpfgfneaMSiu8j8cjQ6q
 V/2pDa0G91JBwwRscDEIzKfRNkqZmwMwO//oqHDTIxea2ah0o2/C3DlaIF5JnKVmYrRopyq1q91
 fNoBn8BxolQqowusJSIF/VYD/6ZUBxFHjqHGFuGq8FkAJBFuwDcJYywIfdfXjoVfhkKYvrK3MJr
 dMSZ18yRhuvTHgB831aDJ5UYJc7G7jHJMBtiZzi7VL+1yX7it33xL8+bP6Wfv6dP6sf5EntVJOy Sw+syoE0eDsDU+w==
X-Mailer: b4 0.13.0
Message-ID: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Subject: [PATCH v9 0/8] File abstractions needed by Rust Binder
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
Cc: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>
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
 rust/helpers.c                  |  86 ++++++++
 rust/kernel/cred.rs             |  85 ++++++++
 rust/kernel/fs.rs               |   8 +
 rust/kernel/fs/file.rs          | 461 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  74 +++++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  13 +-
 rust/kernel/sync/poll.rs        | 121 +++++++++++
 rust/kernel/task.rs             |  91 +++++++-
 rust/kernel/types.rs            |  29 +++
 13 files changed, 973 insertions(+), 12 deletions(-)
---
base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
change-id: 20231123-alice-file-525b98e8a724

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


