Return-Path: <linux-kernel+bounces-536940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6920A48612
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51DE3B0DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338CB1DDA2F;
	Thu, 27 Feb 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDhka04P"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DE1AE003
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675761; cv=none; b=uklM3huiw4glv3ZpcFo1/XJ419YqVrK0JoqwUytiNr7Hta123tDnsLrXyk3oEkn7E2FJA9WhuBcADsgVcTkDrL8q/DGybnMntPPscLAhKKuObDZ4bs9z3j9Zv8dkZpoerT75sL3CpGMclbhV5N8iK2DFjVsCiNdySpxY/HWwB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675761; c=relaxed/simple;
	bh=SLkqtCbTV4WGngOIGeQdA6Ma/ik2r38oGZ+ix63LEAs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s05NhwzX4ThYnC0i0lbD5Sez617Zq1zi4Zlhqwt96BH0+TeMYInkzem5cLmuYicXV0HZvkdkEefXY70FUXCeOAOzSZ1YqwMJ0XCFNNvItrb34vjvFBst9J2KNIKJjmfbSn+Ks6ZW24/i/QGstRaQuiIy4ktMGnJ6oLJL1QLpUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDhka04P; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so8288945e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740675758; x=1741280558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7N2niC0tm9GYpL4kTpAci69B17RX2iCWEhPKu3yRgtc=;
        b=sDhka04PQzum/t7pcZb/gGXmj5dCEvu/ic+KF2YyjzHxibTn/ib5rsiQVSS3lpRcbo
         VGLYoyC7xYdzAlj9uTW6L6H9149T6l/IiHaU0C+kl+2pkIVSQMWkyVy7EUCgDaWMNWp7
         kpw5Q3QULkdVMJlR3Toii6dy1qUiPdSq8qE+CsfkASRuN99xITe99B4iDDg5+NF2i01g
         T9vvvzndibE9hSYoWWHFJcqTTtLp4bB5Mf77JxbOorpIFrYufR+2CKo8MrhbjYc10rc3
         akfezYv+dNljtuwcT81FZHoF8mHbDpmZSA28CJU0SmX40Dg9nfJ2l4rnoqo3PdOrLUHL
         2MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675758; x=1741280558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7N2niC0tm9GYpL4kTpAci69B17RX2iCWEhPKu3yRgtc=;
        b=Ob873y+TGLQHHwBxDXOpk/1MlGMc7AeLmwMzZNy/UVQ+T4YZYUD7QuhufUH7+s5e7z
         rwwibHE7c873CgEiBKWmC8SMLzP10CJUtk4uIA0dC+7/wag+ylv+Q1sYOwk6Hbo4VqB/
         TBIldTBf6Lr+eaGz/fgMgqYD8onCZ3GVK96bzTlbEvPOh8K15/s4kpjE27Ri2nHw80CF
         pCBhMHf2HQ25YYDViPo4uGI8tc+BQs83HlfQEEOfhO3dogrTirUyWzTJlBWg5IZkmRSP
         D21V//xwJ8ocpWNPLNTU/w2b8ezIVBnqQSUv2pW3jJn5yVECk5U0wqZ+nDB/Q1njGFvT
         JX0w==
X-Forwarded-Encrypted: i=1; AJvYcCVkLHsoM6Bl+FY9v5L05pCDE16KccqMojNLI+SVW4zfNqVpCjaYT/K5msDd7D10XYBOKc2K1t6tpfb05OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOVjwjQtLXG6U+Fuqe2vNuCd45H6ztiJ8iyVvmhzt+kMv9e27
	PSL6wD1AKy57O/mmeJt/UGp0W3Bcu3kUYXmua2dZrOscUop00XqLNfZzqroUdEf/G3d/XSks9XA
	ahUU27HG3I67yxg==
X-Google-Smtp-Source: AGHT+IGiRBy2T4pZuKAoxObAEh9uitxTWZj5IZVMfO1S6oM96yytdRmD9YMHqkMLgp0r3G0WIE6HBshMhjxRYv8=
X-Received: from wmbjh14.prod.google.com ([2002:a05:600c:a08e:b0:439:8ee3:e17b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e15:b0:439:9cbc:7753 with SMTP id 5b1f17b1804b1-439b03246d2mr237339895e9.10.1740675758273;
 Thu, 27 Feb 2025 09:02:38 -0800 (PST)
Date: Thu, 27 Feb 2025 17:01:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIaawGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNz3dSKgvyiEt3cxOSifF3LxETLNEMDQ7MUi2QloJaCotS0zAqwcdG xtbUAw8oUeV4AAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=SLkqtCbTV4WGngOIGeQdA6Ma/ik2r38oGZ+ix63LEAs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnwJqObbplB6yaeANqTFz7BvG+CSsY/WddYZzOF
 Ug+T+3+duSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8CajgAKCRAEWL7uWMY5
 RpFKD/9sJCzRyJGIyiSqnki5NeoIaiQUIr0r3kFUeBkycOLKP6NN7QmR1K7Sl6FCblSl8mcdcd5
 SMoTkfP7ETUcT/aDp8hNnqguI5bGB3kX65A06YmHds5KVEMEoDOflnh+SNZ2J4QAeBa59hyujnk
 8EyY0GBFoOxp0Qbf+NSamLl1BAECCBS7ycDJesX/ceneS+/TVJCtftniQOSmaDe5i6fs8XbpvRF
 Z9AYyINAQYYOLnZWngIoX8+S/h+gZgQPVbhHWSwwcC7hGXJnIQGjzBFyDi+JjfzQ48pYk8VIW+6
 WDRuuizvplZPnA3/Th2Q2UwY3VXn7IYHodwxNluX0gLIoJFe0sXF2Cd3wlkD0Fm346lyuQZUveJ
 DFrVjvse0OcwYk35esL2Il11UU0K1CB86qBqPW3SFmWunjk+q/WAGztVxyN0feyDDghNgIM6czW
 cKlXb2I/AzihXQwgoNqkJ77cGWAUF2Q5OGfbFtQ7CrgVqz3XHKpaoSunEDxsvIkCkovA41p5ZkO
 E9Ka0h7XG+BvNr9oflcrsYNyuxubjRtE1tOvtGx/L1ndT/hjEhCLi7ZpwnjyQ4cFS7QqG2cNQpn
 r+zHiLtV9TX7yvawCgcc0XEHv7rgMkuOB0A+6OHPixX3vp52M3H6PCpSRJkqGoV/l/pD+ULqBXX 1Tc+b3pKRo/rczw==
X-Mailer: b4 0.14.1
Message-ID: <20250227-export-macro-v1-0-948775fc37aa@google.com>
Subject: [PATCH 0/4] Check Rust signatures at compile time
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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (4):
      rust: fix signature of rust_fmt_argument
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
 rust/kernel/print.rs            | 11 ++++++-----
 rust/macros/export.rs           | 25 +++++++++++++++++++++++++
 rust/macros/helpers.rs          | 19 ++++++++++++++++++-
 rust/macros/lib.rs              | 18 ++++++++++++++++++
 rust/macros/quote.rs            | 21 +++++++++++++++++++--
 12 files changed, 112 insertions(+), 21 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250227-export-macro-9aa9f1016d8c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


