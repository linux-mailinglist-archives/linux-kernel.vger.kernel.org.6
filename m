Return-Path: <linux-kernel+bounces-407443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC29C6D86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DBBCB23DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEAF1FF03F;
	Wed, 13 Nov 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdKzj+iP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1731FB728;
	Wed, 13 Nov 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496385; cv=none; b=uLURNRLAbbgPRNiXmVcEZkKAzVbeXidAWOJ0vAsC6IqlobkIFfdqMfgliMUp5GQzZdcF6fI02pzZ114MIBj6W6h6u7t7o7YD7qiuOyXJ6hjNHzzDQewNPniUfMxHMC/sAUMUBhQrJKG6LjPUmC4SjhcLb710zF6lWz4aeoyqtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496385; c=relaxed/simple;
	bh=EqbmggtbToPapFNGswGMQ6P7nBdBZEPZ8NDC02vT530=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBAajv8opgIKa0DOvWeR5wWkA9uAbdFQ15Q/py8VGOQySryq42CBsvRTLwEXi83kbhbItDqDDsq5yjy+U0KciYWfeFnq/Mu2+UZAQYT/j6wY6v8oF4vQxoVFtu1U47D1BHK5f7nMkoMjTmMO/Z+ba30GFtkpDvG6DtjXp6HF98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdKzj+iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62270C4CECD;
	Wed, 13 Nov 2024 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731496384;
	bh=EqbmggtbToPapFNGswGMQ6P7nBdBZEPZ8NDC02vT530=;
	h=From:To:Cc:Subject:Date:From;
	b=LdKzj+iP//WGnb8iog079k4Eh7Zm/v3BzFyuQ+SH8GUphzAIu53gcpBXB4juKoE4Y
	 sq51y74JYFwjVF8iYqGXNIISCjpfEV4uK5dkmwua39FPi7v1ipEWvAYYAArGWQBZlA
	 WxOG5hWZ8GMK2EJ5Q2KxhFQnULEBjeyuriNQMzaHfP1yySUxWkMNLnraHYBWQQ8rm6
	 TPD4qmQtQwYcH6MKJ80PCCUON+/N+kYls7ipcLVXeN405PGUf1mVYmnFNvObwalY99
	 dtoAjbjs8it6ljNtXRL/ja+07T8fYKegp5l+ZX3DfEQxKdkL21XOHSp5a85MugsA4m
	 XunQY5clRAQ9Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Sean Hefty <shefty@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next 0/3] Batch of IBCM improvements
Date: Wed, 13 Nov 2024 13:12:53 +0200
Message-ID: <cover.1731495873.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset from Sean fixes old standing issues with IB/cm.

Thanks

Sean Hefty (3):
  IB/cm: Explicitly mark if a response MAD is a retransmission
  IB/cm: Do not hold reference on cm_id unless needed
  IB/cm: Rework sending DREQ when destroying a cm_id

 drivers/infiniband/core/cm.c | 170 ++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 83 deletions(-)

-- 
2.47.0


