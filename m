Return-Path: <linux-kernel+bounces-276337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69BA949240
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912E81F2739D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC520FABD;
	Tue,  6 Aug 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Mr76nB06"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918A16B741
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952404; cv=none; b=oT4EDf2f0SaZ5tNRmRHlq5GdpjoFOkL495kcoX3Eyyq3NY3Gl29bX8TdtJc6RmgAEqtY828KGG0rh+4iOXNLsuQUI3DQ5hJRdZGBkXOExPnhO7gYkmtkWstpxYVMCmW44iW/sTesjKYdLAGD+e2dGWsTHzxGhR2Cq0EXLOE9g5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952404; c=relaxed/simple;
	bh=gND2bZM1lMXlIKqLm4B7YduypVXLJlqmOeeFIwQ3M6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gLriwLaP/rosXiaiXpfNBFflQckCowF5R0nfcNsSF3XBWfCzd2jZK9l+kqUddBZh+F8kUz5vXj1tziHs7/HlgEHMKJmIzy4TbPYYB14sCfvXKQFFhUR0ko81nRqx9VPqlQ7bznFRC/zttSb2s81JDSuBFip5BrGAZsla1hR/yeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Mr76nB06; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3LTBOgJDuXy2JwBI4zDANEzW9GrzludH0YUDes8GtkE=; b=Mr76nB06wQclSyKoqSrIkT4bMj
	OOgpRUmOKIE5K8IQGUaxR8U2Ue89TpXSxdT0t0LL0HAP3KJDI+995AnE8ngb1af0SEBLQhyErrMhE
	hjHW2leRMXsNA6TIA0yF5ulOg9hMTxwWkDA7/eicCWGkSVkuUg/PzILn6egqQuTDxpWJ5hpLw8A5Y
	kpZ3l/J+VEGTtCq4SoUubDju/SqTOjIteVVJcI6v6J6mcqAteBUARvIxjg1AzsJU0gfPFs5ZDK7bS
	hD0k7/fq/d7KEC7yKQkEOc9iplQjxdb6uYxO1eog0Y2XzBfZarNrOeWHEB5CIwMTXl0pFuIMA01tf
	5DgN82Og==;
Received: from [179.118.186.198] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sbKcd-008buR-1C; Tue, 06 Aug 2024 15:53:07 +0200
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RESEND v8 0/2] drm/atomic: Ease async flip restrictions
Date: Tue,  6 Aug 2024 10:52:58 -0300
Message-ID: <20240806135300.114469-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

As per my previous patchsets, the goal of this work is to find a nice way to
allow amdgpu to perform async page flips in the overlay plane as well, not
only on the primary one. Currently, when using the atomic uAPI, this is the only
type of plane allowed to do async flips, and every driver accepts it.

In my last version, I had created a static field `bool async_flip` for
drm_planes. When creating new planes, drivers could tell if such plane was
allowed or not to do async flips. This would be latter checked on the atomic
uAPI whenever the DRM_MODE_PAGE_FLIP_ASYNC was present.

However, Dmitry Baryshkov raised a valid point about getting confused with the 
existing atomic_async_check() code, giving that is an function to do basically
what I want: to let drivers tell DRM whether a giving plane can do async flips
or not. It turns out atomic_async_check() is implemented by drivers to deal with
the legacy cursor update, so it's not wired with the atomic uAPI because is
something that precedes such API.

So my new proposal is to just reuse this same function in the atomic uAPI path.
The plane restrictions defined at atomic_async_check() should work in this
codepath as well. And I will be able to allow overlays planes by modifying
amdgpu_dm_plane_atomic_async_check(), and anyone else have a proper place to
play with async plane restrictions as well.

One note is that currently we always allow async flips for primary planes,
regardless of the drivers, but not every atomic_async_check() implementation
allows primary planes (because they were writing targeting cursor planes
anyway...). To avoid regressions, my patch only calls atomic_async_check() for
non primary planes, and always allows primary ones.

Thoughts?

Changelog
 v7: https://lore.kernel.org/dri-devel/20240618030024.500532-1-andrealmeid@igalia.com/
 - Complete rewrite

André Almeida (2):
  drm/atomic: Let drivers decide which planes to async flip
  drm/amdgpu: Enable async flip on overlay planes

 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  3 +--
 drivers/gpu/drm/drm_atomic_uapi.c             | 23 ++++++++++++++-----
 2 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.46.0


