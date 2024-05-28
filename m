Return-Path: <linux-kernel+bounces-192577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804238D1F59
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F601F22EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D316FF54;
	Tue, 28 May 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jyr4jZOL"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80516F27E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908297; cv=none; b=sbUVVz4Vi+uNg3pN1pi6vO5c1+W2oWU/JeZjFNZyBlreVHL121CYBCCKdVtdhDQPqfBK+ENp4VEqVpqus/cpR6RpUIWQ6FJ/aEpj7N1WYFjy6FfyBQpX85qJcFrYV+cuh7yw057eIZF+HpkULQGUyIkUGmvgsk9gL3skC16tmEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908297; c=relaxed/simple;
	bh=UGSUXvJPMuX9Bkae/WPEm6A6AVU8nmv5zPwgw0bs7/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gkd5y9CDRg1YxPt2p5ng8giMZ721ZUEVCJOow+swuca481kdokMiQlPuq6dpCoNB8tvEKh3CIxAfciQtaGmrEHX4KQ9nQExVx2yVjHAbDSo35ZXkkedt4IvXmi8qazAYXYOUgOlxHI6hGdGRYmId1d9Q/rwc1sBC/GA5evrwohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jyr4jZOL; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-529a8d2c85cso867562e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716908294; x=1717513094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xLfLKzdeYSLpodZjM1TmVnfFmup+gWezC6j62g1XHPU=;
        b=Jyr4jZOLI2Te9/VtxKIaQRi4538PI190E+cpqB93kjBDis43Y9LIJSe1hHGBRs6O/4
         LLN3r4ycLleZP6f35C6I82l7MW5QRnZz5H2vIjcI7Wehu5olPWKQLSNgkZkzFyp5f3f5
         VzevJno7SexdE7QFUVtLuGb/Y15ShVYmhyFfHHEPDfH05BcHL0udiOAtMtUmR2rHaLV3
         gxlincMTiMzZZqPj9ZP81twa66Oz+EPSdC73ugxFpPUhqDhHWAQPUcJ1sMZ+iRRwtHh8
         ojqki2Dz8gApGsaOfoL6EkSJNk5gDlnqw/J4srvmsnnIY6Cm6xL3zI/NRM920ll2Lgfz
         aNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716908294; x=1717513094;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLfLKzdeYSLpodZjM1TmVnfFmup+gWezC6j62g1XHPU=;
        b=OcLwsKkwaue3dylrjq53BxvmoZXMogZFG+2vbgkLh6AwlBLfI3cOZt/AoG4tCFL+6k
         xYMKCQ8vUprf+rM7ZJ0YJmNB6jMCMEfTk3TItA8wyvj096VspWWROwhyZmNRYswZcoLv
         AK6kxW0idLz6tRBFBCwy1sIFP70i5bfk3RzWI6261RFFmgGGdCLFIWxaI9ZEMMApMNJX
         wr1du5LqTn9qsLy2D/hu3o5CrhKQyaUbiy1hDGeoEQAyS43R4p8pSkYDP5NCZF0gwL4y
         CHXKBjtB4ki6T3pQ2Wm98vIS3PWK5y2H40hdoj0hdaQFnF8AylllF177BcMsgDj77biC
         4phA==
X-Forwarded-Encrypted: i=1; AJvYcCVrS7N/YhoO2za/7vun1YDnyd1+CeJAagtYjso6uuotEEvwNe7aLzx5T1elaP1FN8AK7ywEK2TVkUKPFMsxtXczdY5NAX3Y6UBrRMOZ
X-Gm-Message-State: AOJu0YyZSHqJThXrRyqA+9pqjVb7RXaOxQfUt2ZmnqBACu/6MKIMtmFJ
	THWTe+4Tk3mOpsDF+bSytVplmolg8SEzJPbwTsofLltVREcsL1w61Oukj+1SyeTWaoflNgG+M5i
	ReMW021Z+XXVqhg==
X-Google-Smtp-Source: AGHT+IG5oCwliI55QSm/nlB6Lw5lzzQdTvktowkRPiBa6vXNuKdy+E+CON0y6SPl/fSx7Q5eHzfvSrmI1t/i15A=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2c86:b0:529:b6cf:cd0c with SMTP
 id 2adb3069b0e04-529b6cfcebemr3146e87.2.1716908293547; Tue, 28 May 2024
 07:58:13 -0700 (PDT)
Date: Tue, 28 May 2024 14:58:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPnwVWYC/2XPQW7DIBAF0KtErEsFw0BIV71H1QUeDw5SHFd2Z
 bWKfPcO2ZjKYvWB9xkeauG58KLeTg8181qWMt0lnF9Oiq7pPrAuvWQFBpy1EHW6FWI9jroj7xz
 6QMxRyfWvmXP5eVZ9fEq+luV7mn+fzautu7UEjQXcS1arje5t6ogpOkJ8H6ZpuPErTaOqLSvsE
 kzz/ApVRrDg5QBTOEi3Sxm9kU4k9fncuSTyQgeJu5TVSBSJlxQRECgbOEjfSOsb6UWG7D1jHzl 7e5Chle0/Q522i9mx70OM+Z/ctu0PVYM4psMBAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5369; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=UGSUXvJPMuX9Bkae/WPEm6A6AVU8nmv5zPwgw0bs7/Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmVfD/kk+kkk74MgEVp2uFripge2b1MUFf9QTh8
 lMpBFLiVYqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZlXw/wAKCRAEWL7uWMY5
 RjK4D/9tsWpL60+RGj9Xb+y1ietr1OB2e/gUpbdzbfoK8fTqVGvkw1xvetxbsGyDjHtkhrB/Qou
 uzTgJBqVbbBBXK6Udk7MXKirnMOpoW3L05zP9fDm8p4JRFvwX69B5p0d+9YplqWmjEFBPg3Qv+I
 kvW4YcV4gq0LP9wYQDHoE9CoIUq5vR9gmtxRz2xPRjSGUXiJJCTquL23dOaJ1AVPRoeZTi0xde4
 0NPm/CAPEXCye1BY/G/favUIfvl3jPSQjPdETIwpv9jEJ/ASp5Hgwr78ij/lzl25FxVEqjRloaQ
 Ob5pcTDrxJ+5porJkDPaHxsKXVVqunRKepKIyrL/xEe2Ykd5upy/kQR+3CBeZMd5WPy6UTqYzJP
 rEXlKc+ha895BR8UMiCbd2ezCpBy7Si5u3oJvoBR/E2ZVESfzu1uWghhsVUs6KA1IMo2iwHJzgm
 d2XAJJcHCRHHuvJt4OqXqP7gXEDeJ/JGZ2sVCV2GLcn+7TUc1ibp10BySSlCWgolC6Yxtz/HLO3
 SZAGc7hvjI4okhSdcXOFf8Qnc5JNodCoFX4fL237/v/Z/nXXgN2yu5dDsnnPToW+d6qSXkSs6RG
 NppAJvA0n53Rpn1pMIGQNXCTf0+YpZSGgAKobh3c3CrSsPfYTQK4JSlHWDFrV77nw4vwCVS/Vwd uanXNPTOk0FEDKA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
Subject: [PATCH v7 0/4] Memory management patches needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

This patchset contains some abstractions needed by the Rust
implementation of the Binder driver for passing data between userspace,
kernelspace, and directly into other processes.

These abstractions do not exactly match what was included in the Rust
Binder RFC - I have made various improvements and simplifications since
then. Nonetheless, please see the Rust Binder RFC [1] to get an
understanding for how this will be used:

Users of "rust: add userspace pointers"
     and "rust: add typed accessors for userspace pointers":
	rust_binder: add binderfs support to Rust binder
	rust_binder: add threading support
	rust_binder: add nodes and context managers
	rust_binder: add oneway transactions
	rust_binder: add death notifications
	rust_binder: send nodes in transactions
	rust_binder: add BINDER_TYPE_PTR support
	rust_binder: add BINDER_TYPE_FDA support
	rust_binder: add process freezing

Users of "rust: add abstraction for `struct page`":
	rust_binder: add oneway transactions
	rust_binder: add vma shrinker

Links: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v7:
- Fix call to `reserve` under `make rusttest`.
- Add comment on _inline_copy_from_user.
- Add Reviewed-by tags.
- Link to v6: https://lore.kernel.org/r/20240418-alice-mm-v6-0-cb8f3e5d688f@google.com

Changes in v6:
- Base on top of Wedson's Allocation APIs patchset.
  - Do not define my own gfp flags, instead use the ones that are now
    available in `kernel::alloc`.
  - Add gfp flags to `read_all` methods instead of always using
    GFP_KERNEL.
  - The __GFP_HIGHMEM flag is not provided by the Allocation APIs
    patchset, and I do not add it here. I will send a separate patchset
    for adding it.
- Use usize instead of void pointer for userspace address.
- Add _raw suffix to `fill_zero` and `copy_from_user_slice`.
- Do not allow interior mutability in AsBytes/FromBytes.
- Doc changes:
  - Mention that validity of user slices is checked at read/write time,
    not in the constructor of the user slice.
  - Mention that methods can also return EFAULT if a bounds check fails.
  - Mention that methods may have partially copied data even if they
    return EFAULT.
  - Add link from `read_raw` to `read_slice`.
  - Move comment about initialized memory on `read_raw` to
    `# Guarantees` section.
  - Add examples for `Page::alloc_page`.
  - A previous version renamed UserSlicePtr to UserSlice but forgot to
    update that in the commit message. Commit message fixed in this
    version.
- Add Reviewed-by tags submitted on v5.
- Link to v5: https://lore.kernel.org/rust-for-linux/20240415-alice-mm-v5-0-6f55e4d8ef51@google.com/

Changes in v5:
- Fix casts in declarations of PAGE_* constants.
- Fix formatting of PAGE_MASK.
- Reformat comments at 100 line length.
- Minor fixes to safety comments of `read_raw` and `write_slice`.
- Link to v4: https://lore.kernel.org/rust-for-linux/20240404-alice-mm-v4-0-49a84242cf02@google.com/

Changes in v4:
- Rephrase when we fail with EFAULT.
- Remove `pub` from examples.
- Use slices for raw uaccess methods.
- Fix PAGE_MASK constant.
- Rephrase most safety comments in Page abstraction.
- Make with_pointer_into_page and with_page_mapped private.
- Explain how raw pointers into pages are used correctly.
- Other minor doc improvements.
- Link to v3: https://lore.kernel.org/rust-for-linux/20240311-alice-mm-v3-0-cdf7b3a2049c@google.com/

Changes in v3:
- Fix bug in read_all.
- Add missing `#include <linux/nospec.h>`.
- Mention that the second patch passes CONFIG_TEST_USER_COPY.
- Add gfp flags for Page.
- Minor documentation adjustments.
- Link to v2: https://lore.kernel.org/rust-for-linux/20240208-alice-mm-v2-0-d821250204a6@google.com/

Changes in v2:
- Rename user_ptr module to uaccess.
- Use srctree-relative links.
- Improve documentation.
- Rename UserSlicePtr to UserSlice.
- Make read_to_end append to the buffer.
- Use named fields for uaccess types.
- Add examples.
- Use _copy_from/to_user to skip check_object_size.
- Rename traits and move to kernel::types.
- Remove PAGE_MASK constant.
- Rename page methods to say _raw.
- Link to v1: https://lore.kernel.org/rust-for-linux/20240124-alice-mm-v1-0-d1abcec83c44@google.com/

---
Alice Ryhl (2):
      rust: uaccess: add typed accessors for userspace pointers
      rust: add abstraction for `struct page`

Arnd Bergmann (1):
      uaccess: always export _copy_[from|to]_user with CONFIG_RUST

Wedson Almeida Filho (1):
      rust: uaccess: add userspace pointers

 include/linux/uaccess.h         |  46 +++--
 lib/usercopy.c                  |  30 +---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  34 ++++
 rust/kernel/alloc.rs            |   7 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/page.rs             | 250 ++++++++++++++++++++++++++
 rust/kernel/types.rs            |  64 +++++++
 rust/kernel/uaccess.rs          | 388 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 782 insertions(+), 40 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20231128-alice-mm-bc533456cee8

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


