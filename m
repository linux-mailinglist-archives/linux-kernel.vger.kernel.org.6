Return-Path: <linux-kernel+bounces-424786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 412169DB95C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B715FB21E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8E41B3957;
	Thu, 28 Nov 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1frfGzq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1D1B0F0D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803216; cv=none; b=XlQeIXbQKZMy/M8eGBU0kRPGmuui8l8nwk+NjxHoJh6O+02sDZUfelHKbwjWShaZbVouVIvzz/lZladvQddYPQWfNmJspocYSIQuZ0CbGUfUzsBB2AOVoAml1z4C+ztF3s4AfgBuXM1RIGIFOuixDDSmFDcWl7EFPfHZ6s0KXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803216; c=relaxed/simple;
	bh=E3Ik4zpqBXaoUgm4o3J8sc3AWKSWWlS7ekn07azRmjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr0YakgvWr0BsuIvIhixTFL5/mf+HFU9eLL7ezOlahJGJfLlhJw/MNJxOsCmNTGukddTIpY4K6o/587ZxX0VYxl3KFCm6xGSzXAdjEZQWEYpoWoiB3lEKA0ODW/R2PXa53mqjetut1dq/eRBMvV9/WaWA3Bp1lFyXBP80RrdlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1frfGzq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732803213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6SJAHP15rGarv2ZWYIDM7GIKVfkSq/CuvkJEM5Zlm4=;
	b=T1frfGzqPtv5hDX067W5mLjRSDE9OaLYteQ9cKBy2AVlq7/MlcDOwTTBAeAIxhQAIKuP/l
	CiTqDcw4gSTeLeUJkNdbWEQe6YAyL3XDQ2ruilKjSNMdCdvepmggQ3oruJg35k23YbmMUL
	LPOXCxjdMJVozjiycQwamJtzD4Jd4uo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-PvefGdBBM66yJVHe6jVIrA-1; Thu, 28 Nov 2024 09:13:32 -0500
X-MC-Unique: PvefGdBBM66yJVHe6jVIrA-1
X-Mimecast-MFC-AGG-ID: PvefGdBBM66yJVHe6jVIrA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a37a57dfso6595815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732803210; x=1733408010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6SJAHP15rGarv2ZWYIDM7GIKVfkSq/CuvkJEM5Zlm4=;
        b=UHnXCOFjII1rYYAZB6Eyi0FEvKALQnZi7ECpDxrGAooVr0wiYx4gmJtB8fObqL39T8
         j2EDcTNr/X+WJ+t7pVT3OdjFwk9TuAT/p4rMH6v0Ux/03ezckNbiXuoDkQZ2WmOat2HG
         QTb5QSaKzJYR59ITZ/gHzNZhuUxFJBgV4WC4fxlw2qChWJpCEhHpymvQMqjIrjSX5WO5
         N06mzDU3pCp1ELaO1kFm2GCbQ6IQxEGf55/1dDi976L6lKwNnh/ckVdP/iyYE85Hx6BF
         VSHM2gfCNJm43VNf3F7NoMZR1RiFo0V1fPFTz11DGSAEzio+CCkWiGUwWuZs1P0AtzW8
         dbag==
X-Forwarded-Encrypted: i=1; AJvYcCWs78+E8OEKYrBIqTBn59UpmHbcpdMFuUP1lO4GHbUDJ5DucodEXGOjtRxuRF/RIo3YrL51TU4nt8Ylk+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9Ml6Td2yXYdk4LMuNAsDhzxflYj7k7Hyf115Tu56kpiesZ3B
	fcXSYxDJchbczFcX+RUf+mlUj3Zen7jYBZT8upfyTyjapdAvDPgDSRPQ9AfwGWl1/WT63KczkIu
	RHMIWFW6UDUcebjTLxTA4ACc6k6aG0RNi1U5ot0U9SIUbxL1KI9txcCS9yzwpUEaknnVuPw==
X-Gm-Gg: ASbGnctRs42cwlz3WyZcQIRgLQikT8QglHum5r3vzU8bV3k5F+hr2iqBbGHZ6l0XCy3
	DwYgxrr9Im8pmGVY2k//tHB0/shxaW0HIJYrBn57YGPa4qmTXDhgdFx+HXSFTYg7IFsmCsihoS/
	5PPEOrWbqtSruJUUSElt7k6rVXjalMnsv2wH2xJ/vAkXNYN0Mgp1jAela0docnBG9BCgOcHMlnr
	h4V3j+7U5S1MqfqyLn1IEZFjye3kdPJ545i9YSCvGvfLozPtt9Zzg==
X-Received: by 2002:a05:600c:5102:b0:434:a7b6:10ee with SMTP id 5b1f17b1804b1-434a9dcdeb4mr73655005e9.18.1732803210291;
        Thu, 28 Nov 2024 06:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzxzRKTj1hhxbgKbfI9iOKu3aqDxVuon8Cnx4/Dji1Z2q/mHAgXbf419s79zhA/kno8QYJYA==
X-Received: by 2002:a05:600c:5102:b0:434:a7b6:10ee with SMTP id 5b1f17b1804b1-434a9dcdeb4mr73654785e9.18.1732803209917;
        Thu, 28 Nov 2024 06:13:29 -0800 (PST)
Received: from [192.168.10.3] ([151.49.236.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e48edsm54409575e9.42.2024.11.28.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:13:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: boqun.feng@gmail.com,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	axboe@kernel.dk,
	tmgross@umich.edu,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org
Subject: [PATCH 2/2] rust: block/mq: replace mem::zeroed() with Zeroable trait
Date: Thu, 28 Nov 2024 15:13:23 +0100
Message-ID: <20241128141323.481033-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128141323.481033-1-pbonzini@redhat.com>
References: <20241128141323.481033-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Isolate the unsafety in the declaration of the Zeroable trait, instead of having
to use "unsafe" just to declare a struct.  This is more similar to how you would
use "..Default::default()" (which is also a possibility here, but arguably
less efficient).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/kernel/block/mq/gen_disk.rs |  8 +++++---
 rust/kernel/block/mq/tag_set.rs  | 10 ++++++----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 708125dce96a..65342d065296 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -6,7 +6,7 @@
 //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
 
 use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
-use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
+use crate::{bindings, error::from_err_ptr, error::Result, init::Zeroable, sync::Arc};
 use crate::{error, static_lock_class};
 use core::fmt::{self, Write};
 
@@ -31,6 +31,9 @@ fn default() -> Self {
     }
 }
 
+// SAFETY: `bindings::queue_limits` contains only fields that are valid when zeroed.
+unsafe impl Zeroable for bindings::queue_limits {}
+
 impl GenDiskBuilder {
     /// Create a new instance.
     pub fn new() -> Self {
@@ -93,8 +96,7 @@ pub fn build<T: Operations>(
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
     ) -> Result<GenDisk<T>> {
-        // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
-        let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
+        let mut lim: bindings::queue_limits = Zeroable::ZERO;
 
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index f9a1ca655a35..1ff7366ca549 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -10,6 +10,7 @@
     bindings,
     block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
     error,
+    init::Zeroable,
     prelude::PinInit,
     try_pin_init,
     types::Opaque,
@@ -32,6 +33,10 @@ pub struct TagSet<T: Operations> {
     _p: PhantomData<T>,
 }
 
+// SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
+// all are allowed to be 0.
+unsafe impl Zeroable for bindings::blk_mq_tag_set {}
+
 impl<T: Operations> TagSet<T> {
     /// Try to create a new tag set
     pub fn new(
@@ -39,9 +44,6 @@ pub fn new(
         num_tags: u32,
         num_maps: u32,
     ) -> impl PinInit<Self, error::Error> {
-        // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
-        // all are allowed to be 0.
-        let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
         let tag_set = core::mem::size_of::<RequestDataWrapper>()
             .try_into()
             .map(|cmd_size| {
@@ -55,7 +57,7 @@ pub fn new(
                     flags: bindings::BLK_MQ_F_SHOULD_MERGE,
                     driver_data: core::ptr::null_mut::<core::ffi::c_void>(),
                     nr_maps: num_maps,
-                    ..tag_set
+                    ..Zeroable::ZERO
                 }
             });
 
-- 
2.47.0


