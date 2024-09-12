Return-Path: <linux-kernel+bounces-326901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D22976E49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA5281C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0C51B9845;
	Thu, 12 Sep 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ohp1OMTm"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA631898F8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156719; cv=none; b=fubJgQL9wzw8qwIwpUXsTohKupaJt4cuZieq1gIY5MSSi78HZBNvFNoqM889BDKFq6KpVHR9pBZapLnVHscYs9LIWV3K4ebLkPN/SVlfSBp41sWjwxCHUiXg1bLQe0F3JPobKgeDyRA9eREkqfPYv2Tw7XlFPZEbPgV8xrYNipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156719; c=relaxed/simple;
	bh=U9dUmOOuXwqX5mq5q+c61lnytJLwV7sVtmKS0yIcsSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4iaKROZUEwPBykQgh0LXcpk8n5V6MxtYUnlGpNFhuqK87K3uoeXszgRFtSt2ghlNmM+XOsWWzkvHvCUR3+VUJuaGcNk8/NlGDxDHF1t/hyjKHUFO1GgwzqdO8aPKR+QuiEfyeRQtOqujgHZ+hfh+fqydx/ZGMwDx6lv3ZBMc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ohp1OMTm; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-277f0540c3aso581340fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726156716; x=1726761516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYJCNJBfM3mnUo54efKbh8cT5QtGE+6/2LtRTMxqLoo=;
        b=ohp1OMTmc4+MY7BjSxQHsCJIJMIRl/Z4utjQ95fYeombWtM7Jn8+zzYbmrcBSoopbo
         TaPOjRa/b2Sz6LyAoh2ZFQTlTiYRrN0l/dIANNsy4fYwekKTkuKDydt3J9cJmNXqhyDY
         6K29Ed6MJeFrPWE6jAjge8CNhI0n1TVwlbHMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156716; x=1726761516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYJCNJBfM3mnUo54efKbh8cT5QtGE+6/2LtRTMxqLoo=;
        b=b3/XbFd5OB2Fs2P8jbj62TBtFf/uFTp8SvYoeHHHmlbUFFDpV0furqwIyn/uywQu6H
         yfuHrqL5cc6lQznotD+0cA3kiJ3K3vKucC0fThpGc+42bZcuHpXp226lscjvVaveBdxW
         SzTL5nk7231+FP3Op5Kt7r4kc+5NwYtlbGDzeJJSkh2w2AZSR1C2lNCIwPwfszE0h1cp
         ncQ3KF7SX5t8Cmof26NLn61/RbEhLZUtNaKXGg08PX0E9RIaVoxDsX47H33AjbWYbNBM
         lf/zQAoNnJzijAxces1yeKL9GO7z9FErB3b6ziHly5pjGgHP3g4NPZbi1JaaZXG7gnAn
         UwRg==
X-Forwarded-Encrypted: i=1; AJvYcCVF29Tf2XjyBN4tJZT3ZARt9N320Q5uwEKOuyglt6GiAgoVGS/PcIMvnBNRbPC5wUlSNMAOIBOR8njAqPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSbHtpHf0Q0b4s4hRjeivycjEoOMObh+xA1UImoOF9Uw9iRWC
	VELt0HAMhk6XIggeJ1Kq+TVlJIptgYi5+DKfU6II7nGmJ85orN1twD1ttNjDkEo=
X-Google-Smtp-Source: AGHT+IG3uy2cnoFLcKM6BA2VUcWTFVL1Y4Nki9RUdsjOWsRn+gcYCkgHPFUU6mCU9sbh30OTyZ5Mtw==
X-Received: by 2002:a05:6870:7b47:b0:277:d7f1:db53 with SMTP id 586e51a60fabf-27c3f2c3db5mr2514880fac.17.1726156716474;
        Thu, 12 Sep 2024 08:58:36 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb527csm1913939a12.27.2024.09.12.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:58:35 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] tg3: Link IRQs to NAPI instances
Date: Thu, 12 Sep 2024 15:58:30 +0000
Message-Id: <20240912155830.14688-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances with netif_napi_set_irq. This information
can be queried with the netdev-genl API.

Compare the output of /proc/interrupts for my tg3 device with the output of
netdev-genl after applying this patch:

$ cat /proc/interrupts | grep eth0 | cut -f1 --delimiter=':'
 331
 332
 333
 334
 335

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
			 --dump napi-get --json='{"ifindex": 2}'

[{'id': 149, 'ifindex': 2, 'irq': 335},
 {'id': 148, 'ifindex': 2, 'irq': 334},
 {'id': 147, 'ifindex': 2, 'irq': 333},
 {'id': 146, 'ifindex': 2, 'irq': 332},
 {'id': 145, 'ifindex': 2, 'irq': 331}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..c187b13ab3e6 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7393,6 +7393,14 @@ static int tg3_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static void tg3_napi_set_irq(struct tg3 *tp)
+{
+	int i;
+
+	for (i = 0; i < tp->irq_cnt; i++)
+		netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec);
+}
+
 static void tg3_napi_disable(struct tg3 *tp)
 {
 	int i;
@@ -11652,7 +11660,7 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 		goto out_ints_fini;
 
 	tg3_napi_init(tp);
-
+	tg3_napi_set_irq(tp);
 	tg3_napi_enable(tp);
 
 	for (i = 0; i < tp->irq_cnt; i++) {
-- 
2.25.1


