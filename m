Return-Path: <linux-kernel+bounces-169619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B548BCB46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054CC1C21E30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FF7142E63;
	Mon,  6 May 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4L/8BTGd"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45041422DD
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989229; cv=none; b=SN2N/yItOpj1SCjH/wVqT+UR4g579fINMUlCirwTJ/4FW3lhGZMGGHq16BwSYAR/+NGExbEXg7NnXyizbWZfZ1DokLAC+hbBSeLQDBUuviSSium7rxGrob5CiWXsreZtitN80j69yrLrSkNPA63dnbqMaGZnRU25V7ZOtmSCy8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989229; c=relaxed/simple;
	bh=Hi80QBWfC/5dRIWaijnYcqekiBONJQqCWhCgOI8iqLI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DdG5sPKN7lf//F9a6WXFE9xozjP0LrW5D3C8OM7/gTZ71xab0cH2F+hqwosugoUH4j1CLQN3TNafPOBpESGFSTdrrrT8jVsO8hMcyeIq1KaX4xa82nHyUweLCIgrCfloPz5p5mjtWOU02OXnikXk8/5Iq+lBbBPpxrT6kbaNtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4L/8BTGd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so4407720276.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714989227; x=1715594027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PFOyhj3mllue2b1f5gFvIUhYSIkDkhL478tn4LuhmPY=;
        b=4L/8BTGdr/QwGNnbFp1wb0sZFSoxUW/K5Bs4vakT66SccVR/pRy2FX17oilpYhGFEe
         PfJelVYlsoUoXrUDDT8H5gpTjV1b7YGbEw6CKm6+5JeVxVnYJwQr3REkunctyKAatbbw
         mYpj5nM4nGtgmRlepDKrRBPHYJ4MVfJCXJoxp2slE37/mbLO2XHZjg1f9pyWN51TzFDJ
         I7/W6eu6+pL2ECFF0UqvjGnX6oNtT4+5IRkr9uCHr96u2gr8cFHZ/hAlO/oyoO2OHw5S
         aQ/LLrW2kDRYQMcwgEMCJWjwhUY6vS9Vz6jQDKjj5tvdgU91x8+2XNVQIhRMP/xtjxJH
         Nz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989227; x=1715594027;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFOyhj3mllue2b1f5gFvIUhYSIkDkhL478tn4LuhmPY=;
        b=s/tBBaFD9cj/J7fb268JkUtHSr4jQRH2v6ME7NIB55oJf1nRzIVUueeG1DemgEauHQ
         4s+IjM6/luZICk2YyNHoNTAXg395Yq7Zym08ZS2E77PgGolQIAZ6SZgL7PdwTZALfQbK
         aiwKOJV3shoZLcKyjSHPWi+DkEfchhe2vO139CozHSQwTXlWke2mc59yfkCKl+kRYnZ2
         jMPYLa5Am+ZTtfVDcQjWlfMs2gMDTW1OUml5jrbX7GWVHQes49KM37F9cBe88dqtFdOM
         DuqvjsXwQ7hUmV7DVso5KCll5vMoElIQSgvdt5ZRa99eHpltTshUIStwRmgupiigiTln
         /FUw==
X-Forwarded-Encrypted: i=1; AJvYcCV/6GaYY0TlHhuHLsjbrxi6VzUzkxA7RZWKzGWjuZ2Tbr1PUpeFNPeM6Ye4HvtM5aV58fGnvbbN3Atpzqcx3S8yRU+5fE6jr51zqDh4
X-Gm-Message-State: AOJu0Yw0fD8OhXgE36Ku6abaTNNc/efxLrKDEomt4LfKIjwyG6Chfs4M
	q2O6p9HCddQLJW0gYfv/2nzt2I1AeAkxJ666CMbgbC+6rTYii0mL5fpsfWp2emTwM4IPvQwRIew
	5b4Bwfs8CxK68qg==
X-Google-Smtp-Source: AGHT+IEdnYNKREItAwesKph0cqijLYlseJXC7+D4UxWe7gNaz9ghD2ocRA6gI7fJ0Nd9GyLuZZviGh/ahULtJTU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1004:b0:de4:7be7:1c2d with SMTP
 id w4-20020a056902100400b00de47be71c2dmr3371860ybt.11.1714989226858; Mon, 06
 May 2024 02:53:46 -0700 (PDT)
Date: Mon, 06 May 2024 09:53:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJGoOGYC/1XMzQ7CIAzA8VdZehYDuGnw5HuYHfiojDhhAUM0C
 +9unSdPzb9pfysUzAELnLsVMtZQQooUcteBnXT0yIKjBsllz6UUbA7xjo5GeTI5iKPSiuveIdD HkvEWXpt2HaknOkr5veFVfLc/h6Q/pwrGmRF2UEafNB7MxafkZ9zb9ICxtfYBZxuqHKcAAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Hi80QBWfC/5dRIWaijnYcqekiBONJQqCWhCgOI8iqLI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmOKiV4QXU5qfIMWlTuzyQlmQ2fKyaLazvQAjzI
 MU7R/043I+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZjiolQAKCRAEWL7uWMY5
 RvvuD/9758267zl/pRNasfK4sQv1OLPFlCd+Is3VN/u/f3/PFAlRm4wluXZO4kX6zyisM2Ax9Vv
 Ois9bc468aQRPvT909FZR+5L0WKxWPQQIAQnB5ApbrrC4Zp/8t7kAr8++zk8iPBcxm6y/oXsKTi
 IzYdb9bd4ydjuVtYOcMlimv+MWPitv6wauxoVctADgrRrxiPcyoW1h0kYCYFroGNXp80DKj06sN
 3YMgSH6bjJ5P8nmeLmysStiz5nxn7JAZaBlyRTfDw1kpUbXClQYHVbNhnhn+QYp14SZTfsxg8Az
 XKvtSdTjPXwJrsojetCbBLzJ+xmDXh6Rpaq+Bg5vcYxQI+kbVIyyEICGhyeT/p0PisZU6mJHTeD
 OOwbn4lH7Bq66ipVTSZoZr16nX5VB+YIgih1sdqkMRXeNA6tUNzibj5Wd7wtu53tTdBzCtKBoWP
 FJmMkdkzu3IbCNgRgSwNrLcunkgfvp7nBQWBaYxWrMn27dAwYKiYt4AA2T9apbUMW2NXsik9d6X
 4P7wK+Zr7lGecnwVj8x2t5CzOE/VMDUuKcKMWYmWgkfaRw5I8yRl4LKJGHjmeaW75M16EZJiBAM
 pFEJaCe69GnTv54ZLLNaVro7LRw4HwStgP05aSwUHxc45inkY6XPqhhEaDEykR2br+jAdIXNYcg pM+8c4j7W+iIRIA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240506-linked-list-v2-0-7b910840c91f@google.com>
Subject: [PATCH v2 0/9] Add Rust linked list for reference counted values
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains a Rust implementation of a doubly-linked list for
use with reference counted values. Linked lists are famously hard to
implement in Rust [1] given the cyclic nature of the pointers, and
indeed, this implementation uses unsafe to get around that.

Linked lists aren't great for cache locality reasons, but it can be hard
to avoid them for cases where you need data structures that don't
allocate. Most linked lists in Binder are for collections where order
matters (usually stacks or queues). There are also a few lists that are
just collections, but linked lists are only used for this purpose in
cases where the linked list is cold and performance isn't that
important. The linked list is chosen over Vec in this case so that I
don't have to worry about reducing the capacity of the vector. (Our
red/black trees are a much better place to look for improving cache
locality of collections in Rust Binder, and the upcoming xarray bindings
would help with that.)

Please see the Rust Binder RFC [2] for usage examples.

The linked lists are used all over Rust Binder, but some pointers for
where to look for examples:

[PATCH RFC 04/20] rust_binder: add work lists
Implements the work lists that store heterogeneous items. Uses the
various macros a bunch.

[PATCH RFC 10/20] rust_binder: add death notifications
Uses the cursor. Also has objects with multiple prev/next pointer pairs.

[PATCH RFC 15/20] rust_binder: add process freezing
Uses the iterator with for loops.

Link: https://rust-unofficial.github.io/too-many-lists/ [1]
Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Rebase on top of the new allocation APIs.
- Implement Default for List.
- `on_create_list_arc_from_unique` now takes `Pin<&mut Self>`
- from_unique now calls from_pin_unique instead of the other way around
- Add #[inline] markers.
- Use build_assert in pair_from_unique.
- Simplify transmute_from_arc
- Make macros consistently use full paths.
- Many improvements to safety comments.
- Link to v1: https://lore.kernel.org/r/20240402-linked-list-v1-0-b1c59ba7ae3b@google.com

---
Alice Ryhl (9):
      rust: list: add ListArc
      rust: list: add tracking for ListArc
      rust: list: add struct with prev/next pointers
      rust: list: add macro for implementing ListItem
      rust: list: add List
      rust: list: add iterators
      rust: list: add cursor
      rust: list: support heterogeneous lists
      rust: list: add ListArcField

 rust/kernel/lib.rs                     |   1 +
 rust/kernel/list.rs                    | 684 +++++++++++++++++++++++++++++++++
 rust/kernel/list/arc.rs                | 467 ++++++++++++++++++++++
 rust/kernel/list/arc_field.rs          |  96 +++++
 rust/kernel/list/impl_list_item_mod.rs | 204 ++++++++++
 5 files changed, 1452 insertions(+)
---
base-commit: 56f64b370612d8967df2c2e0cead805444d4e71a
change-id: 20240221-linked-list-25169a90a4de

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


