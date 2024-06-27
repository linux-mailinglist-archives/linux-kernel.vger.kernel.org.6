Return-Path: <linux-kernel+bounces-232028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A591A1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF019282150
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E570137930;
	Thu, 27 Jun 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZvqLWKEg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sZI7qpkL"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B0112F59C;
	Thu, 27 Jun 2024 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477921; cv=none; b=h6k4x0hm9h2Z/nLJecU1tZiUEeFsOXC+IdIN7H3trdF+PFfieT4YLl5rSOT2egLJ0MeGjscINHT7IDfUyexSDwUxHRixsATRGV9qw2fZDkr83sNMafAcFE3HC0GTHRVktqJ8Bk08LT565ZJms/Ia6J5dfbiCAiZiC+o1efPeKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477921; c=relaxed/simple;
	bh=eIiGiJfQ7ctVREW43dyly0CY0WIYCCs+bF1HNY8MHUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzNeAWX9nLhUx3sF0J2Qk1TKQqqfwn74sX1mjE/BU8CIcLfZibdvz5Oo1bcRbeaRNik9yMFt+08IQH9ao9clf+WfVyGmiGKcBii8Jpujr58YK4w99a3BGCvmoDY85S6Ej7yyyFibH21q68AiEAiQHhKPxPco9ag5pc1lUnPPUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZvqLWKEg; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sZI7qpkL reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719477918; x=1751013918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljUA2/gwMkyYm97U6fvrYnZuvtjIfdPE/kHZr8D3krA=;
  b=ZvqLWKEgvdpGVyQh1g8LT2CUIGF0wPJbOV9+DQjGNTSWKbH3rpnBQeYq
   vppcRJFQY6y8GrG0J570+H4J6+XXzw81F065lt+s1GiwWokmPjOtVDoCR
   HEU0L4zTePck8HgdnF0tMMzJbJG342zhRY96rB5XKxEXIV2l1P5wptdDF
   DUEO+S6IQWzHxpNW4DreGqULNFN7uJIQUToqidr1h5wHeYS8Dit2xq21t
   B/FTRGJoLz6toeiUVcGOBrk+n8YWAGTb8ZRtTfbPaXYg2EZi95LP7O4nI
   fKNy0j0bWj4WdXzy1TSqYTO/yaG2vYISwRpHnCjPv6t2miUFPHQ2xRx08
   g==;
X-CSE-ConnectionGUID: BadCDbIdSp+kDxdWH3aw+w==
X-CSE-MsgGUID: Ex8iheCxRImuvdAiDJbXTA==
X-IronPort-AV: E=Sophos;i="6.08,269,1712613600"; 
   d="scan'208";a="37617945"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 Jun 2024 10:45:17 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04DD9170D1D;
	Thu, 27 Jun 2024 10:45:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719477913; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ljUA2/gwMkyYm97U6fvrYnZuvtjIfdPE/kHZr8D3krA=;
	b=sZI7qpkLF65LHz0SloJPVbCBOnLq71PLIwLJFxHIU4m03tfWsbfXbpX/w80oBWz3HEHcD7
	h1/u6qZydSXZoj6zQ4343rS9O1c6MTroYqQ9+CS7x+8wWwSkR1j5sQwDi4TdWZOZ26YdiE
	onJP6FMnMCcNNVG8sMW6C6vv97SN3qWIS68AP0/HKMxiUhk/M+vLTg9s68QAxaeGWIlvUp
	CQ/T2GCXeo7aihd3VVJvPjpMQIS8R2rOV7XwaipdOXtzGQpKsmRtqylSbUxD+1wLtfJO3r
	rR+s7vGAOdiisZJ1lC5+1p9RVmKuoxMveBRMB/9qChj+LFihKM0NrYWFxZ1p2A==
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: display: simple: Add AUO G104STN01 panel
Date: Thu, 27 Jun 2024 10:44:43 +0200
Message-ID: <20240627084446.3197196-2-paul.gerber@ew.tq-group.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240627084446.3197196-1-paul.gerber@ew.tq-group.com>
References: <20240627084446.3197196-1-paul.gerber@ew.tq-group.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Tested on TQ TQMa8MPxL on MBa8MPxL.

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5067f5c0a272..a6eeb17040fc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -63,6 +63,8 @@ properties:
       - auo,g101evn010
         # AU Optronics Corporation 10.4" (800x600) color TFT LCD panel
       - auo,g104sn02
+        # AU Optronics Corporation 10.4" (800x600) color TFT LCD panel
+      - auo,g104stn01
         # AU Optronics Corporation 12.1" (1280x800) TFT LCD panel
       - auo,g121ean01
         # AU Optronics Corporation 15.6" (1366x768) TFT LCD panel
-- 
2.44.1


