Return-Path: <linux-kernel+bounces-437509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2615B9E943C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8900416688C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A37E22A1F6;
	Mon,  9 Dec 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mMvkan7X"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4CF22A1D6;
	Mon,  9 Dec 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747573; cv=none; b=KL8JcszPhsDtVyd0Dkig74zkusFIKhZj3BigV0AcQdEr4PkWBOg00YgE834Ko61kgyHgVJHzIdVrkKO8oIwypZaYIMl9mou+HJMyyw8iC4o49ln0ZmAtSHDJqXjRpt9w458/VSIB2INwsWahIHi0HRpR5bOXPPJ+gA5NIjQLkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747573; c=relaxed/simple;
	bh=rJFy2TMRuAhKzSXmJkXeXU+q3gjqOkypGpjammhRXLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzUSIMIcIN5OWDlRFNuI/9Jlwg4hIwyZ0Ls8ZIWZWR6JOyoWu/CGbxKXB/r+Kh9b8PGljgGVZ8YuyfuQoJDBWmlq6at1KXHaHy+pPCAHmLYgsZuaqc38Xxhbws/MlBvAd+n8LihvHuzxyj8PB5lLmqkXl6V9TF2ncABMJ7iOZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mMvkan7X; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=74SCF
	EhyKUBw3QujU7m2Ujgf98W8fbRXMPY5M8M5yjw=; b=mMvkan7X9KHRjf/Ptn6XG
	jdUYzygfkjFLheJg/EJzkjZGrYiefty2e+xeXzR+z/cMY+M7ZjHbkDmtxJOeU/yA
	/v0KvJ3j2JAhUbiT13YjIVAsfRaaC5GBUDQ1Akzm131/c7+b/wr7yvLTbDXYxE7w
	OPX+DFqnuzUCzQSUiyETyA=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBHDaBQ41Zn269cMQ--.14778S2;
	Mon, 09 Dec 2024 20:32:19 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v5 08/18] drm/rockchip: vop2: Add check for 32 bpp format
Date: Mon,  9 Dec 2024 20:32:12 +0800
Message-ID: <20241209123215.2781721-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209122943.2781431-1-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHDaBQ41Zn269cMQ--.14778S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF45Xw1rZr1ktrWrurWUCFg_yoWDKwbEk3
	4xZw1fWrs7uFn8AwnFga4fCFZFyan29F4UGayvyas5AF1kZw10qayIk3yUGasxGF4avFn7
	Aayjqr1fuF13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU166zUUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqR6wXmdW3c3pJwACs0

From: Andy Yan <andy.yan@rock-chips.com>

RK3588 only support DRM_FORMAT_XRGB2101010/XBGR2101010 in afbc mode.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v5:
-  Added in V5

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index bd8db45eeba6..1f101a3c3942 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1224,7 +1224,15 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 				return -EINVAL;
 			}
 		}
+	}
 
+	if (fb->format->format == DRM_FORMAT_XRGB2101010 || fb->format->format == DRM_FORMAT_XBGR2101010) {
+		if (vop2->data->soc_id == 3588) {
+			if (!rockchip_afbc(plane, fb->modifier)) {
+				drm_err(vop2->drm, "Unsupported linear 32 bpp for %s\n", win->data->name);
+				return -EINVAL;
+			}
+		}
 	}
 
 	/*
-- 
2.34.1


