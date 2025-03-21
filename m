Return-Path: <linux-kernel+bounces-571140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21CA6B9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673DF3B4C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005B1224AFE;
	Fri, 21 Mar 2025 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyyc9Taz"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8522370A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555747; cv=none; b=L1W+GnbxntEpwwvxBVuHjG+eUM9GIWFMv8foXLm/oGZ0OuuZvfzdcTUBhovXJMCSbhDevcQtX4aAdxQx0mvmo8ETUGvQKz6PAE2YuNLyhfyECmk/nPTKhhcmU0CZTqFaMJD+CR1y/tScIb7icKLZjl5BzSinaCBdFDVg0GDJqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555747; c=relaxed/simple;
	bh=rVBUM7bruqQGcoYEJyOcUwZZEvKvdz5+odlyIY/Wvz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DVSE1CFUN4V8RPl7wqGj1V4l7IGxThklTG8ue5a/EcZ6fc8M68/QFgnkqiS1AMcCPVXWMsh7THUGOrycmeK1ZCb2ZbfSKmVeVnzAxnIHPe8iDsI9UGXQhsw5Y7PNRIuCLWNjaMFSpIX0BSmGr1CMk1/LDoCQmkhe8GEirkRyQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyyc9Taz; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-399744f742bso457198f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742555744; x=1743160544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Zwfes82qFNKiyGqKPb1cc3DwbfmpXINqEhCLg/yS5A=;
        b=qyyc9Taznrf9ZQIyjYF+kQ0iYxzZuNbUs7ObNQ/PwjkaILq4XdgbBv384Bs2txp1MP
         6xXrwp9VMRxRdH5BSI3xlCfz649io7xvhFXZ3TnRyCeq2fdnhmZhauIJTEKbLxWtBXhK
         nhnHW9kEemzqB1ad8y+ldN8lokY8RKnZDwsJ6bTY7kEGv44MFNriJCYhOsvItDyBz47w
         H5/Ejqo5ttCwK6VLVnZmySjEIjqU1x0CCHQy9hIUlDNYwvzTRNN2aI+/OeuTgOnRlPim
         2bvswJrN/w1OyOhveOsbABc158u9znmj3sTF9cqQ6heUzhhZwfVSWxKzvaV4rd9ZUE2k
         C+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555744; x=1743160544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Zwfes82qFNKiyGqKPb1cc3DwbfmpXINqEhCLg/yS5A=;
        b=B085u0IpVJJHMGCJQbsf0YuoOj3vxENcZO5KwaLnMw26teqNc04khB3vXmbzWXuQM7
         E/N1cArCUYPN1pBYhF6m+m0ffxMqOtDcYs6c/hM7fn88m76enSLpbiHmN6j1rBu93GoW
         WIJp5jaV+FSoLXioNYc2dc2DfkDmrYBZN+fSYabXfmT6L7Arw8/hzY7aYhiDFJEc0qR7
         uIvUjD1ClZFbGh1LK6driKLa0HELVr10c3FuDhNPBp2gpDjB0aVXpuFyr2D6ABVfpJJN
         f2RbqhMrFlBcTmy/Q/Aaea/SMHxJL6xbBIwmnFI4Wv3JU7Pr+dWuieNz+iCCMj4Qdto/
         FD+A==
X-Forwarded-Encrypted: i=1; AJvYcCWKAU5YasaKhVGME4aH0vSlA1OzojC6ikyfzUDRswSxDiWD9x5pYnXvZ5PzCUR29RFrjrfnqaXdQSXdTZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ta7RdJLXy7s62luWfrVrdWSFLmRo3kKs5VrG1uj2+o9Gw03b
	d9gSlIbLbUQ7Fs8FG6v/pdQg8iu2B7QMQUNm6lBp88XRKUOYbwIehfHjWbaTySxmvw==
X-Google-Smtp-Source: AGHT+IFjWEPxXxy0axKgC1Qsy0TWOjbtL4nGbIrKrKA70O1rBQtPabD4KPuVGaJzQTHJOIgnvHOsYjs=
X-Received: from wmbeq10.prod.google.com ([2002:a05:600c:848a:b0:43c:ef7b:ffac])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4014:b0:399:7f2b:8531
 with SMTP id ffacd0b85a97d-3997f92dad8mr2642504f8f.38.1742555744131; Fri, 21
 Mar 2025 04:15:44 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:15:30 +0000
In-Reply-To: <20250321111535.3740332-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321111535.3740332-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321111535.3740332-3-bqe@google.com>
Subject: [PATCH v5 2/4] rust: add bindings for bitops.h
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

Makes atomic set_bit and clear_bit inline functions as well as the
non-atomic variants __set_bit and __clear_bit available to Rust.
Adds a new MAINTAINERS section BITOPS API BINDINGS [RUST].

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS            |  5 +++++
 rust/helpers/bitops.c  | 23 +++++++++++++++++++++++
 rust/helpers/helpers.c |  1 +
 3 files changed, 29 insertions(+)
 create mode 100644 rust/helpers/bitops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 52fc47a28b4c..7cd15c25a43c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4128,6 +4128,11 @@ F:	include/linux/bitops.h
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
diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
new file mode 100644
index 000000000000..2eaab292db4f
--- /dev/null
+++ b/rust/helpers/bitops.c
@@ -0,0 +1,23 @@
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
+
+void rust_helper_set_bit(unsigned int nr, unsigned long *addr)
+{
+	set_bit(nr, addr);
+}
+
+void rust_helper_clear_bit(unsigned int nr, unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d4a60f1d6cc4..0c25cc86a52a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -8,6 +8,7 @@
  */
 
 #include "bitmap.c"
+#include "bitops.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
-- 
2.49.0.395.g12beb8f557-goog


