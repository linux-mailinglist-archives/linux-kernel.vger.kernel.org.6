Return-Path: <linux-kernel+bounces-192579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93BD8D1F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652171F22FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9F1171083;
	Tue, 28 May 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ea0IfQej"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08F17084E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908303; cv=none; b=fVNglqBhf1ZJ6q8XuYNrGK9Q9YfAqDgQJ6Mom3SVzK96ZIPiOIFWJzG+qCJy6e/WI+q38pu1yPLfTMQ8QNZh/YsYH8BiuAlfEV2ptkKcD5EehDmVQ68cx+fugJrRAXdtq+nquwLK5WdPEAU47tAQ3ZGmaZKQWFAEOzc5ejSxXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908303; c=relaxed/simple;
	bh=o0vfP46JuhVT9I8s8c1aGsT1nEiHVNuFmZxbFB7IUxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aRmAooLJuYPA2kxZireV5OoK2PVx38g3IsMdfK8PPNHmAcGAdWOXWkMxIZx4eBy3RXqbnRun1z3wXozsbE9WnPHhadet5KReSr32kp9/v3p8pyuFpR/nbBJgUlsq+5nu55YN2mHTMgFQ3hxUHyMEpV70FrpbY3+iiteo1mEeth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ea0IfQej; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-52707aca5caso429185e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716908299; x=1717513099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDs1IJHnbNwo/zETkdmKSImuTQj5Z+oesXCPuXUO86Y=;
        b=Ea0IfQejoKzuWZmF2hpVVurSvkmJrBYExpVpSWyOK2n1nIFRSJybv9KLBhDXNIKV/F
         zCEdYC0D8441Lmo2KdSdi3nmvYRrBSQw2jYq3mXFph13JgPLySkjxKYeT4r72emQVuui
         8c7KepdI3ngUXJbvTmoWeSEksLrfUJwhbXJYv9Hv9eOagKrKtf+qemyPt2fE0gZE6Nht
         tm5ZaUsCPX3l1QD+9d1X/gTO0Mkx85fqiuP7GSk6KAqYQCWTOB46dRWuFLcQtx5x/HSF
         i2Ed2hMe1vY6nJbF0OdehUTsN/BmRLKBfot/zFFWX2I5S0+2bdgCwEo21FvUNKMaZg0E
         TKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716908299; x=1717513099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDs1IJHnbNwo/zETkdmKSImuTQj5Z+oesXCPuXUO86Y=;
        b=UIrZFP0JF6P5g2citevN2y5M2ALpwFlm1KadUFZDowMtZ75Jo05USZQSmQBoXIOsuc
         KJRaMleilm78HW7dEpx1IQnABrWmTc0/AJue1XkombL3qsdW2INHrIDvNbHIOJHcElA9
         xLIqq5NelB4xuy1MjILAEpWRZPNUXqFo6K5CxeosVJ93CvdvGyNN/ImAyR1sY3vmHAnk
         9Ui0hAsZp1hR/XWOWMh9/F/L79SdqHeqQcQFi6ajkyibT9IAU73D7vga+fPh7nSkG0co
         RoyeN051bSwrMutLkdConurf7tprjv0B8wmdnwymDJMkmljryuDw47wkUha/a19c3RWW
         ceyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/KrBLBHM3HZU32p2kyJmrFbU27k1lbzqlWp3h2hAD3rQKp/AHXs1ATmDCxfcZcKG1gCB4cqqTpmsFNpI7aDgE+BOBUKPIkfkUfNkO
X-Gm-Message-State: AOJu0Yy1af630InGC4LdqNuQzeMAcHQS2RbEGtwti48g+V+BkRw0IBT2
	jKfi+MH6NYnwmQFSMAGdIUgIkVyKzPRK/226HxJPnG1LIwNazWA4vF1x7hQkyMtv8e9e8Zo7k+U
	Ei+hCb1FsT3yxTw==
X-Google-Smtp-Source: AGHT+IE0/smWA0nv7DnIzJunDnNDJqSN2EHjtIqsT2/sKJP0Nv5knZ9MVxp5tyeosgZSBFdOKEeD2mUHzkRd5q0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:4508:b0:527:4ba:5c90 with SMTP
 id 2adb3069b0e04-527f16c29eemr16354e87.4.1716908299488; Tue, 28 May 2024
 07:58:19 -0700 (PDT)
Date: Tue, 28 May 2024 14:58:03 +0000
In-Reply-To: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5419; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=yETbsBE1UqQkTUzr6kFMmtAy1ZCV9RovzSXiqjWQMC0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmVfEBZqo9IvVPwPO5CrRJ9S+efkmY181jkflVc
 +WDKDaJ64KJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZlXxAQAKCRAEWL7uWMY5
 RueSD/4wGfhLRtZZBSvagz2Tr+7o+akzMLKWhMQWrJ8eKjNds02I9WbzFLZQUGXQ+4RqiLvddU4
 n8fLx3irk1ez8T2CEBs2O9zrruwTzwEi76SM9MbP9366gM1BH3RZV/48csVSYgCW6qUBSdVqE3r
 S4Yk9ttNOYeJxILvebO8goJJgqQIcmyI7J8JG7HlmLdq33wrdNfNwCvH1bkxj27/BzRUqOAnRdG
 4emSEQudPjgRcQAUqYek+ZPl1t70K18AjpySXsRtbvdPk84CpoCMCUBmx0q9XIbEs96+qBvCjmU
 saj6XzYGCChZpUMn4ERwoPTvmnIrKCcc4PDYxImnLEi7TsXDbrEMBpP3bRIVjupFwEpskKqI6Oe
 7fZ1KycxvBFAq+/Cp/wiYClD0TxxK41XS9oK/qRukR9BlMHf0zadfQlwnx4dbMLyxGk7Fl2hlwH
 G0Sc3XFE0Mkud0WOFEKQ+0l85lZq/vTdHxYqzjUCmhlg8nkMrF4IfRAdk9R7EZvdWy1ioq7PUMD
 xEsXLgsyhIdd3nDBtRIFjIXNkeXeMrgy/tnBwk/hCIIM+bFJcx3e/6JvMdWJVhIBI1SEYxLjzyB
 zxqRBpw1O+VulD9zCEJFIthq2o0jSikBBtciQBV+VZFr/debLYs26gcJTVHfDPh/jOhqRPdf/sO swwxMcc0sTnOzbg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240528-alice-mm-v7-2-78222c31b8f4@google.com>
Subject: [PATCH v7 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Arnd Bergmann <arnd@arndb.de>

Rust code needs to be able to access _copy_from_user and _copy_to_user
so that it can skip the check_copy_size check in cases where the length
is known at compile-time, mirroring the logic for when C code will skip
check_copy_size. To do this, we ensure that exported versions of these
methods are available when CONFIG_RUST is enabled.

Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
on x86 using the Android cuttlefish emulator.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/uaccess.h | 46 ++++++++++++++++++++++++++++++++--------------
 lib/usercopy.c          | 30 ++++--------------------------
 2 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314f4832..d8e4105a2f21 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -5,6 +5,7 @@
 #include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/minmax.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
@@ -138,13 +139,26 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 	return raw_copy_to_user(to, from, n);
 }
 
-#ifdef INLINE_COPY_FROM_USER
+/*
+ * Architectures that #define INLINE_COPY_TO_USER use this function
+ * directly in the normal copy_to/from_user(), the other ones go
+ * through an extern _copy_to/from_user(), which expands the same code
+ * here.
+ *
+ * Rust code always uses the extern definition.
+ */
 static inline __must_check unsigned long
-_copy_from_user(void *to, const void __user *from, unsigned long n)
+_inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long res = n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
+		/*
+		 * Ensure that bad access_ok() speculation will not
+		 * lead to nasty side effects *after* the copy is
+		 * finished:
+		 */
+		barrier_nospec();
 		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 		instrument_copy_from_user_after(to, from, n, res);
@@ -153,14 +167,11 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 		memset(to + (n - res), 0, res);
 	return res;
 }
-#else
 extern __must_check unsigned long
 _copy_from_user(void *, const void __user *, unsigned long);
-#endif
 
-#ifdef INLINE_COPY_TO_USER
 static inline __must_check unsigned long
-_copy_to_user(void __user *to, const void *from, unsigned long n)
+_inline_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (should_fail_usercopy())
@@ -171,25 +182,32 @@ _copy_to_user(void __user *to, const void *from, unsigned long n)
 	}
 	return n;
 }
-#else
 extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
-#endif
 
 static __always_inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	if (check_copy_size(to, n, false))
-		n = _copy_from_user(to, from, n);
-	return n;
+	if (!check_copy_size(to, n, false))
+		return n;
+#ifdef INLINE_COPY_FROM_USER
+	return _inline_copy_from_user(to, from, n);
+#else
+	return _copy_from_user(to, from, n);
+#endif
 }
 
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	if (check_copy_size(from, n, true))
-		n = _copy_to_user(to, from, n);
-	return n;
+	if (!check_copy_size(from, n, true))
+		return n;
+
+#ifdef INLINE_COPY_TO_USER
+	return _inline_copy_to_user(to, from, n);
+#else
+	return _copy_to_user(to, from, n);
+#endif
 }
 
 #ifndef copy_mc_to_kernel
diff --git a/lib/usercopy.c b/lib/usercopy.c
index 499a7a7d54db..7b17b83c8042 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -12,40 +12,18 @@
 
 /* out-of-line parts */
 
-#ifndef INLINE_COPY_FROM_USER
+#if !defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)
 unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	unsigned long res = n;
-	might_fault();
-	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		/*
-		 * Ensure that bad access_ok() speculation will not
-		 * lead to nasty side effects *after* the copy is
-		 * finished:
-		 */
-		barrier_nospec();
-		instrument_copy_from_user_before(to, from, n);
-		res = raw_copy_from_user(to, from, n);
-		instrument_copy_from_user_after(to, from, n, res);
-	}
-	if (unlikely(res))
-		memset(to + (n - res), 0, res);
-	return res;
+	return _inline_copy_from_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_from_user);
 #endif
 
-#ifndef INLINE_COPY_TO_USER
+#if !defined(INLINE_COPY_TO_USER) || defined(CONFIG_RUST)
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	might_fault();
-	if (should_fail_usercopy())
-		return n;
-	if (likely(access_ok(to, n))) {
-		instrument_copy_to_user(to, from, n);
-		n = raw_copy_to_user(to, from, n);
-	}
-	return n;
+	return _inline_copy_to_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_to_user);
 #endif

-- 
2.45.1.288.g0e0cd299f1-goog


