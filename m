Return-Path: <linux-kernel+bounces-387923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E669B5805
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405B8B22F21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E1E20C33B;
	Tue, 29 Oct 2024 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iDd7BMEB"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95420E305
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245645; cv=none; b=syMUzXBJ0/7bBZ8lZ3Z6lQmWQjG+HiQWzXBaYTYu32M+0dyG1rz6VJLnuH4Z6feJurMHpYDeGkXhRsYhv2HuHBKuWAyUlTWuw6CjAAGOSeBGawLb9Rb5YMmXbVHd3IzpP37M5TSL4foHzeGlBf2nVDQ17ixuFcwMGRJ3s/cpw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245645; c=relaxed/simple;
	bh=AiHeHZWAnYMFpDYE+0wc7nsUQIrVtvSl/rrmUcWJu8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ln5a8tsP6yBNLJV6CAseKYOlV9LXuH4EHtFhpMEdCCm0gTxs4x/q+Dj5CgYtl6o3Vven/j93CC8DjEoI4Y8QM9csW7JvfdqpIxYQek7eA9IDSpc707umfK3EiPE/XSIo1UlITf7a1iJ3ZXIrNGXggPxpd/7zL+v4vFJ8VUTFyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iDd7BMEB; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=1SJ6WtqEW2HtW1rxlgiE167Eik3JoCGDIR36SiPLfcc=; b=iDd7BMEBogfD+Kg6
	C/RN9f1jFoTvsCJRmlMM5w8p67lFHyZuH0VIzNjkJc/j+PWEg3V8kOJIJMLf/x6iVmQzgfMCbS1Dv
	9+3LZEkffsOOSk+BBtqs4KQS7BBDLFtXdpuUGZKla1J0vJVKxfg8HsFUomSyfeaL4LsV9RJir6XWY
	6m4hy3EMeMQ6xOZ2x209ZxXbxbGKf4k1WW3dVFs1AYXBiIpyUONmyf3OzFLt5CFzPiNOOStCxUNR6
	N3dMALRB0tgkysXwnUi8zFynQI7M+cargSmG3UV7mKsX/6EP+b+Y5ZM3C69FHtPDIFXNdZTej/m8h
	IqGGa3NDcUb16lU3Vg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t5vvX-00EMNX-07;
	Tue, 29 Oct 2024 23:47:07 +0000
From: linux@treblig.org
To: dmitry.baryshkov@linaro.org,
	ville.syrjala@linux.intel.com,
	jfalempe@redhat.com,
	tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2 0/3] DRM deadcode
Date: Tue, 29 Oct 2024 23:47:02 +0000
Message-ID: <20241029234706.285087-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

This is a bunch of deadcode removals; the first two are
strictly whole function removals; the last as a revert
also undoes an extra parameter that was added.  It was a clean
revert.

v2
  Drop Remove unused drm_client_framebuffer_flush
    Jocelyn & Thomas have plans for it
  Drop Remove unused drm_crtc_vblank_count_and_time
    Ville thinks it might be easy to make use of
  Convert Remove unused drm_client_modeset_check
     As suggested by Dmitry, make this a full revert

Dr. David Alan Gilbert (3):
  drm: Remove unused drm_atomic_helper_commit_planes_on_crtc
  drm/sysfs: Remove unused drm_class_device_(un)register
  Revert "drm/client: Add drm_client_modeset_check()"

 drivers/gpu/drm/drm_atomic_helper.c  | 72 ----------------------------
 drivers/gpu/drm/drm_client_modeset.c | 35 ++------------
 drivers/gpu/drm/drm_sysfs.c          | 32 -------------
 include/drm/drm_atomic_helper.h      |  1 -
 include/drm/drm_client.h             |  1 -
 include/drm/drm_sysfs.h              |  4 --
 6 files changed, 4 insertions(+), 141 deletions(-)

-- 
2.47.0


