Return-Path: <linux-kernel+bounces-245440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32492B285
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC895281BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3F15572E;
	Tue,  9 Jul 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eml6KNtJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BF155739
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514770; cv=none; b=oRCxC9qw2My/GiLwZlekFykMhsO1psot2tVZDDPZlf/w9kptfKvkbQN/6kwdo5XDyK8x4GZuS73exbfwKtqd7pmlqmcI6NXAKX20FrNSEwz19y8AeiitmdcLlCU3FxvXF1DvOKxND0MlrHuwzPtDwrljoDhVmeQxlZ9wwyJoxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514770; c=relaxed/simple;
	bh=Ba7A+qf3KVB7glN+7THcBtgbX6uG/c4nfawtYEGqGLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UChpUBcsL0nA8uc1oMTupRTBXWDHLDGBWd6Vcm0Ax7wnQrsEn+i8rcLuGRPrlbfoAkeSCe8JqPjpk/VUTL0uZJIXd9j0Pv9T+tKf7AH003Fqnc5v0LCTnCzne0o5Cx3yZrA+rOMRlqeLI9tFjE+Pky+Eq2bG2kRuk+qV8YMxGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eml6KNtJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720514767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUB0YpD6W/a3Rk4MCKqOREUcImdmQCAk36U0msNsfAI=;
	b=eml6KNtJMUiA12gKECBOliG0/ffnwh1mZ/cHn2JaQ5cnZg5mmnaepHC4IFEzUIBHrRRHja
	Skmz10fGIgPlVCWtFsYf063xn9iymz+wrsJvsLjtlxHj6oHMEPsjVrACZrqpw5XoCmt8zR
	86/0Um5eA5IYVCiU/YnbAQ3MX/gwN6I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-9nG2NOENPs65ZRhek9jviw-1; Tue,
 09 Jul 2024 04:45:24 -0400
X-MC-Unique: 9nG2NOENPs65ZRhek9jviw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2276A19560BF;
	Tue,  9 Jul 2024 08:45:22 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.246])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3CFE19560AA;
	Tue,  9 Jul 2024 08:45:16 +0000 (UTC)
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
Subject: [PATCH v2 0/4] drm/panic: Add a qr_code panic screen
Date: Tue,  9 Jul 2024 10:40:06 +0200
Message-ID: <20240709084458.158659-1-jfalempe@redhat.com>
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

v2:
 * Rewrite the rust comments with Markdown (Alice Ryhl)
 * Mark drm_panic_qr_generate() as unsafe (Alice Ryhl)
 * Use CStr directly, and remove the call to as_str_unchecked()
   (Alice Ryhl)
 * Add a check for data_len <= data_size (Greg KH)

Jocelyn Falempe (4):
  drm/panic: Add integer scaling to blit()
  drm/rect: add drm_rect_overlap()
  drm/panic: simplify logo handling
  drm/panic: Add a qr_code panic screen

 drivers/gpu/drm/Kconfig         |   29 +
 drivers/gpu/drm/Makefile        |    1 +
 drivers/gpu/drm/drm_drv.c       |    3 +
 drivers/gpu/drm/drm_panic.c     |  338 +++++++++--
 drivers/gpu/drm/drm_panic_qr.rs | 1004 +++++++++++++++++++++++++++++++
 include/drm/drm_panic.h         |    4 +
 include/drm/drm_rect.h          |   15 +
 7 files changed, 1355 insertions(+), 39 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_panic_qr.rs


base-commit: 5a716b06b329bd2108c95a4f04c71bbe491729f2
-- 
2.45.2


