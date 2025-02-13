Return-Path: <linux-kernel+bounces-512748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070AEA33D57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC37A1340
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EF0214206;
	Thu, 13 Feb 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lr8+exX7"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F021420F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444680; cv=none; b=RMX4K/g24286cLvXUMdee/rlWpHCIFE4PUG8vy4bPvbIb6so5JlHOTUEXPPVoiuzziJ3YNi8E/PI8TPYOY7u7+p506NYqUSE2mSVfmEH1glDjJrGgBF42PdoqsNoTJJEwJ3AVqxidVTY03725lVxjM4TEcpd2JXARjh6D6NRiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444680; c=relaxed/simple;
	bh=hLnQzTlqJUpLYZOPmxfZzN82Dj0rBNMo1kF2NSwDm/Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Fw2tIQxGHKQ2WbKkLEfPcIoPdz5xfqeAuTzRta8ieJvlU7TeRuxzOmW7CcAJWk5RgSuBCP9ygP8Lwdjz6XGMkgl1bbJv2XYX2A8wXKQkRNrY74xU/vIEFyGv3OwR+HconM12sLVyMIOjd3E4QVD0V72XvKbTbnWj3fxNK3Qx+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lr8+exX7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438e180821aso3810625e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739444677; x=1740049477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8sIraLMTcSHYFNbgRkGQfIKI9Dkm/hcGG5yDyhtczYI=;
        b=lr8+exX74vE1RAW2+uGLj7YoIPy3ZwEybr0kXW1Nbd8vUCKfCeKp+xhSMaWn06eScr
         nBvnXVCV6XznIEf+OVo+VNIodo59dgG86RCSooN4N/ezgBZjdkacgap7BJkigmrkjE/5
         luqFISx090f3LcHQ94KwURwuSETDQBpOPOfVqGtd6h6qUpDCtmx4aBntXNOE9t8PiS6B
         leu2XQ/+MVgYzoROhdAY9bfe1Zrqq999Uj6bK/iaDPOS8RS8icsBST6UOyfYnkQsXyEs
         HVJIsW89KwLqDJ7Sgga6Np60Y94PbG+4ECIuV1bwnPv1Ou8sZDjYQobjS3fe+Ov8IcLt
         xxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444677; x=1740049477;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8sIraLMTcSHYFNbgRkGQfIKI9Dkm/hcGG5yDyhtczYI=;
        b=C3YeT0T3mN59Qa7U/5M58N3nR2y4pIIjGdJusSgRXAw9dKT2Rfw8W9JJ9bQeevZJ8U
         +KTrYRES/3WEQxLPdsb+orkNrfh8LRqlMvQVwPLYj90WXRkXZ+4sp+WnuPVF7YzwE0ep
         tbXzOPJ/l0u5nTdHAArpHl1BKcsRmhLhm+VfM/RlZY+fW4mlroVvHSxFxUmz+thiyGHR
         Wy/E97rYgpV+JQM2mE13XEPCFmtY48gU7U/NzRo2CJtuPj/oDgnQcvtd1DUxYfCz9IPy
         qVDfnad1WEZXneAowY5jxKHsyu+1iOvDl0OEix1n7/+E4Br10C64+6NpNnO7Ky6jMEHx
         AA7w==
X-Forwarded-Encrypted: i=1; AJvYcCUyS8ZKeoF0oQ7Uc/Eh9tPSSD3wnmH/ha1VmUYk8Zc+tbJEn0ThxLpPzTIpI26fRbuXVfdQObFI2HIx2nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8n44/5oUCQDvsCLr/9frgqglz4NhYUDagVWleRlNluURXw3Gt
	yC0r+HOBI0QLbvA68LNV0AfADQznvFApu1JKM1W8queWPfTZhmVobYnXpBL7C160SDmtlMh/dpO
	ElXTlesgLRYfSuA==
X-Google-Smtp-Source: AGHT+IFeJbxmgNkUd67pTqHr9xLxt49v4hGS4InUlnB3frDcfO94vjYdcWPTcm+KqK3hfJavANacJ88dKIoI9O8=
X-Received: from wmbjh8.prod.google.com ([2002:a05:600c:a088:b0:439:4036:8da1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b9d:b0:434:f5c0:328d with SMTP id 5b1f17b1804b1-439601a11bbmr30019455e9.23.1739444677115;
 Thu, 13 Feb 2025 03:04:37 -0800 (PST)
Date: Thu, 13 Feb 2025 11:03:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ/RrWcC/2XSzWrDMAwH8FcpOc9Dkr932nuMHezYbgNrU5IRN
 krffWqTNSk+BZv8ZCH9L82Yhy6Pzdvu0gx56sauP/EB1cuuaQ/htM+iS3zREJACS1JMxyCKA0R
 ffIlSN/znecil+7mX+fjk86Ebv/vh9151wtvts59QoJAUkg5cyOX8vu/7/Vd+bftjcysw0RbZG
 RGjEGXWnmxqZaiQXBE3OCPJKEXTYguhpOArpLaIZqQYgcfgLGgXlKyQ3iIzI31DCtAV0ClTrJB
 5IASEGRkBIjkP0kdTtK1fslukZmQZAWZJxRneg66QWxHS8pJjlKNERToFY+r2/BYtg/CMLJKNp
 U1Jq3pPCFvll+1ye0KlUngSMfC2araGAgmXVfGXmTFGgSJX2noY+IiF5tzohREzaTV4HzKgrXO BcmUE/xGUzCh678i4IL15Ytfr9Q+M5pzMHAMAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5737; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hLnQzTlqJUpLYZOPmxfZzN82Dj0rBNMo1kF2NSwDm/Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnrdGzeBJ5RqLDVa6MkQemTYrqLC6LzHhkD8CUZ
 gLFANXNBGCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ63RswAKCRAEWL7uWMY5
 RqjDD/0UFwc/XoVZ+C/UCMbJ7j/HtNooMQ9WHeYZBZZXSb/xEZNGh8MDTSFh3ZlLWOwEQMqvMnA
 CrQSTftCKT6xxeeD0l5qkS/6mszI3n69eC8fWVwvZ9vsLa3Liy68gs0qiUCTKin1IqJiViZn56z
 cB1lD0ajFMnxoLrMRrrKJcWFXjPZiT4AeADNrxo6q868eFRbdvEPYWo+P8iGP0jkEh2OvUWzYcU
 3GK77d3ywFxLOid38Gm7+ZuLoFYLk2u7BT74tPwBajLyOxUevvrQ+ans6D+Bhu5US9CvAYXQQ+c
 FuKUTOZ09eTpEOG+/4tPsbPUqVsIup1inwxIFsnq+3mXIa+0GKuUq/ieF7cf2z1oa6k/cOLn+ZA
 Ww5GVwoH7vPHTQW4KVFvLYxB8Jaz/1beliQWvM+ltdz8f2sd+lrNwXf3w8Pz0mbOnJYPMpdai4t
 V62uyT6aFhLOelhf7nykj8cxiU63MOBcmp1tFvYGVU6dVJrYuqEEfkVkpsI0UzSsg87+cPVUoA0
 hfJueWHYegEhmLrmHi62claUThcInw7XoGKBqR1xJU1Vtdxkw7KicWO2R3BOcpnwOi63BmwX1Tz
 3tdf55IfK1uQB4ucP2zfMAef6HizLBMyuqXNaT9RcZWr5Uaghs5o/3IZtSTMY8HNXKuhtKiHnSQ fUIBKx5I1KnjLTQ==
X-Mailer: b4 0.13.0
Message-ID: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Subject: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and mmap
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Balbir Singh <balbirs@nvidia.com>
Content-Type: text/plain; charset="utf-8"

This updates the vm_area_struct support to use the approach we discussed
at LPC where there are several different Rust wrappers for
vm_area_struct depending on the kind of access you have to the vma. Each
case allows a different set of operations on the vma.

MM folks, what do you prefer I do for the MAINTAINERS file? Would you
prefer that I add these files under MEMORY MANAGEMENT, or would you like
a separate entry similar to the BLOCK LAYER DEVICE DRIVER API [RUST]
entry? Or something else?

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
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
Alice Ryhl (8):
      mm: rust: add abstraction for struct mm_struct
      mm: rust: add vm_area_struct methods that require read access
      mm: rust: add vm_insert_page
      mm: rust: add lock_vma_under_rcu
      mm: rust: add mmput_async support
      mm: rust: add VmaNew for f_ops->mmap()
      rust: miscdevice: add mmap support
      task: rust: rework how current is accessed

 rust/helpers/helpers.c    |   1 +
 rust/helpers/mm.c         |  50 +++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/miscdevice.rs |  44 +++++
 rust/kernel/mm.rs         | 341 +++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs    | 471 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/task.rs       | 247 ++++++++++++------------
 7 files changed, 1037 insertions(+), 118 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20240723-vma-f80119f9fb35

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


