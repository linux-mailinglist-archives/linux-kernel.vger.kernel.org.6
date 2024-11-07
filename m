Return-Path: <linux-kernel+bounces-399237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D239BFC62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AA11F216B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4FF19048F;
	Thu,  7 Nov 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghVr9z/B"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDC19067A;
	Thu,  7 Nov 2024 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945364; cv=none; b=G0IeYUzt9Si1BH0FgO9YggSF73/DN/jHOs4tq0h5NFh8Pq7C+RLuyBw0O70LnEWuZLmOifMsCrZROQH51+e4T87aGe6YX+icrTeOlEen1vQXIH+dPrhLoY7PNzZWOHEadMA6Q3QXcT2ENNamSuxSQcZ735M6lCyVzVcF7sCPfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945364; c=relaxed/simple;
	bh=qjxRgkKubWCYQkrvHROpBnMJrHerul6P0ykac64JUmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Aiw0FIgY2SRvXzK+bHzr64J1qlnXmgn/WIvPHHnrSXhA2wbUYxyO4p6na10E0evBP4kTli+HWCeTCJM7rBeZTpqHmptqGXtpbNl3L//49GE+OIKagJHlCPOFgnQrXi7KJSfVq6z2mVjnI/oBBeo0eVppj+kfzAgEzuhAG6QYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghVr9z/B; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so354995a91.1;
        Wed, 06 Nov 2024 18:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945363; x=1731550163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3xgszKdmXv5sfVpE8qDh7k9LEDdMG+JDVoZYiQkKmg=;
        b=ghVr9z/B0UPhKhBttSqzrnFCwnJpyfeUn7Syomoo6IHXesoy21cy0OR9buJnpCmhAs
         k9fU5GkfWuw2UiY3zXvOdPcrz50vWm8amym9RypbUUXQSRrLVzl2Yz7zqWqztQkIc7ON
         BYmXSWgk/LomOZer1ODareKyiXIh0snLIbWwF7oqyQgFzAiz5bS5fZrcaYIIeOZeW5Ui
         ufEaNgsemPk8OlSZtfyH/QSCORakKFh5m/4IZEpeaHRrCx8POGaEbMnp+Uc4ijY+MOEK
         fxdQinuqaDcx/hITHDYfdS7I7J43rbSY14sC0wyPsqJORVC12YjSQmNdGOFF1hN6JF0n
         LTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945363; x=1731550163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3xgszKdmXv5sfVpE8qDh7k9LEDdMG+JDVoZYiQkKmg=;
        b=iUEq+nOwbctYIwFlQhpvSTOiRxe4Zzy6s7W4qCa2zkMpGp1rHO0tlSIJwwN8l7NP9w
         +CMiEtGgNagypNOcBZkttNFXnjoa+ylBX0nEvhnb/sT3DBJLeMwUHDzgUjD15Ie1hMsW
         pjzMwSrSzOtnDq6asop737cpuAgWfM5f5XTSfUS8Fk4nh2u8x7tsWCuUwJ1lf7eJ15El
         C3BcCPmhF1Sf71YtRyCrp9/lByWTDZ6PoVqoeMMnulE5734dgl2RSGRNlq8ObkL3Oy9t
         BHrxkNm+DK03TM6+9ITR1WDBHzpCVTZ1il1suQXPLLJNObe+IbdxZgzZgpSHNaPzjCl/
         S+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUTtnVHUhO6tBXEaUmRpSv9lADTbZDZBXaEgGk5PfL2ok/JPXMxjz2qACxrgvNf+0GUvaDhCqr8eF+KSc=@vger.kernel.org, AJvYcCW0RaKYPP646lH0rb3cgImkpSGe8BiIlNBF4+E1AzuWU23UvrNN7ZsK1VCTq8yDISNgwTGFlWoFYOdUG6wj78Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+Zj9rjTsCXfN1iPT5dH0xJGfs6qkWD7GvK12da4YGJgynVyd
	GevPd05aHAyp8laU7VvkHbAOIfNvBbIgcEExBPVRdxW9k5yV064X
X-Google-Smtp-Source: AGHT+IHmqdGbNvIKFonBqecHGKg3Y6Z/I5/bs+3uLSpsKKdBupDkxHpj5emo8FdIS6r5xt3bM1h15A==
X-Received: by 2002:a17:90b:4e84:b0:2e8:f58e:27bb with SMTP id 98e67ed59e1d1-2e9a753b70fmr273600a91.8.1730945362776;
        Wed, 06 Nov 2024 18:09:22 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:22 -0800 (PST)
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
Subject: [PATCH 08/13] rust: helpers: Remove rbtree helper
Date: Thu,  7 Nov 2024 12:08:26 +1000
Message-ID: <20241107020831.1561063-9-alistair.francis@wdc.com>
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
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/helpers.c          | 1 -
 rust/helpers/rbtree.c           | 9 ---------
 4 files changed, 3 insertions(+), 10 deletions(-)
 delete mode 100644 rust/helpers/rbtree.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index ded5b816f3041..e464dc1f56820 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -13,3 +13,5 @@
 --allowlist-function kunit_get_current_test
 
 --allowlist-function kmap_local_page
+
+--allowlist-function rb_link_node
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 084468123416e..d389944186479 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -17,6 +17,7 @@
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 61ace53675c04..7f9ffde471da3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -10,7 +10,6 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "page.c"
-#include "rbtree.c"
 #include "refcount.c"
 #include "signal.c"
 #include "slab.c"
diff --git a/rust/helpers/rbtree.c b/rust/helpers/rbtree.c
deleted file mode 100644
index 6d404b84a9b53..0000000000000
--- a/rust/helpers/rbtree.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/rbtree.h>
-
-void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
-			      struct rb_node **rb_link)
-{
-	rb_link_node(node, parent, rb_link);
-}
-- 
2.47.0


