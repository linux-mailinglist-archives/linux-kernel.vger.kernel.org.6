Return-Path: <linux-kernel+bounces-219786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328290D7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932551C2450A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D477481CD;
	Tue, 18 Jun 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUwAcfT7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1045BF9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725731; cv=none; b=C/hMmn38XPEB1TrQGJ6iJ1Twzv9rIIsvtAFil2ynMnnGhIlVPSGw4NdU6QdmkAIuyBs0iTa3MrjyysjZlE6OIzb1Jryy4w537dz4TjtIIW1ZKIpvv85JdRRPEpkTKH4vpGK8BHfJbXiGLAbyPINO7pVRfj8l0KWoBEFx0al4Vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725731; c=relaxed/simple;
	bh=rl883/TvCFM8iBzfUryfwpVXVVTJzuTXYPgBNHy/Abw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wg4dK/b9UrGwvr3qWoKiOq7QiC3tAyUc2NoPnpZi/HDhWle3le1yF3CFFlpQPaBJh9LmsNqIAf1zaOLla6P1rA+0I405JT7MsXoN9khSsStpKSUNpQjtx+porNWSxjHlWKF9tp9eL/FTeEd0e77l1k5CEoF1WhAu0DAZvCFb448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUwAcfT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718725727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FvzzgHj+wG3QHgl50zv8zTMPpV1hn2NtNSqG9dSefl8=;
	b=QUwAcfT7NTq+dC79Ap5+SB7Ylm1IG0AY28xARplOo0bMZn7/jIe9AEfxh5y2w9skmK6rD8
	nmGf26ikA60HmdJyuYoK74obWJQEcY0YBVJiMNM/WwqHU0c/B7Gt+ZOzFlYP4mKC1ur6Bp
	fkiQ20iZbc3ML/2yZ1B/sq+w3D2MD/8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-4w_9WG6EM5iTreVgWfICTQ-1; Tue, 18 Jun 2024 11:48:45 -0400
X-MC-Unique: 4w_9WG6EM5iTreVgWfICTQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42135f60020so41549415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725724; x=1719330524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvzzgHj+wG3QHgl50zv8zTMPpV1hn2NtNSqG9dSefl8=;
        b=hISP7CejgsQ/MvHlP+8G6orN9r+MVv3o3iqvxbrbudMerE1jN59flfJ4I8GFWCXYDr
         t3xdlZKQ+SpkYuv+GJJ39xudyD1M6XDoW+/dCORAgCptN6/U80WqlXFBMGjmYaCEOZU4
         Kw0zCsDq8msh4H+kZzB/6VI7YPNOBJDeMD2zYBCZooXuZNxtBlMLodb6Sg0Dx9S4b33w
         53xw1h2NcF3XNU0HcZicdIwYbwtFCrd3SDIzZI5BFqPv/k97E+8fpfAXRbar7aFfFlre
         N/G+OXirzs1s4SoEcZIGyeHjcdjj4KxBuyZmY07sFjlxYIXoSm1hbd/AXZoiD8Fjy7/r
         OO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDBW8QrLSBrYqHEaoweozxEX7vAicjrZxG+JNp4Ckx2vSbt0LGCeDq+gGD6Nne6MPoc5a4ZU0gF/bjvw5lqbfIawmkNKjBh5eYZVnW
X-Gm-Message-State: AOJu0Yyuy5Cr25dgM7l+Iz8fWEGqmiuogn1wmu2IaOWdpEq8bvfjPqwY
	NMtXChGCWOeF+9IMBTLRl+BXxPk8PGRkib9nHrxYZiesVVmqYl8K6U8YSYfUxkXAYmC8IpDnAEx
	rkg9aIA8A9baxKp+bWvJwE/VWNi0AKUEIAvF7LIxLdd5vcgjp4oNpef3oMyYW8Q==
X-Received: by 2002:a5d:5351:0:b0:35f:275c:fb6f with SMTP id ffacd0b85a97d-3607a78dab2mr11013640f8f.65.1718725723884;
        Tue, 18 Jun 2024 08:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDdOII8S7S2Wbi067c8OVqGpnKCoURHhtfz5VZdgCPfo66Azq7IdxyFJAMwqr/T4xU3pdhZQ==
X-Received: by 2002:a5d:5351:0:b0:35f:275c:fb6f with SMTP id ffacd0b85a97d-3607a78dab2mr11013622f8f.65.1718725723555;
        Tue, 18 Jun 2024 08:48:43 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607510340fsm14413317f8f.93.2024.06.18.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:48:43 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v4 0/2] Rust abstractions for Device & Firmware
Date: Tue, 18 Jun 2024 17:48:33 +0200
Message-ID: <20240618154841.6716-1-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

as agreed in [1] this is the separate series for the device and firmware
abstractions to unblock the inclusion of Fujita's PHY driver.

Originally, those patches were part of the patch series [2][3].

Changes in v4
=============
- add invariant of unmodified backing buffer to `Firmware` (Boqun)

Changes in v3
=============
- fix safety comments for `Send` and `Sync` for `Device` (Boqun)
- add corresponding invariant and safety requirement for `Device::from_raw`
  (Boqun)
- drop `Firmware::request_platform` and `Firmware::request_direct` (Greg)
- fix missing Kconfig entry for `Firmware` (Greg)
- fix doctest compilation for `Firmware`

Changes in v2
=============
- use the 'srctree/' notation
- expand the existing documentation and make it more unambiguous
- use `NonNull` in `Firmware`
- generalize the `Firmware` request functions
- add missing safety comments to `Firmware`

[1] https://lore.kernel.org/rust-for-linux/2024060745-palatable-dragging-32d1@gregkh/
[2] https://lore.kernel.org/rust-for-linux/20240520172554.182094-1-dakr@redhat.com/
[3] https://lore.kernel.org/rust-for-linux/20240520172059.181256-1-dakr@redhat.com/


Danilo Krummrich (2):
  rust: add abstraction for struct device
  rust: add firmware abstractions

 drivers/base/firmware_loader/Kconfig |   7 ++
 rust/bindings/bindings_helper.h      |   1 +
 rust/helpers.c                       |   1 +
 rust/kernel/device.rs                | 102 +++++++++++++++++++++++++++
 rust/kernel/firmware.rs              | 101 ++++++++++++++++++++++++++
 rust/kernel/lib.rs                   |   3 +
 6 files changed, 215 insertions(+)
 create mode 100644 rust/kernel/device.rs
 create mode 100644 rust/kernel/firmware.rs


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1


