Return-Path: <linux-kernel+bounces-221099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05B790EDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B8D1C21088
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F0147C85;
	Wed, 19 Jun 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3CdDGQl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696712FB27
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803268; cv=none; b=foacVd0WWfA7UAcsHa/ohikMweiRwiHUOdB61NCTkUshI0IaoTrFY/62X+B6hMi15HjpXb1yf5Nvsg7zT1YSd70zdRdw2QIIoQITCDSSccluJD7QWQY4Rf0Eh2kjl+WwdpKcpyiCi5VbMHpO2EhML9Mp25KErxyNnII+1lt2OuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803268; c=relaxed/simple;
	bh=5E8vDIqKgkn6pHLbqq57H2fNCs3I/Q5RwP7zBhlZdxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxFv3+EuLnk9+JV7yl28ndlUtWKzFFXJaw87ChudVA1oUopcTJ46KvxF9aYLizQoQbGT4Vh5myzQnBXspbBaP1lBOEAwVH8s9nJC1XN5nLuCFh6OLeZ0p0e/1NLFnaSRDc7mjYMI1JwKGbGKA1aRuNHjhEXhXsieNT48MBp9YI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3CdDGQl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718803264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LzW8s4RIKSJhGPbfdH18YWjRsnO2uKYhRg795DPUmgs=;
	b=V3CdDGQl9GJe1XGwiF4qsIUTEXL9r9ZW/budM8BasmIGpAkb6QueW5CZEY3ryikO+RlTzc
	2Yy+JuuPIT07BOulYx3ihjVUprLQtsFMLv7aEezbVEMdfapbPl4BLLoInIMSn5QWyu24j4
	I91Cz+n52uepRFLzsanV8Z1FQo9p6F4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-0kzAwtPRO-OWXkWaVxu15w-1; Wed, 19 Jun 2024 09:21:03 -0400
X-MC-Unique: 0kzAwtPRO-OWXkWaVxu15w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52c7cff3b89so2458736e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718803262; x=1719408062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzW8s4RIKSJhGPbfdH18YWjRsnO2uKYhRg795DPUmgs=;
        b=CU9lclcmpsu51kWdJUCC867VmYxRuWzItGPty5+udMcNik6F2xSHLji61oL+7YPexU
         /PPgmLXsPdq/bkZVvyX+G4EYgwrSrgd5i7oFy9K3geMA89L4nIkKo1vjYRTPALiIgu7N
         +mENLOAJYaakdvgbUp9pMLrldt/2/0SAHAXYih2ydsX4KkbPxwWypIyVLDOm+9NsJMnn
         9a8FcnKq3mN1Z1H5Qdajtm/1b5AZ9UfRghYsU98wjQnMtDPy9xY5dHUmc6immO5xnmVq
         Kv0lRFNI4YRHAvG13q2saqyOgPeOaaQlbxA8Bu+at19namc/r7VuJ8WetUz+m1FV9GDn
         MzJw==
X-Gm-Message-State: AOJu0YyLh/EFFCxkYWxjcbk4aN4UDKVkRNggs/c0VP5/N+MjvHdKbyMr
	qFAN6L/i9v7URwNz+fy+GUbCdHdzBwiK8uu8RcXRicF5AxOQv8FKsVevgqOHXRutn1WBtolWjaz
	5fAPlNDWQsuy6PYMsbBU/EsmrlorOdZN+wqbJBz4irp5m7SMGLztRVTw2jY6APg==
X-Received: by 2002:a19:5518:0:b0:52c:7f9a:5053 with SMTP id 2adb3069b0e04-52ccaa5d811mr1474827e87.23.1718803261897;
        Wed, 19 Jun 2024 06:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNPfhskyKxfy4zOknuSiPU5vN6I02mz1eNi1JlZbCDy7Nt2mfqo0eCZOlFuNltz/QguMqccg==
X-Received: by 2002:a19:5518:0:b0:52c:7f9a:5053 with SMTP id 2adb3069b0e04-52ccaa5d811mr1474815e87.23.1718803261469;
        Wed, 19 Jun 2024 06:21:01 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73c7sm262782545e9.42.2024.06.19.06.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:21:01 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: mcgrof@kernel.org,
	russ.weight@linux.dev,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	Benno Lossin <benno.lossin@proton.me>
Subject: [PATCH 1/3] firmware: rust: improve safety comments
Date: Wed, 19 Jun 2024 15:20:12 +0200
Message-ID: <20240619132029.59296-1-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the wording of safety comments to be more explicit about what
exactly is guaranteed to be valid.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/firmware.rs | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index b55ea1b45368..386c8fb44785 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -22,8 +22,7 @@
 ///
 /// The pointer is valid, and has ownership over the instance of `struct firmware`.
 ///
-/// Once requested, the `Firmware` backing buffer is not modified until it is freed when `Firmware`
-/// is dropped.
+/// The `Firmware`'s backing buffer is not modified.
 ///
 /// # Examples
 ///
@@ -72,22 +71,22 @@ fn as_raw(&self) -> *mut bindings::firmware {
 
     /// Returns the size of the requested firmware in bytes.
     pub fn size(&self) -> usize {
-        // SAFETY: Safe by the type invariant.
+        // SAFETY: `self.as_raw()` is valid by the type invariant.
         unsafe { (*self.as_raw()).size }
     }
 
     /// Returns the requested firmware as `&[u8]`.
     pub fn data(&self) -> &[u8] {
-        // SAFETY: Safe by the type invariant. Additionally, `bindings::firmware` guarantees, if
-        // successfully requested, that `bindings::firmware::data` has a size of
-        // `bindings::firmware::size` bytes.
+        // SAFETY: `self.as_raw()` is valid by the type invariant. Additionally,
+        // `bindings::firmware` guarantees, if successfully requested, that
+        // `bindings::firmware::data` has a size of `bindings::firmware::size` bytes.
         unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
     }
 }
 
 impl Drop for Firmware {
     fn drop(&mut self) {
-        // SAFETY: Safe by the type invariant.
+        // SAFETY: `self.as_raw()` is valid by the type invariant.
         unsafe { bindings::release_firmware(self.as_raw()) };
     }
 }

base-commit: de6582833db0e695ba0c548e3cc2ad7dbb6aa260
-- 
2.45.1


