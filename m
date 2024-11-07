Return-Path: <linux-kernel+bounces-400564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4139C0F4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1191C22ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB3217F38;
	Thu,  7 Nov 2024 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jXjBq2Jl"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2D2178E6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008899; cv=none; b=GJulcb9r/r5FPrlf4XeYPIshzX3Jh0O1BCZzpS2qcsttJ3dqRpQgBwyOqKLLrvGpyrCCUFZqTExuc6lGmBE2gLuOidfMm71gnRD/l/J1NxsnQDdhZHSQWDiV2lMXx+uy9g4tCBRafUTskI6D66kTsFlTmG+t9K6WOC++vYpj0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008899; c=relaxed/simple;
	bh=GZ3n4cGUFb9X0QXdd9Kdf3Hk/WUzfeCTMfx/Vj51ysE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRrvvgzYYGLi7HIG6/y4fLtiNS4jdrrnqTplXQg4kfBY6VbbaCBDkqPJIJj/DnnIxDIqK7VHhqrYDqypSr8gZQlwxOR5jFpgxtv/l4tO+oMElrGWZ+NJXa1hs14gj6h4psKb5KiDi+6Aoz3Yt8qcPRn8Sn0WFBDFEuORhzLpVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jXjBq2Jl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:c173:4b:4a04:3a21])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CA73822A;
	Thu,  7 Nov 2024 20:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731008886;
	bh=GZ3n4cGUFb9X0QXdd9Kdf3Hk/WUzfeCTMfx/Vj51ysE=;
	h=From:To:Cc:Subject:Date:From;
	b=jXjBq2JlXpoAA9J7MX0LWSdJ/tjY8Pl5LCVuMjW9T9lJd8RHkA1frsHXyT4ssxyyc
	 R+9exTw54vl3e1iIZeq9grpedm/NOYSUBgHiAJku7yylySTRLmF5Qrkv7afqOobhB5
	 xJ8/71lKtccCxAqsbQ62NSlB5tL/3HAcYHBtqVO8=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/3] staging: vc04_services: Assorted fixes
Date: Fri,  8 Nov 2024 01:18:03 +0530
Message-ID: <20241107194806.90408-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assorted fixes for headers and TODO file

Umang Jain (3):
  staging: vc04_services: Cleanup TODO entry
  staging: vchiq_core: Rectify header include for vchiq_dump_state()
  staging: vchiq_debugfs: Use forward declarations

 drivers/staging/vc04_services/interface/TODO             | 9 ---------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h       | 2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_debugfs.h    | 3 ++-
 3 files changed, 3 insertions(+), 11 deletions(-)

-- 
2.45.2


