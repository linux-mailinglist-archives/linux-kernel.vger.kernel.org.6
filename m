Return-Path: <linux-kernel+bounces-247723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136A92D3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BADA1C22798
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD36719345F;
	Wed, 10 Jul 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqkzFwtD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F9193477
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620087; cv=none; b=m6F8G56SYdb1JEymZipUitUikysoYGgwOVFqwnfF56qQZOBu5dnvT+ETGPDPjofl+dQm6p9W9aI+WNHsZ+tzG+8EoswK/7zEUU7txSbzdP2U63BSpAyQcQ/erv4q63l4ZiPLFTyOsk4nSil20jZwKryJV5Cg7G3WgBsyXVEQtmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620087; c=relaxed/simple;
	bh=oc1zcJLj0iIiGUlYapYBgCTcDL4XqAHvvm008AwVrf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/xdUprageya3OPTxhUwgIF/wcH+voRQWGWBmYgaavGsB4dasyR2fGS4HX05BJqXpDlwes6xx9Cwv602QN8wjv8UgdwRvjuJuY7Db+g7oJo4tOLloL4uLTfbKpZvI/e9iqqsVi28x+59RPK2cIGV+KcxuhXqUGFdGr1pPyoHLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqkzFwtD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720620084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WMDQmIcpWVi3ka+DXh7ChDHQelkHDAsew0CmHUpuI8o=;
	b=QqkzFwtD1UiQPJ+GzVpX4dQNIAiWg4KQ/rpRY0qpxcf35r5aFVxNyfIHXar6whojQY1vaD
	U0La7xaFWEVNo17pKFRdrkkBpEiXNotcF44DS/nkWDVSWa4sK30cLjnnj2o/kVWpfzkCCj
	5fCdyo1wNPKMNAtiu4/cM42HV34rGog=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-0ctanX7pNOeEAgENhD6fUg-1; Wed,
 10 Jul 2024 10:01:18 -0400
X-MC-Unique: 0ctanX7pNOeEAgENhD6fUg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFD49196E0A9;
	Wed, 10 Jul 2024 14:01:15 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.246])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7CBC19560AE;
	Wed, 10 Jul 2024 14:01:10 +0000 (UTC)
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
Subject: [PATCH v3 0/4] drm/panic: Add a QR code panic screen
Date: Wed, 10 Jul 2024 15:59:26 +0200
Message-ID: <20240710140057.347384-1-jfalempe@redhat.com>
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

Jocelyn Falempe (4):
  drm/panic: Add integer scaling to blit()
  drm/rect: Add drm_rect_overlap()
  drm/panic: Simplify logo handling
  drm/panic: Add a QR code panic screen

 drivers/gpu/drm/Kconfig         |   31 +
 drivers/gpu/drm/Makefile        |    1 +
 drivers/gpu/drm/drm_drv.c       |    3 +
 drivers/gpu/drm/drm_panic.c     |  338 +++++++++--
 drivers/gpu/drm/drm_panic_qr.rs | 1005 +++++++++++++++++++++++++++++++
 include/drm/drm_panic.h         |    4 +
 include/drm/drm_rect.h          |   15 +
 7 files changed, 1358 insertions(+), 39 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_panic_qr.rs


base-commit: 5a716b06b329bd2108c95a4f04c71bbe491729f2
-- 
2.45.2


