Return-Path: <linux-kernel+bounces-363692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E88899C5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20B31C228C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94DD15666B;
	Mon, 14 Oct 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGR1WjKf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE6155303
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898214; cv=none; b=AKJBQMduH3UF5wd3cOK6wTnBsr23dXN0PhJh9lruI1typqPQKkiOGitA0kf9BOUvki1+vJnOViLVaOGHr+u8d3NGGuBENpZU78FE95vUhNNPJVa5LhrHetYq5vDGF/zeyHcBnHCMpaCTfPoxzq+Nn0omeQvolAjGi7dBDA1dCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898214; c=relaxed/simple;
	bh=L+BrUmFZG6coCaN6vjYiTwSGbPWblzWyjGISzbq8GQ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hFgPYJ9UE6UHyKBDX3sPth2BO+RM0V3IKdjLoaHSJj3Fh7if+jT5PJYjtQSR3LOlorcTAnXyQSzf4fF0Kj7r3j+5JFrrAB+dxEv7mWLNl6ApBz0eXupvdpXQO+wNnOSVRkHrSaYpnzAPNvI4XbceFny5QS9ZQP5scIfPlj0+4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGR1WjKf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6dbbeee08f0so69487107b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728898211; x=1729503011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0iJkEGvsoK5hcpHtL67ZHm4We9Hvjnd+4MuIc6M0BiU=;
        b=MGR1WjKfgkcJYUstKo9OZaK6MzQWsSkWcMzVj7IioAWmGb722cZWmYHg7zliDqdE/d
         zt2rsNRDsITMLzjtCJ671M51LTK7OxLLyFOM+4JRJEj8lLrWjBRMedmYRBF68K+O0yiZ
         uBqook2S2kL7FFw39uc0xP1kKZWpzQSMMYPueV/v90L69xziY+n8I1h5uGpRmc3onloQ
         ldCwL7XgPC559AUhtnhJlSM91onHXn11nhPpuuhnWFzE5doVrBjfJLYn4J9ncWOjv+aa
         CSBJmrVMa3SvtBGqFH46UQO6e/I53spBM8xcNI3WSMCj4kxn88u1jTMYjKUKkJvOzPhZ
         SgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898211; x=1729503011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iJkEGvsoK5hcpHtL67ZHm4We9Hvjnd+4MuIc6M0BiU=;
        b=oCVTKZCQ8gUMDxA1tFNMtlkV+fs7rdg4nLIdk2CaUka5XutIHH5Sp2BFZmpX4ojC5z
         rSrNv0f62Et6HyBBoQaR+K7G0ZRfI7zLmk1wPdrQLk7xjqZ0rKm470auRF5YwNfbaLQC
         ABaqfZQW+fBJeWTa8gg0/4yZjKVpiGahSnr2dM+hlzKwG6Fv4aUDX8GVbuMHof1zV/rj
         yQUmV7hdCXfh1Lslvww9jK7Avtp4jxEhegFgBK0DmGFlivbUrdlmeE256iNbXGXOij98
         zgv8EtrY9kY+6wij7Jwv2nPemaUYlCL0N03RcIJylXMwPKLUsLIgeRD6pmSsHaMzXyQ4
         OSiw==
X-Forwarded-Encrypted: i=1; AJvYcCXkQ743ZoucmpzxT/TWKF9SptNIo1Nv0b0woyqVnrIo9FuLgfj/Xar/qbEgo40HtfeUGnjsoF8PIz1wXto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbcYe9PIjWMTKrWKiu0ouyyRmeaoaqRwFAxI5OxXqvYUlU8sQ
	w7KT/hhK3xpwd+jdXNgeri3Z8KxH0wfJATPR63fPSD1H41mz3c0VQBVJ6SRXXZxHjCfJ2FWDz2r
	2iEdo+LY9iKjbcQ==
X-Google-Smtp-Source: AGHT+IFwXQ1X6dy8pYShptQ2LDtPPnqmooRTc0Xq3ILRYcs4f/0Ul1hHs5Lr+vRsdjgMRGuqjHlTTGnR89Tn4+k=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1349:b0:e20:2da6:ed77 with SMTP
 id 3f1490d57ef6-e2918421de9mr103466276.5.1728898211372; Mon, 14 Oct 2024
 02:30:11 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:29:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI7kDGcC/2XOy07DMBAF0F+pvMZoxm+z4j8QCz9TS7RGCbJAV
 f4dp5YgVZZ3NOfO3MiS5pIW8nK6kTm1spR67UE/nUg4u+uUaIk9EwZMgGactouj2QCizTZ7Lkn
 f/JxTLt/3lrf3ns9l+arzz7204TZ99A0pUs5clK4XmZRep1qnj/Qc6oVsBY3tkR6IdeQ8T9IyH
 QN3B8T/UX9wIN5R9CpgAJejswck9ogNJDoCi85okMYJfkByj9RAckMC0GSQMTF/QOoPISAMpCj QaCxw61WW+vHSuq6/d4kzh6ABAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=L+BrUmFZG6coCaN6vjYiTwSGbPWblzWyjGISzbq8GQ8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDOScqrVsEORZcGk7VjQ60QCLyfj+s9M2lAQyq
 2MfNYCRwtmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwzknAAKCRAEWL7uWMY5
 RvVpEACbFLL+7SM1I8M7MYHkZ37J9Ht+dM441ZT+0/12QSvTk1IH31bseOF9hH7aSTkrJ4CqyM1
 LyR+Auei1Nbj1jhjyuvT63Ekqiifj7+0nRxTlphN2g8KdHmyQj9Tns1H51s/fqJbrBtom8QMTg+
 9mDeC7j+8ZWIuDy/pvH2ptiTs16EuKqVuvsLgvHiDTee09XD0LesfLqUGo7qFwZUn6T6jdT9xfq
 OkSZ3lITJCUjizoBspzv8CscpRHaqa5U3QupWq6kNhpl76id7xKo+uQDr766sKW1WMLPRfWdQxW
 2Vk1V5Sp7nbOfAGgKpKUxt7IoEn4AwXR+iEaMYmKMTdiIo6ZwbIneW/zhElxAxo5saC99+iYQUd
 5ymK0h5twwNMANJIM1unDaZwXoCMfThzLSFpD1em8h4O8aaRy2O5XsnYmFkuq5TQ6DFfA1dgniR
 NAJGNrdy18pekvn9JsQp6aEMmaYsxoLON3clEFZfmAQpcb63osUbroKvAoBB4JYCVRcJdEipLvk
 cVe2SmT+pFTm2fd1WBNVRzRdrBsET7vEQ0mk0Wul0jQdJ46Q/3w9U7q/jFMi0BM57N4kzWX3d9+
 tBTgbpb+gWejsmpE5mJWzrnahTKvLZJI8ZaREmQex1p/3zJ9tjA1aA9BDpbYKFuuhga4MuW2w8y iUeZYAMwegwU+zQ==
X-Mailer: b4 0.13.0
Message-ID: <20241014-vma-v7-0-01e32f861195@google.com>
Subject: [PATCH v7 0/2] Rust support for mm_struct, vm_area_struct, and mmap
 for miscdevice
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="utf-8"

The first patch introduces mm_struct and vm_area_struct abstractions,
and the second patch uses them for miscdevice.

This updates the vm_area_struct support to use the approach we discussed
at LPC where there are three different types depending on the kind of
access you have to the vma. You either have read access, write access,
or you are initializing it. Each case allows a larger set of operations
on the vma.

The first patch in this series depends on vfs.rust.file for
NotThreadSafe. The second patch in this series depends on char-misc-next
for the base miscdevice implementation.

---
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
Alice Ryhl (2):
      rust: mm: add abstractions for mm_struct and vm_area_struct
      rust: miscdevice: add mmap support

 rust/helpers/helpers.c    |   1 +
 rust/helpers/mm.c         |  55 +++++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/miscdevice.rs |  24 ++++
 rust/kernel/mm.rs         | 357 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs    | 264 ++++++++++++++++++++++++++++++++++
 6 files changed, 702 insertions(+)
---
base-commit: 2d424646119f28780f3963811025c05ea848b85f
change-id: 20240723-vma-f80119f9fb35

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


