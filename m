Return-Path: <linux-kernel+bounces-545204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C564DA4EA41
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077BF4241E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF594293B7F;
	Tue,  4 Mar 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2ZE3ycl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2A20967C;
	Tue,  4 Mar 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109771; cv=none; b=NCNKvTJQmdYl10B44PSWw66mNAPARKWNztt9ihxqcgLYIN4Q5MnsZ1rUr5zUYZVs+gCOvargAT2JQNY31hn32TFDiSMl+e6tQ6ua/dm4NTuj0eAucB9A4JK/KaKA+HHFDcNz/f72ecNnG+BCaCAebsMSbwmrOhGUozLR9U8CW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109771; c=relaxed/simple;
	bh=VWb05+i6gtUm2qjEL+/as6rN5zfg3VkaaaJqFy7VfTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2QxxvScFPpXyaYSuKlAAjOcewao/TVW8E5N1+PXIqf8nfyAFNNz/eh5fqPRKFahAuhGcfY4p9lBfepCoPgse9uCnB9yLMuwXjlIGe9tS5Bq4uWvLmkt/wn5e+Nt+TTLYEX498n9wU0jCfh8jKZzM2wGyVAN00xxP1+ttrIe304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2ZE3ycl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7674C4CEE9;
	Tue,  4 Mar 2025 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741109770;
	bh=VWb05+i6gtUm2qjEL+/as6rN5zfg3VkaaaJqFy7VfTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2ZE3yclgc34fDhaGM2qEAHNmfCkQoDUpSzRjh1JM7sk3v/5XXEJer+QU+240LBSE
	 kAxmK5wI0MsH6FuFoLoNH4M8AHT4jD6Wr4nJ4VOQUDnKWXru8xWHXvHws2LTsnzL4O
	 iwJeJVs/8kvrYlBQ7SdxlF+M5DpIPVMwZ9sYotsWYyn6UbDJS/rJIhDE+HIyxn69VK
	 Ld+ea8vPVr05iXacetdof/pQA1W+W7QjsorHjDx19LapBuS6d57kSkTv7urx4JzPYG
	 fIPUhaTwhsEvA5lhUOVIXzejZfHTQ+GEjsI0c3SKGfara/eEiMI49PsdQLu29MEQqG
	 FZVq5K1ADNzXQ==
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
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 1/5] rust: module: add type `LocalModule`
Date: Tue,  4 Mar 2025 18:34:48 +0100
Message-ID: <20250304173555.2496-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304173555.2496-1-dakr@kernel.org>
References: <20250304173555.2496-1-dakr@kernel.org>
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


