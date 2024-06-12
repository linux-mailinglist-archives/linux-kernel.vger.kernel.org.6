Return-Path: <linux-kernel+bounces-212177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C875905C62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA62628425D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9EC83CC9;
	Wed, 12 Jun 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lVUUBpWF"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433C381C4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222150; cv=none; b=ZQU6NMVvuQo8kO8/Hx6EkotrbO50AsyPRKTTFIdo9KelaqihDypbyWNbNBW688RV5f+5FtclxemYTqTLxVO+FBQLVsVVNt3wX0dkGHRsMecmVyQF/vJACDruNEm73ZzHLIyDshK0lgylsN9uYAneVA4n3xKnzvEAAgDxDQ/1SXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222150; c=relaxed/simple;
	bh=XJdyLcK8t8NoaJ10fulIo7C0zbtjGLK4RqYX+yDpnNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nh2xHrzP6Ca8a7b8wKDSv0eKfdhA4z0dj5fJ/31rl8w3u1+n2RbKM6EfFTfsly/UWnEPCvsEVLDLcHgp4dzHPY7EIND/KKp8V4E06lYSFqFuezn7ItXvOfIpznxUR7TDdb2oSIL0ST29XQzm1oC36bS34ZJHFHqhZhFHpt2wyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lVUUBpWF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IoIedJhtd8jVuc+UJluRtTNuNTSW0KI62AWD3MB81eQ=; b=lVUUBpWFqGBHwEjx3P2DuTZteT
	gHqtCj/eLyz6hwlWKxkQSA9OgXvOg1+RrrWhxOg+OP90UWr4U+nugCcJMZz6klcYK8LbyUafegAXa
	TCzZ+WQDBP319uGm+hd7fyEUKu/A4K+fUI+0WPdRJUu+hvQrpvRq9caBaUflthlZPbGjieaOZVYr7
	IF0l0IVKSUbj90imKNB6mOuftjHIi6oZ0V4aHrRh9eqbo4jErC1O6VidtAGR5sr7PLEq+6YKW6R41
	IER4xm1uLi3OwxhCLcIM1KiYxUtfaYTkAZorDlIyzC5WVKoQDTkuQht/fD2OKYxQc1q9q5UjpCAyc
	8iZ/HuMA==;
Received: from [191.204.194.169] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sHTmc-002RtF-5P; Wed, 12 Jun 2024 21:37:22 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 0/3] drm/atomic: Allow drivers to write their own plane check for async
Date: Wed, 12 Jun 2024 16:37:10 -0300
Message-ID: <20240612193713.167448-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

AMD hardware can do async flips with overlay planes, so this patchset does a
small redesign to allow drivers to choose per plane type if they can or cannot
do async flips.

It also allows async commits with IN_FENCE_ID in any driver.

Changes from v4:
- Rebased on top current drm-misc/drm-misc-next

Changes from v3:
- Major patchset redesign 
v3: https://lore.kernel.org/lkml/20240128212515.630345-1-andrealmeid@igalia.com/

Changes from v2:
 - Allow IN_FENCE_ID for any driver
 - Allow overlay planes again
v2: https://lore.kernel.org/lkml/20240119181235.255060-1-andrealmeid@igalia.com/

Changes from v1:
 - Drop overlay planes option for now
v1: https://lore.kernel.org/dri-devel/20240116045159.1015510-1-andrealmeid@igalia.com/

André Almeida (3):
  drm/atomic: Allow userspace to use explicit sync with atomic async
    flips
  drm: Allow drivers to choose plane types to async flip
  drm/amdgpu: Make it possible to async flip overlay planes

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 drivers/gpu/drm/drm_atomic_uapi.c                       | 4 +++-
 include/drm/drm_plane.h                                 | 5 +++++
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.45.2


