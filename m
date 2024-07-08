Return-Path: <linux-kernel+bounces-244853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5392AA54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2C51C21BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E61CD23;
	Mon,  8 Jul 2024 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COCY2bfu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC13BBC1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469258; cv=none; b=FlwnUSAZu7YempKOx/PvJ+W7mb4A9bud79j+XtG/ObbgV4kkPqFHPR3/0xFAdP4dLsjqQ9Xgp9jnPWL4ka73N1yZSdxSLYFvOCNcw/DH+J8z1T80dxyA7gXZOVp433b+RO6M+6egzG39PxoAZ6jyKTV1tvM09ITHFidhpAwHYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469258; c=relaxed/simple;
	bh=jbVPHV3tTIy+aA00s4W/dE7RaviWeAr/ugdsMlvyqUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrBw1Bs/nQVQH1FODJWhBP6EFs7mkrlPgUoztDvwdIrdwUeHXfzfAdoE/y1ChHU5Xgnn0vycASBPkGEttUlnRVorWVn+5V16itKVW7/o5shlQwSP0KRdfpdqAUE03HkCATuCt34BJ5hDw8ivNADPApMsSXh+1kFGhBlX+3UUIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COCY2bfu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720469255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVe4zI8I8PUfShXSDJ871NFnI3GiGhdY8bM4ieLnzgU=;
	b=COCY2bfuHRQGiZ8QRGvgfhZrjbbQ+HE66IuolngLRRmDhMD5ai7s1pYRXbcIJj+2X7ioR4
	N8IT6e0wI8uXRwrdKyq/iOmICSRqfyzOpKFUuLK3b0bjG0N4m8JzeJUZeUyWMH55r7zUAj
	JHtI8iNz9jHbZ/DaPZ8Uy6zMtKst3us=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-6Hx9Nx5zPry2HRYTLW_4xg-1; Mon, 08 Jul 2024 16:07:33 -0400
X-MC-Unique: 6Hx9Nx5zPry2HRYTLW_4xg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36794fcfdd6so2348037f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469253; x=1721074053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVe4zI8I8PUfShXSDJ871NFnI3GiGhdY8bM4ieLnzgU=;
        b=Ax9+Uo0oaa8tbf5RbcK5yoCZYU204VbRsqFrqBl16/xRWomMZmLnRy1jiKwu8onMqW
         MiE4yUxPMr5/2pxauQDQJkxpqhosKXVX4l19fp2J1wflcv89SfRBj7aXqKA+s30lKUNW
         QVTJIFVGmbxAPV1csGa068XLdrPiKHmHltxIZPdU7AsLZG90xmabboz272IVc0SedkUk
         heHp8/Rq+81BHm1xu26ngmzsL4jZJwAyEAKn4XTFUS4Oak9bo/xbKdjkBRSLHFmKNS/l
         kFtuXaXsEGvFaNMG6l/KuCuqsMomAzo0L76KanKro9UfWGAPHVppXNgrtaxp4uy7/91P
         425Q==
X-Forwarded-Encrypted: i=1; AJvYcCU33oKUhvSbO22KtH6m11w9bRShwxWc29tu15uJoXgo4+TgZCm9RCEa3AChd6fIxPZoeKtuHHTk8GKd5bkjxst7q8mRBFKIENIsens2
X-Gm-Message-State: AOJu0YyVEte/Xnzc/0c2GSZFFlluoy+6l7zAQ9hOIZiXMZLfeN9Jiz+o
	ybP6SmIlL9S0QaQIw8e9GL0fSoZt1G+wMJQQZRYXeDf+uSg75aeegjAFH6/wp06WOxoZ+FKkJY4
	e757RMjLPb7YGGpQSi41MQfXWhePq4NLRhQt5FF19LwG7Nmx7+ZBzM5hAPNel0w==
X-Received: by 2002:a5d:64e1:0:b0:367:973c:aa7b with SMTP id ffacd0b85a97d-367cea4600amr586688f8f.2.1720469252833;
        Mon, 08 Jul 2024 13:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbQxYhK1647LvoL7uPyGdkYRjGlhVuxAY+e7ze+A8jjps1TWhysfjohUpZ5l+10Wn/iuw9Nw==
X-Received: by 2002:a5d:64e1:0:b0:367:973c:aa7b with SMTP id ffacd0b85a97d-367cea4600amr586676f8f.2.1720469252532;
        Mon, 08 Jul 2024 13:07:32 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfb2327sm594147f8f.116.2024.07.08.13.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 13:07:32 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: mcgrof@kernel.org,
	russ.weight@linux.dev,
	gregkh@linuxfoundation.org
Cc: chrisi.schrefl@gmail.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH v2 2/2] firmware_loader: fix soundness issue in `request_internal`
Date: Mon,  8 Jul 2024 22:07:21 +0200
Message-ID: <20240708200724.3203-2-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708200724.3203-1-dakr@redhat.com>
References: <20240708200724.3203-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`request_internal` must be called with one of the following function
pointers: request_firmware(), firmware_request_nowarn(),
firmware_request_platform() or request_firmware_direct().

The previous `FwFunc` alias did not guarantee this, which is unsound.

In order to fix this up, implement `FwFunc` as new type with a
corresponding type invariant.

Reported-by: Gary Guo <gary@garyguo.net>
Closes: https://lore.kernel.org/lkml/20240620143611.7995e0bb@eugeo/
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
v2:
  - provide method for each wrapped `FwFunc` (Christian)
---
 rust/kernel/firmware.rs | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 106a928a535e..2ba03af9f036 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -7,10 +7,23 @@
 use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
 use core::ptr::NonNull;
 
-// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
-// `firmware_request_platform`, `bindings::request_firmware_direct`
-type FwFunc =
-    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
+/// # Invariants
+///
+/// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
+/// `bindings::firmware_request_platform`, `bindings::request_firmware_direct`.
+struct FwFunc(
+    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32,
+);
+
+impl FwFunc {
+    fn request() -> Self {
+        Self(bindings::request_firmware)
+    }
+
+    fn request_nowarn() -> Self {
+        Self(bindings::firmware_request_nowarn)
+    }
+}
 
 /// Abstraction around a C `struct firmware`.
 ///
@@ -48,7 +61,7 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
 
         // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
         // `name` and `dev` are valid as by their type invariants.
-        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
+        let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
         if ret != 0 {
             return Err(Error::from_errno(ret));
         }
@@ -60,13 +73,13 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
 
     /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
     pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
-        Self::request_internal(name, dev, bindings::request_firmware)
+        Self::request_internal(name, dev, FwFunc::request())
     }
 
     /// Send a request for an optional firmware module. See also
     /// `bindings::firmware_request_nowarn`.
     pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
-        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
+        Self::request_internal(name, dev, FwFunc::request_nowarn())
     }
 
     fn as_raw(&self) -> *mut bindings::firmware {
-- 
2.45.2


