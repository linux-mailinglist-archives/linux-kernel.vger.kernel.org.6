Return-Path: <linux-kernel+bounces-562890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508ACA6343E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1F31893C2B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEEE189B94;
	Sun, 16 Mar 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="zqSN2CBP"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A037218FDAE
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106040; cv=none; b=q+ulJf9E7f5fxXLopg0qBfJUNWgLrDrl3sdl+ulf4li8eBlazyXIxmmULOBONWoOe19dChJbjxxMYaiqmbeT39dmKLf8Uvhl7SWW6lw58HxmE7OAXDBdagce7FVhtd2sjyqNaZUUD3LTTfyoL4KeiF/OfyqhCaeifeHhIBJV19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106040; c=relaxed/simple;
	bh=gySnbe+vLzB7F5mNzeA75V93oZYKI+9q9RIAFvjms8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGkCes1eycoDujKQMLVZBbT7gQye2/fyOLK5FELBssDuX2PSBktwjB6JoDu4eiXZlWGPM3yZjABYKyhJUmEtVHY99pIO0kO4czZGLb9ikbRS3MAtyW9T8Bz96bGoAwz4oFJVQvqLNGGCkz4PfGXnA+F/qM85UoJb4+N/SHcrcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=zqSN2CBP; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e60cab0f287so2514396276.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106037; x=1742710837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx2EcOXIxEZHQL9BVCXmu7GqocKqlrDTrKJRW1T6D0Y=;
        b=zqSN2CBPYsw22cJTE4KuD+MTAZRZZkX1ijMw4IQPJMM+vX7q1NhUl7qe/tXez3Etdv
         ILfBzMaoprc3kWDofuqmGNYnDRn2Ov1tJdvQLEFSTvdcQt84Jnj56HgXAt9gzGfyY0Du
         Ki8kRplJgrpGrjEJorh4MpHpnj/4boLXubLE4xuCBykDfLmPHP91kno+lLHxg6KZBatW
         pzoLYb1+P0EHNPvQHklQTW/hYmIbT8Pyhb1B46Kf8166UuFIk8v7hss4k7qUTLzR1QqM
         XS0qzIITSpePStLQiImumodMWl0Ni0e/gZV8vNY2xnHrjQ+0iKUu8RosgeBnuU30zFLr
         UaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106037; x=1742710837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx2EcOXIxEZHQL9BVCXmu7GqocKqlrDTrKJRW1T6D0Y=;
        b=AHuXEAj4x+7+V56TWOnzZJkJ/SvJvvzKpiLhZ0pORraaz1aJVdaJoXPPCtrEOzJD5V
         dKn/PfPKsf5sq2nUDWNq4sCzpHIJ2JoILMJf54igK72dkfr9iqJ55Wk1O+FatmhmcZnP
         MtzhQ5+qCbtNYYCwICYb5LubiKxdtPyFz188csTsPDgmDirEeKpjvc+s7nLgAi/nz2va
         sJOeW4+MvQG/JVcqljTD9MPsjxyksnmxIg4Bpf+hqnq8iAu+Jq1FGdetTslBkVr6rkVn
         r0k3wI8deJgIsbdwrsfyEZqYEZHNuXU3LCaKP6MCpP+EaVLFHM4bMhUWQHE+Tn9wV25N
         fIew==
X-Forwarded-Encrypted: i=1; AJvYcCUwMI1RaXhskW2YC7j7jf9/quiQyp/6r4l+kCCwHlO2ht6E562FI0OWs9lMCy7Qc01MiULbFMU6opL34T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjFN2rfnZb0gRTfQuIeC1LJLrGF+YVZgxn0zx9LgUjtIxIzvO
	b750GCnIxRNwzm9zbUvSLJJ9vx5foxkg+ZPPtEwj3KBmmfnRnNwQJCQxE24EKCw=
X-Gm-Gg: ASbGncvr/Ky9tMB070GVI3e/pthHIyUzJ0+c+sUuofZxPIH9YIVxvYZvyujS24/ZfFS
	Ja9oYsocg+6z7dM4MzSLb7YR/U1FDH/FVYrwDsob7FGiN63qdnMKeEdydOv12eyr93Rbgytbky3
	4bPfbx0bEqUAXRWkC6kZcpAY1pGzGtyiXrNuv8gyljTkOQvE8yyQpC512RdpcTh9q85Iym9Kxdg
	f74qvA1Odfh4G5TDGTUXZ8vgjXBuRgmML6cQMe/5Khk81Ad5sleZw5BbIwUs88uovrWD78TWP8S
	KijK7xA+pF+Kb7lUfNfwrh178yI8nizmEzWkwPe5hmtSXsfaOSlh+4YKkg2Vdv8gHMclCZboA+v
	bCKU/4VZgVmHHW/cOqXrcGBZuWO/orQ==
X-Google-Smtp-Source: AGHT+IFnrHoT6XIuxtLq9jDo1MLrNzQ6L46U5f7kPuzqx8EI+Sypu2OuNNUq1wE4WEO3Y7c9ZHNJdA==
X-Received: by 2002:a05:6902:1a4a:b0:e63:edcc:edcd with SMTP id 3f1490d57ef6-e63f65c4e12mr9676199276.34.1742106037568;
        Sat, 15 Mar 2025 23:20:37 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:37 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
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
Subject: [PATCH v4 07/16] rust: pci: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:16 -0400
Message-ID: <20250316061429.817126-8-contact@antoniohickey.com>
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
-- 
2.48.1


