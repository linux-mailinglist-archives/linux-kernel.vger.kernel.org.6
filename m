Return-Path: <linux-kernel+bounces-238997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD89A9254A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0611C25184
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB8139CE2;
	Wed,  3 Jul 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkFRXeya"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166313A40B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991856; cv=none; b=e5RZecoit8CaillOtiUrPgj10pdCIAv4DiSlIvaqQzQAl893iLrnGCbqUEMaVRDNOA7u/XWTbgjKtdKUu3gpmnUoiBoQSPSI66M0/rXzUkyWR40+21iTe9rdK1EZBU7Ras24D26OmgkB0K8IsUDk+1rgPa3vC9PmKi1yySSC3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991856; c=relaxed/simple;
	bh=8rKxfdhj2/cDz+NvbHcA+b60mFYU5yYmAW2A0FnPtFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J04t+2Xob9E5DctOflRyND3BrWaIh9Vq0v6qu8Wn5GOjhhT0DWkCGLXP45ltmeaUY8njXqOK/0tRr8iiCgxM5aAfMYUAiLsi/pWZGXPNxoNjjRuMxnbrcw5ElXoCJbi3Ijh+L+2Z1KAYu/6c2hyyDb5pTdrrkLcLsF8+97YdoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkFRXeya; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c8e422c40cso3031181a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719991854; x=1720596654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dnxB1ID3RzLihjx0TJWMC1pRyz4W9Zi6Ac1xEfORdw=;
        b=PkFRXeyaxmtputHHliJjqFOepVcyHcIOV6mvH0ZYdK/2LPDc6DtvXLR95vWDax1s3q
         seML9IGOP3d606tX8LJcW4ud7XAKUShepuESsgpoACJMTZbQynheMxoL25wAGKgGWOKt
         owDIkyQdR1/k/k/UHFtFJZpA1wej+f8JVnbIXYBvrp1ZlEdnKjPTXY8LsuPBe2LfHh9E
         E3qermC4CfBql6Nq++B/X4cbHrGVv030P7WjnbZkgj3E35If4vF8bsm6W294mof6Ca0I
         F3qMzWRqZTro3iA2C+1S1QHIkmRb4XFHRnGCnYnHO8tPbg4mN96cpCj006Oaf1O6Xyur
         rOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991854; x=1720596654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dnxB1ID3RzLihjx0TJWMC1pRyz4W9Zi6Ac1xEfORdw=;
        b=vWfA6GrvN7lzeWNsOPXzBboSlsy6CHO5oc0SMTMUuWfmZHkawJYW6nu6Fw3TV5q3b0
         mgBWVrzFuALbMsrQ43tr2y75dDVSQxtJh0x80bV7QOLLbaJddijhITKMBCm9XcFsyVRH
         fXG018U1kA5g76/w+gTWPenBsLV5JGoEmYEelakt2o4Ye1pqJ0PpdEkvJWCD/RFb15H3
         9R005U1OjdJp3erhg86Yv5uI72GgXFHBhjetOOiA2IvYBqrUc054sRuNOwfhxYpHlFct
         KL6aRYzO6edNLOyZLCWge9m2UAP5m+GPFsUW8nC7McyrHkSSSv2n0X9KxloU+D9E0GSg
         t/9w==
X-Forwarded-Encrypted: i=1; AJvYcCXCjHXJ8zNSZERLXCKsPodJInKEECkH/bCZ7wri1ubBCs6hmo9iX94odH/4PeMdYzJdSRbdOtxtbxsZRmGI7tKJaEWZy5wHRjZcmqZH
X-Gm-Message-State: AOJu0YyorJugd34efIZ1PWBGlykT40BLmFSpCzfijgNx59CU0eSj0dSe
	68qitiyqSaS+ov+pVDbi2StQvo+ZclwRC5l47nuqy/3EYfkFkDLL88MEh1IkSA0=
X-Google-Smtp-Source: AGHT+IFIOsjyEUEF/RZPTCJR4PG07s8g9pOwwqICGOCwBxXrz1H55FWE1J7LN7fCleAqT7oQXyQ+eg==
X-Received: by 2002:a17:90b:10b:b0:2c7:b164:3ce6 with SMTP id 98e67ed59e1d1-2c93d71f43amr6766963a91.28.1719991853845;
        Wed, 03 Jul 2024 00:30:53 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a77sm10088469a91.6.2024.07.03.00.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:30:53 -0700 (PDT)
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
Subject: [RFC PATCH V3 3/8] rust: Extend OPP bindings for the configuration options
Date: Wed,  3 Jul 2024 12:44:28 +0530
Message-Id: <6d2d8f98dbed555167b6134202ae2e6d121f7c78.1719990273.git.viresh.kumar@linaro.org>
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

This extends OPP bindings with the bindings for the OPP core
configuration options.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 301 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 299 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 4b31f99acc67..92c4ac6cb89c 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -10,11 +10,28 @@
     bindings,
     cpumask::Cpumask,
     device::Device,
-    error::{code::*, from_err_ptr, to_result, Error, Result},
+    error::{code::*, from_err_ptr, from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    prelude::*,
+    str::CString,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
-use core::ptr;
+use core::{ffi::c_char, marker::PhantomData, ptr};
+
+use macros::vtable;
+
+// Creates a null-terminated slice of pointers to Cstrings.
+fn to_c_str_array(names: &[CString]) -> Result<Vec<*const c_char>> {
+    // Allocated a null-terminated vector of pointers.
+    let mut list = Vec::with_capacity(names.len() + 1, GFP_KERNEL)?;
+
+    for name in names.iter() {
+        list.push(name.as_ptr() as _, GFP_KERNEL)?;
+    }
+
+    list.push(ptr::null(), GFP_KERNEL)?;
+    Ok(list)
+}
 
 /// Dynamically created Operating performance point (OPP).
 pub struct Token {
@@ -79,6 +96,286 @@ pub enum SearchType {
     Ceil,
 }
 
+/// Implement this trait to provide OPP Configuration callbacks.
+#[vtable]
+pub trait ConfigOps {
+    /// Called by the OPP core to configure OPP clks.
+    fn config_clks(_dev: &Device, _table: &Table, _opp: &OPP, _scaling_down: bool) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Called by the OPP core to configure OPP regulators.
+    fn config_regulators(
+        _dev: &Device,
+        _opp_old: &OPP,
+        _opp_new: &OPP,
+        _data: *mut *mut bindings::regulator,
+        _count: u32,
+    ) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// Config token returned by the C code.
+pub struct ConfigToken(i32);
+
+impl Drop for ConfigToken {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+        // to relinquish it now.
+        unsafe { bindings::dev_pm_opp_clear_config(self.0) };
+    }
+}
+
+/// Equivalent to `struct dev_pm_opp_config` in the C Code.
+#[derive(Default)]
+pub struct Config<T: ConfigOps> {
+    clk_names: Option<Vec<CString>>,
+    prop_name: Option<CString>,
+    regulator_names: Option<Vec<CString>>,
+    genpd_names: Option<Vec<CString>>,
+    supported_hw: Option<Vec<u32>>,
+    required_devs: Option<Vec<ARef<Device>>>,
+    _data: PhantomData<T>,
+}
+
+impl<T: ConfigOps> Config<T> {
+    /// Creates a new instance of [`Config`].
+    pub fn new() -> Self {
+        Self {
+            clk_names: None,
+            prop_name: None,
+            regulator_names: None,
+            genpd_names: None,
+            supported_hw: None,
+            required_devs: None,
+            _data: PhantomData,
+        }
+    }
+
+    /// Initializes clock names.
+    pub fn set_clk_names(mut self, names: Vec<CString>) -> Result<Self> {
+        // Already configured.
+        if self.clk_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.clk_names = Some(names);
+        Ok(self)
+    }
+
+    /// Initializes property name.
+    pub fn set_prop_name(mut self, name: CString) -> Result<Self> {
+        // Already configured.
+        if self.prop_name.is_some() {
+            return Err(EBUSY);
+        }
+
+        self.prop_name = Some(name);
+        Ok(self)
+    }
+
+    /// Initializes regulator names.
+    pub fn set_regulator_names(mut self, names: Vec<CString>) -> Result<Self> {
+        // Already configured.
+        if self.regulator_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.regulator_names = Some(names);
+
+        Ok(self)
+    }
+
+    /// Initializes genpd names.
+    pub fn set_genpd_names(mut self, names: Vec<CString>) -> Result<Self> {
+        // Already configured. Only one of genpd or required devs can be configured.
+        if self.genpd_names.is_some() || self.required_devs.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.genpd_names = Some(names);
+        Ok(self)
+    }
+
+    /// Initializes required devices.
+    pub fn set_required_devs(mut self, devs: Vec<ARef<Device>>) -> Result<Self> {
+        // Already configured. Only one of genpd or required devs can be configured.
+        if self.genpd_names.is_some() || self.required_devs.is_some() {
+            return Err(EBUSY);
+        }
+
+        if devs.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.required_devs = Some(devs);
+        Ok(self)
+    }
+
+    /// Initializes supported hardware.
+    pub fn set_supported_hw(mut self, hw: Vec<u32>) -> Result<Self> {
+        // Already configured.
+        if self.supported_hw.is_some() {
+            return Err(EBUSY);
+        }
+
+        if hw.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.supported_hw = Some(hw);
+        Ok(self)
+    }
+
+    /// Sets the configuration with the OPP core.
+    pub fn set(self, dev: &Device) -> Result<ConfigToken> {
+        let (_clk_list, clk_names) = match &self.clk_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let (_regulator_list, regulator_names) = match &self.regulator_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let (_genpd_list, genpd_names) = match &self.genpd_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let prop_name = match &self.prop_name {
+            Some(x) => x.as_char_ptr(),
+            None => ptr::null(),
+        };
+
+        let (supported_hw, supported_hw_count) = match &self.supported_hw {
+            Some(x) => (x.as_ptr(), x.len() as u32),
+            None => (ptr::null(), 0),
+        };
+
+        let (_required_devs_list, required_devs) = match &self.required_devs {
+            Some(x) => {
+                // Create a non-NULL-terminated vectorof pointers.
+                let mut list = Vec::with_capacity(x.len(), GFP_KERNEL)?;
+
+                for dev in x.iter() {
+                    list.push(dev.as_raw(), GFP_KERNEL)?;
+                }
+
+                let ptr = list.as_mut_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null_mut()),
+        };
+
+        let mut config = bindings::dev_pm_opp_config {
+            clk_names,
+            config_clks: if T::HAS_CONFIG_CLKS {
+                Some(Self::config_clks)
+            } else {
+                None
+            },
+            prop_name,
+            regulator_names,
+            config_regulators: if T::HAS_CONFIG_REGULATORS {
+                Some(Self::config_regulators)
+            } else {
+                None
+            },
+            genpd_names,
+            supported_hw,
+            supported_hw_count,
+
+            // Don't need to support virt_devs for now.
+            virt_devs: ptr::null_mut(),
+            required_devs,
+        };
+
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements. The OPP core guarantees to not use fields of `config`, after this call has
+        // returned and so we don't need to save a copy of them for future use
+        let ret = unsafe { bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ConfigToken(ret))
+        }
+    }
+
+    // Config's config_clks callback.
+    extern "C" fn config_clks(
+        dev: *mut bindings::device,
+        opp_table: *mut bindings::opp_table,
+        opp: *mut bindings::dev_pm_opp,
+        _data: *mut core::ffi::c_void,
+        scaling_down: bool,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::from_raw(dev) };
+            T::config_clks(
+                &dev,
+                // SAFETY: 'opp_table' is guaranteed by the C code to be valid.
+                &unsafe { Table::from_raw_table(opp_table, &dev) },
+                // SAFETY: 'opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(opp)? },
+                scaling_down,
+            )
+            .map(|_| 0)
+        })
+    }
+
+    // Config's config_regulators callback.
+    extern "C" fn config_regulators(
+        dev: *mut bindings::device,
+        old_opp: *mut bindings::dev_pm_opp,
+        new_opp: *mut bindings::dev_pm_opp,
+        regulators: *mut *mut bindings::regulator,
+        count: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::from_raw(dev) };
+            T::config_regulators(
+                &dev,
+                // SAFETY: 'old_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(old_opp)? },
+                // SAFETY: 'new_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_raw_opp(new_opp)? },
+                regulators,
+                count,
+            )
+            .map(|_| 0)
+        })
+    }
+}
+
 /// Operating performance point (OPP) table.
 ///
 /// # Invariants
-- 
2.31.1.272.g89b43f80a514


