Return-Path: <linux-kernel+bounces-267273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85483940F69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39463289F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E991A0B18;
	Tue, 30 Jul 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcuWV5+B"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2F1A0AFA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335269; cv=none; b=cLY3NLp79nZfsntDPsCFyzMoLaF1BWc+aPrHZoYyzIndyQEOabuxZ5kTq6LXqY3Da6hhNL6tDnwLw/fc49MJm9o2jZ1gtANbxBbSmkRvD8ZtKvWIBpK6Jr78xKTT8RNbm/Ey+8zZyo35sPFWaJEH0oO9vcKbQokhbadyuk/5FeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335269; c=relaxed/simple;
	bh=dO0CWc/xKDTHkuWPDNFu1TEYJonQR+X8T3Udl4DMBu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgSEUh/4sUMaK6ESVupaleAehmxI6WAoAeri/SFjNZEU7jmr8g8MN/bGOBdf748zuOO5NajbDyExJg2GIAnsM3mebkhq3ALmSKhIsqbGx8j/fVNgzAqZjj2/AHX8Xv+bE9cgmwGlaZmjWCa9grZqc8pWmCavMTpKlmMgiU/YUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcuWV5+B; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d357040dbso3354811b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722335268; x=1722940068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGcVVh6shkk/cP1y6RKWzcHFgRZvU/7gGba22DNsHXQ=;
        b=RcuWV5+BeoZYWqU4ujqXpdUswRDHWB/avZhFUl0N3VCoRhVb5iFyVdK+N6E3UtkwSx
         1118Cxr7lRRbISDh7Vj21Ps6fmLFI2fFdzzSN7JkM/iMC3uZiwiHU+gunBzMfUVb1K6b
         ysOe7ZTkl0BzrqNm45hSe2KKgfZK6RzKLgmFwXWM2+xEVv1uHrLWqlGiVCtSGV8vnlX9
         +AA4WodPynk7ATgVQjOeAyAbNKl6P1XV+tlXa04082iHCYtSDmIrJH4jK6kP6qnFHdCd
         nIm+ymsW3I80enl/P0TqAXt5UBq08amgq0HnSLvKKMeYBFG1wi8Bp/CUaUGdoTjUCCKN
         WC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335268; x=1722940068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGcVVh6shkk/cP1y6RKWzcHFgRZvU/7gGba22DNsHXQ=;
        b=g2iDMoDF2YD7Kl1GBsXkO9W6n1emr/2dFFb5jI9yK8kqa8jGwV2thdahQas1ifTMYL
         iuEubFTz01Dx1y2iM/7DNMHP4XsXKNcOf58lZQE/iCEY5ewD8UEbiJYupLNgQ+HwKJvJ
         CWArmeFsvzEm02vDTZ3FrDx/UqzRQRbkHUdG8l0CQWkQ1u/JKv8Z37m2SHHp/KQrbdPo
         bN3gMPo5zt/8jDGyB4sDxo+dGxuDayI3cQ+iFhckKOGkppLgsWpkikZ1Ii/grsHk8nYC
         2gYoa+jLh9J+FJJAnkmGY8jqKTeYjwS9ePz3mzKxX4PMRG2G02+ix0nzbgSmip/FsAtY
         EnRw==
X-Forwarded-Encrypted: i=1; AJvYcCWZB6rmTQ6fh7mwajHbBB+CIQPQMEarG4NYtKeDMWqr1GAaZf2JxFFX2b8e25Gk9opCyBQQc/eUjMpIabOMUJeIV1o1pi/nO0a5vrhy
X-Gm-Message-State: AOJu0YwhfdP9VlHKOO4OWg0SokyRyBfaRJ0HkpcMAAXwO2aLHrbQPi2s
	JeQHDHN1xskLeU4a/ux0M2Ot+DQlsTca/QRO64TBYD7FWck7V7+hYkzyQ3w4So0=
X-Google-Smtp-Source: AGHT+IGh5k77jhw4qnCpk6Wyl01TvyBbrQE0VQxUroorUPZ3Pe+onjAYfUxT64noXwHfpihD+swzFQ==
X-Received: by 2002:a05:6a20:a11a:b0:1c4:8da5:219a with SMTP id adf61e73a8af0-1c4a1299d97mr10019110637.8.1722335267630;
        Tue, 30 Jul 2024 03:27:47 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ba2csm8424835b3a.93.2024.07.30.03.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:27:47 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 7/8] rust: Extend OPP bindings with CPU frequency table
Date: Tue, 30 Jul 2024 15:57:04 +0530
Message-Id: <fd25b21e35c6bf3c51e070159fc6d0f1468b9438.1722334569.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1722334569.git.viresh.kumar@linaro.org>
References: <cover.1722334569.git.viresh.kumar@linaro.org>
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
index 113652448056..7317a5e922cc 100644
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
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw()) };
+    }
+}
+
 /// Operating performance point (OPP) table.
 ///
 /// Wraps the kernel's `struct opp_table`.
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


