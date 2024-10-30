Return-Path: <linux-kernel+bounces-388335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B889B5E10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B539EB2337E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11E1E1324;
	Wed, 30 Oct 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PJShXk6Q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rlKazrdM"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED71990C5;
	Wed, 30 Oct 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277715; cv=none; b=TOXreLOiFyp0s7IRfTwGUQL5OsXu08RBvpOVlOrgxcdeaze0/mjv/Sk+dBX4flBlACgoj55hrxXUF8T7rKQHpAGy6bcEIRBjyRVORXhABaONgAz64Sn5ZiQY1vZ3/HovEPD9SvVQyt9YBgv+3zSTKTFRes1JoYt5eOYhR8ay3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277715; c=relaxed/simple;
	bh=4K/WP62uPq6V560IiCzhbH2c1uA7hP9SMx44NCKtD0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZ5gdnUoudfum4qTHRBc4QPNn5eTS/HGfHtY6UIFmIQWe3ZqWjneJZVQ7lxqsxWHcIuHXgxsors3QH5Z6GNoC3s2w86ZxKDwsExRSI1qgGmrIHQe/2PQ+yD6eizKIk1IfuYo6PCBUl+8tz1ciUiD4Gb9Rgv7TYIJHSJDsVLqx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=PJShXk6Q; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rlKazrdM reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730277711; x=1761813711;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kv28fZyUnvSoy7xLNeLLk5bmzedyTwjko9yL0PpBFlA=;
  b=PJShXk6QxFc03OoE0v+jR+q97hrplFVQ9KRYGvoXldwYqocId7Lx8PIu
   vaTarmV9MlJrQB4J2zPh3P7R5dJo4MHq4AB0tRYiWyJoP8WMwKI//WQpN
   yVeAz8WuhitcsCsK6/fsuaHEQg1VHwpDWzf3rlBXPuhupOVVsZv90nTRu
   K3Fxt0WUBTd5nNculXvKI3JA8E8S1krE2Pjz/feDT0pibTlkQT36QO7CM
   kKc5qsJmws5R+P2AxcGeA5wMZxtWtc34aKfzrK+QjMgd4tHzWsGMMgX13
   SSGGenYmK85AtAp2ySfERwj86QczO1c/ksMF8HmlZysQTwHquXnWyMQqI
   Q==;
X-CSE-ConnectionGUID: v0LiVWSLR7yMTkEUEYUWFw==
X-CSE-MsgGUID: NUhZCbb9SeCskmtMKAn52Q==
X-IronPort-AV: E=Sophos;i="6.11,244,1725314400"; 
   d="scan'208";a="39755780"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 30 Oct 2024 09:41:48 +0100
X-CheckPoint: {6721F14C-4-D31EDE1A-D52D6119}
X-MAIL-CPID: 61672B9E44BD23F5585782F3A78BAD14_5
X-Control-Analysis: str=0001.0A682F23.6721F14C.0071,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7994160F31;
	Wed, 30 Oct 2024 09:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730277703; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=kv28fZyUnvSoy7xLNeLLk5bmzedyTwjko9yL0PpBFlA=;
	b=rlKazrdMT7vl6dJMxpzGapJMT+rlSAnKUilGsMOxmFzH0t7ZtG/KUemS2lOgfRmA0MolXM
	BUF1eGSg+peSa/i0hbN81YtmkBZrYF0GEMBY+hwCZjGUzjrD2n3dRsRC6RQiUoVFu6vxo6
	Sinp8fEXV4uNSLuphCGplmxHCKuPwwx/9nS2HclaL7SJVj3j2IrzborRoRUhx1fJpK5tNp
	hfWYB/AyVrQew2D8KsAo9mHU+7ZpvP6xLpvhtGL2UmA24DYWFccpvP9KYdbEJDouPn0NK8
	5R2Wd0aPSc8QD3Ham80vFRXsDU/m5tjxayN3meO9TwT6V7J6UD1CxPQuztFTwA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: firmware: imx95-scmi: Allow linux,code for protocol@81
Date: Wed, 30 Oct 2024 09:41:40 +0100
Message-Id: <20241030084140.9704-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

BBM protocol supports a single power button, supported by driver
imx-sm-bbm-key.c. By default this is KEY_POWER, but can also be overwritten
using linux,code. Add a reference to this schema and add linux,code as a
supported property.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Admittedly, I'm not sure if this is the correct way of referencing the
linux,code from input.yaml.

 .../devicetree/bindings/firmware/nxp,imx95-scmi.yaml     | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
index 1a95010a546b1..112c3a3eb1980 100644
--- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
@@ -12,13 +12,18 @@ maintainers:
 
 properties:
   protocol@81:
-    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
-    unevaluatedProperties: false
+    type: object
+    allOf:
+      - $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+      - $ref: /schemas/input/input.yaml#
+    additionalProperties: false
 
     properties:
       reg:
         const: 0x81
 
+      linux,code: true
+
   protocol@84:
     $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
     unevaluatedProperties: false
-- 
2.34.1


