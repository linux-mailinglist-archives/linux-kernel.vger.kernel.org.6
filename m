Return-Path: <linux-kernel+bounces-411855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4AA9D0077
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148D81F233D9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E2F19939D;
	Sat, 16 Nov 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="obDQbAuV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2A18E050;
	Sat, 16 Nov 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731781372; cv=none; b=mwiCu5A7b0ZY/AJYOCjsPxUbtiG7V795pFM7si2WS70xx3+i30fJrunYvFnMHYGqJvQugB+7Ho0ckR/9WMudVbgECCz12QqZZoWK++mK12/meKN8IAXPHa2E/I/TquT9ePbEQf+ucZ/GPsBQkYbKubh9ayduPMNCZjYjgTnVovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731781372; c=relaxed/simple;
	bh=5yLL8RBABIDFFVGZv2n5kbkq6Ay3LOmlFo5JVggJqLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7J7I06HFbs9yPPj8+rnGfrSixnQAmmHmaeQUmeak7VzNx+2i7K1dxf6cmBfCZEM/wJ2TObwocQ14DqRptV4Gpo2IHPK6RQs4r1RNY9fVcgBTZbZMDSVfvNPNDOmnafjG/SjsJenTVRXgQFyx/TxAo4DWJieT4aUwXsiEMS4jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=obDQbAuV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731781363;
	bh=5yLL8RBABIDFFVGZv2n5kbkq6Ay3LOmlFo5JVggJqLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=obDQbAuVjSAgWb/fYXKu7UnT53UQHuJZrNXP58OgtW5qfw7iM46xBSBa5hFFjMG/p
	 pb4YEfKB2OJUnLL+YMOOBPAvb+dl3OogjrWUWZUIpQnB+hulCVj7HD4XqDOOPcmpZq
	 kQMMx9prBOzK29MeDzHYdwzc6ByIIWoQN0CX4HtJNk5/d8P11lGToLUFDbIc6/kDT/
	 HpQTaTiy1U/OcUpq7TOHgJS2e38LPC5xxrUAhrA0PwI81wjF3lEqWlG8xRiPG7YoLU
	 6fsK+qcmTuNlYavsyiXS/Y5fNCLioW1z7iDHrDPdBUh23GNA4o5K5Dqvvrr1mk4X1J
	 OP9Gz1mG2JW7g==
Received: from localhost (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A03417E377A;
	Sat, 16 Nov 2024 19:22:43 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 16 Nov 2024 20:22:33 +0200
Subject: [PATCH 2/5] drm/rockchip: vop2: Drop unnecessary if_pixclk_rate
 computation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-vop2-hdmi0-disp-modes-v1-2-2bca51db4898@collabora.com>
References: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
In-Reply-To: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The if_pixclk_rate variable is not being used outside of the if-block in
rk3588_calc_cru_cfg(), hence move the superfluous assignment from the
first branch to the inner comment-block.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 9ad025aa9ab0523c8807b331564c68da10c56c18..3e4c1cfd0bac6fa90f4cab85e27c2a69b86fc9aa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1838,8 +1838,8 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 			K = 2;
 		}
 
-		if_pixclk_rate = (dclk_core_rate << 1) / K;
 		/*
+		 * if_pixclk_rate = (dclk_core_rate << 1) / K;
 		 * if_dclk_rate = dclk_core_rate / K;
 		 * *if_pixclk_div = dclk_rate / if_pixclk_rate;
 		 * *if_dclk_div = dclk_rate / if_dclk_rate;

-- 
2.47.0


