Return-Path: <linux-kernel+bounces-442091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4C49ED7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F100E280E62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979C235C29;
	Wed, 11 Dec 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvBzwilz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573A2288E5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950649; cv=none; b=YljU7wW1xy7JJZ4XLkCQ927ohMLheKFEFENyeTxeEuspM/9Ouyc2WHfRlXtkIhgwMRY31FlrCZ0sHYqNVNVcQURMjx83q/rthw5SapdCd0OuaBVQDXh6Ttlq6GOnpHYb8exlnG0hEj31weE5efjEST/fNZX0hTYS8nmYAxfy1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950649; c=relaxed/simple;
	bh=DJ/7eJXEMrFS4Ie4t4RtBGueyBXmyzT8wnr9zL0rNjQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ey9VFTMJuP2EaH7fHEWkZii3C8ItuQ4WHjj9pan/xicy8LJQc2C/RZpHevJoPaDZIalfC0Ptvqr/nFCBrdSFI+PVKG5mzF6hiPtPbG1Z89rvFWOigVhhttOYa6Ab05lHRypNU9ehmk9YbqdWtLrAzNeIXGkBD7dxdzdZbnP8JMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvBzwilz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DCCC4CED2;
	Wed, 11 Dec 2024 20:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733950647;
	bh=DJ/7eJXEMrFS4Ie4t4RtBGueyBXmyzT8wnr9zL0rNjQ=;
	h=From:Subject:Date:To:Cc:From;
	b=RvBzwilzzX87al39z6Vy+bi5wss+IoFwC2A2j5kwREPrutznLMqsfYpldp2Wyau2L
	 jMVNj0wW18A7FiH9fQZCrNLSD1KB44eG2jaSFv3XrGTfgH2HbBDA0kQ7e7hAh2SFv0
	 8Ghd9qiTIMJP2qX5ubumbiw516n8dmhwtoY/whTqWDgTp/mwixrUR6HBvfJ3N6bs0D
	 uYmN9WgxxWWPEQRjWZfwFs5rV3vLtcSsyEzs4W5agxHP2L1gWCB/lEVkGU7tc+dGv3
	 fVrRkisnmBBCy2jnOJQE2Np6T56MYM/fQTpX1u9HkPMBY9bju9OPybNgkuKpeLG5Gq
	 nYs+wcTPQKOZQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/3] mfd: syscon: Cleanup, fix race condition and remove
 platform driver
Date: Wed, 11 Dec 2024 14:57:11 -0600
Message-Id: <20241211-syscon-fixes-v1-0-b5ac8c219e96@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKf8WWcC/x3LQQqAIBBA0avIrBPSamFXiRZpY81Gw4EoxLs3t
 Hx8fgXGQsgwqwoFb2LKSWA6BeHc0oGadjHY3o7GGqP55ZCTjvQgaxeHCYN3PnoEWa6Cf5BjWVv
 7AC5SSV5eAAAA
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Pankaj Dubey <pankaj.dubey@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

Questions from Krzysztof and a syscon related binding review got me 
looking at the syscon "driver". This series is the result.

This short series drops the stale platform driver part of syscon 
support, fixes a race condition in device_node_get_regmap()
which is used by all the lookup functions, and allows for registering 
nodes without "syscon" compatibles.

Compile tested only. Testing on Tensor, the one user of 
of_syscon_register_regmap(), would be helpful.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (3):
      mfd: syscon: Fix race in device_node_get_regmap()
      mfd: syscon: Remove the platform driver support
      mfd: syscon: Allow syscon nodes without a "syscon" compatible

 drivers/mfd/syscon.c                 | 92 +++++-------------------------------
 drivers/mfd/vexpress-sysreg.c        |  1 -
 include/linux/platform_data/syscon.h |  9 ----
 3 files changed, 13 insertions(+), 89 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241211-syscon-fixes-9f35ecb9bfbe

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


