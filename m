Return-Path: <linux-kernel+bounces-565734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D973A66E46
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE52B16A9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0921F873B;
	Tue, 18 Mar 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6iahaJa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968501A262A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286695; cv=none; b=MYrlx1U945m/uq3xwjqXkU4KinUO7QRJ1s7VsOrilOpcs+W7gjpnd53dQEXjVoQ12Jqh3N3sn/ZxmiV5R+mhVvdeHHl1bH48vWIJexumIRc0lKrkJjApSSBaxAg/kBt5Dvu0+caT1ZnLBLQMdxwMn5yXZGoH04OG1Tr16PIB66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286695; c=relaxed/simple;
	bh=F4ufPEdkMCW4h084hlGUoc9xbvGlZkK0roqYJfiPmSg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dWSiuaLLq+DlcPuSUYZSyUZglHf0TQtY+Jo1AVsLXUc1w3dnLT36o3tZBAzo417vuIJttN71gV5Is8uG8fnG3UKUOyRivzU85OUTj60xexWWqMP/hzcHr328wrNnWiMghfjddpDrpoPrT1Hi7sbgyU3LrBVVXLw1qkHsjsptNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6iahaJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0604AC4CEDD;
	Tue, 18 Mar 2025 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742286695;
	bh=F4ufPEdkMCW4h084hlGUoc9xbvGlZkK0roqYJfiPmSg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C6iahaJa/g/cW7NRLaycSIrSj2YPduoiCgv7JEVyGeRLl6ZOZI5wg4swIxU8ho28y
	 hZqRzCzlV2HwYDChklEaQYcqcVduyM4ERB9CzWYP6807s9FObjfhAX0DTfC1cNyW1Y
	 lxy1CXwTk4tZkBsiuhst46PJMlqzu707UMzCuKD4Am8hAc45IlliS65PdagFYzkXv8
	 hx2RJOYAR/bNoaKWHYDO9kTFQ8RH6QPj/6w6eYSYQ9zkSiPSbXJlH6dLcaxYvYCKy/
	 5mZR/eWwgxg7hW3H7qpXVQFGX3rZLv/Rc6dYe8A5kcd5UCB2b2wyOJ3frkRQI686zW
	 SJPSpla6OdHWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C34C282EC;
	Tue, 18 Mar 2025 08:31:34 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Subject: [PATCH RESEND 0/3] drm/bridge: it6505: fix DP link traning and
 improve compatibility
Date: Tue, 18 Mar 2025 16:32:08 +0800
Message-Id: <20250318-fix-link-training-v1-0-19266711142c@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742286741; l=978;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=F4ufPEdkMCW4h084hlGUoc9xbvGlZkK0roqYJfiPmSg=;
 b=i6LuwKIo0Z3uKz2VsZ1vNownlik5hHUj/56aGdTUSDfohorbjXi4NKMY+Csqr3qS09Vc7KTPI
 cF8NdKJGKzoCyiFu9yLkng4PdxNfIWdLap9yrimfOGu+avjC4UHGueZ
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

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
Hermes Wu (3):
      drm/bridge: it6505: modify DP link auto training
      drm/bridge: it6505: modify DP link training work
      drm/bridge: it6505: skip auto training when previous try fail

 drivers/gpu/drm/bridge/ite-it6505.c | 106 ++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 40 deletions(-)
---
base-commit: 938fbb16aba8f7b88e0fdcf56f315a5bbad41aad
change-id: 20250121-fix-link-training-461495494655

Best regards,
-- 
Hermes Wu <Hermes.wu@ite.com.tw>



