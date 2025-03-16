Return-Path: <linux-kernel+bounces-562888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FC7A6343B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF2A3B3199
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37CB18DF6B;
	Sun, 16 Mar 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="FcJSRUaf"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9D18DB18
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106036; cv=none; b=Or15tGISgmyg7ANkebUQ4UHzfIsLOQ26BEZsEdtGyM9aVH/Ysq6OThtQcE8gfiIkepFKbICsFKAIV/mywJckX02WYsCcDXAYb2byIivIgVylrNZ57wG/qj/vJmfl/rEjQrqFtXMzy+gx/BMrDMZ2F6YFGPF7R/RLIOitbjy6WKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106036; c=relaxed/simple;
	bh=AOfQe8i4EZBpyQu5tG1C/TpZCMWdiMFt8bzjtPdEu7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gR8RwaYiLkgVD3VDKzyPUTslWWRYGwzzAZkNzlmyHYSdhKJ5sdzZHU+fNZoxgyheNXE+HeQOVJ+iOhRLYpCuIk7ouOEB+wnwhzPooqJylbFYWkXerPcpGB8pZzVqOmWoeGSVOsKZiJab5DVO2FbDQ4tiDDEfvupxXJkj5vzebuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=FcJSRUaf; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so3205393276.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106033; x=1742710833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRx4xBTrB/yyQngCERc/V3g4ftfl32p6gXpKrtZEZAE=;
        b=FcJSRUafhUFPaq/1eJ84AmXUBBDMq/6pwcujIov99pvQ/cDOmzRjp/XyJvWbL0ioT4
         cvr7DAmZBLBebbbDzzZsTK5+WuoVhp5nWgNhK7sJDMdIoUkmUY6VmQouY1O26DgEV0wh
         j6cQpK5V0gHPhDezo4yFsnWOZX/1tf025JZNgWIJnHlqF+LWv7ESTimkmH8snGSX9gnK
         gRe46G7TJhyJuYHvdRXcdiRZpqSO+J9MSYLf8SgxleSG/hAHztK+naudsvbAEZFri8o5
         M0D8vZ2632w0lO8U69F4USyV8TMQJ/PKawEJzkia3d8BMfs3eIbaB4IOX8mNpWQ7vBy3
         kbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106033; x=1742710833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRx4xBTrB/yyQngCERc/V3g4ftfl32p6gXpKrtZEZAE=;
        b=O45pgSgB6HVoiufg3LOsxrJMWQaxrads+J0TXBUvcbA+e8LfY3kNvpU4+7HShlkRUW
         m43zaxUjdti0SG8H/4wGDatBBWTZmP9pLj0MDb/YHRnH1YIPvajvLVJt48q3b1Zmfi7L
         s0ADDm7ggCaKNwG/4eMYrognBFTI1BRUaVkxdjxpE5K43bDCS9lmidz9xgCFS9WLAVbh
         Qv2HjlHSGEOlxAirYpI4gBw3jzJZQJ114bnIctjgM9IUVyT/dqeNH8VLwS2/V8ojdqeN
         Jrfd+ZGdDDd7YcOeJmkZaobmRkgLRyy+WINpRfEOcNVZRqywmyclU+eFaFz/xfQ/tXYa
         QUQw==
X-Forwarded-Encrypted: i=1; AJvYcCVqqUkYdVavA855fXCSmNCwPtBMR8e8WYK8kgYIZZgYVHCAKZo2FAEO7Syq+hmCD/MfwgXf7KbZD2DkLcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnDgkpcCEyc4MKxVreLSq7sa98GryqvV0mkG0PZ9PjbE8BG8F
	q+iK8SWtjqonzRdiQb4TJZB93+MS/ae0wzPJvssZgDPQlkeY9SILYc7n5g3I98g=
X-Gm-Gg: ASbGncvtO8tEijAf50JJbYXrzPlEWfnZq0Cfh1zAmBfwfG7zBojKhAlVL+QKM1506ZN
	VOjnP0IWgmqyyCUuoXJdE+KPyf9ItglC2rWi77OCLsxNXIr3FGMr0Unr9L3cujId9TCZutKHVbW
	GrIyzfOh+DFUm6wNVTpCcFT/pAE0bJmW96c7pIqd9Oh2w6rc3nWF3bnA+0gLoXy38JLT5EJEg7m
	+yz8cAVrSqDfstSkfhxwSei/39azXMD1STl68wXMIaKevl7i3Sl1ns5RU27/0tt7JCNs0bytvGo
	6ecpiJSTgNJaEbenyAJHVMd9jCqxEohtoBcRtUgFKtRMIB9GQ3eynVKDb3vO3x0MXIiM2Ac6tlV
	q7+nS8GrC3s7d9PXdz4gU3sJ4HxDmCsLO6GqKv3so
X-Google-Smtp-Source: AGHT+IGHODraP71cA0hWE9ecyV4Z+yF1rpkj3C/Ko/E/C+zVlNjjG+LzHjjw2vkdRuphFhU9CDeGow==
X-Received: by 2002:a05:6902:1ac9:b0:e5e:1062:bcd2 with SMTP id 3f1490d57ef6-e63f64dcc09mr11090915276.10.1742106033471;
        Sat, 15 Mar 2025 23:20:33 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:33 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/16] rust: faux: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:14 -0400
Message-ID: <20250316061429.817126-6-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/faux.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 5acc0c02d451..11e56fcbb6ed 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -7,7 +7,7 @@
 //! C header: [`include/linux/device/faux.h`]
 
 use crate::{bindings, device, error::code::*, prelude::*};
-use core::ptr::{addr_of_mut, null, null_mut, NonNull};
+use core::ptr::{null, null_mut, NonNull};
 
 /// The registration of a faux device.
 ///
@@ -45,7 +45,7 @@ impl AsRef<device::Device> for Registration {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: The underlying `device` in `faux_device` is guaranteed by the C API to be
         // a valid initialized `device`.
-        unsafe { device::Device::as_ref(addr_of_mut!((*self.as_raw()).dev)) }
+        unsafe { device::Device::as_ref(&raw mut (*self.as_raw()).dev) }
     }
 }
 
-- 
2.48.1


