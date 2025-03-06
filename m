Return-Path: <linux-kernel+bounces-549993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE00A559A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6639B189645E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B014727CB10;
	Thu,  6 Mar 2025 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEDnF/vA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019E33981;
	Thu,  6 Mar 2025 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299833; cv=none; b=WZq8B/ZQecvOmGMTWI/1vT9K1L8gMdIdDPUfCYuW9ApPzeetKZ+qZcpV+Hea8WuppTn1bArLKp21rv8+VCqQuE1mC7ylX1CfX/IBZ9e0sLGgjHkl42MX1oKoq82WGE2B6gM4OQ/uOEoK7SRCFZ1Ih7NKpJiUoY2JUVHfduCQTmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299833; c=relaxed/simple;
	bh=y3CZ8ZJK599hbiqH7CSxRE1Iiyt7j7EOyB3glexphq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuluLw8GL8WEh+LOzVNLChhHz3BrS079i1epggkiBCdNAvDj6iutPYbYBAbXBsufyPkF8+zI2MscRsHKLiOGSJuTi8HeXWCO+JbIzhy0MOy5sj6wEj8bzD2mYGCHXny5sPRBnxFmaBD1Duk+V1wUei805uKrblM5SznFIvpZi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEDnF/vA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C56EC4CEE9;
	Thu,  6 Mar 2025 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741299832;
	bh=y3CZ8ZJK599hbiqH7CSxRE1Iiyt7j7EOyB3glexphq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEDnF/vAatuGoGS+jJ/f8Il9WWcjMiMR52s7GqhoM1H4CT+lNLEGSl/8twSncm9K9
	 VhHca6D76eqleQx4IeiIcOiKo78v8SEwd77XX44t1sIsI/siVVY8xh7JXCVcv/m1Os
	 GKi62DLNuE9J7e+uiPAemMzd+tT9Kcz52TbrE62MJcVtBiG8ot2YDrbbKm9oqzSZI3
	 wYA8lWbI9M7DACASeAdo1E0303TcVmLEl1GtwhUspNlb+sX7BW0AzOOyTgZxrK6wjc
	 DgdVys5kg1YAUSc3zuHdDCJethaX59mIgaGzpXXlPpb2Jqtt5ACy+G4PCM1QUY6VFY
	 VPRgyxiKmzhTQ==
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
Subject: [PATCH v6 1/5] rust: module: add type `LocalModule`
Date: Thu,  6 Mar 2025 23:23:27 +0100
Message-ID: <20250306222336.23482-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306222336.23482-1-dakr@kernel.org>
References: <20250306222336.23482-1-dakr@kernel.org>
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

This is first used by the `module_firmware!` macro.

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/macros/module.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index cdf94f4982df..110e59c64197 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -228,6 +228,10 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                 kernel::ThisModule::from_ptr(core::ptr::null_mut())
             }};
 
+            /// The `LocalModule` type is the type of the module created by `module!`,
+            /// `module_pci_driver!`, `module_platform_driver!`, etc.
+            type LocalModule = {type_};
+
             impl kernel::ModuleMetadata for {type_} {{
                 const NAME: &'static kernel::str::CStr = kernel::c_str!(\"{name}\");
             }}
-- 
2.48.1


