Return-Path: <linux-kernel+bounces-534570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D2CA468A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA8F1734E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B9522A808;
	Wed, 26 Feb 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmJCfdLh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6022A807;
	Wed, 26 Feb 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592575; cv=none; b=fox9E4h029pkP7hRXhpmgj6lNQKBNK+yUURUUbxzRQMEsqmSHRF6ypo2EfbrluZPYuMGYsZze5HMaoLJZXCgVRoqJl6eQr/K4ahFwM8Nn4/vrcmtmFLJSfqsYdClq0YuUPg7OrlQ8c/zQFLBqQk2KGcij4AQYwoEcIQuPWiZmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592575; c=relaxed/simple;
	bh=hcX6vOhc/N2TdsfmPWsvTjfv/VFUxahP3QLm3YU+4SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvStgbCj1OuOMz8py2iRD7imRdjgRgqPgU/6e3J56ScpA6/j5WXCOVCfktNCSEyoSauvc3OlIbckDvtYonb5/6jA+UpiFSDekX7S2p9qSuaWzkWINysCoBibuB6o9mYoEGlZscRTTajKy3BCntSY2Tkapy7VjAxGR9DkkQuRdd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmJCfdLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C93C4CED6;
	Wed, 26 Feb 2025 17:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740592575;
	bh=hcX6vOhc/N2TdsfmPWsvTjfv/VFUxahP3QLm3YU+4SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmJCfdLhiLcwaqKbhTbzSCdKnpoPR/bTAd2nd1BfHdIiRvJkWywE91qRT3qSQw5kc
	 9/+/9e0qLWlX5wNOaQ4wC51oHAkk735O9a7sP6TQhUHUdC05ViWD7dSS/pnwgacA/n
	 M9uDFaehiKH18bGECWJTOzjImtD6bdZ7vRO+OkpWSJR8x+3tNTNtmyaybR9ZCirCIV
	 KA1bRqW1sHlhVYeeJo4v3OM9RINHsybzIujLiBTrpZ85EFM+g5PMeCGhle5TF8l1ka
	 NwyHLEDYvU6dYvmKIZ1WAnO8annjXgb1baNvk37u0w3NxdT3YPlSULYCC0Fo6QBAEV
	 e+pgPWAUpKycg==
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
Subject: [PATCH v4 2/6] rust: str: provide const fn as_bytes() for BStr
Date: Wed, 26 Feb 2025 18:55:44 +0100
Message-ID: <20250226175552.29381-3-dakr@kernel.org>
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

`BStr` already dereference to `&[u8]` through the `Deref` trait,
however, this can't be called from const context.

Hence, provide a separate const function for this.

This is used in subsequent nova-core patches.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/str.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 28e2201604d6..71e8a819016d 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -31,6 +31,12 @@ pub const fn from_bytes(bytes: &[u8]) -> &Self {
         // SAFETY: `BStr` is transparent to `[u8]`.
         unsafe { &*(bytes as *const [u8] as *const BStr) }
     }
+
+    /// Same as `self.deref()`, but works in const context.
+    #[inline]
+    pub const fn as_bytes(&self) -> &[u8] {
+        &self.0
+    }
 }
 
 impl fmt::Display for BStr {
-- 
2.48.1


