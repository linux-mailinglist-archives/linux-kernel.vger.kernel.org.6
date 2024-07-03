Return-Path: <linux-kernel+bounces-239774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB286926530
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677CC284B16
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834B1181BB4;
	Wed,  3 Jul 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HClMsL6s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76217DE01
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021471; cv=none; b=mPLwCY7KE6x9jfLOJjywOGdAobhFnX7ozOT9WdnkhlXKVVi88X6XqsAYGp/yV+CranPYYNKyU6MDS7zyfDNptvoWrjLOe3lzegKl+UIin3l9RThAYoARmRi1PbPFkio+8RMi+M1Y7EOQHZHt1yCvhlprmeMrmSZ9f8QP5PbGTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021471; c=relaxed/simple;
	bh=M9eUlAni9FkUNboMsSyX0Mz7X9vOCnEmjMuBMJuBZDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BuTM4m91od9KiVsfkW9q8J8E2W3LTtOiG/H/9zJ+jvhbpLTupF4MLN5qC1dcnpPTpbyQ3NOOucWU15fHnVxveIAcnx006q1C9Q2saQJ3rHUCdONIcNTrH5UXpedSjs5RyTWD1cDNbUROrKmWl3R2dIYyZhbeTdgXrXunFcFxcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HClMsL6s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720021469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s2erXypPFS96oGxgCOnNdx6e4GIHP7kCcJ5ryjq/x4k=;
	b=HClMsL6sSttiQZGf0IVEdsk0jWFQp7fONU7SE5mRK4gwSwycabMSzwPUgCnGG2EVLYIHsE
	k/XICJ5AxndLjtcUqttmzYqM5F7BHMD0V0VgBW4SqhWDao00ywMWKMEVA+M6uBVikOTn8p
	h1Sy5r7GjBt5Io2Adcp2hWILaqL4uxM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-wbBm45VNMgidjIZZQ62NHw-1; Wed,
 03 Jul 2024 11:44:26 -0400
X-MC-Unique: wbBm45VNMgidjIZZQ62NHw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D06DE1954206;
	Wed,  3 Jul 2024 15:44:22 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.208])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 599BD1955BC0;
	Wed,  3 Jul 2024 15:44:17 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	"Bjorn Roy Baron" <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH 0/4] drm/panic: Add a qr_code panic screen
Date: Wed,  3 Jul 2024 17:33:57 +0200
Message-ID: <20240703154309.426867-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This series adds a new panic screen, with the kmsg data embedded in a QR-code.

The main advantage of QR-code, is that you can copy/paste the debug data to a bug report.

The QR-code encoder is written in rust, and is very specific to drm_panic.
The reason is that it is called in a panic handler, and thus can't allocate memory, or use locking.
The rust code uses a few rust core API, and provides only two C entry points.
There is no particular reason to do it in rust, I just wanted to learn rust, and see if it can work in the kernel.

If you want to see what it looks like, I've put a few screenshots here:
https://github.com/kdj0c/panic_report/issues/1

-- 

Jocelyn


Jocelyn Falempe (4):
  drm/panic: Add integer scaling to blit()
  drm/rect: add drm_rect_overlap()
  drm/panic: simplify logo handling
  drm/panic: Add a qr_code panic screen

 drivers/gpu/drm/Kconfig         |  29 +
 drivers/gpu/drm/Makefile        |   1 +
 drivers/gpu/drm/drm_drv.c       |   3 +
 drivers/gpu/drm/drm_panic.c     | 338 +++++++++--
 drivers/gpu/drm/drm_panic_qr.rs | 989 ++++++++++++++++++++++++++++++++
 include/drm/drm_panic.h         |   4 +
 include/drm/drm_rect.h          |  15 +
 7 files changed, 1340 insertions(+), 39 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_panic_qr.rs


base-commit: 3f5ea7ed705e8effe9cfabf912e769ccb6b7d389
-- 
2.45.2


