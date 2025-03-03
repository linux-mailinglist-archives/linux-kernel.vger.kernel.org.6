Return-Path: <linux-kernel+bounces-544831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16519A4E597
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DA165784
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C442836AD;
	Tue,  4 Mar 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urmRmFxZ"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F427C844
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103776; cv=fail; b=a9+2A+8bMupfPhg/3Nfv7iSgPvpzf0GcPfxAMylMt4h00EnS86kLsM99l9TJFYonFvslrYeC7SbFtpuQgJ/MsY5hZl8vtFaTKxG9iN/Vwrs4iYoyPSBqf7LcZLrjx9Eaz9oWFmEXlLTuDsgHL7kjTeeVf565uYfVhYz2/07ipSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103776; c=relaxed/simple;
	bh=0xtVuIRMcJ9mrqBKv9b2M3AjxOMkL6ET0xlLfjPOm+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSCk+h7YpbemkeqVhrIPY8uk40zVgzHcmIwZRyp72onxRDYQ+SeoMa2fifZy0OZf/xtgYgNJ3bEUAXXgoyJQPQ7vV8Z3XZAU5WQ6rTiwGJqz1lzf6cWTAKwKnpj1D/NlZtNV0akCeDOvnmcxksGPQIh2778spNauOLtzFxTJsq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=urmRmFxZ reason="signature verification failed"; arc=none smtp.client-ip=209.85.216.45; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 2BD6040CEC91
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:56:13 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gGb71SfzG1jB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:54:15 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 839D341898; Tue,  4 Mar 2025 18:54:10 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=urmRmFxZ
X-Envelope-From: <linux-kernel+bounces-541328-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=urmRmFxZ
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 9E39143449
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:01:43 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 30AE72DCEC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:01:43 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FCF3AA753
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFF51F1513;
	Mon,  3 Mar 2025 10:00:35 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBF1F2C3B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996031; cv=none; b=QQNepQ09rL3wIsuvZnqlTLCJdbHY9MakUYYFvyfMCj5OHSr5KcrVmgACirzp0acLjzZbi7OUGJ6GQMPdWoTtXiiXqPmxUVsNIesEhHBOsJ+Uxsf32cjnHzJAg19FSsgPKnoV03W5omOS7JYwsrS+SPAR7U57z/TSViRMDK3IRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996031; c=relaxed/simple;
	bh=4ePiwYSbOCYH3v1SviQDg3/HbMk9bKn0Y0srxW3uClM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwwkvbyc405K1zOu+XcR3d2kczPqCred/y0iopMWXlfONvR/QCXJs8PJ0lsAfX6eRO1tlZUmZY7ve7M1YP/VAj3uXi2o8bPldV7xyzsYKUoEN+DCcl0+TZjlsBwyxx/iCncjlCIIkqd9EU5N470pJcsZgALxrGrrc0TBHnWuuPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=urmRmFxZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so4269747a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740996029; x=1741600829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCtpbarqcsWFDUrFSqXD3/5LnWihrLhv2toR5uStrCc=;
        b=urmRmFxZYbF12HuDunEnhJfhZde8ejtb3l2vNYsoImsuixO7ZPmrI1WIHeGJcVt3dl
         2aYzQV8gOoq1KBxJKuAycUErUqsx1z5elD+4QJX7LWOcb7dHSSFtFBHwziB1ZcQJSgog
         rp0F8t6Fle2x+FYztrnLRWowhSNMryZ9S5MfPJ800H/DmN/iBXwPQoMVMu5K7kcmdO94
         dDbn5Qva8xzi7NZ/fOz73GA2s2jaQrqiz8rl/vps9mkbiLbpzHOFHeoyFXswtlTcP2ZE
         8ABhtvCWlX0dLLdgiBg10kcpaahpaw03aG97Ogq9r0PIYl4hjKXTKTk4qtYKuT3GwLoZ
         liRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996029; x=1741600829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCtpbarqcsWFDUrFSqXD3/5LnWihrLhv2toR5uStrCc=;
        b=Gf0Pz0drz2U/RzFmwDDlDyptQMIOinQ3k30Oxi+0dUhcl57PntM7cLN7RYrjFvlP23
         r5JQ+Lr6eD4wMqbbOKwWqKl/w7dvzYkDjvIU45Uca6rzHB4Fo6Lo+cBO70s68Z6eqUpC
         14y324pOqThUqWio6QvAhBkCPq1RRkr7wZiYYZKZDMCdSk8AYJIUr868KcfWOjDEuaqZ
         fL81F2NwvFjsISG29Oj04Ng3uJOFkjwInO4XV2yHYO+2sohYKRphWXKckJW2hF5cvtYI
         Il6vr6jTmgTiHtUlAYPz5ynut/bWGdA3utkCD9XSTFueHa2UAxlhyIOkq4IGvErSJDAh
         qDMw==
X-Forwarded-Encrypted: i=1; AJvYcCUoKah/vwEpeUb9pdp6MAHsa8B8w5Bp5hIvI0ZnGnCnqR96VZbvIHVyDLMZN8G8+iYmOvrKTtz+YvIfxKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4NhOERgOWnPO9Av/kljzfVF7EVnw/+1L8O3EZi0jJC91J68QG
	CzQ88gKmQr1zsbLVlE53annGLHTw+afR0f9H+ha59FmIODkuce8yuM1rEZ9Y76Y=
X-Gm-Gg: ASbGnctPBmBZ8HZJ7au7IvQR10OA4WxeXdn01x6+BfgJzL2nomRAmlEp+16LvhEnJkG
	NNEmVb5vfkML+UpZa7L/YSZsDKicwp4xBkcw2PjyQCYboNM9JpUQo49ewqWXUQzKsfr5G9Ypdv4
	5285aY74jOxe7cyEeT1N/nzzp3tPPnP3f+w5F0WTISw0kA3jYmAql+MvKpD0WD0JTHKhyb89Q+e
	qVDfmnwZOvPx71VlysN4Ih3oLGWXGjwphsMMw7fBi6fZCLjBrrR5g1pJpkNE0uy6PHZZaebSAsp
	XRUk5fXuUSpiGsCe1BONgSNxzjnxmdeUBjS1m2Dc54grYA==
X-Google-Smtp-Source: AGHT+IFU5ll4u6S7m0NrVB1a+FHvXW54L7A2aqExOXgrVGjy78eyLcfNYLvSU8KeXTNKCT43lKxykw==
X-Received: by 2002:a17:90b:528b:b0:2fe:a336:fe65 with SMTP id 98e67ed59e1d1-2febab3c6f0mr20234955a91.10.1740996029494;
        Mon, 03 Mar 2025 02:00:29 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6ded6ebfsm13571496a91.1.2025.03.03.02.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:00:28 -0800 (PST)
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
	rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH V3 2/2] rust: Add initial clk abstractions
Date: Mon,  3 Mar 2025 15:28:10 +0530
Message-Id: <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1740995194.git.viresh.kumar@linaro.org>
References: <cover.1740995194.git.viresh.kumar@linaro.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gGb71SfzG1jB
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708479.47731@fZxd9GqcFP1LGarn7cfU3Q
X-ITU-MailScanner-SpamCheck: not spam

Add initial abstractions for the clk APIs. These provide the minimal
functionality needed for common use cases, making them straightforward
to introduce in the first iteration.

These will be used by Rust based cpufreq / OPP layers to begin with.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS        |   1 +
 rust/kernel/clk.rs | 134 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 3 files changed, 136 insertions(+)
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
=20
 COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
new file mode 100644
index 000000000000..1fa5b7298373
--- /dev/null
+++ b/rust/kernel/clk.rs
@@ -0,0 +1,134 @@
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
+use core::{ops::Deref, ptr};
+
+/// Frequency unit.
+pub type Hertz =3D crate::ffi::c_ulong;
+
+/// A simple implementation of `struct clk` from the C code.
+#[repr(transparent)]
+pub struct Clk(*mut bindings::clk);
+
+impl Clk {
+    /// Gets clock corresponding to a device and a connection id and ret=
urns `Clk`.
+    pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id =3D if let Some(name) =3D name {
+            name.as_ptr() as *const _
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call `clk_get()` for a valid device poi=
nter.
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
+        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
+        // by `clk_get()`.
+        to_result(unsafe { bindings::clk_enable(self.as_raw()) })
+    }
+
+    /// Clock disable.
+    pub fn disable(&self) {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
+        // by `clk_get()`.
+        unsafe { bindings::clk_disable(self.as_raw()) };
+    }
+
+    /// Clock prepare.
+    pub fn prepare(&self) -> Result<()> {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
+        // by `clk_get()`.
+        to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
+    }
+
+    /// Clock unprepare.
+    pub fn unprepare(&self) {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
+        // by `clk_get()`.
+        unsafe { bindings::clk_unprepare(self.as_raw()) };
+    }
+
+    /// Clock prepare enable.
+    pub fn prepare_enable(&self) -> Result<()> {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
+        // by `clk_get()`.
+        to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) }=
)
+    }
+
+    /// Clock disable unprepare.
+    pub fn disable_unprepare(&self) {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
+        // by `clk_get()`.
+        unsafe { bindings::clk_disable_unprepare(self.as_raw()) };
+    }
+
+    /// Clock get rate.
+    pub fn rate(&self) -> Hertz {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
+        // by `clk_get()`.
+        unsafe { bindings::clk_get_rate(self.as_raw()) }
+    }
+
+    /// Clock set rate.
+    pub fn set_rate(&self, rate: Hertz) -> Result<()> {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
+        // by `clk_get()`.
+        to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate) }=
)
+    }
+}
+
+impl Drop for Clk {
+    fn drop(&mut self) {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
+        // by `clk_get()`.
+        unsafe { bindings::clk_put(self.as_raw()) };
+    }
+}
+
+/// A simple implementation of optional `Clk`.
+pub struct OptionalClk(Clk);
+
+impl OptionalClk {
+    /// Gets optional clock corresponding to a device and a connection i=
d and returns `Clk`.
+    pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id =3D if let Some(name) =3D name {
+            name.as_ptr() as *const _
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call `clk_get_optional()` for a valid d=
evice pointer.
+        Ok(Self(Clk(from_err_ptr(unsafe {
+            bindings::clk_get_optional(dev.as_raw(), con_id)
+        })?)))
+    }
+}
+
+// Make `OptionalClk` behave like `Clk`.
+impl Deref for OptionalClk {
+    type Target =3D Clk;
+
+    fn deref(&self) -> &Clk {
+        &self.0
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
--=20
2.31.1.272.g89b43f80a514



