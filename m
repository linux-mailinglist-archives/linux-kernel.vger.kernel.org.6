Return-Path: <linux-kernel+bounces-286943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E66819520A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7164BB26D97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3EC1BB69C;
	Wed, 14 Aug 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="gmxP+Q3g"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AF21BC06D;
	Wed, 14 Aug 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654897; cv=none; b=MRxh97yY8rIBnPlAjMHfBQV1hNmNaLUPt6cqKQUlDhTbwZzaqVHl8njWUn68yOm+5/+gAB1RS5Uf5oX2A7Mvxe7qejLZSFwEgufUUx+yVtz0byJYg2++6DluzYJfrzp8KYoacByAJ/cYNc/IrvT6Xafl7xE00FgjVcgyuSFO4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654897; c=relaxed/simple;
	bh=xvEWlAGjWOuN3MgtbMsNH5e+ZpaxGF+5lo3BiZBgJRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+2Yg5ntlU3k2oPxmNjGmMEdbxYFEzNF2+DnuGhNWJhZLlDk4erL1g5ez4z19teJtlaWjab3h+l3P6yVuccLV1Qbdj0AYnLFfajvqYZel0rGax3CqULydeXR1rui2qI74mJeO7EltGIMGOxkn8+hhmqO/CRpW59/4Q6pVpTjYBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=gmxP+Q3g; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id 2422F40460D1; Wed, 14 Aug 2024 17:01:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su 2422F40460D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1723654880;
	bh=xvEWlAGjWOuN3MgtbMsNH5e+ZpaxGF+5lo3BiZBgJRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmxP+Q3gPsylM4hiOn5vA/OUpPMgr1DB8e/9tVeURTTZzC3pZx8/S8iHsjeWC06Q5
	 VvvoB5ZGO2ZOasDixLme85XPwGho/OuD50ajCbBdgiBSdSadM4+uwP6bBTSdmw+xnx
	 RBfzw1NOMf/egnKr/grpPwxn/G15cDQmGSmi7xxvE6eJZcQdi68Vq7aHqfoWvqyAa8
	 t5XK55HFnH4WltRm/Es8foKiI+pwvSsPW7O42uD9HXqVl6Ma+1fZV7K3udWIP9mWMm
	 8b2LPeO0w6ZlXJ2CHzY4N5wOAgwxzH81DhWqhGAy8WRuDfc59sFirRqbwbctbQGlv6
	 k8PsBkafYplmA==
From: Sergey Bostandzhyan <jin@mediatomb.cc>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Bostandzhyan <jin@mediatomb.cc>
Subject: [PATCH v3 3/3] arm64: dts: rockchip: improve eMMC speed on NanoPi R2S Plus
Date: Wed, 14 Aug 2024 17:00:48 +0000
Message-Id: <20240814170048.23816-4-jin@mediatomb.cc>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240814170048.23816-1-jin@mediatomb.cc>
References: <20240814170048.23816-1-jin@mediatomb.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change has been suggested by Daniel Golle during patch review,
adding mmc-hs200-1_8v; makes sure that eMMC gets detected as HS200
which improves it's performance.

Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
---
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
index 12eabdbf8fe8..146b1da198b8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
@@ -23,6 +23,7 @@
 	cap-mmc-highspeed;
 	supports-emmc;
 	disable-wp;
+	mmc-hs200-1_8v;
 	non-removable;
 	num-slots = <1>;
 	pinctrl-names = "default";
-- 
2.20.1


