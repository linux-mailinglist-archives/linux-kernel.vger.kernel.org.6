Return-Path: <linux-kernel+bounces-303559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33042960E14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F671C22F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BF01C6F6C;
	Tue, 27 Aug 2024 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sETS3Xrn"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6341C68B4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769870; cv=none; b=ZpEdkbMhOIwzmtF1mhhpi/+JMxezIJC67H24LL4DJC26+D32LPEBWW2segQNcnb+5+tkrz74uXrq3Sf988bDIgJT0w0PRbMsbD5L/qNZWMsj8S4kH1auV2BNcwjxAPIlrBqzVm7CNuG++UFSCjEFe0yBNzjSHtysUjuidCG/Q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769870; c=relaxed/simple;
	bh=9vexD2mmzgeQENC9LitcJeueSXuVsjquGp1/eS5zaO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEDhhbf+5pAUn3TGxsAxwdeyN00LeYryWVDQoImr0i7GHZ8dhyb958pd47R6jrFoXwE5Glt6W9HLGVZxVhDD527JDHJeDZ/9jzA94nS9dBaoqowqbZ3AIiFpVe9u43yF9yB9/c/D9oZW2sZdUMlO8DQCaAijiVbNu8zG7cpaKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sETS3Xrn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37308a2ea55so234728f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724769867; x=1725374667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPdvIKW8FgFCV9KPcyxeAD/wE24NwXWq7P7bt6Yx4PY=;
        b=sETS3Xrnqt8icel8VeHtXkw6LRpLmBxlzHyHhi635LB8ozM+v3+bK/rejagxrvGKuC
         OHpam32wVCwg4rnh/Eu1q7xi3lgPZCXwzVDcBP81Xs9uLcVpUlbGl61J5vbHw375mTZH
         YJeUqrlaALGJR1BOoxYg5ohhNd/0LRtcDk0NDHn4g80kZjNKNbdDxRKTmmWtp9i4qfKi
         x/MB3JGNoPmj13nyhsz2mh6vZjiv3LlwjnnT0QY7Zn3/VDFRHKDw+p8n40784WoWyc9S
         jxE+1kYLTfCJIcwMr/tWtcshgKWUfcgvkFAssrq5ZzT7+SxkvAI/vfvc7ukZlKO+/sXo
         h1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769867; x=1725374667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPdvIKW8FgFCV9KPcyxeAD/wE24NwXWq7P7bt6Yx4PY=;
        b=NyGa1y8P/towTq4WhYOTlA/l4IRqB52LvaX9nquSJpD1L1Q6UgsOBSjqhygeCKoO+6
         c5qvzISq+aeH9TUJTMucumCu+fvC/CW2b70P3qCiGfCU36muR0twsALc8C8+VCMLJgh+
         gGXY2pF1tc8CO99ratieWt0fupBe1nU52HLE098IfE6XEJWEB1ayylta44L6Q8C49QyA
         3H3+gQemiBsLOKeDK1yMRvYSRmxyH5Ht0zjj5XgfdP52zgWt/QBge6vUR6W/dD3VpdA4
         R2ahh3nShtOBF3smZbu6WvdEJ25x8bGx5aLZjjdSxbitr1alzzyvBidQgwuDEFyOzIse
         e5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCU94kFZL1qJml0h9qxpQipwThaoTNmGq1cLSB/5G2y8rliizcIuNI98ZDH2q32D4iYptfSSyEn+sFaAczY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbzCgyJH0ecDG/koB+RUz4BiPznVkFj0JmVkFPkpEJEgdLCDS
	FG2jtj1iNL8Ep55469EjL930ns7PiNiv85sq3VNUpRT+tXqr+Hz06IulAHzfXnE=
X-Google-Smtp-Source: AGHT+IEJsWgD4WKt2n6pCZX8Vmj/AnxM/MX4C4ng7kiuGPcfY33T6OA79b7gqBNqaj6PS2psGzM3CA==
X-Received: by 2002:a5d:6d05:0:b0:367:9495:9016 with SMTP id ffacd0b85a97d-373118e9996mr5514954f8f.6.1724769866777;
        Tue, 27 Aug 2024 07:44:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff654sm13270457f8f.75.2024.08.27.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:44:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next RESEND 1/3] net: hisilicon: hip04: fix OF node leak in probe()
Date: Tue, 27 Aug 2024 16:44:19 +0200
Message-ID: <20240827144421.52852-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
References: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index b91e7a06b97f..beb815e5289b 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -947,6 +947,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	priv->tx_coalesce_timer.function = tx_done;
 
 	priv->map = syscon_node_to_regmap(arg.np);
+	of_node_put(arg.np);
 	if (IS_ERR(priv->map)) {
 		dev_warn(d, "no syscon hisilicon,hip04-ppe\n");
 		ret = PTR_ERR(priv->map);
-- 
2.43.0


