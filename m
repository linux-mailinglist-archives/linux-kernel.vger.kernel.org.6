Return-Path: <linux-kernel+bounces-544062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3AA4DD00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C401897402
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B841F37D1;
	Tue,  4 Mar 2025 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YmTW5ger"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0791FF611
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089102; cv=none; b=BIMPndCkoLvJ8O4dlmj8NsmwEg20v2xL26YJRjdGA84UmsQMI4JB5MgUB2Ae/FJK3yHfpKlteKcCAszJtNv5nztpZnaEA9n+IYtqOtmgANeaxbL8twiSaRNJRGsvJ8pjgpdrEDU864jP9j/JgoUHaxih9yxTt+7L1Ye5vo/H4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089102; c=relaxed/simple;
	bh=NwdlXBp91suBvdquLQL/XnW+o+xMpSj1KHTlbK0Pvm0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XygNKN/7322cH7Vs5cFuS4BfsocGUdEt/7tNQiutujh0gZsD+wfXKatxKM17FAHxSS2lX5dbTxjD6njLu2z25WEZZ2D8BNDRPNMabDp/o/45yt4UoL9kq0ehKJ/Kymjf4JWZJlAELP/XjMhj4H51M6KGoX4vqSC9jS4l/ySy9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YmTW5ger; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3910034500eso1236094f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741089098; x=1741693898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5VR+CHHcyx5AF7iuNrkqFuQjQjQZydJwiWIKCLfBoH8=;
        b=YmTW5ger6MavdNRhHBdqVTgghyXfXe2CCn626GPzkYXnINgfQzt1ov5MN4C1VYS3lH
         hFsMn4doaW7aNg4afAYLcAwHdA5a8jvzAq1TwRxoPIn/yNlFdNJwkoSFtOPz89REo0yD
         5Gkv1l08WlagQBZSXXhKIuZ+mYdYNVc9ZcdDOWHQOFzifrrwB6Go3R8/xQVUNGeGoEsS
         1Aew1dEYnsXExJPc7ymOhUg1QjBczVbs0g2jqQdHA9x85IyuPLzYZDzAd6mvS8+1cwkU
         lJcJdkn3hDvudAZiKdryMVWWOzNk6ab2l69/MyHbhkzXrxkOubATxmyjIla/KsWCEEcC
         TEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089098; x=1741693898;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VR+CHHcyx5AF7iuNrkqFuQjQjQZydJwiWIKCLfBoH8=;
        b=WlnY6eEzis/Ob+eC9J/wXmk2H0Fr9Vt/wWWXJwXAlM7q74+qtkaTeRUqLaQhXO+HVv
         IzN8zJVGRLb4iaxpk5OtETImJzsCGGdCstOBWQB3l8Mfl+uXbjiz8H5QU8SMrSYx8DGs
         mL7CReWng5LwtAGLHOJh3O8Kpr83F3Z7eTg8wIzzvD6Ek/RjjNx2Tie+xYjH/XKruq+B
         /5FEhTAVTZd4ULvuWfAACiNiNFZNblDp2PdsDWFc6RvW9v2zKXJdboOXxUHyEN9Llffi
         GTjMwuZEhQ+cktxDkbHbBmL5CcDB/GZjstxy7v48raqoEpDykI+27QJO5Qa0BVMPipPh
         NF+A==
X-Forwarded-Encrypted: i=1; AJvYcCVmtanqRQbKHtFaSQKi5cv1wpJxsLEoz5RjDVlVByHwrF60Os0VsGvMrofETakwgpq8MwZdvQQAZSyDWEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkY4HvHlDm/OkSi79Cgv4v7o6pElXR3mRnv4S5Tkh10iz0Xyf
	HJRgPryOZ8nZYbEY/ZOPwsnTh1AgxjPwNNacfHbAWQx67zu8ExPpzWV0ahodrx99befD6KrUdT/
	jBtsuTsBc9xeP4g==
X-Google-Smtp-Source: AGHT+IE6Yp/kONQSenB7CkTnqEQnBf1Pis4IgJ3Xzjvn4XSRvP79u4TgWgk7in02UfNVJASQDYA7IE8CCDm+pkc=
X-Received: from wmdd10.prod.google.com ([2002:a05:600c:a20a:b0:43b:bd03:5d2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:59ab:0:b0:391:1806:e25c with SMTP id ffacd0b85a97d-3911806e37fmr1460068f8f.17.1741089098650;
 Tue, 04 Mar 2025 03:51:38 -0800 (PST)
Date: Tue, 04 Mar 2025 11:49:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN/oxmcC/2XSzWrDMAwH8FcpOc9Dkr932nuMHezYbgNrM5IRN
 krffWqTNik+BZv8ZCH9z82Yhy6Pzdvu3Ax56sauP/EB9cuuaQ/htM+iS3zREJACS1JMxyCKA0R
 ffIlSN/zn95BL93sr8/HJ50M3/vTD363qhNfbZz+hQCEpJB24kMv5fd/3+6/82vbH5lpgoi2yM
 yJGIcqsPdnUylAhuSJucEaSUYqmxRZCScFXSG0RzUgxAo/BWdAuKFkhvUVmRvqKFKAroFOmWCH
 zQAgIMzICRHIepI+maFu/ZLdIzcgyAsySijO8B10htyKk5SXHKEeJinQKxtTt+S1aBuEZWSQbS
 5uSVvWeELbKL9vl9oRKpfAkYuBt1WwNBRIuq+IvM2OMAkWutPUw8BELzbnRCyNm0mrwPmRAW+c C5coI7hGUzCh678i4IL2pmdowvDPFLJJvlQ2RsDwP/3K5/AOSDidaUwMAAA==
X-Change-Id: 20240723-vma-f80119f9fb35
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5805; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=NwdlXBp91suBvdquLQL/XnW+o+xMpSj1KHTlbK0Pvm0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxuk50oJZrXCEA0r0NvHxTLVUmvlrJsg9F+k4m
 pPzMts43qCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bpOQAKCRAEWL7uWMY5
 RqlAD/9sz4JNKYz9SKoXPPERqoYnoMjn0mz7sCTJw+w97meELPXF5H2y5MyuBW4nBfDkxEfVRkE
 kHxYtc4GXGrdPQ1nKnCacuoRfJEKPYLyyy2JDuHfIOK4eDdH3Nln3nbkTtM2A6S0q21JbvQffoe
 9Z5L/eMa+oZIoWgLEC13XeumIvKFkWuFY8aE8WW7OVt+Qacnn2Ai8oAcSbaY3FV+aHlGwxA5bhU
 fl/PEp7KhGbPHqGwuYFie+k0uMUBs0Hj+ywqJI7n6pAqrOPBbwimx5YK4lcEUe/3LqB0jnG723G
 TIHCmigyIgLGSXsGLYFNdVKiaNplmL7EZHVW5lH5R/tFX75MD16Xdies/q+/T1DhKZhjgbU6w3P
 64aCUfF9kwniNMVTMy8qPfPso1ZjlLuqRv5Z9Vj4TJDsHj1sDT/EIwUQ9qDBiZXjibPZqQDP5i3
 k5Hgu34tVda279VTQG0M8JInHrXF7SJEMN5kNTkgU3gHoiXxxAwAHxHiY6PReYtT4lkucGGWfpI
 bnaxnOn/wePU9F08ZWpcCyrrF9mYP8W37XVXSF8BnnztonnZ7dWtlv1/5a7xnV2hpcfdFkxWqaf
 4ui+qo8dwdMaFsIOkrzkI1QcfqYPxcRqi82wYNMPu+k3RB+PrdYOWgQZJ9lmuWPBmHZR1Q45pNL 9PGjZ0sBT91Yjyg==
X-Mailer: b4 0.14.2
Message-ID: <20250304-vma-v15-0-5c641b31980a@google.com>
Subject: [PATCH v15 0/9] Rust support for mm_struct, vm_area_struct, and mmap
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@Oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Balbir Singh <balbirs@nvidia.com>
Content-Type: text/plain; charset="utf-8"

This updates the vm_area_struct support to use the approach we discussed
at LPC where there are several different Rust wrappers for
vm_area_struct depending on the kind of access you have to the vma. Each
case allows a different set of operations on the vma.

This includes an MM entry as proposed by Lorenzo.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v15:
- Add MAINTAINERS entry.
- Pick up new Acked-by and Reviewed-by tags.
- Link to v14: https://lore.kernel.org/r/20250213-vma-v14-0-b29c47ab21f5@google.com

Changes in v14:
- Rename VmArea* to Vma* as suggested by Liam.
- Update a few comments in patch 02.
- Link to v13: https://lore.kernel.org/r/20250203-vma-v13-0-2b998268a396@google.com

Changes in v13:
- Rebase on v6.14-rc1.
- Remove casts that are now unnecessary due to improved Rust/C integer
  type mappings.
- Link to v12: https://lore.kernel.org/r/20250115-vma-v12-0-375099ae017a@google.com

Changes in v12:
- Add additional documentation to modules at the top of mm.rs and virt.rs.
- Explain why the name Mm is used in commit message of patch 1.
- Expand zap_page_range_single with docs suggested by Lorenzo.
- Update safety comment in vm_insert_page
- Mention that VmAreaMixedMap is identical to VmAreaRef except for VM_MIXEDMAP.
- Update docs for as_mixedmap_vma.
- Add additional docs for VmAreaNew struct.
- Rename `get_read` -> `readable` and equivalent for write/exec.
- Use mut pointers for `from_raw` for VMAs.
- Update safety comment for fops_mmap.
- Add additional docs for MiscDevice::mmap.
- Don't introduce and immediately delete mmgrab_current.
- Reduce active_pid_ns comment at Andreas's suggestion and link to get_pid_ns.
- Fix documentation test in rust/kernel/task.rs.
- Fix warning about unused variables in lock_vma_under_rcu when
  CONFIG_PER_VMA_LOCK=n.
- Fix minor typos.
- Link to v11: https://lore.kernel.org/r/20241211-vma-v11-0-466640428fc3@google.com

Changes in v11:
- Add accessor for the vm_mm field of vm_area_struct.
- Pass the file to MiscDevice::mmap for consistency with
  https://lore.kernel.org/r/20241210-miscdevice-file-param-v3-1-b2a79b666dc5@google.com
- Link to v10: https://lore.kernel.org/r/20241129-vma-v10-0-4dfff05ba927@google.com

Changes in v10:
- Update docs for `set_io`.
- Check address in `zap_page_range_single`.
- Completely redo the last patch.
- Link to v9: https://lore.kernel.org/r/20241122-vma-v9-0-7127bfcdd54e@google.com

Changes in v9:
- Be more explicit about VmAreaNew being used with f_ops->mmap().
- Point out that clearing VM_MAYWRITE is irreversible.
- Use __vm_flags to set the flags.
- Use as_ and into_ prefixes for conversions.
- Update lock_vma_under_rcu docs and commit msg
- Mention that VmAreaRef::end is exclusive.
- Reword docs for zap_page_range_single.
- Minor fixes to flag docs.
- Add way to access current->mm without a refcount increment.
- Link to v8: https://lore.kernel.org/r/20241120-vma-v8-0-eb31425da66b@google.com

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
Alice Ryhl (9):
      mm: rust: add abstraction for struct mm_struct
      mm: rust: add vm_area_struct methods that require read access
      mm: rust: add vm_insert_page
      mm: rust: add lock_vma_under_rcu
      mm: rust: add mmput_async support
      mm: rust: add VmaNew for f_ops->mmap()
      rust: miscdevice: add mmap support
      task: rust: rework how current is accessed
      mm: rust: add MEMORY MANAGEMENT [RUST]

 MAINTAINERS               |  13 ++
 rust/helpers/helpers.c    |   1 +
 rust/helpers/mm.c         |  50 +++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/miscdevice.rs |  44 +++++
 rust/kernel/mm.rs         | 343 +++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs    | 471 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/task.rs       | 247 ++++++++++++------------
 8 files changed, 1052 insertions(+), 118 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20240723-vma-f80119f9fb35

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


