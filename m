Return-Path: <linux-kernel+bounces-244852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540892AA53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F61B20E62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337E328B6;
	Mon,  8 Jul 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iM4sdBN8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BADF14C5B8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469254; cv=none; b=uLY9f5GJAGe9UJPU0EAatYhxXnquRFUFkgslKfTB0iK5TEJQfInmW9j3sTYOrUr4P2rvlwV7xfX7kAnskP8OImECvqlhjpDKqvFcx93uSvNTh9oTB5gB8hORalL63DoKIeEFv7Hz/6hXOXz1dt4In+wsmGzKuRxnFAYDZ1Y6et0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469254; c=relaxed/simple;
	bh=bdhvU9UNHx8t9DL/tSkNjaiRfS1x2EaARCAwMAwHCUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUAsxFfDah44mm1R5SAo0OkvpZleBr08aZULu2OTYYCkMdGTLQ4R/il5wr/eq2KA7byFPDn/onaZVAcv0OVT8KRWNIOyX0kfc3xvob7cvf9N0BLD0q6SxzTzztFooDyJmXvTwd96j7SCkAq1NjoMEExDa8h1RWEeUX6N8NPnNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iM4sdBN8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720469251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yL5D2HYEXnL7bQRI7uUNDG51u5Y8rGadc9gkXbyKQGA=;
	b=iM4sdBN8+WN8dUV5WpsC9iOKo03qqcwAl/fj8WTf3rS0gYxmznL0V8le+CHBksehwFsztZ
	NlsnNVoJTG3sARhbKprJ2gCiVTZmnNqbNP1jWHyNijEgRrness25cGdfxLSZm3AN5s/oN0
	/MbWtxMs1zgDEeH/XT1gp7xAkrNT/lU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-S1ySGP9aPVimmO0DZXhMSQ-1; Mon, 08 Jul 2024 16:07:30 -0400
X-MC-Unique: S1ySGP9aPVimmO0DZXhMSQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367963c4f52so3084432f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469249; x=1721074049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yL5D2HYEXnL7bQRI7uUNDG51u5Y8rGadc9gkXbyKQGA=;
        b=owVVCuCuuJbBM+4U2rm32aMfqy0/s4q8/uajKog2FXvDB+3nzAHtcMR4/c8KVsPrcN
         THCIUXZCfC/GxRWcFKOxbas7s+w2Wkw6eq19X1unuaWNSyhL1c87bnwmvr07/TKBhY83
         ZDSX7DJ1KF3VakWNKLng33+uOgUoHnAHDN99B+SzduariYmZ0F0104t1hXIeKCrFbN9J
         pwi6YgAk8MQW3Rh8ZM5l81bCuedBCuatleBnqorGFuv3B49w9aMzstpu844A/n9zHkK0
         pmXx8fEh8z4uVOP50i9tCrV+ppBStOFavuemsCVFr5+Vf83jqhnQnvlkc1jwOWaTmzi9
         JaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfgfSjN+Cm1wxMEos2fBMQqJpsYRJnsCbdact0t8ujl8JE3Z0LBuTxi2yRWsBuSghg/Fr9LIf5fW/Luj/gSAvf22A3dYx8ApIr18PQ
X-Gm-Message-State: AOJu0YzN3OKh4DX0ui5YtXr1iXyIpuP8quhNm4ljeM6rTywl6awZQFqy
	0mUUtxzr6r9W8Otq7ikN5veMLxPsNNJ9/10znRHQJp4trxDC0o6wqj4jdyzw2e4e053lxCoUwDr
	g6Do2KMYUvEPNSRBrykHh4Gfk3PktqkP6r9voLyVDHnsw8nA4YP+K5Em2vfNIhg==
X-Received: by 2002:adf:ffc8:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-367cead1ed1mr404419f8f.53.1720469249403;
        Mon, 08 Jul 2024 13:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH63gQqjJCEcokYKLmBaEJmumwTy7f+NP2A4sWqUyKY29gIBVynPTjxXAGDrCc3mTaIESJUug==
X-Received: by 2002:adf:ffc8:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-367cead1ed1mr404405f8f.53.1720469248992;
        Mon, 08 Jul 2024 13:07:28 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4267259a118sm572885e9.1.2024.07.08.13.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 13:07:28 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: mcgrof@kernel.org,
	russ.weight@linux.dev,
	gregkh@linuxfoundation.org
Cc: chrisi.schrefl@gmail.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 1/2] firmware_loader: annotate doctests as `no_run`
Date: Mon,  8 Jul 2024 22:07:20 +0200
Message-ID: <20240708200724.3203-1-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The doctests of `Firmware` are compile-time only tests, since they
require a proper `Device` and a valid path to a (firmware) blob in order
to do something sane on runtime - we can't satisfy both of those
requirements.

Hence, configure the example as `no_run`.

Unfortunately, the kernel's Rust build system can't consider the
`no_run` attribute yet. Hence, for the meantime, wrap the example code
into a new function and never actually call it.

Fixes: de6582833db0 ("rust: add firmware abstractions")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
v2: (no changes)
---
 rust/kernel/firmware.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 386c8fb44785..106a928a535e 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -26,14 +26,18 @@
 ///
 /// # Examples
 ///
-/// ```
+/// ```no_run
 /// # use kernel::{c_str, device::Device, firmware::Firmware};
 ///
+/// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
 /// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
 ///
-/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev).unwrap();
+/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
 /// let blob = fw.data();
+///
+/// # Ok(())
+/// # }
 /// ```
 pub struct Firmware(NonNull<bindings::firmware>);
 

base-commit: 997197b58bf6e22b8c6ef88a168d8292fa9acec9
-- 
2.45.2


