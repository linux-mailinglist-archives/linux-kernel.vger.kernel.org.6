Return-Path: <linux-kernel+bounces-366720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C399F90E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279CE1F236EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E501FBF59;
	Tue, 15 Oct 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BljqQEJK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33541F8185
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027666; cv=none; b=WFiHgUjcvLauj9QXBhYLeDyzJH1w/lzkzsBCNw3jaNzm7Q4D1S5LN7Rtrc1H2A6h3UU8YpT+B+XuVWX2bXgX7gv1dKxFSeSoew9merjYEPbDGwptQummAxydXr1rrU35nAoj3q67p07ddD2oEtDUYCNkN1pzTEigbFvJS2qqLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027666; c=relaxed/simple;
	bh=OqTqU8Th4c2EZtve0wtlJSLeEe8jvXUquH28/MfCsV4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gVCecsy1Zi16PzslhbEPfwNBuCJYmUll+Ps1yFcxdYhZY33P4JPCMvLokt8yqunOVVxycQ/+XVy6W8WUIkuO/tHJKcPiLVLnltFujqee4xVwbyKIuslIHaE3B31QdU0hYN2Z7wOYmeMnWIPN2wVt+U4TTbShUlb+8UkRZKlhBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BljqQEJK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729027662;
	bh=OqTqU8Th4c2EZtve0wtlJSLeEe8jvXUquH28/MfCsV4=;
	h=From:Subject:Date:To:Cc:From;
	b=BljqQEJKWIgx4LFU3U3cFw/yLG949d6MM940G86v+VDTUvqCGxPncmpF/xTkz1wGk
	 rQTUtts9YlwSf/piVOD9ECjp7+pie4gvCgppemGLiciFv9EPMEJWxvkBifxHw1nbhM
	 O0QlBdfuoHCfGfKiEcp0xIX5Veun20TgIFqCdyqa9NlUWkK6SDFA1HJmZwODnI6Kjc
	 bmuauYjjm79ACwjyM7PYwSk25zMC9Vh0Q5lFMpuZpJ56CTnePf/y34sZEAM3XsTXTh
	 3Y65S9LPRZhzTCJVoMaYWCSw88gMxc0OzBKwriSIad1rTcMj8bpQWuRHdhv/FgWniw
	 jgL8t83gmnWmA==
Received: from [192.168.1.206] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC3C917E3705;
	Tue, 15 Oct 2024 23:27:40 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/2] driver core: Avoid false-positive errors for
 intentionally skipped links
Date: Tue, 15 Oct 2024 17:27:16 -0400
Message-Id: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADTeDmcC/4WNQQ7CIBBFr9KwdkyZUheuvIfpgjKDJVZoBoOap
 ncXewGX7yX//VVllsBZnZtVCZeQQ4oV8NAoN9l4YwhUWWGLpj2hAf8iLnOId1gkjUwQE7AImJ5
 Qex7b3pOq60XYh/devg6Vp5CfST77UdE/+79ZNGggjbpz1PWG8eLSPNsxiT269FDDtm1f04uvA
 MIAAAA=
X-Change-ID: 20240624-fwdevlink-probed-no-err-45d21feb05fd
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 Jon Hunter <jonathanh@nvidia.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

This series gets rid of the false-positive errors printed when device
links are intentionally skipped. Patch 1 commonizes the logic into a
helper and patch 2 uses that to remove the error.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Added patch 1 introducing the device_link_is_useless() helper and used
  that in patch 2
- Link to v1: https://lore.kernel.org/r/20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com

---
Nícolas F. R. A. Prado (2):
      driver core: Create device_link_is_useless() helper
      driver core: Don't log intentional skip of device link creation as error

 drivers/base/core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)
---
base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
change-id: 20240624-fwdevlink-probed-no-err-45d21feb05fd

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


