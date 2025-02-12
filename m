Return-Path: <linux-kernel+bounces-510811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A7FA3225F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978553A78CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3A42066FC;
	Wed, 12 Feb 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XB5vHdJG"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1B205AA0;
	Wed, 12 Feb 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352984; cv=none; b=UuheKSVBNipRSDdNtW9JmNcowMaoHY3BmboCVjRZvag9vpP8SFgATOt/EzT2125bGkaU0pgDHDWrz1imRSsOL0SA0M8L8SEaswuII7sOMpFY4yVfnmmzJDoeWTy1mSL57j6Ngs8NQdQCqNThziVF7fk/QcrEDcb1JDgQxbiHdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352984; c=relaxed/simple;
	bh=qGwBjM6FbmZGTEEQ4HnAUlJREAcryvTJECv+TVQ8dmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLw/xtNomVNrabFrjF4J8Q+uywGpDusJ/2hkobXO3QE/e0sPPnqKAaOXkZA0rMRTyhi76X1AcaoxUYU6I6q9aKQQ2sn2WVmZBoI7aiCktlDLII3SWS9jnyMWGQQmx1hJ30dF7KQSAW/taDloalxfPyXXsXIFtbqwYXewTDIFxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XB5vHdJG; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=sk//P
	HbsneId3/RrJkXkBvt5LOhcReSat+OU/V8Rlq4=; b=XB5vHdJGwBXy9rgHKzuy3
	3+kwqjaKuMiGvjI6VzROLhs3S+2vS4YVyeFY3ChcG9a3Ydbn2fldt6iMl3r/Z/H+
	aBHJ3CTTSftCAPtARBco5Y2gk270iHZI2K0Ovh4IY6eDhabg3NLGdn6RlgvHung2
	Zj7RuoQMGFyBSHCS2Z79V0=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBnG9Fja6xn14FuLQ--.33700S11;
	Wed, 12 Feb 2025 17:35:44 +0800 (CST)
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
Subject: [PATCH v14 09/13] drm/rockchip: vop2: Add uv swap for cluster window
Date: Wed, 12 Feb 2025 17:35:04 +0800
Message-ID: <20250212093530.52961-10-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093530.52961-1-andyshrk@163.com>
References: <20250212093530.52961-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnG9Fja6xn14FuLQ--.33700S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW8Ww1kAF4UAw47JFy7ZFb_yoW8XrWfpr
	43ArWqgw43Kr4Iq34kJFW5ZFWftwnxKayxZws7tw1F9FyagFyDKwnYkFWUArnFyanFka17
	tF93JrW7Zr1jvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFc_-UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqArxXmesZw5UBAABs+

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
index 4a9a397dc06b..80a15288b805 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1378,10 +1378,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 
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


