Return-Path: <linux-kernel+bounces-367504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD29A033A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26B9286E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590E21D1E92;
	Wed, 16 Oct 2024 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ1dKIX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132E1D1305
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065252; cv=none; b=TyF16u8+lHzaLrVVa0aPpMTHQ7052emUHwwfjDoA1fuXM5nh+SprOJ6aIjVhyo0LY9BA378ad5VLGny4Y05OrAvbJHORZCRgN2iqhBSyOPI3AQfxeu5roNKRH/H7kae19ghq9Cfd4qhnt+6uVYlqvw0f32kH1sl4U7Dbr55q3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065252; c=relaxed/simple;
	bh=0mS2QsnFjEWDx86A7WNGJteaAIrzem/xgIboic3tva4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rUjyWYuW+ywhupCHMHtfa5oF2uXvvBpwI9r/5mz6MgCvZF3r8BxvDti8I379GZaBcAPXoPMovnhuQPjyjFHjyhADWIcv+2huAQt6VM0ROkO2NwL5ZwX2fd8PtQz1MTjYOtUxMhLXeNHDfv4nhAAA8biusnXkLfBcAez/5bd5i9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ1dKIX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FE90C4CECF;
	Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729065252;
	bh=0mS2QsnFjEWDx86A7WNGJteaAIrzem/xgIboic3tva4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NQ1dKIX8W9tyo73h96I324c5M/GRoIgs1ndYbRC72atRfqTssQobqlyd65avMHJ0X
	 XIu01Y4TJg9KARiOabj7BeI+PLXKvGuxgOyhWdi+pHAnMVi3FpLu+BSqNqEtyKABMh
	 o8ZTPNp05foX1DaKJmNAV1wjNPRl5vhNv1dqgcQZ8oawoG2HWpm2hpAgJpe8Hvu3IT
	 VEaWvmoHLazGx19K3k335CLC7pJMGuB1y64Y47MCjqb1rz93Tx8yzI5uyG+HFLPaLD
	 W/5dBqacriGn6Tnzj3u7pCtzJ3WOZ4o+wiEPduXffIKpEBw0quYdyOm8e3C+GuUlG8
	 03YARZutI8emQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA20D20684;
	Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Subject: [PATCH v6 00/10] drm/bridge: it6505: fix HDCP CTS fail items and
 add MCCS support
Date: Wed, 16 Oct 2024 15:54:12 +0800
Message-Id: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRxD2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIxNDA0NT3dKC4pKi1MRc3TIzXcs0kySgWFpqcpq5ElBHQVFqWmYF2LTo2Np
 aAF1IP8FdAAAA
X-Change-ID: 20241015-upstream-v6-9f4b015fecf7
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729065263; l=2652;
 i=Hermes.wu@ite.com.tw; s=20241016; h=from:subject:message-id;
 bh=0mS2QsnFjEWDx86A7WNGJteaAIrzem/xgIboic3tva4=;
 b=gzqV8xnlDztsLFNNGm32Jggeb0RcJidEYBbwujDBbugy7ttmgHRkDYSobIzp2vyKZf7WPLgFj
 jwpa2e2PbmuDqXO/WBhy/24hhQjkjPfb26fnlTGKsgnvtXvy77nigUl
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=kV18uQEXox+1WccdQceCbMlJKN+BBNUk3N8VsoULcQ0=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241016 with
 auth_id=250
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

This is a v6 patch-set.

There are lots of failure items while running HDCP CTS using UNIGRAF DPR-100.
In Order to fix those failures, HDCP flow needs to be changed.

The DisplayPort AUX protocol supports I2C transport.
In Order to support MCCS via the aux channel, the aux-i2c operation is added.

v5->v6:
	-keep the commit message wrapped at 72-75 chars.
	-[10/10] fix return variable being used without being initialized

v4->v5:
	-add more messages for changes.
	-[2/10] modified AUX transfer data size judgment.
		change for-loop to do-while.
	-[7/10] change for-loop to do-while.
	-[9/10] change wait timer with timer_after()

	links:
	https://lore.kernel.org/all/20240926074755.22176-4-Hermes.Wu@ite.com.tw/
	https://lore.kernel.org/all/20240926075134.22394-1-Hermes.Wu@ite.com.tw/

v3->v4:
	-split changes  into patches.

v2->v3:
	-split aux read  KSV function to a patch.
	-[1/3] new in v3
	-[2/3] add description of patch

v1->v2:
	- ignored.

Hermes Wu (10):
  drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
  drm/bridge: it6505: improve AUX operation for edid read
  drm/bridge: it6505: add AUX operation for HDCP KSV list read
  drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
  drm/bridge: it6505: fix HDCP Bstatus check
  drm/bridge: it6505: fix HDCP encryption when R0 ready
  drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100.
  drm/bridge: it6505: fix HDCP CTS compare V matching
  drm/bridge: it6505: fix HDCP CTS KSV list wait timer
  drm/bridge: it6505: add I2C functionality on AUX

Change-Id: Iad0c056d72abf2655081357cf40c3b0d3df916b5
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
Hermes Wu (10):
      drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
      drm/bridge: it6505: improve AUX operation for edid read
      drm/bridge: it6505: add AUX operation for HDCP KSV list read
      drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
      drm/bridge: it6505: fix HDCP Bstatus check
      drm/bridge: it6505: fix HDCP encryption when R0 ready
      drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100.
      drm/bridge: it6505: fix HDCP CTS compare V matching
      drm/bridge: it6505: fix HDCP CTS KSV list wait timer
      drm/bridge: it6505: add I2C functionality on AUX

 drivers/gpu/drm/bridge/ite-it6505.c | 334 ++++++++++++++++++++++++++++++------
 1 file changed, 277 insertions(+), 57 deletions(-)
---
base-commit: b8128f7815ff135f0333c1b46dcdf1543c41b860
change-id: 20241015-upstream-v6-9f4b015fecf7

Best regards,
-- 
Hermes Wu <Hermes.wu@ite.com.tw>



