Return-Path: <linux-kernel+bounces-542072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78FA4C54A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1471616E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3821480C;
	Mon,  3 Mar 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7pmBRd9"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04BC214802
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015770; cv=none; b=mptX4oEhJhB0FJxvvWhWNOKonStOT+yoNq1eLOi7aLpuoJPIUL0BTXOQ8JLW/nvVVuNFFhSZkzszlYVaB7rFUUvuwEewcAIz5F4I5nr6g34YuzIucaFcoUAKmfRLV8zyEzWezwSRAsqA825b6OWqQBwmVK4DD6z13ndQV+ceG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015770; c=relaxed/simple;
	bh=MKKcNGlAewFS7f9bt0R/djTF9vYsut4/GuVdV/ZajuY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FIvOpCGgyrCMmnXAJLEiYQSuZnCyovTwWCEt2/ZUofjgDQGySHgJO8oGkOe47MRI4KBDrGo2uctbC3CO+OsdWyR8n1zAGExXBmKo3GUUg3O6ePNnNbvjuZrN7QuKHc7bakPAmbH+7ECq2RvU++etb9uV8KGbyZolhJUXlzZsoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7pmBRd9; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39104223bb5so572899f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741015767; x=1741620567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rgyyW4sbVGBrzM0W2SDFHnFKoPgMREdNyONofEZmbP8=;
        b=L7pmBRd9SpAfWp4dUytARr+g7q8DKmiVzshxxqpJHVAp2kP7YkT8ij/CtlmwHOAiu1
         nXGqDq/l967FcwR00DkwaOHuMMBj9VGre4UNa3zol2cFG0ArsfjPSy2ehNKPaJ9g5hmw
         E5+uiarfx0sL2e8tqD4XfAWcuFC5VIcWgjssGAkWrA3Rw4o9KEnJRJZv/g8qgrkdAIeI
         ayZl46fntrxcidLoym4lBaVtV8XLDIPqER5LGB0EDpevk0/v4v6BhkNQzFCJY9WhNKEE
         KtFU66HNO8JUt1BKdTD4dqjn9gjvFRFObHevztLUbJhzmrZNTsXcMM39eb3d/XN2K/57
         5lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015767; x=1741620567;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgyyW4sbVGBrzM0W2SDFHnFKoPgMREdNyONofEZmbP8=;
        b=TJC0hLg8cynZ2OHvUTJX/6/pPk/TxXmbtpKSb0GAy8KXijW9uMc+96BppgrQ7Oo8oz
         19+TXepcB4cp01vUy3epQX0zSWquzQ94bSFB37gFZhncSb3NrLRh5LfhkVILNrVDBnUZ
         Llx5OU5J0avZ37O1+vcNyuyd+I2DhZ3BGP4nOWYTJVdFHD4mHDi+9D5SyR3Tgrwszc6j
         cK9l+bc1/Y4/dL3eA+BEtBYqT1lzzER/QSgyrrCDk9WEBDwrRp0yoB5aczLw3LNaarhr
         pbK0fXVMP9Pnb16Xc3uI4Cu6GVNyDSDvJV+F1J3m8W2U0ItMcFhAXkIqlQ7VJIKh2sqh
         AdfA==
X-Forwarded-Encrypted: i=1; AJvYcCW9VDQ/EtRNxCktqCk7SsSVpEi1O3nJ/7jbf+ASTIURkxwWbnmIWxW2t2gi3fioktXDVn6n7xXer9UK/us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvc9om9imA0pvKsDvis6UvM622TF6/Cib/MsdpHspbLv52nXB7
	nxgoX/AFHK35q09fPMnReFQkgWMBpYxsYj3gkVADwLC4nvkMljkiXSCRRv2cv2c3w/joqJkL30U
	9KpgsvWe62PzVbw==
X-Google-Smtp-Source: AGHT+IHxZqB8AydRyo9JQAdZVLt80RVU0cppuHJgioRKDKVGItCNRq1BP4+I+HsxXvl1/JuyUNpaKPc3nCL2TLo=
X-Received: from wmbfp9.prod.google.com ([2002:a05:600c:6989:b0:43b:c927:5a4d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:598c:0:b0:390:f0ff:2c1c with SMTP id ffacd0b85a97d-390f0ff3109mr10554386f8f.18.1741015767187;
 Mon, 03 Mar 2025 07:29:27 -0800 (PST)
Date: Mon, 03 Mar 2025 15:28:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALHKxWcC/x3MQQqAIBBA0avErBsYlaHoKtEidKqBsFCIQLx70
 vIt/i+QJalkmLoCSR7NesUG03fgjzXughqawZJlcuRQ46lR0CcJaIIhpmFkYQ+tuJNs+v63ean 1AwMoqFddAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=MKKcNGlAewFS7f9bt0R/djTF9vYsut4/GuVdV/ZajuY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxcrOHWOt57dLOyMt5elZ38HuGx89RNWsOntvO
 mVaCsgJVbiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8XKzgAKCRAEWL7uWMY5
 Rsi9D/4sbkBkvlmplqLHreKpQpJ+jp0bSSsyajBdb0m33OsdQq3/9YBkITY7C+Fme2CxUmWaMWe
 tk0CGP0Oz/+x6FxzXbUZUs/cN+MYxQ6w1zSU1IG83IqDptXtyA62gfXpJHksBzW/5NIlGYGBPww
 2jusDbx4sSNiveeUqQbhwv1kwDt3lZfl+9Sk7jOkx1m+buFqy3UBIU2Rrfo0vThAQkKQtssTLaS
 cIl3LbdYDrD0TBZ3j16N3aHlayaaM1O9yZnCfR47rZXJWqbrvH6yInNu13Q9nHtyvt9SxwCAh53
 K5FT1Mh6DZzh7rynSG2iIngtL1/70OSLRdY6GDeS5xImpTUdIBeRjgyR6kEuo5L1mEV4dltEbb7
 s+eH9NJVvlzUR6p0kYf+G+irUBusz5wE5tOnwT6zEr4Wj8ypYdZUsZh5b5cOe1A6WLHFcr7c630
 cT7V/AUIrIld+YKgwGAA6CMGEj1GzuZSPVF+UiG8weaplEFh8zX1blxu2H7BYcT5PpNO3BFi73e
 O16OjWvIW3S1Ou5L47Sv8s4FKCcuzpheEB1YEyDdLoewhk3rIwgtdM3LVvaW0cS+ftfEJ+w7diC
 dXgbxEyEUead/4YpWkJ8tGk/PcBgklrb70fgVGV1sFZaWxky5xBO20NM0UUDs8ZA3r8RhkFBjmQ ggL5cu3+uY2kLyA==
X-Mailer: b4 0.14.1
Message-ID: <20250303-inline-cred-v1-1-b2527beace76@google.com>
Subject: [PATCH] cred: rust: mark Credential methods inline
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

I'm seeing Binder generating calls to methods on Credential such as
get_secid, inc_ref, and dec_ref without inlining. Since these methods
are really simple wrappers around C functions, mark the methods to
inline to avoid generating these useless small functions.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/cred.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 81d67789b16f..2599f01e8b28 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -47,6 +47,7 @@ impl Credential {
     ///
     /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
     /// returned [`Credential`] reference.
+    #[inline]
     pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
         // SAFETY: The safety requirements guarantee the validity of the dereference, while the
         // `Credential` type being transparent makes the cast ok.
@@ -54,6 +55,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
     }
 
     /// Get the id for this security context.
+    #[inline]
     pub fn get_secid(&self) -> u32 {
         let mut secid = 0;
         // SAFETY: The invariants of this type ensures that the pointer is valid.
@@ -62,6 +64,7 @@ pub fn get_secid(&self) -> u32 {
     }
 
     /// Returns the effective UID of the given credential.
+    #[inline]
     pub fn euid(&self) -> Kuid {
         // SAFETY: By the type invariant, we know that `self.0` is valid. Furthermore, the `euid`
         // field of a credential is never changed after initialization, so there is no potential
@@ -72,11 +75,13 @@ pub fn euid(&self) -> Kuid {
 
 // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
 unsafe impl AlwaysRefCounted for Credential {
+    #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
         unsafe { bindings::get_cred(self.0.get()) };
     }
 
+    #[inline]
     unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
         // SAFETY: The safety requirements guarantee that the refcount is nonzero. The cast is okay
         // because `Credential` has the same representation as `struct cred`.

---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250303-inline-cred-1d1050785e5c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


