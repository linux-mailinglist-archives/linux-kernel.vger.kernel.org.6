Return-Path: <linux-kernel+bounces-394267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD249BACB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C181C20CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7818E05E;
	Mon,  4 Nov 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8BjxGkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85F18CC1B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702646; cv=none; b=nCI+fMtv+ZpQlDEFdqy3h5vUcRVoRbhGr450Ij4/4OVG0yFycLSoALjBfqkAZ2jAO9KVW80+TY+VqMwj0QL3UdKhi+JlPOY4Iyvc63L9eCZBZtakFcdr4bggpJeLDVGXCebFxn7GMjA8Rehwo4Sge96TNa0tIJq1vYNNAV3cWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702646; c=relaxed/simple;
	bh=N2BEphD6E+ts757yq9dfmmqSySIs2TwDaeNZtjT8DQ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e6OMILze2itPhVddg04ZZ75WA1uoYll9RYlMEpDqQ0IxW+5iQeEZXJB2RFE003V0tFMPaP2kzc91DZ+HCq04ZjFB9+2MzZJZyyUObPMI6vSlw3JA38yyiGrLwTdvUdKNWP9Nvg6haCuFc3fy2UU+v5IFJIDVVvkwBSEwzEyLO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8BjxGkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ACCAC4CECE;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730702646;
	bh=N2BEphD6E+ts757yq9dfmmqSySIs2TwDaeNZtjT8DQ8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=d8BjxGkNhwqEQ1w/TPSJgwkgN/et1iaMVP1zw14U5aA4CnDnOYrzSpqTSkkaqkPmE
	 jbwcjpi5PdzeHjdBbpenFsKGFzoii2ae5TB2B6DeWesRFo4kcDFa9NQYv8NlhCe2NQ
	 OqRKlAcLWpxEmANuT3dYxw51TSOhLOkZ+9lM1AZO9QfKBma4I/L2vfBETzdQj+sEa5
	 zWbmU4iwlq/GUtJi8AzLyiujbcJZjtLqK6lIcIK+GKWJMsrlpz+RD8WPFu0eD+/BUt
	 YDzZ/ACxBi6IVCQc37gLD84l04iAWuQNqhU8OCdLduPvvKZA7CHMVqlkwLr6HpWL0G
	 9LxqTaZRGb5JA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B5ED111AD;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Subject: [PATCH v7 00/10] drm/bridge: it6505: fix HDCP CTS fail items and
 add MCCS support
Date: Mon, 04 Nov 2024 14:43:30 +0800
Message-Id: <20241104-v7-upstream-v7-0-8b71fd0f1d2d@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJtKGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwND3TJz3dKC4pKi1MRcXXPT1MQUozSjNFMzcyWgjoKi1LTMCrBp0bG
 1tQBAzplEXQAAAA==
X-Change-ID: 20241101-v7-upstream-75ead2f2f567
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hermes Wu <hermes.wu@ite.com.tw>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Pin-yen Lin <treapking@chromium.org>, 
 Kenneth Hung <Kenneth.Hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
 Hermes Wu <Hermes.wu@ite.com.tw>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730702658; l=2910;
 i=Hermes.wu@ite.com.tw; s=20241101; h=from:subject:message-id;
 bh=N2BEphD6E+ts757yq9dfmmqSySIs2TwDaeNZtjT8DQ8=;
 b=SnEN66Llgw53Ax04tEB9EPogFfgJEnebxA2xp/6yJ0r/3ojcYg2jVR1CrBzaKZ/7O0Gzl+QKt
 IDXftIsWc6pCifgJ3F51AP/xEG0oehgeu4c1MWR8K3g1EszvJUWRpfD
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=FOYYbsP2Nlw6mjB3rLFYSLmAiENzj4AWQly5XTcDuMM=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241101 with
 auth_id=268
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

There are lots of failure items while running HDCP CTS using UNIGRAF DPR-100.
In Order to fix those failures, HDCP flow needs to be changed.

The DisplayPort AUX protocol supports I2C transport.
In Order to support MCCS via the aux channel, the aux-i2c operation is added.

v6->v7
	-[3/10] add header <linux/bitfield.h> included

	links:
	https://lore.kernel.org/all/20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw/

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

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Hermes Wu <hermes.wu@ite.com.tw>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: Kenneth Hung <Kenneth.Hung@ite.com.tw>
Cc: Pet Weng <Pet.Weng@ite.com.tw> 

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

 drivers/gpu/drm/bridge/ite-it6505.c | 335 ++++++++++++++++++++++++++++++------
 1 file changed, 278 insertions(+), 57 deletions(-)
---
base-commit: 4d1c251e8889b4629789425fe85adfc6d39666ac
change-id: 20241101-v7-upstream-75ead2f2f567

Best regards,
-- 
Hermes Wu <Hermes.wu@ite.com.tw>



