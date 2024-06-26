Return-Path: <linux-kernel+bounces-230039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A643091779B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A541C214FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5B13D28C;
	Wed, 26 Jun 2024 04:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NDvzdFfg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rdDcWB8l"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2213B2B1;
	Wed, 26 Jun 2024 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377415; cv=none; b=Kv8XmjHUz9RfFXvBJD34ie1vVqYCpUOF13kZum7U74hB5OmovUzUEM640NqcKmIBThqvP2T6wUOQIZc67dXktL6aERQQjdUw619Plj9xtbPWypi/3fg2PpMbz9x7WJKNy3DQ+TUmuOrKv1rHo1fvVmMcGvJusnsXWVJMFKNgBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377415; c=relaxed/simple;
	bh=JNT6n7gJQS1ekI8Tauqvdq8JctJu4XPq5pK/wqzf1n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8mnn/wXnudMQwpa6XFGdW7/VjAXnJxu0INZHPf5tfXuUNjbg9HBEqagMXlR8f0f5RPb86q3Ig+0dKyy8lAfK/j5JOmN5PkpFCi71RGPGU2JJNpji/Ji5lo72kgWvf/qwQ1IpNt/o8EXX6aEhPalou7KQnYhP38+kNPCBCKFIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NDvzdFfg; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rdDcWB8l reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719377411; x=1750913411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PyotQWY+vhDeX6zc3eagaZBEBtHJTWwRgB86lW0uB1w=;
  b=NDvzdFfgYVIrEFL3Yx1gkL8Kqxl24R+jEeZKjA9jaYDmtYfSkebrSHUG
   5QWT2Ydf9RN8yLxnAv3Hu3m6Mu5Eb5pBKCkyqtXEaxTPdh9DkCjBkudpK
   cNr/JoqvcWtnGz3HBV5/gJEZalJLvmreO70SaIyyNWYfWezH+s7Hplgfs
   JEH2mcerrEbrp23H8R2kGmVk/g9BPFoZ3RVou3XVEBeQ+CWCPDYkrISC9
   BMre/gCtg3QITB+Woc6ZcMWGJuxvY8DkF3JaJMq8Hcc5gV4qVxVdkK6Q+
   CKUnX9NBtoJF63qHPOWai5KiagxkcyYKKwTHKyufi33MhD4RhXpP0ELeO
   Q==;
X-CSE-ConnectionGUID: DLYO0bOJRn2SOU8zwygVtg==
X-CSE-MsgGUID: T0XYMbzOSD+5UwkLbT618Q==
X-IronPort-AV: E=Sophos;i="6.08,265,1712613600"; 
   d="scan'208";a="37587111"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Jun 2024 06:50:08 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E05AA160B1D;
	Wed, 26 Jun 2024 06:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719377404; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=PyotQWY+vhDeX6zc3eagaZBEBtHJTWwRgB86lW0uB1w=;
	b=rdDcWB8lWIRAgWyjinUmEWXwvz9SmJcSwajwy05Ce7f9lnN/rqniTBbeombDvIYH6V8Gxc
	JImMfVAnEtyoI6yTyrpO9F+nh1XATBvEBC0osYqXqtcln7+4d4hygY14t31F1Xgv5bqBsQ
	0DnZQbxSIQ+BH7i9aAGupoS8zZT12FuvoWWEigRD+//j4s/rsWdLThLP6yWAg34urpcAvd
	BNoahIUjyAz9pRX7TVfnXT+dQoGpPcafV+pVXq7LPRdSkFrTn3f7rOsI9dUtC2k2OBZwhk
	/aBka9jlMkGmeyuXXUzGYBJOoehgghp+OzfwVY+6urL2GwnUjv79D834IY9vYA==
From: Paul Gerber <paul.gerber@ew.tq-group.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Paul Gerber <paul.gerber@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: simple: Add AUO G104STN01 panel
Date: Wed, 26 Jun 2024 06:36:27 +0200
Message-ID: <20240626044727.2330191-1-paul.gerber@ew.tq-group.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add AUO G104STN01 10.4" LCD-TFT LVDS panel compatible string.

Signed-off-by: Paul Gerber <paul.gerber@ew.tq-group.com>
---

Tested on TQ MBa8MPxL with TQMa8MPxL.

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5067f5c0a272..8d75284845db 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -64,6 +64,8 @@ properties:
         # AU Optronics Corporation 10.4" (800x600) color TFT LCD panel
       - auo,g104sn02
         # AU Optronics Corporation 12.1" (1280x800) TFT LCD panel
+      - auo,g104stn01
+        # AU Optronics Corporation 10.4" (800x600) color TFT LCD panel
       - auo,g121ean01
         # AU Optronics Corporation 15.6" (1366x768) TFT LCD panel
       - auo,g156xtn01
-- 
2.44.1


