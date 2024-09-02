Return-Path: <linux-kernel+bounces-310791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F14968143
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF761C208D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADF417E017;
	Mon,  2 Sep 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="mIJRlvSU"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45EEEB1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264269; cv=none; b=bmnbsWoWvPLJQfUGB6328G3T/hdAHCMREnzTEcYwraPFltEiUD/4zeYCozgnEQUBU1gBIm0IGno+zT5ZNxC2/QSqjDXkSOJegv2Y2r35wjVYbUZsTsj/6whNrNYAYa+a0svR+eaeiliL1q14/u2/E+k/VGGTZPf+UEj9bPk65q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264269; c=relaxed/simple;
	bh=I1uDb/QQs3xflBmAMYK4vgToSXc7iz4/D7vDVfKRBe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VEA3Kxdi+H794X4fNtUOpoHCy0eleclDoQt5CkNQedAzuMSPOztD7y7lYJ1toKWffmbYYmQZLU4oPJbOjQnLGmtCeXSRUb1/kHybC8D9p87JStwfowwbTjQzX8Y4n1btQbxk4zYYbTxy8xDBtJEttYga7JaFN0NX+1b4vlrmAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=mIJRlvSU; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E83769799;
	Mon,  2 Sep 2024 04:04:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725264266; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=wFa0bUtxKzChSqtQYzvAr8PoFVU794YULGslHHrtEsw=;
	b=mIJRlvSUS4KZ+4sN9KyZk1kedcft4xYmYViJ8wa/d7ShbOX0sXbvbxZT/CW7Y9Fd1Eej5f
	qy5eTgqqUPWphFBCc7IxgDiuO/V6lKia+4rubmgcz3ydksUj91qKdr8XH1SsLRfVjUHglz
	jeRxavKbfXTuQHQeGWeUxPZ9reyWimnS8bgSBfwaRz8NHB1kj6U8ZYOiGS6+DcB6Vf77b5
	OdoDMKUbw1nfNI4kKQ5qyR59wRtNxWdsgbowT9+7mn59w5Sw4BZkcHG8GAhmWxgJ/M8Xx8
	xcFCjTeYebzFwO83UjWLlBRABbuSziwnkrCdihfEhHGE/8dAbxUi0OiYxqZCPw==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yiyang Wu <toolmanp@tlmp.cc>
Subject: [PATCH V3 0/2] erofs: refactor fast_symlink and read_inode
Date: Mon,  2 Sep 2024 16:04:15 +0800
Message-ID: <20240902080417.427993-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patchset is response to the original suggestions posted here[1].
Since my later work is somehow related to this issue, i think it's
better to deal with it first.

Changes in V2:
  1. Lift the erofs_fill_symlink patch to 1/2
  2. Fix code styles problems in read_inode patch.
  3. Fix the formatting problems caused by clang-format.

Changes in V3:
  1. Remove some redundant variables and statements in both patches.

[1]: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/

Yiyang Wu (2):
  erofs: use kmemdup_nul in erofs_fill_symlink
  erofs: refactor read_inode calling convention

 fs/erofs/inode.c | 126 ++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 68 deletions(-)

-- 
2.46.0


