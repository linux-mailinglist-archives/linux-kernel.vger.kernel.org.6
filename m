Return-Path: <linux-kernel+bounces-300526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF495E4C0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E960BB20EED
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4C1714B0;
	Sun, 25 Aug 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsy+1cDr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913494778C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724611999; cv=none; b=bANtG6MT30j7VqmxtsfcalVEf+ZBpW1+tuhApWz+SzouGSxKK4L+58YUu00r1juIRQ6FKB6CWArOhbV8mebUV3FzkYJtv82cRuomerpbLsyBH9V/JwPZjEvKAhm2CNul5G8NHomBvZzfjoQNiTMdlatQIBNjqn8aQmz8mzEEn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724611999; c=relaxed/simple;
	bh=ue6WPVo2ptKZgCeNkE1VgO0ePkeq3s2Ko4LKgOeSSVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiT7JJEswoGuZuJkqv6Xqfa4C80CXWZI9m+0GKlo+l/un2rqNn1UgqG4u9xc4q4+i6qpd/VZtyTrO/Yob2oCE5qtzRO7Yhaq/uoZbALoo0s+2+uRQdOa89ZLXyjg2qkBh8OFSuxpPwvnQvN9+QkBK0jZ4EpBNa4HayT1iwIAxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dsy+1cDr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4290075c7e1so4541025e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724611996; x=1725216796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMtvRXV/U3e/l+PzLA8fY7oKc3KTxA0nshrMdnXdyGM=;
        b=dsy+1cDriM61W99HKvwbK9ei2CQxz4x+igKMXXdEZJEfsTH1l7CFeaUsfcnDes98fA
         E8laq9bdkor1LXurWQmdAt1wz1m8e6V1zs7gZ4WqhUG1IbldkvAby1I/kpY/nfokt6WG
         FnhkKmR73l8UpKEreEPSIbtEjl0wrcN3L7Sjk1zSjpiG58bgkN450yC7mbRma47vDSiL
         l98bpzA+J4up//Zh3hspwOF5IS5+BlLLP3SRW35x9qK/rDzS7MgLyzCcyx8+MPibkiQD
         KiXY6vHC9gOL7B4YSrIBSbVQ6FUaeR+8XW9bHlhONRduJD5GB68Wx1JzsN9Y762XbKMx
         3Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724611996; x=1725216796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMtvRXV/U3e/l+PzLA8fY7oKc3KTxA0nshrMdnXdyGM=;
        b=F9MZcTyefGBfa+cC1iu1Q4gW1aig5vC73ixZQiK48YEPAUoJHb5H6FUvfQhdSk+qeR
         8tgGI42Zpi9mg+1JzqY9jVR/U9i1DTEyMrNhOah9exn/EMTe/u05+/GHYpk3YGHRvG0S
         H49IT44MP2luiZgz2KUGxuDQaSlC5GFSlQk1ir0h/agTstDL/UrY2ttqiVGAi5RRCrKv
         4fJUdFN604QMGC4tpnyQfgkiGwp0qAAUQxgc+UwcNRnBQUhXK0zeO8AVZwA/tAlQHqJh
         MPvysCKWuaFaLBh/xyYNheQbFxkXEsLD2rgx7SxfUS+CG3v3o441RXG5hNM5NHP94bVe
         +8yA==
X-Forwarded-Encrypted: i=1; AJvYcCVZso09D5Zu18NfVtjGMYeX5/egSMil+MWiHe7hPJpiUwJb8GKaMiknJ6X7yFpF9OzrUkvK15SfAzWnZxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLb4wUCC1WIBMTZ8DZPn9BMxhLZf/FRICBGUJn5/62H2pLGvqO
	V59W1XchySAXTF3Z2CSfQQ/ZLJdf5mr+9e9mdqZMYP3KLPaCnuDo8jC/tc8kwQw=
X-Google-Smtp-Source: AGHT+IHyucbksivjR3R+yNUkpfBIrHJ9f9srz6KIurInP1xh+ETGUBuv8xZhVqT8mODj3jZN4xEo+w==
X-Received: by 2002:a05:600c:1c9f:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-42acc8de6bamr34058175e9.2.1724611995709;
        Sun, 25 Aug 2024 11:53:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb76sm9130963f8f.8.2024.08.25.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:53:15 -0700 (PDT)
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
Subject: [PATCH 2/3] net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
Date: Sun, 25 Aug 2024 20:53:10 +0200
Message-ID: <20240825185311.109835-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
References: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in hns_mac_get_info().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index f75668c47935..616a2768e504 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -933,6 +933,7 @@ static int hns_mac_get_info(struct hns_mac_cb *mac_cb)
 			mac_cb->cpld_ctrl = NULL;
 		} else {
 			syscon = syscon_node_to_regmap(cpld_args.np);
+			of_node_put(cpld_args.np);
 			if (IS_ERR_OR_NULL(syscon)) {
 				dev_dbg(mac_cb->dev, "no cpld-syscon found!\n");
 				mac_cb->cpld_ctrl = NULL;
-- 
2.43.0


