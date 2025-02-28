Return-Path: <linux-kernel+bounces-538516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EC3A49997
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259D6173491
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61A226BD92;
	Fri, 28 Feb 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQphdiLz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A526B086
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746409; cv=none; b=oaV52kofhPLf84PptyEsyibFnEgoU5tAaMqPz526Rr+bNM0IRl0ZdS6vo7hfJFcDYdsKdszcDTNrvDR8YGy7axpP28JJQZg6/2BteoSAc4YO8XkFvjuTnQ9cI0DTZ4+E0OQx+R6nwZeuB7WgIEDeaLQZY6zBo80T2f7e3JylX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746409; c=relaxed/simple;
	bh=f4F5ENySuuzTW13FLThOl99dyKMXA8tvaC3KtUU/46E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OXCOCeZ3N87n+OybZ0k1AKrW10zI8nX6TSTLjvH79cDWoCVEyTkfdUX018pC73TTSqdWAU5IlqbSts6CxFIyJVxLoYFArzA7ZuXnHjAIZpRGVPDki2WqhgOuNq+RdoYmKlkfnW3Ylm14kA+eMXTrkZFGzP9SW5XOOqM+XVGOw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQphdiLz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394040fea1so10903555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740746406; x=1741351206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7pTdW8PK+uCDfeP8CraTwZfQg74lm/uFIg+fx5O10BM=;
        b=HQphdiLzNl8sxpzhrx4CXf4xQdNJ5G2LjgOdPMxpWgloc0UV4iUS4vizd1knUM3ukr
         rT+/2F8WCgN1waRN24og/nSBhC2KICNHsTMiUxP0TEAI36I2ifrDLhj9xGnyxHxu9Odc
         93xiitYem0pmFxwIzGSNSX73jKbd5R/K5rQ/lPmbYb3++YcWWoqEYao7VSudc8UAagq3
         9qb8czFLNPTVyf4P1+gtuEqnbsH4ev3S8DQa59WUa4BZa0qMynOzLel+SFEUMBGPwK4/
         wLqbGjjL+AHDGBzhi2776y51Ayo0kCeeu3jS6sZQwDEjAcS1nOpZ8kKYzt57VgB0nkvZ
         dnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746406; x=1741351206;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pTdW8PK+uCDfeP8CraTwZfQg74lm/uFIg+fx5O10BM=;
        b=R2eYiaB5Z2v4s6FlMOMM4yW86WCc+FuRLJVFclNyX8l/0iKjeV3RAUyH3pyS7U6qZO
         2j/EFz7BOc2ln3GS04rf1BUBkgMrm6tHhh8M3jzKysVsVHVFj28Rev/I5Bw4bbb/rSxq
         ovZQNN319TAzo1jJ4J20VidG4IJq6I4RrSgQAjjVQlzWSHy76/e0AGqSRp9mAHsU7BSQ
         KpyMfSAcjc8uFXSNuYj2LPcvbZhVDP2EXtW/u3Y+2bnJtV+OWatZzp6ZW6Mx/8X556s9
         Uy2rAgRO9O5FaNRWZgCyMy0vjJMKDNU1o/j+ZaCTbCEPk4kJBMRA0XI/gcX2K/Z5mcab
         3NSw==
X-Forwarded-Encrypted: i=1; AJvYcCXXNrRWWVVrB7AsAyXAdJMIsjSoRHEQDxyPCwumjZ/bEpViSSbleeFiWd/Fn26Keb42aTuRr2xCTNRpsIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztkWCrhJ031Lq5OD/GVrnB3Ihaj8OVtqLyhFE+o3dTrsYxsz9U
	AYtZmd/JabO4UrD8Ri4DbdwWmGqEA7v8I/yBaw59aQI42PAtVNY8L6p1Yy+1X8SS+PVIRi2HyVI
	qWlXy+JLDOhp41A==
X-Google-Smtp-Source: AGHT+IFEAv6xKo0a0vIbw4/G69A8H8krQW13rE7XRkdpA2cYXMlLXGdQj1+W9BdcKKZjWZpEvcVhucpeSr3CYy8=
X-Received: from wmbep23.prod.google.com ([2002:a05:600c:8417:b0:439:95b9:9200])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f51:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-43b4829817amr51521165e9.6.1740746405761;
 Fri, 28 Feb 2025 04:40:05 -0800 (PST)
Date: Fri, 28 Feb 2025 12:39:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIGuwWcC/3XMQQ6DIBCF4auYWZcGaC3iqvdoXBAckKQ6BgyxM
 dy91H2X/0ved0DCGDBB3xwQMYcUaKkhLw3YySweWRhrg+Sy5VIqhvtKcWOzsZGYNkY7wcVj7Cz UyxrRhf3kXkPtKaSN4ufUs/itf6AsGGf63inVOntTxjw9kX/j1dIMQynlC+PMihWpAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2311; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=f4F5ENySuuzTW13FLThOl99dyKMXA8tvaC3KtUU/46E=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnwa6HYies8d8W+vofsAmaaagCFfM0KznRJPlkQ
 bljWwLQeAKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8GuhwAKCRAEWL7uWMY5
 RsbbD/4k34jEhPxhPU2TpjINZJrCX+hzqaKUEueUixT1oETdYXEbkKIoL+qzDQ8hcm7U0cS+bcK
 ca1QBfyXm2WUi+hjb69vXRwkN49bhCNcJWxu0/KzCJUgw7tKdNxpG78AKmj8oEH8VXC71ndQ6xw
 Fj1X2YPlz4Vqc8TgcWbb7Sxveyc5fHwA4OBpjSjJPGa2qizE22QSj/wCLOkvqo/g2mk+GxpjVj0
 3GYT/YxqHiGfK2xHslVDc/FZ1DSn74rnnXqNhqn7brcJ+10hK4M7AWqGwYeD6cisJ6f23UgI0bG
 3B0FTrGH+E5uWycU8ObgQWz1twUUYcIlNb4ftQe1pCjr1lOOt6f67NN1WIU7n+eUwIposZdwvpf
 XE4T4/xoaTDRquh0vhq6m7tekwjY20FbAFcSXOvxy7Ezr7Y/GVMEXlPXH4RKH+JoDdQbsiTkvBL
 0uSwvvip+e/3MsOfU8gsfSYHOSw6Xc1+Hcf+ZaR7KxvhBzOnigeYi8E73Mht4Z1O6r36puYZBhI
 Lg3d1TobsqMsGq2SMXqC0L1ZLVMUqzek6+bEOzZfOwffQMY7E8fnT38sfockn/Yl9pchQZdiGDh
 mcQtARbW4jezVmMEOOqi962yXdzGOACBt8iRewWXLbm5Hg/ofgjxl8Py8lyvNquKktPP0ItoGfw aua1wRpwI0xbyvg==
X-Mailer: b4 0.14.1
Message-ID: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
Subject: [PATCH v2 0/5] Check Rust signatures at compile time
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Rust has two different tools for generating function declarations to
call across the FFI boundary:

* bindgen. Generates Rust declarations from a C header.
* cbindgen. Generates C headers from Rust declarations.

In the kernel, we only use bindgen. This is because cbindgen assumes a
cargo-based buildsystem, so it is not compatible with the kernel's build
system. This means that when C code calls a Rust function by name, its
signature must be duplicated in both Rust code and a C header, and the
signature needs to be kept in sync manually.

To eliminate this manual checking, introduce a new macro that verifies
at compile time that the two function declarations use the same
signature. The idea is to run the C declaration through bindgen, and
then have rustc verify that the function pointers have the same type.

The main commit of this series is "rust: add #[export] macro". Please
see its commit message for more details.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Various improvements to documentation.
- Split out quote! changes into its own commit.
- Link to v1: https://lore.kernel.org/r/20250227-export-macro-v1-0-948775fc37aa@google.com

---
Alice Ryhl (5):
      rust: fix signature of rust_fmt_argument
      rust: macros: support additional tokens in quote!
      rust: add #[export] macro
      print: use new #[export] macro for rust_fmt_argument
      panic_qr: use new #[export] macro

 drivers/gpu/drm/drm_panic.c     |  5 -----
 drivers/gpu/drm/drm_panic_qr.rs | 15 +++++++++++----
 include/drm/drm_panic.h         |  7 +++++++
 include/linux/sprintf.h         |  3 +++
 lib/vsprintf.c                  |  3 ---
 rust/bindings/bindings_helper.h |  4 ++++
 rust/kernel/prelude.rs          |  2 +-
 rust/kernel/print.rs            | 10 +++++-----
 rust/macros/export.rs           | 28 ++++++++++++++++++++++++++++
 rust/macros/helpers.rs          | 19 ++++++++++++++++++-
 rust/macros/lib.rs              | 24 ++++++++++++++++++++++++
 rust/macros/quote.rs            | 21 +++++++++++++++++++--
 12 files changed, 120 insertions(+), 21 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250227-export-macro-9aa9f1016d8c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


