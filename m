Return-Path: <linux-kernel+bounces-344256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54D998A785
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49698B24E59
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D1191F70;
	Mon, 30 Sep 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqY9mBaQ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ABF191F6A;
	Mon, 30 Sep 2024 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707442; cv=none; b=OYxrt5TwPmR/xns1zl9igJ9CV3Yzw5ioJ7eLUwNCSF6p9EtNfrttVwlpVGUspZmDJKVwjPJSE96aO0YKqX3JpZNEeaLQQfuRakBmg/TG8aC+Q9IscqafC6EFTX/7+s7A1pRBa80Ziom7JLq04QezXDkwivBGAMYdK2yx0zux26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707442; c=relaxed/simple;
	bh=/QLYFgpYpxV8dVvCdWVaX9SB/W2zEfe0klAPWcg6WVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJA+jx0h4MJgpQLWxYiWtaVWSJtv0opliM0ixIyD+H1CM2q54Id2mVwOj1W4n9ouhhbgCfGm+FWGoSOSOq8RhB4LCrVWlaverN/PWuCKCxGTjaXvOmATJ+yejdETeMzTDncnihZCslQkvv29uzUsgSGa7CQro6ljnMI6Btmt82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqY9mBaQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ba733b904so1500975ad.1;
        Mon, 30 Sep 2024 07:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727707439; x=1728312239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+zHgvx1zgHBYImWhaA0imn53+odTeInzAM4ju+3Aog=;
        b=TqY9mBaQai1nQbGz8Psac3Ipe6ueKyE1nSYJd80/vmWGyC7c6R8N3pldiRQflWjm+a
         13q4VwmmueWlD6SWncZPsLMv8XqaQBQcrVXOo3b8q7rwOPQdLxvo/qB0F2UHu7Fo4Iz6
         MWPLgM2CmM5U1ugSX9g4nqAw36uhycKyehGcc1dAafnqRmMRXQe7h/tPccHR7Nh+DuCX
         vlbB7oZsWcN1CrWEcst7o113pw65nYwq4fc8iSphLlYTkyFuKJsGy8uWDHRJrCigQDiN
         0ZKKwFdUioUB0rUhfC1Ixvw2LNj2WDNV6T2Dg+8qnlHT9Bj5B/xZqevRU5I/N0wKlAp0
         fxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707439; x=1728312239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+zHgvx1zgHBYImWhaA0imn53+odTeInzAM4ju+3Aog=;
        b=N82tHanuKV+Qx+vQaZQzfvyC+C6ASz8WrKzbm/yqufVP2uD/zoVHlyH+FsDEmvSFCK
         3X5z1GLjKDvqyBEWLi/EuOT4fjjPDQSDESyphVjW+1FfBBQrp2xLQLcqa8Ud6avXWoOL
         oyeONTO9Vzm0cZbJt4Yukyrt7un3bvMf5gGKEpzUbXHVPckoAJKwU2f9zxRs2bA+UZMk
         /NebvyPrhva+c3yjSixmk4Hju9i8lMoU9NZ0gi9axiTH+A8GY25QThnRJi/U4zo1Br6v
         aW7XMaz6n8WDAm2VCX248cPLumW92+adGK48kQR9pQNGaCSSa+q7ugm8w3N/4WDXXveM
         WjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2jgYPoU00sFCboW5cgJNwot0YDA7+JMEJAiEe1bQ8Rl1xoklZrDC6HETlhRSlp2bG4/ahUK/0Fm4VGEmsyEc=@vger.kernel.org, AJvYcCXD4eqMiUr3niDoukoFcG76n+ni+VohYWdEIaQwt0wTYs3nBTE7g90Dv37Kf1uq2qo/Wq4NMVrgB/+CSZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4Fh6ROEMeGQXOgBgrB5vMdx8SC1ranuyWoB4ct0RNfqk7Dqs
	sSdoz5ZazMQaZ5rnv+02LrzDwjCOBu99RqVPVnil2e3mbv3c38Sn
X-Google-Smtp-Source: AGHT+IH6xE1azJtpDAam9DTMl8HLwL00nFSR/PZDAm7lCGCHpeMfCFfPvsmhYCUMCDEzp9kF3YQIFQ==
X-Received: by 2002:a17:902:c405:b0:207:7eaa:d6bb with SMTP id d9443c01a7336-20b3776af5bmr178868275ad.29.1727707438756;
        Mon, 30 Sep 2024 07:43:58 -0700 (PDT)
Received: from localhost.localdomain ([187.120.154.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d61db9sm54882005ad.26.2024.09.30.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:43:58 -0700 (PDT)
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
Subject: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
Date: Mon, 30 Sep 2024 11:43:27 -0300
Message-ID: <20240930144328.51098-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930144328.51098-1-trintaeoitogc@gmail.com>
References: <20240930144328.51098-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function increments the refcount by a call to
"bindings::get_device(ptr)". This can be confused because, the function
Arch::from_raw() from standard library, don't increments the refcount.
Hence, rename "Device::from_raw()" to avoid confusion with other
"from_raw" semantics.

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


