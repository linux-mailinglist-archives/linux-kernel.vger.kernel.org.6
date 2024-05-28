Return-Path: <linux-kernel+bounces-192707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17658D2100
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20BA3B22B17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96878171E4F;
	Tue, 28 May 2024 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="jcQXp7B/"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1416C688
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912082; cv=none; b=CWvRmwIVGBWWr+43M/1bx1UMGW2XqGEf0iedLzVymCj+br/cv2s6GDM5YhwYwlfVl1W3NrT5p43Hsibxx3YuMY8QzpHpE6820Nhpgnf+HKKWSvkW8C1zx3LDrSRqcIjYfvKU2QGBSz8NYgrYN8zvdoN9mSwSuGesNPOfHY1sdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912082; c=relaxed/simple;
	bh=XLoTvNeTfS0Z+Xmo5LFQXXdmRX9EJkbbxeer+BFVM1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7/8wTsCK3IYU+y3SRF3iVKvaocuncvpzqgyaTSoPYCmv7hMF5KNboYm++RjS9oadzIz+mWyvnY8yoZhJnuEmBwZqyblU6YFlR87YrhT3a2Wk6XUJb6KR5nGFlWf5KMWj84YaOQam/Dtpxh7pr/YnGM1sicQX6Q5+SK9Jo/gH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=jcQXp7B/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-529c0d5001eso82864e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716912079; x=1717516879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jw0FtTciCXQX3h6CcIOAWgqPfMRJPygWAg+dmYzhfxo=;
        b=jcQXp7B/vlttlCNFS+XMQ5wyb/JVYufPy8pc4EN5syxlBRFTkfBCpBCUSlnmv/4pxe
         TyREqBghByK7bJw9Uwn6SVqQIF4XYzO6JCw3ihWTIuxOqXqrZxVuemnCIcqaJkoDdN7t
         58F0PfcJLFWfb5/DGsT4E4TPneyNp8h6nIw6nRe+SKht1fO9P3qvPwOQC1G1PjZL0o4Q
         jTMBz8Qa49m0kbbxMeupw1yJwgRzSNhZgvHuRUEJgalhBF8/xZ1x7+YM3o8dFP1fjW3I
         71L7QqdTXR8QkojLWDrNoHTsP7Ocaijbj7UqL5e4PlhPCrmzvLuOQJTuZxTVndczlImm
         +nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912079; x=1717516879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jw0FtTciCXQX3h6CcIOAWgqPfMRJPygWAg+dmYzhfxo=;
        b=aAVji3G5KmMGNYy3jviGIc+2MK3SQccgd6mGki9d6T8c6kyy4EreyYxMb7Cjj1i7Lc
         7k15dtOQ7zM8qdCIUSsCuXauPppPdatpvQId5QuyqL43ZRNV5nFhgKTDyGlE2sp8qvUt
         DaWr+7Z8ajcYZWvLZqcCaIeHaLBCo5WdzB4/fjfCjyOGhyXTycixfv94jVi9SsJ9lm7M
         4NRx+NRZVTSXC5NJ+0OKkDqyhIEXf6bjnI0DWXm/0jAvA6kBfLAYGhhmzMfwpHPIkY6t
         3YBlw6yhs//9bVbjhu5ZrRuG+GLQYNkqih75hkK0jd+gXbgX6BbfmW1wvSUgJ2dKq3PL
         JMDw==
X-Forwarded-Encrypted: i=1; AJvYcCXEfTKI7rT1BfualfCYI9ndVP8ejEKLGfQ8iOUoPXKE85LYX+SuuGwr7PcjpncUoZRVN6fVcAeIzUQ/4jbiZeEVffAMmcPnyJco9YN4
X-Gm-Message-State: AOJu0YwENsiAlEkyeNjqyADrn1qrn/SBr37rOnhv5r5uQvy4MHmKy/Lj
	enX361+d6+rWtNOUHJeXK/BcV5odJTWEQCEmkjL9SGUrH/fffVy6/KXQne5KisU=
X-Google-Smtp-Source: AGHT+IEyQ11RRAiPP9QgNTCWBO2LMoWgZ5tDLIEbBtOI6wcxJ4QNn4AUbE6uD+dbnOOySm4vCify4A==
X-Received: by 2002:a05:6512:3b8d:b0:520:85cf:db7f with SMTP id 2adb3069b0e04-52965479b50mr10969426e87.28.1716912079313;
        Tue, 28 May 2024 09:01:19 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4f465sm621137866b.120.2024.05.28.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 09:01:18 -0700 (PDT)
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
Subject: [PATCH net-next] net: smc91x: Remove commented out code
Date: Tue, 28 May 2024 18:00:37 +0200
Message-ID: <20240528160036.404946-2-thorsten.blum@toblux.com>
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


