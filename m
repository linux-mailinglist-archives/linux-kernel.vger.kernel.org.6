Return-Path: <linux-kernel+bounces-220929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601AB90E950
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FC71C232C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7DB13E03F;
	Wed, 19 Jun 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hVACol4f"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0CE13959A;
	Wed, 19 Jun 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796249; cv=none; b=IUBUhghJ2he3jP6LGNRww2OaHi71OH9lMwiA9fw7c5+1aVYQjeQPwcZmzc2+9AzIu505FJoaAIJAFon5xSrUrFEtYHIK9k4SlqGy4yQolfUY8nv7MmKj29SRUAu2XnVSVLmQcEEDFhuI/2CJqNIl3kQMIohnQxnvcWOpax1sQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796249; c=relaxed/simple;
	bh=NZn1OaraKPjXpPU/coZrv5VL2+1jqKHdG89pWwhTaAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bm85vtJmZJFBda0z8wo89GhtZ/M7Z52wsMjbrnGvq3ZLWLR+owBcJMIw7WX6ukcbKIGk3vEjoMrlIVByHVmsLVkKV1aVx9OK68vxvo+klqMeqKhr/Lf/vCon4ImXhWtm+oImG+Nyp/r42fWZfMfODfubgwHsgwQNXdaNirBpGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hVACol4f; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718796242;
	bh=NZn1OaraKPjXpPU/coZrv5VL2+1jqKHdG89pWwhTaAM=;
	h=From:Subject:Date:To:Cc:From;
	b=hVACol4fYBAhiMS4dQgvIk00SBbH93pwx/FeHOeOWx1K0ufTjjZDBF3Q4dX/xLjYT
	 6s5Z0g8/G0Z37jU2Lu9YnfZptdbNXiKBo+59XuFAxWbPmiJRcP6+goND9qgSOJCjCv
	 +AHo6EGF9EkvWQy2hSpilYOIlRT7enUZzaMwO7xMOBojFjEPzO06XJ9BJaqR1qCRE8
	 Fa39nieT/86STTrDDCFMXKHyf//HLkJgtM31h24PD05NfEU0ktmaMLF+TeSatBT/Vs
	 V7U54GM2ir1d9Ry1Dc4S4eiJiLJNRXpTlZYIrl7dm+lyRbluXXcoOgOt2Q9NtFj9uL
	 1aZd2lG4+aHLQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 20D8137804CF;
	Wed, 19 Jun 2024 11:24:02 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/5] DT fixes for Rockchip RK809 audio codec support
Date: Wed, 19 Jun 2024 14:23:29 +0300
Message-Id: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALG/cmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0NL3aJsCwNL3bTMitRiXcNUY2MDc1OLVMO0NCWgjoKiVLAEUEN0bG0
 tABjxT91dAAAA
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Furkan Kardame <f.kardame@manjaro.org>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

Rockchip RK809 MFD provides a RK817 compatible audio codec, supported by
the rk817_codec driver.

This patch series fixes a few issues identified by dtbs_check for the
boards making use of the codec: rk3566-quartz64-b, k3566-roc-pc,
rk3568-evb1-v10, rk3568-lubancat-2, rk3568-odroid-m1, rk3568-rock-3a.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (5):
      dt-bindings: mfd: rk809: Use correct compatible in the example
      dt-bindings: mfd: rk809: Add missing audio codec properties
      arm64: dts: rockchip: Fix mic-in-differential usage on rk3568-rock-3a
      arm64: dts: rockchip: Fix mic-in-differential usage on rk3566-roc-pc
      arm64: dts: rockchip: Fix mic-in-differential usage on rk3568-evb1-v10

 .../devicetree/bindings/mfd/rockchip,rk809.yaml    | 38 ++++++++++++++++++----
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts     |  2 +-
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   |  2 +-
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts    |  2 +-
 4 files changed, 34 insertions(+), 10 deletions(-)
---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240619-rk809-fixes-1e330758e1ff


