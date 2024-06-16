Return-Path: <linux-kernel+bounces-216516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C21D90A064
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1D628204F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787C73518;
	Sun, 16 Jun 2024 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="PpCGpp4U"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66212B2CF;
	Sun, 16 Jun 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718575068; cv=none; b=asOYomVeIWR094RsVbZV01dNRGW1qxkvBVave0WJxwbqRlDkPBoT7716jrPfND6DnvqgjT63tM68I3YtcDziSMtdqWF9FncaJPiEE1XoLQOWFxcuPnugHtk+8ZwT14f9nkF+KxrlI/FS+RhhY4C2iYvt/aaWLZE6J411bba2X8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718575068; c=relaxed/simple;
	bh=NDnVqJ9FGkPHAO/ppUMb+sjr00adaPZXyCz1aJvmI6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuRBG2JuTnWASMFvv0uunK1J6VqPZu5reDPf7pkeD6r638LbFevAwDmSOAKvJSDVi2JFcMEP+/7ssHytbzzKOtDcWkVKFSWhnQIoiGTD8MOYPNbwAe7K2t395v1aWC1YLmVajCAngEaFRZOj/QgNKLg5FPH2cRprY5xzE/Bv4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=PpCGpp4U; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout01.mail.de (unknown [10.0.120.221])
	by shout12.mail.de (Postfix) with ESMTPS id 30DC2240D87;
	Sun, 16 Jun 2024 23:57:39 +0200 (CEST)
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
	by shout01.mail.de (Postfix) with ESMTP id 13DF3240D0B;
	Sun, 16 Jun 2024 23:57:39 +0200 (CEST)
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
	by postfix03.mail.de (Postfix) with ESMTP id E425380226;
	Sun, 16 Jun 2024 23:57:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718575058;
	bh=NDnVqJ9FGkPHAO/ppUMb+sjr00adaPZXyCz1aJvmI6M=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=PpCGpp4UGqorTKnkY+cShBYgLD0uQxzwV4pxkCMQg9eS3cqWaEfjvGct5j9YH8mzY
	 7zjWODdv9684HXJ9yfpLG5boatbehBqK4c79zx25+5Topz6xaNb7/2VCS6HYDdz3sZ
	 xhBi9V2tXlvML+dmC7tgy6tifjmNcEGgF9H8dzlgs/z7dZip8Fo5kMd/Shxy/PCOr4
	 PzeIc2Z3AnW161ogSIaH4YRbrV+xZdFqJVAtxg5hXDAPRKW1I60d4elfDZ0M1F2+XC
	 qHdlb1ADmN5gO/kXlDJw/1wL3IBw4MdsWBdz9jWdHV4mJJSxdo7PAIBiuG4KqDVblI
	 5fqlIKWirXFBg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id CAF5C240A95;
	Sun, 16 Jun 2024 23:57:37 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add FriendlyElec CM3588 NAS
Date: Sun, 16 Jun 2024 23:48:29 +0200
Message-ID: <20240616215354.40999-2-seb-dev@mail.de>
In-Reply-To: <20240616215354.40999-1-seb-dev@mail.de>
References: <20240616215354.40999-1-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1146
X-purgate-ID: 154282::1718575058-057EB338-2B2D7613/0/0

Add devicetree bindings for the FriendlyElec CM3588 NAS board.

The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based on
the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 77469270b271..eca0a42eb384 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -248,6 +248,13 @@ properties:
           - const: friendlyarm,nanopc-t6
           - const: rockchip,rk3588
 
+      - description: FriendlyElec CM3588-based boards
+        items:
+          - enum:
+              - friendlyarm,cm3588-nas
+          - const: friendlyarm,cm3588
+          - const: rockchip,rk3588
+
       - description: GameForce Chi
         items:
           - const: gameforce,chi
-- 
2.43.0


