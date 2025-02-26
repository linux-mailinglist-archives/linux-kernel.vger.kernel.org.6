Return-Path: <linux-kernel+bounces-534569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3494A468A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32243AD460
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF022D4D7;
	Wed, 26 Feb 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdcn+8sR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA322B8C2;
	Wed, 26 Feb 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592569; cv=none; b=gSxey5+mnp/g6yFJz6TdilTuociNb0JgkrdU+ZzMY45TMMIKJSgrFPNQfFn3bs0IMoiB8lE90j3p4ddo/AtsZ7HJ6mi6i7VbaQtheg8GQNlawuIQK27Em/Dmx/pRyBBAdvNWJQ8tJyM41l7MmD1ybX0j2l6p/b/RzCBGBdFrDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592569; c=relaxed/simple;
	bh=VWb05+i6gtUm2qjEL+/as6rN5zfg3VkaaaJqFy7VfTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvOhv4I7aT7ij2IFU0ck2rFaPKSpMSehDYb9YhIPBBGM5N3xWd1MJSCXuuiGchgV+Cs1U22X8vMHZ06pN6u0lJwViHvckutQ2307uS8AkosiaN/jafM/yzXRU+4nxlN3QYuwH99cXy9UgyOodDar6XjiqZ/PQrpb+ghC02lNds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdcn+8sR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0E3C4CEE7;
	Wed, 26 Feb 2025 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740592568;
	bh=VWb05+i6gtUm2qjEL+/as6rN5zfg3VkaaaJqFy7VfTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fdcn+8sR+GatvUYaAZHHzLLAAGsh2UzqruwvSYy0GxcigkHLLzJYBAic8orQ9bPHU
	 Ulc1VgqwoZHhxmstu5mAfkhs/LaAnAy7SFktcB+crH4tVNk9eNTuwlUcKuZOt33RSx
	 LI4AW8gfQRZqaTQW9SnU8NRAbn7bTPkKH5mxI3JP7kht/93vgHdph6hanooVwbks0r
	 c9N11SGk/h8FAvg+a3MlAYYk16+28JrS2/3A0Mx/gXWH2kYeQGv7Ypp2b8E6mGUpNS
	 W5mMhG3jROpUjysr1dBZjNmqhh6Qodr6lxHgeh4D9Al7lMPgxalcsn9C6E3Q3rMhVx
	 YRfENSG2MubiQ==
From: Danilo Krummrich <dakr@kernel.org>
To: airlied@gmail.com,
	simona@ffwll.ch,
	corbet@lwn.net,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	pstanner@redhat.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	bskeggs@nvidia.com,
	acurrid@nvidia.com
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 1/6] rust: module: add type `LocalModule`
Date: Wed, 26 Feb 2025 18:55:43 +0100
Message-ID: <20250226175552.29381-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226175552.29381-1-dakr@kernel.org>
References: <20250226175552.29381-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `LocalModule` type is the type of the module created by `module!`,
`module_pci_driver!`, `module_platform_driver!`, etc.

Since the exact type of the module is sometimes generated on the fly by
the listed macros, provide an alias.

This is first used by the `module_firmware!` macro introduced in a
subsequent patch.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/macros/module.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index cdf94f4982df..6ba9210677c5 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -228,6 +228,8 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                 kernel::ThisModule::from_ptr(core::ptr::null_mut())
             }};
 
+            type LocalModule = {type_};
+
             impl kernel::ModuleMetadata for {type_} {{
                 const NAME: &'static kernel::str::CStr = kernel::c_str!(\"{name}\");
             }}
-- 
2.48.1


