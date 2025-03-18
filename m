Return-Path: <linux-kernel+bounces-566693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5ABA67B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC2D16ADF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC16212D86;
	Tue, 18 Mar 2025 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mazzuzZB"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61220CCF0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320162; cv=none; b=G5D1DYeA13bxnJSlsvol+WAGjsIDlmemHmvOHfX6IIKS3pP13tvobREPQ6yDf6xrQoGnxVZSUA+fr7g0PHNqMF+o5TrtW6QL6s1KZy6hv/PAtKdbkT+tlwSOcTKVDy6H7rGT6lyjGTd4kNWOvSKk8QDBJOvrdjVIYv6aAMXWOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320162; c=relaxed/simple;
	bh=uJIutiU4F9uJdD39iNb8Ou5XvYDbRa8EcLckqr3kp10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y60gyHW+zDLShpmLZCYo2OKfqJq6RRYQtdV05Gl5xAbcK90TTd3V1uA9RDADg9YIppopgHQ0zhCyefOYRXhdVcL/U5yLmyolPDkIYZLNSmEnEFzFtAU9x5BEbKc4O5sAHbjGArDGpdOgBpABzVv7szA4W4LAtbuyPR+t57sxmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mazzuzZB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so18550905e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742320159; x=1742924959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSbH1lMYu7B70rx8iHcL63GgWlDTcxDGerlsbQLm9MQ=;
        b=mazzuzZBB6JASR0+GwTWFRNlh1tpYoyxTRhT/MrvYEZ2kjDrVxopj6T0IQOOA1/YRw
         hZ/Qw89zgFdW625xnq8yCsUjZDwkDih6RbP6zg6Wmq4DYsXQuEdaonbhPQcqeXSPRu70
         rUwim6HriVQhzU4ieswYm3YUU5sxXvo2V03l7rFvwUXzpKLE2YOmHJnOyXXkNNIncmTM
         bvlkbUiSizEpFLwx6HO+giyVmDe6LvVa4Pbm+KMY7jDhmzMBxWlyI+c1j+Gq8MVVURnq
         8HGV7H4VELQi9A3H47AFNWC9qwGfqc+tDGQWs9NQ9m+QBCAnD1Kf+ZDXj5FaHfDSouKi
         Zj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320159; x=1742924959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSbH1lMYu7B70rx8iHcL63GgWlDTcxDGerlsbQLm9MQ=;
        b=GkYe6KQwbk4lBxnawWlKGGBe0TCIvQFdtC88RDP7n8LdVRDhLQyfWNwph2y+FaeMLf
         Mu9+huKmHCLep3/1tjRmEpN3abCA6VZO8SrdH2artWYMQEl8jJCFw4XVkIO2gBzMPCBY
         eDZ+aDCASOffsTvPm3HLdTuNPGdgvsNHRQythkjQGXVjx3FkByG5QqrJraaGWj2SOZDV
         ogd99/rBgxlFMGHdRquZAacV1cSnuIH+wOn+Epikq/s91eEjdBjUloToTNbdEhaFEqsz
         7BzxTd8r6N7VD7YS6JANzZvEEAgmvs7sJBFpEjjlFspHOptHpD4/yLnGK3ExdiZZPP0M
         YKrg==
X-Forwarded-Encrypted: i=1; AJvYcCU+fY3ulsjL4vb/KZ58sJ96MQp2Zx3U3+l1F7wh28Mjf/bYgiZkoJTou/WX4okvHeFUqa3C/PavJkNm7Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFHxoXA9DVEBKWPV1heWIGGK4dpR8MApySBpAW0G5hUTY2+Pj
	LHHOUh8atgbRiqT/6SnsO0zkLTKPmdncAxdADYylJAinIyrcAh4PV6kGuUDHb/OlyA==
X-Google-Smtp-Source: AGHT+IGwrDuMxtuMxwl92MGb7Xvh2jSFb+fFzxcdzRaMOUfOAdTNuPSleq3PgEtUak+wFqpPII4/qFo=
X-Received: from wmqd2.prod.google.com ([2002:a05:600c:34c2:b0:43b:c9fc:b269])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d2a:b0:43c:e2dd:98ea
 with SMTP id 5b1f17b1804b1-43d3b9cd71bmr30430905e9.22.1742320159036; Tue, 18
 Mar 2025 10:49:19 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:45:45 +0000
In-Reply-To: <20250318164221.1533590-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318164221.1533590-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250318174756.1625571-3-bqe@google.com>
Subject: [PATCH v4 1/3] Adds bitmap.c and bitops.c Rust bindings.
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds helpers for bitmap.c and bitops.c to get Rust bindings
for inline methods __set_bit and __clear_bit (these are
non-atomic variants) as well as bitmap_copy_and_extend.

These are needed for providing a basic Rust Bitmap API.
Update MAINTAINERS.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS                     | 11 +++++++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/bitmap.c           |  9 +++++++++
 rust/helpers/bitops.c           | 13 +++++++++++++
 rust/helpers/helpers.c          |  2 ++
 5 files changed, 36 insertions(+)
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c43d66bd85f3..50f44d7e5c6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4029,6 +4029,12 @@ F:	tools/include/vdso/bits.h
 F:	tools/lib/bitmap.c
 F:	tools/lib/find_bit.c
 
+BITMAP API BINDINGS [RUST]
+M:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/helpers/bitmap.c
+F:	rust/helpers/cpumask.c
+
 BITMAP API [RUST]
 M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
 R:	Yury Norov <yury.norov@gmail.com>
@@ -4049,6 +4055,11 @@ F:	include/linux/bitops.h
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
index 55354e4dec14..6bd4396b9cd3 100644
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
index 0640b7e115be..74e5e10694a4 100644
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
2.49.0.rc1.451.g8f38331e32-goog


