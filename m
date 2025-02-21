Return-Path: <linux-kernel+bounces-525238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980F6A3ECDB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E23420606
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1491FCF62;
	Fri, 21 Feb 2025 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4PVf/RF"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B901FECDF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119641; cv=none; b=oj2weCLqI4KSRZctSMgbJdPtIGCvscGr9NDNNwc46xhkk2ga3FRf4B9bNQUnw+Zka5aeBFznIu6qA2qhSJkaVWQTy5yrn9i/UWiaqZfNrJ2RIgwwI/vYg0O5HV6d9GfcFQmX1MdVhhdjekByOJJF8x//M7avw9R11bGwXsw0P/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119641; c=relaxed/simple;
	bh=QwtY0+2OsM6DemRSALyHBYrUGqwilbtsVhnN9LkG79k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O4P7F5B84z+UHidNRTT8IMSWjyhRY6R1guwogsa+HFdLCRrjfPOgaFuHutHIG2bM0+CAkNphZU4sQOP2lA41amewAiimUNOrNnUwO4EsT6+iexzS0EGJ+Cdnmxgl5DKMtIpdsMQKPLi8yFlN7uotjsk0k0yVux8DVY/EXnjAGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4PVf/RF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22100006bc8so30901265ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740119639; x=1740724439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNg/PQcPlHeI4lLEbliBR3X5bvZKY/k1Ucn2ATe8Pak=;
        b=T4PVf/RFeTUN8g4LsUskPEcpee7tS+Qs6FMH7RWIwPFwO6+zlLdKnP/ofv7bgsGlpb
         UG7WpGH3orBlDkX5vpjx/Gvn/Vn+Lfr143XK7mcb4beratv+7cEhG5LjUyED54ZhM5OI
         Xj7JlqljUkYNerBzI4qq+ZZ6zPGbfF1CY/ComJwMIAMhyOYiUCAr7v8gJUgudC9UVc/W
         EYAM3ickPmWQBmNB4qE+PuI2zWbGScuF2LtRMDDWkePAann4okgw2xGfB3aPiQOv2RjR
         r1SUIKe4YjNQ2cxfNaS01JZP2hzKWLITD7f/ooLUx3u1l3x6RtuAhzV4fUQVSkhYqwW/
         xjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119639; x=1740724439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNg/PQcPlHeI4lLEbliBR3X5bvZKY/k1Ucn2ATe8Pak=;
        b=Nz89ETcakZgVqtyeQEqC6i53BFZzpf0S+gmj5zNb0gfd6l3fORaMGWMkTa26c5YlDT
         M9tNSTo0rXC5d0yDJIJxRY3/VokzIlNzZmxHnVs/uNVOHCz9go28j3UZ/kQ6QDFmu6fS
         HiHStTXv4ze7K6xb0RBB/Gsgn1LWEgSUpAmSUayeHW9D/+EZMkWXEIcMoOANUSyob9Ef
         m7kg3OW7xk8bnNCbFiKmnXLkcznxK7Ae8qSn3z9TIdBVM+XnzlZL84gcEpUwpnCuFKxI
         P8h4wdpayt8iN4jF3RTXC9xGNsRQxkXGVr6b7pF2CsSOUTWJ3tPFmbukOWGd/4PIpv8w
         oQZw==
X-Forwarded-Encrypted: i=1; AJvYcCUJvqDFG41BRae76ItMESfIMaj8xBavhO8yGFs/5DV6Ae8A/5n7vksvAAGdWR73uhat/8WKS40y7Ley3lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDne7m7Dbmw97I26Wf+ijFcEHatIfeBmRaNo6rV05DgtD3E+b4
	easkIFMqMoIgQL/8OzLBDurKPDs9ZL3DHPTKrMyyrfZRl7nqwGnDLZNTKkA1cL4=
X-Gm-Gg: ASbGncsAg2gdjIHpYJMlsqGB9pW7mHrmPPEKdB0fX8H7DsL6dzkjT/OsuYM2ZcBc138
	C7qZWZNVHuKgS+AfnB76LvRgU0LedAwYNXTNpUg1wqlLgillyF1FQQk4Pf/OF6jzH9LOV3LHzW1
	jDBEay/XHoerWeuy9Lco9mEsIj0ksYTdAh4ypwR9stFBFP9CiTMH2Vc4wcrQq5L/psr7Hd83qbI
	bkoGw7BERLpm86kDfhUxF5lnVh3mv0Ybi12f2thQNpxeGzJTbj2XtnYpz/eroscEgpe3SEi2CWq
	YvUalECBLreSV6oYeE/0dVGpxuCm
X-Google-Smtp-Source: AGHT+IGWN7LMDgKfbQIt8winmK79UQaYRMyPCFRcj2wUkH6XJiRNnCEc0FgdST1qCb93KqqidUdo8g==
X-Received: by 2002:a05:6a20:ad0c:b0:1ee:aa76:2321 with SMTP id adf61e73a8af0-1eef3c588bbmr4075137637.1.1740119639285;
        Thu, 20 Feb 2025 22:33:59 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add0e439774sm11618432a12.0.2025.02.20.22.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:33:58 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
Date: Fri, 21 Feb 2025 12:03:39 +0530
Message-Id: <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1740118863.git.viresh.kumar@linaro.org>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial bindings for the clk APIs. These provide the minimal
functionality needed for common use cases, making them straightforward
to introduce in the first iteration.

These will be used by Rust based cpufreq / OPP layers to begin with.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS        |   1 +
 rust/kernel/clk.rs | 104 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 3 files changed, 106 insertions(+)
 create mode 100644 rust/kernel/clk.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 726110d3c988..96e2574f41c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5779,6 +5779,7 @@ F:	include/linux/clk-pr*
 F:	include/linux/clk/
 F:	include/linux/of_clk.h
 F:	rust/helpers/clk.c
+F:	rust/kernel/clk.rs
 X:	drivers/clk/clkdev.c
 
 COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
new file mode 100644
index 000000000000..c212cd3167e1
--- /dev/null
+++ b/rust/kernel/clk.rs
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Clock abstractions.
+//!
+//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{from_err_ptr, to_result, Result},
+    prelude::*,
+};
+
+use core::ptr;
+
+/// A simple implementation of `struct clk` from the C code.
+#[repr(transparent)]
+pub struct Clk(*mut bindings::clk);
+
+impl Clk {
+    /// Creates `Clk` instance for a device and a connection id.
+    pub fn new(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id = if let Some(name) = name {
+            name.as_ptr() as *const _
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call `clk_get()`, on a device pointer earlier received from the C
+        // code.
+        Ok(Self(from_err_ptr(unsafe {
+            bindings::clk_get(dev.as_raw(), con_id)
+        })?))
+    }
+
+    /// Obtain the raw `struct clk *`.
+    pub fn as_raw(&self) -> *mut bindings::clk {
+        self.0
+    }
+
+    /// Clock enable.
+    pub fn enable(&self) -> Result<()> {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        to_result(unsafe { bindings::clk_enable(self.0) })
+    }
+
+    /// Clock disable.
+    pub fn disable(&self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        unsafe { bindings::clk_disable(self.0) };
+    }
+
+    /// Clock prepare.
+    pub fn prepare(&self) -> Result<()> {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        to_result(unsafe { bindings::clk_prepare(self.0) })
+    }
+
+    /// Clock unprepare.
+    pub fn unprepare(&self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        unsafe { bindings::clk_unprepare(self.0) };
+    }
+
+    /// Clock prepare enable.
+    pub fn prepare_enable(&self) -> Result<()> {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        to_result(unsafe { bindings::clk_prepare_enable(self.0) })
+    }
+
+    /// Clock disable unprepare.
+    pub fn disable_unprepare(&self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        unsafe { bindings::clk_disable_unprepare(self.0) };
+    }
+
+    /// Clock get rate.
+    pub fn rate(&self) -> usize {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        unsafe { bindings::clk_get_rate(self.0) }
+    }
+
+    /// Clock set rate.
+    pub fn set_rate(&self, rate: usize) -> Result<()> {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        to_result(unsafe { bindings::clk_set_rate(self.0, rate) })
+    }
+}
+
+impl Drop for Clk {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe { bindings::clk_put(self.0) };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911..324b86f127a0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+pub mod clk;
 pub mod cred;
 pub mod device;
 pub mod device_id;
-- 
2.31.1.272.g89b43f80a514


