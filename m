Return-Path: <linux-kernel+bounces-339401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D652F9864B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8048B1F24B69
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE044F5FB;
	Wed, 25 Sep 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ncWW2heG"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92807381AF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281263; cv=none; b=n56LjWYrVRe0yvglLrdV3hInfg9KJGBkrK6A4fiTBfe1PbNALrmNg58UoEhI+QMhFBW8ANu4HX9fKYbvOPt68c9uiKygmKGTfwxTBqsPMm4GxONaoZDeBA+rB6F5i+kEPrzlj9DN2Vi+jxsIHKGjdlR5mzPG1viRmkR+INLrqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281263; c=relaxed/simple;
	bh=/C3n/otTQtjjOW+S8EgHIZOwg2eJkivLmPEPYaCFeIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tkYWEoK5DHLu8OJR36TDRQLWC/916Nb0FTaHIxpkzJ7lr9p6w1cIPGpOzdsCgip/tZYwFCjGWisHu199LcHIMaNcqG+oLJprmWnBC/PgS7/GGFuDvsN6Qwh7cGwR11cBMEiq9/RYB4S0Mes/iBZC1FXdv4thSRuD0p+qEs1KUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ncWW2heG; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5daa93677e1so18932eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727281260; x=1727886060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRNRoZ1Q22A0B1+jOcTZDRfMVA7CQPyYZ3o93tUoHMc=;
        b=ncWW2heGQtY1o48AB3P7jQm4I75mmLI9nXqUUthMErUXTtSAsq8tOP6cbVpjypuEAb
         mZ4vEj9A3lDk8+mPCSSlMQhq/SNSCU28+Y1if/qoThH3A5Lb9yLpERXwGU5p7KhZ67Ee
         52tlMWKQq+vzOn8THwco1OL442S+fLigXK9TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281260; x=1727886060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRNRoZ1Q22A0B1+jOcTZDRfMVA7CQPyYZ3o93tUoHMc=;
        b=gdubYwRLjLKp7DomBH6VSpMSjeXrxtewLjq89vrvIulBfb6ErERLycoiuQQuUaTOHd
         NJkk3wb9ofHS98jFbgyGV9ASDbjFU2g6g0e96EP5Vm8360TufrtjOJ2uCMzZaISi30q+
         pSxxGMjmLGbdRAtB64938l7P3oLEPo+RngEZSDbVe0GIet1x6U/Rn78eiianQlHgmdx8
         HEcGYyNrViI4IDS/1f0cNzGgG31eNEU5SECrhXkOkk2D4Qs/OpEOPhv0hhORa323N1n+
         NjBeB8MgQkCxLUuGddFkM0mYPPzx+LktHe7sWvD0ItFX3S43swJe9l4WXqC210o961cZ
         ozCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsHQvnRvyzLkr6btsfpV3+M3CPMDkrW878r2Zby/duOPWfTae2GyDkMgUCUbVUczSOeDhgK6cm5tOmAlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmM0fFo7lr6ogILT8O0qPYEo2d0uhbbuWAFDTrg7G90P9R4hI+
	uVTqTkb1T91/1XnSquCVQ7ORPH4mMDhSLjZLCSE4LuN+8yzNGNWRSMIkS/m941k=
X-Google-Smtp-Source: AGHT+IEaW3u53guo2I9o+m2lHO3SxFF1Nx51GF93b4nhd0J46dpRFk/eaFwYfb90KUwt4+fj0x444A==
X-Received: by 2002:a05:6870:f729:b0:27c:475c:ab2c with SMTP id 586e51a60fabf-286e1751b46mr3040395fac.43.1727281260477;
        Wed, 25 Sep 2024 09:21:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73341sm2948433a12.72.2024.09.25.09.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:21:00 -0700 (PDT)
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
Subject: [RFC net-next v2 1/2] tg3: Link IRQs to NAPI instances
Date: Wed, 25 Sep 2024 16:20:47 +0000
Message-Id: <20240925162048.16208-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925162048.16208-1-jdamato@fastly.com>
References: <20240925162048.16208-1-jdamato@fastly.com>
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
 drivers/net/ethernet/broadcom/tg3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..ddf0bb65c929 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7413,9 +7413,10 @@ static void tg3_napi_init(struct tg3 *tp)
 {
 	int i;
 
-	netif_napi_add(tp->dev, &tp->napi[0].napi, tg3_poll);
-	for (i = 1; i < tp->irq_cnt; i++)
-		netif_napi_add(tp->dev, &tp->napi[i].napi, tg3_poll_msix);
+	for (i = 0; i < tp->irq_cnt; i++) {
+		netif_napi_add(tp->dev, &tp->napi[i].napi, i ? tg3_poll_msix : tg3_poll);
+		netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec);
+	}
 }
 
 static void tg3_napi_fini(struct tg3 *tp)
-- 
2.25.1


