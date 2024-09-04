Return-Path: <linux-kernel+bounces-314978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FD196BBEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD472B29BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D161D79B6;
	Wed,  4 Sep 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="bJQ1H1Z4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EgJLm4Vx"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C11D79AB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451561; cv=none; b=jH6FRodJffhWKYZSyILn1LecuDKaOF2KyTaQY3CNw4YGjAxofRIlbAIFNJ3WcJkfEyPPzTvZLJaeYBl3PTro0IWgp5zRJKzlCe6qXQz0/ihSnWzOiwo7BeGBVrof02LNNOAwVMBny8xykFRB+8kPH2DzDfsgXMZIt9SaQyEc9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451561; c=relaxed/simple;
	bh=E4h9qsNrJ8M137jNpq8WTl6WEVSi3n2g6BF7Wk7xzkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b3c8oMxd3M66+I2nFzm8GimY32UmrcswCzCwEv+ldhi9625FsUiV+qeEqgxIvVcUVOeJARwG7KXl6fVtJNMFkisAxieRQ05IvRDYdAycbOOX4ZqqW7kI+qQlQE8X2YdNe4xXuh5TZpsYpak9VGS90Qo5UKZsDPKwTT2qNPFaT0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=bJQ1H1Z4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EgJLm4Vx reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725451558; x=1756987558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LEo9NT2QaKp6ysjNqC2FOKskz54S/7F7786D6T7+EQQ=;
  b=bJQ1H1Z4u38v0xG3C2eSEr1T6BMLlUYY05GwJA81WVDgd22UXgUDstTT
   ZNgigGOnGPHcGSw+BhA46RvZsBjRFaxibozyyzFZVBJDN3pd5SR7pTIw+
   9L09gW/TxhIwklMcuyUcy/fhRZUFtjVtvdwUH28kqNVD1kpulIvhwESY6
   iv3TNrb+bMiq6macRHz4eUE2rwO9aLXla1XGw0vv+H6Wh/13Vl1shwCgR
   +1Q+5tO02fhC7PpqeuJnJcJUM0feFqjPjnlooodCs4bQEf1qPTYLmqovy
   CLp0k1Ex34r80P74ng6UFo0K8dpefL7ZNvbFSYf7GeAkoPZi3mR7SNMtn
   g==;
X-CSE-ConnectionGUID: gKxJkwfTQDul0yhBz7vS5A==
X-CSE-MsgGUID: puiGMuJhQkOBejqwzBjtsw==
X-IronPort-AV: E=Sophos;i="6.10,201,1719871200"; 
   d="scan'208";a="38762440"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Sep 2024 14:05:56 +0200
X-CheckPoint: {66D84D24-19-C661815F-E221238E}
X-MAIL-CPID: 92D548C943CAB3188E965922A18E2939_1
X-Control-Analysis: str=0001.0A782F21.66D84D24.00AE,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09BF2160024;
	Wed,  4 Sep 2024 14:05:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725451552; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=LEo9NT2QaKp6ysjNqC2FOKskz54S/7F7786D6T7+EQQ=;
	b=EgJLm4VxF3jMOklz0BCV4TxcieAXJYhG9gsIFAfKx/74oVGFHOfPntTEHCNw4kf9nNh2/5
	Utm+8MxE6xtQF8++Oc0ZQbxXT1spRolCa61bsOoYwa3C0CacYCeC74+BhWF+7j541Biq50
	6tWJYu49020tBjI/h5Z8rGhKuRljegqR/+qmzE9xmxkNETwwBRfeb6P1QItjT703Lu26BW
	ImoA9xSv11gNk5NXF1QcWKowAJ25MPcouMMDxZEnXD+IT3TpE9wu8nv9OCjP2yu+CIGTCz
	xkyEEF0bGOY/w+x6rlYIdcMz8H8eYPbQpXZfLRJryCLcs9moxFHY1Jj/iBon9w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Improve tc358767 debugging
Date: Wed,  4 Sep 2024 14:05:42 +0200
Message-Id: <20240904120546.1845856-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

this small series improves debugging the tc358767 driver by using
dev_err_probe for additional information (patch 1) and print IRQ
debug output only if hotplug status actually changed.

Changes inv 3:
* Collected Robert's and Dmitry' R-b

Changes in v2:
* Added patch for supporting write-only registers

Best regards,
Alexander

Alexander Stein (3):
  drm/bridge: tc358767: Use dev_err_probe
  drm/bridge: tc358767: Only print GPIO debug output if they actually
    occur
  drm/bridge: tc358767: Support write-only registers

 drivers/gpu/drm/bridge/tc358767.c | 56 +++++++++++++++++++------------
 1 file changed, 35 insertions(+), 21 deletions(-)

-- 
2.34.1


