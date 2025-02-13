Return-Path: <linux-kernel+bounces-513352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B0EA34963
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DC7188929D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD12040AB;
	Thu, 13 Feb 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="xmqFW3S7"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6371FFC5C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463213; cv=none; b=sWR0RCfWnEnseUtcDGIDUnFuUJZE2oEB6AEDnWItTILcPsV/uBhrDJB73zcRhVNVzNBr2VrEYdinmpQu+sxdY/fHuu4x5nVx4qgEGT3DCW7sKRx9FSqxhhod3HvKdwGVSqEYtljOaDeBXStg5WnEqyqRv3bRh0jTMIqNnguLW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463213; c=relaxed/simple;
	bh=yNLB3sgdS87xHQMciWaz3AVPMGZxT3oXuB08JT+8bcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HzGXh80yEwgbXNNZSC35RvOjSEPHCjppXBZEHo3QxbW8nKDSnTYXLrz4433yxHLpN7rboJzxYRQ3JZLyOf7lhfoZdJ75/rSHlbxsDTz3rvfU2jPuwoGfH662oigIjp555SmqxbqQrjGlSL/lZBDwoh8n67Ai42khaCYxziLfzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=xmqFW3S7; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739463199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5zz5Vi8NhvlgxdDqN1j9JvIx+D1f7qsFmUg14o5VcyM=;
	b=xmqFW3S73yV9k2hXBaz1jmd9GR8C0I4u1XcUWYZacyueuKPlh6lzQiJLSqcoQyBFUIrIlh
	Dm2UkeUANOSsgqpKgNdyiiq0mzeO4bhtO2jDTLADJeGAuFlQkQ2Km/h0jpnTzrsvUTGc9E
	0oJgXuI01Fyyrj3G7Opeyod9DqTwKabbMWegx2Sle41WZ1GJ0t9OaV9v1OrnYDCxq6KGx7
	FXyt4HXCvZWq80buyE9nE8LrCW8mNy47FQiVjFRkYPErQovSgOJRcywkX1sqiNtZpWdN8L
	CkflSm2uCM7gU70LQW1D8DSI0pX7XLnIcpzPHE2T0Sz2Z5+lQkbLtN4BwVsvxw==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH v2 0/2] apple-nvme: bug fixes
Date: Thu, 13 Feb 2025 11:12:57 -0500
Message-Id: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkarmcC/22Myw7CIBBFf6WZtRiYFiOu+h+mC8ShnYVgwOCj4
 d/Frl2e+zgrZEpMGU7dCokKZ46hAe46cIsNMwm+NgaUqCUqJUK5kfD8oizQuEEah1r3Htrhnmg
 r2v48NV44P2J6b+6ifulfTVFCioPRx0tv7WA8jSlmCp8n8bznCFOt9QuVA4HtqAAAAA==
X-Change-ID: 20250211-nvme-fixes-29c409c2553f
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=yNLB3sgdS87xHQMciWaz3AVPMGZxT3oXuB08JT+8bcs=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnrhoclU9zE6FzM7a6MNsHsid/IfbNcuWpFSzXs
 h/awtBNEIKJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ64aHAAKCRD+/lBaCvVY
 DXb3D/9MW2bY18CKt3Ns5/u+IgnetmV4ng9f3b1f2s/abaXSeEJ3uCVlvCax/9sY65OjIX2rUkO
 845pl5rXfS6UjInZ9jkzq8IM59rg/eEVoo5xz+lUIiYNSXX5nknE2SjlqkIlO1N8D/O8Q2t9drW
 qGqHLPXCiNihPp15THNsL9d7h36Dc5yCjWFgg2FxqzF/pTlcMWEkL79nhL39FEYn/BvR4HrYQw4
 XMKL9yQKJjYExb+vFys243AAUXSb7vDHrOnBVjB5k2/cKvO/1zExdbY+Nt1uiTG3ttjOjqw7pjO
 PmtkxY9cb7WCJukbmrajUonkD5Gx7heo4Uc/OMWccZVKOzVxT1eFia9UYNrVgAaiTURa4a4XAtQ
 AfCaWpwjdjkIxzg1Ku0M4OP4jFMEvsRPeWSIiiUD5T/ljG8uCO91ih8LMRiLO5iW1AizeiiXbrr
 rypP8WdNoERXJGlcQL35TtieDwReYSqzdn7rbI5+4mnujEaGOuqZNdPgkfk3jqDgcs2ZWAZC1A+
 bt0zxfqlvYXR38IFt5FJ9wGEPVmsF/oAWSGmNxfwGTLOzPL6MneP6F7rMBJgMN76BsKdmQSBEDj
 oN1Izd42t3/XUiGLe8bxgTL7SAR/dKc87j1OZzk7eO8rJSMM7JAF1+HrgznXIRNrpnybM8k+QSy
 5wmEGez3GvpeN6A==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

This small series fixes two unrelated issues with the Apple NVMe driver.

* fix NVMe on certain combinations of firmware + machine
* fix a power domain leak

Although these are strict bug fixes, given the early stage of mainlining
for these SoCs, none of this needs to be backported.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
Changes in v2:
- Add Neal's review
- Drop cache flush change.
- Link to v1: https://lore.kernel.org/r/20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io

---
Hector Martin (2):
      apple-nvme: Support coprocessors left idle
      apple-nvme: Release power domains when probe fails

 drivers/nvme/host/apple.c | 55 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 17 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-nvme-fixes-29c409c2553f

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


