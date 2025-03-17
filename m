Return-Path: <linux-kernel+bounces-564938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20344A65D53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27F73ADA53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF51FC0ED;
	Mon, 17 Mar 2025 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6fOMIbV"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13C1F582C;
	Mon, 17 Mar 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237657; cv=none; b=pnpElYLOY91O3ylbfwKguHT0oV65gyoAr59AyDJKAfrsNlRzlF03IM1PSqZrQiZ7rnjVeiiJJ5eJPyiD5Si4OJ2SWbC+5KIrJmG1SIKgsS1bdcLtc39OLctqdVmUv5SDqiYkgwY5MxNqBw+8YwKRvyUw9Xo8dKY/oQISqUWylzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237657; c=relaxed/simple;
	bh=O6iH5uaB2vnuCo3stdhQI+RIzmVOwagXzOMXjOYTBuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BY7HgO3zzb6gGhnG5Qp/UdnFkMant8OKBcRiSec0GwGXK7h8RmDKLus8CywstamyryBNhrQI2mBOLGtprWArTSSR2CNcF/GLx1sCU4kBlOAnvX2/TUuJLRvW85KvxMcAUdsfhhhf2PqYo1qR9rnUPlW3mtMFvqHTzZmNqkYXQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6fOMIbV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499c5d9691so5189125e87.2;
        Mon, 17 Mar 2025 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237654; x=1742842454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQtPQvh7AOfNGyyJYgAlzNOC+RTx4D234UEnDx6A0Kg=;
        b=N6fOMIbVpsfSQQyJ3HcmHUGZh15vBv/HyKM7ysoW24IrF5zHhkBWIRX8y9vdxLKhY/
         1a9NHWSave1rE2jSfn2azne1DK/eaX8nuO1fQvw8/bquwyrs2fxGLjixEYJCA2zWqVVB
         MlL7LQ3qzCDgXavF4yOzDn0X04pqDOIqPagijfK93fqa1weIGlmGNgiK7Jp42JkfmmvQ
         ywlzpMj/5LGb2PQ4N87sXZll1LRMxjyYDIlaZ0OP78e6HtmdR+Ecrlw3LgONVCcmwm0e
         K+5Dnc/GuR/eQUJFY6Q2IIVW2eWjF8G1/ZjmTyfk71xlwj6qkB4JM6Ix9t2MDJisHiTW
         gSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237654; x=1742842454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQtPQvh7AOfNGyyJYgAlzNOC+RTx4D234UEnDx6A0Kg=;
        b=WDTSPAGGjLrc13Kiknm5FVRnjk2tS+GTThkQIV1qhVvtwf/CgxiWoFyfDU4+QcY80H
         YLTF3b+xwE/uZ2G4MXQ4rR9wW9GJgh6CbZlM69dfE2KJKVJK9xGiKFJk+iYerRCjRajp
         1JWGx11Ur4pHeF/fbT6CIGDgjNzl/tZErvg/UkP3Fh8WjejIAixryNfvnrq9S1AjX8KH
         zYXTwl/7iJf3vbehkKg5VIPeIkZW9JJjVWYC3OZqCwADqlA0tbcjDq4Io0g0NMtRCudz
         Wrt7Ssk9uQ5/gJjMpFSSnBSO5u6Ji8vSkzGiFBTz7it++utXkTZQxCzOhgr6XxO8yqvG
         mGAw==
X-Forwarded-Encrypted: i=1; AJvYcCWckLWf9m/vbheLNuGTnDZ04jIZi1fvIjcOMBO14MxH9flPVGI9A8E9t8yKFdEtPFqCgriyRDrTLV8rkhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4gqEH5Z43WhRwwMntqIz4BJrLovwvcV4Dz0pioPTfAp1yjMQ
	bAQKJx1i09IRsbSHdO8p9+114VRJ0S063B7Cf7xK0HqtrV9lPlrjoUGHkQ==
X-Gm-Gg: ASbGncsLXkmiV62XcsBUzuRnoyV8Kg1h1UDg/w8gWt7iCbnppDR8dRqfFPmq/9GirTn
	CPUk2o0QuvYxp6QILPU76qvAiU+zFje2DCFSI/p0veU7BCFt8MvEwZfNmm4CN3aCR7u7VUYxkhZ
	92csDxtNpcSE9S75TKzIIzEYby+SB56pv6ZGpsk3imlZh5KHAmg4UWY+6/yfaB/XhLv1A+yoTnS
	8kHaScDOsupGEHR5qymSnaZoY5UVXWDL0WfULxdGM/RA764VFExcy7KueP5LIs5t4vMawJRLmFw
	99bYKWXnd4VTEfWrSbB5J++cfqLiaCg9tR/R1L60nSpzqlCuZlm4DAFVJAEm2tPhpwopqXOX4Ki
	JPuyp/hh878WwVbNnOqMceg==
X-Google-Smtp-Source: AGHT+IGT6zkWZzSsnWuUG/nW7dwX9DryRKc+ef3WR8hQSZbEMG3129wtNF8We2swDm+RCLx4OFZ36g==
X-Received: by 2002:a05:6512:acb:b0:545:2950:5360 with SMTP id 2adb3069b0e04-549c38f5ee2mr7499944e87.22.1742237654055;
        Mon, 17 Mar 2025 11:54:14 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:12 -0700 (PDT)
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
Subject: [PATCH v15 05/11] rust: dma: implement `dma::Device` trait
Date: Mon, 17 Mar 2025 20:52:12 +0200
Message-ID: <20250317185345.2608976-6-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
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
index 9d00f9c49f47..834d00c1347e 100644
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


