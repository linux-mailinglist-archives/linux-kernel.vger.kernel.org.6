Return-Path: <linux-kernel+bounces-205698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B818FFF07
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9570B24652
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4201515EFC0;
	Fri,  7 Jun 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UijrZEoU"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2615B97E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751586; cv=none; b=r7XyBDFkncMfxNdJjAyELIRv7tK5awAa9vyG8sjpAOuIWkwlBZjDQdzWSW4EOgWRnzxcqBEr90od6uG0W/ukgNkwggEEg08ZgawNbEXZAqW9dRIVTOp+d7xeoJTDB2ZshyXLB6w+tKz7ZAO552j2x6ykO989/e+irZP9o4yQIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751586; c=relaxed/simple;
	bh=Y+dnDpoPgLDQbxi2D26tM1HhdBJGHB5DyqDp5BgM3qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kcre10F9v8UkiAL0vrR1kavM1bCyD393YKDp18E9egVhZKEgkbVAC6u/3IzLf3ZTC1GLaehM4wC4GxhNM0fwb1nzjMV/ziROtH+ByudYWgNNy+NO9fdq8B3sdkMvGpNha+0phV2ykaW9VfbMKbL7RK1geuoSUv01+viQuyboN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UijrZEoU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70249faa853so1589968b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751583; x=1718356383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCjoSclVWZT0iDBq8VFLkZOWwHf6tFEcHjugFV93b9U=;
        b=UijrZEoU5H2jKL+3r85xZOL8CZZlKZ3iHSAjm3NlzVBPUD6ODH0IVGld654yG/jER9
         4a5GV7BB8q7s3UIoG0VEr+2M38kb8GM/7b4nC16r3tKdQJ+1VJ5yRoYgxfOY5VbIdkan
         85RIERByXSas46utrRwy8zmPTqCSV5cwV7RAFYGbEBG3LarzmI3tdL4H5fxPWFQHubPc
         jJMEk4Tlfz1hVKjQ5WJNSlN+xg5m7YPQRTtzcPByC1cmyeS/3alKBa5RXQ21oW8b3Ofz
         oqzqBTjayUf6EQCG6nSHi/7YfiYotyOaEUv3KEY55r679jvpFpsDhQ+uM50yXMaK7uLW
         8wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751583; x=1718356383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCjoSclVWZT0iDBq8VFLkZOWwHf6tFEcHjugFV93b9U=;
        b=fv7GmXAnSoPXJQgS27pPU5+TDzA1E4IWYzQIrHeVEKW7Cl4VYk/jQ8fcu0Fr6kojxz
         mctdDZ+egVR477lK0csHgNPLajyVofDbbI/Uip24YvDp5xzjSBBxIbRokrXobKskHgV9
         /dHgq6FKlmPUFSYDhUoPEMTTZN2T1i0Jz3xbFMDbg2F9I2Rm9eygR/190emHFg91Vbo7
         F0m11QmuocGPgqZVkBk1/o046gIXpTL21RzG0TP86dHtdLFh2V3MrSqJ/NM9mV3eJfKn
         DXG4c2EC8tFaLiwyrD+vpzbXgLmYDrHNmZv/33eJOVqTTVf5Y7d/B6Zw/XgrYmYKUBWx
         +Q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVENLndL004r2kMi8Kyp40cOdBk/uJtK4THUHC4TrmH26lTgPcak+Lr5nvaIa4JuOm5vmd+sqP8QLjN7nD6bCD4td7GQ3tIT18hGjvD
X-Gm-Message-State: AOJu0YygMBbUWu4Q81Xqa7n20nRHqAcK4eLQovlUuePZ+ig84A5Rylae
	Z6+OHGp+DC5GvYlWX7BlztF69IC6IIWvi9WymdihJ3Mo9MiDFO2yr80GjePqld0=
X-Google-Smtp-Source: AGHT+IEynFUinI3X2Ts6k+rw9ZruxT15CQaIWnniA8Pyq/ymZo56xbDZgdazaXXsdaS1AQtNJabJEw==
X-Received: by 2002:a05:6a21:19a:b0:1b4:4370:60f with SMTP id adf61e73a8af0-1b443700773mr422429637.1.1717751582668;
        Fri, 07 Jun 2024 02:13:02 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7d89a0sm29256535ad.128.2024.06.07.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:13:02 -0700 (PDT)
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
Subject: [RFC PATCH V2 7/8] rust: Extend OPP bindings with CPU frequency table
Date: Fri,  7 Jun 2024 14:42:22 +0530
Message-Id: <6e703e990bd1ce864927060c53025506568fd0b8.1717750631.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1717750631.git.viresh.kumar@linaro.org>
References: <cover.1717750631.git.viresh.kumar@linaro.org>
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
index ebcb77b52558..4833848f79b1 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -15,7 +15,10 @@
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
-use core::{ffi::c_char, marker::PhantomData, ptr};
+#[cfg(CONFIG_CPU_FREQ)]
+use crate::cpufreq;
+
+use core::{ffi::c_char, marker::PhantomData, ops::Deref, ptr};
 
 use macros::vtable;
 
@@ -343,6 +346,56 @@ extern "C" fn config_regulators(
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
+        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_ptr()) };
+    }
+}
+
 /// Operating performance point (OPP) table.
 ///
 /// # Invariants
@@ -538,6 +591,12 @@ pub fn adjust_voltage(
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


