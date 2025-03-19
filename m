Return-Path: <linux-kernel+bounces-567217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A131A6835B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9F716B12F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A02144D4;
	Wed, 19 Mar 2025 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io4So/sb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97545204851
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352862; cv=none; b=ooLE+jZ463aYX2R5sXSP21uScEenJuBKD5PYze2Jbth9Ry4K2oc1XZwLTigRoHHplXiP7MUhY/SOfEBDcyDm/8tRWjcbMH1tXlQilBtu+XHh7kWcpFR3ddZQ0kcNXDxisNViRrhWTfUAG4Q6oAlL6hxglFICKjxIHQz6VhdBWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352862; c=relaxed/simple;
	bh=dKN4xjY/HkeBbjfZnhzsdYX4yrkC2f8e+I8NBbNgDEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O00kxNgA3rD2yUzAk8MS3KdXloFKVIqnsPAegM6MM0D2C/XgRKL12FmsRHdANwC1Zk5mCID7GRg6KvA/SU/9Smk02BhuFJt/adSml7cjOOR+F22eDu2u2h/nrcFttbu0kcMR99oqIBy5u/NZu0RUn/6kwMV5W7EPgSeOQ4VedEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io4So/sb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225a28a511eso108615285ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742352861; x=1742957661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ek7cme2/eudsEK193BJL90oVx+fNXmIhOoJyqv4zYew=;
        b=io4So/sbfH0jdSTtn5awbp3wg7vQO6cr15+Mc/6kxFFP+l64zrI9Ad+jXPC/lHfNSi
         IgmkY99qI/lta1B5ew9Nl/CVtw/GmDpxWdusTqhmsP7zOI+EPHuDg9OPPzP0ApO9JDVS
         OFU/7eLCpEG4tkkrBBZUXBJolOmj6hOPaPVgHmjXZWldVxt9mclmiEIxanU4ERoHRDxC
         Gin6TFXarJMLcaoO4njI5Hr/EknubPFhNXyfFwcp5Oo8o7qUm9Hk8/HabdqPWFMXW5Vq
         xoM1sv2dX+uz12B3PJjCF3Febu+Ept+1Edco4Y1xsmHE84qERRH7zfZrmNWMhLlesVXH
         vYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742352861; x=1742957661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ek7cme2/eudsEK193BJL90oVx+fNXmIhOoJyqv4zYew=;
        b=KpK78I8B7QI5PcsKwn65PcqB0S/NpB1rA3pwp4DGpdrTQyw+Nju8GD3Xjxl9NJlbrX
         lvA1olmVWwMrD6EozhKfpnJf0kyUtzZRumxeaWIsqaHFPtiMXzkey+qaajsTe8Y3Pmq2
         CGYZHP26dYvkjNU3Sl/cIpiQ+VhkLbSdmAHGFAahx5a4yn4MvJST79pVzn4A9vMrRV4z
         opBpO2HNe8CCH/g/YorzV+BFeEz+cLQrqBu6KgT5Y/OiqQM6JV/1EdPhcBF5s+saNvf9
         gXd+xL+3K+uVts1KtPOE9/PsFA31lZiFqHMudlDoeWen9FaojWGSKQz++DO9h/ooRrZd
         HMhw==
X-Forwarded-Encrypted: i=1; AJvYcCU3kBSx7QkEgSeaX2A/oSW0IzimXtp7nHDNiXbeUWlxlnB+jsWqxxa6L58pc0lKo/aQXLr4XfRfTLIOCi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWcawMK9CTPkcrFcE54n9aZvzQVFp6yhgJW2WjHB7Tnt3t+AAP
	SUQsboDruoe9VK38sWN4ej7SEQBaQ2RCdsWUsSed1oed8vYaWEOD
X-Gm-Gg: ASbGncv7pgqjk/joAlFugi8qC7Fs6UD3ZteZfaFJsL2u1Gev//2+eZGM6IxgM9wyMmP
	KZ6f+Hd9RV+GRcHnD8SAbxERfhYPf8uhZ6mHFho8EKCIeZc22iWYXD8eeAq+EnlcKf8adh9cwKw
	ygHn+iIxFRwFPAwTbfbMmDmbEiVN2rGDSbMgQNlzCfouejPnY4YW4oyg0N+n0NYbaykXyLEhTqF
	J6ga4wMTgfhq9hzfpulpWaV8tZcsY0wFEqnmHMPTG1qhtsw+PPgOHeCEFMk1UBh0LghEZt/qNRW
	XfHyCKolRLZYKJ2dI42OTkc2P9d6GHH/g8aqH56kbu16padqP9AIH2lpjH/jvdCjNw==
X-Google-Smtp-Source: AGHT+IF0dfIeVetmSPcgsPVe9LLjyiIoUyu5s12IyD3+OHyJqEQkUDfF5BV0koR7p2kdcOfRbFxjgA==
X-Received: by 2002:a17:902:ccd1:b0:21f:5cd8:c67 with SMTP id d9443c01a7336-22649a47794mr14215185ad.31.1742352860696;
        Tue, 18 Mar 2025 19:54:20 -0700 (PDT)
Received: from localhost.localdomain ([114.254.9.37])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-225c6bbfdfesm102978775ad.203.2025.03.18.19.54.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 19:54:20 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Hongliang Wang <wanghongliang@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] Loongarch: Fix device node refcount leak in fdt_cpu_clk_init
Date: Wed, 19 Mar 2025 10:54:10 +0800
Message-Id: <20250319025413.67014-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing of_node_put() to properly handle the reference count of the
device node obtained from of_get_cpu_node().

Fixes: 44a01f1f726a ("LoongArch: Parsing CPU-related information from DTS")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/loongarch/kernel/env.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index 2f1f5b08638f..01aea44cf4b0 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -68,6 +68,7 @@ static int __init fdt_cpu_clk_init(void)
 		return -ENODEV;
 
 	clk = of_clk_get(np, 0);
+	of_node_put(np);
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-- 
2.39.5 (Apple Git-154)


