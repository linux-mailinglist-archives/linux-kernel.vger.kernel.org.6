Return-Path: <linux-kernel+bounces-190448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFA28CFE70
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF73B20BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7213BAC2;
	Mon, 27 May 2024 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="KGfrfms1"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36C326AFA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807398; cv=none; b=VCo6VZmfgSjCS0VeZFzZXRQg1H4EljIWXOK08rkOxByfsRPYJ2S1CPvESxD0nT/qjBxoSiXe58tY2/cIlITD4Js1xng/gUwj9tLP0+bmz6IMtWb19vMTpktTjAYZEvjwPMQ5C3IEo/mMuC3yPR3LICJBcmBs5USVxoFyEFihw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807398; c=relaxed/simple;
	bh=XLoTvNeTfS0Z+Xmo5LFQXXdmRX9EJkbbxeer+BFVM1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrDXlG7TqLDNt8lWfLZ3MHVj5mtnaXb3bndNyPn+k8Nw1ahWSndW76fVz+HbjaQJjT3nH8idXpx1K0U0Dn/8/8YQCvuLaSCypdvuWZIcZTJ+lDuCi7cRDdQSRFstJY9xD/vkuyXfueMWxfAMX4EjcJcpyy+Vs67NRZVapie0TzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=KGfrfms1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57857e0f465so3146814a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716807395; x=1717412195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jw0FtTciCXQX3h6CcIOAWgqPfMRJPygWAg+dmYzhfxo=;
        b=KGfrfms1X+UnFUNtYLi7jq0LzIB6HwvfbrnrsNhHzO2IefNMb+LXLDt4+d9uQqUmht
         GrmD2no50wAJHFO8h5JHJDq4MGcfuO3fzz6LdZEyTzZ5me7z3ZNeJRj78wv3JoArZiig
         bG3exEjYdmQmFh7SAOVJFkgATQ3YCYLvMXmWSjWqmYiLhFUgqDd6qv0b7z4IldTxTJ41
         sdnTEPLRW7eShK+v+KxqEySx8O9O3fnc/2QKJqJ66fpSK99syNKX21adnVilgg8q80dS
         v+R774ONG0lF3BdRLiAbQwZMSJ+gy0ubEXAh+bG1nekEgedbqAS0mE4FksYVYlPy5lv6
         ovwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716807395; x=1717412195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jw0FtTciCXQX3h6CcIOAWgqPfMRJPygWAg+dmYzhfxo=;
        b=Lz/WG+jrwDjmv6Fcofk6P+yHriKImE9XPTqTXc66AhU3NEzWcy4gU6BUxRyKMkyF7Z
         1uobnr0Ub99U900qHiXJOGR1uE20gfZw6AKnUDnRfvJFGStMrJp88okLT4NRTIDIoFsU
         wn4v1CPnflHIKZNltglgcLwjKdG99hvBAOZjEbl3Du4WTUK350ukigSORviT/yqzYjc4
         3U9NlLS6ZAjqw+zuIqxT0WHcnPwQO3cbSGyzpLv+cF84P5s1OwCg179TsX7MzNzLjkPI
         OT5KfrGrNr+2W9fUunQfGwvG1BAFDugJVlLbDZRjEg8P1N6IGrD/RvVn48khRwjXAjd5
         rSDg==
X-Forwarded-Encrypted: i=1; AJvYcCWgvXnetOAa/T9EqKdvFJZpC2dxQKGWZ4gjURFd2pvGZdGNIt2yTO+iCMpwtCsyVx0OCsbXW0j4c1tUg9jCs5PGrb7MEKZu+ndEEP4d
X-Gm-Message-State: AOJu0YwNdYdi5u2rfo4bLr+fODhZnAx2aa2QMOMsMNAaU8D928F3Jx2n
	wtXybS2PmjHKSjV6I4KjZO2diLOlX5Eq7JnBL95IJikCilf1OqkOS6EH2z9hJJ4=
X-Google-Smtp-Source: AGHT+IGlBr+lrKmneJwsXJDybFQCF1UdYP1AaUzjy+aTvC1Qzbd1hN/9MnflALOBxAmHv0rcPKwLZQ==
X-Received: by 2002:a50:9e4d:0:b0:578:5105:5ecc with SMTP id 4fb4d7f45d1cf-578519b7ee2mr5364221a12.37.1716807395099;
        Mon, 27 May 2024 03:56:35 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bc547sm5624412a12.96.2024.05.27.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:56:34 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net] net: smc91x: Remove commented out code
Date: Mon, 27 May 2024 12:55:58 +0200
Message-ID: <20240527105557.266833-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove commented out code

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/ethernet/smsc/smc91x.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 78ff3af7911a..907498848028 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -1574,12 +1574,8 @@ smc_ethtool_set_link_ksettings(struct net_device *dev,
 		    (cmd->base.port != PORT_TP && cmd->base.port != PORT_AUI))
 			return -EINVAL;
 
-//		lp->port = cmd->base.port;
 		lp->ctl_rfduplx = cmd->base.duplex == DUPLEX_FULL;
 
-//		if (netif_running(dev))
-//			smc_set_port(dev);
-
 		ret = 0;
 	}
 
-- 
2.45.1


