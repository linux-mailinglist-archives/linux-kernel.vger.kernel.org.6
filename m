Return-Path: <linux-kernel+bounces-283093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8694ED18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D52B1F22ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329117ADE5;
	Mon, 12 Aug 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIetRdCY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45917AE15
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465952; cv=none; b=mYHsma2PfBczNHd1M7SHYDfofIv5Q7hqp9tY4LtrsBTZFbgoZ/nK5yyQgnDuQXjvMiHIAMsC8DkkTc4P+ooRZpzn2PjJY3Hp9mPj6oi7BFVR6NJBehd2UmtKJJGcPpwCHZnzwGMXqdiEDc1y1ZsAKMQW+/2/36AcHEloHfGxrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465952; c=relaxed/simple;
	bh=0zIgF8iOZJpkLikhKsG5URaMwMAnL1lizsLIc7IZOz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWgGg/PAMuNeFdvQrNzrz2nBEHYR1MxDye+7waTrJ7+o/Y0pncjver7I8bWH3fdJksBXADqE5S5vl5uUeN3vSQaGrufilqUUu3xmXogx1rGpgBbRbMMCwDdTPM1LkxUHAF52KoS5R4IHLLT6AQCAHWxzBPHacBbT9TChv7PrvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIetRdCY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723465949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4qHHKU0iHbF87h4W4yLqLEg6CsTAei3xO/De8ekDPfQ=;
	b=TIetRdCYiPkfhQidyEWfUWexg8hDzGik6QI82M3mH1sTCAkntATCXUJY7etPZhEwi8q1fq
	wqwQjm+pNn4aGzyySQD+Bdy+dLfkskE2iGKWBcVNcHV68jCA6CltGtISm42CTAKRRWuTgj
	G8/5x+WceNgMc+wt09Yk0s1uDtEhSjQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663--D2dNI0cPfOtaPQyrHG3YQ-1; Mon,
 12 Aug 2024 08:32:24 -0400
X-MC-Unique: -D2dNI0cPfOtaPQyrHG3YQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9449D197766D;
	Mon, 12 Aug 2024 12:32:21 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00DF730001A4;
	Mon, 12 Aug 2024 12:32:15 +0000 (UTC)
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
Subject: [PATCH v6 0/4] drm/panic: Add a QR code panic screen
Date: Mon, 12 Aug 2024 14:24:17 +0200
Message-ID: <20240812123147.81356-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


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


base-commit: 5d45c01dea6f9e0f2dbed3ffee02ac2e80579ad4
-- 
2.46.0


