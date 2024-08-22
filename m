Return-Path: <linux-kernel+bounces-296811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8495AF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0D51F21907
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F77153565;
	Thu, 22 Aug 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvxAQXgx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CB1537A3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312359; cv=none; b=BmIkmfiUcjn+UwLO/voc4GA//ZjTmhYoq50PVMabpr/F2fUue+MmOxJTQtLW2r3AJHcNUCw/kQ1L/x9S2DQf5jA4d1JM4MzWJimibvhvFwUA98+Zl9OQVx43BmwRtL4SNpwnRnJ1AJ8lPPzEp2YSRlRrhRaI2hjGOoDKDXeAgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312359; c=relaxed/simple;
	bh=ngsVzx8rA8dorvLUX1pEJou+TcN2FfuQAX9zmlCAPlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PobVyG9N5KzvpFj7buWCVftclBw99750D5daDl9cCAOe5JFd81BztmT6QfWtaZZptAQsJ4ApUp3BftWSaAgrkLA6jvDc3cerXAbkMpvDIaEew5sp59U++E43atAzTavz6/jzdTBCDIYqx4C9Osauej49CsQCwYji7A4ou5/WKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvxAQXgx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724312355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OU4+GO9dY3KCe88LkMJXdKSy/IKKWUcc3BCoLQVde9s=;
	b=PvxAQXgxKZYMpUlX6oM5sIrMxOvoMSVJoBFKeMmMNcyY6tOyKQxrdSDwU8r9snAY871W1y
	hzl66MfXQ4+jJs+1NjaeTI+aCOF4DB0/I4jkZVKK14mZHxJcrmH3QaziZt4k/TaOdHFbcU
	U53JxJ/Yb2bmx3p1krGRLpOag4VchS0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-8wEP7il1Oh2mzs6XGegCmg-1; Thu,
 22 Aug 2024 03:39:12 -0400
X-MC-Unique: 8wEP7il1Oh2mzs6XGegCmg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3A291954B06;
	Thu, 22 Aug 2024 07:39:09 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D34BC1955DD6;
	Thu, 22 Aug 2024 07:39:03 +0000 (UTC)
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
Subject: [PATCH v7 0/4] drm/panic: Add a QR code panic screen
Date: Thu, 22 Aug 2024 09:33:53 +0200
Message-ID: <20240822073852.562286-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 * Fix the logic to find next line and skip the '\n' (Alic Ryhl)
 * Remove __LOG_PREFIX as it's not used (Alice Ryhl)

v5:
 * Move drm_panic_[init|exit]() prototype to drm_crtc_internal.h
   (Daniel Vetter)

v6:
 * rebase, and handle conflict with 5d45c01dea6f ("drm/panic: Add panic description")
 * Fix qr_width should be a signed int, to handle error code.

v7:
 * rename r1/r2 to a/b in drm_rect_overlap() (Jani Nikula)

Jocelyn Falempe (4):
  drm/panic: Add integer scaling to blit()
  drm/rect: Add drm_rect_overlap()
  drm/panic: Simplify logo handling
  drm/panic: Add a QR code panic screen

 drivers/gpu/drm/Kconfig             |   31 +
 drivers/gpu/drm/Makefile            |    1 +
 drivers/gpu/drm/drm_crtc_internal.h |    4 +
 drivers/gpu/drm/drm_drv.c           |    3 +
 drivers/gpu/drm/drm_panic.c         |  340 +++++++--
 drivers/gpu/drm/drm_panic_qr.rs     | 1003 +++++++++++++++++++++++++++
 include/drm/drm_rect.h              |   15 +
 7 files changed, 1357 insertions(+), 40 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_panic_qr.rs


base-commit: 04b5b362bc2a36f1dfe5cad52c83b1ea9d25b87c
-- 
2.46.0


