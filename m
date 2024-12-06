Return-Path: <linux-kernel+bounces-435488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62CF9E787F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E09C18885BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE22135C9;
	Fri,  6 Dec 2024 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="wEASQgyN"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33021206284
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511652; cv=none; b=Vrj78UPKhvHpj8pUaZRLdJHIt3xzWR0vrkayPJNU1n7msY9vDH+qYB7rHYsbECabzSSw1RkpyaKMteJK2HYG06Sa5uWNPa6XRH2HeFyEJD3pkI/GqOF4GqMeY4ZS8SC9ipk9u/5xvED3ro+uY5Aq3uemQ17FpKqVELxqJRQCJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511652; c=relaxed/simple;
	bh=Oug/7vDlEmuLkveQoKotO5NLIXni795nVP0v+lTs4CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULBoVsY7yqjVCrEDmKzNOWVpnIUakjlXz8OKbHSrUTLAUbIVyL702R1EiP6M6yjFFBSDkUbaVp7gvjfDIMzMJT+M5X0ybb8726h7QQ7Hjt0r7cFVPZHPRqP04IqPrQ3JkO8biCzi/ADojccujIPGXaPRTuYNQGQ/YtpZ901ZVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=wEASQgyN; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30036310158so8157181fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733511649; x=1734116449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRtfoUuaiSmawV3D7PM8LTv0BVbgF0vB56WhOBoL48I=;
        b=wEASQgyNpo/yZvNu4FM2FZLwukUvTjSW9Bl/iKuQcPUEyujzJw56wyhxTDtFdUu/kU
         /lDpZCo6Tv9vBIBLp3a6MIMjWtKYOedZ0lZygTAd3er8IydxKPS1zFfxHt677LsEHc2l
         vmj0Ohc9O5PRfkUwsOuysxr4H9agwqA+gSZ6N71jKXXvG6ELdBDxcPk6bwywUU9mi3TA
         jHK8MWGV77x6IsOVrvr8YmC4yf1jG3qJejXX85VXlwMwRS6KsEi5oqXZ2yCP0xag1Ird
         +ilT8UGBC0IAAZiLtx0obj/EjinkLj6nEmxwhTNJ0SYq+EJNJUzP3508gILz+DOydElq
         i3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511649; x=1734116449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRtfoUuaiSmawV3D7PM8LTv0BVbgF0vB56WhOBoL48I=;
        b=Pgt7sh+81hWRhme+7KmOQSa1BgrcpOeJ11vwrhdcwheSjsbm8QbXtC70oM+YfLfxcE
         PBFoPEj6fYCRrUDM7Sr/UfAyEQabKUmqKcc0Q7/mAmwArpBCXE9+FtzTiuGAnFS1hwZk
         yhrN/YqTk+n9nQLKdhceZCtVQZDZoyVC+fRw8nU+kXaSLqudIFb3FLJtuAsMcfzOQrAI
         3tFepSW6RN2/AQMx+Sm5e/ub7OCx4lf5bB9Ud1s2NlwzFyrI0wCV0pcrDcPWopzORhsn
         dYiSvdjlImqHP4ft094XxMJOh+JP+iLND/VzaUtt0AZrzGVGHK5e7OO+LMQ2dZQ3C1S7
         xWiw==
X-Forwarded-Encrypted: i=1; AJvYcCXSNnOR/8Exhi7zHDpSMRmARW031XSexfuYQruVUFpdHhgtR7XYpdB3CBLK6UHqJEP7E1qNJhLm9Gf9Z5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi46Ul9kKnDEpo4s98EC2Iw3+2/OfdL4Fe4EvhaVC5qVv0B2YP
	WiJ602dsn8wt/QKVGNIzTAdnyGrR7pfcM3OYRtbAK4nCUGRG92C7uTQ6XTasCyE=
X-Gm-Gg: ASbGnctGqjP/pZTbF/ND4iw/MvfpAuktHK77kMTc5n5Boxx8c/riyvMjATRrxG9nOSb
	capw+3FKqJg0Xr9vw5AjDqUJxIsKy+fQdaT9aAUsrATDHYSEJ/doyxtgz/4OHknMyZVOLxl62g9
	UrEml1LSX6eGCcyLA5tvgumq6IiNLGBUrRcv2FqUM0/qSVHR4Ixaf3qKkzx1dD4gjRLbLI8dFDW
	HW1x/apsY2aCK28xzBWX89EfxraeLIh7m3phwcMHh/Zp13NuKiVSRN9c9w549nj
X-Google-Smtp-Source: AGHT+IHHUgZX1u6gj5ZZhnbZvFvdFxtWjem7qzmC9NdGd/PDARE/4bpEVRG4Dg3PrMiq11s8UCNfVg==
X-Received: by 2002:a2e:b88c:0:b0:300:3a15:8f26 with SMTP id 38308e7fff4ca-3003a1592e3mr14869321fa.0.1733511648446;
        Fri, 06 Dec 2024 11:00:48 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm5523201fa.113.2024.12.06.11.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:00:48 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net v2 4/4] net: renesas: rswitch: avoid use-after-put for a device tree node
Date: Sat,  7 Dec 2024 00:00:15 +0500
Message-Id: <20241206190015.4194153-5-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
References: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device tree node saved in the rswitch_device structure is used at
several driver locations. So passing this node to of_node_put() after
the first use is wrong.

Move of_node_put() for this node to exit paths.

Fixes: b46f1e579329 ("net: renesas: rswitch: Simplify struct phy * handling")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 9c55f3480678..57cf211ac1e1 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1892,7 +1892,6 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 	rdev->np_port = rswitch_get_port_node(rdev);
 	rdev->disabled = !rdev->np_port;
 	err = of_get_ethdev_address(rdev->np_port, ndev);
-	of_node_put(rdev->np_port);
 	if (err) {
 		if (is_valid_ether_addr(rdev->etha->mac_addr))
 			eth_hw_addr_set(ndev, rdev->etha->mac_addr);
@@ -1922,6 +1921,7 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 
 out_rxdmac:
 out_get_params:
+	of_node_put(rdev->np_port);
 	netif_napi_del(&rdev->napi);
 	free_netdev(ndev);
 
@@ -1935,6 +1935,7 @@ static void rswitch_device_free(struct rswitch_private *priv, unsigned int index
 
 	rswitch_txdmac_free(ndev);
 	rswitch_rxdmac_free(ndev);
+	of_node_put(rdev->np_port);
 	netif_napi_del(&rdev->napi);
 	free_netdev(ndev);
 }
-- 
2.39.5


