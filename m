Return-Path: <linux-kernel+bounces-427635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CB9E0403
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60F21674AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05706204F80;
	Mon,  2 Dec 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="1FOEisxi"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB152040A0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147375; cv=none; b=i56V1s/QuOsTTUzlILVoj+6xnKgyN+E4g3WpNCCLK2jsHX8nsMnSFK239C8/sIGRchbbSUb6kb6acpFghIUOGZAhG+K32Q2vkGgKJj1Znwn6c7RbM9gEUNnbfU3ABGWMv/jog6UXY6Y9nuFAx4feZpBxs3003XZx4XBGW+XcX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147375; c=relaxed/simple;
	bh=4aBJjV9AGG6v/ueyNuXxKCEwqM57vbdIvUBj15x4HvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqIZ6gqkcK5SdYmQgDnanLsGK8TQcdE7yHFhEfI8jz77AnnW1BFo0Opqt2R33BdWN6Mwyr+ihZr5cNmMnwPztREGx29xxpCXQic/9azsW7tREXeWlgZk27iuuCF0/CpR4siNZAveYCNwN7aY7gsFYqcG+zkJumCIDueFhvBuIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=1FOEisxi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so48239981fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 05:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733147372; x=1733752172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utmDOcX/I6M6gZgQOmT31f/v0I8skcbfVHDvau0Ra4U=;
        b=1FOEisxi8IeZv5FtSncX0miSxtfjQCXPiV6a4To0epk0J6OBPluPKE6FJzKwaAJMsG
         sebG4bzW+1pWdJMOIxMqDJGs23DzOebc+Yjf8UG4zmfch/F0br82YIJAeTSM16pmCLxY
         g4C89tJm1kYelawNphTjRms5tJuvfPOOM19acK89J3rfeNltTxq4FdubQatpMwn4O3it
         J4F/7uBkodCrQyxwG7W3F10IKaTpG1QwSBvTpfemKvAVCxAV57fKHXrK5XviSDv1eUL9
         x3UEJ1hJunUYtVCA1UXoW4Cwdfq7s/ln9Ah79Q+mofoPwRlm7CeNFMrG/3X9jS1xvVY0
         74vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147372; x=1733752172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utmDOcX/I6M6gZgQOmT31f/v0I8skcbfVHDvau0Ra4U=;
        b=p8Ah9qRMjiBQMLQ3aQzGabJqeJB1p2fsuk2lPW3+rYX8M9/Y45UYOmnlGjSGdjPDUw
         rSC+mkdY/bU8DD8Z6KRzrl44TniihCqTT6okQ2xbQAia4jFWZHAbAy/mWE9AWph0CUzR
         WE934+kxnS5I8tg5IXryR+qr90Jw14NzNwSQ4R7ridReULzBo5deByTV6KogDK7tlsG/
         KJvLcgSJoH7rsVPkB4HvU2N80Bdl1hy2W3w7y8bFpqRcW8Z8cy0/TCAz1ekEMknSiQ0X
         mBwUbcnpPtG54WYIrgUAij/6wWs93y4zSIiPJ01M4niG7XwbPIPnKGm4r9f+YCI4qQSQ
         HCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/6XeeylsVFDCymPuXzYIvZAor2HHK5bOyrpUbq1HAB3/rg14RcjQ63Gkiwhq35eHkJQo7l9qK2d0SX3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWes2kSm4IsrGbJ80WihSZMcrQnKLYuTYe08XSM4MtM2MQZn/
	I2eU3BGPtaXglMsZIUsQPpCA+pIBdi2SYGCPF1+AeVfyCCmuGiYIewBvfyqTOziuPiURHW49IfR
	yPFA=
X-Gm-Gg: ASbGncvn4A8Z13dah26z/Xwbrc4rWRo4Zn6FBa9R49txfmvQZA9zdNUxqOjDTrbmLrt
	+IqZfoARe6IN44Dl7d/VSJU2xy1aRWMriOeCXSL4ObM5dpmJ/urTEUPodv7d95W0gYb+/jL8tXZ
	FpbpjajTajFazLaxj8EhhDiGSQ+HP7wsbPpKCG9mxw0vJdh5HCwZ5q3Gdwky5zuRE/cvHBGkBJU
	V8LwxLR8PnOl72OhxJWhizwdyRuedxisdcdFKjh9/MvamiX2A1pvPcrBFa7qefu
X-Google-Smtp-Source: AGHT+IEumbL0xz4LEy0IxGz1T5wriVQbKuAxxhzOUJEXRi0z23STaQZgb5byEvsRsYGGQEBKO7tgYg==
X-Received: by 2002:a05:651c:211a:b0:2fb:5688:55a4 with SMTP id 38308e7fff4ca-2ffd6099734mr102259291fa.17.1733147372085;
        Mon, 02 Dec 2024 05:49:32 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f2csm12972661fa.15.2024.12.02.05.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:49:31 -0800 (PST)
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
Subject: [PATCH 4/5] net: renesas: rswitch: do not deinit disabled ports
Date: Mon,  2 Dec 2024 18:49:03 +0500
Message-Id: <20241202134904.3882317-5-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rswitch_ether_port_init_all(), only enabled ports are initialized.
Then, rswitch_ether_port_deinit_all() shall also only deinitialize
enabled ports.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 779c05b8e05f..5980084d9211 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1527,7 +1527,7 @@ static void rswitch_ether_port_deinit_all(struct rswitch_private *priv)
 {
 	unsigned int i;
 
-	for (i = 0; i < RSWITCH_NUM_PORTS; i++) {
+	rswitch_for_each_enabled_port(priv, i) {
 		phy_exit(priv->rdev[i]->serdes);
 		rswitch_ether_port_deinit_one(priv->rdev[i]);
 	}
-- 
2.39.5


