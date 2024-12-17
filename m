Return-Path: <linux-kernel+bounces-449756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008FE9F55BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99FF1885A17
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C5C1F7563;
	Tue, 17 Dec 2024 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw24lEpX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C703398A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459116; cv=none; b=tP+X3d5t8vb91Sx2ZfLLpTc2PztzdaDM5iQLAYZkDmFJ1O2qWvVYvqDio/oOrg7sTQBaXLhrPw/eMPDi5/Pl8Ni1WXwWo0VkR2o+4vPG8Da25Ph76Biza0dW86AyjftVZ1jfMDJRTOhe7Yjrb14DImDyUeyjYFq2/ZhVYRIZlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459116; c=relaxed/simple;
	bh=mtJsy/fk+q+6RZ47ZPA0DWr8yUNsDYMIiX5lk9n9xqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rX9gPE0tZXXQwAQu4/b+52qoIkADYE0qYPHo7yipkIiEDdVcL/uRlxG1n6wu/0l2VJ0UhpOfrCAv0Gstq8DlWhC5RmSiRoLCh6OqOlMzN5T344hqrA1bSzMWddGhtutPaehyu362DjfmJTC1YGKN5plAGDVhzUMax9nH3HSUAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw24lEpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D72FC4CED3;
	Tue, 17 Dec 2024 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459115;
	bh=mtJsy/fk+q+6RZ47ZPA0DWr8yUNsDYMIiX5lk9n9xqk=;
	h=From:Subject:Date:To:Cc:From;
	b=kw24lEpXX3MFp9Ynu8fTbRSrbczB0o8buMv3EDvC7LLSp9Yj7G4iRo2hSCFdqnoD/
	 wyphzxUhgziPmold6SXf2XloA6C5TOv3YeGP7O9ssLsF8m+EpfMSbdxR1VicPmVB72
	 XPsBftQRL7cmgDCvFxNlsN+i1XbpFHdJVfHNtpE3HMU7YQIA3vvbiWN5t239023yPv
	 OEQxXXgarRwYY9zde3KlFmagFnyi5UGMmLpJ0yeIVE8od3gFqPT5hK3E81V1jZGOc7
	 2ms9TypMnXPmu9xF1klzDghhKbK9VDzeAp/a+8aB7/vaI7794GhiiAVqI3mC20wi9U
	 +6NRZ/JZ4oHCw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH v2 0/3] mfd: syscon: Cleanup, fix race condition and remove
 platform driver
Date: Tue, 17 Dec 2024 12:11:39 -0600
Message-Id: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANu+YWcC/3WMQQrCMBBFr1Jm7UgTrRhX3kO6aOKkHZREZqRYS
 u5u7N7l+5/3VlASJoVLs4LQzMo5VbC7BsI0pJGQ75XBtvZorDGoi4acMPKHFF08dBS889ETVOU
 ltB3VuPWVJ9Z3lmWrz+a3/gnNBlv03RDOwRpH7nR9kCR67rOM0JdSvtTj6/OpAAAA
X-Change-ID: 20241211-syscon-fixes-9f35ecb9bfbe
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Pankaj Dubey <pankaj.dubey@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 John Madieu <john.madieu.xa@bp.renesas.com>, 
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
Changes in v2:
- Fix patch 3 logic when a syscon is found in list to not return an 
  error
- Add tags
- Link to v1: https://lore.kernel.org/r/20241211-syscon-fixes-v1-0-b5ac8c219e96@kernel.org

---
Rob Herring (Arm) (3):
      mfd: syscon: Fix race in device_node_get_regmap()
      mfd: syscon: Remove the platform driver support
      mfd: syscon: Allow syscon nodes without a "syscon" compatible

 drivers/mfd/syscon.c                 | 95 ++++++------------------------------
 drivers/mfd/vexpress-sysreg.c        |  1 -
 include/linux/platform_data/syscon.h |  9 ----
 3 files changed, 15 insertions(+), 90 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241211-syscon-fixes-9f35ecb9bfbe

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


