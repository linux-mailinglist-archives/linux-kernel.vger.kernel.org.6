Return-Path: <linux-kernel+bounces-238394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6428B9249E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E1A28503B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D13201278;
	Tue,  2 Jul 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qQ78uiQB"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76422201249
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955348; cv=none; b=ao/7kMBTdnyoJ3uUHa5GweTpgZHLmztH2jKDcWGPiul8lEDhJ8oICIKI/zmdsxxU52ilHmiDqxhnVetfWIqUxhakNOWl5dwC9duGUMSiWW2MKiDdXp7kqmr5RyEHdJlRbY+Md70SHooD9S6WK1wr8NMWjcHhKFjPXVZuaTqItQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955348; c=relaxed/simple;
	bh=rW08zbvaVf0S+FX9kQCM600O0W8PCd2bhCwUVMO5du4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X73xkMcQe71rQ+voTgwgSvlDS69FPd3nsD9Ap2rYuOftqXIwxDmfZ42CqDgfPYHmMo6bjb4vUN2JmKgyzIGVFWlvYUhWPTmAvTDuxgVk4MGVqOnJ2TryX4KCiW0MF3y2va/kgPfU3Ga3Nbos118GYT8VtA5E8qLE1hsK0/Swucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qQ78uiQB; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lYJrMUtFB7T/61Iu3qbyozanTpUcRrqLqx5pmijl8ks=; b=qQ78uiQB1RiBv+e/XeTq0NKVB/
	SdYTBVCWk2QQHUn8laeaj/kxMHKSKtHkp4yj0g4M4Gb2Kznz86H0mICuuPUOktzh+WJla/LKMSzPK
	rjZzIZMSaK8769LIO99aKpUKoGbp+74X4DrRfVwBCkIjsb9NfYw5wyOKmxDD7BNHbaoNwueW/jw+m
	+wWvzOcChFFisjH08L97vuD049xnzl3TlG4n9n44U+qacHNonMSEIZ1MBK7kD9YuuaDvEKHwYv09K
	t6S5RJLX2K/qu89ffQT7PyrSM82EhpgMicXGRO4Imvzz+hMzyGxn0EYNSSM1GDHB05JyLiX2oNeY0
	NFq5rULg==;
Received: from [191.19.134.16] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sOkxC-00ASeG-JT; Tue, 02 Jul 2024 23:22:23 +0200
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
Subject: [PATCH v2 1/2] drm/atomic: Allow userspace to use explicit sync with atomic async flips
Date: Tue,  2 Jul 2024 18:22:14 -0300
Message-ID: <20240702212215.109696-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow userspace to use explicit synchronization with atomic async flips.
That means that the flip will wait for some hardware fence, and then
will flip as soon as possible (async) in regard of the vblank.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Simon Ser <contact@emersion.fr>
---
v2 changes:
- Add r-b

 drivers/gpu/drm/drm_atomic_uapi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 22bbb2d83e30..2e1d9391febe 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1070,7 +1070,9 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip && prop != config->prop_fb_id) {
+		if (async_flip &&
+		    prop != config->prop_fb_id &&
+		    prop != config->prop_in_fence_fd) {
 			ret = drm_atomic_plane_get_property(plane, plane_state,
 							    prop, &old_val);
 			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
-- 
2.45.2


