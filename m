Return-Path: <linux-kernel+bounces-377115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399709ABA11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4740D1C20FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7FA1CEE8A;
	Tue, 22 Oct 2024 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="mGuzYDRF"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716B1CB31A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639789; cv=none; b=kjcjNsc8UI7yVOM2R2DEbDjaIu2qR5qsMAQGlnffGYXPQNZQL9uWFwMCvpRroNJs8tqxeBN0G1Q3Ak4e+dbcn8O24RdfUg6f7WdTa6fuMmB0pYDKQjrzoKrRP+ymBlhrz/+lzM2sRdtUTMQFqMzzAtqeKhsiSfddC+lJ96sNv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639789; c=relaxed/simple;
	bh=ZJpxlsup7R93VCgQrTUG4yLfJXdm0xnTMjDmFnppocU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQsfOQ7I8basML4tELFzdivhW67IUwpqgDFLFpC7ervBWq0NwNTwdPqV/E7WsR5rBpo35WOlK/F3IyzpHss5LkTbGNL5qM3XH20Mx4hnyJ8ugJTgNZ09qNxdOLwBEBVv7IiPm4hVg7nW0YXRaGmSeFKElvoq0c9fTnQ7S2xcsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=mGuzYDRF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=mHrKY4OSTFuiDHRVzjLDtBvBzUfYqHv22XLr1Ipmg6M=; b=mGuzYDRFhxQ5doLK
	ztjIDPKfAAKhgvXUrhtjXJDo1Klb2lNikEdzF6zbVii8ThRBYrMRd1lnI2Q0q8b+H29XIyvVJXcxi
	VWZaNWVjfQH4Z5HurMBUroxDB6Gj4xvNgUxy0yzcUPy6Dt6RpommV1vvgs4dIwZHX5rcXbjGU7dSp
	YdlCZoiOBlI+9wCmoRQeznFQJsTQnfcKiNYeB3nnvk+42HK9n9OKOwZ9JDyGSD6izcUBTkRrxPT7P
	NTnlnaf34lSRi8d4b37jxCRt6AqbuIZNbUeTBF2mrqX4upWnkf1OH/Ikls787AL5sliDDrAmaxT8e
	M5jghRlH2m4P2cU97A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t3OJj-00CtGr-1Z;
	Tue, 22 Oct 2024 23:29:35 +0000
From: linux@treblig.org
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/5] DRM deadcode
Date: Wed, 23 Oct 2024 00:29:29 +0100
Message-ID: <20241022232934.238124-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This is a bunch of deadcode removals; they're all whole
function removals, no changing actual code or behaviour.

Note the last 3 delete functions that were each added (long ago)
by patches that explicitly added that individual function, but then
neve used them.

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (5):
  drm: Remove unused drm_atomic_helper_commit_planes_on_crtc
  drm/sysfs: Remove unused drm_class_device_(un)register
  drm/vblank: Remove unused drm_crtc_vblank_count_and_time
  drm/client: Remove unused drm_client_framebuffer_flush
  drm/client: Remove unused drm_client_modeset_check

 drivers/gpu/drm/drm_atomic_helper.c  | 72 ----------------------------
 drivers/gpu/drm/drm_client.c         | 33 -------------
 drivers/gpu/drm/drm_client_modeset.c | 24 ----------
 drivers/gpu/drm/drm_sysfs.c          | 32 -------------
 drivers/gpu/drm/drm_vblank.c         | 44 ++++-------------
 include/drm/drm_atomic_helper.h      |  1 -
 include/drm/drm_client.h             |  2 -
 include/drm/drm_sysfs.h              |  4 --
 include/drm/drm_vblank.h             | 10 ++--
 9 files changed, 12 insertions(+), 210 deletions(-)

-- 
2.47.0


