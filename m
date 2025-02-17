Return-Path: <linux-kernel+bounces-517031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79BA37B21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3845316DA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71D191489;
	Mon, 17 Feb 2025 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HpTYJ+B2"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77D1885B4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739772023; cv=none; b=DZFu5HCuP/HYXGyXi9k/iGkEcA8SyBtiPddP+WzJufTs41Elgj6j2v9oekV8hfyd537puBp0ja2aREdyjWtX7UA8TBVT0TnIVg/raStQyjKlBMJOTPa7MFmJJb1DgC/gpJpP6ird1ueeq09+WBr8XI1hyUe54WwSGRLaHWVIpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739772023; c=relaxed/simple;
	bh=QfJsyVg0VP0z/iFwR8gySbOpR88WHfuxjwMBTCbk9dE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RP9hNGvJb1VLcAkxSoNZLyeP1vh+m5d/0Rub4k7qs5ZwAmR3rfRsM8vpSnerhfgJ5JlYthVYmFqK4K1Pz6Q7i7WIW+9NA6gqWPTtatP/cAe6tpeViZRBrGxBSfqKm3NftzmARPR7w1Kzw89sKtlSzl5fTeuw1iU8cWHimIqUDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HpTYJ+B2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471f7261f65so574091cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739772019; x=1740376819; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNLaZYweysNghkTQQ5vEunIOEfjB7A4eivqMKKKSU0k=;
        b=HpTYJ+B2RYexiJRyXZ7LNvpkYlq05nAbW0kOWe1tX7hpRIy5uJz1mVbaudsOEis3w9
         TgRtWEJaY+B9UvzxnHQ+WImsEas/cvZW/umloO4eLn/ai36SXmlZPGt0ZYj4DuKSdtAX
         bFj91dYPT9Rjh+VCNb7M05KNyDWIEddRYI+wgemDPVwoIw9SgbP3jlmC+aqQ4NHTBicO
         wcGqHywE1WtWB7gmNPo8EF7WOFPrMg9oTeKQ/WkwRj5Kt5UQjNGVuJNfimWEYg4bTszY
         xkMQqRMb65vImrV9FOKm3JeMHRcM7sUwt86IeV+ArFqkfooVkFXypg9E7KnKA8IAlv+Y
         mI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739772019; x=1740376819;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNLaZYweysNghkTQQ5vEunIOEfjB7A4eivqMKKKSU0k=;
        b=P5GIAOcvpL+ugm6b7113i+W3MAsJsuSXaYkOHbcF7JDJ9Fbe5eTpgkopNlyncn494e
         7svrPwNH3NqXVSsfOG7z3+ps7V82J5i8jQoxyESmNUForABekU10K+qq3DmvGr7NvKHg
         kOaQvrrQKOQQFq6cqIsVjVcaP50rH1hE8DmWXvsDDA5tVIIlGkEkZHn7P37hD5JteEX4
         pjgVgwgTiRpwdFDZShIwjhA4He9O14r51qqbJYbIcYvjga+E29GjnvJwF5Eg9dPq8qHO
         x8/kvEaq1n7sOaJb8XrXVKJrXHxUVXarjp3R5HwcMWAjVw0s9OJaQ1EOr+xRwZkUbnW8
         /oCw==
X-Forwarded-Encrypted: i=1; AJvYcCUl72qvOWy3IZ+reumSCIzZko2fDs9DqDT2tSi7I6VmOtckIfwo37c57+4k/I7u8BhAsjIPcILu2E8Cpgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhN1eDX46SedWPGMCl8+laZDvfhEVaZfvhCVMjhkYiK6QhwOgu
	w0jK+fg/iCqT0cRelu8e3EAVnhz8E4BZnspQwaDQgOb/sAw1AIEVLB5Ezj/kiIo=
X-Gm-Gg: ASbGncseQ+2I2GiWNUQXysnQpjcS5cjRQF+UGheDckHJeKUxWK3H19JO5EDWUqAZLrI
	Qs/eH9zPXvqUkJZdMYNihworw5LzXWmqc+tyY8xGtxwEn33rFobNSTjgcx/0v0ApOBB/ZTZ1sbx
	U318/gnhzWH6/SuEVHG+tlYpTQhbzFB7yq7+uiC83JnH84+tvrWiDLHVS2TdVOmzJplfhB/sYyv
	BJbIKMp39zP+zArI8Ihd29macUiyoh56gz+1vXGUX+59x0a873C+engmvGUOSP0g8TNMrFRuF7o
	3SJebQ/hNqkqJI36df0PGxPBJwlC6yRW9RcflQ==
X-Google-Smtp-Source: AGHT+IEa/Pzs7CbSJS6B4jiAkbAvdqUHWHU03XvpyMfamqGiwX7MVgYWBqRl7K2/oJni/7AC6EA7iA==
X-Received: by 2002:a05:622a:8b:b0:46e:2d0b:e1bf with SMTP id d75a77b69052e-471c015077bmr226327871cf.11.1739772019591;
        Sun, 16 Feb 2025 22:00:19 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f6674aafsm1396881cf.76.2025.02.16.22.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:00:19 -0800 (PST)
From: Nick Hu <nick.hu@sifive.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Russell King <linux@armlinux.org.uk>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Praneeth Bajjuri <praneeth@ti.com>
Cc: Nick Hu <nick.hu@sifive.com>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: axienet: Set mac_managed_pm
Date: Mon, 17 Feb 2025 13:58:42 +0800
Message-Id: <20250217055843.19799-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The external PHY will undergo a soft reset twice during the resume process
when it wake up from suspend. The first reset occurs when the axienet
driver calls phylink_of_phy_connect(), and the second occurs when
mdio_bus_phy_resume() invokes phy_init_hw(). The second soft reset of the
external PHY does not reinitialize the internal PHY, which causes issues
with the internal PHY, resulting in the PHY link being down. To prevent
this, setting the mac_managed_pm flag skips the mdio_bus_phy_resume()
function.

Fixes: a129b41fe0a8 ("Revert "net: phy: dp83867: perform soft reset and retain established link"")
Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 2ffaad0b0477..2deeb982bf6b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -3078,6 +3078,7 @@ static int axienet_probe(struct platform_device *pdev)
 
 	lp->phylink_config.dev = &ndev->dev;
 	lp->phylink_config.type = PHYLINK_NETDEV;
+	lp->phylink_config.mac_managed_pm = true;
 	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 		MAC_10FD | MAC_100FD | MAC_1000FD;
 
-- 
2.17.1


