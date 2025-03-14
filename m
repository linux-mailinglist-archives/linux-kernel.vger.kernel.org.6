Return-Path: <linux-kernel+bounces-560606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACC5A60701
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C86316EB09
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE04110A3E;
	Fri, 14 Mar 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzvmish0"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA133C2D1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741915236; cv=none; b=cygYpFG3Yl3mhmMeTzwTTHWcVqVCJBjwGzIq6UmEub106ZFGqvhyWfoJe+E9JVZ7+prD/mRqUn2mcWTIpYcaPOoNMphpzX72cO0MDo7sWM8w6qbV07yEikHorTVNi0gWFSzZX+Z/WNTxE/Rm3/KA+KBz2z6hnv9ZLfTBURzhrrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741915236; c=relaxed/simple;
	bh=muRcBqlYjNJn9C+Xi6e7cherHhMZOwbSRv+KvT3q0Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lpM8T6P3eaBvIKl4TNWxZrmyD9fgy8CYYvfuYLaPx4jcGITIu5nXImHa1Dzvx6H+2dueKFTfvTBKectcV5ih4ECnaH8UTlakiMssJya9iAtLnrKiHId0E+9v1hNYum7CnGUbEfRnQCgFq8SLp8fY3yOm5ofC9uRUysOa9tiEztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzvmish0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3d8e51bb0so17672285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741915234; x=1742520034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RyOfs+Y+zXnQN7nD15L11CcONhA3EYNbvNV/ylslsk=;
        b=Tzvmish0Hk+06qsQRxfik2iGDZiJC11WIS8kciXbKJ3hZiPOnFxDWB6ooRc7wB5LG5
         emqF+r0K8F8Fllt8zBiV/PxvMdGlNPPkQLYEE8v8cTYFlI9z6Mw46w/ILyH8CRwx8q5H
         re5DU9Nv7DrwVyDDFA0Djq1PlIEoHfGu1DEbwqDHM3IkMMmINQ3zwcXrOCYqjdCXi5J5
         S9h/NWbNXP9RSdcCgxOvQQi2fXtwb59+R5+hm8Z5njpcyJXSMMR1KaMa81KALPeG60qj
         lUGNLNQ571ekNIaucCXYxoMAWTaqLWLUkTMpW6rwsywxDyoycpTkRqZ0muylcvbrH/uL
         /poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741915234; x=1742520034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RyOfs+Y+zXnQN7nD15L11CcONhA3EYNbvNV/ylslsk=;
        b=ve36Oq7fm1pQIJm3S8ScP/0c7jO+AnaYsCg0hti0VNmulo4VSfjQ65BktyVouN9MOA
         bsP6SQ1nzG9hmYzf/420SBtbO6C7VbOG8P41WvZanl6xftU4G8FF+VpOiAjp0ugzzyI5
         2hMArWDYV/8Gub3iK3cSe1gai79Ta3fNQND0RFpSLDuMhwgtN3a2Hafj0fjGSM2nlCP5
         IA86nluQllmnLYsQdGSyqHyIEv5l8n6Xdc7d/uB/EOvZvjg3Kbmb7BXv050+qemjowku
         TWlrtmxzt0YM1AQ+ohWXxSb6nrshSRbj15mCHXZasUlOCaA8RvYQsABclpR73T2qNzcz
         aZyg==
X-Forwarded-Encrypted: i=1; AJvYcCX31ED3tErxFBtZbXQMTrhWeCClaQAPetA2yLdgAHPxGNi+v4xy4A7a6rkrYnNqMZPoDy2oqEhayHuRWRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdDBNSFOrkea7YZYyyID+8PxG4ggpRXMo6WFIVEpitwInB9HE
	gEOfOOKnjZVhSIEdhMdb8vE/g76xXijPDDpgf5gOxWsfK3JE9eo=
X-Gm-Gg: ASbGncvk6UlhAF2bmgSu0L3hx9GMEYyYZMjAjJKxmdCNVZzwYnObKtgUqlb4cdcP+NJ
	XHnoyQB5uKOoa1UvPKA2P8+LWhfiqZFQGAjY2hQrrTJcWxv/4pGBGGhjMMkURMTbW1aFQGu4Szb
	4cbhHKgGvqYl49pTAxvR/OvtQXGSHHJZdMV1KHf6uZjOySzul1Sl7ugxhsU9w6dKVKSeuUrYwc0
	TRmsF5Qjvc0uM6zmIGziUisi4oJb/OvEXavYf1r0LKwsHlVhVJXdwIIoktFW8Tva0nezZWexY9a
	F96vSGRloBA6AuQSA3vYsMTnMDlLEyTqBskYseTqbQ==
X-Google-Smtp-Source: AGHT+IGfhPTAxaf8B75RLgjVfZQ9MQSuBX9YLluLR5rXcZosHQPraRrM7+8ySbbt1uADkGdyWm5Dew==
X-Received: by 2002:a05:620a:440a:b0:7c0:a898:92fd with SMTP id af79cd13be357-7c57c930378mr23367385a.13.1741915233700;
        Thu, 13 Mar 2025 18:20:33 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c719f8sm171847485a.36.2025.03.13.18.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 18:20:32 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: mripard@kernel.org,
	wens@csie.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	neil.armstrong@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] drm/sun4i: backend: Fix error pointers in sun4i_backend_atomic_check
Date: Thu, 13 Mar 2025 20:20:29 -0500
Message-Id: <20250314012029.668306-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function sun4i_backend_atomic_check was dereferencing pointers
returned by drm_atomic_get_plane_state without checking for errors. This
could lead to undefined behavior if the function returns an error pointer.

This commit adds checks using IS_ERR to ensure that plane_state is
valid before dereferencing them.

Similar to commit da29abe71e16
("drm/amd/display: Fix error pointers in amdgpu_dm_crtc_mem_type_changed").

Fixes: 96180dde23b7 ("drm/sun4i: backend: Add a custom atomic_check for the frontend")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 2dded3b828df..a8e0e2123764 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -490,6 +490,10 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
 		struct drm_plane_state *plane_state =
 			drm_atomic_get_plane_state(state, plane);
+
+		if (IS_ERR(plane_state))
+			return PTR_ERR(plane_state);
+
 		struct sun4i_layer_state *layer_state =
 			state_to_sun4i_layer_state(plane_state);
 		struct drm_framebuffer *fb = plane_state->fb;
-- 
2.34.1


