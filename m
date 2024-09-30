Return-Path: <linux-kernel+bounces-344041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9F98A34E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A83A1C22B58
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4118E352;
	Mon, 30 Sep 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmY2oSdJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F8191461;
	Mon, 30 Sep 2024 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700026; cv=none; b=m0BVGewCTvsuS8pcMZgXN4dn5Agjpjv8sGeQDmiPs5zS3zdkxbcMKiesK5h9RZES1zURKwul7ZJK7gYXpGQdP6GaJkfS7VGIwvwkUzmycwnZbjPl2HlzRlwMqbD1GCuKeWSJNlG4eoPzU6fA7GEt+SBxJSp7g565EPkp+B3yjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700026; c=relaxed/simple;
	bh=egT/zzGSDwxwC3pb8/iGUtXhyYX5+DpK8xTUMiHEOJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBB5Nog/eCnknf2pEVWgHvym790pkVDqDUwFmxMDzS2J3gf9xqs7t4WtqvPoFgT0EnmAyNDoGTYKPeg7cechsdThgkkzTKAnvrWi0lz8CmvK5rM3Nu/oZhl2RkCfA8NohpD2IgVpgBAm9S98HAZ2omwIN2dKB0x3ahW1SyKK+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmY2oSdJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2068bee21d8so46433385ad.2;
        Mon, 30 Sep 2024 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727700024; x=1728304824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iqUbwajN8v0SNStG7Mg77uQzwcTNjVZJuIao9JmtF4=;
        b=mmY2oSdJRrPfaWzaAu6sCsNDNEzKnIP0KE51OlrC3BGdikoFxoxdLP01uOBvM2XfOG
         YaJ8wtwfTBxar9OlnhE51YJppubGUZtfuks9s+aUlML7tdiOoIJqZefaFTfodzrNU0lF
         xru6SwnGdWjNnJ5+CRh5ZA+SEVCl9OmEBKiufjQ2cN/j8ywYP/PXTqk06tU/DvSikEtU
         QhTfB6hxVOuvE2dQrsXx1SukDeHrdHheEzyZt/ImKos4Gf9TQRyHlkbIQjXLWqUq/c7u
         tuVfpqe6as2ZmnbJbc7ZoyhuW5B1L3CHXo5PlY+0tT+URGvsT3DCFzcOQRoPudONpVWU
         ujKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700024; x=1728304824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iqUbwajN8v0SNStG7Mg77uQzwcTNjVZJuIao9JmtF4=;
        b=Qc1wskALdHUsbvMpg9fgfZoOnYb26Fog3Qs/wzdsAj0d1sXoXxTpOK6Ty7uGbuKJH0
         kFO6EHTlbgMuK5C5S6vfR29sfi6iNwfxsyi7gwxEKKIg7HCQahZhI67Lddvq/AP9/w5e
         YdktbaDGIK522AzCnXBcy8owjWvM1pasSLiBnf7ewdfmOO98hjOptx02sFxSwV2YogDe
         k1ZnwQoqIAfvIxQZmUEF/RALK+ryZAfHoFe/R3qV5li/6fIafv7KDf8gwfBFL01oHkbi
         nKUGxJtWAQDu9wcLL77YvWVBbnQAvbLYwOnwNXfyyF0HnYGJy01fqlwzZAZ2JK/JPii9
         J2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUXlxH3RblSYC4AxEnWBaKAPSCWagWIIwA/oebrN33LapSHlIgJBdBYpM6sClx5dkcxf//8YpvU7FqHAf4=@vger.kernel.org, AJvYcCWrRIFdMWjFZ/aMKRoYq2DuhyLoWEL5ViqBKaCa6kJsGo2cEGCoATlRR8+8jflB7RCmjSclq361nNeivqJn/8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXt/UQEx522Km0VYuNeg4dEMYnsf2a75SYrKvbD0gWJAYOx8F/
	lK8PJcWNLd0Sm+xMnUitB511YuXhpivez9ASng6tc97m3bwNeUcf
X-Google-Smtp-Source: AGHT+IHl4n7FxOxIraZg3EBJBIRqh2m0BeIReQE61B9LDzbUHHgBoawAFOryicmRFf+nSf9DE8w9qA==
X-Received: by 2002:a17:902:c952:b0:20b:6a57:bf3a with SMTP id d9443c01a7336-20b6a57c137mr95093215ad.1.1727700024169;
        Mon, 30 Sep 2024 05:40:24 -0700 (PDT)
Received: from localhost.localdomain ([187.120.154.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e35ce7sm53377965ad.209.2024.09.30.05.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:40:23 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dakr@redhat.com,
	a.hindborg@kernel.org
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] device: rust: change the name function
Date: Mon, 30 Sep 2024 09:39:56 -0300
Message-ID: <20240930123957.49181-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123957.49181-1-trintaeoitogc@gmail.com>
References: <20240930123957.49181-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function increment the refcount by this command "bindings::get_device(prt)".
This can be confuse becuase, the function Arc::from_raw() from standard library, don't increment the refcount.
Then, this function "Device::from_raw()" will be renamed for don't make confusing in the future.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 rust/kernel/device.rs   | 2 +-
 rust/kernel/firmware.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 851018eef885..ecffaff041e0 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -51,7 +51,7 @@ impl Device {
     ///
     /// It must also be ensured that `bindings::device::release` can be called from any thread.
     /// While not officially documented, this should be the case for any `struct device`.
-    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
+    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
         // SAFETY: By the safety requirements, ptr is valid.
         // Initially increase the reference count by one to compensate for the final decrement once
         // this newly created `ARef<Device>` instance is dropped.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index dee5b4b18aec..13a374a5cdb7 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
-/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
+/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
 /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
 /// let blob = fw.data();
-- 
2.46.2


