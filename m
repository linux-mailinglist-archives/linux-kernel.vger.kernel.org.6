Return-Path: <linux-kernel+bounces-228534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423DD916163
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29F9281477
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D4614A091;
	Tue, 25 Jun 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="J0h5vpYR"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C22148848
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304420; cv=none; b=EzP8VO8ks5OvxgELg5ZgGFKugyoo/f+5lUNmwfVvP557beP877c4l335Mah+G5xJ3SM6+v2SjexkLgmIZte3r1gQvQ0teh490lfYMtw6Tdc9Yl9wM6FuzZeEqCY8mJq7974QVihelrns9ZfUFyLEaCYxSgw6QjQnna78K9aLH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304420; c=relaxed/simple;
	bh=6zLeUxGI/6eJmXDQirmzJApQvIPtWQsC1uEMVIgt2tU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ic1spMHILf7wiurJjFBg8r+I+gixoEwvSTHyoKM8qEbVJabXoBp3P7oNPAxpth8UhfZzuPwJe1KxzIn3bKCTHmvww6ysZQYN+8YyDPYvbAcbXLhyG5Y+BDumOHD7AHo5A7QAHE0FLligU1UcMG11r6YSjzbtD/B+shoJyTOR7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=J0h5vpYR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70671ecd334so1956258b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719304418; x=1719909218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm6ddIKDyA7yDOVacp77GbndxO6yjA2PPWGRWlNTN1Q=;
        b=J0h5vpYRiqosRaYwTeDSWa7DdrN8EDN7B+B+WXEl5ZdQNBBj2dXfguSQ64usrxddoF
         08W+b6rndt8CJIb4vwjNotO9W16+mwHfJkl1lo97bOxzzJ0hM1xdwy1xJHMkyEWEG1NS
         QgU3cwpMweam3XpfM82MDJQUAqrSjQOTKUAglSz7JWG8AgPV6+RukprNwU5/49tFndDr
         guVtEhi20WzM3JirI4GZxb1YHybwf7vCenGSqFZCj0ttpWQwRMXs7fEo6KfhWmukj1a8
         Ibl1oIqwIuXyCjQMwTxWMCx/n7XfoDJYf8Vls/OOlqnPvQX86oIdo0JEiLBsePsoOFuy
         Rhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304418; x=1719909218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mm6ddIKDyA7yDOVacp77GbndxO6yjA2PPWGRWlNTN1Q=;
        b=mIGf8YH44tH9hPTDuA455/hRzVxznPDvoJ5S/uNC9mkzJrXTnRHVNGnB3P+kyWozen
         FPVeo7X6LCsIUAavf9xzblApmJp+hw2uE3CARwYlmX9GLZbhMdhrZTfQPhUuU93WRfrs
         LSlWctxETdTfFRsLhVbD/PkKMdHpD34Du6j4yJvf3sE/6I6AwJ49wuHsy9th/4gvIqeG
         GnRvluGwo3BfnEnSB6mJF+yx0jxo8ZQhh5Q7BWWf1gPR03ARm842tc12/6GK4I9JXufN
         adQFjf6ZCqkZz4XQRAAvf49FsA/8Ou+5lU20wOzayMCvbzgWt/M3dvpWR/Pn809veecv
         Cjkw==
X-Forwarded-Encrypted: i=1; AJvYcCVv1UccapMSjmwNbi/w1dWW7aD0MNcsgNveKHdBx0KfnwUpfs+CXUkPbDfSRaIySKObKH91N8BVjQEoFxo2E33svZOEvo7dkeKoS8e0
X-Gm-Message-State: AOJu0YxjedbPJvzuIgyNaMwmBafPLMRHSyZa+KeeQcQtRtE7NW04l8BO
	KWPyCNUhfDMpIH+MPeBFa1OcqvC99AVfEKWV6i026+MOJedSDYmW1k4fPoGbs9UBD2gK7Fh9MSN
	o3QEK6yyRLSw=
X-Google-Smtp-Source: AGHT+IELm3Ttvtx5YR4G1Z8+z+DN1lPcg5UI0/UEjh9cx2tvPjDsjig+TPYlFTxJUKTZbgzOn8F1Kg==
X-Received: by 2002:a05:6a20:6720:b0:1b4:b4af:6045 with SMTP id adf61e73a8af0-1bcf4479e5cmr7378240637.18.1719304417403;
        Tue, 25 Jun 2024 01:33:37 -0700 (PDT)
Received: from echken.smartx.com (vps-bd302c4a.vps.ovh.ca. [15.235.142.94])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70662ee117asm6035587b3a.211.2024.06.25.01.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:33:37 -0700 (PDT)
From: echken <chengcheng.luo@smartx.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	echken <chengcheng.luo@smartx.com>
Subject: [PATCH 2/2] Add UDP fragmentation features to Geneve devices
Date: Tue, 25 Jun 2024 08:33:24 +0000
Message-Id: <20240625083324.776057-1-chengcheng.luo@smartx.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Geneve devices do not support any offloading features for UDP
fragmentation, large UDP packets sent through Geneve devices to the
kernel protocol stack are preemptively fragmented in the TX direction of
the Geneve device. The more computationally intensive encapsulation and
routing processes occur after fragmentation, which leads to a
significant increase in performance overhead in this scenario. By adding
GSO_UDP and GSO_UDP_L4 to Geneve devices, we can ensure a significant
reduction in the number of packets that undergo the computationally
expensive Geneve encapsulation and routing processes in this scenario,
thereby improving throughput performance.

Signed-off-by: echken <chengcheng.luo@smartx.com>
---
 drivers/net/geneve.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 838e85ddec67..dc0f5846b415 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1198,10 +1198,14 @@ static void geneve_setup(struct net_device *dev)
 	dev->features    |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->features    |= NETIF_F_RXCSUM;
 	dev->features    |= NETIF_F_GSO_SOFTWARE;
+	dev->features    |= NETIF_F_GSO_UDP;
+	dev->features    |= NETIF_F_GSO_UDP_L4;
 
 	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+	dev->features    |= NETIF_F_GSO_UDP;
+	dev->features    |= NETIF_F_GSO_UDP_L4;
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	/* MTU range: 68 - (something less than 65535) */
-- 
2.34.1


