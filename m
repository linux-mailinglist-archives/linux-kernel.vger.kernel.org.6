Return-Path: <linux-kernel+bounces-418422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40229D6172
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840072825AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DF1DED7F;
	Fri, 22 Nov 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2GfW2jy"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566E1DE2BD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290065; cv=none; b=O0IsowonTUQlk98CmxhmbbFtWqrZyUYGvej19sTIwl5MyvcfCWs8lfaR2JRl59f08B71YP1C6EmnupiJTe1qCQ3fYetSQO1O0fbQRqox2XmjYgerOSB33Y0o+ngQgIjc91GBmb4ZP9FfwYFGWFeR06mgJ3dfNfVtpV2gfUfGdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290065; c=relaxed/simple;
	bh=LUrUd+grGI58KdBLkETRaZnLEYCzFFsAhsPOF2EFoeA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QPT7sS8imN7+Q3NIGFB6Rc/czEausZPwvjTE+1DG1qPOWoQ/bg3JqAHNSyJI1vRbVxYsvQ0Y86XVkiWO3+szhxJW5XBHK6Pj+4KnNRXbQpew4ZluNGwfT0sueAasPQzgxs+1uLiLoM8UaJP1i1cchy6K80f1EaRCRqtSSqwig5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2GfW2jy; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso19709325e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732290062; x=1732894862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=linYc4PYYa1AalUUZfLW5Qk3D1efJXXgmysKez0fQBc=;
        b=Y2GfW2jypiEH79EBdpZcE3kiD8kD2y2t9uz5c8ZEHvgYHVsbi3frZFG94gWMQzXKNw
         k70jfjQqmVMgeJGZSJcTvPbH76vj9a+uNJAaw1r8rWPEQJitQ+C0I8JaGVG8/JgIAn8O
         W8dTQwBObPVlnfXufm5PVEjUm/YtWQhcdPdLLG0+jpMSxVe9lNNNB7ptx+/oZso32pqB
         E7BCqea/0xWtJhGEDskHk1I0xtSNk8keV9mskbBrtzgSdcN2e72YgpqfPIyz6eopcSBN
         4PSiW2xCCBI1PWXsRCUhyulEEe8pBIzkYJYONliTbFyy09X/Q3MFfCKztVdRZ8NQ4B6q
         Ke+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290062; x=1732894862;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=linYc4PYYa1AalUUZfLW5Qk3D1efJXXgmysKez0fQBc=;
        b=a6/tcagStgOhkCzuQuOiE/uFWCMD5g/tqc5I0iJMTAehz4s97Llik1RhJhUTpb9aEP
         /7i/bEyisHMX7CNeDTpOsjHggb1y69bELPwSeatK1x+oc19zVBOyUCNSHdOar79cXy3e
         gosw9fGz6n6CbMNqdzKYD2H1wT2uxFDvgqv3nMd7DzDBZgBGBXIfloi67RPE96dMYgWH
         lGd4SudcLuMQj/ZY1QxI7xHv1h5hOaO6FX3McFgtRU8+QGzkboosyshCzbPpHtSmqFCG
         xP0S7ZpKRX54iyoD1956UHtEDixGYPLGiTDw2mjmbRZZQeodtEpbRFGbHKNGCSE6dhC8
         65dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpX+9N61UCUmnvsgDz6UR6K21QupCCk55VFnP4YxhqpKE79pL/dBhJMsT0Z7d8/t78BBlhu9lx1NrKG8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KrRbh6fqa7dKylBzagzb5IUsju0BGfphpc7vquql0QkzIKJY
	JsjR31UTT5SJcKrvOlVWbqMuKWz5V3EUmCUNx5c+W3crz1hkF+NQmRK4OcCvojTt9986f2m6lvZ
	DfLqK4hhKohBfLA==
X-Google-Smtp-Source: AGHT+IEskQOQOnMC5eHBm3np17NWKLLGzeqv77GLRWF8Aq7UDd1Yq+DczJ/rUyix8emN+G0xVynCck2Dy26SqmM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:510b:b0:430:5487:bb6a with SMTP
 id 5b1f17b1804b1-433ce4fa384mr291005e9.8.1732290062019; Fri, 22 Nov 2024
 07:41:02 -0800 (PST)
Date: Fri, 22 Nov 2024 15:40:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOqlQGcC/2XRTWrDMBAF4KsErasyo3911XuULiRrlAiauNjFt
 ATfvXJUGgctn9D3ZmCubKap0MxeDlc20VLmMl5q8E8HNpzC5Ui8pJqZAKHACsmXc+DZAaLPPke
 pWf35OVEu37eWt/eaT2X+GqefW+mC2+ujX5AjlyIkHWqRI3o9juPxg56H8cy2gkXskW1IVBSiJ
 O2FTYMMHZJ3VBdsSFaUohlwgJBT8B1SeyQaUhWBx+AsaBeU7JDeI9OQ3pACdBl0IhE7ZP4RAkJ DhgNPzoP00WRt+0l2j1RDtiJAkiI7U++gO+TuCMXfJFcRRYlK6BSMeVxvXddfBZL7yQoCAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3620; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LUrUd+grGI58KdBLkETRaZnLEYCzFFsAhsPOF2EFoeA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnQKXyonxh82WaNw5WfTyoJuUa5dGM/xGb3cf4c
 7lLrxHjg+yJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0Cl8gAKCRAEWL7uWMY5
 RmfWD/9hYSKnsvnSKhX8pODCL+0H5dx11YhePvsnCPGid0TJ6nnUovNNYLEN09U6T8a9jOtJh9l
 Mr5Qamp+wY/qDkMoTTxsRkNDxNjWNoH0twR0pncoXnYDkko+zm6tYuIShifLfaSXa/3nM3zB7Qu
 nvExS6tnpDPGi4ZK1W1EzCf8QX/8EeCc3MVxwec7riAinUXrW/zGmhV9VZIHpI2lvnH+rTsTA7w
 +cqfCdvJw0hjZpnNBTahHUBvLnf3chIk2nPioxeB02a75xoWVUOcgcRqlwrEsA2KJENDQejY388
 gTk1pE5lOvTCcrDmXI9doOCWbFAejc235rbAuAi4oK7E88Q8iT1OPQBCxW240r5i7goeltg8jwq
 V4nyaqyAftnPrmdDbtQHwNoQoUF5sA2LkQYAgzUfV2NbRZ9s3bMTEGylZBWNaNKHAGR5+gj0rYz
 BMD3mAN1jB/i44KIomd9AAmaqaLzQLFpMj1WuJM/AugKxFV4tV9c56tJAC0kjZKDWYTO+N3+SPJ
 3N6SepYjCXiU4ZHN3y64wE1TZ3zls5eofhAL7erzZkjWUF/sjdJHDg8gcecH1FoKoPWFLzbjeR+
 k50WxmKZvqIVuIoKkb8Qu6iejqdHG47kR2IvOm4Ad3XWSDRpBo+RLdywpD5qgX11aatJ+JBlr6w WscCXtBwmJg/EQw==
X-Mailer: b4 0.13.0
Message-ID: <20241122-vma-v9-0-7127bfcdd54e@google.com>
Subject: [PATCH v9 0/8] Rust support for mm_struct, vm_area_struct, and mmap
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
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
      mm: rust: add VmAreaNew for f_ops->mmap()
      rust: miscdevice: add mmap support
      task: rust: rework how current is accessed

 rust/helpers/helpers.c    |   1 +
 rust/helpers/mm.c         |  50 ++++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/miscdevice.rs |  28 +++
 rust/kernel/mm.rs         | 323 +++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs    | 421 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/task.rs       |  64 +++++--
 7 files changed, 875 insertions(+), 13 deletions(-)
---
base-commit: 8b8379ae7c70734686e98cf7455e6b25e614d593
change-id: 20240723-vma-f80119f9fb35

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


