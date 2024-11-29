Return-Path: <linux-kernel+bounces-425791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280269DEB0D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAABF282DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35171494C3;
	Fri, 29 Nov 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOLQaFJy"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAF44C77
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897976; cv=none; b=SfEhjzMZBJgMK2OYYjusxuXDET7Pl8Bd7VQAs/UJ8SL0+ong+KvSzKCQmJ0vB5FihukJfLRI3igBsiZhib8obl8i84t1GXZhrT66ctzrJJQ0fXde4oOxf9MejRzSTrQN3d3Dh3ysUyAG0QjeJ/QY9q3tjRfyxgfv8M0+0MlShX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897976; c=relaxed/simple;
	bh=6euziWlsTZT2LwlstrHKpxyGGSj51lSnwkd3P2pMMFc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XjG1G1VEsU5huzVsDg7xlb7pwrKYlJCA8KvA53JA921SFI5NKRzg22xH78H1PUZMA79wCgFYXVoxExtCaiOgEK5bEPW/s3x97FKrhudcLXb1o7NyEfUwvcA1Le2HkRFR5DPV45szkcuI4XtzYFBRXI8tQNr6CJyK0qFu1er8v5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AOLQaFJy; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43499c1342aso15547905e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732897972; x=1733502772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdDkek5Yx0fnCo6dzbffEiVWl75Uo6GigWomprG1zsw=;
        b=AOLQaFJyOyWvJf0mrFudli76pwxAx3vkf90jhstfD5HZJQca6zhNQjfstMMpuT0hP1
         Ws7FE5Q6H+soM1Jht/q6sugkBAyg8fCYU+TcWipAG3eoZQ/Gf3FogKSOrZqg7vIkAzuU
         RgbrCJgyQUjTFk+j9dugWv6XPH7267syUzD7SHU2T2WSAb/CyVjvi0LTFNW4BvbSp+jU
         V9Fe/6UQIMJlVbi5cadzkC+pELwcLH44Wkylra05Lor5g935FpdAXweObP4Yo0+k06in
         l8uUbSUL7p7R+w36y9utEezQGWN+HNDRa73TIXhQwVZ7T/cBpXl+cbv86HsLAPB6hmYe
         L8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897972; x=1733502772;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdDkek5Yx0fnCo6dzbffEiVWl75Uo6GigWomprG1zsw=;
        b=Is4KNB45WAgB/w/G230r3hrONQ579zMTMUXomNOdQ4lGzF6qnVB4VUsaorI/qD1vup
         /9MwXQx6jqfOIyeTCAdKw3xHx4c1VUlut36BkhCG0zahEXv0ng/9JtWyG5XTA0FTKndo
         SXbfaPXW6++h9nNSKKoeSU6BE1pmaFgnZJ1bLlSuY1w58eN0ZeEz6OZP4WNSoVpUQJ3g
         zxgtbBMDMBqybCNJojhRvi7ZVkmD0xufWkGAjqujIbID3fZ5YfU3YfoUXge/J7ON9bDJ
         6+4VKR8rSv3u40aLhIUbNefcP4OO2JdWlGyNY2GhRGlnLI741bijvhkj/3iESY77BWCK
         qP3w==
X-Forwarded-Encrypted: i=1; AJvYcCUxsxfIzDbEpRYccWxG+cvmaz/4ciqTDddjZ4fkr1AdenOxn8xXDlVh8EzoaVWToTaJbFZW3sv710aeMK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Z758coARs6xYRRdJrCQfyeigz+Q9TMKXUvDxAlHoXO2u3pf9
	27874DlJD0mp4ocLiWxVFnVnD8ckeu3nvEgoSMHPNdrDoTf1c8qCdt+rNG0xbIPF6IEdQ/bEi2r
	kDX8VZQSw3alqsw==
X-Google-Smtp-Source: AGHT+IEd+WeP0yZPx6J5QdCs2EPuOVY/vOZYlux3Z8lhvwvQCPBdFiPz2BckCfzrfuurfyRG73I1GeoSZAi/JkA=
X-Received: from wmlm17.prod.google.com ([2002:a7b:ca51:0:b0:434:a72c:1d0a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3146:b0:434:9fac:b158 with SMTP id 5b1f17b1804b1-434a9dbbc0bmr100391565e9.1.1732897972554;
 Fri, 29 Nov 2024 08:32:52 -0800 (PST)
Date: Fri, 29 Nov 2024 16:32:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKLsSWcC/2XRzWrDMAwH8FcpPs9Dkr932nuMHezYbgNrU5IRN
 krefWpT1hQfJfz7S1gXMZWxL5N4213EWOZ+6ocTFwgvO9Ed4mlfZJ+5IQhIgyMl52OU1QNiqKE
 mZQS/PI+l9j+3mI9Prg/99D2Mv7fUGa/dZz+jRKkoZhM5yJfyvh+G/Vd57YajuAbMtEVuRcQoJ
 lVMIJc7FRukHogXXJFilJPtsINYcwwN0ltEK9KMIGD0DoyPWjXIbJFdkbkiDegrmFwoNcj+IwS
 EFVkJMvsAKiRbjWsnuS3SK3KMAIui6i3fwTTIPxDSfZJnVJJCTSZHa9v1whbdPyIwckgu1S5no 5/vtCzLH5ewly5AAgAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4766; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Kn//SnjqmXMSPKs0UN6ocZ4BEFE/v6XXxAVCGEr9Q0k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnSeyl5zS+M35OT/I2nUtC5L2kfh5ODjaiYGuDP
 cYtEamZs3mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0nspQAKCRAEWL7uWMY5
 RjNXD/926bt9DrrkSPThowHNLR4dvULvxmEsBsqNJWOKCjgb1e+sCbIbxmDab8B5298zQHoojoV
 TIt5vCE0Ns8381mWLefOOD6Qkgn1TaxqtqzilRyWSJqWognLKQHj65DEugaccCX4yE6mh2tu4LL
 6c3JgfuHm1bzXxKhSbn7DkeqUzAGOTg1rA4nZY6Uv7mBg+Ep49IetCM5Q+AuaDHdxqAkKePOHhw
 VQN0Vb3CFDLGURmw8CAGx/Qb/eYkYTxcRAGcMJRt/dMPWScDwiXeVuucaoSfeoqbLFp5aXqBcCx
 J3MBSS0NLrm7CK7VytCXJhZMQ3oqXkcvdCzMht04wt3NDQoPNDrEvvQGhmpUZCKq/ZTU+NOEeZ8
 rhQ9b79gqq/SaraLvMi0S/Jn/H0jmQy4J7daYRKv75ssP9bq5ClfZz+btMvKX38cJvUBu6oa6vp
 gSh7+3pGk/t2CdL1CRX4SibQ5Il+U1SlfWYPwzNOjrZo88pBrnD22W04Vg7Baonw+DY1BNVn8Ik
 JjwexJD3jjIfvdn24Iy7frXkW42L9tdYv2HlO1kb5cuxLW3u7d5/gQ8B1NunOfqwVoaEs1BnR+6
 /R8aTjt5V+VWRF0tWqA2MY2etjcpfV7mNNuKKtsZ+bgHQIWLAqnLVyVQZ1UsqynaaVIF2+Mn6vZ O84lAa0QaplKDMQ==
X-Mailer: b4 0.13.0
Message-ID: <20241129-vma-v10-0-4dfff05ba927@google.com>
Subject: [PATCH v10 0/8] Rust support for mm_struct, vm_area_struct, and mmap
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
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This updates the vm_area_struct support to use the approach we discussed
at LPC where there are several different Rust wrappers for
vm_area_struct depending on the kind of access you have to the vma. Each
case allows a different set of operations on the vma.

This depends on several PULLs that have landed / are landing during the
currently ongoing merge window.

To: Miguel Ojeda <ojeda@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
To: John Hubbard <jhubbard@nvidia.com>
To: Liam R. Howlett <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: rust-for-linux@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>

Changes in v10:
- Update docs for `set_io`.
- Check address in `zap_page_range_single`.
- Completely redo the last patch.
- Link to v9: https://lore.kernel.org/r/20241122-vma-v9-0-7127bfcdd54e@goog=
le.com

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
- Link to v8: https://lore.kernel.org/r/20241120-vma-v8-0-eb31425da66b@goog=
le.com

Changes in v8:
- Split series into more commits to ease review.
- Improve read locks based on Lorenzo's doc: either the mmap or vma lock
  can be used.
- Get rid of mmap write lock because it's possible to avoid the need for
  it.
- Do not allow invalid flag combinations on VmAreaNew.
- Link to v7: https://lore.kernel.org/r/20241014-vma-v7-0-01e32f861195@goog=
le.com

Changes in v7:
- Make the mmap read/write lock guards respect strict owner semantics.
- Link to v6: https://lore.kernel.org/r/20241010-vma-v6-0-d89039b6f573@goog=
le.com

Changes in v6:
- Introduce VmArea{Ref,Mut,New} distinction.
- Add a second patchset for miscdevice.
- Rebase on char-misc-next (currently on v6.12-rc2).
- Link to v5: https://lore.kernel.org/r/20240806-vma-v5-1-04018f05de2b@goog=
le.com

Changes in v5:
- Rename VmArea::from_raw_vma to from_raw.
- Use Pin for mutable VmArea references.
- Go through `ARef::from` in `mmgrab_current`.
- Link to v4: https://lore.kernel.org/r/20240802-vma-v4-1-091a87058a43@goog=
le.com

Changes in v4:
- Pull out ARef::into_raw into a separate patch.
- Update invariants and struct documentation.
- Rename from_raw_mm to from_raw.
- Link to v3: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@goog=
le.com

Changes in v3:
- Reorder entries in mm.rs.
- Use ARef for mmput_async helper.
- Clarify that VmArea requires you to hold the mmap read or write lock.
- Link to v2: https://lore.kernel.org/r/20240727-vma-v2-1-ab3e5927dc3a@goog=
le.com

Changes in v2:
- mm.rs is redesigned from scratch making use of AsRef
- Add notes about whether destructors may sleep
- Rename Area to VmArea
- Link to v1: https://lore.kernel.org/r/20240723-vma-v1-1-32ad5a0118ee@goog=
le.com

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
 rust/kernel/mm.rs         | 323 ++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs    | 429 ++++++++++++++++++++++++++++++++++++++++++=
++++
 rust/kernel/task.rs       | 284 +++++++++++++++++-------------
 7 files changed, 999 insertions(+), 117 deletions(-)
---
base-commit: a62eb7bdef0b0009d1e141198e790fbc588ad0a1
change-id: 20240723-vma-f80119f9fb35

Best regards,
--=20
Alice Ryhl <aliceryhl@google.com>


