Return-Path: <linux-kernel+bounces-239001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9BF9254B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A75B254C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A713D628;
	Wed,  3 Jul 2024 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4ZU1lDX"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E90913D600
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991871; cv=none; b=tI4V5rNSowV6vncSULFzkh50kRbuEMcjcOQNlFM5kAgxUZbIsI70nW38FvZ39L5A79rf1uHymW4Q01FazFPFuc7ewoGOyr++E7YTa6CSb9CxnJV9lgp7cj2+IHf83AuwlByd6htz8pBEIZkhunUhhMB8qE2X/hu8ys7cUlDtACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991871; c=relaxed/simple;
	bh=ONhmdqsWZDFLFh6FZ0fs7s5ZNKCwSTqTca5vpftOr4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6P9xk1V+g5lWySvHb7ybPUYT01jms8qn3I6EEFW+mUGPI6d6jbyTxrdHkalYHRcIwo05StpQhH5Y2ArozA79Ca6DV6I0bCQUq18VM/VW1Hee8f/VOg51P4XnIuPwO/Njwy/dwJ7J9oPMcx7mjoT/cBkT6EnOypXtJLSh/+3cZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W4ZU1lDX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c97ff39453so91168a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719991869; x=1720596669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGmDSlgxeRxM9Y7lSVn8pZpU6fzV4VP8wkEHpyGM1hk=;
        b=W4ZU1lDXSzZmSt5bWEcJBTm9pjPTJmcoberXVHYQWus63osTQh+1ACwR+iKRJm4wR9
         vRz+Mns34CkXtbrGc7hOZLOOP1MlmNpmtrvOO4fI7i1sdryoP+gyOiqOx4ZokAZ1MYet
         PDMUF6vynMBrdUfmLwXDrhDxOQb9E5YikYuxUTwkBKl+rxbpyg+cf8X39opxzUbWUfQ7
         6D8iiQVfIXhHrBeLYKk3OZ5t6fyxLao9IHYyIkBc+VsIwCSnnubJ5nhcN7KzqXz4hrQl
         yxKzFOMXECxQSF3dYPgP+yNUeBGByKsNI8Oa7p+XLq9zTjxU+PhVow2/D1eREkyKfQL5
         CqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991869; x=1720596669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGmDSlgxeRxM9Y7lSVn8pZpU6fzV4VP8wkEHpyGM1hk=;
        b=Q+xZMQoJAR0qkKlezb5ZUtYGephfctj46qDFffv8YpO/eP2H2Alq9BKDY9tT1S6W4G
         D+tZNXBwWDCSZklabJFnDLWUbzP834NgZ5YiMMz/S/GKq5Rpzbcjyx0S6wsGlsg44sWz
         CBScO787DAmQOcKK+9pQMFyQ+Z0S7CfGvjIKWKB+ktINgnDkVnfHtR4kxWZCSzoPqGmo
         yl3ZcMJLdx8wRYjgbYvHgEgThHQLr57+rOeSJFI14B2qe1llhM4D0OqaqJ0fVC93GQKr
         sgcf9Kzml8zx/398ozkIe4qv92+EXCrEH6lm3/UxIpUtJISNsOF3hq/a5lrizrGYg0DU
         zBkA==
X-Forwarded-Encrypted: i=1; AJvYcCW7XzfvEKixcBP0ts2pjkdkLQkUNanny5FMVl/DPnIrn7WPlm6kudqb6Q4b/9Odbl5ooY88UtYTwyCYPUwPz5j/H3Tjh3UidFDGSLpj
X-Gm-Message-State: AOJu0YymiA8sLHOsM5F8YsMYTAa3LE3/NHludoe+jjztmdrL/jnvoL+s
	klSo/XG7ct/hBxgx6W9GAYiTR3Co1oGPBUBZ3b2tD69pFDeMrxEeprc4NajYl0g=
X-Google-Smtp-Source: AGHT+IENXtyKbNnA1xRpxIfAeNA//qOjOvY7fcGsntZd4ck71ZV+1hEVvl03kBc6zmacmCk2AFG8yw==
X-Received: by 2002:a17:90b:a48:b0:2c8:bf72:5389 with SMTP id 98e67ed59e1d1-2c93d6f1508mr9665435a91.9.1719991868718;
        Wed, 03 Jul 2024 00:31:08 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e7d7bsm10045396a91.47.2024.07.03.00.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:31:08 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 7/8] rust: Extend OPP bindings with CPU frequency table
Date: Wed,  3 Jul 2024 12:44:32 +0530
Message-Id: <e7f85eb87c45633d7b5da3aa340dc44d37fb8ee2.1719990273.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1719990273.git.viresh.kumar@linaro.org>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds bindings for CPUFreq core related API.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 61 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 92c4ac6cb89c..bc16b8c407fb 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,7 +16,10 @@
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
-use core::{ffi::c_char, marker::PhantomData, ptr};
+#[cfg(CONFIG_CPU_FREQ)]
+use crate::cpufreq;
+
+use core::{ffi::c_char, marker::PhantomData, ops::Deref, ptr};
 
 use macros::vtable;
 
@@ -376,6 +379,56 @@ extern "C" fn config_regulators(
     }
 }
 
+/// CPU Frequency table created from OPP entries.
+#[cfg(CONFIG_CPU_FREQ)]
+pub struct FreqTable {
+    dev: ARef<Device>,
+    table: cpufreq::Table,
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl FreqTable {
+    /// Creates new instance of [`FreqTable`] from raw pointer.
+    fn new(table: &Table) -> Result<Self> {
+        let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
+
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
+        })?;
+        Ok(Self {
+            dev: table.dev.clone(),
+            // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+            table: unsafe { cpufreq::Table::from_raw(ptr) },
+        })
+    }
+
+    /// Returns reference to the underlying [`cpufreq::Table`].
+    pub fn table(&self) -> &cpufreq::Table {
+        &self.table
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Deref for FreqTable {
+    type Target = cpufreq::Table;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        &self.table
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Drop for FreqTable {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw()) };
+    }
+}
+
 /// Operating performance point (OPP) table.
 ///
 /// # Invariants
@@ -580,6 +633,12 @@ pub fn adjust_voltage(
         })
     }
 
+    /// Create cpufreq table from OPP table.
+    #[cfg(CONFIG_CPU_FREQ)]
+    pub fn to_cpufreq_table(&mut self) -> Result<FreqTable> {
+        FreqTable::new(self)
+    }
+
     /// Sets a matching OPP based on frequency.
     pub fn set_rate(&self, freq: u64) -> Result<()> {
         // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
-- 
2.31.1.272.g89b43f80a514


