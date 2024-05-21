Return-Path: <linux-kernel+bounces-184434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3037A8CA6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6631F21208
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0CF55E75;
	Tue, 21 May 2024 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="awRJxGwR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ABD18641
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261451; cv=none; b=FfLpXZRgcqmyz7OJ/l/pmJpF3OXt7gfnHfJkLDUC3TeQhtY1dK9yDOuygg9/O50YPTBp870cOdY+MQBFQ5NX+J3Etv1pK1UvpLq0mF2+uu7rNlhf8aEJrYIDvog5V/4nCF0vejVQ8el5ootUMfoAuNmSzQObwP1xYneDtRpHYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261451; c=relaxed/simple;
	bh=XPJI+WS4EeMm9YhpHRUqULnGSCpjTomPq7hFHW5wa5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3CDArP6y3K+1lTNG5O3jhYjKi2kEu9OLjgKKkwMTMaviyYNUWdNIb7KCKdXPaFhDmkXQiWW/aHPiHjDZ/Q0GPGQ0VG92hKDfzwqgxQKfHzDbG3IbvyR++rKCGEyNPLrbutOTz8vmL8EXX1SBqLOb6sNv16CdlOox0zenHKNUyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=awRJxGwR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1edc696df2bso30587565ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261449; x=1716866249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m47pozkJx2xYmkwgf2WxpxVuMQVKY0n0nxGrHzab78=;
        b=awRJxGwRhfoe86ga8MoKAHTu9oh4L1K0RNa+2tVCKoZlbPUd1rpCWF+YA7xQiVITKM
         i7okboUCeSKJ76XVN3ZiddDDmSwV/PAQzwdpeLNvTTuNmHllyom+GRZ5g3PcHaQAJfn3
         Kbb2IhTEDvekpZt8wG3Ts2Hqo0A7d0QylgBBAlD6aHzMebocTjzykU5wJ6rsB/JZrrBC
         zfr+5RwOubn1kUECbWNK4z6As91oxTCrrYYmaCVX6f3xZ58Gobz4DdpzFp5LoOaPqoq5
         1mOuIqle7XXq85ZQ1c8/mkvI97viAvRJ4xq71FgFMMAt/bParAO9ND4Cth+X6dnWenIM
         vZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261449; x=1716866249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8m47pozkJx2xYmkwgf2WxpxVuMQVKY0n0nxGrHzab78=;
        b=Vud0BrPxiMvXRiBkA9s5+soVV+MdaFeE4hRKdfj/yJCh4CRLNz+5nXzgkRrQTjHlyl
         f9gGk3ObFsivX26wRmnS22p5YPpZaZy8yergGvCQXlgtXiIrA6LFMeNraccp5VumawA4
         x2DXbbbe6QK4BnHnUuKIRdDVwl07peGyVLGOheYG4/0XPcvmVB6RgqAcsiXWigtl96UL
         1deOvMoQOwjwdZTz/OYGqgcgRNoWLJAAFjtAbYUBQtg6StzLbKqfQIakmb/L44AyAWEY
         i1OH6jIYfSFv9LeZkivTGu+m6XFnQ7V1qk3IHIIepqbZL52nJw6KKYfVOK584I5Bi/M7
         fcCA==
X-Forwarded-Encrypted: i=1; AJvYcCUjCxuyau34hL0xFVFgqBoN/IHY7LTu2J/4JLvzfI9Ta6wad0dwMzk+ikUslWvbrQ3NPkvnn5TqY36dpDLT82RXlndcJ+bzlZFgBic0
X-Gm-Message-State: AOJu0YwXnhzcU5tEWKWZ+13+DQ8jyWPh0+Jq0mVhSLmfQjsN/3H+jISd
	BK8LvhlIpGaYlm65hXZeyRsyQdbvcNSguCEB1xxfb30s3zTRErHdrsae46u7BQg=
X-Google-Smtp-Source: AGHT+IF8XMIr22vZBHnnoWoHa3Q8FM+pktp2JXxMwSQx57nMRLvpMYto1JBLC0Ubt03+7danJPVlmg==
X-Received: by 2002:a17:903:2350:b0:1f2:f854:f54 with SMTP id d9443c01a7336-1f2f8541142mr75795665ad.62.1716261449374;
        Mon, 20 May 2024 20:17:29 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:28 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 10/31] Staging: rtl8192e: Rename variable rtllib_rx_InfraAdhoc
Date: Mon, 20 May 2024 20:16:57 -0700
Message-Id: <20240521031718.17852-11-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable rtllib_rx_InfraAdhoc to rtllib_rx_infra_adhoc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 108fe1520cf9..ea8cab9707bc 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1223,7 +1223,7 @@ static void rtllib_rx_indicate_pkt_legacy(struct rtllib_device *ieee,
 	kfree(rxb);
 }
 
-static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
+static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 		 struct rtllib_rx_stats *rx_stats)
 {
 	struct net_device *dev = ieee->dev;
@@ -1431,7 +1431,7 @@ int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	switch (ieee->iw_mode) {
 	case IW_MODE_INFRA:
-		ret = rtllib_rx_InfraAdhoc(ieee, skb, rx_stats);
+		ret = rtllib_rx_infra_adhoc(ieee, skb, rx_stats);
 		break;
 	case IW_MODE_MONITOR:
 		ret = rtllib_rx_monitor(ieee, skb, rx_stats);
-- 
2.30.2


