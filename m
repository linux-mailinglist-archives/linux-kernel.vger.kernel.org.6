Return-Path: <linux-kernel+bounces-556638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C02AFA5CCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2E67ACDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77852263F39;
	Tue, 11 Mar 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACAzO07K"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C0263C6B;
	Tue, 11 Mar 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715397; cv=none; b=mOOmmgtwYIz7M/y2qdYp3OKyIDcPr8A/ArAZAJbmOn3IWEzPAWHt69eBSLch0zOq1v9/CbdJqPp6AJVOt+GwwWc6lxciC4ZQyAj/xNK8UZ+lLFKbPuU+5Qqvj81IYTWOXx+I6bha2Mxfhb4pxUG/ScMekFCBLECrOe7P4Ya/ND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715397; c=relaxed/simple;
	bh=g2IUN8jCVllbF1ZiAJOX0NP0fmAmUk0/qWWI8VzUu7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sneDVswQwqEG46KbANzywvJIf5EWHt0N6Op7iE/6Nog5vLx54mARpLsSNXjIVSMaBxaNfAbuKhkFpwEVzS4IdMLknraLRFBpc8g4Km34a9FT3/+/CaN3H+sypLjA7zlsMGHlcQQXszSGwtI9Awqnq9DPg+5ZNBzElNjhwt/G64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACAzO07K; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so5948092e87.0;
        Tue, 11 Mar 2025 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715394; x=1742320194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4DDd/iic2hsiU29M8h+cyzkeUX9RCrQK1w4R9M79gk=;
        b=ACAzO07K4QwVkfLyRMiRcqfF6m/PloyGn/UndV2bbkBdR+AvNuOh7jqATmDiavXVKx
         /ALPLyPB/T93/3MpUk3uwnYkaXBHQ0V8VfCPTx//nOy1VOVRrKbGx5HdRT7ws+TnqUfs
         aoark/k0oyUd56EcgGoWThW7D9hTxQHJc8qsMKwIYSNbbqRl1mjxxcQSSzyHsX1jQD0f
         3CkIAwNSzdatdn53pS+3gnjPqQuhiqiI9eyQj7lM+GzvJsHIn3xGTA526YOresEVdWUp
         5F+qr1hZsZgytUud+B7jLeSW721hUYs2DWTPI/fICDhusSw5IVc3fqKeNdKXvf9HFa4+
         wj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715394; x=1742320194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4DDd/iic2hsiU29M8h+cyzkeUX9RCrQK1w4R9M79gk=;
        b=hGckO7HHHxpLXZ1zb4O21qzunt2aYLHWJ7gqW2eTRZJHP0lQ4LUA+BmuEZhAF7gx5K
         gRZbynkZ+ANVpJhB5BlkSs68fndCoe6EgIVz0A3bCbFZnX7T+wSZpACCEIaLUynzU7j/
         Y+/MErj9Wzkw5v4nL+jdwNOGHbpzvd7iP3pkm1aDebOM7HTMiFD4W/y90fdjxuFbTGwd
         /25Vxz9gQ7VSgQojb8WCHGdsYhXUq0H4xCtBWtq++PDegS1Gz+hMRZrmNsUngJyGqXhq
         ztnSN60qEs+PB+zmn+cVl9R0bAyyAh1LnyrAwGjaNmnVOXk29bB/bYboozKOe1uwR3xc
         CrEg==
X-Forwarded-Encrypted: i=1; AJvYcCUrQylZZ9PKv+mSF/Bsu5PpN8yeuZGNk5hAh1gQfsJCKp6bFpvtX9tQaUF3jvMi93v7RvRvFJ12lNS26ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywN2IuouQ66w7WV3MNwAVSZnIByXhW08TbLJN+jflVXdeVYTae
	bfdWOb87EDP5P3rMQvpR7RfR5cQ/tQKpR/AP7AeosE0VCSGd5iTa5quV6w==
X-Gm-Gg: ASbGncuyuCJLDYYBgoVXCMFS2IUbGvJzPEc63Iq7Kgyzp8y9CsghDp/6GUz7pGv+e/T
	RAR8wi98/1MyHUDmpjd20KDqtLsoLrFFBCMBhLHiKs8Q+EPESkYq1YONNqDUyICLjSQOdRwhTWi
	grgjXFDjBBtSqQDxEpwBFANKhe0St9JMdn0FxxieefCi/diRgcOlgH6id8GV+QqyO93NfvkYI4C
	XGN6v1tldr58gArBAigYn60r64vo4zrTa6QTU+Xd877QPln05cLKnxVLGn2mEUe/W27VvxOvglM
	04EKgASdcltyyAzKvt2P5VsjpHr4ditb3qDGW8PXcxg7HSqnz/Oclc6bSStooKcAcVjTpSs9JTq
	NdAyS3X9V26qydh90noM/Hw==
X-Google-Smtp-Source: AGHT+IEK8bFyfeYyDu9u2ggRv4bnWCiWDFZdozZy4sv0fCHGsi/lf50Ck2X/Ydwr4axZ6CUhdcQvDg==
X-Received: by 2002:a05:6512:1116:b0:545:6fa:bf5f with SMTP id 2adb3069b0e04-549abaaaf60mr1682087e87.2.1741715393817;
        Tue, 11 Mar 2025 10:49:53 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:53 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v14 05/11] rust: dma: implement `dma::Device` trait
Date: Tue, 11 Mar 2025 19:48:01 +0200
Message-ID: <20250311174930.2348813-6-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

Add a trait that defines the DMA specific methods of devices.

The `dma::Device` trait should be implemented by (bus) device
representations, where the underlying bus potentially supports DMA, such
as `pci::Device` or `platform::Device`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 325b00fe7871..7ff797a7ad18 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -6,13 +6,20 @@
 
 use crate::{
     bindings, build_assert,
-    device::Device,
+    device,
     error::code::*,
     error::Result,
     transmute::{AsBytes, FromBytes},
     types::ARef,
 };
 
+/// Trait to be implemented by bus specific devices.
+///
+/// The [`Device`] trait should be implemented by bus specific device representations, where the
+/// underlying bus has potential support for DMA, such as [`crate::pci::Device`] or
+/// [crate::platform::Device].
+pub trait Device: AsRef<device::Device> {}
+
 /// Possible attributes associated with a DMA mapping.
 ///
 /// They can be combined with the operators `|`, `&`, and `!`.
@@ -130,7 +137,7 @@ pub mod attrs {
 // Hence, find a way to revoke the device resources of a `CoherentAllocation`, but not the
 // entire `CoherentAllocation` including the allocated memory itself.
 pub struct CoherentAllocation<T: AsBytes + FromBytes> {
-    dev: ARef<Device>,
+    dev: ARef<device::Device>,
     dma_handle: bindings::dma_addr_t,
     count: usize,
     cpu_addr: *mut T,
@@ -152,7 +159,7 @@ impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
     /// # Ok::<(), Error>(()) }
     /// ```
     pub fn alloc_attrs(
-        dev: &Device,
+        dev: &device::Device,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -194,7 +201,7 @@ pub fn alloc_attrs(
     /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
     /// `dma_attrs` is 0 by default.
     pub fn alloc_coherent(
-        dev: &Device,
+        dev: &device::Device,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<CoherentAllocation<T>> {
-- 
2.43.0


