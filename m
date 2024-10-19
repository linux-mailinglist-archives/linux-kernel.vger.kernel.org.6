Return-Path: <linux-kernel+bounces-372705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 481309A4C13
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD366B22CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AED1DE8B4;
	Sat, 19 Oct 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="Vy+O6DGU"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3C38FB0
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729327275; cv=none; b=aRBHklHcarhRvx8Xji04OIlywssYykjS2N92PHDl0dic4uAqLhqUMp3LhvUNgs+uDw3rdcebX24+oG+wMdxokgE8lMlJJlLUr+t2tCuwUCaLzw/4buS0c4Mz3FHj5iBzWyFCohypo9D0p9dK+pUFwopPxmPCZVjeIXKUKZsYopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729327275; c=relaxed/simple;
	bh=6WkRiTW6hxrOkXkyZUPVV9ShUISdUKz0rcrZcsQkaX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=siPjYR+R5Szh/Wh7DbL7znYd8hWfWD3fcw7ABWtIJU9o1LVfi0GFLlQvu6uJcSPYxsj8w7HofhrlvA/kYi+gckyt9LSDCJBFPcu3hu0VM1KPkY9Z8g0bI7mS/1XcVD5UTz5RnrVKiKKsi77/V3PsnmZUvAcuIyo4uLBlqk6cKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=Vy+O6DGU; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1729327271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bbAs0TRfliKVT6GU9TEAPy0g/6tMD6uUNyQ5bBgcgz4=;
	b=Vy+O6DGU3TETIO1c+DK7b3WRhznZrucfviXFE9izV77hP7ZEQYbf3TTLkcEVCd6F3DGPGc
	mfr7VPWpXMJPVaTqQeEyE5nwUrMsz6dYL8KdA4DhibIf7rxcb06qYG0KXLZ38SV3cICsGr
	lVTz2nWa99Ao/ogvJqsQNk7VE9YZSH4=
From: =?UTF-8?q?Thomas=20B=C3=B6hler?= <witcher@wiredspace.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Jocelyn Falempe <jfalempe@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20B=C3=B6hler?= <witcher@wiredspace.de>
Subject: [PATCH v2 0/7] Cleanup Clippy issues in drm_panic_qr.rs
Date: Sat, 19 Oct 2024 10:22:45 +0200
Message-ID: <20241019084048.22336-1-witcher@wiredspace.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The file drivers/gpu/drm/drm_panic_qr.rs has some lints that Clippy
complains about. This series cleans them up by either allowing what is
written or conforming to what Clippy expects where it makes sense.

All explicitly allowed lints are marked with `#[expect(...)]`.

v1 -> v2:
- Add "Fixes" trailers and rename "Closes" to "Link" trailers as
  the patches all fix part of the issue.
- Replace `#[allow(...)]` with `#[expect(...)]`. Support for `expect` is
  already in rust-next, which is where this series will be merged into.

Thomas Böhler (7):
  drm/panic: avoid reimplementing Iterator::find
  drm/panic: remove unnecessary borrow in alignment_pattern
  drm/panic: prefer eliding lifetimes
  drm/panic: remove redundant field when assigning value
  drm/panic: correctly indent continuation of line in list item
  drm/panic: allow verbose boolean for clarity
  drm/panic: allow verbose version check

 drivers/gpu/drm/drm_panic_qr.rs | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.46.2


