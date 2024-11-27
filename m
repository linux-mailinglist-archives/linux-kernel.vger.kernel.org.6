Return-Path: <linux-kernel+bounces-423341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644D89DA610
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD14B21D93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A8F19884B;
	Wed, 27 Nov 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3/wsbKR"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735D145B0F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704224; cv=none; b=gLtHFOSZPqlFg+EMoJivbny9WZ6dsA4ycfTYZVAKYE8BhCMH1iK5/iN9WGEPUPOFF3lKkNdUitvfdwyagzcRpq3ULiEc5Paai/jSWL+PVDHymtHPeXdrk/5a4wgZUvTkJcJXvdzTRPCXch8pl6HgwgLK7HKBDayaebgeJa2Ld68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704224; c=relaxed/simple;
	bh=pNCvTr15h54rXqFAxHFqLQGy0rcXtDjwY1aAYWGsTpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NUsSe7c56LbjAXixFDJ4y1Ls/dYoZXrugUk50QbKUl0W/MyFssUM7vc02N+w/eWwJOLi202cH6m7EHdWH4n1VkwZpwhvvCQJ4CblcKaDPc8GUZBPUbE1wIA3A5Z2fzvq1UyjfIlOj6rgq7drHvBwq5giQBajYGyZeyh76fvjX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3/wsbKR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724fee568aaso3702469b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732704223; x=1733309023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzCk60ssLnzRtG4kB4XwKsk4zCPWkQgHAif9YUyJxD8=;
        b=X3/wsbKRwcRfEuiQ4/dMyPP9oyaYEw9u56T7qq0b8n6uf0EfwfuVLMPhGCWBTalyGe
         doycFat3nU6XFknVor+BEczeiomd/Ghky9np3on6gHN6SEZge/sPAnpJQlYU/YP4Vof4
         6WnuHkNGlItbKybQeth2dAploiomIK5IlVlv42cCy7X+9NEAy7TQWqgp/E/8ocpAN+rR
         AHPcHaSbjiLUXqKQMetbAln1Rq9QUvKyrV2yPpDURAlSchGz4lXfKQab0O72OJFE98RR
         wqc5b0z0s117sNeDzppKs9TyJoR9xQmTySIIWkaumasQFtPpedDP7FOEerEFXs6J7N6p
         hveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732704223; x=1733309023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzCk60ssLnzRtG4kB4XwKsk4zCPWkQgHAif9YUyJxD8=;
        b=GJyfpmCQckQRT3UGonkNTE/SJ3vNw8Iv5s+Tb1mGMyQ11r8vRep8mdi83R9wVDBgC7
         H9JTWtS4XQyquVsq1j2A4xrVJsEj/4hyjb6B34TMoX1IEJBH64S+NyONl32mp0I9sDHP
         hlmCQszayaftxLKeU+cNL2VGe7M3xNclrf+vfDSwqCIu/lcxqRizCBsjBVm9K9VxhPTd
         YS+JQUyEyHLIkLXbxdQkp1fl9tMkZLZPtA24CHJb+wTLryw2A3v2LsQaH3LDPVmWJOHw
         cb0poxLGP8DzE0BSMc8QH+hK5/fMuicNS5P2+Nmr0Z0O6MNGXlPIZQVYHa5hgYGSw/2m
         a7kw==
X-Forwarded-Encrypted: i=1; AJvYcCUfz1KkNMNRHMaYKTkg+s/Iq3V23a7LOu728HVfAyEQm+biqdjekjyEX6KlvEAI7Sx+gTVfV6SEQASJ1no=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVGVvuIqe8PtyDPZQXhxMW6ORriEzux+w/OSrodsWAF4mQ4vv
	2S09ERGe4ExPzl8vxZQvcznQgiXYPyO+nrwy6ZYJQyM61XXGPAty
X-Gm-Gg: ASbGncuSG9eKo30y9McBOu4MQT8xtFV2vevsiQoPpBqauyd19vogVDTFhYYCYO7ga6N
	3pXBem9bSjpd1yqRIM6Dh2nj9aiixNHzRTLrbuzKyLmM+vlyg2dVXPnw/2HZEsMNSow9QHxzGNh
	CofnzXZ1BioOKga0FEtwpWooqvgKyUlJsLSkFm2T7HKlxqVznglz685slcgf+LR4BCXINqTyZCM
	KNxYufYJxOmhj9YlI6hoeVCXXLZDaGN0xt0CJV3qQHSQxvQ50oBMwcVv2xWg1VY1g==
X-Google-Smtp-Source: AGHT+IFasGDwkTah8VJCd5YqVj7arrUVACm5XfE0BZ2QCILBn6viPi1c/IWF0UOE2Q5hAg+SnGy9+g==
X-Received: by 2002:a05:6a00:14d5:b0:71e:695:41ee with SMTP id d2e1a72fcca58-72530013a73mr3817487b3a.5.1732704222532;
        Wed, 27 Nov 2024 02:43:42 -0800 (PST)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:79f6:179c:470f:690f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de572e50sm9905806b3a.172.2024.11.27.02.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:43:42 -0800 (PST)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stefan Eichenberger <eichest@gmail.com>
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH] phy: marvell: Fix spelling mistake "exlicitly" -> "explicitly"
Date: Wed, 27 Nov 2024 16:13:33 +0530
Message-Id: <20241127104333.18944-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake in mvebu_comphy_ethernet_init_reset
comments.

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index fefc02d921e6..71f9c14fb50d 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -422,7 +422,7 @@ static int mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane)
 	/* wait until clocks are ready */
 	mdelay(1);
 
-	/* exlicitly disable 40B, the bits isn't clear on reset */
+	/* explicitly disable 40B, the bits isn't clear on reset */
 	regmap_read(priv->regmap, MVEBU_COMPHY_CONF6(lane->id), &val);
 	val &= ~MVEBU_COMPHY_CONF6_40B;
 	regmap_write(priv->regmap, MVEBU_COMPHY_CONF6(lane->id), val);
-- 
2.34.1


