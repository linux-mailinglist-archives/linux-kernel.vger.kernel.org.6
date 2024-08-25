Return-Path: <linux-kernel+bounces-300525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE495E4BF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEE6B20EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDA116F847;
	Sun, 25 Aug 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT+QyFji"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F721EA80
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724611998; cv=none; b=Qwn4PNcDA/HZqxygTviQjwTphrmB/2m/Qexb/Bz1s1reBrGEi/F/ugpP6S6ICdPZY4EVf5KjK3TQEDZuFJx0hfc74bHnHfcHnHsaqCicns6uGGaCr1zK0CoF3SOnGuwnzq3SZ/IvWXPrQmvml8ltEJIO9aBTHr3LHEMkHAptBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724611998; c=relaxed/simple;
	bh=9vexD2mmzgeQENC9LitcJeueSXuVsjquGp1/eS5zaO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qb6TWU2SsuAH4euiUAkc7Xo/9wIFV0bXIizWoFZcodP0OHkgiy9eV64zKQmW7LS95tmurAjoza2XDvaW5/W2kF44nJtCamq/66akwApIr/vHRWtEWHFsKg5yzp5lQrWnkKzweoPw8XrsOice+UVTAZhI7zv1STlWhjPmUG8Loz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DT+QyFji; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36830a54b34so142350f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724611994; x=1725216794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPdvIKW8FgFCV9KPcyxeAD/wE24NwXWq7P7bt6Yx4PY=;
        b=DT+QyFjiMZ4lq4v1MKjk9rWGrZLlX3+x6OC9ruIr0kmHZ2xdSfhE0BWBnusdf8xkmb
         zWMgkqrVbJaYY+MKgh2DtIxF4daHJsiQWPRO5J6stjX/ch2+nTI7yEL05jtXp/s+RzUA
         guc0/DxmN+TuJxwQj6999Cjkzpg2n4XLgY0Nl1UnKiJa1eMlq726x51ONajWT6Lbz0JI
         tZ16GSJeg7rBTm1cR5Ez85trPKeDV6U2FPO0I+k/3SxHkPDs2hjRbl6zfqtL/97qBGUu
         Lf8dD00GquafBabN9hKfEbOZUOeuwm3QvK3Q1+OSnxF+moYttv+jLzhL05JwLDOoUji8
         nttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724611994; x=1725216794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPdvIKW8FgFCV9KPcyxeAD/wE24NwXWq7P7bt6Yx4PY=;
        b=AaOuHcD9ssGP6qvPpuWc9RUnwD0p59A8nAk64mvPhF/69DmVh+MXa9SiTQkqgv4JD8
         dN8j7L/xoapUXN8LjSx48a8g3fNH/XzlmRR3R62FGlzuLc6Iem5A3Ya8VbskX7bBXP2k
         uPibKmnQnXOsNJxDGE19Rn07G+MIBlGuhgCnclIHXFaevJrWqNNCt6bk/WoWNnIK6nvO
         0Nt62gq5C+zEJwjkREpABLjOwzswsDC75ba4XNf7jKGlKGDYmeO45q3oFvCK6pbDZ0Gc
         ay9bL3SqtM75h8el3UBbW1EP+GrYtGp2rXMdSO/bOL3gE7TZeLGEv5BItgi8s13arlnN
         wr/g==
X-Forwarded-Encrypted: i=1; AJvYcCXcQxCbU9EcCoFPx2/FolEqmTp9bIqNK7shmQl0VaBoDCR8CvGPKcTdjEhFF8aDvfmiUi99KkmhYqpsC6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM2s+GudkgpUm0foVw7eG4I3l0pODafTtV5FDgj5fRE4SaCyan
	wBx6vKvXViH6Nuya6WEJwOzPn7vm0ln0zZcaMJz3S/kagmqhzgRmwuiUFsFi91c=
X-Google-Smtp-Source: AGHT+IGb8eO/KaLKd+muI8oRL2UcYKsg2Hp6fGBdqiipIr+mKyxHMhWPUMMnIuurLDu03AVaY4a7Pw==
X-Received: by 2002:a5d:598e:0:b0:373:6bf:95f1 with SMTP id ffacd0b85a97d-373118439e9mr3348095f8f.2.1724611994244;
        Sun, 25 Aug 2024 11:53:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb76sm9130963f8f.8.2024.08.25.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:53:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] net: hisilicon: hip04: fix OF node leak in probe()
Date: Sun, 25 Aug 2024 20:53:09 +0200
Message-ID: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
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


