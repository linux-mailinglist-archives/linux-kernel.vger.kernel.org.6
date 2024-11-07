Return-Path: <linux-kernel+bounces-399234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D59BFC5F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356FC280F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68818754F;
	Thu,  7 Nov 2024 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkPbRjZ0"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211442A97;
	Thu,  7 Nov 2024 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945348; cv=none; b=X6lIdBuLHWYqYL7gElVKRg8ZyXcwLozvEmOeja/mFUwiLHU/b6B1e/kUvPbaP8Z1NJuWSSgMnFQc7TIoZ58kxAnNWjxsV8Q/wqlCiIXbrhoWxhgWbDg2zhO4VDGh4or8Dd+kO9jXMzQq1dnI0sKVMHgHU90GWYzok8oiEtFtYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945348; c=relaxed/simple;
	bh=U/MHHMANLLRFH8bXUZDEC7Ll1T4qSlmleiKizwJ2cz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6p5RdASZV/T3xLK5KlRI7e+uVm28FvePq+A8lnKtNF59Vu0e+y5bNUoCfWK+4GbkhkdCSny+uQO2Yb++XWYI4X41uOybKiKQjEfGE0yqU685HSrToFvNZFa8CKEhWVjQtMUnQmx9RiGO0WZl1iaShRKbyPhmnj7v/89r7i3GEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkPbRjZ0; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so332739a91.2;
        Wed, 06 Nov 2024 18:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945347; x=1731550147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LgUzLaa/81IYkOXJGqaU2iQyIFHmm0Jvesuccgag3s=;
        b=kkPbRjZ0719SIFFibxWoNuPXI2aGpTqHKDAjnHRhHSNyRTbvOz9P0FA2DjiU0d+Dp3
         7gw1afiC8jDtUQXrxG3L5LyR2HAxbzlN3WPvArVwbYgMFcEDpfOE08+VBHYHLW6odB7n
         0Fn4lr5MKfR42WZ44uRk5N37iLUr9sRNPzYQnNXClfJlmiKV33cuT3BTOW8PcCGITzm8
         t2F5HWdKoJH5Vg0uYgN41s6e/3B1XKg5K6AMilr4kpFfmt2cpy593rPQM3h0CErbO99O
         RDbv2Z9OhZ6gOIL1reTJA0NCVj1j4hVus/8ca2b+CsJR9puQGf1i0Ycxf1kzAFgYu6Jw
         cwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945347; x=1731550147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LgUzLaa/81IYkOXJGqaU2iQyIFHmm0Jvesuccgag3s=;
        b=dqlsVwtPyH0DNX0oLSFCr6BevcXiecjJMPfpRcka7089WdXrO+ITnAjAMjCK9tep2N
         l0RG8Jg3XH5TX3ldRDX2rTktJixiK09XxK7uiKftFnqbthq9BsmTbSQX5HkrQzJYNdf9
         J75w2BndPDsREprfjiOYi2ksRKCtZAjr4Qnih8lMDpHEqcCIUyZEWJiQ8sbzTaH8td4T
         MFRjQU/KME3ZoPHyRG3HtByeFv7PZCGMqmgtILa9LfuQjLpn5itJeh6UcgiFO3PP906c
         I5sKXTSDfZoRGf2BRZVay7J7K9eGh+UOfXgVVtICIdhpMZO1nRcYbL5MjWbEgno7csal
         TjBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZqTUqsFBZKWf9jGwXm8fmkg3Ye95JwTIfHdlXonNPv0VE0y1K4KkinWNoMV61RB49qm8gdJQeAHqL8bmHHM=@vger.kernel.org, AJvYcCX9I8MinS34i2Y4VTu3gJRfblufAzhMuunICL4KQzIJKJX4CU8Pul93F+jFgutUHwAQLyBtdU5jAjlbWyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXfV3ZShbxmrkgfwV5WdNhA3xr7arkYb+WP/TPals3+VUfbCx
	g+coeZi0MJgQ051jGq9AJhVxWszsWYFSDN/cBsEGT7CyMsHoaTjO
X-Google-Smtp-Source: AGHT+IGfJWUafciN2fNXLy1jWI1dGe71eoWoM4W2pn15Ul+b+0lSTNIqhVZhjbJURnXoG4DzkOlD4Q==
X-Received: by 2002:a17:90b:38cd:b0:2e1:ce67:5d29 with SMTP id 98e67ed59e1d1-2e94c2dd2afmr29798279a91.21.1730945346805;
        Wed, 06 Nov 2024 18:09:06 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:06 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	me@kloenk.dev,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	aliceryhl@google.com
Cc: alistair23@gmail.com
Subject: [PATCH 05/13] rust: helpers: Remove kunit helper
Date: Thu,  7 Nov 2024 12:08:23 +1000
Message-ID: <20241107020831.1561063-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107020831.1561063-1-alistair.francis@wdc.com>
References: <20241107020831.1561063-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions | 2 ++
 rust/helpers/helpers.c        | 1 -
 rust/helpers/kunit.c          | 9 ---------
 3 files changed, 2 insertions(+), 10 deletions(-)
 delete mode 100644 rust/helpers/kunit.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 0269efa83c618..b4032d277e722 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -9,3 +9,5 @@
 --allowlist-function ERR_PTR
 --allowlist-function IS_ERR
 --allowlist-function PTR_ERR
+
+--allowlist-function kunit_get_current_test
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 40e51daef412e..875e1fed81c24 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,7 +9,6 @@
 
 #include "bug.c"
 #include "build_assert.c"
-#include "kunit.c"
 #include "mutex.c"
 #include "page.c"
 #include "rbtree.c"
diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
deleted file mode 100644
index 9d725067eb3bc..0000000000000
--- a/rust/helpers/kunit.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <kunit/test-bug.h>
-#include <linux/export.h>
-
-struct kunit *rust_helper_kunit_get_current_test(void)
-{
-	return kunit_get_current_test();
-}
-- 
2.47.0


