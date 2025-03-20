Return-Path: <linux-kernel+bounces-569058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55804A69E13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DF819C3213
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FED1C5D77;
	Thu, 20 Mar 2025 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="LWs67NfU"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C01C07F6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436522; cv=none; b=H9izkYpfRxKZ/yPQLO5q5h/ljFafoIBLQOWcl8ZjaiCHiiajXKyC4VyXRV/vgA4iSlBMmXBiHQQxiNpEa5yBLBLhvCfDVqI5EYReRTasEd2C5lwf3281EZU8L1EdinNj2IAMYp+Bs2TTVmw6doVmRyzG5oG5MnKfXi9ksr6rWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436522; c=relaxed/simple;
	bh=55V2j/OQPKYJTWiV+U25GDW5Iw0leNvV8HMgmBJ2+HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTueRFwEtFdggpfLVeYcRIBmqkBFZpHMm2CbM645xVhSUV/NHJiGAkk7i4vfFzzMNtG/a5rj9u1IMBli9tKCaDhmYg/d8KeqGC6VLFHjZI/9v4CPd3YbYIGSqj0GKQb602Tg1Sf9r5KN37t6vhYWUh5zmPT21hNW+PcPCT2lbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=LWs67NfU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ef7c9e9592so2501547b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436520; x=1743041320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYdjsu9Z7/7WUWaSQUOHiYBv7brhy95VtaLf8YZSIL0=;
        b=LWs67NfUHEd94PBe46MENCciIUYHpghRNAKijCxV8DIT5YRXi6RIQE2LP5wEason55
         BReZNWhj5clCRi+rm4Z3vvgmQVWHi5wNVupYbxOc93f1/Pv5Qr6dqNmuVQmhFRxX5HhX
         oKSO3xP2CJ7Rt33MWF6Qlry0hjSUk8G3FLHc75t4TGEWLpGGESaPMtS2gvfVTRZT9pqy
         OdVYLsL6SS82oQ5rnO7sWXOdpWWEWgxfVrpNh6FzAFBUoL8FPdbPpeYkvPFoz66TVTej
         qI5ik3u9Nje6TPyxZKoU+nzNXVGyA7dQdT4M916hA3X+xP42envwwRjTqmUDWKl1iU+f
         AZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436520; x=1743041320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYdjsu9Z7/7WUWaSQUOHiYBv7brhy95VtaLf8YZSIL0=;
        b=EGJ9yivzGYGvNWI8Jff3e/rkmI+eDLJKLhgNeW9WqgyPJH64ULdGaC7BJpUvUp38dY
         tM5RpbAty1E4YIfRDTKXKSzSUijNcOzzycQBWF9gRgHOKTgSl/5SvQgq1qdP/8dHMQ7A
         ep7ulfpeDK+Th7A2vquXx+XNhkKtMlvyFYwZ1jV4ONw63j/xsZpEGJBU9ndYiKq3aQaF
         9dqkx8H8gBpZt9Sg3dyFQyMNgFPkcucwzFyAgF8L2F2G+c83vrMxUC+4tPFfiYTI1hkM
         Ieb6BNkrh2FaSJLKhCYuswiT20Z/kaG4Gwj7cITPNPGZKf1hyQvdHvo51wGapdv34VSe
         EpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy6OgW4gEETIYOnV+Y7A9/yU4iS+teRNDayeMbJ5/iokZUVHQw13CpKtx4w7J1hEXpU0Ax1y6I1piKdWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vPumiSQNwSumLFBxw7+OtTx0j6CALcPEXmrEFynx10KUyFJd
	GCt/DAtcs+x8WySDTltmK8ML6igWqEFEHHjZXo4/TW5XW8SBgLCZuqrMC+7mQTc=
X-Gm-Gg: ASbGncsYWwiU3XwNpEEISA325uemnwPSM7uusNupDwtbA+7vQdZrsAa6ToyAUUQIFBC
	0SYNUHb2Wkupw1VbKyd40JgzFEVF6PfwYq0/y+LWTEb75/5BHfGGpXRTL+LsObcEOGOHdVJkXuG
	8eThGw93Lbdo46dDiDdP2a/IJy9rl7yuv2graCgt6NCKCJHxbD0xhKh7TwZQg0wpd5VRzsUe1Az
	jXr1Drt70x2T9jlRz0OAIfbPQqxIN0FBBkS5fujawpdkoWm6P2zOMfh0pozZ7mZ9qZnquJa7Mxq
	/22CkipVB2v7BbmlNzfPxmt1owiBSpw3aqscQRuXa9WXvyrGlU51wQxG8frIoZgREC1MxkvEE3B
	yVMNjuBlyKh2WGG9Po6YqC7zv2dcs8A==
X-Google-Smtp-Source: AGHT+IHctHYEVPNjVuLvb2QThCG44XzX6Hlpf6z6uDv1fDPTG2mB/nmST4ANdlI35F2bQBVILOWMeg==
X-Received: by 2002:a05:690c:7281:b0:6f9:87da:b763 with SMTP id 00721157ae682-7009bf78fe0mr72646217b3.12.1742436519870;
        Wed, 19 Mar 2025 19:08:39 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:39 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/17] rust: pci: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:26 -0400
Message-ID: <20250320020740.1631171-8-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of_mut!(place)`
with `&raw mut place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw mut` is similar to `&mut`
making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/pci.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f7b2743828ae..6cb9ed1e7cbf 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -17,7 +17,7 @@
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
-use core::{ops::Deref, ptr::addr_of_mut};
+use core::ops::Deref;
 use kernel::prelude::*;
 
 /// An adapter for the registration of PCI drivers.
@@ -60,7 +60,7 @@ extern "C" fn probe_callback(
     ) -> kernel::ffi::c_int {
         // SAFETY: The PCI bus only ever calls the probe callback with a valid pointer to a
         // `struct pci_dev`.
-        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
+        let dev = unsafe { device::Device::get_device(&raw mut (*pdev).dev) };
         // SAFETY: `dev` is guaranteed to be embedded in a valid `struct pci_dev` by the call
         // above.
         let mut pdev = unsafe { Device::from_dev(dev) };


