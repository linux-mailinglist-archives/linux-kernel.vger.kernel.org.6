Return-Path: <linux-kernel+bounces-259738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5E939C82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D93D280D07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19214C584;
	Tue, 23 Jul 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsXB/5zR"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238F13C9D5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722975; cv=none; b=T5Qm/C0+DmXxCOdWcVooYZ/wemVccRdnEg2d/CbR1AS1lw7GbFA15DAhmg3F1Dkz5quYxfHcuefZluq81JV0LnSOD72J2XVM6eZH30nLANiCrfa/30fSFIYNsbktvTiDDQV8x02wT4oP9wL3DtUeWtPq2dVQk8oqcFH6x+44Y4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722975; c=relaxed/simple;
	bh=gO+wMa98KpOtz97bqT2YMqnZVUaR6iSWiIIQ8donbhc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qL+68BusVGNJshIw9l9EaEA+LHAxjvb9OlYyrfyS5x0BCAlS/9oC5TeeJdtUra0XvymOYrM1ZuFcmX/KMpyqJUhdVY1IFw4vN9TkMbTTQum+6xn43GZ8YpXcQIb8qksHwP24o3FZuhmtUGZe3OK0u94knd0Y1gNXWMhwJ+eY8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsXB/5zR; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-52efc9f2080so2454426e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722972; x=1722327772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3DveBYTWAJnx7XdYizqRmZotehtZ2DxuY6C3RxIRdU=;
        b=OsXB/5zRK7fdq6q7uh7U6cuod4EZmqr1XtTQZCZ525sGbXIzkPZGkmTjqPEUkB+JVF
         gM1nl78ETD8EvhKpwf8DRZvuPEg/6qtf0M+cbZ00vtMjN9ELJNItffCpmTHgSEEtFV++
         b2T/IEUqFH+BSJSwjSMxdnW4zkf1VgMpeBytJFz/Gouikebc/JbvvBeLff7U4Gh2LTBn
         2qFiMA2sLzXdoCmyNRIkXaAF/qJnRYO3gXbwP2asJccXEl22FvDGZPFrN65VQERKahke
         +8U+Iag6H9na52WqT2MJZISDL78/rA7A/YhSWAXiaPHRjTCG9hpZW7cfCit15EgdTui6
         vOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722972; x=1722327772;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3DveBYTWAJnx7XdYizqRmZotehtZ2DxuY6C3RxIRdU=;
        b=DtDJjO7sDTetGxosgPHR7oLllYwSP9acRwUugmZlns4KUr4K8MWlNsGUTJLR7vzQlH
         f8i09IErsnNLws3cEaVREjiJhOm7Dj3x5GlKlLjaGu++uuI77nwQO55f7LME50ViIHaD
         7xK5l84OHHAihR/NUIjiNP3PtqBRQUbySLg0vYMQ4e6LlSooRAOjE/oxdmkrYPLD5adm
         BIQHE0QvahUdFJvbUFlvB4vHP73u8MjCw6PIq7mWgdF8rdjnYhlVm1D4iW43ULTSwoTF
         DULujbP7hEqwyhhXtPaptwRpiw+VqP/YR58O4WDRDVkYL36M6yaP70FQ5oz8ndkzORhd
         MkXA==
X-Forwarded-Encrypted: i=1; AJvYcCUhRFpRfYXQ2Sgz66b68K1sSyYG4HDwCAXaSN5ITvUWubTjeHP2HEvzgNlGVqQY9OJHPMjKfpDIMC24WjNx/lRzKXGELQfVLwcPUU0X
X-Gm-Message-State: AOJu0YziPCHt9NJD72IlAsu+CZESKqnrBRcZ7EGL3z9y1MVzqTAkHTNP
	ECDltCWXonQWEvPKpPT1P9qapltwKk68AZyO4533whlwKCHcxDcZtBfZD/Vn8x9xR+FBJFEauEF
	BPqGApCgfECHm3g==
X-Google-Smtp-Source: AGHT+IFVkYWVOmHKCqfnB+1HrIPZZ4jGUzaHalitsXB3nRoJ2dKE5NvEOGJy5VBWzTAYz7//zspBBGg58Txs6wQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:b14:b0:52f:357:4a38 with SMTP
 id 2adb3069b0e04-52f03574b77mr7242e87.11.1721722971317; Tue, 23 Jul 2024
 01:22:51 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:22:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAClon2YC/1WMzQ7CIBAGX6XhLIalf+LJ9zAegG5bYgUDhmiav
 rvbejA9bWbzzcwsYXSY2LmYWcTskgueoDwUzI7aD8hdR8ykkJWQEvjk/B07OunFZQ2N0kroqkN
 GxjNi795b7XojHmkU4meLZ1i/vw6Vdp0MXHADtlZGtxpLcxlCGCY82vBgayjLv1yLZi9LklujQ JwqYRX0O3lZli8ct6go5AAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3813; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=gO+wMa98KpOtz97bqT2YMqnZVUaR6iSWiIIQ8donbhc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn2gzs3Z+jtx94W/68uOkFwbtbHfRxHgdFvSb9
 FvoAnwsrh2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp9oMwAKCRAEWL7uWMY5
 RrrbEAClecL++mNJtIWVwFz7MH0h3twoELhhIuKkUIGh+x4b4MQsm9AHRlX0z8579mbTXaweEa9
 /HUtNF5s3Y54CMunYvcGOxmwi56lhYbD4wIOblunb9YrwXSE0qc7GrwJCwi3D5DUOEZYTEdKL0X
 zJp6Ik3r1Ak7xDkMhgrJG88aaH0F3yxobXA3MHSW4ku1+XJB1X021UtzkZXd4UnEkv798c02doy
 WXkYLcn/NoWZShFMRgmuhIp2jU/PKRF9u9bEAlZ0j57CkIyWDtGRHghzjUmfgF2OJwKioWZVsnx
 i1GF/cqz/VKh2B9aCuJQ8KcOd3TocCHw2yXlOFCW0jPXeIV0KPmEWA8FeSubIV+rTHvcIQiE0je
 hpjMj4KiGbz8xygr8EVwxCfZrRQjWsCdAW+dLyR+Arr8riTzCSettYHIdFvyEbKrMcEd6ZxrXFl
 7Ne1F3oT5csgMFETn5S5egEb7c6WCUBN7Zu3UjOP1oWaTKHS9XAP7jn1+JZwMGlmdi91Lrqh37f
 UT34FVmXvqZq+H+emC+EmYYOAGq/UZUs1vTxr9YxUV667OW16BzUQVVMCL84uzxhLKQAuVcN92B
 u1YIa9XjlZdEP7rad+OupX9Y61we1TROZWjfX6lrc55akstODm7gUMX9VSUWX99tigdE9TKwk7B 68dRghiXBYPMHRw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
Subject: [PATCH v3 00/10] Add Rust linked list for reference counted values
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, 
	Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
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
Changes in v3:
- Add `assert_pinned!` macro and use it to ensure that the field is
  structurally pinned when using the tracked_by strategy.
- Improve ListArcSafe docs.
- Use From trait for UniqueArc->ListArc conversions.
- Implement AsRef<Arc> for ListArc.
- Improve safety documentation related to ListItem.
- Improve invariants of List.
- Other minor docs improvements.
- Add Reviewed-by tags
- Link to v2: https://lore.kernel.org/r/20240506-linked-list-v2-0-7b910840c91f@google.com

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

Benno Lossin (1):
      rust: init: add `assert_pinned` macro

 rust/kernel/init.rs                    |  67 ++++
 rust/kernel/init/__internal.rs         |  29 ++
 rust/kernel/lib.rs                     |   1 +
 rust/kernel/list.rs                    | 685 +++++++++++++++++++++++++++++++++
 rust/kernel/list/arc.rs                | 508 ++++++++++++++++++++++++
 rust/kernel/list/arc_field.rs          |  96 +++++
 rust/kernel/list/impl_list_item_mod.rs | 268 +++++++++++++
 7 files changed, 1654 insertions(+)
---
base-commit: b1263411112305acf2af728728591465becb45b0
change-id: 20240221-linked-list-25169a90a4de

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


