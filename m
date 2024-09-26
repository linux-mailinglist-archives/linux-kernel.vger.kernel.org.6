Return-Path: <linux-kernel+bounces-339878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38E986BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5517D1F2333F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621917BB30;
	Thu, 26 Sep 2024 04:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hdBPE/l7"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7431D5ADE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727323934; cv=none; b=A95bLtjzj+qZcO1mOYE6ecGU58RahCNivpTu+UgFq2uHJTIxmnULfb8XQCHd0HBxzt08imomcPbG1Z92axvkSs8nzAvJiDQwZAkw+LOcKxUEXIsVgq4Cfp9HGEUmKKXP37QX0vRB8jcF7E4mGdTkuF/JCfDwW/iwDaY1bk46JwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727323934; c=relaxed/simple;
	bh=Ai+sNxKt65jRYZfAqFem+qvcH4ORQMDKzhQeed9xx1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJSXqeP0Ef1ISAzOhRflKN9otDxvkcAGxA+b9c1BncowgSK8rbLBQ1Kt54Py/z/tXLCHXV8QeH5RS52rBOtrnB+GM/DNSTcXRDv1s6YLGxce2y7GcYXC0DgDpamz2hQbSRfGbP7Kuv+m3xAPIO8AGy8Z7VKNH7TFww8bhbISuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=hdBPE/l7; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F2C622C0184;
	Thu, 26 Sep 2024 16:12:08 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1727323928;
	bh=5+N3Q+STZnboiRAOIS2diw/bn+Y79sn4/8AIq/uxpIs=;
	h=From:To:Cc:Subject:Date:From;
	b=hdBPE/l7hVZyv4ps1Tc5OiT1twY3Lq+bReYFdwv5E7d/bXrm74++t9s2TZgaDxvLS
	 /NjemePfUOUHrISysf34Zb83OnqNx93atxahsEorHT3mWK6LABbEMowKQ/IUWThqat
	 S92nzYr6oCznfC5gU8cU/uIgNIH5Azpv5VTNUZvmNz+AqI0+7VfSTnEQEiI2nGasQZ
	 b9fc5QGRJfRnRXQAt/mR7fq8xB8E9k5zP6yYifZqMdFnLCxyCKcRKbqEfyq4TDYKmj
	 nS0zEVg49xLT4I4BzNdHtb2/2KUbubGFXXGu+IS+Ya+QJCKnF7HOgSxWPxOflAhcFh
	 HkroykmO5bzqQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66f4df180000>; Thu, 26 Sep 2024 16:12:08 +1200
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id CB23F13EE36;
	Thu, 26 Sep 2024 16:12:08 +1200 (NZST)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id C92FB2A3C0E; Thu, 26 Sep 2024 16:12:08 +1200 (NZST)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Andi Shyti <andi.shyti@kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aryan.srivastava@alliedtelesis.co.nz
Subject: [PATCH v8 0/2] i2c: octeon: Add block-mode r/w
Date: Thu, 26 Sep 2024 16:12:00 +1200
Message-ID: <20240926041203.2850856-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=66f4df18 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=EaEq8P2WXUwA:10 a=toHKM1xulaPNuss4LNwA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add support for block mode read/write operations on
Thunderx chips.

-Refactor common code for i2c transactions.
-Add block mode transaction functionality.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
Changes in v2:
- comment style and formatting.

Changes in v3:
- comment style and formatting.

Changes in v4:
- Refactoring common code.
- Additional comments.

Changes in v5:
- Further refactoring.
- Split refactoring into separate patch in series.
- Add more comments + details to comments.

Changes in v6:
- Reword/reformat commit messages

Changes in v7:
- Fix typo in commit message.
- Remove usage of r/w and hlc abbreviations from commits.

Changes in v8
- Updated refactor commit msg with more information.
- Rebased patch

Aryan Srivastava (2):
  i2c: octeon: refactor common i2c operations
  i2c: octeon: Add block-mode i2c operations

 drivers/i2c/busses/i2c-octeon-core.c     | 241 +++++++++++++++++++----
 drivers/i2c/busses/i2c-octeon-core.h     |  13 +-
 drivers/i2c/busses/i2c-thunderx-pcidrv.c |   3 +
 3 files changed, 213 insertions(+), 44 deletions(-)

--=20
2.46.0


