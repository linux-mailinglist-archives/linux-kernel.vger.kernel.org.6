Return-Path: <linux-kernel+bounces-513746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96794A34E26
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152113A8A91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC63245B1A;
	Thu, 13 Feb 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEKpqizx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181AE245B15
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473229; cv=none; b=YccaqmG/TV48k6EMPvbYEaW9c9WA0Wm5ECyr8brbTBKxU28vSdpv3MNOQr8d6bMMnL3pD0ll71AyeprrlmEg51K7xoakpUDnJcozqXLSieedntqmSSdLArDtZeAesM75znhzF8+Qd5qCJeoPjkm2ivPMUEqxg1M206F8a2Htruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473229; c=relaxed/simple;
	bh=hxWopbeRhDie3KprxW1B1Z9l0aq0Jj2wHB7Dl7kis4M=;
	h=Message-ID:From:To:Cc:Subject:Date; b=dgX6zm/i12kaf6YlCLkySEyxfcEa+TQBVhsQoE4BE9sZItnAtwFrb3sjUz1zxrgxL6DlTDaeNqsJ1aET/mrOOlfKAfCtIMbL+GPX516pIOaTg2W2RS0EogmleCFh+wu2eKpVLYaTHaQjafH9/AccjtRfT/1wgtcxjKlM3WsSTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEKpqizx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C80BC4CED1;
	Thu, 13 Feb 2025 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739473228;
	bh=hxWopbeRhDie3KprxW1B1Z9l0aq0Jj2wHB7Dl7kis4M=;
	h=From:To:Cc:Subject:Date:From;
	b=fEKpqizxH6UoMONlazTl9HW5G0eL0diUHALkeAw9AeojrUq3SjxwCT56fgYKY6W92
	 EZpLOo4xzM/4U3YBT+OtZmolb+BYb9dY2N0IJ71qJO3FXfJSHQmSXASTGUZI0Fftzb
	 8gJPCW/seGbDnn3IcuBMGvXvh4Y2KfSkCKlzsUn4arByiAQNE4WZd4R0pS86c81K9G
	 qqLK4YkrhbBTUpeoEVYOVudoXpor/QWzIz0bu/VgRkn7/yWYjSm3rGYcnTvWSCN65L
	 dRdCZtmS/H4R0wjgs2jDIFQTHcNd4M0gzRTjFyiRxCWpN8RO7v2FaHk74qhC9VkQXn
	 O8rXkoiN+EP4w==
Message-ID: <e25038550cd571bab188a0e61e2c2b2c.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.14-rc2
Date: Thu, 13 Feb 2025 19:00:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.14-rc2

for you to fetch changes up to 35e21de48e693af1dcfdbf2dc3d73dcfa3c8f2d9:

  regulator: core: let dt properties override driver init_data (2025-02-11 16:29:01 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.14

The main change here is a revert for a cleanup that was done in the
core, attempting to resolve some confusion about how we handle systems
where we've somehow managed to end up with both platform data and device
tree data for the same device.  Unfortunately it turns out there are
actually a few systems that deliberately do this and were broken by the
change so we've just reverted it.

There's also a new Qualcomm device ID.

----------------------------------------------------------------
Jerome Brunet (1):
      regulator: core: let dt properties override driver init_data

Varadarajan Narayanan (1):
      regulator: qcom_smd: Add l2, l5 sub-node to mp5496 regulator

 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |  2 +-
 drivers/regulator/core.c                           | 61 ++++++++++------------
 2 files changed, 28 insertions(+), 35 deletions(-)

