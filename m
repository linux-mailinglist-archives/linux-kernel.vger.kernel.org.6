Return-Path: <linux-kernel+bounces-567905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85608A68BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD5A46173D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217125522E;
	Wed, 19 Mar 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rq4f/hMm"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FDE253351
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383919; cv=none; b=kvdOzQJWsVK3pE2EMdlz6k7oAKHVOiaPhmFmRGPJSQSXd6MVqUzeeMxlDrZVMGrTvbbc1zEBlwjvsHB4uPZ7fxuZksed+Caf1aYIcnNDVgl3+66NeBeQFLBp8ROQyFUvRPGdolsBswJLsJDCBZ0PzYX14yQUjtHBQ2tM6GS5Nes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383919; c=relaxed/simple;
	bh=RuXrV//hIvjiA+W+YbupwJQyEmmFJohsJNlq+1idI7E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uR9w7lCvZKNS7bwjD67mnq1vlntJ58aIpk+MsVpU7AMZ3y0gZGGbgRCiwcymPMF+paIxGVaflUOxJM4C04rCpsr+AwmIIGoEkS7lR7RIs8Y758EHZIDQ1rYb04aa+1THsi4mXeNAFArL9eP0pPaiL7PPp/aHcqc7UKiYxajnBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rq4f/hMm; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3933ab5b1d5so4027774f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742383916; x=1742988716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IGofwAYv54rMEo8vimppynY4arFbdsc0r6K3/IoLjTk=;
        b=Rq4f/hMmX7yqwkmHpayWFuh2gQa8CJyBPWF/0V80Lb+Z42l+wOSohP+Qd90K/+1fUH
         C4m27rJUOgEK1amPk7IkumE2+O2HIHQ5ERl/DrvmVMCVtxEfnFfBWuK4rTHRzi0DiY/D
         hs/NCKiwxr1TPBj0g4EJNgj8E2hRXPmtDHzDe+49rNzcGHr7b6WUGTpr3UYsONKhvCQX
         kO9vi8dW+j0xnzYiF2NxMKf0ZW2UJmbVg1a5WaLfp8rrVwfJyT5EDx5CkGvwZ2zB4+8m
         ltoatRES5eT3BbxDMQCgIIvfcQeH2WAIhM/dYvP7zz7ymsAHmxmJQT2wfBpSeYjVE/oc
         64yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383916; x=1742988716;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGofwAYv54rMEo8vimppynY4arFbdsc0r6K3/IoLjTk=;
        b=vPwNBLKCcDHb2gTJsmfyjKctGaUZ/4GZAu4J6bI4Shl2ge+9lk8OTNmvtciibX1DPK
         g2MZCZPk3mFFsPW4MG05bvvIUPKGUOUhLIAq/ABSgfBqSJKJR3HgdSBZxL8WPGd77HkR
         Xx+qvL7mxjiZz85vDfvm9Jn02dOyhSbW9RO0kkA8jEGkQwNkBm0zia2XNsLzJ9npGcJW
         ARKRKDLnnU2RxuCJVhu+FUN3OK7EoTjoHVGHxFIXReYufsVjwQVIR9uS/F0mtuXwUf4+
         FQc7MpNmv+Zrqh8r5vK0UlFem5T7g8UBi+SlonPgMZfVma6rs8KPayJmb3Y7NRo9Sm4I
         0KsA==
X-Forwarded-Encrypted: i=1; AJvYcCVtW3Ujjx+lrjjvrZls7a5N7Yl6dUJlGVF5iLyEtbzW/Pl1FnBUih862+jZqgjYZApZ6ms6nQDyFdlNl1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKD7ZwwjXhrb2hUE5/b+O9c+iUZ+1+c3WdEPw2Opbe9zBcmg+
	7TLhgK1AqdK9y8xG+07w3upAUPqjCiK3ghJFOhYalYI2JTezpxwL3PptMSkD9inM9g==
X-Google-Smtp-Source: AGHT+IGzh3kXc8999T3CpI2hcHppBO7i1TzlYGwvSvJCEC1lo4kLWxIvb531h3mGWjHN3Kn0oXXC/T0=
X-Received: from wmbdl18.prod.google.com ([2002:a05:600c:6692:b0:43c:f256:f4b3])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6488:0:b0:391:952:c758
 with SMTP id ffacd0b85a97d-399739b65f9mr1899843f8f.6.1742383915723; Wed, 19
 Mar 2025 04:31:55 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:27:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250319112822.1961241-2-bqe@google.com>
Subject: [PATCH] rust: adds bindings for bitmap.c and bitops.c
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds bindings are for inline non-atomic methods __set_bit and
__clear_bit (bitops) as well as bitmap_copy_and_extend.

Update MAINTAINERS.

These are needed for providing a Rust Bitmap API.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
Part of a series that introduces Rust Bitmap API that has received
a few rounds of review. Thanks for the helpful review comments.

Rebased on next-20250318 and split as requested in
https://lore.kernel.org/all/Z9nAVIokrWqoRiFR@thinkpad/

 MAINTAINERS                     |  6 ++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/bitmap.c           |  9 +++++++++
 rust/helpers/bitops.c           | 13 +++++++++++++
 rust/helpers/helpers.c          |  2 ++
 5 files changed, 31 insertions(+)
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ebf7fa9a814d..7cd15c25a43c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4111,6 +4111,7 @@ F:	tools/lib/find_bit.c
 BITMAP API BINDINGS [RUST]
 M:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
 BITOPS API
@@ -4127,6 +4128,11 @@ F:	include/linux/bitops.h
 F:	lib/test_bitops.c
 F:	tools/*/bitops*
 
+BITOPS API BINDINGS [RUST]
+M:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/helpers/bitops.c
+
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index fcefe3068a28..4f9374c2d7e5 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/bitmap.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
new file mode 100644
index 000000000000..a50e2f082e47
--- /dev/null
+++ b/rust/helpers/bitmap.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitmap.h>
+
+void rust_helper_bitmap_copy_and_extend(unsigned long *to, const unsigned long *from,
+		unsigned int count, unsigned int size)
+{
+	bitmap_copy_and_extend(to, from, count, size);
+}
diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
new file mode 100644
index 000000000000..0ea1611b95dc
--- /dev/null
+++ b/rust/helpers/bitops.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+
+void rust_helper___set_bit(unsigned int nr, unsigned long *addr)
+{
+	__set_bit(nr, addr);
+}
+
+void rust_helper___clear_bit(unsigned int nr, unsigned long *addr)
+{
+	__clear_bit(nr, addr);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index e1c21eba9b15..0c25cc86a52a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,6 +7,8 @@
  * Sorted alphabetically.
  */
 
+#include "bitmap.c"
+#include "bitops.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.49.0.395.g12beb8f557-goog


