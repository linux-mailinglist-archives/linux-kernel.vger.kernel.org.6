Return-Path: <linux-kernel+bounces-286059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA295161A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DC61F221AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB8313D24D;
	Wed, 14 Aug 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzAY+gAD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE7381D4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622760; cv=none; b=hYOBedcWp4LSfAaTdqxY+B3HxTZy6QsSNNc2rlM1wBfiy17WFtYNeaOftPMDIDapSiSsLP9kkoUi71uhKT0Q8MJa8m2OUGfuLaDuQ5+ZzFOzNYZIVpNwfiP3mJpgtXB5geM0Adis3mQPOxGJc7EgTZzJajIa8mWHvlP7KWlfCEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622760; c=relaxed/simple;
	bh=+eBaqh+2H5uYNm1+WlROU5qD6zqR1eTQrzPcjuqr8dc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c5AQV3pZE6NdmmE7h3VKeiczxBY+Rlr4CPWB+dUg//jwqV3zxrGGgm65cRcqniOGvHNWwutdHoRrAwP57s+ErWWXlOW1RKl+S9EiG2wBnL3Kp0nqxhPAhpp8yVPR6OQ0zpvO5ID/dbetBlpzu+p0xySA2M3sVNrz6AuFwNx1wug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzAY+gAD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b6584bbdcso10112789276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723622757; x=1724227557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=itE9r8x085HeFvCy6NcU4TMOBuRl7UvyUI5Grg2pV1o=;
        b=UzAY+gADUl7HxBg2I45bgt1VppJvGX/3XtzWJTfNcPcSrf0xpNMFOFsKuzK25CKgsj
         6NbViPxq6gt9gelBcQaNAEmZQ/5oxDmG2VkGlGCTVJeDKe9+JBNcx8p6ihvFbX3GyL3u
         xQA4t99FeSvBloCmLpgzus6S8BHPfellaDa9qt6gthDc/HayepWJsKBjnSmOqtqLExUk
         ABXSS57Oi2mTu5hxWW47D8Zehkr4cFkQ8R34EaEp99lIg0tzmEQaX0lmhsSiZZIlfYzR
         Xhh0UsPTI0kvpTEMkZQl4n6fpVNu886KCyckJyPzy+cVCsDPkgdaM99CO5tHk3X0tdKA
         x9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622757; x=1724227557;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itE9r8x085HeFvCy6NcU4TMOBuRl7UvyUI5Grg2pV1o=;
        b=wpzO/O5YivvvU55L5hdijSVe+W022RFHWcEBLtPqyZ5oH/C9WDUwOc/wyyeVs/y0rY
         FUzpIfrdDB/t/d4hpR2uVBrWcmkJSUE5ig1bO54jiN0GYuMEUvf2sBkJP7n40ziK/4Ta
         1iaeFgHsXaKsb+a0xF64q+s8NBDpyJak2QBesvCK8eaczTHjXOib0cNIV2g0nza9Y/xL
         eYuIPrBgFTLhlLsjD6bYPEAORn75tkrZnbDOxQ/6FsMCWu3FFs4+a4Ytz3Wc/PcHZBJU
         MDPtt9IpuHkw03Z10P4P3jKrhBj09EQFoNvMk+zcrsIZKyJu3WZJPWwkCZjQxnmBzxBk
         uJdg==
X-Forwarded-Encrypted: i=1; AJvYcCVOyx3xeTGIy9LG3ZOnPwsjI/4UUfoMxof+uUjkeddSCvpRjLFdW0LvRfFZ3PiPfpSuXB9TlrX13B15gljPie/Rzino3pL7yyHxqsou
X-Gm-Message-State: AOJu0Yx0c7WmtvlfceXt9D1QeH2oKetqD7wFH798qAPEDo8jM5scd6xz
	rFixXGyrabFUkWcU1wzL7ShZYKEmxK9AG3naWiIJluBkJ0WRNqu7RDSqdJvcMKCbPnv53azR3XU
	6Qu6V/3Zbhhybfg==
X-Google-Smtp-Source: AGHT+IHpMYFxTBuHXu1qN09szTEr2M7FiSNTeEYxLMTDlbu+ZlpNeGClNDeZ+xxZvwL2SN19mEI2gB/bjN54Ko0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5b:389:0:b0:e11:5c41:54e2 with SMTP id
 3f1490d57ef6-e115c4155b1mr2792276.0.1723622756875; Wed, 14 Aug 2024 01:05:56
 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:05:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD9lvGYC/2XNTQ7CIBCG4asY1mJggLa48h7GBT/TStRiWtNom
 t7dURdN7Yp8hOdlZD12CXu234yswyH1Kbc0zHbDwtm1DfIUaTMQoAWA5NfUXjDS0T84GFlYZ4X
 TERmJe4d1en5rxxPtMz3K3esbH+Tn9teh0qIzSC64l8FY70qHyh+anJsr7kK+sU9ogBkbUSwxE C69laLSIlhZr7CacQlqiRXhykZvIZTR13qF9Yyr/581YVBYByMFBgsLPE3TG6RBl3JeAQAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4254; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+eBaqh+2H5uYNm1+WlROU5qD6zqR1eTQrzPcjuqr8dc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvGVGG0ATvdsfGHhQPvBlD36YHhNeOwZ3G4fFw
 Ml/YTrHIVyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrxlRgAKCRAEWL7uWMY5
 RpVFEACwaS6W/oqMFD2u/PIcvbmnM/arvfH3Q9dUeSW54Hm6xUcr5HlOm5vlbooUR50UuyNbyne
 xgUaJfJK6EIDLboLtS9zQ8mUqK9SdOmKDJdxrYmOLpM4WXvcEWLEqUJhXHFKoklFiu+jK8haTtU
 VDMjHwtIIacj+W8yJEa/Mdw+F/0khUTz9q3MO2VEsXIVyxV+SditRp30z6/Ai1ITLsKQ5Q1KQm4
 oVyKerK4YoF2FoXZPMWqufVcZpUr/OS2VdtcajX60H9iRT3TaWShW389jV1MtlNojtNBiqFMOoL
 iIbfSIAgPySz0o/EBM9vwcIMnhgW4ug7DQ8mNxfeN3kE7coEWNo/miLBWK1Q5IH+GYj23DTNQ0s
 BWIgHapx70tpdQc9z01iVcSevJlnC02gN8BAHANU7cvRWA06LgTPN5/Nxowdz+l1Z+/fGG5uRTJ
 ZBbogW2xtlf07cCmWby+/jrtFT54bWESr82MIcxWv68xDNORbidt/N7O8vbjYuvdV9FP1lrl5lT
 Evhjby53tiLfodS4/v//DXMlGncb9Bz7oFt1ypWnPyMfX15LMY9bvsZODJmmvuayU/9h7aiL+nX
 PJuhTw33unZOX6CLMYHW0LtBZFAquIYoCn6BBhfH9afdMyJ71+x5w2QwtAwURpQ12ZDg5GGOxBB g8JnoMD4REHPFyA==
X-Mailer: b4 0.13.0
Message-ID: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
Subject: [PATCH v5 00/10] Add Rust linked list for reference counted values
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
Changes in v5:
- Reword: "must not change implementation" -> "must not change behavior".
- Fix mixup between zeroed and uninit.
- Now all patches have a Reviewed-by from Benno.
- Link to v4: https://lore.kernel.org/r/20240806-linked-list-v4-0-23efc510ec92@google.com

Changes in v4:
- Support several impl blocks inside `impl_list_item!`.
- Link to v3: https://lore.kernel.org/r/20240723-linked-list-v3-0-89db92c7dbf4@google.com

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
 rust/kernel/list.rs                    | 686 +++++++++++++++++++++++++++++++++
 rust/kernel/list/arc.rs                | 521 +++++++++++++++++++++++++
 rust/kernel/list/arc_field.rs          |  96 +++++
 rust/kernel/list/impl_list_item_mod.rs | 274 +++++++++++++
 7 files changed, 1674 insertions(+)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240221-linked-list-25169a90a4de

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


