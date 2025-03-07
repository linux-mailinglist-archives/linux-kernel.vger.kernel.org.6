Return-Path: <linux-kernel+bounces-550946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0027A5664E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193311893DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44202163BB;
	Fri,  7 Mar 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcHIiHYS"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0B216394;
	Fri,  7 Mar 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345725; cv=none; b=js/ZMygex1W2bPUnn9iUZkmjREJJ/CncTg4O1ww78BN4SeOBfp22JAN4N4fmzOJ8ketJYM7jOgvbnNb28VHTcVgqX967IjHqPqIrsZosdEgj6dlkquupNG4p+wu9FQYjo60OGImpaD50yHUgCia1E3oFO9D6kynJaS4kcr70Ra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345725; c=relaxed/simple;
	bh=nWi1w82ZlChughw2atxEeA1HOxW2EcSlkpcjamzBmkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6eSk19BPgLi1fGUhdcyCdRHzv7p5l9o7R369VfWsaHbwpMfQ46EwZ+1mud6LjkM2SOuHTxiWPcgcep9jbgzfKR3zHJJvi19CSoX8qIwxdGPuCseIJmLRdXS+OVrLhKg2SIx4AzGWqyX5MngYegosf+EN2TpYOP4y68qqPG6wSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcHIiHYS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-549946c5346so351444e87.2;
        Fri, 07 Mar 2025 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345722; x=1741950522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZBUDcLiga65o3ONmY3eoTnwBjqCQOBm6Uo217lnuaM=;
        b=EcHIiHYSfCw3n6d7fq8lhSRBopNtJpuy2MBrkzILk4CIE+h0CcRPr9gTe1HHuD393O
         +vc9/ivdRzmIbPc+QPTAVvVLzx1c1vGB4j23PRU1jKsf899k0pRTqpzbzk8lZ6uuO/VL
         LutFfl0WND0gxuHzUbKRXU24bG0Ef99sjSzteJMyKzygSEqu/o3mpPdE1vO6mVfk39fD
         fNcWdckuZs51cK1xb8ut08lfRYkytqcJ6RKgd9vWgheKTmEddeG9HfeMmjQkjeyQ7Jfd
         hzi4WZPINtbNKX6gxuoe66B/BQHJicl6eYMuFsGGQlgTP+bW70v6kpJbNO1168uT0dmF
         jhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345722; x=1741950522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZBUDcLiga65o3ONmY3eoTnwBjqCQOBm6Uo217lnuaM=;
        b=pZYstDdf+GIbYFWaSKuIC/WHT3HHqpsd7OLmuN1yPV9/+9zWlS1aRb8FwY3EcBg1dJ
         Jsn9IRSx98kROlfc7+7Pbx44xKvU5vcMUHNFWB2pvLWP28jJtR1miHQBQ4HNqf7tzSAz
         ORHoIOxLRgwdspgmbav18OghXNgoC4Zbip0NNLCGI8ojEt1nK2MVJEAkUx1WQsJBXpXy
         8stkcxXGzTKjPDmtrmpb2BZxL+bmtZap6vqUJD5eTivYHEsERbjG+b5rXiEPcb4EC8Xn
         V6tnfh2QWlT+vzgz7jFbGIDnTp/yENpBzoOK1MSOQ2q5duJOfSx65q8zUVr1/tDNH096
         ODgw==
X-Forwarded-Encrypted: i=1; AJvYcCULuezlp9WvqPgFnOzIoUeVi8bxwoZtC7Pr8pHFB4o7Sp8nt+ojkroCRTAh8LQCPDHYMJJl5R6u+SV5gsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOg6QnC4ZZLe0Jn72gHEIsc2FMkMDJUKchp7RAlFdk8kykHUC
	DS/GQK/dTG+ENK2apUNJLGaWy1wVZzwmpKfOwSfkXJ6HoiCmkzTYMZoCmw==
X-Gm-Gg: ASbGncsvlkCsAuJFYEsk0DD07KgHe8qwb9vUeEAIRvErGzyaa+gY8ghRfynplHYxmLi
	RABgalTlx7Bxtmy+hljTk0FZ/NKhWssyh564037juiztcp4JF3jOvVop9zjEUlpy7t6nNZSKDUa
	6NJQ3/IPMWUMBHVX4q/LaBwCWSFiiAl3aBzxWOkJdkWgtCUV01TVSzZ+hG34EGnW8cvMQSBq8E1
	XeBh+YtQ2nH/vDIGOrH8a2d2Qolmd/KgGWbtRyKRwPPs43Cr+fPJfNFOEojqzOysuCM9IU7Siv5
	N/+fDX2aubw7cBY+TARSQLN4ZJVyeSlur+6n3+6YoDaHpB6MQsasP69o0DFoj/dgbHAxrbrjL//
	g2ZhPTDIrJ/8zddqcRcI6pw==
X-Google-Smtp-Source: AGHT+IH0pmG5mntX/CHSlfv4qG5i5KqvwH+6uqJ1o8DOk4THqW5aC9xKMtC/IYhgCK730wYpu9WZGg==
X-Received: by 2002:a05:6512:39d4:b0:549:39d8:51ef with SMTP id 2adb3069b0e04-54990e29b80mr1027667e87.6.1741345721906;
        Fri, 07 Mar 2025 03:08:41 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:40 -0800 (PST)
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
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Subject: [PATCH v13 3/7] rust: pci: impl AsMut<Device> for pci::Device
Date: Fri,  7 Mar 2025 13:06:20 +0200
Message-ID: <20250307110821.1703422-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

Some device methods require mutable references, since they change the
underlying struct device without lock protection.

Hence, make it possible to retrieve a mutable reference to a Device from
a mutable pci::Device.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4c98b5b9aa1e..141430dac2d5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -432,3 +432,14 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+impl AsMut<device::Device> for Device {
+    fn as_mut(&mut self) -> &mut device::Device {
+        // SAFETY:
+        // - `self.0.as_raw()` is valid by the type invariant of `device::Device`,
+        // - `struct device` is embedded in `struct pci_dev`, hence it is safe to give out a
+        //    mutable reference for `device::Device` if we have a mutable reference to the
+        //    corresponding `pci::Device`.
+        unsafe { &mut *self.0.as_raw().cast() }
+    }
+}
-- 
2.43.0


