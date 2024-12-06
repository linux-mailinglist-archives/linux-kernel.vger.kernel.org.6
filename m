Return-Path: <linux-kernel+bounces-435791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5C99E7C63
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D0E1886DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877B213E6F;
	Fri,  6 Dec 2024 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m9i/WufE"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8522C6DC;
	Fri,  6 Dec 2024 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733527666; cv=none; b=GWfiz2Eg4NClZzovjg3Bhkxeu8VvsE2As8SvpaDqGGJEuDCVrOGdytlHrvOa40bw0c7W3KP3o0ACzD3fimRFvz2s+mxt5fHALC1M2fA+blON+L/TcnmG9EAjqcmHpDcmKTUfKI+a2RJRFPk+7zMKBklnPQcMj+a2sarqXJvUsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733527666; c=relaxed/simple;
	bh=T/hdbAzVv7g18kp7hxGCuy92NcslPbzZ1NtmtxEqNUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4VtJdUdnYDwzOL4mzJgTuntRKSIizHz9zWVOSBUx6Ze7t0JO7PDWB0ITWNFPKL3h8jqSqRYm821aGNarFjwzPtrhj97AYR+HgQqlJ5PNWkw7d+UIRCbKDrKprxPOGGqpYMXbEkX4oGw1xkEWLmBbis8dT6PhpqinBhrMov3dX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=m9i/WufE; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733527665; x=1765063665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TcejyqLKLMz7bPyWnjBeG1tus8EctKbOLswdbH9vFzM=;
  b=m9i/WufEOPKqW2vI/r/q/4BFVh6sSO7WhAiPebIaCFWrpnF4CHx3cMhF
   2w/f6XfS2Pzm6ZkiNWMPjjG7Yy/mu/bnLsjtRvvUGpKxAgYO9V3HX4XCY
   C6oSmeRCZ8Hq3GEyAJXz7Plkwj6QKR5ZufFpDIv7+66rnfcTSPQ7U84dr
   g=;
X-IronPort-AV: E=Sophos;i="6.12,214,1728950400"; 
   d="scan'208";a="153828443"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 23:27:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:62272]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.190:2525] with esmtp (Farcaster)
 id 8c9cc2af-c9e8-477d-a247-3b3a38f3d34d; Fri, 6 Dec 2024 23:27:43 +0000 (UTC)
X-Farcaster-Flow-ID: 8c9cc2af-c9e8-477d-a247-3b3a38f3d34d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 23:27:41 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.240.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 23:27:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dan.carpenter@linaro.org>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <idosch@nvidia.com>, <kernel-janitors@vger.kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] rtnetlink: fix error code in rtnl_newlink()
Date: Sat, 7 Dec 2024 08:27:31 +0900
Message-ID: <20241206232731.38026-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <a2d20cd4-387a-4475-887c-bb7d0e88e25a@stanley.mountain>
References: <a2d20cd4-387a-4475-887c-bb7d0e88e25a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

> [PATCH net-next] rtnetlink: fix error code in rtnl_newlink()

This should be tagged for net.git.

Otherwise looks good to me.


> If rtnl_get_peer_net() fails, then propagate the error code.  Don't
> return success.
> 
> Fixes: 48327566769a ("rtnetlink: fix double call of rtnl_link_get_net_ifla()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

> ---
>  net/core/rtnetlink.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index ab5f201bf0ab..ebcfc2debf1a 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3972,8 +3972,10 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  		if (ops->peer_type) {
>  			peer_net = rtnl_get_peer_net(ops, data, extack);
> -			if (IS_ERR(peer_net))
> +			if (IS_ERR(peer_net)) {
> +				ret = PTR_ERR(peer_net);
>  				goto put_ops;
> +			}
>  			if (peer_net)
>  				rtnl_nets_add(&rtnl_nets, peer_net);
>  		}
> -- 
> 2.45.2

