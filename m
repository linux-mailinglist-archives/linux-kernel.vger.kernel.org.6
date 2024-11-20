Return-Path: <linux-kernel+bounces-415958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D654D9D3E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB8A2851A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C31D432A;
	Wed, 20 Nov 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N19OBsQN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE801C4A00
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114580; cv=none; b=aVRFTLhCL8iq4GBafUkmhxG9JTnTMAsMeZD7kzk85RJtwQNVOs+d3dwDj4Bt8cvQNXesftiLDHFAZOWMHYpiZ4NPnA2cN49cQUJxDGZKqTIGV3fIuSljvJwkR5LI4ncoAfxEGIAnnMC0mw3y0N+KY4iK0/DIvwKqwyZrKPdN1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114580; c=relaxed/simple;
	bh=dT7Zkr+UIC4q/j6ipR4QBx4F66YP/oG6Xz0KcH1wcTE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lXkWBWCpvUVmE2XuqK/bxOmtJ7FWFaOxP9rbMoutJHke75tcswCW7/kMVw9lZ7m9uRQY0QFq+M25NOisZMdB8Rc+gLidCF0nBJ5CLm9yVTERPSUdudauOlfhpxDEY9Pekr7uUijfs5MZ0v8n65M3T0mnJ3i4PibBqmG/4nTzMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N19OBsQN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eeb889aeecso27430827b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732114575; x=1732719375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iHHs841g6FN7yTueS7BUd1kUsp73KLDPPhCP6P2iTMY=;
        b=N19OBsQNmTK8kKe5Ye6hR2coh31iK1yKawKh2OM9CSxo/F/hr1fRWzv7uTWiwIw7hK
         n57vx7xmEZZ7UNuVQ57Wa/hlloJT2vhxklPWevrRXMhU85cioaetMjiB2VOVHhZUVE/m
         OIjfsXFcT/ijsmATMDNsbOzmBH167Fo5+7dDUPWHLKHRZcFX22trtrNhX1LyzlL/pgp9
         VYxT/8wOLeYMjUQHIfc6kRwZNXu1lLTnphPtig7NCJNkdvN7YJBsW7fkVNIeVUmm17C1
         S8yKBBnQqeUUcGUj2NaDWPwUo+5Z+B8LsSDoIfSLVeZYJ1f44vRzYS4f0vaEyiQB0F+B
         5Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114575; x=1732719375;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHHs841g6FN7yTueS7BUd1kUsp73KLDPPhCP6P2iTMY=;
        b=X/L3fkOOy9PpsnBhYRmqUElp4MEeOB2t8Ol/PmSUQaPkr6jYNOfcBiumN2AW0JI4HJ
         8jWqYbGm9jTM+R7sTxYxvjGCpvDUrs8xakkC7G06qwNGQWQPiiI/Wqle+94yd5euwchO
         xdPQABxkbh+GDwrxr82fwTaxW6Xbs8cqW4Zxd2nkj8xDOq48zsygNefOuuuO5VOuroST
         pAeZrHeVt4aN2pvpq/e2bnjZFU4Kb/+dTL+1c3rqIjBXGiM1BW/y5XfVYoY6MIdLPJA1
         ITCyZfH+w78CboSGx2V+KgmdutrfVO0qaFLXIWSBJsFfXXJRYoHxs1HjCWcNUcQNArwT
         sNNA==
X-Forwarded-Encrypted: i=1; AJvYcCV878jam2QyQ1ulFXWVEtikEtavGws4j6ZGO0gzZBaqDN8nTXEAWamvp2MGkeTFj+SuhrFRSkfQByHZR6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rOh+FVpUsPc5SXsRbXJ7dh88Ag8EOcH8rwsV/cVO1r2Lp+il
	mhdoiLPRo2nDlaTnw2fLfvSgcVFxbE/jjoRw3HAgc3xKEo49VgpinACbGnied/K+sAV9dZdRHfu
	degfKQy4OVQixkw==
X-Google-Smtp-Source: AGHT+IH8MrrXVPZZuDuLH+xVKdoXCMLFK6Gn+/sxLCB228YDJMNSgRxGu7HWs9RTHvIoY8xY3Lm8XRbkj18WCBk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:a81:ad16:0:b0:62c:f976:a763 with SMTP id
 00721157ae682-6eebd0c2111mr172127b3.1.1732114575699; Wed, 20 Nov 2024
 06:56:15 -0800 (PST)
Date: Wed, 20 Nov 2024 14:49:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABL3PWcC/2XRTWrEMAwF4KsMXtdF8r+76j1KF04sZwydSUlKa
 Bly9ypjaDNk+YS/J4NuYqap0ixeTjcx0VLnOl45hKeT6M/pOpCsmbNQoAx4peVySbIEQIwllk5
 bwS8/Jyr1+97y9s75XOevcfq5ly64TR/9ghKlVinbxEWB6HUYx+GDnvvxIraCRe2Rb0gxSp0mG
 5XPvU4HpP8Rf7AhzSh3rsceUskpHpDZI9WQYQQRU/BgQzL6gOweuYbshgxgKGAzqe6A3B9CQGj ISZA5RNCxc8X64ya/R6YhzwiQtCrB8R3sA1rX9ReHdt8+1QEAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2963; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=dT7Zkr+UIC4q/j6ipR4QBx4F66YP/oG6Xz0KcH1wcTE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnPfh4SY8iEVd1Q0QPBJyy1bHyLIkOtvQvSBL9x
 38z3ZROFj2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZz34eAAKCRAEWL7uWMY5
 RkSZEAC0WX4fMT+IHnG7zNw/4rDQeAuCEzBqeNoDJ5m2kCr4TtPdsSfOPasI/kkB2enSi9V45aN
 F39b47+uzd17RtTxK3pK5M4Z48MKfDkLkM3shieJPdbsbmkoYfHX0S30lFMbFM1yepGTyxSILVi
 5mdp75tOU1qRdWdrANz0ITas85x4TvdIrBAr/6BmXh7bF0KJPrq+DycAMy/JnJi/y0IIRkkVwb8
 UuMC4PFOPHtJt7LUdsmpfS46Y3rZT3EAksgz+OvU20f78lDCSoViB/+EFN3xmCEv3fgIT/E0zNr
 tXLJ/PQ+nC2kdSuUDc3vUG8m4dxR19ojnJZzLORerAiQzYIES1cMItXFlj58PT8KH91d9Uga3x1
 3zltJ0fjTanM6lesx68GLBPzqBBRrRnYDbgniCZyeUHOqK8vPm4eDoDneTskU1Y29+hNgL71c64
 JKjL2fbO8ejnLujNijLkHzcN5w0AJ9hRonfdx4rDsCj37kacU1AGhiyxMnZ/f8niTqZEZV49p2H
 RQZhldSXsTF0WPDe99V9e3OM3UyJFgVL3NcxTIKhZ9cGjnT7pDA5h48x9muxdADV2OkHyy9d8uN
 Qs1OBhXFBHNiohASDBuLDejMDmEI9cgXcWVTbSsRTThTUL4LKYh6jZ7uvxoy4OIDgxCb8cG3NTO GM6NWL9oeWQmBQw==
X-Mailer: b4 0.13.0
Message-ID: <20241120-vma-v8-0-eb31425da66b@google.com>
Subject: [PATCH v8 0/7] Rust support for mm_struct, vm_area_struct, and mmap
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="utf-8"

This updates the vm_area_struct support to use the approach we discussed
at LPC where there are several different Rust wrappers for
vm_area_struct depending on the kind of access you have to the vma. Each
case allows a different set of operations on the vma.

This series depends on vfs.rust.file and char-misc-next which are
scheduled to land upstream in the current merge window.

---
Changes in v8:
- Split series into more commits to ease review.
- Improve read locks based on Lorenzo's doc: either the mmap or vma lock
  can be used.
- Get rid of mmap write lock because it's possible to avoid the need for
  it.
- Do not allow invalid flag combinations on VmAreaNew.
- Link to v7: https://lore.kernel.org/r/20241014-vma-v7-0-01e32f861195@google.com

Changes in v7:
- Make the mmap read/write lock guards respect strict owner semantics.
- Link to v6: https://lore.kernel.org/r/20241010-vma-v6-0-d89039b6f573@google.com

Changes in v6:
- Introduce VmArea{Ref,Mut,New} distinction.
- Add a second patchset for miscdevice.
- Rebase on char-misc-next (currently on v6.12-rc2).
- Link to v5: https://lore.kernel.org/r/20240806-vma-v5-1-04018f05de2b@google.com

Changes in v5:
- Rename VmArea::from_raw_vma to from_raw.
- Use Pin for mutable VmArea references.
- Go through `ARef::from` in `mmgrab_current`.
- Link to v4: https://lore.kernel.org/r/20240802-vma-v4-1-091a87058a43@google.com

Changes in v4:
- Pull out ARef::into_raw into a separate patch.
- Update invariants and struct documentation.
- Rename from_raw_mm to from_raw.
- Link to v3: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com

Changes in v3:
- Reorder entries in mm.rs.
- Use ARef for mmput_async helper.
- Clarify that VmArea requires you to hold the mmap read or write lock.
- Link to v2: https://lore.kernel.org/r/20240727-vma-v2-1-ab3e5927dc3a@google.com

Changes in v2:
- mm.rs is redesigned from scratch making use of AsRef
- Add notes about whether destructors may sleep
- Rename Area to VmArea
- Link to v1: https://lore.kernel.org/r/20240723-vma-v1-1-32ad5a0118ee@google.com

---
Alice Ryhl (7):
      mm: rust: add abstraction for struct mm_struct
      mm: rust: add vm_area_struct methods that require read access
      mm: rust: add vm_insert_page
      mm: rust: add lock_vma_under_rcu
      mm: rust: add mmput_async support
      mm: rust: add VmAreaNew
      rust: miscdevice: add mmap support

 rust/helpers/helpers.c    |   1 +
 rust/helpers/mm.c         |  50 ++++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/miscdevice.rs |  28 ++++
 rust/kernel/mm.rs         | 345 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs    | 404 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 829 insertions(+)
---
base-commit: 7f219f5002eb0ce2b12562127aeb0521bbf2146e
change-id: 20240723-vma-f80119f9fb35

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


