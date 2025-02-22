Return-Path: <linux-kernel+bounces-527370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C8A40A68
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3A242016D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8375720ADFE;
	Sat, 22 Feb 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6AyIFJk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9421FF7AD;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243448; cv=none; b=HNduOKv9nAIJaaPe7zSZIcbkInEJroQdYzii2vDdwAvQugfXpfuI60W9G6YwWd3pdNYy38ff5oq8tDa6P/fKBtO0mHgAlyZBlZSp18mFa9TZ95OmxhVoGrEHc8D1XQqPS/BbDHI8GvCOxbwCOTwoMTg6ybendG5j3aHoCgr6nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243448; c=relaxed/simple;
	bh=Y+9vtj0/GJijf+70Pc6ic4DpWvcYid81kYksrctrbME=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BobvbfD/ym2fhyYRbL0zQaNqD89viwVWB0pM/oOsOGrHi6MWl0i0tg3w9QLgwZoKPEVjipkrArQJKHx6OixJULC7I55IewnvfwdzLQLRtqoioSzVR5Jdu6PYmTWA7PxKM4ruAQxTniYsXskWu4EI9tBhpWf7hPZg7ob9gv4sKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6AyIFJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 611F8C4CED1;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740243447;
	bh=Y+9vtj0/GJijf+70Pc6ic4DpWvcYid81kYksrctrbME=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=D6AyIFJk+/XdJcNCqGWHKcIc8Jq3H9WXy/57bP/dJZybtFjBo2jXv7iDD1ujTXYf6
	 2hHtnhgG03E2YsQFy6mSe/DOw6NmSvwjN9xt2jbyeWDcc+9aiu9opcUlGYMYR2To0e
	 /vxJ3s2fJ6mHlnYc77u3j3mvU4+BxG0MW429atEqlWkd0Uyf401o9HU1BRAgtEdOr+
	 XzB/+M3cgJ84aZ39w+B0QDvAONrAxb+mISTQE2lk4xM2PVocxODpACzEhqATU6/bGA
	 /91TAoBb8TGPEO+gKHMO9QNZGACA2djY7hh313afhfy0tWL8HwBUTHC5IiZTk7ewQJ
	 CZUoap/SGdVyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BCEC021B2;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Subject: [PATCH 0/4] Miscellaneous Apple RTKit fixes
Date: Sat, 22 Feb 2025 16:56:45 +0000
Message-Id: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM0BumcC/x3MQQqAIBBA0avErBvQISG6SrQInWqgVByIILx70
 vIt/n9BuQgrTN0LhW9RSbHB9h34Y407o4RmIEPOEBlccz4ZNXm8RD06x97SYMdhC9CiXHiT5x/
 OS60f+7ccWmAAAAA=
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=Y+9vtj0/GJijf+70Pc6ic4DpWvcYid81kYksrctrbME=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ/ouxpcfyrJiu7Wnyave+7iM7/iEZ3IVNsnmrcdmbraIm
 Kh3t2p5RykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiWxYw/Hf+VXIqZPJS+9te
 Dvc8YoX2Vf2/ksZcw2yqn/OtJSpRTIyR4Z5v25H5Ul1H13ZYzfKcnHMpW/7otnOtcaJTlGos0+4
 mcgEA
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

Hi,

This series contains four unrelated minor fixes to our RTKit driver.
These are mainly required for drivers which aren't upstream yet but
have been part of our downstream tree for quite a while now.

Best,

Sven

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
Hector Martin (1):
      soc: apple: rtkit: Implement OSLog buffers properly

Janne Grunau (3):
      soc: apple: rtkit: Add APPLE_RTKIT_PWR_STATE_INIT
      soc: apple: rtkit: Use high prio work queue
      soc: apple: rtkit: Cut syslog messages after the first '\0'

 drivers/soc/apple/rtkit-internal.h |  1 +
 drivers/soc/apple/rtkit.c          | 62 +++++++++++++++++++++++---------------
 2 files changed, 38 insertions(+), 25 deletions(-)
---
base-commit: 00834971f0d9e38beae37e92055b1432782827d0
change-id: 20250220-apple-soc-misc-55ec124184fd

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>



