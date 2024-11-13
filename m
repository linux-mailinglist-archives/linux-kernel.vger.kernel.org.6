Return-Path: <linux-kernel+bounces-407195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676AC9C6A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB39281988
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AA4189B86;
	Wed, 13 Nov 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfdJDVka"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092311898E8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483094; cv=none; b=DZNW1M+4iONTqRt0mK6ahQ4t4iLS2+J2tVCCIAGdwgugMtkcUTkvle88bOTmnUWbOZAzaPd1k0DH/WGBdhA2vYp4fMkV1dyH0S7OZkOeVpvZJNtFKShEu+zDSBbX/qrjn7wUqcEyJ2SuXdw3lPuT+W1fL5Rq4RFqLuAyfG2p8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483094; c=relaxed/simple;
	bh=tmuSu2iaBDMllSjqEsXXqjaCbaHp1pOOtGHzUZ12VGc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W3DKVLqGMQntP9LYQiaWEYDu99RQogj67N0PISt4zuqra3h8OnJOoNs7dyp5whOInhhAuK4fAni0rYJBqWUCO+s/Vdn3HI9MINm0qhDa2PLpTdYd30kW5isDD8dFqmRrzKOEHiMK0DBFpZB7IIANPsJGZ/A2kXWp5QpomR9rRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfdJDVka; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so57092675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731483089; x=1732087889; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4csWLl7Ej9wAFH627/RtOwQI0dYK7exWefQ0DxYMq0=;
        b=TfdJDVkaOxLfhRptRKlUOMDVESNlELFaftJuuk5UCW5/H0i2au18apKckCipmXbvql
         r3ZDtsKxL+s7Oz+8GkEFkCIBdAPBVPQHyGI14c/tr3LytgcGxVhTVObH8FspCR5ngFex
         3dKF+ian+DEDqAjiicGlScqO3AL/nCBENkHAraxr/gmdZEWJqHOuSe3Taa2PKoJaGGah
         cim3o89u+lxXlafzGjn71ECMcLxv7TCynXv+UXj9OkC7pbo6zqJ8QAu2qjXzYBxTyB3J
         hDs/gZzWdqSRy0WEbi2zhm4WGplKpLNscjrnfVLynT1p1qzuphOkawLMGloWgHuDviZs
         Zv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731483089; x=1732087889;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4csWLl7Ej9wAFH627/RtOwQI0dYK7exWefQ0DxYMq0=;
        b=ME/7rwRtgBJHxbfumdUJpHY4h001VOqylgFJHSRrXZkoIk2dlvI6bVwfqyuYdSqUIM
         Gf/uLMZZ6E4DBAj2DlyTbBGspuQ6a20NFTYBFgE6SjGEt1E982O7vRf2+/G9fcPYX6ec
         e6Et0tRln+Xl3AZNpNzbuTSRVnneZVu9OcmFLbn3ycon+EszAlk4B5yn8cMWvzAfOaxU
         OHSzzwfwVPFQ0+u2svbvE+3TwYL7N6ghkSUwI0k2jWtfn4AhROld4GQywdQiimpNj2zn
         mpZ875XoMNOOAvOmPlMVGmIZ5ourO39XprLpEGAIHjs9Pl414Z9VezuQu0xqwYEwJZip
         wp0A==
X-Forwarded-Encrypted: i=1; AJvYcCWlyYgwP8dQ5UxTGGYZ66hCAgD/gXy9AGzza2PH3onYNFRcYFarrVivmgEa2+lC+PfsbttoG+T/ND6B/Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fFMPKRS6srZZP2TNNc25zmE1VWq9bbt8xKlvSsb43tXOwThw
	TMJXJ5ZRg+BpaWcIvAN7UdbncSsboSEADzcd0wirtIdwOwKEW51DZEqNscnUh5o=
X-Google-Smtp-Source: AGHT+IFXhHLRS1YpnITs+WT4llH7CTWUIO/WdLiyAZE4altKKyOTrJjPAyh4aJtRTdM5ubYGkxnsCw==
X-Received: by 2002:a05:600c:a4c:b0:431:5df7:b310 with SMTP id 5b1f17b1804b1-432b74ff9b1mr168355735e9.8.1731483089349;
        Tue, 12 Nov 2024 23:31:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97fe6csm17353305f8f.31.2024.11.12.23.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 23:31:28 -0800 (PST)
Date: Wed, 13 Nov 2024 10:31:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: enetc: clean up before returning in probe()
Message-ID: <93888efa-c838-4682-a7e5-e6bf318e844e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We recently added this error  path.  We need to call enetc_pci_remove()
before returning.  It cleans up the resources from enetc_pci_probe().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index d18c11e406fc..a5f8ce576b6e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -174,9 +174,11 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 	si = pci_get_drvdata(pdev);
 	si->revision = ENETC_REV_1_0;
 	err = enetc_get_driver_data(si);
-	if (err)
-		return dev_err_probe(&pdev->dev, err,
-				     "Could not get VF driver data\n");
+	if (err) {
+		dev_err_probe(&pdev->dev, err,
+			      "Could not get VF driver data\n");
+		goto err_alloc_netdev;
+	}
 
 	enetc_get_si_caps(si);
 
-- 
2.45.2


