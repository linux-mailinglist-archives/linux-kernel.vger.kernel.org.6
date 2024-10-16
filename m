Return-Path: <linux-kernel+bounces-367921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5FF9A0874
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D657C1F251B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3A2076C4;
	Wed, 16 Oct 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXCKUER7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FEB15C147
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078486; cv=none; b=BkGajJb6+q7nF53QdLHNDJm5OUFQsUg5Vl9nnBGRrfcViOTp/dmbGYGcuG3iRX4W7hM3k/mSHCf0el/KFqMPPk1MRtzdiEey4Tza6KZ4z44IFBjtW9j2FSL2vZEqW+uNmAyne80+aEkf308deEoJlmeblf7TXOBoW88ErnaH1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078486; c=relaxed/simple;
	bh=FASyUf1saphfaZbw5HzqQHkzRL2v/xQtO8LX2AzMsdU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rDsN6mrJVYd99si0hNHPVWM+7uMo5jDQJXqfjRgTbpac3tLRAUanNVZy3RhDjUxES1k8lzgtLkH+Bmv9KWp1MxYyOU4jFcWVJt1/krvJbdEJhQQ1lbNdnPYb/cJQ2mYPyoJ65MpMWPgPxp9YGJ8WqtNUCFOAryzVQX4faUYrs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXCKUER7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29142c79d6so7105040276.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729078481; x=1729683281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MALXvk2pH8I2k2u/nrpnO/yJTvhOpCgZg6TPQyQ9Tdg=;
        b=jXCKUER7sMuJpsjFPjGfNXpmnnilcD81k5aLo9hE1EU92QL7UPZkjlv+YSZgpY/XZL
         yaJr3a9TiGqYSEM5ECgOFMH/w0JxxxxwwwMcODJll1hytk4BLX0FRsHw4UlFxZxOmIoq
         qu3xygr+Gl7w4yCkADzIyrDkYXI63KIm+t4I2DtbdtBRhLYcoSdTn1nVO402rwYgmLI2
         9TJoy+3Rn446bXq2oCSznRrwcy4BvRXvJlWQSOZTAmwi0dFUeI+WxBXxdOC/paXaj4do
         VlgT+64KXsq0+26GG+wEQQZCNVw4drzyS81b3rhYhVPaBrkh3dtv4voWLxTVJDY8K40y
         E2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729078481; x=1729683281;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MALXvk2pH8I2k2u/nrpnO/yJTvhOpCgZg6TPQyQ9Tdg=;
        b=cCZKxeYvjHlZP0+aTc8PJdRjmmFLjXZaExHiToGzwKWL+oK58zQgxRi/5wVTWoMmHL
         fRWy+1C+aLH95VyMxeMeioLXH2dbWsqi4zbeIFYI0MbuwqZx4vSUm4tcWnnCi2XHn8Mh
         js6CWZv5EGEuXI+L6eqvJzjCArNwDzcqlFTu2MTxYnml31420n3dCt/TQyXCj7WlLskw
         6iQoZjCKnxf2qxgmNzIfGYga8Vf4GItrmzanEmsLyp2/tj+52rSRVk1x1Q3VPvDABybc
         vvcz6SYGcwqL0xjMgsSggqFI8xEDMqvpxbkEXAoRnhypQQJJj4VLO6gCAyvfjhnxHVw6
         IlfA==
X-Forwarded-Encrypted: i=1; AJvYcCUWeasL0AJ8CtZNBEvoOewzC2QpybGfoz9bUz+zU44+k0GSXFz3Vvk85pxKRlK435zDm07+QGGdijUtmpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypHchbo4YxR6LiuIS/yXhhn5pPKlrCmf4rVeZPsxpCz3nMXSow
	pNhwt/uUz//Y0uT1Tr/CzEn8Z/IUfUFkvLxsZaH7iNrQTpX0KpE8t/VQlskNZIqM9oLxFDxEg4e
	wZHOeohHJIg1mIg==
X-Google-Smtp-Source: AGHT+IGfRBqsOD2gGU0Q/tMktiVo9//GJQ0UbhR+dW9OD/x0wD05SndfGUmQvGwGLXuBq1JNpcneuDfyEmwqT64=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5b:546:0:b0:e28:f19d:ed4d with SMTP id
 3f1490d57ef6-e297856f63fmr2163276.6.1729078481439; Wed, 16 Oct 2024 04:34:41
 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:34:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMCkD2cC/22MywrDIBAAfyXsuRZX8qKn/kfJwehqFtIYtEhL8
 N9rc+5xBmYOSBSZEtyaAyJlThy2CurSgFn05kmwrQxKqhYldmLX1emV/SYG6pxuzdDhTFCDPZL j9zl7TJUXTq8QP+c748/+3WQUKPrRzXace4vS3H0IfqWrCU+YSilfqC4cwaUAAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=FASyUf1saphfaZbw5HzqQHkzRL2v/xQtO8LX2AzMsdU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnD6TDRlj6OCtorsbkl4Zx1Ncki8FT20tIyymhr
 t0bMM3J99OJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZw+kwwAKCRAEWL7uWMY5
 RjzsD/9MGtoHTc3tWy/FcEwTs19PhkvgcFc4rA9v2okPpqYrHx+wNdDavdQuuxysi7X/oi/Kw9N
 Tah4eilyoGLrxKSzQ+/kA3p9haCeodxjLtzf7sK8JVhpq7Pwd0Aa5cGv4kvFch3Zu9y9Q7etpOg
 8sqgNXLswBGwFZoYaYOup1erzww1h6uajLSoaYK4zVQxXow240EKaqLgZIrgIBIBe7/fUg1U0xq
 4iYCczcu+kPnoomPiT6lCCYUedEUa+lQejHmXcVE+Qc5J+cAKk0wcz2y5/VjXG4l0UaaEGKyG5D
 LXHYh+ZBb22eQSRWsKXAkvI7X4z9LP8RqzcQxEqrsJPFcLqePfJ6yDLg9H8GCy/F8VSgHLoK+Ru
 bSSNENSd6kBEyNyXWPlRQIxByzx3QOhc/KYExoIa1WSG4GhIyCBns120U5GC2waj675Jj9XDqYw
 v6TGLRbTcfyoSf5XwFdhYC0Fbk4lBYOv806NoFhWYPwPlzKKth9xC+pwSo5ZEpLcCi+GoxSfjMY
 GX1Wg4+7p1ma+0dTDAjA2Dz0zhjOihmF4ye/AOyaSBSIFLfD6R8VzLTw3MqKza8z6Y3PfQYhWcw
 iOYVnvJgZeFgpe96jDP/4sPiga272g0ey+Ep4swWlbrd/glIXe70FCOYeHP87BXOnRAvAASAjiR NC+MM5j4FhDPoEA==
X-Mailer: b4 0.13.0
Message-ID: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
Subject: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This is a useful for helper for working with indices into buffers that
consist of several pages. I forgot to include it when I added PAGE_SIZE
and PAGE_MASK for the same purpose in commit fc6e66f4696b ("rust: add
abstraction for `struct page`").

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Make the function const.
- Address integer overflow in docs.
- Link to v1: https://lore.kernel.org/r/20241015-page-align-v1-1-68fbd8b6d10c@google.com
---
 rust/kernel/page.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 208a006d587c..9ef01929e7d0 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -20,6 +20,15 @@
 /// A bitmask that gives the page containing a given address.
 pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
 
+/// Round up the given number to the next multiple of `PAGE_SIZE`.
+///
+/// It is incorrect to pass an address where the next multiple of `PAGE_SIZE` doesn't fit in a
+/// `usize`.
+pub const fn page_align(addr: usize) -> usize {
+    // Brackets around PAGE_SIZE-1 to avoid triggering overflow sanitizers in the wrong cases.
+    (addr + (PAGE_SIZE - 1)) & PAGE_MASK
+}
+
 /// A pointer to a page that owns the page allocation.
 ///
 /// # Invariants

---
base-commit: 8d8f785ceb21b9a0de11e05b811cc52d6fa79318
change-id: 20241015-page-align-7e5fa4c751be

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


