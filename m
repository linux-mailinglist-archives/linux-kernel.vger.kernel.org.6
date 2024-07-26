Return-Path: <linux-kernel+bounces-262902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354D93CE84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD221C2155B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F917625C;
	Fri, 26 Jul 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lLiwdkOP"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31F1741E8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977616; cv=none; b=YaPsXoje/R4CTkZ1eAIg3+QfRwf1YC4VywV7kvzRQEcM+25W36VoOQEaWpyxQMIMg5tytrzR96q90Kfzi8UNRcAzj8ub7JisPqvDYsWzn1zPx2olM2CJXseuIiVH46+mpPN9QJWY/+EzoGacmUmVA3Kg3YESElxltYROQdpUiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977616; c=relaxed/simple;
	bh=jpqwEfa8nGRMSxJaVMggBcXx9wtmXE0Es7GshUm/IAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=amYA4iVillagSUvdpxBKbS4acJAdcVlvTWrQ33nzt3jPHPdP8lmq6vgWREsJzpvzAS8kpsC/IAQLjw/2sZXFH+WR2P08eQs8LFuWxhsGXL8uzjm7nQTPs2yXIwkMKYe1/F8rVLGp8e7n4EjFZuP/i3bxCq2jsc+8V02OEukMezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lLiwdkOP; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-396db51d140so6203445ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721977614; x=1722582414; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6bPP41x2BcXUf2RhmUFWS336ijR3sePP2PnHhiYKX0=;
        b=lLiwdkOPkn52YVPIYLASST+K+q7ikq3mSWhZuxNgoOKHzK4sxfVIMYnwWRUXHOLFL9
         eqXpVHfGC5ruy/zxbzcL11ea7+Kld5xMKQQo4Mhllfl3DPGr8wOuOCNF2q0C6xYy80Mc
         Lrbx3arX/cFMxiYxw70nuTUS2jmxMq4sSPWhpoTrQasLXyjuG12o41jcTg86uXgqR+T3
         mBpE05XhV0CFxGNYXbUZmW86vyoN6nZthuD6c88Fm5exHVjyCbrld8gH6CHmjk2ajpDW
         c4XPyo7eoMvJeEwetsb3V6ExSXhLnNR9tP2TFe3eJSHMXcnmjTHyd5xvfTliS5gNjGqV
         W+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721977614; x=1722582414;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6bPP41x2BcXUf2RhmUFWS336ijR3sePP2PnHhiYKX0=;
        b=eBo0ARWopk3NYJ83dCjCdbGTUwxycsaDpn3y+fKhQItoey8b4luyxoXIoywEAIwqsG
         0LurgyOMiUZXNircSBXZijxB7O8OoVLdNP0BOL76iam5ZIcJfS6b3kR0xjopLGbLK7l8
         9Xh3uv5uSg0rKMeNogtqy/VLZ/5WWah8b9vRmJbpK9RHTVy1XCdGZh8fiALdN72apH5H
         RQjyQdK4ELA0gQDw3AMiKVd5agVhaXJvOoyuaRRy80G4l4tOKizJS2U3q2zOSIkJRFXy
         bjVcQe/oGdauc5/A+h15UtPk7ofZojw4sNNHCxDjRGbeX8eQvvoZi+adONnNAVHskRFe
         7QLw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ3SVM8lu12QfM1OsG4pUD18ebxlieAgNQ/WzhQo66sMvNyZRAT/QOvYCAMc2A3Fz1SkaA/8UIXyW8Ii4tlcFxXOX0K0XaZgADGAEJ
X-Gm-Message-State: AOJu0YwPEYzV2MoH/kzuEbF9pjqbJ9+z1Pha1GCiTkdCpP3A+WCgVpWD
	SNY9epRXUdpfxLO23DmX39ncusEyrPVRs48Ac36Y3/ccN70dHbgwSzh6KUjtRbY=
X-Google-Smtp-Source: AGHT+IH/MAMZrCPan9EzFang1zc1AhdOVmFmxnStAc5cJ/IPwPzY0XAHlowhcmA3IyMyJtLj8fNBeQ==
X-Received: by 2002:a05:6e02:214c:b0:39a:e814:d2ab with SMTP id e9e14a558f8ab-39ae814d513mr6951765ab.21.1721977613849;
        Fri, 26 Jul 2024 00:06:53 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8749c2sm2108345b3a.155.2024.07.26.00.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:06:53 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 26 Jul 2024 15:06:50 +0800
Subject: [PATCH] net: axienet: start napi before enabling Rx/Tx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-andyc-net-fixes-v1-1-15a98b79afb4@sifive.com>
X-B4-Tracking: v=1; b=H4sIAAlLo2YC/x3LQQqAIBBA0avIrBswK5WuEi1Ep5qNhYYU0d2Tl
 o/PfyBTYsowigcSFc68x4q2EeA3F1dCDtWgpOqlURoDFXQx3B4jnbjwRRk7qRerBmus76GeR6I
 /1HGa3/cD8bY0u2UAAAA=
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Robert Hancock <robert.hancock@calian.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.13-dev-a684c

softirq may get lost if an Rx interrupt comes before we call
napi_enable. Move napi_enable in front of axienet_setoptions(), which
turns on the device, to address the issue.

Link: https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg06160.html
Fixes: cc37610caaf8 ("net: axienet: implement NAPI and GRO receive")
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index db7640529ce7..6fb48268b47c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1849,9 +1849,9 @@ static void axienet_dma_err_handler(struct work_struct *work)
 			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 	axienet_set_mac_address(ndev, NULL);
 	axienet_set_multicast_list(ndev);
-	axienet_setoptions(ndev, lp->options);
 	napi_enable(&lp->napi_rx);
 	napi_enable(&lp->napi_tx);
+	axienet_setoptions(ndev, lp->options);
 }
 
 /**

---
base-commit: 80532af22b67cb83736f62feaeba483b2a5f74db
change-id: 20240726-dev-andyc-net-fixes-306f825878c4

Best regards,
-- 
Andy Chiu <andy.chiu@sifive.com>


