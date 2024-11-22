Return-Path: <linux-kernel+bounces-418427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B323F9D6178
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A3B1605B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB41DFE04;
	Fri, 22 Nov 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exeBluvj"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B21DFD95
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290078; cv=none; b=sX11EksJf694G2EQclKRb7Pif6yvobTA7T7PQ+hftOaM3oCBVjIrTQBZVc6wGgRs41iI13zokHbGunVPDMfRpMEjY/7u2LrXCLb3UVtO61wYDje6JT7QV+5PWHe6EK+jCQZif5Eckfpkp24TsmHSvUSX2iPEUI9Z1xs/4kQoV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290078; c=relaxed/simple;
	bh=e90cBT06DiQlSWUKjCW8KaJiJvXBHZuG2g717B8IAkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nqgEE2Z183v2iulYI8ENF79PY37Jy9LEvsFL0Las1G0XLba+ty79W0uG00vjZdAtHE6e7zmtSpTZ4k77bZTOOfOcJpS8tOnBmhqE94yhhWYqGWObHvq1JyUuFO/HvQv1Bw3+csTp4gTpDTI0bRMMFecwpViXk9MknnATMN00p28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exeBluvj; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3822ecd84b3so1147906f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732290074; x=1732894874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQjQrA8l6WUO1Dv46YWyP2KzKGLvaWN5xjw1wa5cSc8=;
        b=exeBluvjMZI+V5Mulgs6I6swS2PpkVzxrBaGZiSsdo44VGsm33oycwkrroq6u/QEza
         tR5is5xV7kNFIJtjVljvq3HJdKv9Boask3WxN7B0gE1TEsT+l7UmHaOccX+Xo/0//99h
         2Lc4la4/Et+98RctnUfk5bOws10SqKJWncpKKyvujf2wXRxg2rps11UmcgKGGoSjT9xS
         lnUYnWGpMx1RryL9KYnUGO649QT1A1BSfTpgbvcmNhwvEZ4DYd6zKPwrf0tv32a9vDxv
         nn8NSZ9zlVSy3J65gOMpcw9hFiE5MqO/gY0KoonNL53SiWmd8aK7XN/Q3VKZKpG3OGO3
         8ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290074; x=1732894874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQjQrA8l6WUO1Dv46YWyP2KzKGLvaWN5xjw1wa5cSc8=;
        b=RbUevsQfeme4HvsElfzfX3b/y9lULby3dmJQ4CuSV0VmUAwvPJnKPCcHhWsbjDC+gM
         8fCcPqYq9QyGBBBBP+AW0Kk4I2NMSv/IFatJdjQ+5KBnJoLWsznvTLIcggg2bJboeTCp
         4G6C43P56COFyagpFcngdJyXXAfX4Q6zi4gn0fYWCLR/chDffLNs9jiHYTrFxubP7IjR
         gZc7ZjXeWxejfAFQVjQX7KC/ylvvPzW2PZX8EEsVol0STwnBcDlX1WJSDVl4AjDwD9Zo
         1JXI2OxU8MbQfXhsy/QMskyJtttohngajT3zU9JmwD600ui6x4Gl5lBGkZPxosLvt5s/
         tqXA==
X-Forwarded-Encrypted: i=1; AJvYcCVnFNY77a51slWoSWBrWGAb6cLC8v7b4U5Mjn8icWRBYsEzg+uFADR+sqanPxnfujbp/NBasgsw8CDHYRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJ6bnUx3jBriIwth5F5n8XsClogEw3m87jEqrPPgUaraQGvaR
	jgAsxDTYp9KeC+ymOuFyv9y291P2RnKZhOndAkdM/21s1yf3/kHcAMhfFcLY8Ph0HshwUGz1J1P
	rY9Oh2ZkCeHCqhw==
X-Google-Smtp-Source: AGHT+IH2pPS49cAT9mdCjiMFAVekUdtncedHBNDeVISatyX0fCCBayouO8NUq4KgmU1yCNwvAR5MiYLmHLx8PcE=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:a5d:5e0c:0:b0:382:449d:a6ab with SMTP id
 ffacd0b85a97d-38260b452d1mr878f8f.1.1732290073825; Fri, 22 Nov 2024 07:41:13
 -0800 (PST)
Date: Fri, 22 Nov 2024 15:40:30 +0000
In-Reply-To: <20241122-vma-v9-0-7127bfcdd54e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=e90cBT06DiQlSWUKjCW8KaJiJvXBHZuG2g717B8IAkc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnQKYJ73Kuhs7y8NsLUpQQMtbfBgw4kDNtzBVg2
 tUbFMPyS9eJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0CmCQAKCRAEWL7uWMY5
 RkzaEACBEXTOYc+UZmggaAf5RKHc4bX3sRd3bEoHGg1TwzgV8P69eolFeBEDIMT4ozAtxjnoZMO
 8H6ODCr80sTJ/14jsNEMfD8riO17u4t2Rct81AB6ASqN4eCABDEd93DFjjrtgNZxE5acubWPzlT
 rFWtgWhwIcyUvUkhX1ipVexr4/ZItTLyezntWLg4kBqVJ6uLepiaJctIk53F4rU8p9UZnAfC1P1
 sPbE95Jb4S0oJhIGQoFaF6VtlUEV3joZaYJl1gGkuFnbWy6y1ije3pGCnWYv/099C2FtXKzKMEB
 e5mTT5LYuqJhZ3zf3gjfrNICehst0DXZPDIbpvzs199wF3CzRntxGAcRQkDApOhBkZj73Ntx6oj
 fO/MGb7TVIZgLhToYA91lnHYjCs18cIAwieUxn0k0tfq5NPUfYUYAad+koxMCGOauUvnCCB/DqC
 2idZYlEiasHpiaOmj1judPSffxEnMkvDFLZtW2xroCdVECOMMYuFmW5fFv9hj5n2+yL3kmmcsoJ
 Sz/nfsJI5NF41/S/qA61Mo3l0d1XRZwMpxnEdzVm/KU47CaGRXonGb5rsfDf12bRSmzzvXthP/V
 vqtIKmQT4av/5On0EURF0tsQcFkV2DKivHNmMubOcOhsj3jFGHajd8ny39WSl7qKcFxdd3gePsV 7fPwbNtETlyL+wQ==
X-Mailer: b4 0.13.0
Message-ID: <20241122-vma-v9-5-7127bfcdd54e@google.com>
Subject: [PATCH v9 5/8] mm: rust: add mmput_async support
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

Adds an MmWithUserAsync type that uses mmput_async when dropped but is
otherwise identical to MmWithUser. This has to be done using a separate
type because the thing we are changing is the destructor.

Rust Binder needs this to avoid a certain deadlock. See commit
9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
details. It's also needed in the shrinker to avoid cleaning up the mm in
the shrinker's context.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 425b73a9dfe6..50f4861ae4b9 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -98,6 +98,48 @@ fn deref(&self) -> &Mm {
     }
 }
 
+/// A wrapper for the kernel's `struct mm_struct`.
+///
+/// This type is identical to `MmWithUser` except that it uses `mmput_async` when dropping a
+/// refcount. This means that the destructor of `ARef<MmWithUserAsync>` is safe to call in atomic
+/// context.
+///
+/// # Invariants
+///
+/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
+#[repr(transparent)]
+pub struct MmWithUserAsync {
+    mm: MmWithUser,
+}
+
+// SAFETY: It is safe to call `mmput_async` on another thread than where `mmget` was called.
+unsafe impl Send for MmWithUserAsync {}
+// SAFETY: All methods on `MmWithUserAsync` can be called in parallel from several threads.
+unsafe impl Sync for MmWithUserAsync {}
+
+// SAFETY: By the type invariants, this type is always refcounted.
+unsafe impl AlwaysRefCounted for MmWithUserAsync {
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmget(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The caller is giving up their refcount.
+        unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
+    }
+}
+
+// Make all `MmWithUser` methods available on `MmWithUserAsync`.
+impl Deref for MmWithUserAsync {
+    type Target = MmWithUser;
+
+    #[inline]
+    fn deref(&self) -> &MmWithUser {
+        &self.mm
+    }
+}
+
 // These methods are safe to call even if `mm_users` is zero.
 impl Mm {
     /// Call `mmgrab` on `current.mm`.
@@ -171,6 +213,13 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
         unsafe { &*ptr.cast() }
     }
 
+    /// Use `mmput_async` when dropping this refcount.
+    #[inline]
+    pub fn into_mmput_async(me: ARef<MmWithUser>) -> ARef<MmWithUserAsync> {
+        // SAFETY: The layouts and invariants are compatible.
+        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
+    }
+
     /// Attempt to access a vma using the vma read lock.
     ///
     /// This is an optimistic trylock operation, so it may fail if there is contention. In that

-- 
2.47.0.371.ga323438b13-goog


