Return-Path: <linux-kernel+bounces-577658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241D8A71FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8416A3B8F29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4479257ADE;
	Wed, 26 Mar 2025 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXnO8NI/"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518512561AA;
	Wed, 26 Mar 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019987; cv=none; b=i8xmopwy/LiJe2mm3yazgZb6ftRcmue3XwCL9IESFhGnX8n/Be4mnKKb6KeCHJWbLblfr2y6ChclCgvi5jZ7uES1KB6JS5p1gAM/6veI2TNsgxKB8KNaa4m1FoBUqLLXc9xFqRuEyxRJiVhL6Xs4PIUn68KYqWM1xjpmNMXeHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019987; c=relaxed/simple;
	bh=QklNTkE+U9D+pTS8UKveElBjdJatRbS+Ai62Y7tPWXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXsI2K/C1b0CSIjjNkwgn3oIgo3b6i0r/XpoCoY6GyllCY2+HDYdhUvpzgA4r7AleXOlLQEEIejKeLSGRn8ansxPXvXfdF1JyLxNLv9TQI/HU3kcBqeBN47JTZLl1HQU1EvXvW3EGavlAc3aBWXSl8Iqth2L+Rq9RZGN1kSimrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXnO8NI/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30c2d427194so2949241fa.0;
        Wed, 26 Mar 2025 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019983; x=1743624783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pveoisS0dkHjk8AoQMkPJTBRAAfPuiNG6lIhjvhzlA8=;
        b=YXnO8NI/yB9I1lVql5uMKKmdnMQswJd8E0/Ol2eBYecfepstmGu/Hs3ZZy+dAtncZh
         CqJ5xfjz+SbJ8lG8TCCeTeo46yWMeKnGlL+C80KjY45h5voAgbAC7aPGqbkQJfsg7/Pg
         oSKkOUuwkZyXdKddqF2zc+TplpObkJ06DyXMTR2dsk3vB3VIJt2L7LraxwF4ULWYSeKi
         Eq7JcjW6uQEwF26S2EBSsg5ZlU9NHoFeCh0fLyO0/pi/QQ4AFPGioapYo05EZlIN6PY1
         AJwQYFX/DKh0IpRlK8LTANTYHatl837PMQeNom36i4BZBWGCpcT1OJay16Fbw/FW6Rt6
         FtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019983; x=1743624783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pveoisS0dkHjk8AoQMkPJTBRAAfPuiNG6lIhjvhzlA8=;
        b=P+c5dmuL9IoYYCMNI2pe6Jo70qWDoql3h4ECTonw+T5H/ENpfzIA9hBrRgVMGBYOxb
         HJQwPCA5WsHRD4IEPh2v2/mLcf0+5mYjCVLqleoa8NPJKhH/GJvgEhAxoO+iHUeHiwx9
         iz3C0jtXvvs/gFekIowwQWq1o08cBc3EnwzvDzhQFdwZcYA0N4Bks/xXONtJySxyVWmM
         SA/9sEKtvunriF9/lgE55vMzSc4uICP0mT7Fe2zmGrYNRciVvw04lHQGkgLB9yNBNFY8
         BlYTY6jNGhu3eX6XDs3WPw74bKNXmqk5SmY4+4fh/3me5MoK5n3ojms7w5J2r5O/4tXd
         cPsg==
X-Forwarded-Encrypted: i=1; AJvYcCUnLY70BiWk/If271heWYuCvg0I9zANCss1yFb+rfIT0LVWcMJpYvBEvpSWP0pCucqwV6ZTmF9khVNx6CH878Q=@vger.kernel.org, AJvYcCWP/3IUCMm0D3Zf+gTleY2tuT4UeZNOBVWIAdP4JEgbuuEjbo7ehbJ8/kdRO7/equ6A310k2phiUJjx5Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+iNJZz3wojOOze9+nJ/PtinVeYQz7CxmYDE6szNH8kB7Lod6
	PH6Mn1iI+cqm3RJHPuk7cPS3acANbfBGuUg3Ax4GwBt5CauNnrpu
X-Gm-Gg: ASbGncvETHY4NLGdCXeFpVsicIxY7BPLSciGsA2JKeSKn05P0VmInaL7xdwY7Hpodtm
	5l482mVGvz/sLpnvjBTMg5WEXpLDjZTEAkWp5i9Im1gqloT6+vvArLcfv0WaVhnLiJvlha7lRVn
	HR04Ms8yrA9+T8ldbizKKb0qe7BFgNrsA3i7LuGhBjrDKxUNNHUJXrmwvB5bnW/XcRZen2YErPJ
	cD2VNDkym8XtFbUTJRGef+LvKKlsfbkRadLXHX64aotQvDPI0Cpdt2nkq88V2LDox0gTtFWl4XD
	rK5eSJVUV+xvACMJRA9wapIUpSGaP2bqMmlHsRtBhLMj/MB/iu9oENmQMo0tpYSUMpN9biKmqWv
	SNmOcxArq+Gz4DsPDbM98HA==
X-Google-Smtp-Source: AGHT+IFayDpBMS79xivFqH7xf6jKCQW1raM5CGZsxw5i6zi+hzQ0h4CALk7kf9R32eciaIZyk6BJIA==
X-Received: by 2002:a05:6512:3e08:b0:549:5b54:2c68 with SMTP id 2adb3069b0e04-54b011d6355mr391157e87.22.1743019983084;
        Wed, 26 Mar 2025 13:13:03 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646873asm1872136e87.46.2025.03.26.13.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:13:01 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 1/3] rust: dma: be consistent in using the `coherent` nomenclature
Date: Wed, 26 Mar 2025 22:11:42 +0200
Message-ID: <20250326201230.3193329-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel, `consistent` and `coherent` are used interchangeably for
the region described in this api. Stick with `coherent` nomenclature
to show that dma_alloc_coherent() is being used.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8cdc76043ee7..d3f448868457 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -89,15 +89,15 @@ pub mod attrs {
     /// Forces contiguous allocation of the buffer in physical memory.
     pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs = Attrs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
 
-    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
+    /// Hints DMA-mapping subsystem that it's probably not worth the time to try
     /// to allocate memory to in a way that gives better TLB efficiency.
     pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs = Attrs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
 
-    /// This tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
+    /// Tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
     /// __GFP_NOWARN).
     pub const DMA_ATTR_NO_WARN: Attrs = Attrs(bindings::DMA_ATTR_NO_WARN);
 
-    /// Used to indicate that the buffer is fully accessible at an elevated privilege level (and
+    /// Indicates that the buffer is fully accessible at an elevated privilege level (and
     /// ideally inaccessible or at least read-only at lesser-privileged levels).
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
 }
@@ -105,7 +105,7 @@ pub mod attrs {
 /// An abstraction of the `dma_alloc_coherent` API.
 ///
 /// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
-/// large consistent DMA regions.
+/// large coherent DMA regions.
 ///
 /// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
 /// processor's virtual address space) and the device address which can be given to the device
@@ -115,7 +115,7 @@ pub mod attrs {
 /// # Invariants
 ///
 /// For the lifetime of an instance of [`CoherentAllocation`], the `cpu_addr` is a valid pointer
-/// to an allocated region of consistent memory and `dma_handle` is the DMA address base of
+/// to an allocated region of coherent memory and `dma_handle` is the DMA address base of
 /// the region.
 // TODO
 //
@@ -138,7 +138,7 @@ pub struct CoherentAllocation<T: AsBytes + FromBytes> {
 }
 
 impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
-    /// Allocates a region of `size_of::<T> * count` of consistent memory.
+    /// Allocates a region of `size_of::<T> * count` of coherent memory.
     ///
     /// # Examples
     ///
-- 
2.43.0


