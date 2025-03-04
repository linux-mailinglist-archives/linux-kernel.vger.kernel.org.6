Return-Path: <linux-kernel+bounces-543310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68694A4D41F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B493AE07B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C35A1F55ED;
	Tue,  4 Mar 2025 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JSDZh5my"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E813C67C;
	Tue,  4 Mar 2025 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071292; cv=none; b=mXOLdzyQsJ1sSV8Ix0+WTpKyr2JBRW7lRcN9bBBstJBWOYrxXxcy03q/6DURIhzXmmaM9PJDbjjds37/bUE+RJygmScym6x3mQguV8v3qfW74S9n9ArqSJItm0utJjRgCUuInFv6NSHit8bDdD2ELiIv5kYFvExckhJ2D8w0aDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071292; c=relaxed/simple;
	bh=PZJOo2jkFpPSOOKfCsW24Q9wdMm475xu7XZoTyOtQFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dhYJrwCD6RuLeBKC3Q6ZhDqN3fbh4Cqb1PHAnQZ2jWbbwYINBeqtfOKExqmft/T6qKC1OEKT8aKXUMkasSL5Fu0ZrJY1Ah7nc4dL1I/c6WJrZD78vxbcAf1Fa4HPlP57WF4TOuYLcmkneLq4UAlERyZfoID9zei7lhMjbdTve0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JSDZh5my; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741071288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aafKtHHkAEBbntAJUzxVz9PQQQFksdjYPmu3KZGEX7E=;
	b=JSDZh5my1bMySMxF4bjjZPMeUVbWTp5KROw2uazUDj/AYP1Tmw5hi0KRvnY0zXOoln182G
	xoGAgbwWnoau1kWPRRLwXkk58sNrDw++Z9y3m0lSFuS1vrMwb3gibz6yGcJT7UCjChA+Sz
	ftOxQJ/bfFNH7RkNsd15di98ZQr+P4XO7H0RhcjewPjgpEXp+FVrCmMaAoaWtmSC4j1bGV
	53EMXt8TSiRkHjhI2evWATQTlEFjz0oNJSCocoXT1yihkqC4mXSWW/KfJfbn737o5F5Aro
	kYdYWpNRPCrnu4UIqimOMcmD/rPYyZ8Vw1a2hr8DVeHjcSlXo63KOuYIBVCuig==
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: heiko@sntech.de,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: dt-bindings: Specify ordering for properties within groups
Date: Tue,  4 Mar 2025 07:54:42 +0100
Message-Id: <09d6f2fc111b3d6e58987336944f93ec36b65118.1741071107.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

When it comes to ordering the individual properties inside each property
group, applying alphanumerical ordering can result in more logical and more
usable lists of properties, just like it's already the case with the
alphanumerical ordering of the nodes without unit addresses.

Let's have this clearly specified in the DTS coding style.  Also expand the
provided example a bit, to actually show the alphanumerical ordering.

Applying strict alphabetical ordering can result in property lists that are
far from optimal from the usability standpoint.  For the provided example,
which stems from a real-world DT, [1][2][3] applying the strict alphabetical
ordering produces this undesirable result:

  vdd-0v9-supply = <&board_vreg1>;
  vdd-12v-supply = <&board_vreg3>;
  vdd-1v8-supply = <&board_vreg4>;
  vdd-3v3-supply = <&board_vreg2>;

Obviously, having the properties sorted by their associated voltages in the
ascending order, which the alphanumerical ordering produces, is more logical,
more usable and more consistent.

[1] https://lore.kernel.org/linux-rockchip/b39cfd7490d8194f053bf3971f13a43472d1769e.1740941097.git.dsimic@manjaro.org/
[2] https://lore.kernel.org/linux-rockchip/174104113599.8946.16805724674396090918.b4-ty@sntech.de/
[3] https://lore.kernel.org/linux-rockchip/757afa87255212dfa5abf4c0e31deb08@manjaro.org/

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/devicetree/bindings/dts-coding-style.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
index 8a68331075a0..079d079f1ad9 100644
--- a/Documentation/devicetree/bindings/dts-coding-style.rst
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -133,6 +133,10 @@ The above-described ordering follows this approach:
 3. Status is the last information to annotate that device node is or is not
    finished (board resources are needed).
 
+The above-described ordering specifies the preferred ordering of property
+groups, while the individual properties inside each group shall be ordered
+alpha-numerically by the property name.
+
 Example::
 
 	/* SoC DTSI */
@@ -158,7 +162,10 @@ Example::
 	/* Board DTS */
 
 	&device_node {
-		vdd-supply = <&board_vreg1>;
+		vdd-0v9-supply = <&board_vreg1>;
+		vdd-1v8-supply = <&board_vreg4>;
+		vdd-3v3-supply = <&board_vreg2>;
+		vdd-12v-supply = <&board_vreg3>;
 		status = "okay";
 	}
 

