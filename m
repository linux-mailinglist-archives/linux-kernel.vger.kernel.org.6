Return-Path: <linux-kernel+bounces-168987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3148BC09B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9D1C20E57
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AC821A06;
	Sun,  5 May 2024 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="SvRiPwWl"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A52C69B
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714916520; cv=none; b=W3Drg0ejKnO+TQxVDhv2HQSqOq9kM/wWs52EO8AjuVnSRKaXIBmYIHGzEPCLhG2geYar4o2JFxJjY1wmkojT0+DmKAIK6m8Ll2RbuWwc2dSpz3tZ9DrxZMq/bY9Gc+QaNgXcYmN8udASkXdReyvMPxeyHoRGNYzVNxrujfi52ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714916520; c=relaxed/simple;
	bh=vMHAB25GpqSX2vx/lPuSzrghl2AT8AicEvffckrntFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8DZCo9M+Sg36DSfHdFMXYbA/B0tNnFPy4Ut/FXOfvP+a3KgpSbOQff79poep7+D+k3rvje3qzuOTPu4djxQOeN6I43doDyLGPl1mzjkSs4IqZGW4b/6ae+OlaY+n+yAXZCVXFFra4OH2v64FWoJoqVbikGN5i1oixqJXq7VzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=SvRiPwWl; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714916492; bh=eTFSF0qSsxOuDHS34o+hgy93ZRL8a/aPI7xKAOuylBI=;
 b=SvRiPwWlI7y1OmkGt714c5P9kk/l/zL04V4apKKsdYa22MbHeMI9cdW109eR6Fe9Cz974xciv
 VSc6NApbV/jg48nsygdzzB8+rP9ak+ktbQXZD7sqyG/ajwts04zW/XA3cuV8Y/NiOdMLJ7jqMD3
 yUMKJI/E9KayR1IxaoP7GuEDieyScB5mDWLNeZyaEjfneHR9QfUc9y6I+Xqkhp7QgpwBa+UT89a
 bU8xTgHKDqvH1gqh4BHoYiARCOKE8TTJlNadUIl8fciDgNakZYt6pLA+2hyQZo7R2Wop2jRjlCy
 Lqh1v1CMWQVSVJ+zCOWhoK/Fd42DrooUYJUunXyYbdrA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Chris Zhong
 <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/4] dt-bindings: mfd: rk809: Fix vcc8 and vcc9-supply description
Date: Sun,  5 May 2024 13:41:11 +0000
Message-ID: <20240505134120.2828885-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240505134120.2828885-1-jonas@kwiboo.se>
References: <20240505134120.2828885-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66378c8a57f92010457d687e

As can be seen in the RK809 datasheet BUCK5 and SWOUT1 share an input
supply, vcc9, and SWOUT2 use vcc8 as the input supply.

Correct the description for vcc8-supply and vcc9-supply to reflect this.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index 839c0521f1e5..c951056b8b4d 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -78,11 +78,11 @@ properties:
 
   vcc8-supply:
     description:
-      The input supply for SWITCH_REG1.
+      The input supply for SWITCH_REG2.
 
   vcc9-supply:
     description:
-      The input supply for DCDC_REG5 and SWITCH_REG2.
+      The input supply for DCDC_REG5 and SWITCH_REG1.
 
   regulators:
     type: object
-- 
2.43.2


