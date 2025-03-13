Return-Path: <linux-kernel+bounces-558704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB94A5E9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9053B361A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF536147C9B;
	Thu, 13 Mar 2025 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0eNfg4i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F611CBA;
	Thu, 13 Mar 2025 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832261; cv=none; b=oOgDv2Sh3hrAYjq8Q8VuwR1hJdy7+FFA5QAMt+6OdAsQeSzAkZPY4Yo9yNBl7ry5+EBlz3uR7RMeYRijCv6Bfm0N7+9/P3066alDjTYpVbZah33BdJmTVgG5j+uIIQocicwZHRUFlTeI1SCgx0y8dWBJd56X/dA+A+u6gZeFcSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832261; c=relaxed/simple;
	bh=DRVCIISdaFeehvx3l2ubIzGkweyu9N3EeZWWt1VR9Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/9K5eh6zo9mHaqYIHb9Y06DLgHdhl4oRGlRN0XBcZR07T9WE3k3nhtQcUjY54QRii8/jUHHCmIYpzgQzMrkwZP6j9nY7qs9NhiXpRFDf6e2VakAaTaT1dMfL36/z7102/NG9+EKk0NougroT3wpDw4PC8Hi23zoI6FPxBCsxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0eNfg4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E83FC4CEE3;
	Thu, 13 Mar 2025 02:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741832260;
	bh=DRVCIISdaFeehvx3l2ubIzGkweyu9N3EeZWWt1VR9Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0eNfg4innYmycjPdGIJ5KQtsK6SlQTBl42ZvmS+lBh8vRCl5MQZGCBDfkW7Nd/z9
	 +60ERt9HAbNH6/hhe8WHsZqYNJFXZrM8R58NYrmCgSgZohSS1IEStjcCN3TC9Bno4/
	 PW2KDZPM4qJwnmk03AiZ9FlnqVSDaUPhMvU+LBcyFFSv3OCSXcvZ/61TZhwqo1Zi1F
	 kBi0lIDnr7UrasNwXz0pPXOe9QIhqFFr/WgPbzP3mwpChQSN5B/S7y9t43oYxdtjwM
	 fBmglVoozD/SKc7uSRmmFtBspOz7Bvkq3cBA46S5Giv7GH5gCVMhoNO4YswlrdOA35
	 H8att4sj0oiGw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/4] rust: device: implement device context marker
Date: Thu, 13 Mar 2025 03:13:32 +0100
Message-ID: <20250313021550.133041-3-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313021550.133041-1-dakr@kernel.org>
References: <20250313021550.133041-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bus device functions should only be called from bus callbacks,
such as probe(), remove(), resume(), suspend(), etc.

To ensure this add device context marker structs, that can be used as
generics for bus device implementations.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index db2d9658ba47..39793740a95c 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -209,6 +209,24 @@ unsafe impl Send for Device {}
 // synchronization in `struct device`.
 unsafe impl Sync for Device {}
 
+/// Marker trait for the context of a bus specific device.
+///
+/// Some functions of a bus specific device should only be called from a certain context, i.e. bus
+/// callbacks, such as `probe()`.
+///
+/// This is the marker trait for structures representing the context of a bus specific device.
+pub trait DeviceContext {}
+
+/// The [`Normal`] context is the context of a bus specific device when it is not an argument of
+/// any bus callback.
+pub struct Normal;
+impl DeviceContext for Normal {}
+
+/// The [`Core`] context is the context of a bus specific device when it is supplied as argument of
+/// any of the bus callbacks, such as `probe()`.
+pub struct Core;
+impl DeviceContext for Core {}
+
 #[doc(hidden)]
 #[macro_export]
 macro_rules! dev_printk {
-- 
2.48.1


