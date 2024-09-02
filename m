Return-Path: <linux-kernel+bounces-310669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39021967FDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B6F2818CE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0015D5D9;
	Mon,  2 Sep 2024 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="mrDi/Zgt"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4DD32C85
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260457; cv=none; b=dap/lk1X694O+CyIBbpuHjx+420PlygTRhZP70BscnGOrK25jXTVd0Z237OoKzNREaPKwauzGNyKTo+NB3xTEW4qsbeO8Z+MVJCbFwdEaPWjxSlu+n8+EDVdA9VSFdFJJs72WPt44SmPOnJu0yYB0XFfOaIBKxhdT5DN5hlvWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260457; c=relaxed/simple;
	bh=1K/CUhSwJ6Wa3gsjl/bHFffkEaa56bHGbH3Eg/mP7wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/0wPMh1tAPC+9v5UwSmsdPyWw31I3Y/odpuIN4wg5cbFq0yrOMJ4PDxZZcGlE+6m+M8d6buDRvLWSYRPhgGMHgA7JFzUzd7Kzy4j47180ob0Yn6BiO/4XjreXeVHD2/TRlwM00H1uvD6YHfFFof6Xa69DRsATeQOiv++gs8JB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=mrDi/Zgt; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF39D69838;
	Mon,  2 Sep 2024 03:00:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725260454; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=16T8kYwpbBuW3+NAto6Jm8Gq1eiF2RMZkO+aeHQ7K1o=;
	b=mrDi/ZgtzeRmQ9tVh6O5hsOYQk+gDHZY1ZKCpbhiBwGK62Li6GFA/zm3CGMt1tuccd6dpI
	gEyEP3dTmu2HF8uLQLPoryYoSq+KPJh9OPeHxdthkWNdkQLdSB9ZhVkVrRJt89bk5JAX5r
	4sM9OtlYBQtBX2rE1dSRnZYzx8Y4uJi/M3ZTXZndVmO9jA+ksNtB5todmUf8j57R3S3Kbh
	FD09Is6E9tidyD2iosWeexU5FWna+DviFCNlwZPLuUdasiT8nmdKVtYkJ0ZVaUJ0x3oHd5
	OuqYyAIj4/3kM8IpkLEu1mhs7e0MA0MbRenHPfDGDgmhGEx8/IaB79LWs2uxCQ==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yiyang Wu <toolmanp@tlmp.cc>
Subject: [PATCH V2 0/2] erofs: refactor fast_symlink and read_inode
Date: Mon,  2 Sep 2024 15:00:45 +0800
Message-ID: <20240902070047.384952-1-toolmanp@tlmp.cc>
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

[1]: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/

Yiyang Wu (2):
  erofs: use kmemdup_nul in erofs_fill_symlink
  erofs: refactor read_inode calling convention

 fs/erofs/inode.c | 128 ++++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 63 deletions(-)

-- 
2.46.0


