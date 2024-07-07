Return-Path: <linux-kernel+bounces-243445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A9A929631
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D1A1C20B6C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635921876;
	Sun,  7 Jul 2024 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+gfm2mT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B117F7
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312741; cv=none; b=VgdD6u/tMd8HlZJE63sI/JgPoFTC1cKCyvpeY3G75axHz3gPOHKCQCtCLCZeEaqssS8ICX4FjgleqQidZktFoLwSahcUMw9Oy2tZvF536MRfsJZWxbGezAH5SPWfj2musPH9arwS7XiI/BeFjG8b7bGfFJwxIrMfUOf7iXjYwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312741; c=relaxed/simple;
	bh=dHtsEElXBy8Dxdb1s0vbepFzPMPOK9qK160QsPvk5aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpslD3VIE3lXp44uYLz4IClMVWESX7snCYOZzZEbqq25vTL+//WcCB24MeSy8Qn7OM6k7p6rzXaRyPk9HNzkSlEOzBZ+sTAeWqwiuSFX/k9/Wj/sbfK1VIi7zNv8GDMMaWgu2zlXxE6lIJ3205tLrOCqNDdH5zKoA3+wqlGz9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+gfm2mT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720312739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HjDxfyeph/HGU7uFboIxbBi4ztp61LafjDj/t15v1RY=;
	b=a+gfm2mTQFoa1R5hjC6bmz0cULIS/55wEZ2NmaUwiguIWsgz+/8BYqR0U79pKXcX7aaxUs
	+5lDGRW6jwHHiD3Qr/nquGVjw3aH3mW1XsU+YLw36ZTliUCL62mCFc1fqs4dyuUH/0lwNF
	YS5cvxhZX90Ycn5RjJ79CcQwB+kKIOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-OxhhDGSPPf-SgLFL3HIHkw-1; Sat, 06 Jul 2024 20:38:57 -0400
X-MC-Unique: OxhhDGSPPf-SgLFL3HIHkw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4257f95ffc6so21223485e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 17:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720312736; x=1720917536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjDxfyeph/HGU7uFboIxbBi4ztp61LafjDj/t15v1RY=;
        b=r9Tjp5caQ+sUNsIRe17LVa3rgbmbQ3OKLm3MrhPx9ucM76NmSwvQYHv7DU0oCygD/D
         VbduGEwUHZpv7sf7libP96sd0eLw750kzny2uotA2ynYQHX/rjeQa1ppG5Nrjf5H1cFP
         SGSwPZKNKO7nkmPHVxMay1EL2DBbfFo6x59Jrgf7tRGyNt9rELcKdX5GDOfGN2jg/tHa
         QUALYso2S7mlIPr7XYgszTuuuCt84w7C+7px/3+wdiYDuLHYQegBZP/6Bh/Y6W7yrs1o
         LDjlQCErbX0CyqdgEyg/hK1aj9tYidv+0kaFRja/N4fHVQQ2iIFwd9A4uxig+hgNd7fX
         o3KQ==
X-Gm-Message-State: AOJu0YzSzc7MxAxucNPJv9beoTv1Y0bPN0U+JTrC613LNoBALrmAUl8+
	sV/EZydwTEs2mFC/SucBaz/BwVjrncSAX704xxPvdYyUsYIo5XUXZA4ONxD1SnL9MBFwb8qZOrc
	QDDJwmPqNJzfovw7TQ3WEXfE2j/niqS0l8EPeSbz6mZG4w6vf744mCack58cMiA==
X-Received: by 2002:a05:600c:12c8:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-42659feacb0mr27592465e9.29.1720312735906;
        Sat, 06 Jul 2024 17:38:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJBWPjFKjE9hN4GVsF5scJWgyYGeayk2+QfvlRcxyJDpRfL21TuRmjpWxSfPWyLZCx4VzNvA==
X-Received: by 2002:a05:600c:12c8:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-42659feacb0mr27592415e9.29.1720312735446;
        Sat, 06 Jul 2024 17:38:55 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4265476ce75sm45822415e9.1.2024.07.06.17.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 17:38:54 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: mcgrof@kernel.org,
	russ.weight@linux.dev,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 1/2] firmware_loader: annotate doctests as `no_run`
Date: Sun,  7 Jul 2024 02:38:25 +0200
Message-ID: <20240707003835.69090-1-dakr@redhat.com>
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


