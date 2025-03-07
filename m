Return-Path: <linux-kernel+bounces-550425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C350A55F66
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F6B1777E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D81953AD;
	Fri,  7 Mar 2025 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FTU3/ge7"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA01922E1;
	Fri,  7 Mar 2025 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322026; cv=none; b=JmyKITuI/LAZaBPSwJ5MA8ak4NFq0r3Z/DPUQZF/XNSCKpSHY6UGobI4S8woV5wDpiqFeUuYm7iEc0TiwmmTPTsTLoggFg9jWfdqsLNNk6iLH6ggzkFwCS9Kyr6sv5HXlbfioNTcqs2hZ+PsRqsPjIDSJd5hZR84hrBbbDpFHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322026; c=relaxed/simple;
	bh=yMU5TeKh7nrCLHPRsLuOwnfvtnkYg6ef6ucEdRhf9cI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pXK9HnEmukoxqLyMkUUtfTkR+8wyFkfR71vA5+aumXZyNhuAvdSeBJ/FPltMyxXWIJKjO3OESiKsJ87Fn/PW9vz+gKA2Zwe7uVtCBx6EspsbhqoEB56lWX3N1iyrtK1CDOR4SGrcl/bL9VZYGuAcmOqHgygLxhNqFZn1lvWz2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FTU3/ge7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741322022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l87+0jFmn8NRp9gpeByeTDhcGWohe97zZiVzox4NplA=;
	b=FTU3/ge7mpfmy7LtuB7uhS5/NabLSus98cV1xipUDqYZH+7GRRDX/8hZbM8vqhjxxacw2H
	EcpfGetWi4+HnAjlusmxRU4a2Scz5fWRXSy25HRxFUFhxeKuDk1utkVFIYhIqdoRzJ2G95
	PbivmglKNOhUBUdBX/ihqnF2DEp/VRKak/JC10t49tHIQEjFI2udjKP2EAqGUkOrvXI+8r
	F3kf6qJPst6E8GezQoNhWLr9Sf2ukbdkpl0R2qmmyi+BUQSF91gLLQcPT/bWocQXfHhzTm
	DEmB4XFlBHOXvvXWInuLtflEi4y3D3T8zV6ppupsoxipH7QQbxD1a/hQ0BGPcg==
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: heiko@sntech.de,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] docs: dt-bindings: Specify ordering for properties within groups
Date: Fri,  7 Mar 2025 05:33:37 +0100
Message-Id: <7276139ea1f4a5f4db48c77f536a3638492e6c2f.1741321984.git.dsimic@manjaro.org>
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

Let's have this clearly specified in the DTS coding style, together with
a brief description of the natural sort order for those readers who aren't
familiar with it already.  Also expand the provided node example a bit, to
actually show the results of applying natural sort order.

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
    Changes in v3:
      - Rewrote the part of the changes that describes natural sort order
        and its relation to "standard" alpha-numerical ordering, to make
        it more understandable, as suggested by Krzysztof [6]
      - Slightly expanded the patch description, to clarify the additional
        goal of explaining the natural sort order briefly
    
    Changes in v2:
      - Changed the additions to the coding style to specify natural sort
        order, which avoids amibguity, as suggested by Krzysztof [5]
      - Adjusted and expanded the patch description appropriately, together
        with including one more reference for the natural sort order
    
    Link to v1: https://lore.kernel.org/linux-kernel/09d6f2fc111b3d6e58987336944f93ec36b65118.1741071107.git.dsimic@manjaro.org/T/#u
    Link to v2: https://lore.kernel.org/linux-kernel/47c51c10098f089e52fb14c5c5527611dc8daf32.1741164239.git.dsimic@manjaro.org/T/#u
    
    [5] https://lore.kernel.org/linux-kernel/20250305-defiant-serious-newt-b7c5ea@krzk-bin/
    [6] https://lore.kernel.org/linux-kernel/20250306-dexterous-goshawk-of-aptitude-e4f1f6@krzk-bin/

 .../devicetree/bindings/dts-coding-style.rst       | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
index 8a68331075a0..7d183c1ade74 100644
--- a/Documentation/devicetree/bindings/dts-coding-style.rst
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -133,6 +133,15 @@ The above-described ordering follows this approach:
 3. Status is the last information to annotate that device node is or is not
    finished (board resources are needed).
 
+The above-described ordering specifies the preferred ordering of property
+groups, while the individual properties inside each group shall use natural
+sort order by the property name.
+
+The natural sort order differs from alpha-numerical ordering only by treating
+any single- and multi-digit numbers found inside the property names atomically,
+and by taking their actual numerical values and comparing those values between
+themselves to determine the order of property names.
+
 Example::
 
 	/* SoC DTSI */
@@ -158,7 +167,10 @@ Example::
 	/* Board DTS */
 
 	&device_node {
-		vdd-supply = <&board_vreg1>;
+		vdd-0v9-supply = <&board_vreg1>;
+		vdd-1v8-supply = <&board_vreg4>;
+		vdd-3v3-supply = <&board_vreg2>;
+		vdd-12v-supply = <&board_vreg3>;
 		status = "okay";
 	}
 

