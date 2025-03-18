Return-Path: <linux-kernel+bounces-566269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF22A675B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FE21886EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317420D516;
	Tue, 18 Mar 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riLEMBC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226542070;
	Tue, 18 Mar 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306188; cv=none; b=HonU47Nc3+hHVK/lyDQSl47DeYCftbdXGqZyR1Ns2HhQS6Taolgx5ZgT4RKoz1ilXYS+Gu6vf69398zD1TNWuYhVuPMNADGxN48rpIhv8o8qu1OrC1ZahPtUswqdO1x9eWm+h5cg8pah3u4FfdRW/2AVEN5kIQMBOM7KmULgV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306188; c=relaxed/simple;
	bh=Ww9exGMmO24xwS8PBP7zFZYsmBxOqJ6sUrg3JmGs0g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s5ybeiXt81ughGUudtlhAU8N54yWYQZtGkQR5apBUSg9Hw365eotGCvDPNFGrQtvTjlrGOQzl54n19HHXMO1WfJe7wHg4PRj1nJWEiZ6c3Y5XNx9EtdEtreZKIeVv16UHq2hlyc57+4EbCIRy4KOEcsUmO/MBvUGrq4gM7wCiGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riLEMBC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB882C4CEE3;
	Tue, 18 Mar 2025 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306188;
	bh=Ww9exGMmO24xwS8PBP7zFZYsmBxOqJ6sUrg3JmGs0g0=;
	h=From:To:Cc:Subject:Date:From;
	b=riLEMBC4qMlzl6NK2AZB6ieXptvQVEJwI+XJPgRzSHDIN4UfLjPMxLnEVy8UZMwr9
	 rI3yYJ6azfunLbiJS4tIh2/owjbDo/Il41Y9nt8ed/ebjo6/lfWGGH0zMlqJnWIrre
	 kcwHgFazQ52LpagPcZQZA5X2WxwcqBPOt/M1FDRt2dOaOz+T/c6H9x5yb6twW7XwGR
	 CxDppA004RgimuxSgsXa/kgWBo9+psWWc4SLX44T6fRQX8iMsKHI/pc0byVN9dCt2v
	 YvaIeUMAQvQpJjAr8n+1ygXUG1/zA0M2teedqXOHH/WMCh+HBARNs8TIpsL6ttn1YY
	 9ZjsnC54bIhvA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/2] rcu: Random updates
Date: Tue, 18 Mar 2025 14:56:17 +0100
Message-ID: <20250318135619.4300-1-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Just a bunch of things I had lagging in my local queue.

Thanks.

Frederic Weisbecker (2):
  rcu: Comment on the extraneous delta test on rcu_seq_done_exact()
  rcu: Robustify rcu_is_cpu_rrupt_from_idle()

 kernel/rcu/rcu.h  |  7 +++++++
 kernel/rcu/tree.c | 27 +++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.48.1


