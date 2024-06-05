Return-Path: <linux-kernel+bounces-201731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265C68FC26E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D171C22685
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC38135A4E;
	Wed,  5 Jun 2024 03:48:14 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8060D433A9;
	Wed,  5 Jun 2024 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717559294; cv=none; b=AYin4x6FZcz3aBMdU/xVxW8xKs4D+TH4/6HcZozRpUQLrf4lEE59rvkq1bH/ZnbTZTifUizqmJVscCjvwpygTjyt4gxvE5g+sdTyBsIO5gtRvY4uKqduGqIO9lnsElk7j6itTEsSbqQIWzjXxjoGSMWlk3tkg0e71DMdU3qxdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717559294; c=relaxed/simple;
	bh=j9OA7Ub6TkUxBfDMSbmGIFCbyIPwZ6CydduLEsssUFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DrX08dNFSzM4Edj6b7RtyOqmJLeCrzX+vYFUEIbj9mY4LMMx/3s6lDPdDrxYS1KbrM88Xu2EXLDr+hhsLKww8JVumWhU1uB3eJ8te4M7FjbbPES5067cQue3kdwtIhAvwLFAHBiP4YIWWVJQjFkH5tN6VntWK7eVpXiNmwBY7S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id F1F5360189A89;
	Wed,  5 Jun 2024 11:47:46 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	andrew@lunn.ch,
	ahmed.zaki@intel.com,
	hkallweit1@gmail.com,
	justin.chen@broadcom.com,
	jdamato@fastly.com,
	gerhard@engleder-embedded.com,
	d-tatianin@yandex-team.ru,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: ethtool: fix the error condition in ethtool_get_phy_stats_ethtool()
Date: Wed,  5 Jun 2024 11:47:43 +0800
Message-Id: <20240605034742.921751-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker (scan-build) warning:
net/ethtool/ioctl.c:line 2233, column 2
Called function pointer is null (null dereference).

Return '-EOPNOTSUPP' when 'ops->get_ethtool_phy_stats' is NULL to fix
this typo error.

Fixes: 201ed315f967 ("net/ethtool/ioctl: split ethtool_get_phy_stats into multiple helpers")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 net/ethtool/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5a55270aa86e..e645d751a5e8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2220,7 +2220,7 @@ static int ethtool_get_phy_stats_ethtool(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int n_stats, ret;
 
-	if (!ops || !ops->get_sset_count || ops->get_ethtool_phy_stats)
+	if (!ops || !ops->get_sset_count || !ops->get_ethtool_phy_stats)
 		return -EOPNOTSUPP;
 
 	n_stats = ops->get_sset_count(dev, ETH_SS_PHY_STATS);
-- 
2.30.2


