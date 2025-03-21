Return-Path: <linux-kernel+bounces-570718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53DA6B3DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D363A1F95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28181E8323;
	Fri, 21 Mar 2025 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wdldznpY"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D111F2AD0C;
	Fri, 21 Mar 2025 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533039; cv=none; b=u5HRSaxRhVg5+8RFgxfQMARDA/Vh8BFi7IXbEGReZTOJnlYpc0916XgnebEw8h67nY9Ndb+pNKS3VMNHoSopkkPEdrsUwixPdDkkK+VIO32t5W4IVDJ88Lvr9XEv54Uzs5M4/Rf6CrPBMrlJ2IPPcoWcg22AG8k+uLC12HOC+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533039; c=relaxed/simple;
	bh=ZzLfGaThpVKL/EzA44jAydOvzbqJW6+9uZ7fjskDpdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FgsvDGM2pajdAe+2nacTLdMPY2Q+uWtc7VIcgDvzBOWJ6Jq8WGgC6Ko/wpMGOtTkA0IOUiVgckbVfbdh7tXCwNNNDQpOj7HYOJZr+g4Yu9yMNvVL7LdH9cLFBfle17TCIMVqJd867RDLSk3wxJ7gXtHnIIsnVGmA8ay5NL+mys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wdldznpY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742533033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=34L65aDT1Mxo5imphoDQ1zuSM7y94ZYPS51yNey3ekA=;
	b=wdldznpYF2iprwYPpPpUcVtq+rR+oGN0324OYAyC4duKfwflwA0R0a2ypUbn/t8RmkVeim
	dtGoFMOAKsdhAuwEkqO8EGAb6YxdQxm98RSHhnnRpjBigGpTHZr748Hnqwx0TRq34BSiyP
	thMmuYBLCUM65wwbt9bbyyIruEkpnK7e3FDiQ5zYw8vKPBA5tNhVu1glcUn2kSzo0OagDF
	mBtC/J3cli2AGKchRoGcFc1DFZwdvU8UAMfDENH/KZxD5FqcX943+7UzyTVSHJjKWOT+Md
	lN8+3Ot572vHkBlrHcNT+jFsnYSaQTZIDOEzWCdRsAxIPk+PVqAdF0+H7HbISA==
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: heiko@sntech.de,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] docs: dt-bindings: Specify ordering for properties within groups
Date: Fri, 21 Mar 2025 05:57:09 +0100
Message-Id: <6468619098f94d8acb00de0431c414c5fcfbbdbf.1742532899.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Ordering of the individual properties inside each property group benefits
from applying natural sort order [1] by the property names, because it
results in more logical and more usable property lists, similarly to what's
already the case with the alpha-numerical ordering of the nodes without
unit addresses.

Let's have this clearly specified in the DTS coding style, and let's expand
the provided node example a bit, to actually show the results of applying
natural sort order.

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
    Changes in v4:
      - Compacted both the introduced additions to the DTS conding style
        and the patch description, as suggested by Krzysztof [7]
      - Reformatted the patch description to obey the 75-column-width
        rule, and adjusted the editor configuration accordingly, to avoid
        such issues in the future, as suggested by Krzysztof [7]
    
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
    Link to v3: https://lore.kernel.org/linux-kernel/7276139ea1f4a5f4db48c77f536a3638492e6c2f.1741321984.git.dsimic@manjaro.org/T/#u
    
    [5] https://lore.kernel.org/linux-kernel/20250305-defiant-serious-newt-b7c5ea@krzk-bin/
    [6] https://lore.kernel.org/linux-kernel/20250306-dexterous-goshawk-of-aptitude-e4f1f6@krzk-bin/
    [7] https://lore.kernel.org/linux-kernel/20250307-logical-nimble-okapi-3ba081@krzk-bin/

 Documentation/devicetree/bindings/dts-coding-style.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
index 8a68331075a0..d8a2b11cab48 100644
--- a/Documentation/devicetree/bindings/dts-coding-style.rst
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -133,6 +133,9 @@ The above-described ordering follows this approach:
 3. Status is the last information to annotate that device node is or is not
    finished (board resources are needed).
 
+The individual properties inside each group shall use natural sort order by
+the property name.
+
 Example::
 
 	/* SoC DTSI */
@@ -158,7 +161,10 @@ Example::
 	/* Board DTS */
 
 	&device_node {
-		vdd-supply = <&board_vreg1>;
+		vdd-0v9-supply = <&board_vreg1>;
+		vdd-1v8-supply = <&board_vreg4>;
+		vdd-3v3-supply = <&board_vreg2>;
+		vdd-12v-supply = <&board_vreg3>;
 		status = "okay";
 	}
 

