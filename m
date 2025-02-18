Return-Path: <linux-kernel+bounces-519276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE8A39AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D273B3A7F50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8EB23ED6A;
	Tue, 18 Feb 2025 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WM9ABPes"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0523C8BD;
	Tue, 18 Feb 2025 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878193; cv=none; b=kkX3wB9vT9ILD/reyJtvz9zNUQmuvHvK0vQuYI7lv4tDvfAAcaX1P3slUpMEXovswrRFnr5BKn5csSPqhZSN447UVY4riU64PT1Ba/2WhVxOfM37M87b+tAYc5IMHEyI84Fsky9L6tc5MON79PgTg424Va3tlKh6ZrjRGcr0hNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878193; c=relaxed/simple;
	bh=95Jws2JSVAfjnpVJZCx6RsAqdDalRl913pBS+c/b8p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dii5h2Mk3GPNPhGOX98Te+MMi5XCCT0QDxyHTRRxNXIRYjruFdSRA/EL4Gj0tTa/+IdRIGf7s7peNILAc4Gre1avL7ZFpnKo0Yzag1CnSIkl9z62Ry45HCq5boYhLQEhlJiE4ACDyiaAdu1huauRtOBc5U7vOLtSm+WJQax63jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WM9ABPes; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=QCVLZ
	Vwkqxt+Z5qrKlu5ExcWoG+pU3WzCGMehfenaGY=; b=WM9ABPesh1s8FY4Pv1cQo
	TlvaWQsfpsaw74TVoMgtDOsFySvnVZ/iC3Rqe5dgeClIE4iKQj4HpgmgsqGCpz0i
	PDaipVIFKv360q5Sjxz8y1Q5Sz0raU1pspNNg3VcruePr8VyrojdbIy2uU1E0Hpy
	yq5lfz1wXmVAcCmmprknI8=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD333uybrRnLIPUMQ--.34107S11;
	Tue, 18 Feb 2025 19:27:58 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	daniel@fooishbar.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH v15 09/13] drm/rockchip: vop2: Add uv swap for cluster window
Date: Tue, 18 Feb 2025 19:27:36 +0800
Message-ID: <20250218112744.34433-10-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218112744.34433-1-andyshrk@163.com>
References: <20250218112744.34433-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD333uybrRnLIPUMQ--.34107S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW8Ww1kAF4UAw47JFy7ZFb_yoW8XrWfpr
	43ArWqgw45Kw4Iq34kJFW5AFWft3ZxKayxuws7tw1F9ryakFyDGwn0kFWUArnFyFs2kF47
	tF93JrW7Zr40vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOgAwUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBz3Xme0aMptrAABss

From: Andy Yan <andy.yan@rock-chips.com>

The Cluster windows of upcoming VOP on rk3576 also support
linear YUV support, we need to set uv swap bit for it.

As the VOP2_WIN_UV_SWA register defined on rk3568/rk3588 is
0xffffffff, so this register will not be touched on these
two platforms.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index cc46fe2dc188..ec3f49ef03d1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1377,10 +1377,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 
 	rb_swap = vop2_win_rb_swap(fb->format->format);
 	vop2_win_write(win, VOP2_WIN_RB_SWAP, rb_swap);
-	if (!vop2_cluster_window(win)) {
-		uv_swap = vop2_win_uv_swap(fb->format->format);
-		vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
-	}
+	uv_swap = vop2_win_uv_swap(fb->format->format);
+	vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
 
 	if (fb->format->is_yuv) {
 		vop2_win_write(win, VOP2_WIN_UV_VIR, DIV_ROUND_UP(fb->pitches[1], 4));
-- 
2.34.1


