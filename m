Return-Path: <linux-kernel+bounces-255287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27985933E61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5913F1C21293
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673718131A;
	Wed, 17 Jul 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsjgTS7J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6E3D0AD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226424; cv=none; b=fPy7sgwr/WH4LE5LPWe4FRXjjel/Tlbk48SmD5De0YrP2y1djWPS9iS5uvT6QAtCYG1egmb3/4PNfpJhkNsx8R0G8pu3nD2qyivEktVkEqhHLJbFI0k4nwY3LzBg3KCfJKsRpr5pY5JvfxQlej8I6fyKMLukZG5Q1ngQ+xbx8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226424; c=relaxed/simple;
	bh=0i6fn924b1sQyq3LyxwRWcGfMfN2caTpNiccz8aCfgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJZDF/AVaxWb5jLrTLyUCxK04+EruOuUNXzSnYjsjSVO0HrTEqXKrVzt93oErwoxsWsxKuzPn5ndnDJhZn7OFNmMHCLK2EDHpgYOhS4+7yCBCQibkBE+MME/1rkFnobUwMco93OrF5zNwhD5H/gYQ5cLozfT+3zw5TcrZII3yfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsjgTS7J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721226422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=03pe0yiUKP1H7BUwfos0BSDGWIzjAknzzyfMZUSQG+U=;
	b=FsjgTS7JVAqRikJoAr5hYrXjd5Rvhgml00mMLgHwLx8JOhSOgeQrhOiSGCFxgL+iw/OyGG
	iRlSF4Ml1TGpEQEDfqnVBvOz4p1Xx/3rD0AOD83Yijl3kPXt3Do8NXEPrCoViBDeXRm7MX
	UsWfxl3RBiyCcRbFZnXxLc1pDAHmlX4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-rYjpjYsQNXmcYKerrJqy_g-1; Wed,
 17 Jul 2024 10:26:56 -0400
X-MC-Unique: rYjpjYsQNXmcYKerrJqy_g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AC071955D50;
	Wed, 17 Jul 2024 14:26:53 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.18])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 309AC1955D42;
	Wed, 17 Jul 2024 14:26:47 +0000 (UTC)
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
Subject: [PATCH v4 0/4] drm/panic: Add a QR code panic screen
Date: Wed, 17 Jul 2024 16:24:47 +0200
Message-ID: <20240717142644.1106060-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This series adds a new panic screen, with the kmsg data embedded in a QR code.

The main advantage of QR code, is that you can copy/paste the debug data to a bug report.

The QR code encoder is written in rust, and is very specific to drm panic.
The reason is that it is called in a panic handler, and thus can't allocate memory, or use locking.
The rust code uses a few rust core API, and provides only two C entry points.
There is no particular reason to do it in rust, I just wanted to learn rust, and see if it can work in the kernel.

If you want to see what it looks like, I've put a few screenshots here:
https://github.com/kdj0c/panic_report/issues/1

v2:
 * Rewrite the rust comments with Markdown (Alice Ryhl)
 * Mark drm_panic_qr_generate() as unsafe (Alice Ryhl)
 * Use CStr directly, and remove the call to as_str_unchecked()
   (Alice Ryhl)
 * Add a check for data_len <= data_size (Greg KH)

v3:
 * Fix all rust comments (typo, punctuation) (Miguel Ojeda)
 * Change the wording of safety comments (Alice Ryhl)
 * Add a link to the javascript decoder in the Kconfig (Greg KH)
 * Fix data_size and tmp_size check in drm_panic_qr_generate()
 
 v4:
 * Fix the logic to find next line and skip the '\n' (Alice Ryhl)
 * Remove __LOG_PREFIX as it's not used (Alice Ryhl)

Jocelyn Falempe (4):
  drm/panic: Add integer scaling to blit()
  drm/rect: Add drm_rect_overlap()
  drm/panic: Simplify logo handling
  drm/panic: Add a QR code panic screen

 drivers/gpu/drm/Kconfig         |   31 +
 drivers/gpu/drm/Makefile        |    1 +
 drivers/gpu/drm/drm_drv.c       |    3 +
 drivers/gpu/drm/drm_panic.c     |  340 +++++++++--
 drivers/gpu/drm/drm_panic_qr.rs | 1003 +++++++++++++++++++++++++++++++
 include/drm/drm_panic.h         |    4 +
 include/drm/drm_rect.h          |   15 +
 7 files changed, 1358 insertions(+), 39 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_panic_qr.rs


base-commit: e1a261ba599eec97e1c5c7760d5c3698fc24e6a6
-- 
2.45.2


