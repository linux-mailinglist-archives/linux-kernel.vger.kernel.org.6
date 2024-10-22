Return-Path: <linux-kernel+bounces-376473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3419AB21E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0582283647
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5D1A264C;
	Tue, 22 Oct 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="G+hD+cw2"
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D613D2B8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611015; cv=none; b=KwoRr1Y+YSWVLDcxb/Fa67nzoZ19jCLEYc1aIShJShJoTtZQImxv4a8k/DmnSnquXCvDRRdOuf2/OzvuaneCxDEIBOiuLCSgpZePAMwmOVLGMqwS9shDINGD/Uz9AsUhWfRxRGG+AND7TaDLNDT8Pob1UG7HS810k+pKfjnwkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611015; c=relaxed/simple;
	bh=G0oSHbfksbSu2t4D2EM01TYyXErs37ZXSLhARmf6ewE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YjNYo+XSPW/rlUn4XbLq0xnM01VWRymGmF6MUey7aghyQ0QQnXlG4WhU6I2EGO6JdEcp4/CePZ8X2LO5F/vSP++riLt3saf60Qz6EcWL67y5yDCO0IqA8HKZib2ZIs+HztkTKn3+lYmrVYlq0Ni364eU6Z85yt/qVfq0UqMLPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=G+hD+cw2; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXwd343mTz14s8;
	Tue, 22 Oct 2024 17:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729609911;
	bh=DXcgCrfryIcs9aP8OkSnOzrenyom7Z7qj4jE4bpke9c=;
	h=From:To:Cc:Subject:Date:From;
	b=G+hD+cw2W5/DbQiqWwW1mzDSljuqB7v0uXhNqSG9LdxPRenxBsMNnSJBLwc1YAuaT
	 V3xN89IdIpOVn770l/MRBWU8FIDVhWBCV3EMmeFprI1w52+Dp1jPwIKDyOZ9k+FsiZ
	 YOvsumof9ben3fB06eMst7WHWHEkplVk3fIfePNk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXwd306MnzgrS;
	Tue, 22 Oct 2024 17:11:50 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/3] Refactor Landlock access mask management
Date: Tue, 22 Oct 2024 17:11:41 +0200
Message-ID: <20241022151144.872797-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

To simplify code for new access types [1], add 2 new helpers:
- landlock_merge_access_masks()
- landlock_match_ruleset()

This third version mainly use a new union access_masks_all type instead
of changing struct access_masks.

The last patch uses these helpers to optimize Landlock scope management
like with filesystem and network access checks.

[1] https://lore.kernel.org/r/3433b163-2371-e679-cc8a-e540a0218bca@huawei-partners.com

Previous version:
v2: https://lore.kernel.org/r/20241014124835.1152246-1-mic@digikod.net
v1: https://lore.kernel.org/r/20241001141234.397649-1-mic@digikod.net

Regards,

Mickaël Salaün (3):
  landlock: Refactor filesystem access mask management
  landlock: Refactor network access mask management
  landlock: Optimize scope enforcement

 security/landlock/fs.c       | 31 ++++------------
 security/landlock/net.c      | 27 +++-----------
 security/landlock/ruleset.h  | 70 +++++++++++++++++++++++++++++++-----
 security/landlock/syscalls.c |  2 +-
 security/landlock/task.c     | 20 ++++++++---
 5 files changed, 90 insertions(+), 60 deletions(-)


base-commit: dad2f20715163e80aab284fb092efc8c18bf97c7
-- 
2.47.0


