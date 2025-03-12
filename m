Return-Path: <linux-kernel+bounces-557284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC51A5D672
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963153B5807
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB71E7C07;
	Wed, 12 Mar 2025 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="otuhekoT"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101741E5713
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761772; cv=none; b=V7qtO5skk6vvKUQkbx6QAQmtXAIPmq8+kn+rKM8q8saAihweDiAEbzqSGqub4ipC1r6lT8Eegb6os5MsRfVy7xEpfXKQP58m9S8KjuiW3LQZM9z+SBQfY0FtWHKjcYlAH6Ld0QHy3sLJsTHTKxVXVqOTI+TSOx1x5W0sQmsU86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761772; c=relaxed/simple;
	bh=BXxmNwAR3XD+Lwcg6vWkjZWpbgVFft4baYm+h8YFV/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQBAAjP0XvcA0XMW31esSn5hTcs0wWVN90R+N6Vd3aa6hXvHnv5NGGA8IqhbEV/gh2ttL3JfaEcA8h2F5SavU69JiX14PkMPMLdq4UbWDVVOYspd2i3STLQw8bjsAOIHQX/JPXidzm4YjZ9now4YVmf8u+jATkLt78x0KlMgTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=otuhekoT; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Y9A+G
	MGKN+/gUY1pm2Jf9qbSfuZPHc1NStiINtfiC4E=; b=otuhekoTwyJx+JqzGhknl
	/Iv7vVn5kEHxqjM52cwGzgtak+d431j79xyTzrismLDKslKWhSqlTn2MS2U1hNdE
	qYnxFLnpq1cDQLlFlXm4MJdqJO0UwhXd99Z+zVxZQ1jYNzw8O+d2KEc0SbRiX7Qc
	nMcy8ciC2LTSJWZfaSDNak=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAnro3MLNFnNsQBSQ--.34149S2;
	Wed, 12 Mar 2025 14:42:23 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	piotr.oniszczuk@gmail.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/rockchip: vop2: Fix interface enable/mux setting of DP1 on rk3588
Date: Wed, 12 Mar 2025 14:42:10 +0800
Message-ID: <20250312064218.524143-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnro3MLNFnNsQBSQ--.34149S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1rKFyDJrWUWr1DGFWfKrg_yoW8JFW7pr
	s0yryYqrWkKrWjvF1fGF4Fyr4SkanFkayIka1fKa9xGa48tr1kGr98Ja1kAry7Xr17ZFyj
	krZIyrW3uFW2yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbwIDUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hYOXmfRJTn62wAAsf

From: Andy Yan <andy.yan@rock-chips.com>

This is a copy-paste error, which affects DP1 usage.

Fixes: 328e6885996c ("drm/rockchip: vop2: Add platform specific callback")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index a8b1ebfc5af5..de2da4f4e434 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1753,9 +1753,9 @@ static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32
 		dip |= FIELD_PREP(RK3588_DSP_IF_POL__DP0_PIN_POL, polflags);
 		break;
 	case ROCKCHIP_VOP2_EP_DP1:
-		die &= ~RK3588_SYS_DSP_INFACE_EN_MIPI1_MUX;
-		die |= RK3588_SYS_DSP_INFACE_EN_MIPI1 |
-			   FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_MIPI1_MUX, vp->id);
+		die &= ~RK3588_SYS_DSP_INFACE_EN_DP1_MUX;
+		die |= RK3588_SYS_DSP_INFACE_EN_DP1 |
+			   FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_DP1_MUX, vp->id);
 		dip &= ~RK3588_DSP_IF_POL__DP1_PIN_POL;
 		dip |= FIELD_PREP(RK3588_DSP_IF_POL__DP1_PIN_POL, polflags);
 		break;
-- 
2.34.1


