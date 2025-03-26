Return-Path: <linux-kernel+bounces-576508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4717A71025
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AB43B21A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D837189905;
	Wed, 26 Mar 2025 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2so4mAk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA27AD4B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742967220; cv=none; b=LFiNPX30MP7oME2Yffry2fTspFs7Z/wMaznQ6vSBasANShVlA9v1deg9gGoRvEa0cMnzrrdaTEZ2AtviEsVVYfgGeniGiJJMaXiGE+0WVF+srIsqoxI7/xljtXsjniFOWf8QiOuC0NxX9Bzoew5fuJ9rEF5LMbyuWf+Y4WcRD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742967220; c=relaxed/simple;
	bh=oKGOdDgxhAqNZ5oSM5iv/OnF2CxCH6tBHGl2VSB8qc8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EDJhCIpm9Gm9eNMfW1koYPlBVVENoP8c1u2PhcDwjCANRw7qyc2r6rgmo8siO0Yo0ILCPHg0NMBGgALkIP78sAkKejhc6CNw4NSVy4Q+TmIl5VbYeqIF0CQtVNO3K9iz9U4AugjETKd+2NZ/kMPZmU6fUtGkLl793UbNf84+7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2so4mAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EFC7C4CEE2;
	Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742967220;
	bh=oKGOdDgxhAqNZ5oSM5iv/OnF2CxCH6tBHGl2VSB8qc8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C2so4mAkFdfZgTI5w7njInHi+EKOorVmxjIdp7Hct9OFYaF1ypELS+A5Fzob4l8Kh
	 kEOdyJ2TgGcDXjQDO3dr0Qhke8GJRE5TNaRkQARzcRgRqi+BDEQJRenX+tiVbBgRtg
	 qDouualJKx+3zWupUGxx0BmUjlF+ZN5iYV/xv79ZXE0YS8x5X0RgDWYvgbHrXDjO9R
	 L8uabB8y75rNU7h/XzekN2LBdOTbggT6sd9MsFzJYptQlSnHyUqi0v8J7kEq7BWt4k
	 WxeRvdVPCVsdE6TwFES1C82dBjosHiOw9foFfbti4ZI3aYw9AVpQLLpNHqo69+xcTo
	 gjQItjhgdXang==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BD5C28B30;
	Wed, 26 Mar 2025 05:33:39 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Subject: [PATCH v2 0/5] drm/bridge: it6505: fix DP link traning and improve
 compatibility
Date: Wed, 26 Mar 2025 13:34:12 +0800
Message-Id: <20250326-fix-link-training-v2-0-756c8306f500@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANSR42cC/x2MQQqAIBAAvxJ7bkFFBftKdIjabCm20IhA+nvSc
 WBmCmRKTBm6pkCimzMfUsG0DUzrKJGQ58pglHFKG40LP7izbHilkYUlovXaBmeD9c5B7c5EVfq
 f/fC+Hwia3E9jAAAA
X-Change-ID: 20250121-fix-link-training-461495494655
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742967277; l=1323;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=oKGOdDgxhAqNZ5oSM5iv/OnF2CxCH6tBHGl2VSB8qc8=;
 b=82T34WmCkdjj6qSV8M4kPQjRl4ckK8npAAKkeembaXRcV/OIg3QCR0QAJk84CiH5zcAZGx/sb
 J4byaM9Mb6DBdb5KWK618gl/kTW7KBxDq/QAvZeg0xYHlDbedTFttC7
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

IT6505 supports HW auto link training which will write DPCD and check
training status automatically. Some DP device can not pass
HW auto link training and must set link training step by step.

when HW auto link training fail, it may trigger video FIFO error,
and link training process will reset to beginning, and never try
step training method.

Modify training method improve compatibility to these DP devices.

v1 -> v2:
	1. Split [PATCH 1/3] into 3 commits
	2. Drop non necessary variable auto_ttrain_retry
	v1 link: https://lore.kernel.org/all/20250318-fix-link-training-v1-0-19266711142c@ite.com.tw/

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
Hermes Wu (5):
      drm/bridge: it6505: fix link training state HW register reset
      drm/bridge: it6505: check INT_LINK_TRAIN_FAIL while link auto training
      drm/bridge: it6505: modify DP link auto training
      drm/bridge: it6505: modify DP link training work
      drm/bridge: it6505: skip auto training when previous try fail

 drivers/gpu/drm/bridge/ite-it6505.c | 112 +++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 47 deletions(-)
---
base-commit: 938fbb16aba8f7b88e0fdcf56f315a5bbad41aad
change-id: 20250121-fix-link-training-461495494655

Best regards,
-- 
Hermes Wu <Hermes.wu@ite.com.tw>



