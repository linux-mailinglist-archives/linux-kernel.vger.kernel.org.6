Return-Path: <linux-kernel+bounces-546317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4AA4F918
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FABB1636EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523FD1FDA78;
	Wed,  5 Mar 2025 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="h8rhsKs0"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1431F4620;
	Wed,  5 Mar 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164346; cv=none; b=LK038X7EgVbAP0PPTHXC0Ppzs0AwFID1qWj/nUeW0ng5yl2tOvHa7QGKrG0jvuX7S8XnsJbRgkYcHrhrI0hMnMUDXhbhurEHBlz5B+EkPCtonr5gL6rDxjNXPhYm9TcjT+dGo7LBhJin7gAQBfYB4PY3tkAQ/VvNscomy1/vb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164346; c=relaxed/simple;
	bh=ByBwppToxDAngWQy+QkPd/KBlKvZGnAQgBdJDm2SZ1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VlDH3mDHOTTHP5vQiX38a84jMLwiekT4jLTB8gNq6e8GS4qBj2tKxu+0gtrLDrRobSaIoQ3Xrh5mViuNlrwsQtwJhKoihdNQykeG8sQqf5viBUTxyQut5dkynNqmOfKMOpEhO/HPDM4B/Jvgd/W8GGuZcj0XILjga8bz+pxjynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=h8rhsKs0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741164337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kiXyDCsvGdbUPFdP4dFELihQJtcmgCkV9HCP0y+H2rc=;
	b=h8rhsKs01KJUWnYlfPoDH0qi5atxR0Nmc2JmOZ/ptzDiuksWaclkOjRgPS2iFK0dAoGWp9
	bSsdmXS6kdxzSJc1DLw5x2X12WVlXpOun2GnBm3CXdYhWjzBcpu1RV4dt7y/y2XxXS/UD6
	xhGrZpbWik1fWhKfmI+9X4CgKY8AmuAoTHaGYa/HzCgwglaekxJ5sBhIo/LU2q1aX5TDXP
	A6du2JDlKnX72B6MFA9LXWv8JupfXcb5zRKLR4AfUfPZSJnKbCwXcghDrSzrmYs9a9QQZ3
	yQ1lJRizDPHWTwaAPuvudqnwKHSk/O5X64ZVHzOgevGmUQNAU4/A6o28XgOVyA==
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: heiko@sntech.de,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: dt-bindings: Specify ordering for properties within groups
Date: Wed,  5 Mar 2025 09:45:33 +0100
Message-Id: <47c51c10098f089e52fb14c5c5527611dc8daf32.1741164239.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

When it comes to ordering of the individual properties inside each property
group, applying natural sort order to multi-digit numbers [1] found inside
the property names can result in more logical and more usable property lists,
similarly to what's already the case with the alpha-numerical ordering of
the nodes without unit addresses.

Let's have this clearly specified in the DTS coding style.  Also expand the
provided example a bit, to actually show the natural sort order.

Applying strict alpha-numerical ordering can result in property lists that
are suboptimal from the usability standpoint.  For the provided example,
which stems from a real-world DT, [2][3][4] applying strict alpha-numerical
ordering produces the following undesirable result:

  vdd-0v9-supply = <&board_vreg1>;
  vdd-12v-supply = <&board_vreg3>;
  vdd-1v8-supply = <&board_vreg4>;
  vdd-3v3-supply = <&board_vreg2>;

Having the properties sorted in natural order by their associated voltages
is more logical, more usable, and a bit more consistent.

[1] https://en.wikipedia.org/wiki/Natural_sort_order
[2] https://lore.kernel.org/linux-rockchip/b39cfd7490d8194f053bf3971f13a43472d1769e.1740941097.git.dsimic@manjaro.org/
[3] https://lore.kernel.org/linux-rockchip/174104113599.8946.16805724674396090918.b4-ty@sntech.de/
[4] https://lore.kernel.org/linux-rockchip/757afa87255212dfa5abf4c0e31deb08@manjaro.org/

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
      - Changed the additions to the coding style to specify natural sort
        order, which avoids amibguity, as suggested by Krzysztof [5]
      - Adjusted and expanded the patch description appropriately, together
        with including one more reference for the natural sort order
    
    Link to v1: https://lore.kernel.org/linux-kernel/09d6f2fc111b3d6e58987336944f93ec36b65118.1741071107.git.dsimic@manjaro.org/T/#u
    
    [5] https://lore.kernel.org/linux-kernel/20250305-defiant-serious-newt-b7c5ea@krzk-bin/

 .../devicetree/bindings/dts-coding-style.rst          | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
index 8a68331075a0..15de3ede2d9c 100644
--- a/Documentation/devicetree/bindings/dts-coding-style.rst
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -133,6 +133,12 @@ The above-described ordering follows this approach:
 3. Status is the last information to annotate that device node is or is not
    finished (board resources are needed).
 
+The above-described ordering specifies the preferred ordering of property
+groups, while the individual properties inside each group shall use natural
+sort order by the property name.  More specifically, natural sort order shall
+apply to multi-digit numbers found inside the property names, while alpha-
+numerical ordering shall apply otherwise.
+
 Example::
 
 	/* SoC DTSI */
@@ -158,7 +164,10 @@ Example::
 	/* Board DTS */
 
 	&device_node {
-		vdd-supply = <&board_vreg1>;
+		vdd-0v9-supply = <&board_vreg1>;
+		vdd-1v8-supply = <&board_vreg4>;
+		vdd-3v3-supply = <&board_vreg2>;
+		vdd-12v-supply = <&board_vreg3>;
 		status = "okay";
 	}
 

