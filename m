Return-Path: <linux-kernel+bounces-310845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9999681F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7961C2202C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC6185952;
	Mon,  2 Sep 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="mvN5keBm"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC31865F2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265915; cv=none; b=sDRxrdbG/R8UrhjdT/Qs/SN8YbDELD4BnHxXlB//AzXsXmc9PC4xBc/GEY+GhWWkzrl+fBFZRnTf09dz/3NJTOm6vzQK40+Uv+WAhjXCUIEqN3uTI6ccjmLW2V0O/D2Mr64geiXvLg4afTTNRPd2qbScpui9dpRcwO5KiLqdG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265915; c=relaxed/simple;
	bh=3nKyRaFW3kfaai0vAY2IQhgi/W3ICdvo0dr+/wwacxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmMUukLuP8biN7vp4YqSDJ+iGsF/e97LDgZQWSRR6bl9h0pVTm8Ebn6qVdXek6ixlWZFFV3AO2IaUpyYuqt5V9Y1IlFEiYgO/aBzdooit+9nA7ppqleRDL2JRuJCZll+7HKF76X2Qx9ko/9KTCttv857ucbTZwrx533yFLvKY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=mvN5keBm; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 164C869838;
	Mon,  2 Sep 2024 04:31:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265913; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=oKPn+zD0eRJIX/o2vrVRDLstxl6jl9/PbkerZfe7CPw=;
	b=mvN5keBm9kXvDGR+Ls/tCOgV6wqsrc9lZUmsdhUAaK1FtEVrlgip8O9TxS/nQIdG32Mwh6
	R/vjDB4sHLMwhvUXWi/MS0lay4Uu2s/tQb5AulDBwaUZh63mpAhylgLzdMedkFXRP3StDA
	dvjRmOTnYDbSbCmmopR1CJU4aYoQ+7s4GlkIXexATl8czT9yCSYjxQX79ARHOSnTAXdXCx
	4ntmCQ9e7luqx+lAD4v5t3R/dMpL3SuFESXkRdRnlt7TwxG+Vkzjx4gGf16UvNOyhGn6e+
	m6qGK3KWqSw6/he+fF+BRRDjo1UCCQPpumntPnF0VPMrVYHZKGqFT+z5AKBiuQ==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/2] erofs: refactor fast_symlink and read_inode
Date: Mon,  2 Sep 2024 16:31:45 +0800
Message-ID: <20240902083147.450558-1-toolmanp@tlmp.cc>
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

Changes in V4:
  1. Remove out_unlock in erofs_fill_inode and use early returns.
  2. Fix missing initializer for erofs_buf in erofs_read_inode.

[1]: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/

Yiyang Wu (2):
  erofs: use kmemdup_nul in erofs_fill_symlink
  erofs: refactor read_inode calling convention

 fs/erofs/inode.c | 133 ++++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 72 deletions(-)

-- 
2.46.0


